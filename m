Received: from eggs.gnu.org ([209.51.188.92]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4e-0004tf-1J
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4d-0002Te-Au
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:13 +0100
Message-Id: <1550908162-22644-22-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 21/30] hw/arm: Express dependencies of the
 raspi machines with Kconfig
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

Most of the code is directly controlled by the CONFIG_RASPI switch,
so not much to add here additionally.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 4 +---
 hw/arm/Kconfig                  | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b8509fd..290023c 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -28,15 +28,13 @@ CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
 CONFIG_MPS2=y
+CONFIG_RASPI=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
 CONFIG_IMX_FEC=y
 
-CONFIG_FRAMEBUFFER=y
-
 CONFIG_DIGIC=y
-CONFIG_RASPI=y
 CONFIG_NRF51_SOC=y
 
 CONFIG_FSL_IMX6=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fa69f1b..32495e6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -269,6 +269,9 @@ config ALLWINNER_A10
 
 config RASPI
     bool
+    select FRAMEBUFFER
+    select PL011 # UART
+    select SDHCI
 
 config STM32F205_SOC
     bool
-- 
1.8.3.1
