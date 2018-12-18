Received: from eggs.gnu.org ([2001:4830:134:3::10]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZGKS-0006qK-I4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZGKP-0008EA-EZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZGKP-0008DQ-7f
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:26:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DBEA89ADC
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 14:26:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 18 Dec 2018 14:26:26 +0000
Message-Id: <20181218142629.15943-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Fix & improve icon display on GTK and SDL
 frontends
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

Daniel P. Berrang=C3=A9 (3):
  ui: install logo icons to $prefix/share/icons
  ui: fix icon display for GTK frontend under GNOME Shell with Wayland
  sdl: add support for high resolution window icon

 Makefile                                      |  16 ++++++++++-
 configure                                     |  27 ++++++++++++++++++
 include/ui/sdl2.h                             |   3 ++
 ui/gtk.c                                      |  18 ++++--------
 .../icons/qemu.svg                            |   0
 ui/icons/qemu_128x128.png                     | Bin 0 -> 7761 bytes
 ui/icons/qemu_16x16.png                       | Bin 0 -> 751 bytes
 ui/icons/qemu_24x24.png                       | Bin 0 -> 1167 bytes
 ui/icons/qemu_256x256.png                     | Bin 0 -> 16216 bytes
 .../qemu-icon.bmp =3D> ui/icons/qemu_32x32.bmp  | Bin
 ui/icons/qemu_32x32.png                       | Bin 0 -> 1656 bytes
 ui/icons/qemu_48x48.png                       | Bin 0 -> 2604 bytes
 ui/icons/qemu_512x512.png                     | Bin 0 -> 34609 bytes
 ui/icons/qemu_64x64.png                       | Bin 0 -> 3588 bytes
 ui/qemu.desktop                               |   8 ++++++
 ui/sdl2.c                                     |  22 +++++++-------
 16 files changed, 71 insertions(+), 23 deletions(-)
 rename pc-bios/qemu_logo_no_text.svg =3D> ui/icons/qemu.svg (100%)
 create mode 100644 ui/icons/qemu_128x128.png
 create mode 100644 ui/icons/qemu_16x16.png
 create mode 100644 ui/icons/qemu_24x24.png
 create mode 100644 ui/icons/qemu_256x256.png
 rename pc-bios/qemu-icon.bmp =3D> ui/icons/qemu_32x32.bmp (100%)
 create mode 100644 ui/icons/qemu_32x32.png
 create mode 100644 ui/icons/qemu_48x48.png
 create mode 100644 ui/icons/qemu_512x512.png
 create mode 100644 ui/icons/qemu_64x64.png
 create mode 100644 ui/qemu.desktop

--=20
2.19.2
