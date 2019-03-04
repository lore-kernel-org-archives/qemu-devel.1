Received: from eggs.gnu.org ([209.51.188.92]:45841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCW-0001sv-Hs
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCV-0003y2-8W
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:32 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCU-0003up-Uh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:31 -0500
Received: by mail-wm1-x330.google.com with SMTP id c13so403563wmb.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:34 +0100
Message-Id: <1551723614-1823-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/54] isa: express dependencies with kconfig
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
index 3fd656e..8000a9a 100644
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
index 256443e..c7e32ce 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -10,19 +10,12 @@ CONFIG_VGA_CIRRUS=y
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
@@ -32,14 +25,12 @@ CONFIG_APM=y
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
index 331bdc5..cba8582 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -31,7 +31,6 @@ CONFIG_MIPSNET=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 5c576fe..5ccdcb6 100644
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
index 38c7290..e406559 100644
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
index c966cca..14dea69 100644
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
index b17513b..1e519b3 100644
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
index 207baee..45d3a6a 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -21,6 +21,8 @@ config HDA
 
 config PCSPK
     bool
+    default y
+    depends on I8254
 
 config WM8750
     bool
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 4a64d83..aca8d11 100644
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
index 26c1324..fbb0a9b 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -3,6 +3,8 @@ config ESCC
 
 config PARALLEL
     bool
+    default y
+    depends on ISA_BUS
 
 config PL011
     bool
@@ -12,9 +14,13 @@ config SERIAL
 
 config SERIAL_ISA
     bool
+    default y
+    depends on ISA_BUS
+    select SERIAL
 
 config SERIAL_PCI
     bool
+    select SERIAL
 
 config VIRTIO_SERIAL
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1149ea2..bbd6dd9 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -33,9 +33,12 @@ config VGA_PCI
 
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
index 93f8609..0b3c8d9 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -14,6 +14,7 @@ config I440FX
 
 config ISAPC
     bool
+    select ISA_BUS
 
 config Q35
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index fe27705..88076a7 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -11,6 +11,7 @@ config IDE_PCI
 
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
index fc068ef..a1e4bd8 100644
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
@@ -89,6 +94,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
+    depends on ISA_BUS
 
 config AUX
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index ad56fc0..f4b5ff2 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -33,6 +33,10 @@ config LAN9118
 
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
index 10a30f8..e781995 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,6 +1,6 @@
 config TPM_TIS
     bool
-    depends on TPM
+    depends on TPM && ISA_BUS
 
 config TPM_CRB
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index cd0244f..4bbd981 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -6,6 +6,8 @@ config WDT_IB6300ESB
 
 config WDT_IB700
     bool
+    default y
+    depends on ISA_BUS
 
 config WDT_DIAG288
     bool
-- 
1.8.3.1
