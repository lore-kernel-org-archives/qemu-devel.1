Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91335CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB832064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4vb/i3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB832064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuLX-0008Py-3F
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGX-0002OB-Dd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGW-0001Do-46
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGV-0001DX-TT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id r141so6597270wme.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=62R1pMICSQgalMj3UXUALVQERlO54EdusG7o+yE6TlY=;
 b=Z4vb/i3R6ex105D81hSYBBuA86o9BCOBOVC1weSVsW3O56iD+KGBAQW8DB/Mb6jefh
 jCKCMDbF7Z3MA2a/DkXZkPuOMHWPPeAERCwXy2e4YLNCtWzFnBQa7S4ubGr2JYxTqI4V
 4UicT21g0dxnFaP6ZClIwR7c+7RaxpgF7nyt82ZNRrXfW8MPcKnlwHYKS1djxs3Nii2C
 p8h7jyAmZ49SolDLwlR2ZImF35Qm6iR+COQlO6v/Mhq8LMhESETkMAmuSlXVikFhQgLg
 Vl3pX7nyrFRJRr+KZiZ0I5XdBlHZCef1f5FP/uk3pSTeAwnAB8PNN6F3VqPIuJNcyEkN
 fvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=62R1pMICSQgalMj3UXUALVQERlO54EdusG7o+yE6TlY=;
 b=O8ofZUb8c3dgd2OeiBtBq5HmQ0jweVVemnUrqerC5kkAyJ6gSji12BkxnqCB+dWUSG
 VExO356ESKBVPSeYRgXREXeAeGsQsbwPdlIbZJfSrc7T9S6gSapLyxZLRQFe02BYFPQz
 mMlbPQOYXYr/JIJtul4ARhWstPXEjGH4shGTCe7Lr3wpTaJ1XN0364C7U7Tn2wLImd4B
 mitc16QMwGejYbDo2W837w78zBdvQZlAI+Y0hh2zLgxrsXB/iR4o4+VN2igHbb5DsZeR
 YyxC7csAhCXySS7oMz5w4of+gnF65KcaVzymveftd67hfhUn2NNUdOwm5LYZjIsq1eCe
 vQmw==
X-Gm-Message-State: APjAAAWsi+ulPMCenZoRLrI68IUs0gBMp/XgVOJTpfNOEwyh0KUkccxB
 zHKxAPDBeK6h+8F4KVvnKwKLrQpQeAI=
X-Google-Smtp-Source: APXvYqy0zEg3x1lefwuCs0LcKZ2x9Qu3CHF12Yvp0lOmJI4JI6kkO8mHc4pH8NoUSZgud29oYSBMlQ==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr3286359wmk.100.1571751118316; 
 Tue, 22 Oct 2019 06:31:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] hw/timer/lm32_timer: Switch to transaction-based ptimer
 API
Date: Tue, 22 Oct 2019 14:31:00 +0100
Message-Id: <20191022133134.14487-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Switch the lm32_timer code away from bottom-half based ptimers to the
new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the ytimer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191017132905.5604-4-peter.maydell@linaro.org
---
 hw/timer/lm32_timer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index fabde760b2d..3fdecd09fe2 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -30,7 +30,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #define DEFAULT_FREQUENCY (50*1000000)
@@ -63,7 +62,6 @@ struct LM32TimerState {
 
     MemoryRegion iomem;
 
-    QEMUBH *bh;
     ptimer_state *ptimer;
 
     qemu_irq irq;
@@ -119,6 +117,7 @@ static void timer_write(void *opaque, hwaddr addr,
         s->regs[R_SR] &= ~SR_TO;
         break;
     case R_CR:
+        ptimer_transaction_begin(s->ptimer);
         s->regs[R_CR] = value;
         if (s->regs[R_CR] & CR_START) {
             ptimer_run(s->ptimer, 1);
@@ -126,10 +125,13 @@ static void timer_write(void *opaque, hwaddr addr,
         if (s->regs[R_CR] & CR_STOP) {
             ptimer_stop(s->ptimer);
         }
+        ptimer_transaction_commit(s->ptimer);
         break;
     case R_PERIOD:
         s->regs[R_PERIOD] = value;
+        ptimer_transaction_begin(s->ptimer);
         ptimer_set_count(s->ptimer, value);
+        ptimer_transaction_commit(s->ptimer);
         break;
     case R_SNAPSHOT:
         error_report("lm32_timer: write access to read only register 0x"
@@ -176,7 +178,9 @@ static void timer_reset(DeviceState *d)
     for (i = 0; i < R_MAX; i++) {
         s->regs[i] = 0;
     }
+    ptimer_transaction_begin(s->ptimer);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_commit(s->ptimer);
 }
 
 static void lm32_timer_init(Object *obj)
@@ -195,10 +199,11 @@ static void lm32_timer_realize(DeviceState *dev, Error **errp)
 {
     LM32TimerState *s = LM32_TIMER(dev);
 
-    s->bh = qemu_bh_new(timer_hit, s);
-    s->ptimer = ptimer_init_with_bh(s->bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(timer_hit, s, PTIMER_POLICY_DEFAULT);
 
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, s->freq_hz);
+    ptimer_transaction_commit(s->ptimer);
 }
 
 static const VMStateDescription vmstate_lm32_timer = {
-- 
2.20.1


