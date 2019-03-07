Received: from eggs.gnu.org ([209.51.188.92]:43900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tsp-0005LR-NN
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tsp-0000MK-3t
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:20:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Mar 2019 15:18:35 +0100
Message-Id: <1551968334-18982-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1551968334-18982-1-git-send-email-thuth@redhat.com>
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 10/29] hw/arm: Express dependencies of
 stellaris with Kconfig
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

This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs (i.=
e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  7 +------
 hw/arm/Kconfig                  | 10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 2c07f5c..46ec4eb 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -14,6 +14,7 @@ CONFIG_MUSCA=3Dy
 CONFIG_CHEETAH=3Dy
 CONFIG_SX1=3Dy
 CONFIG_NSERIES=3Dy
+CONFIG_STELLARIS=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_NAND=3Dy
@@ -22,16 +23,10 @@ CONFIG_SERIAL=3Dy
 CONFIG_MAX7310=3Dy
 CONFIG_TMP421=3Dy
 CONFIG_PCA9552=3Dy
-CONFIG_STELLARIS=3Dy
-CONFIG_STELLARIS_INPUT=3Dy
-CONFIG_STELLARIS_ENET=3Dy
-CONFIG_SSD0303=3Dy
-CONFIG_SSD0323=3Dy
 CONFIG_DDC=3Dy
 CONFIG_SII9022=3Dy
 CONFIG_ADS7846=3Dy
 CONFIG_MAX111X=3Dy
-CONFIG_SSI_SD=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index cfb3ab1..cb19fd3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -96,6 +96,16 @@ config REALVIEW
=20
 config STELLARIS
     bool
+    select ARM_V7M
+    select I2C
+    select PL011 # UART
+    select PL022 # Serial port
+    select PL061 # GPIO
+    select SSD0303 # OLED display
+    select SSD0323 # OLED display
+    select SSI_SD
+    select STELLARIS_INPUT
+    select STELLARIS_ENET # ethernet
=20
 config STRONGARM
     bool
--=20
1.8.3.1
