Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1988C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6412074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPb8ee+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6412074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6Sb-0003QM-Ls
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6Nd-0003vA-G3; Tue, 16 Jun 2020 03:51:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6Nb-00085b-QF; Tue, 16 Jun 2020 03:51:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so1885756wme.3;
 Tue, 16 Jun 2020 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X3NztLovGUVeCGZNLiGLjBwKDBV+Pcr5uGZxcvfdmrY=;
 b=rPb8ee+wygtZWv4ygAuZYdSrKydWCvSuCb2dTCvULgmJzad8a0TbldC89qG9uf4JbC
 IjcwTVD1vhTXOW8n4HN+L5iD1mGoUnb/1wUPgp2Y7k3plqS3LuSTm0Aw2mvgbNJcsL4c
 tNE/S8cNqtfmtyLbAzO4A26zkPLMNz1PMcjOyHSaib/prrJoTTAoSSBYvfpMcSzVxcHY
 wWynZU6bQnEu4NKpxHf1SqJhWyDQlKsfxidcRT6y+PSU3UxaoK9FPCQtR7iYL+RENdlJ
 jsIHMDeaCnHcwuqx/IRhM3hV72MjcUVnzEsqkiDOaLOg8rLVYoZ7BIhIYkkICVD8VD1I
 WB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X3NztLovGUVeCGZNLiGLjBwKDBV+Pcr5uGZxcvfdmrY=;
 b=dJdYX+J6gbv48XzwRZKiNvf1cJWJwYC3zLOVjQFmGGPS0Njyx2MfxAXUyJ53TOtX0R
 b9wkkceGglwVbR7or2o/DwNxI2v8yr+PFyQiefCO6ifMFNTQGmftwUkvvP+wNfgllpmK
 PSW3DZb+/+Wt5KTJ178USz7EsIlFxZa51llKRYF9t4BrT2H5sOzwxWHJObML92Fn0AJN
 xtM+a2jfa8DpaLtFIVw2h5lHMFDvu8eiMj8Z/e4oqSLqyCtx5eIRPVNAh0VWwH0wYjn3
 0qZTm9XPn2/XVpifzs67+MULO9wuuPUvh/96j21md01PYB4Fln/oW6hCRTj37srlIfy5
 GvCA==
X-Gm-Message-State: AOAM530V9Dgp2oIVaaQYe/ehjFLHJMIlZjadhjVUlnoMq0aRnUNTrnFF
 rmOo22XBSnf8XWtDnogM/u3/g9Ms
X-Google-Smtp-Source: ABdhPJwyjF/RrvQsrN0MqAM1aFul+xxvjuBzkYqzsi5XzjFtVcwXmUJh7yXZLz/5si/8HT4f5CLlGQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr1967406wmj.137.1592293893404; 
 Tue, 16 Jun 2020 00:51:33 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/watchdog/wdt_aspeed: Reduce timer precision to
 micro-second
Date: Tue, 16 Jun 2020 09:51:21 +0200
Message-Id: <20200616075121.12837-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current implementation uses nano-second precision, while
the watchdog can not be more precise than a micro-second.
Simplify by using a micro-second based timer.
Rename the timer 'timer_us' to have the unit explicit.

Inspired-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/watchdog/wdt_aspeed.h |  2 +-
 hw/watchdog/wdt_aspeed.c         | 24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 819c22993a..e76a493788 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -25,7 +25,7 @@
 typedef struct AspeedWDTState {
     /*< private >*/
     SysBusDevice parent_obj;
-    QEMUTimer *timer;
+    QEMUTimer *timer_us;
 
     /*< public >*/
     MemoryRegion iomem;
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 6352ba1b0e..3fcb20f72b 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -98,23 +98,24 @@ static void aspeed_wdt_reload(AspeedWDTState *s)
     uint64_t reload;
 
     if (!(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK)) {
-        reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
+        reload = muldiv64(s->regs[WDT_RELOAD_VALUE],
+                          NANOSECONDS_PER_SECOND / SCALE_US,
                           s->pclk_freq);
     } else {
-        reload = s->regs[WDT_RELOAD_VALUE] * 1000ULL;
+        reload = s->regs[WDT_RELOAD_VALUE];
     }
 
     if (aspeed_wdt_is_enabled(s)) {
-        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + reload);
+        timer_mod(s->timer_us, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + reload);
     }
 }
 
 static void aspeed_wdt_reload_1mhz(AspeedWDTState *s)
 {
-    uint64_t reload = s->regs[WDT_RELOAD_VALUE] * 1000ULL;
+    uint64_t reload = s->regs[WDT_RELOAD_VALUE];
 
     if (aspeed_wdt_is_enabled(s)) {
-        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + reload);
+        timer_mod(s->timer_us, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + reload);
     }
 }
 
@@ -149,7 +150,7 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
             awc->wdt_reload(s);
         } else if (!enable && aspeed_wdt_is_enabled(s)) {
             s->regs[WDT_CTRL] = data;
-            timer_del(s->timer);
+            timer_del(s->timer_us);
         }
         break;
     case WDT_RESET_WIDTH:
@@ -189,7 +190,7 @@ static const VMStateDescription vmstate_aspeed_wdt = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_TIMER_PTR(timer, AspeedWDTState),
+        VMSTATE_TIMER_PTR(timer_us, AspeedWDTState),
         VMSTATE_UINT32_ARRAY(regs, AspeedWDTState, ASPEED_WDT_REGS_MAX),
         VMSTATE_END_OF_LIST()
     }
@@ -214,7 +215,7 @@ static void aspeed_wdt_reset(DeviceState *dev)
     s->regs[WDT_CTRL] = 0;
     s->regs[WDT_RESET_WIDTH] = 0xFF;
 
-    timer_del(s->timer);
+    timer_del(s->timer_us);
 }
 
 static void aspeed_wdt_timer_expired(void *dev)
@@ -224,7 +225,7 @@ static void aspeed_wdt_timer_expired(void *dev)
 
     /* Do not reset on SDRAM controller reset */
     if (s->scu->regs[reset_ctrl_reg] & SCU_RESET_SDRAM) {
-        timer_del(s->timer);
+        timer_del(s->timer_us);
         s->regs[WDT_CTRL] = 0;
         return;
     }
@@ -232,7 +233,7 @@ static void aspeed_wdt_timer_expired(void *dev)
     qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %" HWADDR_PRIx " expired.\n",
                   s->iomem.addr);
     watchdog_perform_action();
-    timer_del(s->timer);
+    timer_del(s->timer_us);
 }
 
 #define PCLK_HZ 24000000
@@ -244,7 +245,8 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
 
     assert(s->scu);
 
-    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expired, dev);
+    s->timer_us = timer_new_us(QEMU_CLOCK_VIRTUAL,
+                               aspeed_wdt_timer_expired, dev);
 
     /* FIXME: This setting should be derived from the SCU hw strapping
      * register SCU70
-- 
2.21.3


