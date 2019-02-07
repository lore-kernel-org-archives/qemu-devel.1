Received: from eggs.gnu.org ([209.51.188.92]:57418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvw-0001wx-0L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvt-0002HI-U2
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvt-0002Fj-Ln
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id p6so828571wmc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:58 +0100
Message-Id: <1549562254-41157-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/51] scsi: express dependencies with Kconfig
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

This automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak         |  1 -
 default-configs/hppa-softmmu.mak        |  1 -
 default-configs/mips-softmmu-common.mak |  1 -
 default-configs/sparc-softmmu.mak       |  1 -
 default-configs/virtio.mak              |  1 -
 hw/scsi/Kconfig                         | 10 +++++++++-
 hw/scsi/Makefile.objs                   |  2 +-
 hw/usb/Kconfig                          |  2 ++
 8 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 901f42a..44acb5a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -163,5 +163,4 @@ CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
 
 # for realview and versatilepb
-CONFIG_SCSI=y
 CONFIG_LSI_SCSI_PCI=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 5089a94..b7f2b43 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -7,7 +7,6 @@ CONFIG_I8259=y
 CONFIG_E1000_PCI=y
 CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
-CONFIG_SCSI=y
 CONFIG_LSI_SCSI_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_MC146818RTC=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 90a2412..a7a8d4e 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -4,7 +4,6 @@ CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_ESP=y
-CONFIG_SCSI=y
 CONFIG_VGA_ISA=y
 CONFIG_VGA_ISA_MM=y
 CONFIG_VGA_CIRRUS=y
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 59a4a3d..805c400 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -2,7 +2,6 @@
 
 CONFIG_ISA_BUS=y
 CONFIG_ECC=y
-CONFIG_SCSI=y
 CONFIG_ESP=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 51599ed..82d0726 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -7,6 +7,5 @@ CONFIG_VIRTIO_GPU=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_RNG=y
-CONFIG_SCSI=y
 CONFIG_VIRTIO_SCSI=y
 CONFIG_VIRTIO_SERIAL=y
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index a7d25d3..b9cf269 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -5,24 +5,29 @@ config LSI_SCSI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select SCSI
 
 config MPTSAS_SCSI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select SCSI
 
 config MEGASAS_SCSI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select SCSI
 
 config VMW_PVSCSI_SCSI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select SCSI
 
 config ESP
     bool
+    select SCSI
 
 config ESP_PCI
     bool
@@ -34,11 +39,14 @@ config SPAPR_VSCSI
     bool
     default y
     depends on PSERIES
+    select SCSI
 
 config VIRTIO_SCSI
     bool
+    select SCSI
 
 config VHOST_USER_SCSI
     bool
-    default y
+    # Only PCI devices are provided for now
+    default y if VIRTIO_PCI
     depends on VHOST_USER && LINUX
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 45167ba..54b36ed 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -6,7 +6,7 @@ common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o
 common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
 common-obj-$(CONFIG_ESP) += esp.o
 common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
-obj-$(CONFIG_PSERIES) += spapr_vscsi.o
+obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
 
 ifeq ($(CONFIG_VIRTIO_SCSI),y)
 obj-y += virtio-scsi.o virtio-scsi-dataplane.o
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index e20670a..a1b7acb 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -52,11 +52,13 @@ config USB_STORAGE_BOT
     bool
     default y
     depends on USB
+    select SCSI
 
 config USB_STORAGE_UAS
     bool
     default y
     depends on USB
+    select SCSI
 
 config USB_AUDIO
     bool
-- 
1.8.3.1
