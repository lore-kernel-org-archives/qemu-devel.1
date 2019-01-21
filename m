Received: from eggs.gnu.org ([209.51.188.92]:55546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ2-0008ER-6e
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ1-0000kE-80
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glaJ0-0000jb-Vp
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14FD5A82C
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:12:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Jan 2019 15:11:46 +0100
Message-Id: <20190121141152.948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Ui 20190121 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 681d61362d3f766a00806b89d6581869041f73=
cb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-01-17 12:48:42 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20190121-pull-request

for you to fetch changes up to fbd57c754f32804a63295f70f271d1ef128ee590:

  egl-helpers.h: do not depend on X11 Window type, use EGLNativeWindowTyp=
e (2019-01-21 09:44:32 +0100)

----------------------------------------------------------------
ui: highres logo for sdl and gtk, bugfixes for vnc and egl.

----------------------------------------------------------------

Alexander Kanavin (1):
  egl-helpers.h: do not depend on X11 Window type, use
    EGLNativeWindowType

Daniel P. Berrang=C3=A9 (3):
  ui: install logo icons to $prefix/share/icons
  ui: fix icon display for GTK frontend under GNOME Shell with Wayland
  sdl: add support for high resolution window icon

Gerd Hoffmann (1):
  vnc: detect and optimize pageflips

 configure                                          |  47 +++++++++++++++=
++++++
 Makefile                                           |  16 ++++++-
 include/ui/egl-helpers.h                           |   2 +-
 include/ui/sdl2.h                                  |   3 ++
 ui/egl-helpers.c                                   |   4 +-
 ui/gtk-egl.c                                       |   3 +-
 ui/gtk.c                                           |  18 +++-----
 ui/sdl2.c                                          |  22 +++++-----
 ui/vnc.c                                           |  25 +++++++++--
 pc-bios/qemu-icon.bmp                              | Bin 630 -> 0 bytes
 ui/icons/Makefile                                  |  13 ++++++
 pc-bios/qemu_logo_no_text.svg =3D> ui/icons/qemu.svg |   0
 ui/icons/qemu_128x128.png                          | Bin 0 -> 8286 bytes
 ui/icons/qemu_16x16.png                            | Bin 0 -> 765 bytes
 ui/icons/qemu_24x24.png                            | Bin 0 -> 1201 bytes
 ui/icons/qemu_256x256.png                          | Bin 0 -> 17572 byte=
s
 ui/icons/qemu_32x32.bmp                            | Bin 0 -> 4234 bytes
 ui/icons/qemu_32x32.png                            | Bin 0 -> 1696 bytes
 ui/icons/qemu_48x48.png                            | Bin 0 -> 2694 bytes
 ui/icons/qemu_512x512.png                          | Bin 0 -> 38007 byte=
s
 ui/icons/qemu_64x64.png                            | Bin 0 -> 3807 bytes
 ui/qemu.desktop                                    |   8 ++++
 22 files changed, 131 insertions(+), 30 deletions(-)
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
2.9.3
