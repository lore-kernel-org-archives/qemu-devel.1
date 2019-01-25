Received: from eggs.gnu.org ([209.51.188.92]:58415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP2-0007rB-K4
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOt-00021T-2V
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:53 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOs-00020b-PC
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:50 -0500
Received: by mail-wm1-x341.google.com with SMTP id d15so6163696wmb.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:55 +0100
Message-Id: <1548410831-19553-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 36/52] hw/pci/Makefile.objs: make pcie
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
Cc: yang.zhong@intel.com, thuth@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

From: Yang Zhong <yang.zhong@intel.com>

Make pcie splited from pci and make it configurable.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-30-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak      | 1 +
 default-configs/i386-softmmu.mak     | 1 +
 default-configs/mips64el-softmmu.mak | 1 +
 default-configs/ppc-softmmu.mak      | 1 +
 default-configs/riscv32-softmmu.mak  | 1 +
 default-configs/riscv64-softmmu.mak  | 1 +
 hw/pci/Kconfig                       | 4 ++++
 hw/pci/Makefile.objs                 | 9 +++++++--
 8 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b0995a0..59cf3d2 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -121,6 +121,7 @@ CONFIG_VERSATILE=y
 CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
+CONFIG_PCI_EXPRESS=y
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 CONFIG_VFIO_PLATFORM=y
 CONFIG_VFIO_XGMAC=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 412c8c5..b5281d3 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -44,6 +44,7 @@ CONFIG_ISA_TESTDEV=y
 CONFIG_VMPORT=y
 CONFIG_SGA=y
 CONFIG_LPC_ICH9=y
+CONFIG_PCI_EXPRESS=y
 CONFIG_PCI_EXPRESS_Q35=y
 CONFIG_APIC=y
 CONFIG_IOAPIC=y
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index 9eb1208..c6ad4da 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -12,4 +12,5 @@ CONFIG_JAZZ_LED=y
 CONFIG_VT82C686=y
 CONFIG_MIPS_BOSTON=y
 CONFIG_FITLOADER=y
+CONFIG_PCI_EXPRESS=y
 CONFIG_PCI_EXPRESS_XILINX=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 90118cb..47e4177 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -23,6 +23,7 @@ CONFIG_ETSEC=y
 CONFIG_PPC405=y
 CONFIG_PPC440=y
 CONFIG_VIRTEX=y
+CONFIG_PCI_EXPRESS=y
 
 # For Sam460ex
 CONFIG_SAM460EX=y
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 6533716..8c3a91a 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,6 +8,7 @@ CONFIG_VIRTIO_MMIO=y
 
 CONFIG_CADENCE=y
 
+CONFIG_PCI_EXPRESS=y
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 6533716..8c3a91a 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,6 +8,7 @@ CONFIG_VIRTIO_MMIO=y
 
 CONFIG_CADENCE=y
 
+CONFIG_PCI_EXPRESS=y
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index d3d2205..4ca2537 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -1,2 +1,6 @@
 config PCI
     bool
+
+config PCI_EXPRESS
+    bool
+    select PCI
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 9f905e6..c78f2fb 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -2,8 +2,13 @@ common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
 common-obj-$(CONFIG_PCI) += msix.o msi.o
 common-obj-$(CONFIG_PCI) += shpc.o
 common-obj-$(CONFIG_PCI) += slotid_cap.o
-common-obj-$(CONFIG_PCI) += pci_host.o pcie_host.o
-common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
+common-obj-$(CONFIG_PCI) += pci_host.o
+
+# The functions in these modules can be used by devices too.  Since we
+# allow plugging PCIe devices into PCI buses, include them even if
+# CONFIG_PCI_EXPRESS=n.
+common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o
+common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
-- 
1.8.3.1
