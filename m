Received: from eggs.gnu.org ([2001:4830:134:3::10]:44346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWE-0003U3-Iy
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWD-0006Ac-1H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVcWC-0006AG-SC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:24 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Jun 2018 14:47:12 +0200
Message-Id: <20180620124719.16450-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] seabios: 1.11.2 update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi folks,

So, here is the current state of the seabios update for the upcoming
qemu 3.0 release.  This time it is a bit more than just the usual
"update submodule and binaries".

seabios 1.11.2 is not released yet.  The plan is to cherry-pick the
changes needed to support the new qemu 3.0 display devices
(bochs-display and ramfb) into the 1.11-stable branch for the 1.11.2
release.  Current state is here:
   https://git.kraxel.org/cgit/seabios/log/?h=1.11-stable-testing

Changes in this patch series:
  - seabios submodule update (to the testing branch).
  - new vgabios configs for bochs-display and ramfb.
  - update the bios config to enables ide dma (for qnx).
  - drop (old) vgabios submodule and build rules.
  - seabios binary update.
  - make bochs-display and ramfb load the new vgabios roms.

Git branch for this series is here:
   https://git.kraxel.org/cgit/qemu/log/?h=seabios-1.11.2

cheers,
  Gerd

Gerd Hoffmann (7):
  seabios: update submodule to 1.11.2-testing
  seabios: add vga configs for bochs-display and ramfb
  seabios: enable ide dma
  vgabios: remove submodule and build rules.
  seabios: update binaries
  bochs-display: enable vgabios
  ramfb: enable vgabios

 hw/display/bochs-display.c    |   1 +
 hw/display/ramfb.c            |   1 +
 .gitmodules                   |   3 ---
 pc-bios/bios-256k.bin         | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin              | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-cirrus.bin    | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin       | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-stdvga.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin           | Bin 38400 -> 38400 bytes
 roms/Makefile                 |  20 +++-----------------
 roms/config.seabios-128k      |   1 +
 roms/config.seabios-256k      |   1 +
 roms/config.vga-bochs-display |   3 +++
 roms/config.vga-ramfb         |   3 +++
 roms/seabios                  |   2 +-
 roms/vgabios                  |   1 -
 18 files changed, 14 insertions(+), 22 deletions(-)
 create mode 100644 roms/config.vga-bochs-display
 create mode 100644 roms/config.vga-ramfb
 delete mode 160000 roms/vgabios

-- 
2.9.3
