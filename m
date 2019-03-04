Received: from eggs.gnu.org ([209.51.188.92]:45874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCY-0001vI-P0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCX-00043A-NS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCX-00041w-FU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id e74so128151wmg.3
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:37 +0100
Message-Id: <1551723614-1823-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/54] scsi: express dependencies with Kconfig
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

This automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak         | 1 -
 default-configs/hppa-softmmu.mak        | 1 -
 default-configs/mips-softmmu-common.mak | 1 -
 default-configs/sparc-softmmu.mak       | 1 -
 default-configs/virtio.mak              | 1 -
 hw/scsi/Kconfig                         | 7 +++++++
 hw/scsi/Makefile.objs                   | 2 +-
 hw/usb/Kconfig                          | 2 ++
 8 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index e9a972f..7b7c040 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -166,5 +166,4 @@ CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
 
 # for realview and versatilepb
-CONFIG_SCSI=y
 CONFIG_LSI_SCSI_PCI=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 85a2011..221c609 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -8,7 +8,6 @@ CONFIG_I8259=y
 CONFIG_E1000_PCI=y
 CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
-CONFIG_SCSI=y
 CONFIG_LSI_SCSI_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_MC146818RTC=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 6d5882b..556cd5c 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -5,7 +5,6 @@ CONFIG_ISA_BUS=y
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
index 5a2930c..7e6d467 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -7,6 +7,5 @@ CONFIG_EDID=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_RNG=y
-CONFIG_SCSI=y
 CONFIG_VIRTIO_SCSI=y
 CONFIG_VIRTIO_SERIAL=y
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 8144ccb..a696ff0 100644
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
@@ -34,9 +39,11 @@ config SPAPR_VSCSI
     bool
     default y
     depends on PSERIES
+    select SCSI
 
 config VIRTIO_SCSI
     bool
+    select SCSI
 
 config VHOST_USER_SCSI
     bool
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
index 86ee615..071e749 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -40,9 +40,11 @@ config USB_TABLET_WACOM
 
 config USB_STORAGE_BOT
     bool
+    select SCSI
 
 config USB_STORAGE_UAS
     bool
+    select SCSI
 
 config USB_AUDIO
     bool
-- 
1.8.3.1
