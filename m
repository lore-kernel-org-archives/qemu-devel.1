Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE5C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E40E20652
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E40E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBUz-0001Q3-Ni
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:11:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBMm-0003GG-11
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBMl-00022k-1u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBMd-0001ut-Bb; Thu, 18 Apr 2019 14:02:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 945213076C60;
	Thu, 18 Apr 2019 18:02:21 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5DE11001E9D;
	Thu, 18 Apr 2019 18:02:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:36 +0200
Message-Id: <20190418180057.3593-9-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 18 Apr 2019 18:02:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 08/29] hw/arm: Express
 dependencies of musicpal with Kconfig
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
Message-ID: <20190418180036.b2E1pUxw2RWUWhpdaosl0hrB-rvvA5ih2Jh_5_aSKtw@z>

This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs (i.=
e.
his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 6 +-----
 hw/arm/Kconfig                  | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 7f94811ccb..0a4d293f8a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -11,13 +11,13 @@ CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
 CONFIG_INTEGRATOR=3Dy
 CONFIG_FSL_IMX31=3Dy
+CONFIG_MUSICPAL=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_NAND=3Dy
 CONFIG_ECC=3Dy
 CONFIG_SERIAL=3Dy
 CONFIG_MAX7310=3Dy
-CONFIG_WM8750=3Dy
 CONFIG_TWL92230=3Dy
 CONFIG_TSC2005=3Dy
 CONFIG_LM832X=3Dy
@@ -40,7 +40,6 @@ CONFIG_IMX_FEC=3Dy
 CONFIG_FTGMAC100=3Dy
 CONFIG_DS1338=3Dy
 CONFIG_PFLASH_CFI01=3Dy
-CONFIG_PFLASH_CFI02=3Dy
 CONFIG_MICRODRIVE=3Dy
 CONFIG_USB_MUSB=3Dy
 CONFIG_PLATFORM_BUS=3Dy
@@ -56,14 +55,12 @@ CONFIG_PL190=3Dy
 CONFIG_PL330=3Dy
 CONFIG_CADENCE=3Dy
 CONFIG_PXA2XX=3Dy
-CONFIG_BITBANG_I2C=3Dy
 CONFIG_FRAMEBUFFER=3Dy
 CONFIG_XILINX_SPIPS=3Dy
 CONFIG_ZYNQ_DEVCFG=3Dy
=20
 CONFIG_ARM11SCU=3Dy
 CONFIG_DIGIC=3Dy
-CONFIG_MARVELL_88W8618=3Dy
 CONFIG_OMAP=3Dy
 CONFIG_TSC210X=3Dy
 CONFIG_BLIZZARD=3Dy
@@ -137,7 +134,6 @@ CONFIG_XILINX_AXI=3Dy
 CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
=20
 CONFIG_STRONGARM=3Dy
-CONFIG_MUSICPAL=3Dy
=20
 # for realview and versatilepb
 CONFIG_LSI_SCSI_PCI=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9087b7d714..b9f3c3c232 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -46,7 +46,12 @@ config MAINSTONE
=20
 config MUSICPAL
     bool
+    select BITBANG_I2C
+    select MARVELL_88W8618
     select PTIMER
+    select PFLASH_CFI02
+    select SERIAL
+    select WM8750
=20
 config NETDUINO2
     bool
--=20
2.21.0


