Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6BCC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E13720854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWB+94uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3bf-0008Us-BQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qr-0005SI-FA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qq-0008Em-1d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qp-0008EF-RA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id a6so17835739wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KXSQWrkgVKujQgWAmEV6JwKVKd1aFY1WSRQmmAz+nVY=;
 b=jWB+94ujTc439fKVKwSIrrowL/39fs3zOhGyba2gJcdpgiVi1rY3pOYxhnTo2BoZKM
 mNPiFP76lMQUW40yviUDrbdSRKbbc/2BL29u3Xp0fTfTl3xqwYncLnpzAEQQOdpYvPCe
 bmvg8y9TscUZOcUdRRmh7Rgt0ZII+4bBgbdCdyKBqv60O1WDk2sbpNMXp7D9XAxfEtqY
 QKY1/7VFWaSu2XGWqzStqd9SqlKG/69oxGdJYt4bJXn+Ub1bGmFrfXQoKkLdgEV9IP+C
 Umvx574AYRPRRJIwT8ziK4FfwP2drWhjCWdFGy8dFcqeApmntoR+FUPpmtpJxN9CTb4r
 KlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KXSQWrkgVKujQgWAmEV6JwKVKd1aFY1WSRQmmAz+nVY=;
 b=Q7ESrBrrW6G1yS+98NwMJECx3VaRlpKdSKp/kLRYIUSMeUlIkm5QHJZjcSvaQ/Polv
 OQEPaR5jlj77PR3dSK6cOmFA1Zx+VFFKlwpYa7WPNlZcynT8bFpILBOzYH9OCgFtap5m
 tmEsNbxng/HiNjFKCuv6rX66m5vhcawuv3TJNn4p3DIJ+Zs/BTX119nPqYs87XUY3Nu5
 qN0KkqurjI7xQkw7djETIjGyErm/+w6a78Uc2iA3Fjg9oseU50kvVtRaWKT2AKWrdY5q
 FiZGTFqOw/OQmk/aLYU4rGAMHKPplDqEp8+meTnqvRjKHk2vs3grgtxlwci7OHxFY1mO
 E1Og==
X-Gm-Message-State: APjAAAWeAqmfLBMQQh9kiqdmmwWZXqYzAS4F8EAO+FEMfkhR4D4BZ7hb
 a9EY+YgIB0CNA3LhUrOyiMF2TxQZfAOJfw==
X-Google-Smtp-Source: APXvYqyN3qLuRVLFt5DH26dgz0LAFbgQbK0iAo+6frXhRnmGkjrVcrX+5giQawTTybn7lcV5nm1BZA==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr15561509wma.44.1571069138442; 
 Mon, 14 Oct 2019 09:05:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/68] aspeed: Parameterise number of MACs
Date: Mon, 14 Oct 2019 17:03:56 +0100
Message-Id: <20191014160404.19553-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

To support the ast2600's four MACs allow SoCs to specify the number
they have, and create that many.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-22-clg@kaod.org
[clg: - included a check on sc->macs_num when realizing the macs
      - included interrupt definitions for the AST2600 ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  5 ++++-
 hw/arm/aspeed_ast2600.c     | 10 ++++++++--
 hw/arm/aspeed_soc.c         |  6 ++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 67c59956f83..088a5d10818 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -30,7 +30,7 @@
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  4
 #define ASPEED_CPUS_NUM  2
-#define ASPEED_MACS_NUM  2
+#define ASPEED_MACS_NUM  4
 
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
index a4f0fafab7c..25d2c2d05d6 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -32,7 +32,9 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_SPI1]      = 0x1E630000,
     [ASPEED_SPI2]      = 0x1E641000,
     [ASPEED_ETH1]      = 0x1E660000,
+    [ASPEED_ETH3]      = 0x1E670000,
     [ASPEED_ETH2]      = 0x1E680000,
+    [ASPEED_ETH4]      = 0x1E690000,
     [ASPEED_VIC]       = 0x1E6C0000,
     [ASPEED_SDMC]      = 0x1E6E0000,
     [ASPEED_SCU]       = 0x1E6E2000,
@@ -88,6 +90,9 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_I2C]       = 110,   /* 110 -> 125 */
     [ASPEED_ETH1]      = 2,
     [ASPEED_ETH2]      = 3,
+    [ASPEED_ETH3]      = 32,
+    [ASPEED_ETH4]      = 33,
+
 };
 
 static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
@@ -173,7 +178,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
                                        OBJECT(&s->scu), &error_abort);
     }
 
-    for (i = 0; i < ASPEED_MACS_NUM; i++) {
+    for (i = 0; i < sc->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
@@ -397,7 +402,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics; i++) {
+    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
         qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
@@ -470,6 +475,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->sram_size    = 0x10000;
     sc->spis_num     = 2;
     sc->wdts_num     = 4;
+    sc->macs_num     = 4;
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
     sc->memmap       = aspeed_soc_ast2600_memmap;
     sc->num_cpus     = 2;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a063be9fd79..6defb143acd 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -198,7 +198,7 @@ static void aspeed_soc_init(Object *obj)
                                        OBJECT(&s->scu), &error_abort);
     }
 
-    for (i = 0; i < ASPEED_MACS_NUM; i++) {
+    for (i = 0; i < sc->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
@@ -372,7 +372,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics; i++) {
+    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
         qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
@@ -455,6 +455,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     sc->sram_size    = 0x8000;
     sc->spis_num     = 1;
     sc->wdts_num     = 2;
+    sc->macs_num     = 2;
     sc->irqmap       = aspeed_soc_ast2400_irqmap;
     sc->memmap       = aspeed_soc_ast2400_memmap;
     sc->num_cpus     = 1;
@@ -478,6 +479,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     sc->sram_size    = 0x9000;
     sc->spis_num     = 2;
     sc->wdts_num     = 3;
+    sc->macs_num     = 2;
     sc->irqmap       = aspeed_soc_ast2500_irqmap;
     sc->memmap       = aspeed_soc_ast2500_memmap;
     sc->num_cpus     = 1;
-- 
2.20.1


