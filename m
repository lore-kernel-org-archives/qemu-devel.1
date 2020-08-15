Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF9C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B21423B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQSzufEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B21423B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zK1-00013c-Ea
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zJ2-0008Kz-1Y
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:45:20 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zJ0-0007Ag-2j
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:45:19 -0400
Received: by mail-oi1-x243.google.com with SMTP id z22so11029220oid.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yiKdEsXrfNBH7/8vYLZc3MqLfFg4s03EnbAK1DMKZss=;
 b=FQSzufEJpHgEXdXVj7RJ7hNTKcgoV79nx+d0e7Am/nx1wtlmpnEm0lEwmqvYPpf7Rx
 wiU3dTxhItSJFWg+aMzhwylk7/8x/O6ZYHRKFQ/d4zRkBb8eEtJrkKK2p2eLW+CwoLaB
 cOSf+HdNoWbe1VApVrQTY578+Rqwxf5uHEXau22dC3u1y+1s6XagZzsqfXsIZHkw+uBe
 H1XgQ7XzX7GAvyv+bpnL8emy6jSckYdXc+Ah7XPy0FFEG9shQTx8Hjl7I3QogUiynPR3
 wAE+6np2CPBt6Grj7sOsTV9xnRdyWZsrugH0fT2W4BehbhadwxrkhtZqxwQQydwxsjgR
 QYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yiKdEsXrfNBH7/8vYLZc3MqLfFg4s03EnbAK1DMKZss=;
 b=sFbmI3B4q+sheJm3V+00g0ADVIRuaGKVUK0nL+JFZGsYxSQJLwEDVJsnO7hFnJnLnC
 kTQmCArGoIf/mym1Nn8a4GLELR0kdtzAjYcuDsInEdiXjokIHydHdzyAxTdBZAoZBhgw
 /9eqW6q5MNTF1TUaXbW3XhRZnJ1htrrGRBsKOCQDnf7BFtAwGVjm6IGmT2HpaoP8mSvy
 F3MuI/XMr9cT6S1l/YSXrEBkuxDSPkvvx1sh5EuREsfxm/SV4+ZI/DQTG1KMQEhSZNzW
 GU5l5JY4o44r7SBUR1UvqhyjRGKQYA7FUgIyG+QgUHWYTd1I77TGkuTKO1bAHxP/joli
 oRLw==
X-Gm-Message-State: AOAM531b2q8HVd1n4UAiGro3FqDQuFLgVqUYa3Q7a71A72gHVT2YrBwX
 uYoRlZpyMRQx+W/CB+P2BqylqSdS1FtjFA==
X-Google-Smtp-Source: ABdhPJysIL824KIrlrx0ofsgHQEmTPDH+0vwgUV2dcjPhNsTZw4Ogb0HeUVr2ttW2p6vpY6X7RUo9Q==
X-Received: by 2002:a17:90a:a590:: with SMTP id
 b16mr4368232pjq.131.1597455113171; 
 Fri, 14 Aug 2020 18:31:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/20] target/arm: Rearrange {sve,fp}_check_access assert
Date: Fri, 14 Aug 2020 18:31:29 -0700
Message-Id: <20200815013145.539409-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
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
index 16f2699ad7..ad7972eb22 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -64,6 +64,7 @@ typedef struct DisasContext {
      * that it is set at the point where we actually touch the FP regs.
      */
     bool fp_access_checked;
+    bool sve_access_checked;
     /* ARMv8 single-step state (this is distinct from the QEMU gdbstub
      * single-step support).
      */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 534c3ff5f3..42aa695dff 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1175,18 +1175,18 @@ static void do_vec_ld(DisasContext *s, int destidx, int element,
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
@@ -1195,10 +1195,14 @@ static inline bool fp_access_check(DisasContext *s)
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
 
@@ -14548,6 +14552,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     s->base.pc_next += 4;
 
     s->fp_access_checked = false;
+    s->sve_access_checked = false;
 
     if (dc_isar_feature(aa64_bti, s)) {
         if (s->base.num_insns == 1) {
-- 
2.25.1


