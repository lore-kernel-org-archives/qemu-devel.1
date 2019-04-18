Received: from eggs.gnu.org ([209.51.188.92]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBOQ-0004f5-Vo
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBON-0002s3-3T
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:12 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 18 Apr 2019 20:00:46 +0200
Message-Id: <20190418180057.3593-19-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 18/29] hw/arm: Express
 dependencies of allwinner / cubieboard with Kconfig
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

Add dependencies for the Cubitech Cubieboard.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 6 +-----
 hw/arm/Kconfig                  | 9 +++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index c86a9f5427..a0b9016e3a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -7,6 +7,7 @@ CONFIG_ARM_V7M=3Dy
 # CONFIG_TEST_DEVICES=3Dn
=20
 CONFIG_ARM_VIRT=3Dy
+CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
 CONFIG_INTEGRATOR=3Dy
@@ -32,7 +33,6 @@ CONFIG_NETDUINO2=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
-CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
=20
 CONFIG_FRAMEBUFFER=3Dy
@@ -60,10 +60,6 @@ CONFIG_IOTKIT_SYSINFO=3Dy
 CONFIG_ARMSSE_CPUID=3Dy
 CONFIG_ARMSSE_MHU=3Dy
=20
-CONFIG_ALLWINNER_A10_PIT=3Dy
-CONFIG_ALLWINNER_A10_PIC=3Dy
-CONFIG_ALLWINNER_A10=3Dy
-
 CONFIG_FSL_IMX6=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 49306d6419..2ef5696900 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -25,6 +25,10 @@ config CHEETAH
     select OMAP
     select TSC210X
=20
+config CUBIEBOARD
+    bool
+    select ALLWINNER_A10
+
 config DIGIC
     bool
     select PTIMER
@@ -245,6 +249,11 @@ config ARM_V7M
=20
 config ALLWINNER_A10
     bool
+    select AHCI
+    select ALLWINNER_A10_PIT
+    select ALLWINNER_A10_PIC
+    select ALLWINNER_EMAC
+    select SERIAL
=20
 config RASPI
     bool
--=20
2.21.0
