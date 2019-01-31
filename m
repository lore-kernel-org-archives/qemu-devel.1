Received: from eggs.gnu.org ([209.51.188.92]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qD-0005zR-9O
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qC-0002a6-Ar
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qC-0002Yq-24
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:52 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:10 +0800
Message-Id: <20190131073234.18037-4-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 03/27] vfio: move conditional up to
 hw/Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of wrapping the entire Makefile.objs with an ifeq/endif, just
include the directory only for Linux.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/Makefile.objs      | 2 +-
 hw/vfio/Makefile.objs | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 39d882af6f..22dd211363 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -30,7 +30,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += ssi/
 devices-dirs-$(CONFIG_SOFTMMU) += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-$(CONFIG_SOFTMMU) += usb/
-devices-dirs-$(CONFIG_SOFTMMU) += vfio/
+devices-dirs-$(CONFIG_LINUX) += vfio/
 devices-dirs-$(CONFIG_SOFTMMU) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index 8b3f664d85..91805893f7 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,4 +1,3 @@
-ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
 obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
@@ -7,4 +6,3 @@ obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
 obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
 obj-$(CONFIG_SOFTMMU) += spapr.o
 obj-$(CONFIG_VFIO_AP) += ap.o
-endif
-- 
2.17.1
