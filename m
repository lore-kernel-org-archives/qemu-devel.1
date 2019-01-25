Received: from eggs.gnu.org ([209.51.188.92]:58695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyPL-0008Cv-9O
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP9-0002Jr-SS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:17 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP9-0002IN-LB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:07 -0500
Received: by mail-wr1-x442.google.com with SMTP id p7so9673314wru.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:08:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:11 +0100
Message-Id: <1548410831-19553-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 52/52] kconfig: introduce CONFIG_TEST_DEVICES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

This moves some devices that are mostly used for testing purposes
(for example in endianness-test) under a new symbol CONFIG_TEST_DEVICES
that has to be enabled explicitly in the default-configs file.  This makes
it easier to drop this code from QEMU if desirable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak       | 2 +-
 default-configs/i386-softmmu.mak        | 1 +
 default-configs/mips-softmmu-common.mak | 2 +-
 default-configs/ppc-softmmu.mak         | 2 +-
 default-configs/sh4-softmmu.mak         | 3 +--
 default-configs/sh4eb-softmmu.mak       | 2 +-
 default-configs/sparc64-softmmu.mak     | 2 +-
 hw/Kconfig                              | 3 +++
 hw/hyperv/Kconfig                       | 2 +-
 hw/misc/Kconfig                         | 7 ++++---
 10 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 2ad4d40..762e3a2 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -10,6 +10,6 @@ CONFIG_VMWARE_VGA=y
 CONFIG_IDE_CMD646=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_SMC37C669=y
 CONFIG_DP264=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 07b1e82..0f30bd6 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -3,6 +3,7 @@
 # Optional devices:
 #
 CONFIG_PCI_DEVICES=y
+CONFIG_TEST_DEVICES=y
 
 # Boards:
 #
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index e5f0841..ac70f00 100644
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
@@ -41,3 +40,4 @@ CONFIG_MALTA=y
 CONFIG_MIPSSIM=y
 CONFIG_ACPI_SMBUS=y
 CONFIG_SMBUS_EEPROM=y
+CONFIG_TEST_DEVICES=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 87c2d6d..05ba726 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -3,6 +3,7 @@
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_ISA_BUS=y
+CONFIG_TEST_DEVICES=y
 
 # For embedded PPCs:
 CONFIG_PPC4XX=y
@@ -57,7 +58,6 @@ CONFIG_MAC_NEWWORLD=y
 # For PReP
 CONFIG_PREP=y
 CONFIG_PREP_PCI=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
 CONFIG_I82374=y
 CONFIG_I82378=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 1b4582a..4ebcaaa 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -9,9 +9,8 @@ CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
 CONFIG_I2C=y
 CONFIG_DDC=y
-CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I82374=y
 CONFIG_R2D=y
 CONFIG_SHIX=y
-CONFIG_TEST_DEVICES=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index baed9a4..4ebcaaa 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -9,7 +9,7 @@ CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
 CONFIG_I2C=y
 CONFIG_DDC=y
-CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I82374=y
 CONFIG_R2D=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index aef26a2..7fe1005 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -14,7 +14,7 @@ CONFIG_PCI_SABRE=y
 CONFIG_SIMBA=y
 CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_SUN4V_RTC=y
 CONFIG_SUN4U=y
 CONFIG_NIAGARA=y
diff --git a/hw/Kconfig b/hw/Kconfig
index e3c380f..d5ecd02 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -61,6 +61,9 @@ source unicore32/Kconfig
 source xtensa/Kconfig
 
 # Symbols used by multiple targets
+config TEST_DEVICES
+    bool
+
 config XILINX
     bool
     select PTIMER # for hw/timer/xilinx_timer.c
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
index a178bac..892a472 100644
--- a/hw/hyperv/Kconfig
+++ b/hw/hyperv/Kconfig
@@ -5,5 +5,5 @@ config HYPERV
 
 config HYPERV_TESTDEV
     bool
-    default y if PC
+    default y if TEST_DEVICES
     depends on HYPERV
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 823135c..3ebe30f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -25,16 +25,17 @@ config SGA
 
 config ISA_TESTDEV
     bool
-    default y if PC
+    default y if TEST_DEVICES
+    depends on ISA_BUS
 
 config PCI_TESTDEV
     bool
-    default y if PCI_DEVICES
+    default y if TEST_DEVICES
     depends on PCI
 
 config EDU
     bool
-    default y if PCI_DEVICES
+    default y if TEST_DEVICES
     depends on PCI
 
 config PCA9552
-- 
1.8.3.1
