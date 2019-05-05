Received: from eggs.gnu.org ([209.51.188.92]:56248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHeT-0004dt-MB
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHeS-00052Y-BS
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:58:01 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun,  5 May 2019 15:57:09 +0200
Message-Id: <20190505135714.11277-24-thuth@redhat.com>
In-Reply-To: <20190505135714.11277-1-thuth@redhat.com>
References: <20190505135714.11277-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/28] hw/arm: Express dependencies of the
 remaining IMX boards with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 --
 hw/arm/Kconfig                  | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 1455d083d8..6dc388c43e 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -37,7 +37,6 @@ CONFIG_SABRELITE=3Dy
 CONFIG_EMCRAFT_SF2=3Dy
=20
 CONFIG_VGA=3Dy
-CONFIG_IMX_FEC=3Dy
=20
 CONFIG_NRF51_SOC=3Dy
=20
@@ -49,4 +48,3 @@ CONFIG_PCIE_PORT=3Dy
 CONFIG_XIO3130=3Dy
 CONFIG_IOH3420=3Dy
 CONFIG_I82801B11=3Dy
-CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7af94a8184..4a14749792 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -285,6 +285,10 @@ config XLNX_VERSAL
=20
 config FSL_IMX25
     bool
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select DS1338
=20
 config FSL_IMX31
     bool
@@ -299,6 +303,7 @@ config FSL_IMX6
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select SDHCI
=20
 config ASPEED_SOC
     bool
@@ -324,12 +329,26 @@ config MPS2
=20
 config FSL_IMX7
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select A15MPCORE
+    select PCI
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select PCI_EXPRESS_DESIGNWARE
+    select SDHCI
=20
 config ARM_SMMUV3
     bool
=20
 config FSL_IMX6UL
     bool
+    select A15MPCORE
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select SDHCI
=20
 config NRF51_SOC
     bool
--=20
2.21.0
