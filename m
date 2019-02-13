Received: from eggs.gnu.org ([209.51.188.92]:51939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqFy-00025D-K8
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq5E-0006Fe-Do
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:16 +0100
Message-Id: <1550047098-1210-24-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 23/25] hw/arm: Express dependencies of the
 ZynqMP zcu102 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

This cleans up most settings in default-configs/aarch64-softmmu.mak.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/aarch64-softmmu.mak |  4 ----
 hw/arm/Kconfig                      | 11 +++++++++++
 hw/display/Kconfig                  |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 4ea9add..3a4b15e 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -3,10 +3,6 @@
 # We support all the 32 bit boards so need all their config
 include arm-softmmu.mak
 
-CONFIG_AUX=y
-CONFIG_DDC=y
-CONFIG_DPCD=y
-CONFIG_XLNX_ZYNQMP=y
 CONFIG_XLNX_ZYNQMP_ARM=y
 CONFIG_XLNX_VERSAL=y
 CONFIG_ARM_SMMUV3=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d96d1b..721cc07 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -289,6 +289,17 @@ config STM32F205_SOC
 
 config XLNX_ZYNQMP_ARM
     bool
+    select AHCI
+    select ARM_GIC
+    select CADENCE
+    select DDC
+    select DPCD
+    select SDHCI
+    select SSI
+    select SSI_M25P80
+    select XILINX_AXI
+    select XILINX_SPIPS
+    select XLNX_ZYNQMP
 
 config XLNX_VERSAL
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a5f3fc0..d2ae2f1 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -108,3 +108,4 @@ config VIRTIO_VGA
 
 config DPCD
     bool
+    select AUX
-- 
1.8.3.1
