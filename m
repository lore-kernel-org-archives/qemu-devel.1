Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A04CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28BA20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5wOMzfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28BA20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgcA-0007My-Di
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy6-0007vr-AG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy4-0000wp-3k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfy3-0000wd-TR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id t16so21672295wrr.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mBAa8aOzaEjXceVb3slP1wzsJg0PhsoOqpMdKz0RtWI=;
 b=q5wOMzfBUZSBfoYqvwoI3DZ0t3VubE6hhsTEl1Ga43k3ckJPOPHe9xq5BJMzrUHK4g
 NFisXtDSB+CeqgpvpW9YRUFmfxUCkwxo2GSIdNzcSfnbz+1fKkdX9RQcj8ZZbk+seU0h
 l3X3pcVLxHBtkKGZN3jBl8m5ndJGo6UYc9PcyKxTM7rsTsI0yIIR9LMgcQ2s22SS7Hnl
 9HwrapTt5wHLumq+K7wlMC0oDM93BNVKqTo6QLDxEE9P5/O8N0XyKZYPGFiMYwoKbwW8
 FqdoXc2kdZ4YcPJt0Nf2WvdYt8v56hhNR4yjBA3ZeA1egn11V+NQ7bD1wCcq+UAUDGaB
 E1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mBAa8aOzaEjXceVb3slP1wzsJg0PhsoOqpMdKz0RtWI=;
 b=SAMjlRpiasqKMIr/L2JOYlpSB7zDlb14nBHxt3N0HqCM+rdFrCwaDu6ce9DzGh5Ghz
 h1wOZyBo3Sbi76o3LUP4sgf9VBe7ORphuqS5CelhhMAxba+2jOYV3ncSmJ24xq0MtRjV
 w0QrqvDdywjjZ7sGI1L7uu9VJVoZ0iheN2vgZMQR/rsqCCQUrzvkopHBS9eZAw4kjjil
 x4l3T0vdWdWnI1xxWcVCFuHoUyLR+yTrImcN1a3VtPtLfO1UI0dg9ZC4N4fOlXwkUpzP
 aOdow7j2+n53mL1P7mmqVf6zkGUHBjwdMCzybvPkjJVvgCOmdkZzyWDpCiZWgL/Z6Hew
 xMog==
X-Gm-Message-State: APjAAAXFu26kz1v6OJD/LJGoW9FSBnNbV73hu1PpnXIw1gtFzSHOG+l3
 NbmX9O6diUmCVuj2rU6qbDLL9KGX3gM=
X-Google-Smtp-Source: APXvYqz4p9YF4uDfPnmJbqM+lki7tb+ShC9krv5KZSkmZeBhzS8T8ciXrqEKjVARprZ+XTP7Ue9IeA==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4584277wrn.307.1571934486640; 
 Thu, 24 Oct 2019 09:28:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/51] hw/timer/grlib_gptimer.c: Switch to transaction-based
 ptimer API
Date: Thu, 24 Oct 2019 17:27:05 +0100
Message-Id: <20191024162724.31675-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Switch the grlib_gptimer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191021134357.14266-3-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/grlib_gptimer.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index bb09268ea14..7a9371c0e30 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -29,7 +29,6 @@
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #include "trace.h"
@@ -63,7 +62,6 @@ typedef struct GPTimer     GPTimer;
 typedef struct GPTimerUnit GPTimerUnit;
 
 struct GPTimer {
-    QEMUBH *bh;
     struct ptimer_state *ptimer;
 
     qemu_irq     irq;
@@ -93,6 +91,17 @@ struct GPTimerUnit {
     uint32_t config;
 };
 
+static void grlib_gptimer_tx_begin(GPTimer *timer)
+{
+    ptimer_transaction_begin(timer->ptimer);
+}
+
+static void grlib_gptimer_tx_commit(GPTimer *timer)
+{
+    ptimer_transaction_commit(timer->ptimer);
+}
+
+/* Must be called within grlib_gptimer_tx_begin/commit block */
 static void grlib_gptimer_enable(GPTimer *timer)
 {
     assert(timer != NULL);
@@ -115,6 +124,7 @@ static void grlib_gptimer_enable(GPTimer *timer)
     ptimer_run(timer->ptimer, 1);
 }
 
+/* Must be called within grlib_gptimer_tx_begin/commit block */
 static void grlib_gptimer_restart(GPTimer *timer)
 {
     assert(timer != NULL);
@@ -141,7 +151,9 @@ static void grlib_gptimer_set_scaler(GPTimerUnit *unit, uint32_t scaler)
     trace_grlib_gptimer_set_scaler(scaler, value);
 
     for (i = 0; i < unit->nr_timers; i++) {
+        ptimer_transaction_begin(unit->timers[i].ptimer);
         ptimer_set_freq(unit->timers[i].ptimer, value);
+        ptimer_transaction_commit(unit->timers[i].ptimer);
     }
 }
 
@@ -266,8 +278,10 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
         switch (timer_addr) {
         case COUNTER_OFFSET:
             trace_grlib_gptimer_writel(id, addr, value);
+            grlib_gptimer_tx_begin(&unit->timers[id]);
             unit->timers[id].counter = value;
             grlib_gptimer_enable(&unit->timers[id]);
+            grlib_gptimer_tx_commit(&unit->timers[id]);
             return;
 
         case COUNTER_RELOAD_OFFSET:
@@ -291,6 +305,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
             /* gptimer_restart calls gptimer_enable, so if "enable" and "load"
                bits are present, we just have to call restart. */
 
+            grlib_gptimer_tx_begin(&unit->timers[id]);
             if (value & GPTIMER_LOAD) {
                 grlib_gptimer_restart(&unit->timers[id]);
             } else if (value & GPTIMER_ENABLE) {
@@ -301,6 +316,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
             value &= ~(GPTIMER_LOAD & GPTIMER_DEBUG_HALT);
 
             unit->timers[id].config = value;
+            grlib_gptimer_tx_commit(&unit->timers[id]);
             return;
 
         default:
@@ -344,9 +360,11 @@ static void grlib_gptimer_reset(DeviceState *d)
         timer->counter = 0;
         timer->reload = 0;
         timer->config = 0;
+        ptimer_transaction_begin(timer->ptimer);
         ptimer_stop(timer->ptimer);
         ptimer_set_count(timer->ptimer, 0);
         ptimer_set_freq(timer->ptimer, unit->freq_hz);
+        ptimer_transaction_commit(timer->ptimer);
     }
 }
 
@@ -365,14 +383,16 @@ static void grlib_gptimer_realize(DeviceState *dev, Error **errp)
         GPTimer *timer = &unit->timers[i];
 
         timer->unit   = unit;
-        timer->bh     = qemu_bh_new(grlib_gptimer_hit, timer);
-        timer->ptimer = ptimer_init_with_bh(timer->bh, PTIMER_POLICY_DEFAULT);
+        timer->ptimer = ptimer_init(grlib_gptimer_hit, timer,
+                                    PTIMER_POLICY_DEFAULT);
         timer->id     = i;
 
         /* One IRQ line for each timer */
         sysbus_init_irq(sbd, &timer->irq);
 
+        ptimer_transaction_begin(timer->ptimer);
         ptimer_set_freq(timer->ptimer, unit->freq_hz);
+        ptimer_transaction_commit(timer->ptimer);
     }
 
     memory_region_init_io(&unit->iomem, OBJECT(unit), &grlib_gptimer_ops,
-- 
2.20.1


