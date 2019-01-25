Received: from eggs.gnu.org ([209.51.188.92]:57803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOT-0007Ky-6D
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOQ-0001YL-Pj
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOO-0001UQ-UP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id u4so9639519wrp.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:23 +0100
Message-Id: <1548410831-19553-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/52] hw/pci-host/Makefile.objs: make CONFIGS
 clear for PCI EXPRESS
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

Change the CONFIGs for PCI EXPRESS and make module name more
clear for code files.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20190123065618.3520-2-yang.zhong@intel.com>
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
index 3c9351f..107f801 100644
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
index 64c998c..2f919df 100644
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
index c2ae313..9eb1208 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -12,4 +12,4 @@ CONFIG_JAZZ_LED=y
 CONFIG_VT82C686=y
 CONFIG_MIPS_BOSTON=y
 CONFIG_FITLOADER=y
-CONFIG_PCI_XILINX=y
+CONFIG_PCI_EXPRESS_XILINX=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 6c7be12..83738cb 100644
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
index c9c5971..fbfd1d4 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,7 +8,7 @@ CONFIG_VIRTIO_MMIO=y
 
 CONFIG_CADENCE=y
 
-CONFIG_PCI_GENERIC=y
+CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index c9c5971..fbfd1d4 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,7 +8,7 @@ CONFIG_VIRTIO_MMIO=y
 
 CONFIG_CADENCE=y
 
-CONFIG_PCI_GENERIC=y
+CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index fa461d4..a43351a 100644
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
index 6d6597c..073d512 100644
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
1.8.3.1
