Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F136C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ED8218CD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ED8218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBS3-0007G1-G2
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:07:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBNT-0003q2-3Y
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBNR-0002Qg-Te
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBNI-0002Il-Bv; Thu, 18 Apr 2019 14:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B8483078DDD;
	Thu, 18 Apr 2019 18:03:01 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33FCF1001DC8;
	Thu, 18 Apr 2019 18:02:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:40 +0200
Message-Id: <20190418180057.3593-13-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 18 Apr 2019 18:03:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 12/29] hw/arm: Express
 dependencies of the PXA2xx machines with Kconfig
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Rob Herring <robh@kernel.org>, qemu-block@nongnu.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418180040.CDHtVgPpd-GWioQPowsevu2ZsOJ7hy4uMC6XERornso@z>

Add Kconfig dependencies for the PXA2xx machines (akita, borzoi,
connex and verdex gumstix, tosa, mainstone, spitz, terrier and z2).
This patch is based on earlier work by =C3=81kos Kov=C3=A1cs (i.e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 15 ++++--------
 hw/arm/Kconfig                  | 42 +++++++++++++++++++++++++++++++++
 hw/arm/Makefile.objs            |  5 +++-
 3 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index df7d9421e0..f39a854f2e 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -19,22 +19,20 @@ CONFIG_STELLARIS=3Dy
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
@@ -42,16 +40,13 @@ CONFIG_NETDUINO2=3Dy
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
index b786cfc5bd..101de74260 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -48,6 +48,9 @@ config INTEGRATOR
=20
 config MAINSTONE
     bool
+    select PXA2XX
+    select PFLASH_CFI01
+    select SMC91C111
=20
 config MUSICPAL
     bool
@@ -85,6 +88,43 @@ config OMAP
=20
 config PXA2XX
     bool
+    select FRAMEBUFFER
+    select I2C
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
@@ -217,6 +257,8 @@ config MSF2
=20
 config ZAURUS
     bool
+    select NAND
+    select ECC
=20
 config A9MPCORE
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index bd0b45a799..00328d1b0b 100644
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
2.21.0


