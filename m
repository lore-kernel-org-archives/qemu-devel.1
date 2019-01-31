Received: from eggs.gnu.org ([209.51.188.92]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qF-000618-BK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qE-0002bM-EA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qE-0002Yq-4K
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:54 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:11 +0800
Message-Id: <20190131073234.18037-5-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 04/27] hw/pci-host/Makefile.objs: make
 CONFIGS clear for PCI EXPRESS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com, "Michael S . Tsirkin" <mst@redhat.com>

Change the CONFIGs for PCI EXPRESS and make module name more
clear for code files.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak      | 4 ++--
 default-configs/i386-softmmu.mak     | 2 +-
 default-configs/mips64el-softmmu.mak | 2 +-
 default-configs/pci.mak              | 2 +-
 default-configs/riscv32-softmmu.mak  | 2 +-
 default-configs/riscv64-softmmu.mak  | 2 +-
 hw/net/Makefile.objs                 | 4 ++--
 hw/pci-host/Makefile.objs            | 8 ++++----
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 3c9351f029..107f801367 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -122,7 +122,7 @@ CONFIG_VERSATILE=y
 CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
-CONFIG_PCI_GENERIC=y
+CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 CONFIG_VFIO_XGMAC=y
 CONFIG_VFIO_AMD_XGBE=y
 
@@ -153,7 +153,7 @@ CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_XILINX_AXI=y
-CONFIG_PCI_DESIGNWARE=y
+CONFIG_PCI_EXPRESS_DESIGNWARE=y
 
 CONFIG_STRONGARM=y
 CONFIG_HIGHBANK=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 64c998c4c8..2f919df346 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -47,7 +47,7 @@ CONFIG_ISA_TESTDEV=y
 CONFIG_VMPORT=y
 CONFIG_SGA=y
 CONFIG_LPC_ICH9=y
-CONFIG_PCI_Q35=y
+CONFIG_PCI_EXPRESS_Q35=y
 CONFIG_APIC=y
 CONFIG_IOAPIC=y
 CONFIG_PVPANIC=y
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index c2ae313f47..9eb1208b58 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -12,4 +12,4 @@ CONFIG_JAZZ_LED=y
 CONFIG_VT82C686=y
 CONFIG_MIPS_BOSTON=y
 CONFIG_FITLOADER=y
-CONFIG_PCI_XILINX=y
+CONFIG_PCI_EXPRESS_XILINX=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 6c7be12779..83738cbb65 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -22,7 +22,7 @@ CONFIG_MEGASAS_SCSI_PCI=y
 CONFIG_MPTSAS_SCSI_PCI=y
 CONFIG_RTL8139_PCI=y
 CONFIG_E1000_PCI=y
-CONFIG_E1000E_PCI=y
+CONFIG_E1000E_PCI_EXPRESS=y
 CONFIG_IDE_CORE=y
 CONFIG_IDE_QDEV=y
 CONFIG_IDE_PCI=y
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index c9c5971409..fbfd1d4e4b 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,7 +8,7 @@ CONFIG_VIRTIO_MMIO=y
 
 CONFIG_CADENCE=y
 
-CONFIG_PCI_GENERIC=y
+CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index c9c5971409..fbfd1d4e4b 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,7 +8,7 @@ CONFIG_VIRTIO_MMIO=y
 
 CONFIG_CADENCE=y
 
-CONFIG_PCI_GENERIC=y
+CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index fa461d4463..a43351aa04 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -7,8 +7,8 @@ common-obj-$(CONFIG_EEPRO100_PCI) += eepro100.o
 common-obj-$(CONFIG_PCNET_PCI) += pcnet-pci.o
 common-obj-$(CONFIG_PCNET_COMMON) += pcnet.o
 common-obj-$(CONFIG_E1000_PCI) += e1000.o e1000x_common.o
-common-obj-$(CONFIG_E1000E_PCI) += net_tx_pkt.o net_rx_pkt.o
-common-obj-$(CONFIG_E1000E_PCI) += e1000e.o e1000e_core.o e1000x_common.o
+common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += net_tx_pkt.o net_rx_pkt.o
+common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += e1000e.o e1000e_core.o e1000x_common.o
 common-obj-$(CONFIG_RTL8139_PCI) += rtl8139.o
 common-obj-$(CONFIG_VMXNET3_PCI) += net_tx_pkt.o net_rx_pkt.o
 common-obj-$(CONFIG_VMXNET3_PCI) += vmxnet3.o
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 6d6597c065..073d5124d1 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,8 +14,8 @@ common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 common-obj-$(CONFIG_PCI_SABRE) += sabre.o
 common-obj-$(CONFIG_FULONG) += bonito.o
 common-obj-$(CONFIG_PCI_PIIX) += piix.o
-common-obj-$(CONFIG_PCI_Q35) += q35.o
-common-obj-$(CONFIG_PCI_GENERIC) += gpex.o
-common-obj-$(CONFIG_PCI_XILINX) += xilinx-pcie.o
+common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
+common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
+common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
 
-common-obj-$(CONFIG_PCI_DESIGNWARE) += designware.o
+common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) += designware.o
-- 
2.17.1
