Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E53ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF042133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc/z3Drr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF042133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK38A-00036v-4a
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pc-0003Ub-I4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pZ-0006u3-62
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pY-0006tD-Uj
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id v8so20389461wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YDpkoGzc05OBgCvdaXhaPuXJCQ9Ytyq/17y1wRe7eSw=;
 b=kc/z3Drr11V16uhsnH0u8z4Gq6pCT47PIaQuk46QERD8itc4yb7eswf09H9g6RGZKr
 NqxlKbQ6Tuljg8eiHJvYFk1qlML4N3MYMEbuJn06Uix8HOUv5K2t/8M2NlLqo21TG+Py
 s6fTPLW4J5KwgXXwhCYiApT1pD0BIqfBK7005qLJgqxnw3uS0xdRMvbhkj54JC4JhxG+
 LNtNWaK++NiHNtSNjT0eJ/3n9qjgIOx4OipfposS5Y20lw0/O/0h4vNyI+PmYEdA/Ub2
 FYxgYnMFjyGyPE3r5Uoqs+4ei6NppkQtULFNCAQBBQ7n9ShY3ZYOPAn8w+c0m1ucRar8
 9aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YDpkoGzc05OBgCvdaXhaPuXJCQ9Ytyq/17y1wRe7eSw=;
 b=EUq8qr+PreB508kqAi0mpRVorPnBBTer0LHmUV0p0goXeZFET4F8PDpkSOq7+REZ99
 +waUW6SMqH4NEAapA2RNLuc03eQFEE31MBl+moEdSelF9H6ultrJJVs39mWIi4DxLmJm
 lU6t8kYEdwoiI9DNHjUYdBT71I6YvX17DJ2PiHsfA71zr5maRInGeV4puoe/5Fnp9+S3
 1oELv63YwMQRdCtOyuzDXnU1ItRjKRpLEigy7/eOetc426XRfvV50hnWUqGMaShx0/w8
 7IdEufpPfNaRf1G9L4/mnMn1Zx0uFwvSHUpDSgDxOAazCrmUxZ1qxAITkhMvhDtSUTL9
 qdAQ==
X-Gm-Message-State: APjAAAUWN5+jXgnU5HXPVZ8RXsYxAWGe33/CaL/q0CtpQSVWaDzJkQxY
 F4n2kzteIA6GH3epcaHYpo5L24E3P2Mc3Q==
X-Google-Smtp-Source: APXvYqzNxqdnd6thVCNMkCUwbEZJdgOw6kg3obbz7FMWQIFv49PJUmL3pGRZJUjoINX2lF5s2PEqhw==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr15649759wrl.140.1571069058668; 
 Mon, 14 Oct 2019 09:04:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/68] ptimer: Provide new transaction-based API
Date: Mon, 14 Oct 2019 17:03:01 +0100
Message-Id: <20191014160404.19553-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Provide the new transaction-based API. If a ptimer is created
using ptimer_init() rather than ptimer_init_with_bh(), then
instead of providing a QEMUBH, it provides a pointer to the
callback function directly, and has opted into the transaction
API. All calls to functions which modify ptimer state:
 - ptimer_set_period()
 - ptimer_set_freq()
 - ptimer_set_limit()
 - ptimer_set_count()
 - ptimer_run()
 - ptimer_stop()
must be between matched calls to ptimer_transaction_begin()
and ptimer_transaction_commit(). When ptimer_transaction_commit()
is called it will evaluate the state of the timer after all the
changes in the transaction, and call the callback if necessary.

In the old API the individual update functions generally would
call ptimer_trigger() immediately, which would schedule the QEMUBH.
In the new API the update functions will instead defer the
"set s->next_event and call ptimer_reload()" work to
ptimer_transaction_commit().

Because ptimer_trigger() can now immediately call into the
device code which may then call other ptimer functions that
update ptimer_state fields, we must be more careful in
ptimer_reload() not to cache fields from ptimer_state across
the ptimer_trigger() call. (This was harmless with the QEMUBH
mechanism as the BH would not be invoked until much later.)

We use assertions to check that:
 * the functions modifying ptimer state are not called outside
   a transaction block
 * ptimer_transaction_begin() and _commit() calls are paired
 * the transaction API is not used with a QEMUBH ptimer

There is some slight repetition of code:
 * most of the set functions have similar looking "if s->bh
   call ptimer_reload, otherwise set s->need_reload" code
 * ptimer_init() and ptimer_init_with_bh() have similar code
