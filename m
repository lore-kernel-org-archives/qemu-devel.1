Received: from eggs.gnu.org ([208.118.235.92]:54962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGn-0003US-PQ
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGj-0004oW-MT
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGi-0004B3-ES
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:45 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:09 +0800
Message-Id: <20181227063419.12981-16-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 15/25] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/i386-softmmu.mak | 10 ----------
 hw/audio/Kconfig                 |  2 ++
 hw/block/Kconfig                 |  2 ++
 hw/char/Kconfig                  |  5 +++++
 hw/display/Kconfig               |  6 ++++++
 hw/i386/Kconfig                  |  1 +
 hw/ide/Kconfig                   |  1 +
 hw/input/Kconfig                 |  2 ++
 hw/isa/Kconfig                   |  5 +++++
 hw/misc/Kconfig                  |  4 ++++
 hw/net/Kconfig                   |  3 +++
 hw/watchdog/Kconfig              |  2 ++
 12 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index e152590d15..d664329ac1 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -4,23 +4,15 @@ CONFIG_PCI=y
 CONFIG_ISA=y
 include hyperv.mak
 CONFIG_VGA_ISA=y
-CONFIG_VGA_CIRRUS=y
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
@@ -30,14 +22,12 @@ CONFIG_APM=y
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
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index bfb30276ec..350f2d4359 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -35,6 +35,8 @@ config HDA
 
 config PCSPK
     bool
+    default y
+    depends on ISA_BUS
 
 config WM8750
     bool
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 3710434436..83c2be5915 100644
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
index 1ed6f0dbce..26765599a5 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -3,6 +3,8 @@ config ESCC
 
 config PARALLEL
     bool
+    default y
+    depends on ISA_BUS
 
 config PL011
     bool
@@ -12,6 +14,9 @@ config SERIAL
 
 config SERIAL_ISA
     bool
+    default y
+    depends on ISA_BUS
+    select SERIAL
 
 config SERIAL_PCI
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 5e73277cc2..e0d7919a06 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -9,6 +9,9 @@ config ADS7846
 
 config VGA_CIRRUS
     bool
+    default y
+    depends on ISA_BUS && PCI
+    select VGA
 
 config G364FB
     bool
@@ -36,9 +39,12 @@ config VGA_PCI
 
 config VGA_ISA
     bool
+    depends on ISA_BUS
+    select VGA
 
 config VGA_ISA_MM
     bool
+    select VGA
 
 config VMWARE_VGA
     bool
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 427bda3717..68a9064558 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -9,6 +9,7 @@ config I440FX
 
 config ISAPC
     bool
+    select ISA_BUS
 
 config Q35
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 0f25b27163..41d3057675 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -12,6 +12,7 @@ config IDE_PCI
 
 config IDE_ISA
     bool
+    depends on ISA_BUS
     select IDE_QDEV
 
 config IDE_PIIX
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 91bae47498..01805ed17b 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -6,6 +6,8 @@ config LM832X
 
 config PCKBD
     bool
+    default y
+    depends on ISA_BUS
 
 config PL050
     bool
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index b59d074453..3f451ef006 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -9,15 +9,20 @@ config I82378
 
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
 
 config LPC_ICH9
     bool
+    select ISA_BUS
+    select ACPI_X86_ICH
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1ca4b2464e..e6df7480c6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -1,5 +1,6 @@
 config APPLESMC
     bool
+    depends on ISA_BUS
 
 config MAX111X
     bool
@@ -12,9 +13,11 @@ config TMP421
 
 config ISA_DEBUG
     bool
+    depends on ISA_BUS
 
 config SGA
     bool
+    depends on ISA_BUS
 
 config ISA_TESTDEV
     bool
@@ -93,6 +96,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
+    depends on ISA_BUS
 
 config AUX
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index c87375ee52..b7585cbe55 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -48,6 +48,9 @@ config LAN9118
 
 config NE2000_ISA
     bool
+    default y
+    depends on ISA_BUS
+    depends on PCI # for NE2000State
 
 config OPENCORES_ETH
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 4e24bf8240..b5cd056b01 100644
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
2.17.1
