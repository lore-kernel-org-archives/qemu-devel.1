Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603D8C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6982133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGyYISJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6982133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Aq-0006qM-Jy
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pf-0003YB-44
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pc-0006xK-UA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pc-0006w4-MR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id j18so20367438wrq.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Rk1ojq7X/fdHuWZIiQoPzPhZjyvbdwoulra1pv6pWfQ=;
 b=fGyYISJrLwTnfcaCCA8tlUQqmimSP4fdMn0ZotGbyltcBk1HZwRIF/OlNONaUWFkZo
 IHqjYZrN5fWwYGlos5PqoBoL051wUA03fAlncTHEOOmqXTpJwy2A2d1eYUsZf2+KGPbE
 uu+yEz9ZZTz2rUl4B9FEg6kqmSdx9apmursEjN6yqxkKKVZ0/1+Gc0pubrdRS2SycqYg
 Ijn71Qeh4V6LCpjUpUbnEf3AvZEzJtUEg/EHu9xSLLkGdWbxn4nsn9oVHlQ2344+O5eW
 6hlRey6Vn2WGwtL/ZTNIn4xws2fqVnVAKxtVhGS/q/Hs7zmVWNvzivXRlSfZTT0HLtUj
 GwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rk1ojq7X/fdHuWZIiQoPzPhZjyvbdwoulra1pv6pWfQ=;
 b=CcB/iIY4QRYu4CM2QbOCNG783b3xL4W88etQsQjq8YKSxiP9xoYTd29RJZ1RAMBbzS
 r6AE+b4S/jJF/at+KS+HG6GlnEuhoLwAUmxqQnMmtCdpFeXqKGoHxB54A+Ei6LMsolkz
 ecUa4mnJTYptUdKp/XhxNdYtvuHy2o0iEIYEAs0e3Tk5Yuib5kSuuVLGfVocLqlrMKWq
 WBbeyc1Z4vm0fJFSyncBgpQol3UPA2dgvIDseBGa2mh29tqFIJ2kln04Z+oMsAEUQljr
 XCUYdofveiKWS6C0gVgLro2rLN8F41CGqA8DvYIpD/zwnGqNw/EXG/QG7v2i5h8+69HW
 ELuA==
X-Gm-Message-State: APjAAAX7xSN5vk9krAlaUv7s4aCWKU/Vnp3oDmRiZhjC1Pj2hr+K/YWf
 Z5VSpxj4tV3Xod2ABeltcqQJh20uKQqKcg==
X-Google-Smtp-Source: APXvYqyarauui1HtaLBXQVQzYQ6FkKSqb0IAPPHDZED5eLFHRLNVxrDXV5kB8a4RvR63hN/GS3SpgQ==
X-Received: by 2002:adf:d845:: with SMTP id k5mr13670941wrl.141.1571069061673; 
 Mon, 14 Oct 2019 09:04:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/68] tests/ptimer-test: Switch to transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:02 +0100
Message-Id: <20191014160404.19553-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

Convert the ptimer test cases to the transaction-based ptimer API,
by changing to ptimer_init(), dropping the now-unused QEMUBH
variables, and surrounding each set of changes to the ptimer
state in ptimer_transaction_begin/commit calls.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-4-peter.maydell@linaro.org
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


