Received: from eggs.gnu.org ([209.51.188.92]:57333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvt-0001vn-5H
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvr-0002DL-Sp
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvr-00025X-Gw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id v26so812143wmh.3
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:47 +0100
Message-Id: <1549562254-41157-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/51] hw/display: make edid configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Use CONFIG_EDID to make edid-generate.c and edid-region.c
configurable.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-26-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/pci.mak  | 1 +
 hw/display/Makefile.objs | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 037636f..0552190 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -49,3 +49,4 @@ CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
 CONFIG_VFIO=$(CONFIG_LINUX)
 CONFIG_VFIO_PCI=y
+CONFIG_EDID=y
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 7c4ae9a..576fca4 100644
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
1.8.3.1
