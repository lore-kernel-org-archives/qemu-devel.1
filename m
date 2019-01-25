Received: from eggs.gnu.org ([209.51.188.92]:58627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP9-00080A-P3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP1-0002CZ-T8
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP1-0002BH-H7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id s12so9632870wrt.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:03 +0100
Message-Id: <1548410831-19553-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 44/52] ptimer: express dependencies with Kconfig
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-39-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak        | 1 -
 default-configs/cris-softmmu.mak       | 1 -
 default-configs/lm32-softmmu.mak       | 1 -
 default-configs/m68k-softmmu.mak       | 1 -
 default-configs/microblaze-softmmu.mak | 1 -
 default-configs/nios2-softmmu.mak      | 1 -
 default-configs/ppc-softmmu.mak        | 1 -
 default-configs/sh4-softmmu.mak        | 1 -
 default-configs/sh4eb-softmmu.mak      | 1 -
 default-configs/sparc-softmmu.mak      | 1 -
 default-configs/sparc64-softmmu.mak    | 1 -
 default-configs/unicore32-softmmu.mak  | 1 -
 hw/Kconfig                             | 2 ++
 hw/arm/Kconfig                         | 4 ++++
 hw/cris/Kconfig                        | 1 +
 hw/lm32/Kconfig                        | 2 ++
 hw/m68k/Kconfig                        | 2 ++
 hw/mips/Kconfig                        | 1 +
 hw/misc/Kconfig                        | 1 +
 hw/net/Kconfig                         | 2 ++
 hw/sh4/Kconfig                         | 1 +
 hw/sparc/Kconfig                       | 2 ++
 hw/timer/Kconfig                       | 6 ++++++
 hw/unicore32/Kconfig                   | 1 +
 hw/watchdog/Kconfig                    | 1 +
 25 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 07d0a62..f8a7742 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -6,7 +6,6 @@ CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
-CONFIG_PTIMER=y
 CONFIG_SD=y
 CONFIG_MAX7310=y
 CONFIG_WM8750=y
diff --git a/default-configs/cris-softmmu.mak b/default-configs/cris-softmmu.mak
index a637c4b..b3cae59 100644
--- a/default-configs/cris-softmmu.mak
+++ b/default-configs/cris-softmmu.mak
@@ -2,6 +2,5 @@
 
 CONFIG_ETRAXFS=y
 CONFIG_NAND=y
-CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_AXIS=y
diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
index ef0f4ba..f489838 100644
--- a/default-configs/lm32-softmmu.mak
+++ b/default-configs/lm32-softmmu.mak
@@ -3,7 +3,6 @@
 CONFIG_LM32=y
 CONFIG_MILKYMIST=y
 CONFIG_FRAMEBUFFER=y
-CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SD=y
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 27f5274..a12eece 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for m68k-softmmu
 
 CONFIG_COLDFIRE=y
-CONFIG_PTIMER=y
 CONFIG_AN5206=y
 CONFIG_MCF5208=y
diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/microblaze-softmmu.mak
index 14837cf..a4a6770 100644
--- a/default-configs/microblaze-softmmu.mak
+++ b/default-configs/microblaze-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for microblaze-softmmu
 
-CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_SERIAL=y
 CONFIG_XILINX=y
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index ab42d0f..b3c507e 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -2,6 +2,5 @@
 
 CONFIG_NIOS2=y
 CONFIG_SERIAL=y
-CONFIG_PTIMER=y
 CONFIG_ALTERA_TIMER=y
 CONFIG_NIOS2_10M50=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index c60a483..f38c14c 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -13,7 +13,6 @@ CONFIG_OPENPIC=y
 CONFIG_PPCE500_PCI=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
-CONFIG_PTIMER=y
 CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 7446fc8..9e8e487 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -4,7 +4,6 @@ CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
-CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index e37a532..2a26946 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -4,7 +4,6 @@ CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
-CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 59a4a3d..223b0be 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -6,7 +6,6 @@ CONFIG_SCSI=y
 CONFIG_ESP=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
-CONFIG_PTIMER=y
 CONFIG_FDC=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_PCNET_COMMON=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 4a6e997..aef26a2 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -3,7 +3,6 @@
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_M48T59=y
-CONFIG_PTIMER=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
index 5f6c4a8..17a7915 100644
--- a/default-configs/unicore32-softmmu.mak
+++ b/default-configs/unicore32-softmmu.mak
@@ -1,5 +1,4 @@
 # Default configuration for unicore32-softmmu
 CONFIG_ISA_BUS=y
 CONFIG_PUV3=y
