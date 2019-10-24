Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42ED20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y22cxE4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42ED20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgbZ-0005n5-Ak
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy4-0007tW-Hs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy3-0000w7-3Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfy2-0000vj-T6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id a11so10714854wra.6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SSIRbdIen/7fg/3VtseNziJYU9KzRrDZCTawNXozh3I=;
 b=y22cxE4wfhbYgnmyjP4CDSeN5PCVMUOWL4J/ROx7CvUOChnsGZJx3TujBkED6JIutJ
 8lhbmzlXyTeN0kypgs86J1g7tv9YXjMVmlIw+PMWalk9WBh/8Ud7GC79UL5TGN8FWJGS
 iSO9LM7SZpu1w9F8kJ5XnrUMalzAyyYZMs0lVeOOgI2kiIKrF9p9ierQAyrAv4C5GUF/
 siBTDiYUqSgkPtfaci7NLfMXf5wyZ1Ahj71BLj4HtFX9AOctGMxFui8vt8FWjrg73HCT
 8DFDLizVrACJIzKkJgyKmki9KBMO5WvAZuZVVYgn5GS0kEnxRfCOTHWc0JlydbvcffTA
 Gbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SSIRbdIen/7fg/3VtseNziJYU9KzRrDZCTawNXozh3I=;
 b=STRH+hulWhDg8eZh4H2iKShKPPWhWi5SbbIGMd1IbAbsnwKDUBH69wwQlwi59rTO4q
 NDRuiSe2XGNqem4A1/ax7xf9GZF4qjDYzNj7dsF7hlcBiG7JRai7D4WMjNbrGdOMmCCZ
 T3ffPoqUJUa274spC04lWc36qCZ99H3Oml5e9tZkW0WsHZEyVA4ZbczcYluiNOlo7Fom
 Ca7Cfyrkr8spxJUjP0vgT77M2HZQiFpON+gECRCIm0XA5pK6R0zjgqah0XAfnRKm7TR/
 7wr7+WESJDcKAqsdfhdMGSBVMdLrUWb0Mp1NoLC7yv97y3RD2zQUhbBGUica1tTz5z3h
 xd/g==
X-Gm-Message-State: APjAAAUl1dBn53lDf7aXfbEQNQ0wSe8IwqUERQx46aBkz6KGsJfFWbaq
 IkKllwbjKQjQ1+WFY409B9KQBqBa92c=
X-Google-Smtp-Source: APXvYqz5c8vrtm8DS2d5ce0hrgQdMm8bBsEvYrMUclsl6mbkNFFCSMtWlH9mMSOfIPdl5xrXWMnomA==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr4658975wrs.366.1571934485507; 
 Thu, 24 Oct 2019 09:28:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/51] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
Date: Thu, 24 Oct 2019 17:27:04 +0100
Message-Id: <20191024162724.31675-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Switch the slavio_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191021134357.14266-4-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/slavio_timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 890dd53f8d8..c55e8d0bf42 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -30,7 +30,6 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 /*
@@ -213,6 +212,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
     saddr = addr >> 2;
     switch (saddr) {
     case TIMER_LIMIT:
+        ptimer_transaction_begin(t->timer);
         if (slavio_timer_is_user(tc)) {
             uint64_t count;
 
@@ -234,6 +234,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                 ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1);
             }
         }
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_COUNTER:
         if (slavio_timer_is_user(tc)) {
@@ -245,7 +246,9 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             t->reached = 0;
             count = ((uint64_t)t->counthigh) << 32 | t->count;
             trace_slavio_timer_mem_writel_limit(timer_index, count);
+            ptimer_transaction_begin(t->timer);
             ptimer_set_count(t->timer, LIMIT_TO_PERIODS(t->limit - count));
+            ptimer_transaction_commit(t->timer);
         } else {
             trace_slavio_timer_mem_writel_counter_invalid();
         }
@@ -253,13 +256,16 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
     case TIMER_COUNTER_NORST:
         // set limit without resetting counter
         t->limit = val & TIMER_MAX_COUNT32;
+        ptimer_transaction_begin(t->timer);
         if (t->limit == 0) { /* free-run */
             ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 0);
         } else {
             ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 0);
         }
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_STATUS:
+        ptimer_transaction_begin(t->timer);
         if (slavio_timer_is_user(tc)) {
             // start/stop user counter
             if (val & 1) {
@@ -271,6 +277,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             }
         }
         t->run = val & 1;
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_MODE:
         if (timer_index == 0) {
@@ -280,6 +287,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                 unsigned int processor = 1 << i;
                 CPUTimerState *curr_timer = &s->cputimer[i + 1];
 
+                ptimer_transaction_begin(curr_timer->timer);
                 // check for a change in timer mode for this processor
                 if ((val & processor) != (s->cputimer_mode & processor)) {
                     if (val & processor) { // counter -> user timer
@@ -306,6 +314,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                         trace_slavio_timer_mem_writel_mode_counter(timer_index);
                     }
                 }
+                ptimer_transaction_commit(curr_timer->timer);
             }
         } else {
             trace_slavio_timer_mem_writel_mode_invalid();
@@ -365,10 +374,12 @@ static void slavio_timer_reset(DeviceState *d)
         curr_timer->count = 0;
         curr_timer->reached = 0;
         if (i <= s->num_cpus) {
+            ptimer_transaction_begin(curr_timer->timer);
             ptimer_set_limit(curr_timer->timer,
                              LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
             ptimer_run(curr_timer->timer, 0);
             curr_timer->run = 1;
+            ptimer_transaction_commit(curr_timer->timer);
         }
     }
     s->cputimer_mode = 0;
@@ -378,7 +389,6 @@ static void slavio_timer_init(Object *obj)
 {
     SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    QEMUBH *bh;
     unsigned int i;
     TimerContext *tc;
 
@@ -390,9 +400,11 @@ static void slavio_timer_init(Object *obj)
         tc->s = s;
         tc->timer_index = i;
 
-        bh = qemu_bh_new(slavio_timer_irq, tc);
-        s->cputimer[i].timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+        s->cputimer[i].timer = ptimer_init(slavio_timer_irq, tc,
+                                           PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(s->cputimer[i].timer);
         ptimer_set_period(s->cputimer[i].timer, TIMER_PERIOD);
+        ptimer_transaction_commit(s->cputimer[i].timer);
 
         size = i == 0 ? SYS_TIMER_SIZE : CPU_TIMER_SIZE;
         snprintf(timer_name, sizeof(timer_name), "timer-%i", i);
-- 
2.20.1


