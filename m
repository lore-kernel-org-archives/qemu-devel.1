Received: from eggs.gnu.org ([2001:4830:134:3::10]:59204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yD-0004b4-4J
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yC-0006GO-8g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0yC-0006Fr-3P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 523DA87628
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:42:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 17:42:15 +0200
Message-Id: <20180702154222.3130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Seabios 1.11.2 20180702 patches
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

The following changes since commit 2d58e33ec1b76990f09bc1e3412e0b36e1ac4634:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-07-02 13:43:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/seabios-1.11.2-20180702-pull-request

for you to fetch changes up to 9f5d9c19c7d9c6eca21802a2777da0119bc22749:

  ramfb: enable vgabios (2018-07-02 17:21:52 +0200)

----------------------------------------------------------------
seabios: update to release 1.11.2, add/update configuration.
vgabios: remove (old unused lgpl'ed vgabios).
ramfb,bochs-display: use new vgabios roms.

----------------------------------------------------------------

Gerd Hoffmann (7):
  seabios: update submodule to release 1.11.2
  seabios: add vga configs for bochs-display and ramfb
  seabios: enable ide dma
  vgabios: remove submodule and build rules.
  seabios: update bios and vgabios binaries
  bochs-display: enable vgabios
  ramfb: enable vgabios

 hw/display/bochs-display.c        |   1 +
 hw/display/ramfb.c                |   1 +
 .gitmodules                       |   3 ---
 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 0 -> 27648 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin           | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 0 -> 28160 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin               | Bin 38400 -> 38400 bytes
 roms/Makefile                     |  20 +++-----------------
 roms/config.seabios-128k          |   1 +
 roms/config.seabios-256k          |   1 +
 roms/config.vga-bochs-display     |   3 +++
 roms/config.vga-ramfb             |   3 +++
 roms/seabios                      |   2 +-
 roms/vgabios                      |   1 -
 20 files changed, 14 insertions(+), 22 deletions(-)
 create mode 100644 pc-bios/vgabios-bochs-display.bin
 create mode 100644 pc-bios/vgabios-ramfb.bin
 create mode 100644 roms/config.vga-bochs-display
 create mode 100644 roms/config.vga-ramfb
 delete mode 160000 roms/vgabios

-- 
2.9.3
