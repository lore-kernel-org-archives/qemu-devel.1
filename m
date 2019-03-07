Received: from eggs.gnu.org ([209.51.188.92]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1ts1-0004aG-J5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1ts0-0008FB-S0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:37 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Mar 2019 15:18:29 +0100
Message-Id: <1551968334-18982-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1551968334-18982-1-git-send-email-thuth@redhat.com>
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 04/29] hw/arm: Express dependencies of the
 exynos machines with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Add Kconfig dependencies for the Exynos-related boards (nuri and
smdkc210).
This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs (i.=
e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 18 ++++++------------
 hw/arm/Kconfig                  | 11 +++++++++++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 2a7efc1..3475d50 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,7 +1,12 @@
 # Default configuration for arm-softmmu
=20
-CONFIG_PCI=3Dy
+# TODO: ARM_V7M is currently always required - make this more flexible!
+CONFIG_ARM_V7M=3Dy
+
 CONFIG_PCI_DEVICES=3Dy
+
+CONFIG_EXYNOS4=3Dy
+
 CONFIG_VGA=3Dy
 CONFIG_NAND=3Dy
 CONFIG_ECC=3Dy
@@ -25,7 +30,6 @@ CONFIG_ADS7846=3Dy
 CONFIG_MAX111X=3Dy
 CONFIG_SSI_SD=3Dy
 CONFIG_SSI_M25P80=3Dy
-CONFIG_LAN9118=3Dy
 CONFIG_SMC91C111=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
@@ -35,21 +39,15 @@ CONFIG_PFLASH_CFI01=3Dy
 CONFIG_PFLASH_CFI02=3Dy
 CONFIG_MICRODRIVE=3Dy
 CONFIG_USB_MUSB=3Dy
-CONFIG_USB_EHCI_SYSBUS=3Dy
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
=20
 CONFIG_ARM11MPCORE=3Dy
-CONFIG_A9MPCORE=3Dy
 CONFIG_A15MPCORE=3Dy
=20
-CONFIG_ARM_V7M=3Dy
 CONFIG_NETDUINO2=3Dy
=20
-CONFIG_ARM_GIC=3Dy
 CONFIG_ARM_TIMER=3Dy
-CONFIG_ARM_MPTIMER=3Dy
-CONFIG_A9_GTIMER=3Dy
 CONFIG_PL011=3Dy
 CONFIG_PL022=3Dy
 CONFIG_PL031=3Dy
@@ -60,11 +58,9 @@ CONFIG_PL080=3Dy
 CONFIG_PL110=3Dy
 CONFIG_PL181=3Dy
 CONFIG_PL190=3Dy
-CONFIG_PL310=3Dy
 CONFIG_PL330=3Dy
 CONFIG_CADENCE=3Dy
 CONFIG_XGMAC=3Dy
-CONFIG_EXYNOS4=3Dy
 CONFIG_PXA2XX=3Dy
 CONFIG_BITBANG_I2C=3Dy
 CONFIG_FRAMEBUFFER=3Dy
@@ -72,7 +68,6 @@ CONFIG_XILINX_SPIPS=3Dy
 CONFIG_ZYNQ_DEVCFG=3Dy
=20
 CONFIG_ARM11SCU=3Dy
-CONFIG_A9SCU=3Dy
 CONFIG_DIGIC=3Dy
 CONFIG_MARVELL_88W8618=3Dy
 CONFIG_OMAP=3Dy
@@ -122,7 +117,6 @@ CONFIG_VERSATILE_I2C=3Dy
 CONFIG_PCI_EXPRESS=3Dy
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=3Dy
=20
-CONFIG_SDHCI=3Dy
 CONFIG_INTEGRATOR=3Dy
 CONFIG_INTEGRATOR_DEBUG=3Dy
=20
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d298fbd..74436cc 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -8,7 +8,14 @@ config DIGIC
=20
 config EXYNOS4
     bool
+    select A9MPCORE
+    select I2C
+    select LAN9118
+    select PCI
+    select PL310 # cache controller
     select PTIMER
+    select SDHCI
+    select USB_EHCI_SYSBUS
=20
 config HIGHBANK
     bool
@@ -104,6 +111,10 @@ config ZAURUS
=20
 config A9MPCORE
     bool
+    select A9_GTIMER
+    select A9SCU       # snoop control unit
+    select ARM_GIC
+    select ARM_MPTIMER
=20
 config A15MPCORE
     bool
--=20
1.8.3.1
