Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803BBC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AC22087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AC22087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5PRf-00075W-MF
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 03:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5PN7-0002NN-4F
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5PN5-0006n4-Je
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:06:28 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:40204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5PN5-0006ll-Db
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:06:27 -0400
Received: from player690.ha.ovh.net (unknown [10.108.57.153])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8A64D18C342
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 09:06:25 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id E214094DCBEF;
 Wed,  4 Sep 2019 07:06:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 09:05:05 +0200
Message-Id: <20190904070506.1052-10-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904070506.1052-1-clg@kaod.org>
References: <20190904070506.1052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7093450890386901777
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgedgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.162.229
Subject: [Qemu-devel] [PATCH 09/10] aspeed/scu: Introduce per-SoC SCU types
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

and use a class AspeedSCUClass to define each SoC characteristics.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_scu.h | 15 +++++++
 hw/arm/aspeed_soc.c          |  3 +-
 hw/misc/aspeed_scu.c         | 83 ++++++++++++++++++++----------------
 3 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 38996adc59fe..90dd4dadedeb 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -15,6 +15,8 @@
=20
 #define TYPE_ASPEED_SCU "aspeed.scu"
 #define ASPEED_SCU(obj) OBJECT_CHECK(AspeedSCUState, (obj), TYPE_ASPEED_=
SCU)
+#define TYPE_ASPEED_2400_SCU TYPE_ASPEED_SCU "-ast2400"
+#define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
=20
 #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)
=20
@@ -45,6 +47,19 @@ typedef struct AspeedSCUState {
=20
 extern bool is_supported_silicon_rev(uint32_t silicon_rev);
=20
+#define ASPEED_SCU_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedSCUClass, (klass), TYPE_ASPEED_SCU)
+#define ASPEED_SCU_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedSCUClass, (obj), TYPE_ASPEED_SCU)
+
+typedef struct  AspeedSCUClass {
+    SysBusDeviceClass parent_class;
+
+    const uint32_t *resets;
+    uint32_t (*calc_hpll)(AspeedSCUState *s);
+    uint32_t apb_divider;
+}  AspeedSCUClass;
+
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
=20
 /*
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index da508c99c335..cf1d0cf921ba 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -161,8 +161,9 @@ static void aspeed_soc_init(Object *obj)
                                 &error_abort, NULL);
     }
=20
+    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
     sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
-                          TYPE_ASPEED_SCU);
+                          typename);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 268cb24e565c..d284458b9b3d 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -166,23 +166,10 @@ static uint32_t aspeed_scu_get_random(void)
=20
 static void aspeed_scu_set_apb_freq(AspeedSCUState *s)
 {
-    uint32_t apb_divider;
-
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        apb_divider =3D 2;
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        apb_divider =3D 4;
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(s);
=20
     s->apb_freq =3D s->hpll / (SCU_CLK_GET_PCLK_DIV(s->regs[CLK_SEL]) + =
1)
-        / apb_divider;
+        / asc->apb_divider;
 }
=20
 static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned si=
ze)
@@ -303,7 +290,7 @@ static const uint32_t hpll_ast2400_freqs[][4] =3D {
     { 400, 375, 350, 425 }, /* 25MHz */
 };
=20
-static uint32_t aspeed_scu_calc_hpll_ast2400(AspeedSCUState *s)
+static uint32_t aspeed_2400_scu_calc_hpll(AspeedSCUState *s)
 {
     uint32_t hpll_reg =3D s->regs[HPLL_PARAM];
     uint8_t freq_select;
@@ -334,7 +321,7 @@ static uint32_t aspeed_scu_calc_hpll_ast2400(AspeedSC=
UState *s)
     return hpll_ast2400_freqs[clk_25m_in][freq_select] * 1000000;
 }
=20
-static uint32_t aspeed_scu_calc_hpll_ast2500(AspeedSCUState *s)
+static uint32_t aspeed_2500_scu_calc_hpll(AspeedSCUState *s)
 {
     uint32_t hpll_reg   =3D s->regs[HPLL_PARAM];
     uint32_t multiplier =3D 1;
@@ -357,25 +344,9 @@ static uint32_t aspeed_scu_calc_hpll_ast2500(AspeedS=
CUState *s)
 static void aspeed_scu_reset(DeviceState *dev)
 {
     AspeedSCUState *s =3D ASPEED_SCU(dev);
-    const uint32_t *reset;
-    uint32_t (*calc_hpll)(AspeedSCUState *s);
-
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        reset =3D ast2400_a0_resets;
-        calc_hpll =3D aspeed_scu_calc_hpll_ast2400;
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        reset =3D ast2500_a1_resets;
-        calc_hpll =3D aspeed_scu_calc_hpll_ast2500;
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);
=20
-    memcpy(s->regs, reset, sizeof(s->regs));
+    memcpy(s->regs, asc->resets, sizeof(s->regs));
     s->regs[SILICON_REV] =3D s->silicon_rev;
     s->regs[HW_STRAP1] =3D s->hw_strap1;
     s->regs[HW_STRAP2] =3D s->hw_strap2;
@@ -385,7 +356,7 @@ static void aspeed_scu_reset(DeviceState *dev)
      * All registers are set. Now compute the frequencies of the main cl=
ocks
      */
     s->clkin =3D aspeed_scu_get_clkin(s);
-    s->hpll =3D calc_hpll(s);
+    s->hpll =3D asc->calc_hpll(s);
     aspeed_scu_set_apb_freq(s);
 }
=20
@@ -459,11 +430,51 @@ static const TypeInfo aspeed_scu_info =3D {
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(AspeedSCUState),
     .class_init =3D aspeed_scu_class_init,
+    .class_size    =3D sizeof(AspeedSCUClass),
+    .abstract      =3D true,
+};
+
+static void aspeed_2400_scu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2400 System Control Unit";
+    asc->resets =3D ast2400_a0_resets;
+    asc->calc_hpll =3D aspeed_2400_scu_calc_hpll;
+    asc->apb_divider =3D 2;
+}
+
+static const TypeInfo aspeed_2400_scu_info =3D {
+    .name =3D TYPE_ASPEED_2400_SCU,
+    .parent =3D TYPE_ASPEED_SCU,
+    .instance_size =3D sizeof(AspeedSCUState),
+    .class_init =3D aspeed_2400_scu_class_init,
+};
+
+static void aspeed_2500_scu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2500 System Control Unit";
+    asc->resets =3D ast2500_a1_resets;
+    asc->calc_hpll =3D aspeed_2500_scu_calc_hpll;
+    asc->apb_divider =3D 4;
+}
+
+static const TypeInfo aspeed_2500_scu_info =3D {
+    .name =3D TYPE_ASPEED_2500_SCU,
+    .parent =3D TYPE_ASPEED_SCU,
+    .instance_size =3D sizeof(AspeedSCUState),
+    .class_init =3D aspeed_2500_scu_class_init,
 };
=20
 static void aspeed_scu_register_types(void)
 {
     type_register_static(&aspeed_scu_info);
+    type_register_static(&aspeed_2400_scu_info);
+    type_register_static(&aspeed_2500_scu_info);
 }
=20
 type_init(aspeed_scu_register_types);
--=20
2.21.0


