Received: from eggs.gnu.org ([209.51.188.92]:52129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqG2-0002Kh-NR
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq4v-0005xg-Dw
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:38 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:07 +0100
Message-Id: <1550047098-1210-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/25] hw/arm: Express dependencies of
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

Netduino only depends on the stm32f205 SoC which in turn depends on
its components.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 9 +--------
 hw/arm/Kconfig                  | 7 +++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 9db6808..3279fb5 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -24,25 +24,18 @@ CONFIG_TOSA=y
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
index 3d580fa..5d7dafb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -81,6 +81,7 @@ config MUSICPAL
 
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
