Received: from eggs.gnu.org ([209.51.188.92]:45928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCc-0001yE-TM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCb-0004CD-IY
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCb-00049w-86
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id l5so6631183wrw.6
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:40 +0100
Message-Id: <1551723614-1823-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/54] i2c: express dependencies with Kconfig
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
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-38-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak         | 1 -
 default-configs/i386-softmmu.mak        | 2 --
 default-configs/mips-softmmu-common.mak | 1 -
 default-configs/ppc-softmmu.mak         | 1 -
 default-configs/sh4-softmmu.mak         | 1 -
 default-configs/sh4eb-softmmu.mak       | 1 -
 hw/Makefile.objs                        | 2 +-
 hw/audio/Kconfig                        | 1 +
 hw/display/Kconfig                      | 3 +++
 hw/gpio/Kconfig                         | 1 +
 hw/i2c/Kconfig                          | 6 ++++++
 hw/i386/Kconfig                         | 1 +
 hw/input/Kconfig                        | 1 +
 hw/isa/Kconfig                          | 1 +
 hw/misc/Kconfig                         | 4 ++++
 hw/nvram/Kconfig                        | 1 +
 hw/timer/Kconfig                        | 3 +++
 17 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 917b18d..8ced4e8 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -69,7 +69,6 @@ CONFIG_CADENCE=y
 CONFIG_XGMAC=y
 CONFIG_EXYNOS4=y
 CONFIG_PXA2XX=y
-CONFIG_I2C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_FRAMEBUFFER=y
 CONFIG_XILINX_SPIPS=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index ed234c1..98552e1 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -24,8 +24,6 @@ CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
-CONFIG_SMBUS_EEPROM=y
-CONFIG_I2C=y
 CONFIG_PCI_DEVICES=y
 
 # Boards:
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 45c599b..0795d52 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -33,7 +33,6 @@ CONFIG_MC146818RTC=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
-CONFIG_I2C=y
 CONFIG_R4K=y
 CONFIG_MALTA=y
 CONFIG_MIPSSIM=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index d4807b3..0e46d6a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -32,7 +32,6 @@ CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_SM501=y
 CONFIG_DDC=y
 CONFIG_IDE_SII3112=y
-CONFIG_I2C=y
 CONFIG_AT24C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_M41T80=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 3f7fbe2..8b003e1 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -9,7 +9,6 @@ CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
-CONFIG_I2C=y
 CONFIG_DDC=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 17f07a4..6f58242 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -9,7 +9,6 @@ CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
 CONFIG_IDE_MMIO=y
 CONFIG_SM501=y
-CONFIG_I2C=y
 CONFIG_DDC=y
 CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 2d9b42d..82aa7fa 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -10,7 +10,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += display/
 devices-dirs-$(CONFIG_SOFTMMU) += dma/
 devices-dirs-$(CONFIG_SOFTMMU) += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
-devices-dirs-$(CONFIG_SOFTMMU) += i2c/
+devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-$(CONFIG_SOFTMMU) += ide/
 devices-dirs-$(CONFIG_SOFTMMU) += input/
 devices-dirs-$(CONFIG_SOFTMMU) += intc/
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index 01aea55..e9c6fed 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -40,6 +40,7 @@ config PCSPK
 
 config WM8750
     bool
+    depends on I2C
 
 config PL041
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 4941773..fc129f6 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -24,9 +24,11 @@ config PL110
 
 config SII9022
     bool
+    depends on I2C
 
 config SSD0303
     bool
+    depends on I2C
 
 config SSD0323
     bool
@@ -71,6 +73,7 @@ config MILKYMIST_TMU2
 
 config SM501
     bool
+    select I2C
 
 config TCX
     bool
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index d0a4abf..9227cb5 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,5 +1,6 @@
 config MAX7310
     bool
+    depends on I2C
 
 config PL061
     bool
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index d6d4402..74c9328 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -3,18 +3,24 @@ config I2C
 
 config SMBUS_EEPROM
     bool
+    depends on I2C
 
 config DDC
     bool
+    depends on I2C
 
 config VERSATILE_I2C
     bool
+    select I2C
 
 config ACPI_SMBUS
     bool
+    select I2C
 
 config BITBANG_I2C
     bool
+    select I2C
 
 config IMX_I2C
     bool
+    select I2C
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 081855e..9cd24d7 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -28,6 +28,7 @@ config PC_ACPI
     select ACPI_X86
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
+    select SMBUS_EEPROM
     depends on ACPI_SMBUS
 
 config I440FX
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 814f87f..e05b7be 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -3,6 +3,7 @@ config ADB
 
 config LM832X
     bool
+    depends on I2C
 
 config PCKBD
     bool
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 6f0812d..fcd87b4 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -19,6 +19,7 @@ config PIIX4
 config VT82C686
     bool
     select ISA_BUS
+    select ACPI_SMBUS
 
 config SMC37C669
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 41d8633..5f63701 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -7,9 +7,11 @@ config MAX111X
 
 config TMP105
     bool
+    depends on I2C
 
 config TMP421
     bool
+    depends on I2C
 
 config ISA_DEBUG
     bool
@@ -36,6 +38,7 @@ config EDU
 
 config PCA9552
     bool
+    depends on I2C
 
 config PL310
     bool
@@ -102,5 +105,6 @@ config PVPANIC
 
 config AUX
     bool
+    select I2C
 
 source macio/Kconfig
diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
index 1f5ec95..ebaa749 100644
--- a/hw/nvram/Kconfig
+++ b/hw/nvram/Kconfig
@@ -3,6 +3,7 @@ config DS1225Y
 
 config AT24C
     bool
+    depends on I2C
 
 config MAC_NVRAM
     bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 7dbc121..e1a6e74 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -9,6 +9,7 @@ config A9_GTIMER
 
 config DS1338
     bool
+    depends on I2C
 
 config HPET
     bool
@@ -18,6 +19,7 @@ config I8254
 
 config M41T80
     bool
+    depends on I2C
 
 config M48T59
     bool
@@ -27,6 +29,7 @@ config PL031
 
 config TWL92230
     bool
+    depends on I2C
 
 config XLNX_ZYNQMP
     bool
-- 
1.8.3.1
