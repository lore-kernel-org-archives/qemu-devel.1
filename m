Received: from eggs.gnu.org ([209.51.188.92]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN2w-0001Jg-LG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN2u-00061Z-Nu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:19:22 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 30 Apr 2019 09:14:02 +0200
Message-Id: <20190430071405.16714-28-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 27/30] hw/arm: Express dependencies of the
 ZynqMP zcu102 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Cedric Le Goater <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, qemu-block@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Andrey Smirnov <andrew.smirnov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

This cleans up most settings in default-configs/aarch64-softmmu.mak.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/aarch64-softmmu.mak |  4 ----
 hw/arm/Kconfig                      | 11 +++++++++++
 hw/display/Kconfig                  |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch6=
4-softmmu.mak
index 313490fb38..49ff415ee4 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -3,9 +3,5 @@
 # We support all the 32 bit boards so need all their config
 include arm-softmmu.mak
=20
-CONFIG_AUX=3Dy
-CONFIG_DDC=3Dy
-CONFIG_DPCD=3Dy
-CONFIG_XLNX_ZYNQMP=3Dy
 CONFIG_XLNX_ZYNQMP_ARM=3Dy
 CONFIG_XLNX_VERSAL=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index da091ac217..eff61efab9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -279,6 +279,17 @@ config STM32F205_SOC
=20
 config XLNX_ZYNQMP_ARM
     bool
+    select AHCI
+    select ARM_GIC
+    select CADENCE
+    select DDC
+    select DPCD
+    select SDHCI
+    select SSI
+    select SSI_M25P80
+    select XILINX_AXI
+    select XILINX_SPIPS
+    select XLNX_ZYNQMP
=20
 config XLNX_VERSAL
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 0577e68c8e..bb95f8d6a4 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -108,6 +108,7 @@ config VIRTIO_VGA
=20
 config DPCD
     bool
+    select AUX
=20
 config ATI_VGA
     bool
--=20
2.21.0