We deliberately don't try to avoid this repetition, because
it will all be deleted when the QEMUBH version of the API
is removed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-3-peter.maydell@linaro.org
---
 include/hw/ptimer.h |  72 +++++++++++++++++++++
 hw/core/ptimer.c    | 152 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 209 insertions(+), 15 deletions(-)

diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 2fb9ba1915e..4c321f65dcb 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -91,6 +91,38 @@ typedef void (*ptimer_cb)(void *opaque);
  */
 ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask);
 
+/**
+ * ptimer_init - Allocate and return a new ptimer
+ * @callback: function to call on ptimer expiry
+ * @callback_opaque: opaque pointer passed to @callback
+ * @policy: PTIMER_POLICY_* bits specifying behaviour
+ *
+ * The ptimer returned must be freed using ptimer_free().
+ *
+ * If a ptimer is created using this API then will use the
+ * transaction-based API for modifying ptimer state: all calls
+ * to functions which modify ptimer state:
+ *  - ptimer_set_period()
+ *  - ptimer_set_freq()
+ *  - ptimer_set_limit()
+ *  - ptimer_set_count()
+ *  - ptimer_run()
+ *  - ptimer_stop()
+ * must be between matched calls to ptimer_transaction_begin()
+ * and ptimer_transaction_commit(). When ptimer_transaction_commit()
+ * is called it will evaluate the state of the timer after all the
+ * changes in the transaction, and call the callback if necessary.
+ *
+ * The callback function is always called from within a transaction
+ * begin/commit block, so the callback should not call the
+ * ptimer_transaction_begin() function itself. If the callback changes
+ * the ptimer state such that another ptimer expiry is triggered, then
+ * the callback will be called a second time after the first call returns.
+ */
+ptimer_state *ptimer_init(ptimer_cb callback,
+                          void *callback_opaque,
+                          uint8_t policy_mask);
+
 /**
  * ptimer_free - Free a ptimer
  * @s: timer to free
@@ -100,6 +132,28 @@ ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask);
  */
 void ptimer_free(ptimer_state *s);
 
+/**
+ * ptimer_transaction_begin() - Start a ptimer modification transaction
+ *
+ * This function must be called before making any calls to functions
+ * which modify the ptimer's state (see the ptimer_init() documentation
+ * for a list of these), and must always have a matched call to
+ * ptimer_transaction_commit().
+ * It is an error to call this function for a BH-based ptimer;
+ * attempting to do this will trigger an assert.
+ */
+void ptimer_transaction_begin(ptimer_state *s);
+
+/**
+ * ptimer_transaction_commit() - Commit a ptimer modification transaction
+ *
+ * This function must be called after calls to functions which modify
+ * the ptimer's state, and completes the update of the ptimer. If the
+ * ptimer state now means that we should trigger the timer expiry
+ * callback, it will be called directly.
+ */
+void ptimer_transaction_commit(ptimer_state *s);
+
 /**
  * ptimer_set_period - Set counter increment interval in nanoseconds
  * @s: ptimer to configure
@@ -108,6 +162,9 @@ void ptimer_free(ptimer_state *s);
  * Note that if your counter behaviour is specified as having a
  * particular frequency rather than a period then ptimer_set_freq()
  * may be more appropriate.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_period(ptimer_state *s, int64_t period);
 
@@ -121,6 +178,9 @@ void ptimer_set_period(ptimer_state *s, int64_t period);
  * as setting the frequency then this function is more appropriate,
  * because it allows specifying an effective period which is
  * precise to fractions of a nanosecond, avoiding rounding errors.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_freq(ptimer_state *s, uint32_t freq);
 
@@ -148,6 +208,9 @@ uint64_t ptimer_get_limit(ptimer_state *s);
  * Set the limit value of the down-counter. The @reload flag can
  * be used to emulate the behaviour of timers which immediately
  * reload the counter when their reload register is written to.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_limit(ptimer_state *s, uint64_t limit, int reload);
 
@@ -169,6 +232,9 @@ uint64_t ptimer_get_count(ptimer_state *s);
  * Set the value of the down-counter. If the counter is currently
  * enabled this will arrange for a timer callback at the appropriate
  * point in the future.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_count(ptimer_state *s, uint64_t count);
 
@@ -183,6 +249,9 @@ void ptimer_set_count(ptimer_state *s, uint64_t count);
  * the counter value will then be reloaded from the limit and it will
  * start counting down again. If @oneshot is non-zero, then the counter
  * will disable itself when it reaches zero.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_run(ptimer_state *s, int oneshot);
 
@@ -195,6 +264,9 @@ void ptimer_run(ptimer_state *s, int oneshot);
  *
  * Note that this can cause it to "lose" time, even if it is immediately
  * restarted.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_stop(ptimer_state *s);
 
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index f0d3ce11398..7239b8227cc 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -31,6 +31,16 @@ struct ptimer_state
     uint8_t policy_mask;
     QEMUBH *bh;
     QEMUTimer *timer;
+    ptimer_cb callback;
+    void *callback_opaque;
+    /*
+     * These track whether we're in a transaction block, and if we
+     * need to do a timer reload when the block finishes. They don't
+     * need to be migrated because migration can never happen in the
+     * middle of a transaction block.
+     */
+    bool in_transaction;
+    bool need_reload;
 };
 
 /* Use a bottom-half routine to avoid reentrancy issues.  */
