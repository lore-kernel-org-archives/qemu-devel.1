Received: from eggs.gnu.org ([209.51.188.92]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvw-0001xj-Tb
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvv-0002Hl-2h
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvu-0002HS-P8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id v13so829100wrw.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:59 +0100
Message-Id: <1549562254-41157-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 16/51] isa: express dependencies with kconfig
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-36-yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak       | 1 -
 default-configs/i386-softmmu.mak        | 9 ---------
 default-configs/mips-softmmu-common.mak | 1 -
 default-configs/ppc-softmmu.mak         | 1 -
 default-configs/sh4-softmmu.mak         | 1 -
 default-configs/sh4eb-softmmu.mak       | 1 -
 default-configs/sparc64-softmmu.mak     | 1 -
 hw/audio/Kconfig                        | 2 ++
 hw/block/Kconfig                        | 2 ++
 hw/char/Kconfig                         | 6 ++++++
 hw/display/Kconfig                      | 3 +++
 hw/dma/Kconfig                          | 1 +
 hw/i386/Kconfig                         | 1 +
 hw/ide/Kconfig                          | 1 +
 hw/input/Kconfig                        | 2 ++
 hw/ipmi/Kconfig                         | 2 ++
 hw/isa/Kconfig                          | 7 +++++++
 hw/misc/Kconfig                         | 6 ++++++
 hw/net/Kconfig                          | 4 ++++
 hw/sparc64/Kconfig                      | 1 +
 hw/tpm/Kconfig                          | 2 +-
 hw/watchdog/Kconfig                     | 2 ++
 22 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index e1017aa..f0c1928 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -15,7 +15,6 @@ CONFIG_VMWARE_VGA=y
 CONFIG_IDE_CMD646=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_TEST_DEVICES=y
 CONFIG_SMC37C669=y
 CONFIG_DP264=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 60356ed..54b571f 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -9,19 +9,12 @@ CONFIG_VGA_ISA=y
 CONFIG_VMWARE_VGA=y
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
-CONFIG_VMMOUSE=y
 CONFIG_IPMI=y
 CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_PARALLEL=y
 CONFIG_I8254=y
-CONFIG_PCSPK=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
 CONFIG_ACPI=y
 CONFIG_ACPI_X86=y
 CONFIG_ACPI_X86_ICH=y
@@ -31,14 +24,12 @@ CONFIG_APM=y
 CONFIG_I8257=y
 CONFIG_IDE_ISA=y
 CONFIG_IDE_PIIX=y
-CONFIG_NE2000_ISA=y
 CONFIG_HPET=y
 CONFIG_APPLESMC=y
 CONFIG_I8259=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_MC146818RTC=y
 CONFIG_PCI_PIIX=y
-CONFIG_WDT_IB700=y
 CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_VMPORT=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index a7a8d4e..45c599b 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -30,7 +30,6 @@ CONFIG_MIPSNET=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index f5df65f..d4807b3 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -63,7 +63,6 @@ CONFIG_PREP=y
 CONFIG_PREP_PCI=y
 CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
 CONFIG_PARALLEL=y
 CONFIG_I82374=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 651fe1a..3f7fbe2 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -11,7 +11,6 @@ CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
 CONFIG_I2C=y
 CONFIG_DDC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I8259=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index fa3e07e..17f07a4 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -11,7 +11,6 @@ CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
 CONFIG_I2C=y
 CONFIG_DDC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I8259=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 24d7389..2d23b0c 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -14,7 +14,6 @@ CONFIG_PCI_SABRE=y
 CONFIG_SIMBA=y
 CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_TEST_DEVICES=y
 CONFIG_SUN4V_RTC=y
 CONFIG_SUN4U=y
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index dedb513..01aea55 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -35,6 +35,8 @@ config HDA
 
 config PCSPK
     bool
+    default y
+    depends on I8254
 
 config WM8750
     bool
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index b60e2ab..6a23659 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -1,5 +1,7 @@
 config FDC
     bool
