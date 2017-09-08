Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeD-0002FJ-MF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-0003L2-EU
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:44 +1000
Message-Id: <20170908103558.31632-27-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 26/40] ppc4xx_i2c: Move to hw/i2c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak    | 1 +
 default-configs/ppc64-softmmu.mak  | 1 +
 default-configs/ppcemb-softmmu.mak | 1 +
 hw/i2c/Makefile.objs               | 1 +
 hw/{ppc => i2c}/ppc4xx_i2c.c       | 0
 hw/ppc/Makefile.objs               | 2 +-
 6 files changed, 5 insertions(+), 1 deletion(-)
 rename hw/{ppc => i2c}/ppc4xx_i2c.c (100%)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 1f1cd85b12..d4d44eb66b 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PPC4XX=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index 46c9599321..af32589b38 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PPC4XX=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 94340de356..635923a166 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PPC4XX=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index a081b8ef2c..0594dea3ae 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -8,3 +8,4 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
 obj-$(CONFIG_OMAP) += omap_i2c.o
+obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
similarity index 100%
rename from hw/ppc/ppc4xx_i2c.c
rename to hw/i2c/ppc4xx_i2c.c
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 207721647a..7efc686748 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,7 +13,7 @@ endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-y += ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
-obj-y += ppc4xx_pci.o ppc4xx_i2c.o
+obj-y += ppc4xx_pci.o
 # PReP
 obj-$(CONFIG_PREP) += prep.o
 obj-$(CONFIG_PREP) += prep_systemio.o
-- 
2.13.5