-CONFIG_PTIMER=y
 CONFIG_PCKBD=y
diff --git a/hw/Kconfig b/hw/Kconfig
index c4f1547..e3c380f 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -63,6 +63,8 @@ source xtensa/Kconfig
 # Symbols used by multiple targets
 config XILINX
     bool
+    select PTIMER # for hw/timer/xilinx_timer.c
 
 config XILINX_AXI
     bool
+    select PTIMER # for hw/dma/xilinx_axidma.c
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1a0a5c9..f136952 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -3,9 +3,11 @@ config VIRT
 
 config DIGIC
     bool
+    select PTIMER
 
 config EXYNOS4
     bool
+    select PTIMER
 
 config HIGHBANK
     bool
@@ -18,6 +20,7 @@ config MAINSTONE
 
 config MUSICPAL
     bool
+    select PTIMER
 
 config NETDUINO2
     bool
@@ -99,6 +102,7 @@ config NRF51_SOC
 
 config MSF2
     bool
+    select PTIMER
 
 config ZAURUS
     bool
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
index 86954ab..b7738ab 100644
--- a/hw/cris/Kconfig
+++ b/hw/cris/Kconfig
@@ -3,3 +3,4 @@ config AXIS
 
 config ETRAXFS
    bool
+   select PTIMER
diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
index 84c530e..4f45840 100644
--- a/hw/lm32/Kconfig
+++ b/hw/lm32/Kconfig
@@ -1,5 +1,7 @@
 config LM32
     bool
+    select PTIMER
 
 config MILKYMIST
     bool
+    select PTIMER
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index cd66ada..8e91eda 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -3,6 +3,8 @@ config AN5206
 
 config MCF5206
     bool
+    select PTIMER
 
 config MCF5208
     bool
+    select PTIMER
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 348c9bf..cdc07e5 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -15,6 +15,7 @@ config FULONG
 
 config MIPS_CPS
     bool
+    select PTIMER
 
 config MIPS_BOSTON
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 0680d1e..55170f6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -66,6 +66,7 @@ config ECCMEMCTL
 
 config IMX
     bool
+    select PTIMER
 
 config STM32F2XX_SYSCFG
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 6d15720..e575bf5 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -45,6 +45,7 @@ config SMC91C111
 
 config LAN9118
     bool
+    select PTIMER
 
 config NE2000_ISA
     bool
@@ -96,6 +97,7 @@ config VIRTIO_NET
 
 config ETSEC
     bool
+    select PTIMER
 
 config ROCKER
     bool
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index 417a72f..1ea2bc3 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -9,3 +9,4 @@ config SH7750
 
 config SH4
     bool
+    select PTIMER
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
index 3795754..c9c2142 100644
--- a/hw/sparc/Kconfig
+++ b/hw/sparc/Kconfig
@@ -6,6 +6,8 @@ config LEON3
 
 config GRLIB
     bool
+    select PTIMER
 
 config SLAVIO
     bool
+    select PTIMER
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1a6e74..a021c74 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -1,8 +1,10 @@
 config ARM_TIMER
     bool
+    select PTIMER
 
 config ARM_MPTIMER
     bool
+    select PTIMER
 
 config A9_GTIMER
     bool
@@ -36,12 +38,14 @@ config XLNX_ZYNQMP
 
 config ALTERA_TIMER
     bool
+    select PTIMER
 
 config MC146818RTC
     bool
 
 config ALLWINNER_A10_PIT
     bool
+    select PTIMER
 
 config STM32F2XX_TIMER
     bool
@@ -51,6 +55,8 @@ config SUN4V_RTC
 
 config CMSDK_APB_TIMER
     bool
+    select PTIMER
 
 config CMSDK_APB_DUALTIMER
     bool
+    select PTIMER
diff --git a/hw/unicore32/Kconfig b/hw/unicore32/Kconfig
index b3cf294..a03a996 100644
--- a/hw/unicore32/Kconfig
+++ b/hw/unicore32/Kconfig
@@ -1,2 +1,3 @@
 config PUV3
     bool
+    select PTIMER
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 35ccb72..2118d89 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -1,5 +1,6 @@
 config CMSDK_APB_WATCHDOG
     bool
+    select PTIMER
 
 config WDT_IB6300ESB
     bool
-- 
1.8.3.1