+    default y
+    depends on ISA_BUS
 
 config SSI_M25P80
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 6eba69a..fc18481 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -3,6 +3,8 @@ config ESCC
 
 config PARALLEL
     bool
+    default y
+    depends on ISA_BUS
 
 config PL011
     bool
@@ -12,11 +14,15 @@ config SERIAL
 
 config SERIAL_ISA
     bool
+    default y
+    depends on ISA_BUS
+    select SERIAL
 
 config SERIAL_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select SERIAL
 
 config VIRTIO_SERIAL
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 9199beb..e5f347f 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -39,9 +39,12 @@ config VGA_PCI
 
 config VGA_ISA
     bool
+    depends on ISA_BUS
+    select VGA
 
 config VGA_ISA_MM
     bool
+    select VGA
 
 config VMWARE_VGA
     bool
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index b9ce1c5..751dec5 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -9,6 +9,7 @@ config PL330
 
 config I82374
     bool
+    select I8257
 
 config I8257
     bool
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 6df3f7c..0f94ae1 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -13,6 +13,7 @@ config I440FX
 
 config ISAPC
     bool
+    select ISA_BUS
 
 config Q35
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 246e27b..ab47b6a 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -12,6 +12,7 @@ config IDE_PCI
 
 config IDE_ISA
     bool
+    depends on ISA_BUS
     select IDE_QDEV
 
 config IDE_PIIX
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index c729dcd..814f87f 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -6,6 +6,8 @@ config LM832X
 
 config PCKBD
     bool
+    default y
+    depends on ISA_BUS
 
 config PL050
     bool
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
index 68f8ba1..6a4f08f 100644
--- a/hw/ipmi/Kconfig
+++ b/hw/ipmi/Kconfig
@@ -9,6 +9,8 @@ config IPMI_EXTERN
 
 config ISA_IPMI_KCS
     bool
+    depends on ISA_BUS
 
 config ISA_IPMI_BT
     bool
+    depends on ISA_BUS
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index b59d074..af68af9 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -6,18 +6,25 @@ config APM
 
 config I82378
     bool
+    select ISA_BUS
 
 config PC87312
     bool
+    select ISA_BUS
 
 config PIIX4
     bool
+    select ISA_BUS
 
 config VT82C686
     bool
+    select ISA_BUS
 
 config SMC37C669
     bool
+    select ISA_BUS
 
 config LPC_ICH9
     bool
+    select ISA_BUS
+    select ACPI_X86_ICH
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 830b457..5a7dbe1 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -1,5 +1,6 @@
 config APPLESMC
     bool
+    depends on ISA_BUS
 
 config MAX111X
     bool
@@ -12,12 +13,16 @@ config TMP421
 
 config ISA_DEBUG
     bool
+    depends on ISA_BUS
 
 config SGA
     bool
+    depends on ISA_BUS
 
 config ISA_TESTDEV
     bool
+    default y if TEST_DEVICES
+    depends on ISA_BUS
 
 config PCI_TESTDEV
     bool
@@ -93,6 +98,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
+    depends on ISA_BUS
 
 config AUX
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index d50e301..ff974bc 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -48,6 +48,10 @@ config LAN9118
 
 config NE2000_ISA
     bool
+    default y
+    depends on ISA_BUS
+    depends on PCI # for NE2000State
+    select NE2000_PCI
 
 config OPENCORES_ETH
     bool
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index 8c13345..41f7295 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -1,5 +1,6 @@
 config SUN4U
     bool
+    select ISA_BUS
 
 config NIAGARA
     bool
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index da4bb5b..f3eb570 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -3,7 +3,7 @@ config TPM
 
 config TPM_TIS
     bool
-    depends on TPM
+    depends on TPM && ISA_BUS
 
 config TPM_CRB
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index edb3d42..35ccb72 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -8,6 +8,8 @@ config WDT_IB6300ESB
 
 config WDT_IB700
     bool
+    default y
+    depends on ISA_BUS
 
 config WDT_DIAG288
     bool
-- 
1.8.3.1