@@ -39,13 +49,16 @@ static void ptimer_trigger(ptimer_state *s)
     if (s->bh) {
         replay_bh_schedule_event(s->bh);
     }
+    if (s->callback) {
+        s->callback(s->callback_opaque);
+    }
 }
 
 static void ptimer_reload(ptimer_state *s, int delta_adjust)
 {
-    uint32_t period_frac = s->period_frac;
-    uint64_t period = s->period;
-    uint64_t delta = s->delta;
+    uint32_t period_frac;
+    uint64_t period;
+    uint64_t delta;
     bool suppress_trigger = false;
 
     /*
@@ -58,11 +71,20 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
         (s->policy_mask & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT)) {
         suppress_trigger = true;
     }
-    if (delta == 0 && !(s->policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)
+    if (s->delta == 0 && !(s->policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)
         && !suppress_trigger) {
         ptimer_trigger(s);
     }
 
+    /*
+     * Note that ptimer_trigger() might call the device callback function,
+     * which can then modify timer state, so we must not cache any fields
+     * from ptimer_state until after we have called it.
+     */
+    delta = s->delta;
+    period = s->period;
+    period_frac = s->period_frac;
+
     if (delta == 0 && !(s->policy_mask & PTIMER_POLICY_NO_IMMEDIATE_RELOAD)) {
         delta = s->delta = s->limit;
     }
@@ -136,6 +158,15 @@ static void ptimer_tick(void *opaque)
     ptimer_state *s = (ptimer_state *)opaque;
     bool trigger = true;
 
+    /*
+     * We perform all the tick actions within a begin/commit block
+     * because the callback function that ptimer_trigger() calls
+     * might make calls into the ptimer APIs that provoke another
+     * trigger, and we want that to cause the callback function
+     * to be called iteratively, not recursively.
+     */
+    ptimer_transaction_begin(s);
+
     if (s->enabled == 2) {
         s->delta = 0;
         s->enabled = 0;
@@ -164,6 +195,8 @@ static void ptimer_tick(void *opaque)
     if (trigger) {
         ptimer_trigger(s);
     }
+
+    ptimer_transaction_commit(s);
 }
 
 uint64_t ptimer_get_count(ptimer_state *s)
@@ -263,10 +296,15 @@ uint64_t ptimer_get_count(ptimer_state *s)
 
 void ptimer_set_count(ptimer_state *s, uint64_t count)
 {
+    assert(s->in_transaction || !s->callback);
     s->delta = count;
     if (s->enabled) {
-        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        ptimer_reload(s, 0);
+        if (!s->callback) {
+            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ptimer_reload(s, 0);
+        } else {
+            s->need_reload = true;
+        }
     }
 }
 
@@ -274,6 +312,8 @@ void ptimer_run(ptimer_state *s, int oneshot)
 {
     bool was_disabled = !s->enabled;
 
+    assert(s->in_transaction || !s->callback);
+
     if (was_disabled && s->period == 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
@@ -282,8 +322,12 @@ void ptimer_run(ptimer_state *s, int oneshot)
     }
     s->enabled = oneshot ? 2 : 1;
     if (was_disabled) {
-        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        ptimer_reload(s, 0);
+        if (!s->callback) {
+            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ptimer_reload(s, 0);
+        } else {
+            s->need_reload = true;
+        }
     }
 }
 
@@ -291,35 +335,50 @@ void ptimer_run(ptimer_state *s, int oneshot)
    is immediately restarted.  */
 void ptimer_stop(ptimer_state *s)
 {
+    assert(s->in_transaction || !s->callback);
+
     if (!s->enabled)
         return;
 
     s->delta = ptimer_get_count(s);
     timer_del(s->timer);
     s->enabled = 0;
+    if (s->callback) {
+        s->need_reload = false;
+    }
 }
 
 /* Set counter increment interval in nanoseconds.  */
 void ptimer_set_period(ptimer_state *s, int64_t period)
 {
+    assert(s->in_transaction || !s->callback);
     s->delta = ptimer_get_count(s);
     s->period = period;
     s->period_frac = 0;
     if (s->enabled) {
-        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        ptimer_reload(s, 0);
+        if (!s->callback) {
+            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ptimer_reload(s, 0);
+        } else {
+            s->need_reload = true;
+        }
     }
 }
 
 /* Set counter frequency in Hz.  */
 void ptimer_set_freq(ptimer_state *s, uint32_t freq)
 {
+    assert(s->in_transaction || !s->callback);
     s->delta = ptimer_get_count(s);
     s->period = 1000000000ll / freq;
     s->period_frac = (1000000000ll << 32) / freq;
     if (s->enabled) {
-        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        ptimer_reload(s, 0);
+        if (!s->callback) {
+            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ptimer_reload(s, 0);
+        } else {
+            s->need_reload = true;
+        }
     }
 }
 
@@ -327,12 +386,17 @@ void ptimer_set_freq(ptimer_state *s, uint32_t freq)
    count = limit.  */
 void ptimer_set_limit(ptimer_state *s, uint64_t limit, int reload)
 {
+    assert(s->in_transaction || !s->callback);
     s->limit = limit;
     if (reload)
         s->delta = limit;
     if (s->enabled && reload) {
-        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        ptimer_reload(s, 0);
+        if (!s->callback) {
+            s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ptimer_reload(s, 0);
+        } else {
+            s->need_reload = true;
+        }
     }
 }
 
@@ -341,6 +405,32 @@ uint64_t ptimer_get_limit(ptimer_state *s)
     return s->limit;
 }
 
