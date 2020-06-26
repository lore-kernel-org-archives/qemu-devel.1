Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C44C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECAB206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+RuJNwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECAB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jougX-0005cA-4N
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joufe-0004M4-Rk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:09:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joufd-00042T-4n
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:09:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id j1so5086375pfe.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hxw6BjVwQMIa1uoPxedqx8XGWOQD0NGxS2kvL4q3yy8=;
 b=p+RuJNwrhJwZzEjMil2KSK43gxw9c+9Cn27jYyvT7FTHmrnzki4Un4F4HvfliyZTfh
 zXg3MOoJ+ONJRbRqBL+3x/DlskkOFR5Pv03YSLmatXGGMw3clTstv9gJr4m/vWUkDZEF
 CBH7TvujTskzBLKxmyLPmM7vz5Oo9h3Poeiv71ZablgVXZIPmYqo777WsK6qOPK50nde
 SmUXWbP9JsnlKn74DgQeHsaZ5mjwr+9R1fj4cXkmHMS+cuZzUWSTM2wt4vIHVpHZN8o8
 ul4nASLcZ7/qGz/SGDT5xixR7NfFPCAHQfBDw6F46jXdXo7vBfac0kn3xXk3fqVLna0w
 Cvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hxw6BjVwQMIa1uoPxedqx8XGWOQD0NGxS2kvL4q3yy8=;
 b=U4AINskNL5PbOouh5ucX2DuQVaz2cEFcoCqfXrjmlt7nYwPyuYtAfzDMSJ7Ls3fdKr
 NkMjMpJ2Vx6hsjTJI5TX2+hIo7FQ3E1NJemGbDYC78ncZfxZhG54YiL/gBd0A1FWdOPC
 Y+fLHKbvgUR46sUN5S8VnCv8wI5oo75mKcmBSdlmRtBCbAgVSlaXJfwrDeyPcChcTvn7
 htOGF44Ri0Ui1cwQcFfWO+xqmHTbUD1J6oMdhJpqD49riuna0f/65IeUMs24D6Qax9JZ
 jM2CDi9qWa6hQHftN5dcjvichU+zK7Zf2vWjEOUebczGkChcWXlAoTbivZMW3GXgkcMJ
 tXQg==
X-Gm-Message-State: AOAM531P8h4NmKeIhb/PyiCJwL2EPtv0rDn4wSzMLtBzeTuNIoVN0GoC
 msVvXXTvu40HANHN+uau1vPkIzy2YW0=
X-Google-Smtp-Source: ABdhPJySL9DB2KuzQm4AqOozxNZFtkP0eB09mp1/CHx78taMbXTCz5oaVyoh9Itih5DIfoAWn+ufFg==
X-Received: by 2002:a62:ea14:: with SMTP id t20mr813019pfh.264.1593202195174; 
 Fri, 26 Jun 2020 13:09:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n8sm23879405pgi.18.2020.06.26.13.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 13:09:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] tests/qht-bench: Adjust testing rate by -1
Date: Fri, 26 Jun 2020 13:09:49 -0700
Message-Id: <20200626200950.1015121-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626200950.1015121-1-richard.henderson@linaro.org>
References: <20200626200950.1015121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the seed must be non-zero, subtracting 1 means puts the
rate in 0..UINT64_MAX-1, which allows the 0 and UINT64_MAX
thresholds to corrspond to 0% (never) and 100% (always).

Suggested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qht-bench.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index eb88a90137..ad885d89d0 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -25,7 +25,13 @@ struct thread_stats {
 struct thread_info {
     void (*func)(struct thread_info *);
     struct thread_stats stats;
-    uint64_t r;
+    /*
+     * Seed is in the range [1..UINT64_MAX], because the RNG requires
+     * a non-zero seed.  To use, subtract 1 and compare against the
+     * threshold with </>=.  This lets threshold = 0 never match (0% hit),
+     * and threshold = UINT64_MAX always match (100% hit).
+     */
+    uint64_t seed;
     bool write_op; /* writes alternate between insertions and removals */
     bool resize_down;
 } QEMU_ALIGNED(64); /* avoid false sharing among threads */
@@ -131,8 +137,9 @@ static uint64_t xorshift64star(uint64_t x)
 static void do_rz(struct thread_info *info)
 {
     struct thread_stats *stats = &info->stats;
+    uint64_t r = info->seed - 1;
 
-    if (info->r < resize_threshold) {
+    if (r < resize_threshold) {
         size_t size = info->resize_down ? resize_min : resize_max;
         bool resized;
 
@@ -151,13 +158,14 @@ static void do_rz(struct thread_info *info)
 static void do_rw(struct thread_info *info)
 {
     struct thread_stats *stats = &info->stats;
+    uint64_t r = info->seed - 1;
     uint32_t hash;
     long *p;
 
-    if (info->r >= update_threshold) {
+    if (r >= update_threshold) {
         bool read;
 
-        p = &keys[info->r & (lookup_range - 1)];
+        p = &keys[r & (lookup_range - 1)];
         hash = hfunc(*p);
         read = qht_lookup(&ht, p, hash);
         if (read) {
@@ -166,7 +174,7 @@ static void do_rw(struct thread_info *info)
             stats->not_rd++;
         }
     } else {
-        p = &keys[info->r & (update_range - 1)];
+        p = &keys[r & (update_range - 1)];
         hash = hfunc(*p);
         if (info->write_op) {
             bool written = false;
@@ -208,7 +216,7 @@ static void *thread_func(void *p)
 
     rcu_read_lock();
     while (!atomic_read(&test_stop)) {
-        info->r = xorshift64star(info->r);
+        info->seed = xorshift64star(info->seed);
         info->func(info);
     }
     rcu_read_unlock();
@@ -221,7 +229,7 @@ static void *thread_func(void *p)
 static void prepare_thread_info(struct thread_info *info, int i)
 {
     /* seed for the RNG; each thread should have a different one */
-    info->r = (i + 1) ^ time(NULL);
+    info->seed = (i + 1) ^ time(NULL);
     /* the first update will be a write */
     info->write_op = true;
     /* the first resize will be down */
-- 
2.25.1


