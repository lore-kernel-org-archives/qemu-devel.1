Received: from eggs.gnu.org ([209.51.188.92]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4Z-0004nh-53
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS4X-0002Lk-VL
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:05 +0100
Message-Id: <1550908162-22644-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/30] hw/arm: Express dependencies of the
 PXA2xx machines with Kconfig
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

Add Kconfig dependencies for the PXA2xx machines (akita, borzoi,
connex and verdex gumstix, tosa, mainstone, spitz, terrier and z2).
This patch is based on earlier work by =C3=81kos Kov=C3=A1cs (i.e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 15 +++++---------
 hw/arm/Kconfig                  | 43 +++++++++++++++++++++++++++++++++++=
++++++
 hw/arm/Makefile.objs            |  5 ++++-
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index d6858c3..cba62ba 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -16,22 +16,20 @@ CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
 CONFIG_VERSATILE=3Dy
 CONFIG_VEXPRESS=3Dy
+CONFIG_MAINSTONE=3Dy
+CONFIG_GUMSTIX=3Dy
+CONFIG_SPITZ=3Dy
+CONFIG_TOSA=3Dy
+CONFIG_Z2=3Dy
=20
 CONFIG_VGA=3Dy
-CONFIG_NAND=3Dy
-CONFIG_ECC=3Dy
-CONFIG_SERIAL=3Dy
-CONFIG_MAX7310=3Dy
 CONFIG_TMP421=3Dy
 CONFIG_PCA9552=3Dy
-CONFIG_ADS7846=3Dy
-CONFIG_MAX111X=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
 CONFIG_FTGMAC100=3Dy
 CONFIG_DS1338=3Dy
-CONFIG_MICRODRIVE=3Dy
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
=20
@@ -39,16 +37,13 @@ CONFIG_NETDUINO2=3Dy
=20
 CONFIG_PL330=3Dy
 CONFIG_CADENCE=3Dy
-CONFIG_PXA2XX=3Dy
 CONFIG_FRAMEBUFFER=3Dy
 CONFIG_XILINX_SPIPS=3Dy
 CONFIG_ZYNQ_DEVCFG=3Dy
=20
 CONFIG_DIGIC=3Dy
-CONFIG_MAINSTONE=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
-CONFIG_ZAURUS=3Dy
 CONFIG_ZYNQ=3Dy
 CONFIG_STM32F2XX_TIMER=3Dy
 CONFIG_STM32F2XX_USART=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 62ab487..fd6b92c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -50,6 +50,9 @@ config INTEGRATOR
=20
 config MAINSTONE
     bool
+    select PXA2XX
+    select PFLASH_CFI01
+    select SMC91C111
=20
 config MUSCA
     bool
@@ -92,6 +95,44 @@ config OMAP
=20
 config PXA2XX
     bool
+    select FRAMEBUFFER
+    select I2C
+    select PCI
+    select SERIAL
+    select SD
+    select SSI
+    select USB_OHCI
+
+config GUMSTIX
+    bool
+    select PFLASH_CFI01
+    select SMC91C111
+    select PXA2XX
+
+config TOSA
+    bool
+    select ZAURUS  # scoop
+    select MICRODRIVE
+    select PXA2XX
+
+config SPITZ
+    bool
+    select ADS7846 # display
+    select MAX111X # A/D converter
+    select WM8750  # audio codec
+    select MAX7310 # GPIO expander
+    select ZAURUS  # scoop
+    select NAND    # memory
+    select ECC     # Error-correcting for NAND
+    select MICRODRIVE
+    select PXA2XX
+
+config Z2
+    bool
+    select PFLASH_CFI01
+    select WM8750
+    select PL011 # UART
+    select PXA2XX
=20
 config REALVIEW
     bool
@@ -230,6 +271,8 @@ config MSF2
=20
 config ZAURUS
     bool
+    select NAND
+    select ECC
=20
 config A9MPCORE
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index bd0b45a..00328d1 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -11,7 +11,10 @@ obj-$(CONFIG_NETDUINO2) +=3D netduino2.o
 obj-$(CONFIG_NSERIES) +=3D nseries.o
 obj-$(CONFIG_SX1) +=3D omap_sx1.o
 obj-$(CONFIG_CHEETAH) +=3D palm.o
-obj-$(CONFIG_PXA2XX) +=3D gumstix.o spitz.o tosa.o z2.o
+obj-$(CONFIG_GUMSTIX) +=3D gumstix.o
+obj-$(CONFIG_SPITZ) +=3D spitz.o
+obj-$(CONFIG_TOSA) +=3D tosa.o
+obj-$(CONFIG_Z2) +=3D z2.o
 obj-$(CONFIG_REALVIEW) +=3D realview.o
 obj-$(CONFIG_STELLARIS) +=3D stellaris.o
 obj-$(CONFIG_STRONGARM) +=3D collie.o
--=20
1.8.3.1
