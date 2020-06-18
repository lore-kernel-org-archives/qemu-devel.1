Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A882C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A05721852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlkiN6Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A05721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlm9x-0003us-K0
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8e-0001nr-Rb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:56 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8d-0002Gp-34
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id b16so2171160pfi.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6tpPOBz95/j0U9AMqUe6BQmQ5LvPnYdp+NbHp9sGVlA=;
 b=NlkiN6Ql2YvrrimkRrKvOEvCLTso+5yuSXfnv2WSF4t26+Pqt1gB3uND3NC8D7JhCe
 NJgiHCHb8Sqn8HZYw+LtEoguGnxsq2NxdHM65i7u9rfsSk023VveMHV8A6SImiy2/BVb
 4/Jz5nF4KqOcdVTW41Zdz2WBr2ED2UMEPk6tvcIL5H3fyndbvQvasH6fN1/iVdbIICjV
 2XuajbCoMdGWE7yZ2nmdEZkcseh3mvXcFk/MHESlP/4yXbnYW9oMr5SQS3slIHDOqEgl
 xembrt02LyXpuo6t1Meyq1/3YImH9HN7/crC87IohQ2HmX/nK381zOi+5C0eJeeHg19+
 b3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6tpPOBz95/j0U9AMqUe6BQmQ5LvPnYdp+NbHp9sGVlA=;
 b=aBTL5Pse6s2rMxJjkktT+H9pibxITrozESE+L+d3XJNa7VS2cAR5NHI0ZHn/qkJ7Gh
 V2cVD9Pze+SPbEKq4RTV38VSTylpRnFL//uUFn0c+a1YxD5o6dsx4MncMIiuQCAcJLPv
 7DQGdtDzoh49nz69lWZsXzJ9mDwKIz/tCkxNmW6IPSvT7XyTSAtzi8re3UIwRUYEDXBb
 sR9BL/gz98bO/HZIpFe5YBP56DHbit1Y76G51502JtsmL/plmXZRIsPRvslrixqEf58j
 5BIz2EqlCtQH8KRxrB6d2s4OGdrKAFtNVsDPoY3lxfOTVz4pnDX/ZU5WBoi0B5soDgGq
 vFYg==
X-Gm-Message-State: AOAM533+xCzZsj0w1N3PFbv6mmiPYNZNzkYdhOBq8h+zEoPXPW8W8giB
 NamRgjezIfL/NzICiAwz0h/xVxMOe0Q=
X-Google-Smtp-Source: ABdhPJx1rJxWgptFX2x6mB/TseGrrmS9u5sr7zyIyHNL8SeIGrE63W+n9TL525uxtHuT9sQKFyHp4g==
X-Received: by 2002:aa7:9818:: with SMTP id e24mr2032168pfl.30.1592454413431; 
 Wed, 17 Jun 2020 21:26:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 005/100] target/arm: Rearrange {sve, fp}_check_access assert
Date: Wed, 17 Jun 2020 21:25:09 -0700
Message-Id: <20200618042644.1685561-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to ensure that access is checked by the time we ask
for a specific fp/vector register.  We want to ensure that
we do not emit two lots of code to raise an exception.

But sometimes it's difficult to cleanly organize the code
such that we never pass through sve_check_access exactly once.
Allow multiple calls so long as the result is true, that is,
no exception to be raised.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |  1 +
 target/arm/translate-a64.c | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 62ed5c4780..f6a9e1054b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -63,6 +63,7 @@ typedef struct DisasContext {
      * that it is set at the point where we actually touch the FP regs.
      */
     bool fp_access_checked;
+    bool sve_access_checked;
     /* ARMv8 single-step state (this is distinct from the QEMU gdbstub
      * single-step support).
      */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a0e72ad694..b80ee9f734 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1083,18 +1083,18 @@ static void do_vec_ld(DisasContext *s, int destidx, int element,
  * unallocated-encoding checks (otherwise the syndrome information
  * for the resulting exception will be incorrect).
  */
-static inline bool fp_access_check(DisasContext *s)
+static bool fp_access_check(DisasContext *s)
 {
-    assert(!s->fp_access_checked);
-    s->fp_access_checked = true;
+    if (s->fp_excp_el) {
+        assert(!s->fp_access_checked);
+        s->fp_access_checked = true;
 
-    if (!s->fp_excp_el) {
-        return true;
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+        return false;
     }
-
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                       syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
-    return false;
+    s->fp_access_checked = true;
+    return true;
 }
 
 /* Check that SVE access is enabled.  If it is, return true.
@@ -1103,10 +1103,14 @@ static inline bool fp_access_check(DisasContext *s)
 bool sve_access_check(DisasContext *s)
 {
     if (s->sve_excp_el) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_sve_access_trap(),
-                           s->sve_excp_el);
+        assert(!s->sve_access_checked);
+        s->sve_access_checked = true;
+
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                           syn_sve_access_trap(), s->sve_excp_el);
         return false;
     }
+    s->sve_access_checked = true;
     return fp_access_check(s);
 }
 
@@ -14050,6 +14054,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     s->base.pc_next += 4;
 
     s->fp_access_checked = false;
+    s->sve_access_checked = false;
 
     if (dc_isar_feature(aa64_bti, s)) {
         if (s->base.num_insns == 1) {
-- 
2.25.1


