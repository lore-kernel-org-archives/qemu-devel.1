Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829AC17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E962067B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8E+XXuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E962067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAE2-0000xZ-H3
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUACo-000846-KV
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUACm-0006Lt-A9
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUACm-0006LY-38
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id t1so14760177wrv.4
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jXiECD5vexW+GXBCZCMbsqDmlGQb1rFrS+VaoexST1k=;
 b=Q8E+XXuCerjFaqFA+kurlwE++6y0DUCg3gJvWrF5Q3Iay8JhBbUfCwud7dNk3MmPMe
 0FwncSTHrp1wHKahqA2zhhMS+Np6QaLrjPE7khckLII34CNQQwgOtDwhEtwTuCgbwNTg
 bsDV/0+ES4cxLLgkl1RWPNXR7sVdvRpO98ewzlj2zYUweu7Z7U9/N0jJDccbLBTJUKJ/
 CbKZzWdNvSu9DSBQvvu3uDpGiCvzPd93pMyrqrCrTbIjR0BqynIeG4FWBx9eaBZrYuMB
 yFt2oVOFeeZ+/5cAOtUiUc54G7VoN3WKTCVx2xynbh3XyfGBSltpi++EgbJO6bDSKWZd
 f7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jXiECD5vexW+GXBCZCMbsqDmlGQb1rFrS+VaoexST1k=;
 b=B4bYdho5kV3qH5h3SfydzQX6sHB1rgZkfMv23YzoxkkCr7Qc1nJVjipMMDnDvpBNBK
 CW5PnxDLqyB/LkrJCVfat6uzjTzQKLEcKiUDHftmDbsVgu38HqltR6uu/mPmVeFdD0yA
 pxewOg1JDQXMbjj0JzQ6T8IuKV7wA7zYQD9FH+jTGEYYmgxh5e2TbTnftx1pZ7YZOTfd
 HAkpwzgZfOgqhfQ20j1V3h3wehKdEhO5HQwXH83HLX/+ZHQgto+DuV9+xl+skM1A4Vc9
 WAF64bY1nAdYW565cM6vkTTmB7wXWC3/TCXXGgfsM6BGbMibwbR0osBd9CZVV4in4aqx
 Cunw==
X-Gm-Message-State: APjAAAVW0OKqrrZPs94vHUeK0e3qXik0nDGKzAvxHLKtnVignlkX2yw/
 gsme4pPK6rFHG2x1Ls69+s6VyKta1KnC8g==
X-Google-Smtp-Source: APXvYqxJ8u6tcGtgYEZDFzwRqA9wT2Wo9kFK40PNY9dBg2H8wlKcYxSfKd0JdqZWgndFLjWPWASk4Q==
X-Received: by 2002:adf:e386:: with SMTP id e6mr19916068wrm.397.1573480686584; 
 Mon, 11 Nov 2019 05:58:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t29sm20544857wrb.53.2019.11.11.05.58.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 05:58:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] ptimer: Remove old ptimer_init_with_bh() API
Date: Mon, 11 Nov 2019 13:58:01 +0000
Message-Id: <20191111135803.14414-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111135803.14414-1-peter.maydell@linaro.org>
References: <20191111135803.14414-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

Now all the users of ptimers have converted to the transaction-based
API, we can remove ptimer_init_with_bh() and all the code paths
that are used only by bottom-half based ptimers, and tidy up the
documentation comments to consider the transaction-based API the
only possibility.

The code changes result from:
 * s->bh no longer exists
 * s->callback is now always non-NULL

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191025142411.17085-1-peter.maydell@linaro.org
---
 include/hw/ptimer.h | 45 +++++++++++-----------
 hw/core/ptimer.c    | 91 ++++++++-------------------------------------
 2 files changed, 36 insertions(+), 100 deletions(-)

diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 4c321f65dcb..412763fffb2 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -10,15 +10,24 @@
 
 #include "qemu/timer.h"
 
-/* The ptimer API implements a simple periodic countdown timer.
+/*
+ * The ptimer API implements a simple periodic countdown timer.
  * The countdown timer has a value (which can be read and written via
  * ptimer_get_count() and ptimer_set_count()). When it is enabled
  * using ptimer_run(), the value will count downwards at the frequency
  * which has been configured using ptimer_set_period() or ptimer_set_freq().
- * When it reaches zero it will trigger a QEMU bottom half handler, and
+ * When it reaches zero it will trigger a callback function, and
  * can be set to either reload itself from a specified limit value
  * and keep counting down, or to stop (as a one-shot timer).
  *
+ * A transaction-based API is used for modifying ptimer state: all calls
+ * to functions which modify ptimer state must be between matched calls to
+ * ptimer_transaction_begin() and ptimer_transaction_commit().
+ * When ptimer_transaction_commit() is called it will evaluate the state
+ * of the timer after all the changes in the transaction, and call the
+ * callback if necessary. (See the ptimer_init() documentation for the full
+ * list of state-modifying functions and detailed semantics of the callback.)
+ *
  * Forgetting to set the period/frequency (or setting it to zero) is a
  * bug in the QEMU device and will cause warning messages to be printed
  * to stderr when the guest attempts to enable the timer.
@@ -72,7 +81,7 @@
  * ptimer_set_count() or ptimer_set_limit() will not trigger the timer
  * (though it will cause a reload). Only a counter decrement to "0"
  * will cause a trigger. Not compatible with NO_IMMEDIATE_TRIGGER;
- * ptimer_init_with_bh() will assert() that you don't set both.
+ * ptimer_init() will assert() that you don't set both.
  */
 #define PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT (1 << 5)
 
