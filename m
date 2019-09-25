Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECFA21D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECFA21D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8iv-0003ah-QJ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD8OA-0005Mo-3P
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD8O8-0001j7-QV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:29 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:58635)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD8O8-0001iD-L8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:28 -0400
Received: from player786.ha.ovh.net (unknown [10.108.42.88])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 13CB579A60
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:35:27 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 87A94A4D4345;
 Wed, 25 Sep 2019 14:35:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 21/23] aspeed: Parameterise number of MACs
Date: Wed, 25 Sep 2019 16:32:46 +0200
Message-Id: <20190925143248.10000-22-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
References: <20190925143248.10000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8876031916005886737
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.61
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

To support the ast2600's four MACs allow SoCs to specify the number
they have, and create that many.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[clg: - included a check on sc->macs_num when realizing the macs
      - included interrupt definitions for the AST2600 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  5 ++++-
 hw/arm/aspeed_ast2600.c     | 10 ++++++++--
 hw/arm/aspeed_soc.c         |  6 ++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 67c59956f835..088a5d108185 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -30,7 +30,7 @@
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  4
 #define ASPEED_CPUS_NUM  2
-#define ASPEED_MACS_NUM  2
+#define ASPEED_MACS_NUM  4
=20
 typedef struct AspeedSoCState {
     /*< private >*/
@@ -69,6 +69,7 @@ typedef struct AspeedSoCClass {
     uint64_t sram_size;
     int spis_num;
     int wdts_num;
+    int macs_num;
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
@@ -114,6 +115,8 @@ enum {
     ASPEED_I2C,
     ASPEED_ETH1,
     ASPEED_ETH2,
+    ASPEED_ETH3,
+    ASPEED_ETH4,
     ASPEED_SDRAM,
     ASPEED_XDMA,
 };
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a4f0fafab7cb..25d2c2d05d63 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -32,7 +32,9 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
     [ASPEED_SPI1]      =3D 0x1E630000,
     [ASPEED_SPI2]      =3D 0x1E641000,
     [ASPEED_ETH1]      =3D 0x1E660000,
+    [ASPEED_ETH3]      =3D 0x1E670000,
     [ASPEED_ETH2]      =3D 0x1E680000,
+    [ASPEED_ETH4]      =3D 0x1E690000,
     [ASPEED_VIC]       =3D 0x1E6C0000,
     [ASPEED_SDMC]      =3D 0x1E6E0000,
     [ASPEED_SCU]       =3D 0x1E6E2000,
@@ -88,6 +90,9 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
     [ASPEED_I2C]       =3D 110,   /* 110 -> 125 */
     [ASPEED_ETH1]      =3D 2,
     [ASPEED_ETH2]      =3D 3,
+    [ASPEED_ETH3]      =3D 32,
+    [ASPEED_ETH4]      =3D 33,
+
 };
=20
 static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
@@ -173,7 +178,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
                                        OBJECT(&s->scu), &error_abort);
     }
=20
-    for (i =3D 0; i < ASPEED_MACS_NUM; i++) {
+    for (i =3D 0; i < sc->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[=
i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
@@ -397,7 +402,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
     }
=20
     /* Net */
-    for (i =3D 0; i < nb_nics; i++) {
+    for (i =3D 0; i < nb_nics && i < sc->macs_num; i++) {
         qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed=
",
                                  &err);
@@ -470,6 +475,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass=
 *oc, void *data)
     sc->sram_size    =3D 0x10000;
     sc->spis_num     =3D 2;
     sc->wdts_num     =3D 4;
+    sc->macs_num     =3D 4;
     sc->irqmap       =3D aspeed_soc_ast2600_irqmap;
     sc->memmap       =3D aspeed_soc_ast2600_memmap;
     sc->num_cpus     =3D 2;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a063be9fd795..6defb143acde 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -198,7 +198,7 @@ static void aspeed_soc_init(Object *obj)
                                        OBJECT(&s->scu), &error_abort);
     }
=20
-    for (i =3D 0; i < ASPEED_MACS_NUM; i++) {
+    for (i =3D 0; i < sc->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[=
i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
@@ -372,7 +372,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     }
=20
     /* Net */
-    for (i =3D 0; i < nb_nics; i++) {
+    for (i =3D 0; i < nb_nics && i < sc->macs_num; i++) {
         qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed=
",
                                  &err);
@@ -455,6 +455,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass=
 *oc, void *data)
     sc->sram_size    =3D 0x8000;
     sc->spis_num     =3D 1;
     sc->wdts_num     =3D 2;
+    sc->macs_num     =3D 2;
     sc->irqmap       =3D aspeed_soc_ast2400_irqmap;
     sc->memmap       =3D aspeed_soc_ast2400_memmap;
     sc->num_cpus     =3D 1;
@@ -478,6 +479,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass=
 *oc, void *data)
     sc->sram_size    =3D 0x9000;
     sc->spis_num     =3D 2;
     sc->wdts_num     =3D 3;
+    sc->macs_num     =3D 2;
     sc->irqmap       =3D aspeed_soc_ast2500_irqmap;
     sc->memmap       =3D aspeed_soc_ast2500_memmap;
     sc->num_cpus     =3D 1;
--=20
2.21.0


