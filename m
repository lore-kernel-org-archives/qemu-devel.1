Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0961DCA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73362064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDjuAcZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73362064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuMy-000283-Av
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGc-0002T1-15
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGa-0001Ev-KV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGZ-0001Eg-Tl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id r19so17321817wmh.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=c/CnNVHFORCd4oE1CaU05xljf7UHrrubl901brpFpx8=;
 b=bDjuAcZwrG2L0E+zhgbnXzRSlXp0zQbaQBvued8E766giyJPloeZh2zxlF1EosCXet
 AIzzX/amIY+mwhnMByzqpxqVPRn8PL+Zs41YG/aMuCeB03leQJ05tMyr+xDEPgbEwnPk
 Ve/0Oh3bkL6iKUkZm+xs5fL6sNdGfi/FhtsSSNelaGiUXQtAsk7RATN0uCuo+Z8gNQxB
 hIe/t2PejtpNp26p0CtZxwaoTlYjQ2gZMrbAt+4K76DTqObHdKc3SzgckpAHM4X/3nTg
 gFAsm7bMf2C6SrcyW43Rr1Q/q2vaOwWVYPyj9Wt8cqambFLX4LTVufkOk32Z9p2kFGmr
 F5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c/CnNVHFORCd4oE1CaU05xljf7UHrrubl901brpFpx8=;
 b=Yze5Z4VfMMrC57/BWIwIZmFazrx7ii15EOuwaQ2ixh9FyhoDuY8qy/R1s7XJClefzR
 kkcD+af5yL7vy7FIleZbfo/OfIK5ByfXPr/8wtpTr7HTbwFIxJV8Vbqevs5fkVPRlntO
 lS0sr/G8Z/G/oR+hQJCEXhE/ezU/Vse25pH2Q0TrCjkau6bwPWva7lUqfZEC/OM9Ri+B
 WQtJ76Lpn/KZc4EfwyHtclc63z0btZfjJSANdjw91UJREFOF2EHaLi48S1fXXkZTWdvh
 6Rf1M6kr1aC53/IjoFevUlYzBIC1gODbtoareTV8hTzmjJMTnSrNm4FeviLdyK2UOBrg
 0sbg==
X-Gm-Message-State: APjAAAU2LNjhvnAZ+e1eHLLza4bLDD3r+NAUqQ1rvX29sJN9cGam50hK
 loYNm1grm4HZb7UQyI2rwRSzi5OdJSE=
X-Google-Smtp-Source: APXvYqxQRgdyvqkAXssBt2SyO5G906Jk+QDIsPEDz4CYVWM4QV7LY99rTYbKryPW3Sh1YhSbx9dn9w==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr3151360wmc.60.1571751122530;
 Tue, 22 Oct 2019 06:32:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] hw/watchdog/etraxfs_timer.c: Switch to transaction-based
 ptimer API
Date: Tue, 22 Oct 2019 14:31:02 +0100
Message-Id: <20191022133134.14487-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Switch the etraxfs_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191017132905.5604-7-peter.maydell@linaro.org
---
 hw/timer/etraxfs_timer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index ab27fe1895b..afe3d30a8ea 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -26,7 +26,6 @@
 #include "hw/sysbus.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
@@ -59,9 +58,6 @@ typedef struct ETRAXTimerState {
     qemu_irq irq;
     qemu_irq nmi;
 
-    QEMUBH *bh_t0;
-    QEMUBH *bh_t1;
-    QEMUBH *bh_wd;
     ptimer_state *ptimer_t0;
     ptimer_state *ptimer_t1;
     ptimer_state *ptimer_wd;
@@ -155,6 +151,7 @@ static void update_ctrl(ETRAXTimerState *t, int tnum)
     }
 
     D(printf ("freq_hz=%d div=%d\n", freq_hz, div));
+    ptimer_transaction_begin(timer);
     ptimer_set_freq(timer, freq_hz);
     ptimer_set_limit(timer, div, 0);
 
@@ -176,6 +173,7 @@ static void update_ctrl(ETRAXTimerState *t, int tnum)
             abort();
             break;
     }
+    ptimer_transaction_commit(timer);
 }
 
 static void timer_update_irq(ETRAXTimerState *t)
@@ -240,6 +238,7 @@ static inline void timer_watchdog_update(ETRAXTimerState *t, uint32_t value)
 
     t->wd_hits = 0;
 
+    ptimer_transaction_begin(t->ptimer_wd);
     ptimer_set_freq(t->ptimer_wd, 760);
     if (wd_cnt == 0)
         wd_cnt = 256;
@@ -250,6 +249,7 @@ static inline void timer_watchdog_update(ETRAXTimerState *t, uint32_t value)
         ptimer_stop(t->ptimer_wd);
 
     t->rw_wd_ctrl = value;
+    ptimer_transaction_commit(t->ptimer_wd);
 }
 
 static void
@@ -311,9 +311,15 @@ static void etraxfs_timer_reset(void *opaque)
 {
     ETRAXTimerState *t = opaque;
 
+    ptimer_transaction_begin(t->ptimer_t0);
     ptimer_stop(t->ptimer_t0);
+    ptimer_transaction_commit(t->ptimer_t0);
+    ptimer_transaction_begin(t->ptimer_t1);
     ptimer_stop(t->ptimer_t1);
+    ptimer_transaction_commit(t->ptimer_t1);
+    ptimer_transaction_begin(t->ptimer_wd);
     ptimer_stop(t->ptimer_wd);
+    ptimer_transaction_commit(t->ptimer_wd);
     t->rw_wd_ctrl = 0;
     t->r_intr = 0;
     t->rw_intr_mask = 0;
@@ -325,12 +331,9 @@ static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
     ETRAXTimerState *t = ETRAX_TIMER(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    t->bh_t0 = qemu_bh_new(timer0_hit, t);
-    t->bh_t1 = qemu_bh_new(timer1_hit, t);
-    t->bh_wd = qemu_bh_new(watchdog_hit, t);
-    t->ptimer_t0 = ptimer_init_with_bh(t->bh_t0, PTIMER_POLICY_DEFAULT);
-    t->ptimer_t1 = ptimer_init_with_bh(t->bh_t1, PTIMER_POLICY_DEFAULT);
-    t->ptimer_wd = ptimer_init_with_bh(t->bh_wd, PTIMER_POLICY_DEFAULT);
+    t->ptimer_t0 = ptimer_init(timer0_hit, t, PTIMER_POLICY_DEFAULT);
+    t->ptimer_t1 = ptimer_init(timer1_hit, t, PTIMER_POLICY_DEFAULT);
+    t->ptimer_wd = ptimer_init(watchdog_hit, t, PTIMER_POLICY_DEFAULT);
 
     sysbus_init_irq(sbd, &t->irq);
     sysbus_init_irq(sbd, &t->nmi);
-- 
2.20.1


