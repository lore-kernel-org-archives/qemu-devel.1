Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B1CC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5972080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5972080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLN7K-0004sk-2x
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:23:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMzx-0007FO-Rx
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMzw-0004mA-QL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hLMzp-0004jd-Gj; Tue, 30 Apr 2019 03:16:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DB4A30ADBBA;
	Tue, 30 Apr 2019 07:16:08 +0000 (UTC)
Received: from thuth.com (ovpn-116-190.ams2.redhat.com [10.36.116.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD55B1001E85;
	Tue, 30 Apr 2019 07:15:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Tue, 30 Apr 2019 09:13:45 +0200
Message-Id: <20190430071405.16714-11-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 30 Apr 2019 07:16:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 10/30] hw/arm: Express dependencies of the
 OMAP machines with Kconfig
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
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Rob Herring <robh@kernel.org>, qemu-block@nongnu.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>,
	John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Andrew Jeffery <andrew@aj.id.au>, Peter Chubb <peter.chubb@nicta.com.au>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430071345.MaDPv-US0FBuaY_VBYxyKlLczCJ9fC8pPSQn_R-GooA@z>

Add Kconfig dependencies for the OMAP machines (cheetah, n800, n810,
sx1 and sx1-v1).
This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs (i.=
e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 17 ++++-------------
 hw/arm/Kconfig                  | 25 +++++++++++++++++++++++++
 hw/arm/Makefile.objs            |  3 ++-
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 0a4d293f8a..b7ed3c530b 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -12,16 +12,16 @@ CONFIG_HIGHBANK=3Dy
 CONFIG_INTEGRATOR=3Dy
 CONFIG_FSL_IMX31=3Dy
 CONFIG_MUSICPAL=3Dy
+CONFIG_MUSCA=3Dy
+CONFIG_CHEETAH=3Dy
+CONFIG_SX1=3Dy
+CONFIG_NSERIES=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_NAND=3Dy
 CONFIG_ECC=3Dy
 CONFIG_SERIAL=3Dy
 CONFIG_MAX7310=3Dy
-CONFIG_TWL92230=3Dy
-CONFIG_TSC2005=3Dy
-CONFIG_LM832X=3Dy
-CONFIG_TMP105=3Dy
 CONFIG_TMP421=3Dy
 CONFIG_PCA9552=3Dy
 CONFIG_STELLARIS=3Dy
@@ -39,9 +39,7 @@ CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
 CONFIG_FTGMAC100=3Dy
 CONFIG_DS1338=3Dy
-CONFIG_PFLASH_CFI01=3Dy
 CONFIG_MICRODRIVE=3Dy
-CONFIG_USB_MUSB=3Dy
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
=20
@@ -61,15 +59,8 @@ CONFIG_ZYNQ_DEVCFG=3Dy
=20
 CONFIG_ARM11SCU=3Dy
 CONFIG_DIGIC=3Dy
-CONFIG_OMAP=3Dy
-CONFIG_TSC210X=3Dy
-CONFIG_BLIZZARD=3Dy
-CONFIG_ONENAND=3Dy
-CONFIG_TUSB6010=3Dy
 CONFIG_MAINSTONE=3Dy
 CONFIG_MPS2=3Dy
-CONFIG_MUSCA=3Dy
-CONFIG_NSERIES=3Dy
 CONFIG_RASPI=3Dy
 CONFIG_REALVIEW=3Dy
 CONFIG_ZAURUS=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b9f3c3c232..71126254ff 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -2,6 +2,11 @@ config ARM_VIRT
     bool
     imply VFIO_PLATFORM
=20
+config CHEETAH
+    bool
+    select OMAP
+    select TSC210X
+
 config DIGIC
     bool
     select PTIMER
@@ -58,9 +63,25 @@ config NETDUINO2
=20
 config NSERIES
     bool
+    select OMAP
+    select TMP105   # tempature sensor
+    select BLIZZARD # LCD/TV controller
+    select ONENAND
+    select TSC210X  # touchscreen/sensors/audio
+    select TSC2005  # touchscreen/sensors/keypad
+    select LM832X   # GPIO keyboard chip
+    select TWL92230 # energy-management
+    select TUSB6010
=20
 config OMAP
     bool
+    select FRAMEBUFFER
+    select I2C
+    select ECC
+    select NAND
+    select PFLASH_CFI01
+    select SD
+    select SERIAL
=20
 config PXA2XX
     bool
@@ -74,6 +95,10 @@ config STELLARIS
 config STRONGARM
     bool
=20
+config SX1
+    bool
+    select OMAP
+
 config VERSATILE
     bool
=20
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fa57c7c770..8302b8df1d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -9,7 +9,8 @@ obj-$(CONFIG_MAINSTONE) +=3D mainstone.o
 obj-$(CONFIG_MUSICPAL) +=3D musicpal.o
 obj-$(CONFIG_NETDUINO2) +=3D netduino2.o
 obj-$(CONFIG_NSERIES) +=3D nseries.o
-obj-$(CONFIG_OMAP) +=3D omap_sx1.o palm.o
+obj-$(CONFIG_SX1) +=3D omap_sx1.o
+obj-$(CONFIG_CHEETAH) +=3D palm.o
 obj-$(CONFIG_PXA2XX) +=3D gumstix.o spitz.o tosa.o z2.o
 obj-$(CONFIG_REALVIEW) +=3D realview.o
 obj-$(CONFIG_STELLARIS) +=3D stellaris.o
--=20
2.21.0


