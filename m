Received: from eggs.gnu.org ([209.51.188.92]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCP-0001mU-EO
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCO-0003jW-Id
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCO-0003hJ-As
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id f3so121887wmj.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:27 +0100
Message-Id: <1551723614-1823-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/54] hw/display: make edid configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Use CONFIG_EDID to make edid-generate.c and edid-region.c
configurable.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-26-yang.zhong@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/pci.mak    | 1 +
 default-configs/virtio.mak | 1 +
 hw/display/Makefile.objs   | 4 +---
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 037636f..0552190 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -49,3 +49,4 @@ CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
 CONFIG_VFIO=$(CONFIG_LINUX)
 CONFIG_VFIO_PCI=y
+CONFIG_EDID=y
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index b653aa0..3abf68a 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -6,6 +6,7 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_CRYPTO=y
 CONFIG_VIRTIO_GPU=y
+CONFIG_EDID=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_RNG=y
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
