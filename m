Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D2C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EDE217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljUjknKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EDE217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtA7-0000cM-Uy
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7R-0006cH-6v
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7N-0002Ck-MZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7N-0002CF-8c
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id y21so3949412wmi.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qwANpzWfIEeRGUJ6saOUlObSLOjFsXhXk8QCpbryjDk=;
 b=ljUjknKZZ8tliKRFUJSOiiUKxRiENcfs9yEe5dTrY+Qy8yWxmKi4NPhtyPrUQxXsb/
 X8AzHEQAr1jt8RVLPluxhq/dkf5EmZ5T9mDfXZHlHiGhKZBaEiHc40gvrj5lFP4yAky2
 QYmKqI436vidElkEaAUx0LvbE9JHXchESkFGFd0sj76ux9CSDlL0Z9xcu8YnGr4rlpHy
 dvq0Ci61d+W/37RMtua++UfCc8LW4qWh9yh2pJh0zQ0rgyckrG4dhayIHzebBbGKXL2h
 rQ3qsQtFGRbZbSkG9eALvWrKC4RMTDo/VovDUJ+JBzr1NpBZqthVp+jnNsprDBbgrm4X
 aBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qwANpzWfIEeRGUJ6saOUlObSLOjFsXhXk8QCpbryjDk=;
 b=EsxaXxQ200y/PFZzdBhjwGJ8JQb1+YUjnzGffs1hZBODa9bPGGB95edOokTZNC5uxw
 4Iy50G77na2JSA2kF1wq+A7C1v+FG4SAskiCXUkWsTdNCgieZgHyLXV1m/HMTsmF5t1D
 pqAVx+NBP8u1v1Ry1xG+c0/thevZ5CaVZ3wpbIgscKhnD//b0vwTI1fbtanjTCcJildW
 iol8Xci43Tq3VEEf7u9Nq0oYfAOM0JI/OHoDFNgvXSoHAWvcR8WptPC7+mOit1TGMFmy
 Mrh1rYbSj0+mqq835sWQV2TVsGqSQrXUmBajqgNL001iybZ3wNQhwU1NeadRBoQiHHs6
 JGAA==
X-Gm-Message-State: APjAAAWEzF+LE7VVHL6kZ5182rK7QnJvVgALhlNjT3ruk8sGoWziyJwN
 ncuqau7IHSuN8p6fX0PKaQc5UQ==
X-Google-Smtp-Source: APXvYqxdUjoHtx/6QQnsxhyaNR/9J07lU1RcDHCH26bq667rT1Sfz1Qi+3C2FNgG6evucGyQCGLyrA==
X-Received: by 2002:a7b:c4d4:: with SMTP id g20mr4252433wmk.123.1570555068010; 
 Tue, 08 Oct 2019 10:17:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/21] tests/ptimer-test: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:22 +0100
Message-Id: <20191008171740.9679-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Convert the ptimer test cases to the transaction-based ptimer API,
by changing to ptimer_init(), dropping the now-unused QEMUBH
variables, and surrounding each set of changes to the ptimer
state in ptimer_transaction_begin/commit calls.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/ptimer-test.c | 106 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 22 deletions(-)

diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index a3c82d1d147..e16c30ce573 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -67,12 +67,13 @@ static void qemu_clock_step(uint64_t ns)
 static void check_set_count(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 1000);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 1000);
     g_assert_false(triggered);
     ptimer_free(ptimer);
@@ -81,17 +82,20 @@ static void check_set_count(gconstpointer arg)
 static void check_set_limit(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_limit(ptimer, 1000, 0);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
     g_assert_cmpuint(ptimer_get_limit(ptimer), ==, 1000);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_limit(ptimer, 2000, 1);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 2000);
     g_assert_cmpuint(ptimer_get_limit(ptimer), ==, 2000);
     g_assert_false(triggered);
@@ -101,22 +105,25 @@ static void check_set_limit(gconstpointer arg)
 static void check_oneshot(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_set_count(ptimer, 10);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 2 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 8 : 7);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_stop(ptimer);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 8 : 7);
     g_assert_false(triggered);
@@ -126,7 +133,9 @@ static void check_oneshot(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 8 : 7);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 7 + 1);
 
@@ -157,28 +166,36 @@ static void check_oneshot(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 10);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(20000000 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 10);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_limit(ptimer, 9, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(20000000 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 9);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 8 : 7);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 20);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 19 + 1);
 
@@ -190,7 +207,9 @@ static void check_oneshot(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
     g_assert_true(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_stop(ptimer);
+    ptimer_transaction_commit(ptimer);
 
     triggered = false;
 
@@ -204,8 +223,7 @@ static void check_oneshot(gconstpointer arg)
 static void check_periodic(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool wrap_policy = (*policy & PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool no_immediate_reload = (*policy & PTIMER_POLICY_NO_IMMEDIATE_RELOAD);
@@ -214,9 +232,11 @@ static void check_periodic(gconstpointer arg)
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_set_limit(ptimer, 10, 1);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 10);
     g_assert_false(triggered);
@@ -245,7 +265,9 @@ static void check_periodic(gconstpointer arg)
                     (no_round_down ? 9 : 8) + (wrap_policy ? 1 : 0));
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 20);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 20);
     g_assert_false(triggered);
