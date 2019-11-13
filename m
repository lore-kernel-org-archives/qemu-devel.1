Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDFBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 01:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177FE20818
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 01:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmedqT/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177FE20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUh3f-0007Kk-0B
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 20:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUgta-0001Y6-4r
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtY-0005LH-Uc
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:30 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUgtU-0005K8-1P; Tue, 12 Nov 2019 19:52:24 -0500
Received: by mail-pg1-x541.google.com with SMTP id 15so169623pgh.5;
 Tue, 12 Nov 2019 16:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=69JEq1ljDXyHeKt9u+I4iV39ni/MWZMig/OklbPPAFo=;
 b=AmedqT/ypEk0jFibhlPxFaz1RYCARtLfspAqPXQ2kQJfniym7juPQGVAcuWGuag11L
 4Bw+qgzs9yWYtMnTjzin1fJmWntop5jw7Fm+HH7tC8JQRzciC9rWudA3MQ+LDxdrz5U1
 YauVmLH6tnmdB3RXNbd6+ec5KM7Vo8YuJSmcHB811Vlo5odm5JTLBaDOYqGZvsbPQJml
 3niV6NQQNbMWXh7DlGGOdW46axI8wxoKopecw3aCt1iyT1TXQXiU2AnMeSuuXbewkOny
 Fl7/KXwyQGtrTs6EyAZ0qbZ4RogOA5VZuPM9Gows6aAsQx6T/eU3kcAjt3UTFoePLfJ7
 uYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=69JEq1ljDXyHeKt9u+I4iV39ni/MWZMig/OklbPPAFo=;
 b=KuNA2ROQ+pG6VKwdwXFgcSEzVLbm4TZAQs0YeFq5g9n+sCVpC08lsAi9oQI1YlrqnV
 o9bVpNuSqC1db4ltnKp2EJw7f+p4IRv97mNa2Aq/GmYkrGKovEBreZ6ehkG1jUHe7i1F
 E0FqVWbx77ifqjDx+VW6VBaJzaoVZ8WvR6PgIaLx+owTBoJaw4ePcUZ597Pk+wewPXOA
 AuXtQXJlJd8SDwL38BuydoCzXi6YvMxryU2r/KVztaTPmvKsI5EfrwbPb8PbaWJVfeEf
 7VjLBHZoCL44O1LP/H1zdSckmxPHwEb8e+7NuWQ9Si2wNpVMaIcT2t2pVv/+TeZeGuqk
 f9pQ==
X-Gm-Message-State: APjAAAVTLvddvFUocB0KFp394/8lPPNmquFu84X/gYOxzEP+We+mNq4Q
 cEeKP4QoNQ1j3ZOb0j3RprU=
X-Google-Smtp-Source: APXvYqw5PXQN99bT0X3yFG5Qvc8C/cy/do4EhrEVIV6IfSExcICJDfI9deCrxc2aLvHMN+uJugLSeA==
X-Received: by 2002:a17:90a:8083:: with SMTP id c3mr937501pjn.92.1573606342926; 
 Tue, 12 Nov 2019 16:52:22 -0800 (PST)
Received: from voyager.ozlabs.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id i13sm169848pfo.39.2019.11.12.16.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 16:52:22 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 4/4] watchdog/aspeed: Fix AST2600 frequency behaviour
Date: Wed, 13 Nov 2019 11:22:01 +1030
Message-Id: <20191113005201.19005-5-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113005201.19005-1-joel@jms.id.au>
References: <20191113005201.19005-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2600 control register sneakily changed the meaning of bit 4
without anyone noticing. It no longer controls the 1MHz vs APB clock
select, and instead always runs at 1MHz.

The AST2500 was always 1MHz too, but it retained bit 4, making it read
only. We can model both using the same fixed 1MHz calculation.

Fixes: 6b2b2a703cad ("hw: wdt_aspeed: Add AST2600 support")
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix Fixes line in commit message
---
 hw/watchdog/wdt_aspeed.c         | 21 +++++++++++++++++----
 include/hw/watchdog/wdt_aspeed.h |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 8787c5ad0f97..9a8a2200fd8e 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -93,11 +93,11 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
 
 }
 
-static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
+static void aspeed_wdt_reload(AspeedWDTState *s)
 {
     uint64_t reload;
 
-    if (pclk) {
+    if (!(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK)) {
         reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
                           s->pclk_freq);
     } else {
@@ -109,6 +109,16 @@ static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
     }
 }
 
+static void aspeed_wdt_reload_1mhz(AspeedWDTState *s)
+{
+    uint64_t reload = s->regs[WDT_RELOAD_VALUE] * 1000ULL;
+
+    if (aspeed_wdt_is_enabled(s)) {
+        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + reload);
+    }
+}
+
+
 static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size)
 {
@@ -130,13 +140,13 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
     case WDT_RESTART:
         if ((data & 0xFFFF) == WDT_RESTART_MAGIC) {
             s->regs[WDT_STATUS] = s->regs[WDT_RELOAD_VALUE];
-            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK));
+            awc->wdt_reload(s);
         }
         break;
     case WDT_CTRL:
         if (enable && !aspeed_wdt_is_enabled(s)) {
             s->regs[WDT_CTRL] = data;
-            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+            awc->wdt_reload(s);
         } else if (!enable && aspeed_wdt_is_enabled(s)) {
             s->regs[WDT_CTRL] = data;
             timer_del(s->timer);
@@ -283,6 +293,7 @@ static void aspeed_2400_wdt_class_init(ObjectClass *klass, void *data)
     awc->offset = 0x20;
     awc->ext_pulse_width_mask = 0xff;
     awc->reset_ctrl_reg = SCU_RESET_CONTROL1;
+    awc->wdt_reload = aspeed_wdt_reload;
 }
 
 static const TypeInfo aspeed_2400_wdt_info = {
@@ -317,6 +328,7 @@ static void aspeed_2500_wdt_class_init(ObjectClass *klass, void *data)
     awc->ext_pulse_width_mask = 0xfffff;
     awc->reset_ctrl_reg = SCU_RESET_CONTROL1;
     awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
+    awc->wdt_reload = aspeed_wdt_reload_1mhz;
 }
 
 static const TypeInfo aspeed_2500_wdt_info = {
@@ -336,6 +348,7 @@ static void aspeed_2600_wdt_class_init(ObjectClass *klass, void *data)
     awc->ext_pulse_width_mask = 0xfffff; /* TODO */
     awc->reset_ctrl_reg = AST2600_SCU_RESET_CONTROL1;
     awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
+    awc->wdt_reload = aspeed_wdt_reload_1mhz;
 }
 
 static const TypeInfo aspeed_2600_wdt_info = {
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index dfedd7662dd1..819c22993a6e 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -47,6 +47,7 @@ typedef struct AspeedWDTClass {
     uint32_t ext_pulse_width_mask;
     uint32_t reset_ctrl_reg;
     void (*reset_pulse)(AspeedWDTState *s, uint32_t property);
+    void (*wdt_reload)(AspeedWDTState *s);
 }  AspeedWDTClass;
 
 #endif /* WDT_ASPEED_H */
-- 
2.24.0


