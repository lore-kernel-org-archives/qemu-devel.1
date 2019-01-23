Received: from eggs.gnu.org ([209.51.188.92]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWB-0004uB-P6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWA-0003kd-PZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWA-0002Nr-ID
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:10 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:03 +0800
Message-Id: <20190123065618.3520-30-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 29/44] hw/pci/Makefile.objs: make pcie
 configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com, "Michael S . Tsirkin" <mst@redhat.com>

Make pcie splited from pci and make it configurable.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/pci.mak | 1 +
 hw/pci/Kconfig          | 3 +++
 hw/pci/Makefile.objs    | 5 +++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index f7b3690bbd..b17b456b1e 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -1,4 +1,5 @@
 CONFIG_PCI=y
+CONFIG_PCI_EXPRESS=y
 # For now, CONFIG_IDE_CORE requires ISA, so we enable it here
 CONFIG_ISA_BUS=y
 CONFIG_VIRTIO_PCI=y
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index d3d2205577..81533b9dc0 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -1,2 +1,5 @@
 config PCI
     bool
+
+config PCI_EXPRESS
+    bool
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 9f905e6344..d30eb32cbb 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -2,8 +2,9 @@ common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
 common-obj-$(CONFIG_PCI) += msix.o msi.o
 common-obj-$(CONFIG_PCI) += shpc.o
 common-obj-$(CONFIG_PCI) += slotid_cap.o
-common-obj-$(CONFIG_PCI) += pci_host.o pcie_host.o
-common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
+common-obj-$(CONFIG_PCI) += pci_host.o
+common-obj-$(CONFIG_PCI_EXPRESS) += pcie.o pcie_aer.o
+common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
-- 
2.17.1