@@ -268,7 +290,9 @@ static void check_periodic(gconstpointer arg)
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 3);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 3);
     g_assert_false(triggered);
@@ -284,7 +308,9 @@ static void check_periodic(gconstpointer arg)
                     (no_round_down ? 9 : 8) + (wrap_policy ? 1 : 0));
     g_assert_true(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_stop(ptimer);
+    ptimer_transaction_commit(ptimer);
     triggered = false;
 
     qemu_clock_step(2000000);
@@ -293,8 +319,10 @@ static void check_periodic(gconstpointer arg)
                     (no_round_down ? 9 : 8) + (wrap_policy ? 1 : 0));
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 3);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 3 + 1);
 
@@ -310,7 +338,9 @@ static void check_periodic(gconstpointer arg)
                     (no_round_down ? 9 : 8) + (wrap_policy ? 1 : 0));
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      no_immediate_reload ? 0 : 10);
 
@@ -348,7 +378,9 @@ static void check_periodic(gconstpointer arg)
                     (no_round_down ? 8 : 7) + (wrap_policy ? 1 : 0));
     g_assert_true(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_stop(ptimer);
+    ptimer_transaction_commit(ptimer);
 
     triggered = false;
 
@@ -358,8 +390,13 @@ static void check_periodic(gconstpointer arg)
                     (no_round_down ? 8 : 7) + (wrap_policy ? 1 : 0));
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
+
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 + 1);
 
@@ -372,23 +409,26 @@ static void check_periodic(gconstpointer arg)
 static void check_on_the_fly_mode_change(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool wrap_policy = (*policy & PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_set_limit(ptimer, 10, 1);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 9 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 1 : 0);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 1 : 0);
     g_assert_false(triggered);
@@ -403,7 +443,9 @@ static void check_on_the_fly_mode_change(gconstpointer arg)
 
     qemu_clock_step(2000000 * 9);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      (no_round_down ? 1 : 0) + (wrap_policy ? 1 : 0));
@@ -419,22 +461,25 @@ static void check_on_the_fly_mode_change(gconstpointer arg)
 static void check_on_the_fly_period_change(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_set_limit(ptimer, 8, 1);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 4 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 4 : 3);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 4000000);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 4 : 3);
 
     qemu_clock_step(4000000 * 2 + 1);
@@ -452,22 +497,25 @@ static void check_on_the_fly_period_change(gconstpointer arg)
 static void check_on_the_fly_freq_change(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_freq(ptimer, 500);
     ptimer_set_limit(ptimer, 8, 1);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 4 + 1);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 4 : 3);
     g_assert_false(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_freq(ptimer, 250);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 4 : 3);
 
     qemu_clock_step(2000000 * 4 + 1);
@@ -485,13 +533,14 @@ static void check_on_the_fly_freq_change(gconstpointer arg)
 static void check_run_with_period_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 99);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(10 * NANOSECONDS_PER_SECOND);
 
@@ -503,8 +552,7 @@ static void check_run_with_period_0(gconstpointer arg)
 static void check_run_with_delta_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool wrap_policy = (*policy & PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool no_immediate_reload = (*policy & PTIMER_POLICY_NO_IMMEDIATE_RELOAD);
@@ -513,9 +561,11 @@ static void check_run_with_delta_0(gconstpointer arg)
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_set_limit(ptimer, 99, 0);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      no_immediate_reload ? 0 : 99);
 
@@ -541,8 +591,10 @@ static void check_run_with_delta_0(gconstpointer arg)
             g_assert_false(triggered);
         }
 
+        ptimer_transaction_begin(ptimer);
         ptimer_set_count(ptimer, 99);
         ptimer_run(ptimer, 1);
+        ptimer_transaction_commit(ptimer);
     }
 
     qemu_clock_step(2000000 + 1);
@@ -562,8 +614,10 @@ static void check_run_with_delta_0(gconstpointer arg)
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 0);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      no_immediate_reload ? 0 : 99);
 
@@ -602,23 +656,26 @@ static void check_run_with_delta_0(gconstpointer arg)
                     wrap_policy ? 0 : (no_round_down ? 99 : 98));
     g_assert_true(triggered);
 
+    ptimer_transaction_begin(ptimer);
     ptimer_stop(ptimer);
+    ptimer_transaction_commit(ptimer);
     ptimer_free(ptimer);
 }
 
 static void check_periodic_with_load_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool continuous_trigger = (*policy & PTIMER_POLICY_CONTINUOUS_TRIGGER);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
 
@@ -642,8 +699,10 @@ static void check_periodic_with_load_0(gconstpointer arg)
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_count(ptimer, 10);
     ptimer_run(ptimer, 0);
+    ptimer_transaction_commit(ptimer);
 
     qemu_clock_step(2000000 * 10 + 1);
 
@@ -662,22 +721,25 @@ static void check_periodic_with_load_0(gconstpointer arg)
         g_assert_false(triggered);
     }
 
+    ptimer_transaction_begin(ptimer);
     ptimer_stop(ptimer);
+    ptimer_transaction_commit(ptimer);
     ptimer_free(ptimer);
 }
 
 static void check_oneshot_with_load_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
-    QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
     triggered = false;
 
+    ptimer_transaction_begin(ptimer);
     ptimer_set_period(ptimer, 2000000);
     ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
 
-- 
2.20.1


