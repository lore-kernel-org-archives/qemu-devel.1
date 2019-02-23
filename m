Received: from eggs.gnu.org ([209.51.188.92]:57530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4a-0004pA-U7
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4a-0002QU-5L
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:12 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:11 +0100
Message-Id: <1550908162-22644-20-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 19/30] hw/arm: Express dependencies of
 allwinner / cubieboard with Kconfig
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

Add dependencies for the Cubitech Cubieboard.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 6 +-----
 hw/arm/Kconfig                  | 9 +++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b0c6c99..badb190 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -4,6 +4,7 @@
 CONFIG_ARM_V7M=y
 
 CONFIG_ARM_VIRT=y
+CONFIG_CUBIEBOARD=y
 CONFIG_EXYNOS4=y
 CONFIG_HIGHBANK=y
 CONFIG_INTEGRATOR=y
@@ -29,7 +30,6 @@ CONFIG_NETDUINO2=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
-CONFIG_ALLWINNER_EMAC=y
 CONFIG_IMX_FEC=y
 
 CONFIG_FRAMEBUFFER=y
@@ -56,10 +56,6 @@ CONFIG_IOTKIT_SYSCTL=y
 CONFIG_IOTKIT_SYSINFO=y
 CONFIG_ARMSSE_CPUID=y
 
-CONFIG_ALLWINNER_A10_PIT=y
-CONFIG_ALLWINNER_A10_PIC=y
-CONFIG_ALLWINNER_A10=y
-
 CONFIG_FSL_IMX6=y
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 34243b4..73382b6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -24,6 +24,10 @@ config CHEETAH
     select OMAP
     select TSC210X
 
+config CUBIEBOARD
+    bool
+    select ALLWINNER_A10
+
 config DIGIC
     bool
     select PTIMER
@@ -257,6 +261,11 @@ config EXYNOS4
 
 config ALLWINNER_A10
     bool
+    select AHCI
+    select ALLWINNER_A10_PIT
+    select ALLWINNER_A10_PIC
+    select ALLWINNER_EMAC
+    select SERIAL
 
 config RASPI
     bool
-- 
1.8.3.1
