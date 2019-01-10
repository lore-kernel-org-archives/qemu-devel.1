Received: from eggs.gnu.org ([209.51.188.92]:49106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghZ1A-0000gI-U8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghZ14-0008Ge-ME
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghZ14-0008DY-DK
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:00:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1962783F3E
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 12:00:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 10 Jan 2019 12:00:44 +0000
Message-Id: <20190110120047.25369-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Fix & improve icon display on GTK and
 SDL frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series improves the GTK and SDL frontends so that they display the
high quality QEMU logo.

Changed in v2:

  - Add a 'regenerate' make target in ui/icons to rebuild icons
    from SVG using inkscape.
  - Allow use of SDL_Image to be disabled with --enable-sdl-image
    configure arg
  - Reduce number of conditionals in SDL code
  - Fix variable name typo in SDL code

Daniel P. Berrang=C3=A9 (3):
  ui: install logo icons to $prefix/share/icons
  ui: fix icon display for GTK frontend under GNOME Shell with Wayland
  sdl: add support for high resolution window icon

 Makefile                                      |  16 +++++-
 configure                                     |  47 ++++++++++++++++++
 include/ui/sdl2.h                             |   3 ++
 pc-bios/qemu-icon.bmp                         | Bin 630 -> 0 bytes
 ui/gtk.c                                      |  18 +++----
 ui/icons/Makefile                             |  13 +++++
 .../icons/qemu.svg                            |   0
 ui/icons/qemu_128x128.png                     | Bin 0 -> 8286 bytes
 ui/icons/qemu_16x16.png                       | Bin 0 -> 765 bytes
 ui/icons/qemu_24x24.png                       | Bin 0 -> 1201 bytes
 ui/icons/qemu_256x256.png                     | Bin 0 -> 17572 bytes
 ui/icons/qemu_32x32.bmp                       | Bin 0 -> 4234 bytes
 ui/icons/qemu_32x32.png                       | Bin 0 -> 1696 bytes
 ui/icons/qemu_48x48.png                       | Bin 0 -> 2694 bytes
 ui/icons/qemu_512x512.png                     | Bin 0 -> 38007 bytes
 ui/icons/qemu_64x64.png                       | Bin 0 -> 3807 bytes
 ui/qemu.desktop                               |   8 +++
 ui/sdl2.c                                     |  22 ++++----
 18 files changed, 104 insertions(+), 23 deletions(-)
 delete mode 100644 pc-bios/qemu-icon.bmp
 create mode 100644 ui/icons/Makefile
 rename pc-bios/qemu_logo_no_text.svg =3D> ui/icons/qemu.svg (100%)
 create mode 100644 ui/icons/qemu_128x128.png
 create mode 100644 ui/icons/qemu_16x16.png
 create mode 100644 ui/icons/qemu_24x24.png
 create mode 100644 ui/icons/qemu_256x256.png
 create mode 100644 ui/icons/qemu_32x32.bmp
 create mode 100644 ui/icons/qemu_32x32.png
 create mode 100644 ui/icons/qemu_48x48.png
 create mode 100644 ui/icons/qemu_512x512.png
 create mode 100644 ui/icons/qemu_64x64.png
 create mode 100644 ui/qemu.desktop

--=20
2.19.2
