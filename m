Received: from eggs.gnu.org ([209.51.188.92]:36710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIS-0001N8-4c
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIR-0007S5-Do
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:47041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIR-0005r5-4P
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:47 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:55 +0800
Message-Id: <20190118112410.3010-29-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 28/43] hw/pci/Makefile.objs: make pcie
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

Make pcie splited from pci and make it configurable.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/pci.mak | 1 +
 hw/pci/Kconfig          | 3 +++
 hw/pci/Makefile.objs    | 5 +++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index c1b64922b9..553b1905de 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -1,4 +1,5 @@
 CONFIG_PCI=y
+CONFIG_PCIE=y
 # For now, CONFIG_IDE_CORE requires ISA, so we enable it here
 CONFIG_ISA_BUS=y
 CONFIG_VIRTIO_PCI=y
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index d3d2205577..a717a26995 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -1,2 +1,5 @@
 config PCI
     bool
+
+config PCIE
+    bool
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 9f905e6344..a995795a47 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -2,8 +2,9 @@ common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
 common-obj-$(CONFIG_PCI) += msix.o msi.o
 common-obj-$(CONFIG_PCI) += shpc.o
 common-obj-$(CONFIG_PCI) += slotid_cap.o
-common-obj-$(CONFIG_PCI) += pci_host.o pcie_host.o
-common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
+common-obj-$(CONFIG_PCI) += pci_host.o
+common-obj-$(CONFIG_PCIE) += pcie.o pcie_aer.o
+common-obj-$(CONFIG_PCIE) += pcie_port.o pcie_host.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
-- 
2.17.1
