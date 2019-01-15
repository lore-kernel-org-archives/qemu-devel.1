Received: from eggs.gnu.org ([209.51.188.92]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYV-0002jb-1F
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRx-0001L3-1c
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:12:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:56304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPRw-00013D-4r
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:12:16 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:49 +0800
Message-Id: <20190115141108.934-19-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v2 18/37] hw/display: make edid configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

Use CONFIG_EDID to make edid-generate.c and edid-region.c
configurable.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/pci.mak  | 1 +
 hw/display/Makefile.objs | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 6c7be12779..171bdf48bc 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -47,3 +47,4 @@ CONFIG_VGA_PCI=y
 CONFIG_BOCHS_DISPLAY=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
+CONFIG_EDID=y
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 97acd5b6cb..a8e23c8501 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += edid-generate.o
+common-obj-$(CONFIG_EDID) += edid-generate.o edid-region.o
 
 common-obj-$(CONFIG_FW_CFG_DMA) += ramfb.o
 common-obj-$(CONFIG_FW_CFG_DMA) += ramfb-standalone.o
@@ -15,12 +15,10 @@ common-obj-$(CONFIG_SSD0323) += ssd0323.o
 common-obj-$(CONFIG_XEN) += xenfb.o
 
 common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
-common-obj-$(CONFIG_VGA_PCI) += edid-region.o
 common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
 common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
 common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
-common-obj-$(CONFIG_BOCHS_DISPLAY) += edid-region.o
 
 common-obj-$(CONFIG_BLIZZARD) += blizzard.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
-- 
2.17.1
