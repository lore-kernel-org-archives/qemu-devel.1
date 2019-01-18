Received: from eggs.gnu.org ([209.51.188.92]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIt-0001lW-UF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIr-0007is-Lc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:47096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIn-0006rc-M3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:11 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:24:03 +0800
Message-Id: <20190118112410.3010-37-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 36/43] i2c: express dependencies with
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 -
 hw/Makefile.objs                 | 2 +-
 hw/audio/Kconfig                 | 1 +
 hw/display/Kconfig               | 3 +++
 hw/gpio/Kconfig                  | 1 +
 hw/i2c/Kconfig                   | 6 ++++++
 hw/i2c/Makefile.objs             | 3 ++-
 hw/i386/Kconfig                  | 1 +
 hw/input/Kconfig                 | 1 +
 hw/isa/Kconfig                   | 1 +
 hw/misc/Kconfig                  | 4 ++++
 hw/timer/Kconfig                 | 3 +++
 12 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 23ea6a3888..38622f7132 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -22,7 +22,6 @@ CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
-CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 
 # Boards:
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index b95b0c74a1..920086b182 100644
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
index 350f2d4359..5cb7118e44 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -40,6 +40,7 @@ config PCSPK
 
 config WM8750
     bool
+    depends on I2C
 
 config PL041
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 3d69435982..7a9d121772 100644
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
@@ -70,6 +72,7 @@ config MILKYMIST_TMU2
 
 config SM501
     bool
+    depends on I2C
 
 config TCX
     bool
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index d0a4abf93f..9227cb5598 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,5 +1,6 @@
 config MAX7310
     bool
+    depends on I2C
 
 config PL061
     bool
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index d6d4402608..74c9328729 100644
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
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 48f7760379..ff22aa6541 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,4 +1,5 @@
-common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
+common-obj-$(CONFIG_I2C) += core.o smbus.o
+common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index b359319875..9f5788e8e2 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -24,6 +24,7 @@ config PC_ACPI
     select ACPI_X86
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
+    select SMBUS_EEPROM
     depends on ACPI_SMBUS
 
 config I440FX
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 01805ed17b..5d64e07fc6 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -3,6 +3,7 @@ config ADB
 
 config LM832X
     bool
+    depends on I2C
 
 config PCKBD
     bool
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index bf72e4fef2..82eaf183b1 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -18,6 +18,7 @@ config PIIX4
 config VT82C686
     bool
     select ISA_BUS
+    select ACPI_SMBUS
 
 config SMC37C669
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e6df7480c6..73ceefab75 100644
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
@@ -34,6 +36,7 @@ config EDU
 
 config PCA9552
     bool
+    depends on I2C
 
 config PL310
     bool
@@ -100,3 +103,4 @@ config PVPANIC
 
 config AUX
     bool
+    select I2C
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 7dbc1211ab..e1a6e7469b 100644
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
2.17.1