@@ -80,17 +89,6 @@
 typedef struct ptimer_state ptimer_state;
 typedef void (*ptimer_cb)(void *opaque);
 
-/**
- * ptimer_init_with_bh - Allocate and return a new ptimer
- * @bh: QEMU bottom half which is run on timer expiry
- * @policy: PTIMER_POLICY_* bits specifying behaviour
- *
- * The ptimer returned must be freed using ptimer_free().
- * The ptimer takes ownership of @bh and will delete it
- * when the ptimer is eventually freed.
- */
-ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask);
-
 /**
  * ptimer_init - Allocate and return a new ptimer
  * @callback: function to call on ptimer expiry
@@ -127,8 +125,7 @@ ptimer_state *ptimer_init(ptimer_cb callback,
  * ptimer_free - Free a ptimer
  * @s: timer to free
  *
- * Free a ptimer created using ptimer_init_with_bh() (including
- * deleting the bottom half which it is using).
+ * Free a ptimer created using ptimer_init().
  */
 void ptimer_free(ptimer_state *s);
 
@@ -164,7 +161,7 @@ void ptimer_transaction_commit(ptimer_state *s);
  * may be more appropriate.
  *
  * This function will assert if it is called outside a
- * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
+ * ptimer_transaction_begin/commit block.
  */
 void ptimer_set_period(ptimer_state *s, int64_t period);
 
@@ -180,7 +177,7 @@ void ptimer_set_period(ptimer_state *s, int64_t period);
  * precise to fractions of a nanosecond, avoiding rounding errors.
  *
  * This function will assert if it is called outside a
- * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
+ * ptimer_transaction_begin/commit block.
  */
 void ptimer_set_freq(ptimer_state *s, uint32_t freq);
 
@@ -210,7 +207,7 @@ uint64_t ptimer_get_limit(ptimer_state *s);
  * reload the counter when their reload register is written to.
  *
  * This function will assert if it is called outside a
- * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
+ * ptimer_transaction_begin/commit block.
  */
 void ptimer_set_limit(ptimer_state *s, uint64_t limit, int reload);
 
@@ -234,7 +231,7 @@ uint64_t ptimer_get_count(ptimer_state *s);
  * point in the future.
  *
  * This function will assert if it is called outside a
- * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
+ * ptimer_transaction_begin/commit block.
  */
 void ptimer_set_count(ptimer_state *s, uint64_t count);
 
@@ -243,15 +240,15 @@ void ptimer_set_count(ptimer_state *s, uint64_t count);
  * @s: ptimer
  * @oneshot: non-zero if this timer should only count down once
  *
- * Start a ptimer counting down; when it reaches zero the bottom half
- * passed to ptimer_init_with_bh() will be invoked.
+ * Start a ptimer counting down; when it reaches zero the callback function
+ * passed to ptimer_init() will be invoked.
  * If the @oneshot argument is zero,
  * the counter value will then be reloaded from the limit and it will
  * start counting down again. If @oneshot is non-zero, then the counter
  * will disable itself when it reaches zero.
  *
  * This function will assert if it is called outside a
- * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
+ * ptimer_transaction_begin/commit block.
  */
 void ptimer_run(ptimer_state *s, int oneshot);
 
@@ -266,7 +263,7 @@ void ptimer_run(ptimer_state *s, int oneshot);
  * restarted.
  *
  * This function will assert if it is called outside a
- * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
+ * ptimer_transaction_begin/commit block.
  */
 void ptimer_stop(ptimer_state *s);
 
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7239b8227cc..b5a54e25369 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -29,7 +29,6 @@ struct ptimer_state
     int64_t last_event;
     int64_t next_event;
     uint8_t policy_mask;
-    QEMUBH *bh;
     QEMUTimer *timer;
     ptimer_cb callback;
     void *callback_opaque;
@@ -46,12 +45,7 @@ struct ptimer_state
 /* Use a bottom-half routine to avoid reentrancy issues.  */
 static void ptimer_trigger(ptimer_state *s)
 {
-    if (s->bh) {
-        replay_bh_schedule_event(s->bh);
-    }
-    if (s->callback) {
-        s->callback(s->callback_opaque);
-    }
+    s->callback(s->callback_opaque);
 }
 
 static void ptimer_reload(ptimer_state *s, int delta_adjust)
