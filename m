Received: from eggs.gnu.org ([209.51.188.92]:57183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4B-0004Wa-HQ
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4A-0001vB-LC
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:49:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:00 +0100
Message-Id: <1550908162-22644-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/30] hw/arm: Express dependencies of the
 fsl-imx31 machine with Kconfig
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

Add Kconfig dependencies for the fsl-imx31 / kzm machine.
This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs (i.=
e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 3 +--
 hw/arm/Kconfig                  | 5 +++++
 hw/misc/Kconfig                 | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 74382cc..388a2ba 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -8,6 +8,7 @@ CONFIG_PCI_DEVICES=3Dy
 CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
 CONFIG_INTEGRATOR=3Dy
+CONFIG_FSL_IMX31=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_NAND=3Dy
@@ -66,7 +67,6 @@ CONFIG_TSC210X=3Dy
 CONFIG_BLIZZARD=3Dy
 CONFIG_ONENAND=3Dy
 CONFIG_TUSB6010=3Dy
-CONFIG_IMX=3Dy
 CONFIG_MAINSTONE=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_MUSCA=3Dy
@@ -115,7 +115,6 @@ CONFIG_ALLWINNER_A10_PIC=3Dy
 CONFIG_ALLWINNER_A10=3Dy
=20
 CONFIG_FSL_IMX6=3Dy
-CONFIG_FSL_IMX31=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6a34ce1..df10a4d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -106,6 +106,11 @@ config FSL_IMX25
=20
 config FSL_IMX31
     bool
+    select SERIAL
+    select IMX
+    select IMX_I2C
+    select LAN9118
+    select PCI
=20
 config FSL_IMX6
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 11d4b30..54ff9a8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -76,6 +76,8 @@ config ECCMEMCTL
 config IMX
     bool
     select PTIMER
+    select SSI
+    select USB_EHCI_SYSBUS
=20
 config STM32F2XX_SYSCFG
     bool
--=20
1.8.3.1
