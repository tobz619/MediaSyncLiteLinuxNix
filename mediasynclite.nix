{ lib
, stdenv
, fetchFromGitHub
, gtk3
, glib
, gsettings-desktop-schemas
, pkg-config
, curl
, openssl
, jansson
, wrapGAppsHook3
}:

stdenv.mkDerivation rec {
  pname = "mediasynclite";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "iBroadcastMediaServices";
    repo = "MediaSyncLiteLinux";
    rev = version;
    hash = "sha256-KIXt7fZ6WAy2z704OovmTU47meZYQenNIUY2/JnY83w=";
    };

  buildInputs = [
   curl
   openssl.dev
   jansson
  ];

  strictDeps = true;

  nativeBuildInputs = [
   gtk3
   glib
   gsettings-desktop-schemas
   pkg-config
   wrapGAppsHook3
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  postPatch = ''
    substitute ./src/ibmsl.c ./src/ibmsl.c --subst-var out
  '';

  meta = with lib; {
    description = "A Linux-native graphical uploader for iBroadcast";
    downloadPage = "https://github.com/tobz619/MediaSyncLiteLinuxNix";
    homepage = "https://github.com/iBroadcastMediaServices/MediaSyncLiteLinux";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ tobz619 ];
  };
}
