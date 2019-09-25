Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E8C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8345921D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8345921D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8wQ-000130-Sx
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD8OO-0005er-4M
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD8OM-0001tX-US
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:43 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:56488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD8OM-0001sq-Nu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:42 -0400
Received: from player786.ha.ovh.net (unknown [10.109.146.82])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6726614325F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:35:40 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id D5334A4D4480;
 Wed, 25 Sep 2019 14:35:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 23/23] aspeed/soc: Add ASPEED Video stub
Date: Wed, 25 Sep 2019 16:32:48 +0200
Message-Id: <20190925143248.10000-24-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
References: <20190925143248.10000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8879972568535632657
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.46
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast2600.c     | 5 +++++
 hw/arm/aspeed_soc.c         | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 43478f617879..cccb684a19bb 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -96,6 +96,7 @@ enum {
     ASPEED_SDMC,
     ASPEED_SCU,
     ASPEED_ADC,
+    ASPEED_VIDEO,
     ASPEED_SRAM,
     ASPEED_SDHCI,
     ASPEED_GPIO,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index af047463a355..931887ac681f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -44,6 +44,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
     [ASPEED_SCU]       =3D 0x1E6E2000,
     [ASPEED_XDMA]      =3D 0x1E6E7000,
     [ASPEED_ADC]       =3D 0x1E6E9000,
+    [ASPEED_VIDEO]     =3D 0x1E700000,
     [ASPEED_SDHCI]     =3D 0x1E740000,
     [ASPEED_GPIO]      =3D 0x1E780000,
     [ASPEED_GPIO_1_8V] =3D 0x1E780800,
@@ -236,6 +237,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM=
],
                                 ASPEED_SOC_IOMEM_SIZE);
=20
+    /* Video engine stub */
+    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO]=
,
+                                0x1000);
+
     if (s->num_cpus > sc->num_cpus) {
         warn_report("%s: invalid number of CPUs %d, using default %d",
                     sc->name, s->num_cpus, sc->num_cpus);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 6defb143acde..f4fe243458fd 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -34,6 +34,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
     [ASPEED_SDMC]   =3D 0x1E6E0000,
     [ASPEED_SCU]    =3D 0x1E6E2000,
     [ASPEED_XDMA]   =3D 0x1E6E7000,
+    [ASPEED_VIDEO]  =3D 0x1E700000,
     [ASPEED_ADC]    =3D 0x1E6E9000,
     [ASPEED_SRAM]   =3D 0x1E720000,
     [ASPEED_SDHCI]  =3D 0x1E740000,
@@ -63,6 +64,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
     [ASPEED_SCU]    =3D 0x1E6E2000,
     [ASPEED_XDMA]   =3D 0x1E6E7000,
     [ASPEED_ADC]    =3D 0x1E6E9000,
+    [ASPEED_VIDEO]  =3D 0x1E700000,
     [ASPEED_SRAM]   =3D 0x1E720000,
     [ASPEED_SDHCI]  =3D 0x1E740000,
     [ASPEED_GPIO]   =3D 0x1E780000,
@@ -231,6 +233,10 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM=
],
                                 ASPEED_SOC_IOMEM_SIZE);
=20
+    /* Video engine stub */
+    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO]=
,
+                                0x1000);
+
     if (s->num_cpus > sc->num_cpus) {
         warn_report("%s: invalid number of CPUs %d, using default %d",
                     sc->name, s->num_cpus, sc->num_cpus);
--=20
2.21.0


