Received: from eggs.gnu.org ([208.118.235.92]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGn-0003UR-PP
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGj-0004ob-Ms
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:57851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGi-00041J-ES
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:45 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:07 +0800
Message-Id: <20181227063419.12981-14-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 13/25] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

This lets you disable SCSI altogether with "CONFIG_SCSI=n".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/scsi/Kconfig       | 11 ++++++++++-
 hw/scsi/Makefile.objs |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 6e7575397f..d669a4824e 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -5,24 +5,29 @@ config LSI_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config MPTSAS_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config MEGASAS_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config VMW_PVSCSI_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config ESP
     bool
+    select SCSI
 
 config ESP_PCI
     bool
@@ -30,11 +35,15 @@ config ESP_PCI
     depends on PCI
     select ESP
 
-config PSERIES
+config SPAPR_VSCSI
     bool
+    select SCSI
 
 config VIRTIO_SCSI
     bool
+    default y
+    depends on VIRTIO
+    select SCSI
 
 config VHOST_USER_SCSI
     bool
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 45167baeaf..54b36ed8b1 100644
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
-- 
2.17.1
