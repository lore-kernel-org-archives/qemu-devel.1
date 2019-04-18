Received: from eggs.gnu.org ([209.51.188.92]:47178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBPt-0005sw-Hd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBPs-0003sr-HK
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:05:45 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 18 Apr 2019 20:00:53 +0200
Message-Id: <20190418180057.3593-26-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 25/29] hw/arm: Express
 dependencies of the microbit / nrf51 machine with Kconfig
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

Add Kconfig dependencies for the NRF51 / microbit machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 3 +--
 hw/arm/Kconfig                  | 6 ++++++
 hw/arm/Makefile.objs            | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 6dc388c43e..233937f394 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -35,11 +35,10 @@ CONFIG_RASPI=3Dy
 CONFIG_DIGIC=3Dy
 CONFIG_SABRELITE=3Dy
 CONFIG_EMCRAFT_SF2=3Dy
+CONFIG_MICROBIT=3Dy
=20
 CONFIG_VGA=3Dy
=20
-CONFIG_NRF51_SOC=3Dy
-
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 58439c492a..708eae19e5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -347,8 +347,14 @@ config FSL_IMX6UL
     select IMX_I2C
     select SDHCI
=20
+config MICROBIT
+    bool
+    select NRF51_SOC
+
 config NRF51_SOC
     bool
+    select I2C
+    select ARM_V7M
=20
 config EMCRAFT_SF2
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index eae9f6c442..994e67dd0d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -8,6 +8,7 @@ obj-$(CONFIG_EMCRAFT_SF2) +=3D msf2-som.o
 obj-$(CONFIG_HIGHBANK) +=3D highbank.o
 obj-$(CONFIG_INTEGRATOR) +=3D integratorcp.o
 obj-$(CONFIG_MAINSTONE) +=3D mainstone.o
+obj-$(CONFIG_MICROBIT) +=3D microbit.o
 obj-$(CONFIG_MUSICPAL) +=3D musicpal.o
 obj-$(CONFIG_NETDUINO2) +=3D netduino2.o
 obj-$(CONFIG_NSERIES) +=3D nseries.o
@@ -48,4 +49,4 @@ obj-$(CONFIG_ARMSSE) +=3D armsse.o
 obj-$(CONFIG_FSL_IMX7) +=3D fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) +=3D smmu-common.o smmuv3.o
 obj-$(CONFIG_FSL_IMX6UL) +=3D fsl-imx6ul.o mcimx6ul-evk.o
-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_soc.o microbit.o
+obj-$(CONFIG_NRF51_SOC) +=3D nrf51_soc.o
--=20
2.21.0
