Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F2C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DB02070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjkGs1W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DB02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMRw-0005KX-3L
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGM4x-0003aJ-Eg
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGM4v-000172-1g
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGM4u-00016f-Qo
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id m18so5526571wmc.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aZ62Msi6+VMnCAAUmgOLUV4qO75/pTiQ0YCB2BZ1mjM=;
 b=SjkGs1W65IL/u/a4xu8YoHSuiFwdRvy9o2hk4tLqPV1ShQ/kNx6S+Mww4foH6r6xED
 LuwWpzB7V5vVvTtsJpGvL5tYEHEKqZ6CPCTccfVzvPb/ZnSRtwQzpwr0cDOdhMcpno++
 2jg2uzeY5dkQ1eeH58gwIS0NW0tN6N0qwejbbDu0oVIIOIKRdTJ9WXnBXW9kHA0/Ykda
 4zhmPjlUp5b7RhLFVCJelKn+sTePQHJBpeeD3IVXX2nlckpwzB3ecbXS/KHr6vGLMrG/
 zR2Xeq7FCQPRhQ1f+grxxj8MHKH1IDwAKc+uV++5pyoGfpcNW6Ps6WypH4+UsDVeunFO
 PETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aZ62Msi6+VMnCAAUmgOLUV4qO75/pTiQ0YCB2BZ1mjM=;
 b=nMAcVosagYBEekugu9VuiEuNr0OriQookVd6JE+kpmGJ1SdXsVBrptGYqTNsmEoMoF
 VNYP/Q3iWYl7TAYFwobovdhOgAmpu4EoH9eW+ErvjRzRpWItKNty8fR/FHc9nn6axnxO
 urIhySYqMcJibt8J2YJDLgN21nEvEksPb4leGUBTDFC6s7pX2I+40OKIBC+WWD51pOpu
 qv/yrVyBRi7jnnA3kW/Hq+zQl13q+VahrYcat0Dz6w9HVoaHOOHkfG4/wWLYu/BUtDDz
 soZG4dt6Zzaw7pNkzytTcQ29vjKES5s6i5XmMGXbQykpZoG+YoEsq5u1pYs1vQMUdlr2
 NyIg==
X-Gm-Message-State: APjAAAV25oazygCencdiJ4XoEYiniYTEzd3/7OdyKjYsmwKfMyvpHhy8
 wJDgsngx8ugezrQQhwAZMMZqPA==
X-Google-Smtp-Source: APXvYqzdYcw65dFIEp+ZMbNGEjUW1Ich7+NTKb8jxHfedvrgl+ruX7T159fPPWI/rIaUPt8X6JCYBQ==
X-Received: by 2002:a1c:980e:: with SMTP id a14mr10063954wme.99.1570189735425; 
 Fri, 04 Oct 2019 04:48:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t17sm11962094wrp.72.2019.10.04.04.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 04:48:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC 3/4] ptimer: Provide new transaction-based API
Date: Fri,  4 Oct 2019 12:48:47 +0100
Message-Id: <20191004114848.16831-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004114848.16831-1-peter.maydell@linaro.org>
References: <20191004114848.16831-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
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
---
 include/hw/ptimer.h |  66 +++++++++++++++++++++++++
 hw/core/ptimer.c    | 114 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 169 insertions(+), 11 deletions(-)

diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 2fb9ba1915e..b9cd301ab02 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -91,6 +91,32 @@ typedef void (*ptimer_cb)(void *opaque);
  */
 ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask);
 
+/**
+ * ptimer_init - Allocate and return a new ptimer
+ * @callback: function to call on ptimer expiry
+ * @callback_data: opaque pointer passed to @callback
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
+ */
+ptimer_state *ptimer_init(ptimer_cb callback,
+                          void *callback_opaque,
+                          uint8_t policy_mask);
+
 /**
  * ptimer_free - Free a ptimer
  * @s: timer to free
@@ -100,6 +126,28 @@ ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask);
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
@@ -108,6 +156,9 @@ void ptimer_free(ptimer_state *s);
  * Note that if your counter behaviour is specified as having a
  * particular frequency rather than a period then ptimer_set_freq()
  * may be more appropriate.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_period(ptimer_state *s, int64_t period);
 
@@ -121,6 +172,9 @@ void ptimer_set_period(ptimer_state *s, int64_t period);
  * as setting the frequency then this function is more appropriate,
  * because it allows specifying an effective period which is
  * precise to fractions of a nanosecond, avoiding rounding errors.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_freq(ptimer_state *s, uint32_t freq);
 
@@ -148,6 +202,9 @@ uint64_t ptimer_get_limit(ptimer_state *s);
  * Set the limit value of the down-counter. The @reload flag can
  * be used to emulate the behaviour of timers which immediately
  * reload the counter when their reload register is written to.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_limit(ptimer_state *s, uint64_t limit, int reload);
 
@@ -169,6 +226,9 @@ uint64_t ptimer_get_count(ptimer_state *s);
  * Set the value of the down-counter. If the counter is currently
  * enabled this will arrange for a timer callback at the appropriate
  * point in the future.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_set_count(ptimer_state *s, uint64_t count);
 
@@ -183,6 +243,9 @@ void ptimer_set_count(ptimer_state *s, uint64_t count);
  * the counter value will then be reloaded from the limit and it will
  * start counting down again. If @oneshot is non-zero, then the counter
  * will disable itself when it reaches zero.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_run(ptimer_state *s, int oneshot);
 
@@ -195,6 +258,9 @@ void ptimer_run(ptimer_state *s, int oneshot);
  *
  * Note that this can cause it to "lose" time, even if it is immediately
  * restarted.
+ *
+ * This function will assert if it is called outside a
+ * ptimer_transaction_begin/commit block, unless this is a bottom-half ptimer.
  */
 void ptimer_stop(ptimer_state *s);
 
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index f0d3ce11398..89228132650 100644
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
@@ -39,6 +49,9 @@ static void ptimer_trigger(ptimer_state *s)
     if (s->bh) {
         replay_bh_schedule_event(s->bh);
     }
+    if (s->callback) {
+        s->callback(s->callback_opaque);
+    }
 }
 
 static void ptimer_reload(ptimer_state *s, int delta_adjust)
@@ -263,10 +276,15 @@ uint64_t ptimer_get_count(ptimer_state *s)
 
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
 
@@ -274,6 +292,8 @@ void ptimer_run(ptimer_state *s, int oneshot)
 {
     bool was_disabled = !s->enabled;
 
+    assert(s->in_transaction || !s->callback);
+
     if (was_disabled && s->period == 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
@@ -282,8 +302,12 @@ void ptimer_run(ptimer_state *s, int oneshot)
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
 
@@ -291,35 +315,50 @@ void ptimer_run(ptimer_state *s, int oneshot)
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
 
@@ -327,12 +366,17 @@ void ptimer_set_freq(ptimer_state *s, uint32_t freq)
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
 
@@ -341,6 +385,22 @@ uint64_t ptimer_get_limit(ptimer_state *s)
     return s->limit;
 }
 
+void ptimer_transaction_begin(ptimer_state *s)
+{
+    assert(!s->in_transaction && s->callback);
+    s->in_transaction = true;
+}
+
+void ptimer_transaction_commit(ptimer_state *s)
+{
+    assert(s->in_transaction);
+    s->in_transaction = false;
+    if (s->need_reload) {
+        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        ptimer_reload(s, 0);
+    }
+}
+
 const VMStateDescription vmstate_ptimer = {
     .name = "ptimer",
     .version_id = 1,
@@ -377,9 +437,41 @@ ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask)
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


