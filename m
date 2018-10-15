Received: from eggs.gnu.org ([2001:4830:134:3::10]:50939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByom-00020r-Ei
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByog-0008Sn-Pi
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gByog-0008KX-8E
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:34 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Oct 2018 11:05:12 +0200
Message-Id: <20181015090517.26884-3-kraxel@redhat.com>
In-Reply-To: <20181015090517.26884-1-kraxel@redhat.com>
References: <20181015090517.26884-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] display: add separate config option for
 bochs-display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This allows modern architectures which don't care about vga
compatibility (risc-v for example) build bochs-display without
including all vga emulation too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181005160147.892-2-kraxel@redhat.com
---
 default-configs/pci.mak  | 1 +
 hw/display/Makefile.objs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index de53d20ac6..6c7be12779 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -44,5 +44,6 @@ CONFIG_SDHCI=y
 CONFIG_EDU=y
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
+CONFIG_BOCHS_DISPLAY=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 780a76b9f0..2a0de16a55 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -14,11 +14,11 @@ common-obj-$(CONFIG_SSD0323) += ssd0323.o
 common-obj-$(CONFIG_XEN) += xenfb.o
 
 common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
-common-obj-$(CONFIG_VGA_PCI) += bochs-display.o
 common-obj-$(CONFIG_VGA_PCI) += edid-region.o
 common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
 common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
+common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
 
 common-obj-$(CONFIG_BLIZZARD) += blizzard.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
-- 
2.9.3