+void ptimer_transaction_begin(ptimer_state *s)
+{
+    assert(!s->in_transaction || !s->callback);
+    s->in_transaction = true;
+    s->need_reload = false;
+}
+
+void ptimer_transaction_commit(ptimer_state *s)
+{
+    assert(s->in_transaction);
+    /*
+     * We must loop here because ptimer_reload() can call the callback
+     * function, which might then update ptimer state in a way that
+     * means we need to do another reload and possibly another callback.
+     * A disabled timer never needs reloading (and if we don't check
+     * this then we loop forever if ptimer_reload() disables the timer).
+     */
+    while (s->need_reload && s->enabled) {
+        s->need_reload = false;
+        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        ptimer_reload(s, 0);
+    }
+    /* Now we've finished reload we can leave the transaction block. */
+    s->in_transaction = false;
+}
+
 const VMStateDescription vmstate_ptimer = {
     .name = "ptimer",
     .version_id = 1,
@@ -377,9 +467,41 @@ ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask)
     return s;
 }
 
+ptimer_state *ptimer_init(ptimer_cb callback, void *callback_opaque,
+                          uint8_t policy_mask)
+{
+    ptimer_state *s;
+
+    /*
+     * The callback function is mandatory; so we use it to distinguish
+     * old-style QEMUBH ptimers from new transaction API ptimers.
+     * (ptimer_init_with_bh() allows a NULL bh pointer and at least
+     * one device (digic-timer) passes NULL, so it's not the case
+     * that either s->bh != NULL or s->callback != NULL.)
+     */
+    assert(callback);
+
+    s = g_new0(ptimer_state, 1);
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ptimer_tick, s);
+    s->policy_mask = policy_mask;
+    s->callback = callback;
+    s->callback_opaque = callback_opaque;
+
+    /*
+     * These two policies are incompatible -- trigger-on-decrement implies
+     * a timer trigger when the count becomes 0, but no-immediate-trigger
+     * implies a trigger when the count stops being 0.
+     */
+    assert(!((policy_mask & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT) &&
+             (policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)));
+    return s;
+}
+
 void ptimer_free(ptimer_state *s)
 {
-    qemu_bh_delete(s->bh);
+    if (s->bh) {
+        qemu_bh_delete(s->bh);
+    }
     timer_free(s->timer);
     g_free(s);
 }
-- 
2.20.1


