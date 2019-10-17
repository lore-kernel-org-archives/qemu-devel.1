Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B006FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C31214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlX+7Bwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C31214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL69t-0004Lf-1B
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q4-0006kC-KI
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q3-0002Yv-8s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5q3-0002Yf-0w
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so1956012wrb.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RWVTerfEod6JXDvGIgZLZLZ8haab8EF7a9UHu0kP8E4=;
 b=nlX+7BwnOVlP9bSMi4KyJebzYiG0AttIkkNxSNDhCSjlvTjxMTJU+bexd0wrlVV8dL
 tqW49D3goLsYDeowHkpsyROgx9xcX031V71WjYVG+sbZdyUWN7htoO8nH3gJXNTu45fK
 b66ejqnUGaptU8+gwjLLjjUybd6Pah1wVwmB8R5H+C7MOFr7gM9df/AMR97BIbPE3qRA
 kYJgmGnYVuL14p3r9OT5j6ezDgQfp+3XqacuFkqFAkdBE8x8Z0jcglHk/U7S9R8QB0e5
 +sweVqrqmfeeKGvyN9SSXjQXXaaa1sWqGv1yaTS8h/Zps64JQEMghgSZCAKLL0sRADn0
 M9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RWVTerfEod6JXDvGIgZLZLZ8haab8EF7a9UHu0kP8E4=;
 b=PefnBsY0vgo+JXXCreAiql3SYQwK14F1mjmYsQX0FQZIbXVGThdyNScs2s/f3UTl7i
 ffjnuiwe6aGHewPgwYdnrkH35aE+3jpjaqUk0TCCywa/hv+yETvMU9NNuYn1QcEBZsx6
 8JPMWKEycAXSNQqGYMZUyCcls0vYBiEkfOiYKORfYqUnMqdGu6bOuyJHbwcubFs6g0ep
 l1XLB4BRZVJuT59X7BUpYRYOxL/i615nMZ/bl5mKc3YF72djvenOTdKfaK2ohcmf4dQY
 r3pibGP4V0nkNRQ/sKhp0F4mP1l8pP408ODgSGakSNXfhiRe9waG5Xt9uXq4/YgJDXll
 pmJg==
X-Gm-Message-State: APjAAAVOnFoEchRp5MCHS7WB4SDZ8j4Lh1to9xP8M6UPXBHrWuupptiC
 N14ZyxGgqrOChf245Hugs3XxA389z9YbkQ==
X-Google-Smtp-Source: APXvYqyrg/bE85X54K/4huwJB3M+qUmf8E4QIpDwzEU6HbD/iv3quxvMnW3T2l60Rb/eFBRTH7dpVw==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr2926563wrs.172.1571318949692; 
 Thu, 17 Oct 2019 06:29:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] hw/timer/sh_timer: Switch to transaction-based ptimer API
Date: Thu, 17 Oct 2019 14:28:59 +0100
Message-Id: <20191017132905.5604-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132905.5604-1-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the sh_timer code away from bottom-half based ptimers to the
new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/sh_timer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 48a81b4dc79..13c4051808f 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "qemu/timer.h"
-#include "qemu/main-loop.h"
 #include "hw/ptimer.h"
 
 //#define DEBUG_TIMER
@@ -91,13 +90,18 @@ static void sh_timer_write(void *opaque, hwaddr offset,
     switch (offset >> 2) {
     case OFFSET_TCOR:
         s->tcor = value;
+        ptimer_transaction_begin(s->timer);
         ptimer_set_limit(s->timer, s->tcor, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCNT:
         s->tcnt = value;
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, s->tcnt);
+        ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCR:
+        ptimer_transaction_begin(s->timer);
         if (s->enabled) {
             /* Pause the timer if it is running.  This may cause some
                inaccuracy dure to rounding, but avoids a whole lot of other
@@ -148,6 +152,7 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             /* Restart the timer if still enabled.  */
             ptimer_run(s->timer, 0);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCPR:
         if (s->feat & TIMER_FEAT_CAPT) {
@@ -168,12 +173,14 @@ static void sh_timer_start_stop(void *opaque, int enable)
     printf("sh_timer_start_stop %d (%d)\n", enable, s->enabled);
 #endif
 
+    ptimer_transaction_begin(s->timer);
     if (s->enabled && !enable) {
         ptimer_stop(s->timer);
     }
     if (!s->enabled && enable) {
         ptimer_run(s->timer, 0);
     }
+    ptimer_transaction_commit(s->timer);
     s->enabled = !!enable;
 
 #ifdef DEBUG_TIMER
@@ -191,7 +198,6 @@ static void sh_timer_tick(void *opaque)
 static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
 {
     sh_timer_state *s;
-    QEMUBH *bh;
 
     s = (sh_timer_state *)g_malloc0(sizeof(sh_timer_state));
     s->freq = freq;
@@ -203,8 +209,7 @@ static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
     s->enabled = 0;
     s->irq = irq;
 
-    bh = qemu_bh_new(sh_timer_tick, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(sh_timer_tick, s, PTIMER_POLICY_DEFAULT);
 
     sh_timer_write(s, OFFSET_TCOR >> 2, s->tcor);
     sh_timer_write(s, OFFSET_TCNT >> 2, s->tcnt);
-- 
2.20.1


