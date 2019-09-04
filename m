Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE610C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF05522CEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF05522CEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5PTy-0000xm-Ru
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 03:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5PMX-0001bN-7M
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5PMV-0006Nj-QY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:53 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:42396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5PMV-0006Mf-Kq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:51 -0400
Received: from player690.ha.ovh.net (unknown [10.109.143.18])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1BCE4226066
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 09:05:49 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id D662E94DC838;
 Wed,  4 Sep 2019 07:05:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 09:05:00 +0200
Message-Id: <20190904070506.1052-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904070506.1052-1-clg@kaod.org>
References: <20190904070506.1052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7083317792215501585
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgedgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.98
Subject: [Qemu-devel] [PATCH 04/10] aspeed: Use consistent typenames
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

Improve the naming of the different controller models to ease their
generation when initializing the SoC. The rename of the SMC types is
breaking migration compatibility.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  3 ---
 hw/arm/aspeed_soc.c         | 25 ++++++++++++-------------
 hw/ssi/aspeed_smc.c         | 12 ++++++------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a56effebc16e..ab5052b12cb5 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -61,9 +61,6 @@ typedef struct AspeedSoCInfo {
     uint32_t silicon_rev;
     uint64_t sram_size;
     int spis_num;
-    const char *fmc_typename;
-    const char **spi_typename;
-    const char *gpio_typename;
     int wdts_num;
     const int *irqmap;
     const hwaddr *memmap;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 3aa73d2438ef..25dbc409d358 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -112,10 +112,6 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
=20
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
=20
-static const char *aspeed_soc_ast2400_typenames[] =3D { "aspeed.smc.spi"=
 };
-static const char *aspeed_soc_ast2500_typenames[] =3D {
-    "aspeed.smc.ast2500-spi1", "aspeed.smc.ast2500-spi2" };
-
 static const AspeedSoCInfo aspeed_socs[] =3D {
     {
         .name         =3D "ast2400-a1",
@@ -123,9 +119,6 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .silicon_rev  =3D AST2400_A1_SILICON_REV,
         .sram_size    =3D 0x8000,
         .spis_num     =3D 1,
-        .fmc_typename =3D "aspeed.smc.fmc",
-        .spi_typename =3D aspeed_soc_ast2400_typenames,
-        .gpio_typename =3D "aspeed.gpio-ast2400",
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
         .memmap       =3D aspeed_soc_ast2400_memmap,
@@ -136,9 +129,6 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .silicon_rev  =3D AST2500_A1_SILICON_REV,
         .sram_size    =3D 0x9000,
         .spis_num     =3D 2,
-        .fmc_typename =3D "aspeed.smc.ast2500-fmc",
-        .spi_typename =3D aspeed_soc_ast2500_typenames,
-        .gpio_typename =3D "aspeed.gpio-ast2500",
         .wdts_num     =3D 3,
         .irqmap       =3D aspeed_soc_ast2500_irqmap,
         .memmap       =3D aspeed_soc_ast2500_memmap,
@@ -158,6 +148,12 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCState *s =3D ASPEED_SOC(obj);
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
     int i;
+    char socname[8];
+    char typename[64];
+
+    if (sscanf(sc->info->name, "%7s", socname) !=3D 1) {
+        g_assert_not_reached();
+    }
=20
     for (i =3D 0; i < sc->info->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
@@ -190,14 +186,16 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
                           TYPE_ASPEED_I2C);
=20
+    snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
-                          sc->info->fmc_typename);
+                          typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
=20
     for (i =3D 0; i < sc->info->spis_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, s=
ocname);
         sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
-                              sizeof(s->spi[i]), sc->info->spi_typename[=
i]);
+                              sizeof(s->spi[i]), typename);
     }
=20
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc)=
,
@@ -226,8 +224,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma)=
,
                           TYPE_ASPEED_XDMA);
=20
+    snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio)=
,
-                          sc->info->gpio_typename);
+                          typename);
 }
=20
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9f3cff5fb6f5..f4f7c1818307 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -190,7 +190,7 @@ static const AspeedSegments aspeed_segments_ast2500_s=
pi2[] =3D {
=20
 static const AspeedSMCController controllers[] =3D {
     {
-        .name              =3D "aspeed.smc.smc",
+        .name              =3D "aspeed.smc-ast2400",
         .r_conf            =3D R_CONF,
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
@@ -203,7 +203,7 @@ static const AspeedSMCController controllers[] =3D {
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_SMC_MAX,
     }, {
-        .name              =3D "aspeed.smc.fmc",
+        .name              =3D "aspeed.fmc-ast2400",
         .r_conf            =3D R_CONF,
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
@@ -216,7 +216,7 @@ static const AspeedSMCController controllers[] =3D {
         .has_dma           =3D true,
         .nregs             =3D ASPEED_SMC_R_MAX,
     }, {
-        .name              =3D "aspeed.smc.spi",
+        .name              =3D "aspeed.spi1-ast2400",
         .r_conf            =3D R_SPI_CONF,
         .r_ce_ctrl         =3D 0xff,
         .r_ctrl0           =3D R_SPI_CTRL0,
@@ -229,7 +229,7 @@ static const AspeedSMCController controllers[] =3D {
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_SPI_MAX,
     }, {
-        .name              =3D "aspeed.smc.ast2500-fmc",
+        .name              =3D "aspeed.fmc-ast2500",
         .r_conf            =3D R_CONF,
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
@@ -242,7 +242,7 @@ static const AspeedSMCController controllers[] =3D {
         .has_dma           =3D true,
         .nregs             =3D ASPEED_SMC_R_MAX,
     }, {
-        .name              =3D "aspeed.smc.ast2500-spi1",
+        .name              =3D "aspeed.spi1-ast2500",
         .r_conf            =3D R_CONF,
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
@@ -255,7 +255,7 @@ static const AspeedSMCController controllers[] =3D {
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_MAX,
     }, {
-        .name              =3D "aspeed.smc.ast2500-spi2",
+        .name              =3D "aspeed.spi2-ast2500",
         .r_conf            =3D R_CONF,
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
--=20
2.21.0


