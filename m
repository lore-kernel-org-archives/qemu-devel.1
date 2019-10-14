Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F13DC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD932133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqPscYcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD932133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK32j-0003oz-Jy
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pe-0003Xl-QN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pd-0006xr-D6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pd-0006xB-70
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id p4so4500507wrm.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ppKekkdyvFhkeosiKomCQMOUGLuIDXn9EHr3PuXEGrU=;
 b=cqPscYcXcr/F9vM26ijL4lnVAZnLcPxHrPbgchirfvMO3y4UOrUNvlhOVjTvHRpxRj
 POhN0zhsSu9qVYHrqHWeNHXBTGe2DygHq1diqC7lA9C2SYoYi2RfhVxaB6SXSkey4ap9
 j3HD11hM3kWVFZ6zbM0JL4rNZsq8FmPcrpj2GWh7zETq+9j83WnyQ69Bw9NdOc9a7+Jx
 POPpIaE3O0tfkkLHpHzza4Xw+KWlSkSBCLt+lR3oBeZQvjtdpWZHZB5XLrFFHcQMBzhf
 IMfeLtMsTTYbrHBx3ZTjzGBk1pKWmSW719O8jLYn4uv2fgQC523UFTX3ULnyFo4d3HVd
 DYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ppKekkdyvFhkeosiKomCQMOUGLuIDXn9EHr3PuXEGrU=;
 b=WUe3oAOhy9wiPK9OMFyUX8eVZvRMmCBvYMwAXEIcrQJ4xXQ+SQEi82bZNPLv0Bn8EN
 dMZ06bKshYfpf5GfhdVgv8I4NRJ0lONgx1lrBIniXNAPrzvIlE4jyhpxaH8aFLXymR3N
 6Io8pZo/r/7jj9rL2Q7F3yNElt6jxouvF3Gyu64VgWrtf16yXpWEUiBaBF0IV+H1YXg1
 AnAJ8VuEWmwQKtb+3PVyAyR4hA6G36s6vt2zizWhf2xBfqFnpTsC12LZMJ0Z+Y9Lzd3n
 BpcuyzTuN3BFvG8CeXA3MNbfXRbkYMeQkZEdIEHW/3pqd6SjFHNoVNlvIISZNQM4PLDX
 EW6g==
X-Gm-Message-State: APjAAAWau1D5bMSlFx9DAG1UaBG6Wcup/WtTM7hdF7XbH3EZQ5w9I+XC
 3/lZh4wbJ4DjnLBpe1ZOE7nK3NBvUZEhmg==
X-Google-Smtp-Source: APXvYqwt2x+5DvCRaJgIa6yssiO8pyb5NsSL6ZP2HjJFZ8thii8V0+HJlVXHQwk4Mnyf40R/6ms0mA==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr12600853wrj.283.1571069063689; 
 Mon, 14 Oct 2019 09:04:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/68] hw/timer/arm_timer.c: Switch to transaction-based ptimer
 API
Date: Mon, 14 Oct 2019 17:03:03 +0100
Message-Id: <20191014160404.19553-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Switch the arm_timer.c code away from bottom-half based ptimers
to the new transaction-based ptimer API. This just requires
adding begin/commit calls around the various arms of
arm_timer_write() that modify the ptimer state, and using the
new ptimer_init() function to create the timer.

Fixes: https://bugs.launchpad.net/qemu/+bug/1777777
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-5-peter.maydell@linaro.org
---
 hw/timer/arm_timer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index dc33ab31050..af524fabf75 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -14,7 +14,6 @@
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
@@ -75,7 +74,10 @@ static uint32_t arm_timer_read(void *opaque, hwaddr offset)
     }
 }
 
-/* Reset the timer limit after settings have changed.  */
+/*
+ * Reset the timer limit after settings have changed.
+ * May only be called from inside a ptimer transaction block.
+ */
 static void arm_timer_recalibrate(arm_timer_state *s, int reload)
 {
     uint32_t limit;
@@ -102,13 +104,16 @@ static void arm_timer_write(void *opaque, hwaddr offset,
     switch (offset >> 2) {
     case 0: /* TimerLoad */
         s->limit = value;
+        ptimer_transaction_begin(s->timer);
         arm_timer_recalibrate(s, 1);
+        ptimer_transaction_commit(s->timer);
         break;
     case 1: /* TimerValue */
         /* ??? Linux seems to want to write to this readonly register.
            Ignore it.  */
         break;
     case 2: /* TimerControl */
+        ptimer_transaction_begin(s->timer);
         if (s->control & TIMER_CTRL_ENABLE) {
             /* Pause the timer if it is running.  This may cause some
                inaccuracy dure to rounding, but avoids a whole lot of other
@@ -128,13 +133,16 @@ static void arm_timer_write(void *opaque, hwaddr offset,
             /* Restart the timer if still enabled.  */
             ptimer_run(s->timer, (s->control & TIMER_CTRL_ONESHOT) != 0);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case 3: /* TimerIntClr */
         s->int_level = 0;
         break;
     case 6: /* TimerBGLoad */
         s->limit = value;
+        ptimer_transaction_begin(s->timer);
         arm_timer_recalibrate(s, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -166,14 +174,12 @@ static const VMStateDescription vmstate_arm_timer = {
 static arm_timer_state *arm_timer_init(uint32_t freq)
 {
     arm_timer_state *s;
-    QEMUBH *bh;
 
     s = (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
     s->freq = freq;
     s->control = TIMER_CTRL_IE;
 
-    bh = qemu_bh_new(arm_timer_tick, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_DEFAULT);
     vmstate_register(NULL, -1, &vmstate_arm_timer, s);
     return s;
 }
-- 
2.20.1


