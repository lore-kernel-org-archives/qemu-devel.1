Received: from eggs.gnu.org ([209.51.188.92]:46024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCn-0002Af-Pa
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCl-0004TZ-6n
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCi-0004NC-9k
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id d17so6637515wre.10
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:47 +0100
Message-Id: <1551723614-1823-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/54] isa: express SuperIO dependencies with
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
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak |  5 -----
 default-configs/ppc-softmmu.mak   |  9 ---------
 default-configs/sh4-softmmu.mak   |  9 ++-------
 default-configs/sh4eb-softmmu.mak |  6 ------
 hw/block/Kconfig                  |  5 +++--
 hw/isa/Kconfig                    | 21 +++++++++++++++++++++
 6 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index f0c1928..762e3a2 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -2,13 +2,8 @@
 
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_I82374=y
 CONFIG_I8254=y
-CONFIG_I8257=y
-CONFIG_PARALLEL=y
-CONFIG_FDC=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index d1ee6f7..9ad307a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -9,12 +9,10 @@ CONFIG_TEST_DEVICES=y
 CONFIG_PPC4XX=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
-CONFIG_I8257=y
 CONFIG_OPENPIC=y
 CONFIG_PPCE500_PCI=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
-CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
 CONFIG_E500=y
@@ -58,17 +56,10 @@ CONFIG_MAC_NEWWORLD=y
 # For PReP
 CONFIG_PREP=y
 CONFIG_PREP_PCI=y
-CONFIG_SERIAL_ISA=y
-CONFIG_MC146818RTC=y
 CONFIG_RS6000_MC=y
-CONFIG_PARALLEL=y
 CONFIG_I82374=y
 CONFIG_I82378=y
-CONFIG_I8254=y
 CONFIG_PCKBD=y
-CONFIG_FDC=y
 CONFIG_NE2000_ISA=y
 CONFIG_PC87312=y
-CONFIG_PCSPK=y
-CONFIG_IDE_ISA=y
 CONFIG_CS4231A=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index ccefc10..4ba5584 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,20 +1,15 @@
-# Default configuration for sh4-softmmu
+# Default configuration for sh4eb-softmmu
 
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
-CONFIG_I8259=y
-CONFIG_I8254=y
-CONFIG_PCSPK=y
 CONFIG_I82374=y
-CONFIG_I8257=y
-CONFIG_MC146818RTC=y
 CONFIG_R2D=y
 CONFIG_SHIX=y
+CONFIG_TEST_DEVICES=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index c8edeb7..9717673 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -3,18 +3,12 @@
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
-CONFIG_I8259=y
-CONFIG_I8254=y
-CONFIG_PCSPK=y
 CONFIG_I82374=y
-CONFIG_I8257=y
-CONFIG_MC146818RTC=y
 CONFIG_R2D=y
 CONFIG_SHIX=y
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index f89e4eb..55e1a1e 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -1,7 +1,8 @@
 config FDC
     bool
-    default y
-    depends on ISA_BUS
+    # FIXME: there is no separate file for the MMIO floppy disk controller, so
+    # select ISA_BUS here instead of polluting each board that requires one
+    select ISA_BUS
 
 config SSI_M25P80
     bool
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index fcd87b4..57e09a0 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -7,26 +7,47 @@ config APM
 config I82378
     bool
     select ISA_BUS
+    select I8259
+    select I8254
+    select I82374
+    select MC146818RTC
 
 config PC87312
     bool
     select ISA_BUS
+    select I8259
+    select I8254
+    select I8257
+    select MC146818RTC
+    select SERIAL_ISA
+    select PARALLEL
+    select FDC
+    select IDE_ISA
 
 config PIIX4
     bool
+    # For historical reasons, SuperIO devices are created in the board
+    # for PIIX4.
     select ISA_BUS
 
 config VT82C686
     bool
     select ISA_BUS
     select ACPI_SMBUS
+    select SERIAL_ISA
+    select FDC
 
 config SMC37C669
     bool
     select ISA_BUS
+    select SERIAL_ISA
+    select PARALLEL
+    select FDC
 
 config LPC_ICH9
     bool
+    # For historical reasons, SuperIO devices are created in the board
+    # for ICH9.
     select ISA_BUS
     select ACPI_SMBUS
     select ACPI_X86_ICH
-- 
1.8.3.1
