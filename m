Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC60DC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D6A2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuDlqPJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D6A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW8q-0000sH-Ru
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrH-0002Jn-TS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrF-0003GK-V4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrF-0003Fa-CL; Mon, 06 Apr 2020 13:48:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id k1so526602wrm.3;
 Mon, 06 Apr 2020 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4qH9Y6DuxMr7Hpaab8O+4h54IDNv0/jiVmK2ORkgQcM=;
 b=ZuDlqPJogrtywgtHo4K1K/hz3DAl5EpWjYGKKa4fN4HE+kv1/j+tL/RpJNONx0+Fvy
 sZZrVWt2VMRGrKxGz+JaG2LdxnO+d9f1r3UFF4vGOoJGQewLN6C4FyFP0B8ByeXmmGbV
 xvglBopPhx7dxZWfo56hyCdcsHbPIApDcZFX5DC0jiQQMmNCN7Vj4Q6f0Fa0EleqHd78
 4iBnWvW9FEfPqP357fTAg3kbTCzKG0Xk+/w2sYkr+hMGKSZumg2j2p2Yi4213mVKz2fa
 ZY8p9j7FXJ1r8YPo2EKLnFdA/H4S9HuxfB40BfsQc9IG7cDFC7FMY0mV3f2bR7d/WbUM
 19RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4qH9Y6DuxMr7Hpaab8O+4h54IDNv0/jiVmK2ORkgQcM=;
 b=q7aTnrE+fxjQg5rhx3qUNut6hr7g8lN1UrZGzRI3R69nvYpTYjnbt9NWnEceDYKEus
 LM2SlZMhzusICvb4oQqVRlSsAWKefr2W1w1pTJ/AM5PpwuBbTmso6wkO7SsrX4DOAKeB
 IjLI3wLxSr49tNhsuubyup7RAZpJr4RS1ZqSn+3xqXcJIMc0Pzvbqetcr2XlBvVM54+b
 vzVJV1azrbkALMxE0JRwX7arRDm8czp3CjntXS27UL/DmFK2uJaoPCHhN2KPTMSdLhBM
 nx8WbT875hGNvru6R5Jz5bzcI7IjnwUyk04fkqr9BQ6d64OQ9CFhBtWrqS/LO27ZuUxK
 5+yA==
X-Gm-Message-State: AGi0PuZEUC3ERHXvlEKlmteIcgFmZ339EbtTEK7dwNPD6ieiB2+waZJz
 tSgS7CeYbU7CNJehi1Pp1kV3bNrFxkE=
X-Google-Smtp-Source: APiQypLXUCdyx6FH0UxlG//cNePSGsrB43ux8fV+wI5gEV+n4XJkEpjhXKGIcLmdMPHfS8qmbH5aTA==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr396708wro.68.1586195304023;
 Mon, 06 Apr 2020 10:48:24 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 28/54] hw/arm/aspeed: Add missing error-propagation
 code
Date: Mon,  6 Apr 2020 19:47:17 +0200
Message-Id: <20200406174743.16956-29-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_ast2600.c | 36 ++++++++++++++++++++++++++++++------
 hw/arm/aspeed_soc.c     | 12 ++++++++++--
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index c8e0171824..d810df928c 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -277,7 +277,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (s->num_cpus > 1) {
             object_property_set_int(OBJECT(&s->cpu[i]),
                                     ASPEED_A7MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
+                                    "reset-cbar", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
         }
         /*
          * TODO: the secondary CPUs are started and a boot helper
@@ -293,10 +297,18 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* A7MPCORE */
     object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu",
-                            &error_abort);
+                            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
 
     for (i = 0; i < s->num_cpus; i++) {
@@ -343,7 +355,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
-                             OBJECT(&s->scu), "scu", &error_abort);
+                             OBJECT(&s->scu), "scu", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -459,7 +475,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
         object_property_set_link(OBJECT(&s->wdt[i]),
-                                 OBJECT(&s->scu), "scu", &error_abort);
+                                 OBJECT(&s->scu), "scu", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
@@ -490,7 +510,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
-                                 "nic", &error_abort);
+                                 "nic", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
                                  &err);
         if (err) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index aa6d739ad0..5f90215187 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -301,7 +301,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
-                             OBJECT(&s->scu), "scu", &error_abort);
+                             OBJECT(&s->scu), "scu", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -398,7 +402,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
         object_property_set_link(OBJECT(&s->wdt[i]),
-                                 OBJECT(&s->scu), "scu", &error_abort);
+                                 OBJECT(&s->scu), "scu", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.1


