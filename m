Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E16EC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3950B21721
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvjUEJUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3950B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3a2-0001Up-H2
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:11:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3FP-0002P6-5u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3FI-0002Eu-H4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:57 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3FG-0002CI-Nh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:51 -0400
Received: by mail-wr1-f49.google.com with SMTP id c27so7574984wrb.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xLXG4Nv6yEmVw9kkMxGxEVuFArgBP+Xz+Oi4X8SxX1A=;
 b=xvjUEJUg+ZWVyqYduXllUqk1KcQofIY+0jtnEDDmxSSjUNgJc1WttJY8OgQX/G3/58
 L3z/2NQi4rcDvq2VhLH5YSAu1IztT3qbt7wNfiBO9s9LwslApxWUyrid9d9ZYCB/ldB1
 sx14sohFPT6YCgt1yb3+i84XuhaMMLUBszeiCTakJqyTqmd0mowjc/6cn+HxQfzbCEI7
 efjGqbpxSt0c+xRdFV9wg95JOkdfpouCv/qQyUBy636PggJcNYe6rnO2YUK6U2jc3fwj
 2bKCKlFEgSU5KlOjhpNFxPuBinS3zDNc+uZvDvSMZoMEOMI0IXhgKzFWjnOu9UX1P2Z6
 c4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xLXG4Nv6yEmVw9kkMxGxEVuFArgBP+Xz+Oi4X8SxX1A=;
 b=kZG8A137EBvFCzd5YwJcYaPEcDwCHz19EBDos/A+ZGpQEuixAalIsXN+t/mnG2N87e
 dirPVANMYry1h2uOpD9QAqSsf+m2mjnLplk9PYFZ0vUIc1VS18/9pbTzSGf7O6UBdUyL
 GLrJPX811HHYYGs3C0TDdNxf2KnWjZpEZNCwV6UXXF2X+9Rx/a4QYB/H5xJeQUzEgGG2
 2ODLAnMVnF9iwXpav1S1zOJPfiTDGcDY4O8B2b5s5ClJp2XAohHgr6+SfCbs78IOxLfm
 UjDAEEH4jcFmqXVN6XEmuNBaLzQcMb6hV7T+7n2kziEQ6MDrt067QNvxUrcOqRiJjXdJ
 A+2Q==
X-Gm-Message-State: APjAAAXCnfRUtDPM/FW7GP0TRCusvELyMyyy5wxnwHSEAdFRaMhPpC7X
 tgCPhlwDd+BkYBYLXbSjowv2VUWkcf90mw==
X-Google-Smtp-Source: APXvYqxxP09lzpvQqNtXgAdPcYOHDYks8o7ByFGa7jDuUH2ba1Ai+21qSE2QmLngXEOmjneUd5dHZQ==
X-Received: by 2002:adf:e28a:: with SMTP id v10mr1424716wri.178.1561999200375; 
 Mon, 01 Jul 2019 09:40:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:11 +0100
Message-Id: <20190701163943.22313-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.49
Subject: [Qemu-devel] [PULL 14/46] aspeed: add support for multiple NICs
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

From: Cédric Le Goater <clg@kaod.org>

The Aspeed SoCs have two MACs. Extend the Aspeed model to support a
second NIC.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-7-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed_soc.c         | 33 +++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b613b00600f..75b557060b9 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -25,6 +25,7 @@
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
 #define ASPEED_CPUS_NUM  2
+#define ASPEED_MACS_NUM  2
 
 typedef struct AspeedSoCState {
     /*< private >*/
@@ -43,7 +44,7 @@ typedef struct AspeedSoCState {
     AspeedSMCState spi[ASPEED_SPIS_NUM];
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
-    FTGMAC100State ftgmac100;
+    FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index d38fb0aaa0f..736e52366a6 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -234,8 +234,10 @@ static void aspeed_soc_init(Object *obj)
                                     sc->info->silicon_rev);
     }
 
-    sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
-                          sizeof(s->ftgmac100), TYPE_FTGMAC100);
+    for (i = 0; i < ASPEED_MACS_NUM; i++) {
+        sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
+                              sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
+    }
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -382,19 +384,22 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
-    object_property_set_bool(OBJECT(&s->ftgmac100), true, "aspeed", &err);
-    object_property_set_bool(OBJECT(&s->ftgmac100), true, "realized",
-                             &local_err);
-    error_propagate(&err, local_err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    for (i = 0; i < nb_nics; i++) {
+        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
+                                 &err);
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
+                                 &local_err);
+        error_propagate(&err, local_err);
+        if (err) {
+            error_propagate(errp, err);
+           return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+                        sc->info->memmap[ASPEED_ETH1 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+                           aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0,
-                    sc->info->memmap[ASPEED_ETH1]);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
-                       aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
-- 
2.20.1


