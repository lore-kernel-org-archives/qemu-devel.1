Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49556208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49556208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dCA-0002il-2j
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cCu-0001Dm-Bh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cCt-00023E-27
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:48 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:45247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cCr-00020n-UH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:46 -0400
Received: from player691.ha.ovh.net (unknown [10.108.54.36])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0F36D130B4B
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:48:42 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id D498398B2998;
 Wed,  4 Sep 2019 20:48:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:57 +0200
Message-Id: <20190904204659.13878-14-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2533556269348457233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.131
Subject: [Qemu-devel] [RFC PATCH 13/15] aspeed: Parameterise number of MACs
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
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h | 5 ++++-
 hw/arm/aspeed_soc.c         | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 74db48374531..30b67a09f13c 100644
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
@@ -67,6 +67,7 @@ typedef struct AspeedSoCInfo {
     uint64_t sram_size;
     int spis_num;
     int wdts_num;
+    int macs_num;
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
@@ -117,6 +118,8 @@ enum {
     ASPEED_I2C,
     ASPEED_ETH1,
     ASPEED_ETH2,
+    ASPEED_ETH3,
+    ASPEED_ETH4,
     ASPEED_SDRAM,
     ASPEED_XDMA,
 };
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 80d7f206004c..8069de8d5a36 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -90,7 +90,9 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
     [ASPEED_SPI1]      =3D 0x1E630000,
     [ASPEED_SPI2]      =3D 0x1E641000,
     [ASPEED_ETH1]      =3D 0x1E660000,
+    [ASPEED_ETH3]      =3D 0x1E670000,
     [ASPEED_ETH2]      =3D 0x1E680000,
+    [ASPEED_ETH4]      =3D 0x1E690000,
     [ASPEED_VIC]       =3D 0x1E6C0000,
     [ASPEED_SDMC]      =3D 0x1E6E0000,
     [ASPEED_SCU]       =3D 0x1E6E2000,
@@ -190,6 +192,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .sram_size    =3D 0x8000,
         .spis_num     =3D 1,
         .wdts_num     =3D 2,
+        .macs_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
         .memmap       =3D aspeed_soc_ast2400_memmap,
         .num_cpus     =3D 1,
@@ -200,6 +203,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .sram_size    =3D 0x9000,
         .spis_num     =3D 2,
         .wdts_num     =3D 3,
+        .macs_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2500_irqmap,
         .memmap       =3D aspeed_soc_ast2500_memmap,
         .num_cpus     =3D 1,
@@ -210,6 +214,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .sram_size    =3D 0x10000,
         .spis_num     =3D 2,
         .wdts_num     =3D 4,
+        .macs_num     =3D 4,
         .irqmap       =3D aspeed_soc_ast2600_irqmap,
         .memmap       =3D aspeed_soc_ast2600_memmap,
         .num_cpus     =3D 2,
@@ -305,7 +310,7 @@ static void aspeed_soc_init(Object *obj)
                                        OBJECT(&s->scu), &error_abort);
     }
=20
-    for (i =3D 0; i < ASPEED_MACS_NUM; i++) {
+    for (i =3D 0; i < sc->info->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[=
i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
--=20
2.21.0


