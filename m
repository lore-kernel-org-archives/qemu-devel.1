Received: from eggs.gnu.org ([209.51.188.92]:46948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBOz-0005AB-KU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBOy-0003Ok-I9
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 18 Apr 2019 20:00:50 +0200
Message-Id: <20190418180057.3593-23-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 22/29] hw/arm: Express
 dependencies of sabrelite with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, Peter Chubb <peter.chubb@nicta.com.au>, qemu-block@nongnu.org, Cedric Le Goater <clg@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Add Kconfig dependencies for the Sabrelite / iMX6 machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 4 +---
 hw/arm/Kconfig                  | 7 +++++++
 hw/arm/Makefile.objs            | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 76508e3910..ef7dd7156a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -33,6 +33,7 @@ CONFIG_NETDUINO2=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
 CONFIG_DIGIC=3Dy
+CONFIG_SABRELITE=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
@@ -40,13 +41,10 @@ CONFIG_IMX_FEC=3Dy
=20
 CONFIG_NRF51_SOC=3Dy
=20
-CONFIG_FSL_IMX6=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
=20
-CONFIG_IMX_I2C=3Dy
-
 CONFIG_PCIE_PORT=3Dy
 CONFIG_XIO3130=3Dy
 CONFIG_IOH3420=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 059fb8282c..065c7acf1b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -177,6 +177,10 @@ config REALVIEW
     select DS1338 # I2C RTC+NVRAM
     select USB_OHCI
=20
+config SABRELITE
+    bool
+    select FSL_IMX6
+
 config STELLARIS
     bool
     select ARM_V7M
@@ -289,6 +293,9 @@ config FSL_IMX31
=20
 config FSL_IMX6
     bool
+    select A9MPCORE
+    select IMX
+    select IMX_I2C
=20
 config ASPEED_SOC
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 4f591ca487..fadd69882c 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_COLLIE) +=3D collie.o
 obj-$(CONFIG_VERSATILE) +=3D versatilepb.o
 obj-$(CONFIG_VEXPRESS) +=3D vexpress.o
 obj-$(CONFIG_ZYNQ) +=3D xilinx_zynq.o
+obj-$(CONFIG_SABRELITE) +=3D sabrelite.o
=20
 obj-$(CONFIG_ARM_V7M) +=3D armv7m.o
 obj-$(CONFIG_EXYNOS4) +=3D exynos4210.o
@@ -36,7 +37,7 @@ obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-z=
cu102.o
 obj-$(CONFIG_XLNX_VERSAL) +=3D xlnx-versal.o xlnx-versal-virt.o
 obj-$(CONFIG_FSL_IMX25) +=3D fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
-obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o sabrelite.o
+obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o
 obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) +=3D mps2.o
 obj-$(CONFIG_MPS2) +=3D mps2-tz.o
--=20
2.21.0
