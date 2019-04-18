Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C04EC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D0120643
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D0120643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45389 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBfY-0002Cb-Fx
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:21:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBPs-0005ru-Gu
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBPp-0003rK-5W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:05:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBPg-0003eL-H1; Thu, 18 Apr 2019 14:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B9F3C1306EC;
	Thu, 18 Apr 2019 18:05:20 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 493741018A10;
	Thu, 18 Apr 2019 18:04:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:52 +0200
Message-Id: <20190418180057.3593-25-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 18 Apr 2019 18:05:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 24/29] hw/arm: Express
 dependencies for remaining IMX boards with Kconfig
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418180052.UDQDATKk_J67FUWoFJKl5oIniP5t68oaYsB4bRjeEdA@z>

IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.

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
index f5cd63860d..58439c492a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -283,6 +283,10 @@ config XLNX_VERSAL
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
@@ -296,6 +300,7 @@ config FSL_IMX6
     select A9MPCORE
     select IMX
     select IMX_I2C
+    select SDHCI
=20
 config ASPEED_SOC
     bool
@@ -321,12 +326,26 @@ config MPS2
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