@@ -296,15 +290,10 @@ uint64_t ptimer_get_count(ptimer_state *s)
 
 void ptimer_set_count(ptimer_state *s, uint64_t count)
 {
-    assert(s->in_transaction || !s->callback);
+    assert(s->in_transaction);
     s->delta = count;
     if (s->enabled) {
-        if (!s->callback) {
-            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            ptimer_reload(s, 0);
-        } else {
-            s->need_reload = true;
-        }
+        s->need_reload = true;
     }
 }
 
@@ -312,7 +301,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
 {
     bool was_disabled = !s->enabled;
 
-    assert(s->in_transaction || !s->callback);
+    assert(s->in_transaction);
 
     if (was_disabled && s->period == 0) {
         if (!qtest_enabled()) {
@@ -322,12 +311,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
     }
     s->enabled = oneshot ? 2 : 1;
     if (was_disabled) {
-        if (!s->callback) {
-            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            ptimer_reload(s, 0);
-        } else {
-            s->need_reload = true;
-        }
+        s->need_reload = true;
     }
 }
 
@@ -335,7 +319,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
    is immediately restarted.  */
 void ptimer_stop(ptimer_state *s)
 {
-    assert(s->in_transaction || !s->callback);
+    assert(s->in_transaction);
 
     if (!s->enabled)
         return;
@@ -343,42 +327,30 @@ void ptimer_stop(ptimer_state *s)
     s->delta = ptimer_get_count(s);
     timer_del(s->timer);
     s->enabled = 0;
-    if (s->callback) {
-        s->need_reload = false;
-    }
+    s->need_reload = false;
 }
 
 /* Set counter increment interval in nanoseconds.  */
 void ptimer_set_period(ptimer_state *s, int64_t period)
 {
-    assert(s->in_transaction || !s->callback);
+    assert(s->in_transaction);
     s->delta = ptimer_get_count(s);
     s->period = period;
     s->period_frac = 0;
     if (s->enabled) {
-        if (!s->callback) {
-            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            ptimer_reload(s, 0);
-        } else {
-            s->need_reload = true;
-        }
+        s->need_reload = true;
     }
 }
 
 /* Set counter frequency in Hz.  */
 void ptimer_set_freq(ptimer_state *s, uint32_t freq)
 {
-    assert(s->in_transaction || !s->callback);
+    assert(s->in_transaction);
     s->delta = ptimer_get_count(s);
     s->period = 1000000000ll / freq;
     s->period_frac = (1000000000ll << 32) / freq;
     if (s->enabled) {
-        if (!s->callback) {
-            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            ptimer_reload(s, 0);
-        } else {
-            s->need_reload = true;
-        }
+        s->need_reload = true;
     }
 }
 
@@ -386,17 +358,12 @@ void ptimer_set_freq(ptimer_state *s, uint32_t freq)
    count = limit.  */
 void ptimer_set_limit(ptimer_state *s, uint64_t limit, int reload)
 {
-    assert(s->in_transaction || !s->callback);
+    assert(s->in_transaction);
     s->limit = limit;
     if (reload)
         s->delta = limit;
     if (s->enabled && reload) {
-        if (!s->callback) {
-            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            ptimer_reload(s, 0);
-        } else {
-            s->need_reload = true;
-        }
+        s->need_reload = true;
     }
 }
 
@@ -407,7 +374,7 @@ uint64_t ptimer_get_limit(ptimer_state *s)
 
 void ptimer_transaction_begin(ptimer_state *s)
 {
-    assert(!s->in_transaction || !s->callback);
+    assert(!s->in_transaction);
     s->in_transaction = true;
     s->need_reload = false;
 }
@@ -448,37 +415,12 @@ const VMStateDescription vmstate_ptimer = {
     }
 };
 
-ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask)
-{
-    ptimer_state *s;
-
-    s = (ptimer_state *)g_malloc0(sizeof(ptimer_state));
-    s->bh = bh;
-    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ptimer_tick, s);
-    s->policy_mask = policy_mask;
-
-    /*
-     * These two policies are incompatible -- trigger-on-decrement implies
-     * a timer trigger when the count becomes 0, but no-immediate-trigger
-     * implies a trigger when the count stops being 0.
-     */
-    assert(!((policy_mask & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT) &&
-             (policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)));
-    return s;
-}
-
 ptimer_state *ptimer_init(ptimer_cb callback, void *callback_opaque,
                           uint8_t policy_mask)
 {
     ptimer_state *s;
 
-    /*
-     * The callback function is mandatory; so we use it to distinguish
-     * old-style QEMUBH ptimers from new transaction API ptimers.
-     * (ptimer_init_with_bh() allows a NULL bh pointer and at least
-     * one device (digic-timer) passes NULL, so it's not the case
-     * that either s->bh != NULL or s->callback != NULL.)
-     */
+    /* The callback function is mandatory. */
     assert(callback);
 
     s = g_new0(ptimer_state, 1);
@@ -499,9 +441,6 @@ ptimer_state *ptimer_init(ptimer_cb callback, void *callback_opaque,
 
 void ptimer_free(ptimer_state *s)
 {
-    if (s->bh) {
-        qemu_bh_delete(s->bh);
-    }
     timer_free(s->timer);
     g_free(s);
 }
-- 
2.20.1


