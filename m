Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C4C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207D220643
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207D220643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBhy-0004Ho-77
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:24:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBOQ-0004f5-Vo
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBON-0002s3-3T
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBO3-0002gF-KM; Thu, 18 Apr 2019 14:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AA6E300250C;
	Thu, 18 Apr 2019 18:03:50 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA0C1001F52;
	Thu, 18 Apr 2019 18:03:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:46 +0200
Message-Id: <20190418180057.3593-19-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 18 Apr 2019 18:03:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 18/29] hw/arm: Express
 dependencies of allwinner / cubieboard with Kconfig
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
Message-ID: <20190418180046.Zf_xKMxRgvAfeWyK4QZCocPFC7Lb8-viNn7_NqJQjU8@z>

Add dependencies for the Cubitech Cubieboard.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 6 +-----
 hw/arm/Kconfig                  | 9 +++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index c86a9f5427..a0b9016e3a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -7,6 +7,7 @@ CONFIG_ARM_V7M=3Dy
 # CONFIG_TEST_DEVICES=3Dn
=20
 CONFIG_ARM_VIRT=3Dy
+CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
 CONFIG_INTEGRATOR=3Dy
@@ -32,7 +33,6 @@ CONFIG_NETDUINO2=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
-CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
=20
 CONFIG_FRAMEBUFFER=3Dy
@@ -60,10 +60,6 @@ CONFIG_IOTKIT_SYSINFO=3Dy
 CONFIG_ARMSSE_CPUID=3Dy
 CONFIG_ARMSSE_MHU=3Dy
=20
-CONFIG_ALLWINNER_A10_PIT=3Dy
-CONFIG_ALLWINNER_A10_PIC=3Dy
-CONFIG_ALLWINNER_A10=3Dy
-
 CONFIG_FSL_IMX6=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 49306d6419..2ef5696900 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -25,6 +25,10 @@ config CHEETAH
     select OMAP
     select TSC210X
=20
+config CUBIEBOARD
+    bool
+    select ALLWINNER_A10
+
 config DIGIC
     bool
     select PTIMER
@@ -245,6 +249,11 @@ config ARM_V7M
=20
 config ALLWINNER_A10
     bool
+    select AHCI
+    select ALLWINNER_A10_PIT
+    select ALLWINNER_A10_PIC
+    select ALLWINNER_EMAC
+    select SERIAL
=20
 config RASPI
     bool
--=20
2.21.0


