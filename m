Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72157C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7A722250
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOAvclSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7A722250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmlJt-0001Q7-F4
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmlJF-0000Cu-M1
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:45:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmlJD-0007oo-Qh
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:45:57 -0400
Received: by mail-pl1-x643.google.com with SMTP id n9so5675076plk.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DluY8Oq2yB2PRsFlspiwVeg903l4iG/+upHvbfNm14Q=;
 b=MOAvclSRYtWG3W0USsiKFVXWL80r3LkxmeG6Xdlr7QkqgvfernjisV9qSwNO9sO5Qp
 m70fMHU6I8zFxrcEeyHK60wTw9W3ecsZoNOBRIT4wQu4tOV1EDHQf65fdddRecE063pu
 o/PT2QNsh+9jRc1kmPI0fHxX/NMB8uSOxd1iaaF3YBKnkHZ5S4l9nfRK+znhr2MG+nR4
 XWZboUmxfJRPY5MBKRQjfLVqHUDmVHd6N6VHlFMHVou3An7Cu/rzikaqwROXN2PCAGBj
 bJvqfOMk3abzUvR0DLSSmd6+TZuxZxawl2CxvAcFwIHqlq4hilR+f9HqDJ1vK6d0S8lO
 6VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DluY8Oq2yB2PRsFlspiwVeg903l4iG/+upHvbfNm14Q=;
 b=GItML1FhkZMqvz+y6RdQApUKqukpBDRvgBh435HmhsJ8UXyY86/Fi3D9x53DimVSQ/
 xXBQjd+YcpoirnWG+HFLi1MvfYk4D0h4Q4P3cTp/dPr79mkZMtwnREJgrirq8ilXKq08
 l06KKdrCLuJrRle3YrxBC5kKIEeCfYDAoujOQ4wSvNucGHPcjYuKbcKrSIHpEqbO0OBq
 f+aOmyhZGf1A48Ky4DnXHUvI4VuNWA47Kb+D7VkrgnH8q/su2X4D7LDLFq4vxPkhLQdS
 8PyBXbHRxgXjfIWsZ+7YmxY5Sqcinb9L9cRqOTryvfowfsaWYqc1svChwCafd43jezJR
 sG9Q==
X-Gm-Message-State: AOAM531+XngAIqxCAimn3uk/7032MKC4vjqc3fRJk81qfI0FN9YwelAS
 ixOMC6gvdS7MwMGvj0gRii8ytFbnJHQ=
X-Google-Smtp-Source: ABdhPJyseIoIh44J1TsyVrRZGVQb3F39FXoNNpEWkg3qCtK2G8HLgJC6Z+f0/rIbEnCTWqcfbC82yA==
X-Received: by 2002:a17:902:ed02:: with SMTP id
 b2mr13854700pld.326.1592689553448; 
 Sat, 20 Jun 2020 14:45:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q1sm10087959pfk.132.2020.06.20.14.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 14:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qht-bench: Adjust rate computation and comparisons
Date: Sat, 20 Jun 2020 14:45:51 -0700
Message-Id: <20200620214551.447392-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org, "Emilio G . Cota" <cota@braap.org>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use <= comparisons vs the threshold, so that threshold UINT64_MAX
is always true, corresponding to rate 1.0 being unity.  Simplify
do_threshold scaling to 2**64, with a special case for 1.0.

Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qht-bench.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index eb88a90137..21b1b7de82 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -132,7 +132,7 @@ static void do_rz(struct thread_info *info)
 {
     struct thread_stats *stats = &info->stats;
 
-    if (info->r < resize_threshold) {
+    if (info->r <= resize_threshold) {
         size_t size = info->resize_down ? resize_min : resize_max;
         bool resized;
 
@@ -154,7 +154,7 @@ static void do_rw(struct thread_info *info)
     uint32_t hash;
     long *p;
 
-    if (info->r >= update_threshold) {
+    if (info->r > update_threshold) {
         bool read;
 
         p = &keys[info->r & (lookup_range - 1)];
@@ -281,11 +281,18 @@ static void pr_params(void)
 
 static void do_threshold(double rate, uint64_t *threshold)
 {
+    /*
+     * For 0 <= rate <= 1, scale to fit in a uint64_t.
+     *
+     * For rate == 1, returning UINT64_MAX means 100% certainty: all
+     * uint64_t will match using <=.  The largest representable value
+     * for rate less than 1 is 0.999999999999999889; scaling that
+     * by 2**64 results in 0xfffffffffffff800.
+     */
     if (rate == 1.0) {
         *threshold = UINT64_MAX;
     } else {
-        *threshold = (rate * 0xffff000000000000ull)
-                   + (rate * 0x0000ffffffffffffull);
+        *threshold = rate * 0x1p64;
     }
 }
 
-- 
2.25.1


