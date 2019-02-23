Received: from eggs.gnu.org ([209.51.188.92]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4Y-0004nN-PA
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4X-0002LT-RW
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:10 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:10 +0100
Message-Id: <1550908162-22644-19-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/30] hw/arm: Express dependencies of
 netduino / stm32f2xx with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Netduino only depends on the stm32f205 SoC which in turn depends on
its components.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 9 +--------
 hw/arm/Kconfig                  | 7 +++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 62d6b96..b0c6c99 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -25,25 +25,18 @@ CONFIG_TOSA=y
 CONFIG_Z2=y
 CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
+CONFIG_NETDUINO2=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
 CONFIG_ALLWINNER_EMAC=y
 CONFIG_IMX_FEC=y
 
-CONFIG_NETDUINO2=y
-
 CONFIG_FRAMEBUFFER=y
 
 CONFIG_DIGIC=y
 CONFIG_MPS2=y
 CONFIG_RASPI=y
-CONFIG_STM32F2XX_TIMER=y
-CONFIG_STM32F2XX_USART=y
-CONFIG_STM32F2XX_SYSCFG=y
-CONFIG_STM32F2XX_ADC=y
-CONFIG_STM32F2XX_SPI=y
-CONFIG_STM32F205_SOC=y
 CONFIG_NRF51_SOC=y
 
 CONFIG_CMSDK_APB_TIMER=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 487fb03..34243b4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -87,6 +87,7 @@ config MUSICPAL
 
 config NETDUINO2
     bool
+    select STM32F205_SOC
 
 config NSERIES
     bool
@@ -262,6 +263,12 @@ config RASPI
 
 config STM32F205_SOC
     bool
+    select ARM_V7M
+    select STM32F2XX_TIMER
+    select STM32F2XX_USART
+    select STM32F2XX_SYSCFG
+    select STM32F2XX_ADC
+    select STM32F2XX_SPI
 
 config XLNX_ZYNQMP_ARM
     bool
-- 
1.8.3.1
