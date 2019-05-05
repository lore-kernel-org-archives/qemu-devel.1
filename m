Received: from eggs.gnu.org ([209.51.188.92]:55976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHeB-0004JC-79
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHe9-0004ou-Sw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:42 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun,  5 May 2019 15:57:00 +0200
Message-Id: <20190505135714.11277-15-thuth@redhat.com>
In-Reply-To: <20190505135714.11277-1-thuth@redhat.com>
References: <20190505135714.11277-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/28] hw/arm: Express dependencies of the
 aspeed boards with Kconfig
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

Dependencies have been determined by looking at hw/arm/aspeed.c

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  7 +------
 hw/arm/Kconfig                  | 10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 25e8f717ac..2580584281 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -26,15 +26,12 @@ CONFIG_SPITZ=3Dy
 CONFIG_TOSA=3Dy
 CONFIG_Z2=3Dy
 CONFIG_COLLIE=3Dy
+CONFIG_ASPEED_SOC=3Dy
=20
 CONFIG_VGA=3Dy
-CONFIG_TMP421=3Dy
-CONFIG_PCA9552=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
-CONFIG_FTGMAC100=3Dy
-CONFIG_DS1338=3Dy
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
=20
@@ -92,8 +89,6 @@ CONFIG_I82801B11=3Dy
 CONFIG_ACPI=3Dy
 CONFIG_ARM_VIRT=3Dy
 CONFIG_SMBIOS=3Dy
-CONFIG_ASPEED_SOC=3Dy
-CONFIG_SMBUS_EEPROM=3Dy
 CONFIG_GPIO_KEY=3Dy
 CONFIG_MSF2=3Dy
 CONFIG_FW_CFG_DMA=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a507144d9a..95ac0b540e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -255,6 +255,16 @@ config FSL_IMX6
=20
 config ASPEED_SOC
     bool
+    select DS1338
+    select FTGMAC100
+    select I2C
+    select PCA9552
+    select SERIAL
+    select SMBUS_EEPROM
+    select SSI
+    select SSI_M25P80
+    select TMP105
+    select TMP421
=20
 config MPS2
     bool
--=20
2.21.0
