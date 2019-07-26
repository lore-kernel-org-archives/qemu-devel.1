Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B72C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA6A218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsnHg8Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA6A218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4O6-0007dF-IP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mc-0001mQ-Tj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mb-0007Me-RM
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mb-0007LC-Ln
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:41 -0400
Received: by mail-pl1-x644.google.com with SMTP id az7so25001434plb.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7qMkBV6xIInqYLHQbsNGGIckvY18Pfy+zYd9EjT4q5E=;
 b=HsnHg8ZaUxSGLCpbuDc4pmqUNrk330qSqmCO7NJTJx3m/vp85OhDyq2sIfoOQMvEbC
 zwJTp6aCdSb8Vzb5I3MzM/8NsArcdkXmTDaputpA722tHqznS9eORwuHooib+qqP6QPX
 i4jgNJnIHUVe00Xv060oFeiZXLFCKKhZWa5JReNbzYgaAUay+JlIWvlmRee4OYAushcY
 4plOVDzEuzXkEswad/+xa69p7Z7piLmNqV87qxYkjE+jbdyvH9bjbZxUdW5Y5JYhJ+3Y
 kEciIOkrHb7VL37Qaa59SQ0V+Er9+A7aybjUXqZYyK8jIcVNVueuEv6o3qiwkRkNOKkv
 wNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7qMkBV6xIInqYLHQbsNGGIckvY18Pfy+zYd9EjT4q5E=;
 b=Myr/zzSA4NqkVChSo8NuqX9ct8Ff6dxoBjTt49ei+Xe3pVPBgfABOq40dhFcAWrTVj
 Pea5JmwdfKFXK19jQ5ekTPYmpuZ70E4kFNyZwZhsrWflSL/h1kJpo25u89tspI1GrCUl
 2U116H9I76FGyGgJbi5h8cxsGkDo5SL0FJ3AfBryG3F4bek27dleUN8vjUI6e7ocpmaa
 017kzFnjOp2yu2+9J3W16bTT6avrQjNz70Cui46ydJR14Tcfcy2DnJBaaG0vtacU8JUT
 cLcPY4INIfZn2JpZqn6W4VI0eKXgl2d3Ez6MEfjafJrzT3Yb/u10DzIbIXfzfdw/KvHv
 mP0g==
X-Gm-Message-State: APjAAAU2rKZseSAH0O2scxPtUJkV4tAIfxkR0iodlgJrZx3qWZ5ZLm7n
 UYPtOxZpqrX44eBbA4qgSqzMXH87DdI=
X-Google-Smtp-Source: APXvYqw18BMzHqaWf3+n90CKJsgnhA1xy0JEpmQCJSX0Yq+s1T/pPXMgG7loi9NQgF0Gzd8kbGhBQg==
X-Received: by 2002:a17:902:4201:: with SMTP id
 g1mr97729634pld.300.1564163440520; 
 Fri, 26 Jul 2019 10:50:40 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:30 -0700
Message-Id: <20190726175032.6769-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 05/67] target/arm: Use the saved value of the
 insn address
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The address of the current insn is still available in s->base.pc_next,
and need not be recomputed from s->pc - 4.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0848fb933a..595385e1b1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1212,7 +1212,7 @@ static inline void gen_hvc(DisasContext *s, int imm16)
      * as an undefined insn by runtime configuration (ie before
      * the insn really executes).
      */
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next);
     gen_helper_pre_hvc(cpu_env);
     /* Otherwise we will treat this as a real exception which
      * happens after execution of the insn. (The distinction matters
@@ -1231,7 +1231,7 @@ static inline void gen_smc(DisasContext *s)
      */
     TCGv_i32 tmp;
 
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next);
     tmp = tcg_const_i32(syn_aa32_smc());
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
@@ -3190,7 +3190,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
 
     /* Sync state because msr_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next);
     tcg_reg = load_reg(s, rn);
     tcg_tgtmode = tcg_const_i32(tgtmode);
     tcg_regno = tcg_const_i32(regno);
@@ -3212,7 +3212,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
 
     /* Sync state because mrs_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next);
     tcg_reg = tcg_temp_new_i32();
     tcg_tgtmode = tcg_const_i32(tgtmode);
     tcg_regno = tcg_const_i32(regno);
@@ -7219,7 +7219,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
 
             gen_set_condexec(s);
-            gen_set_pc_im(s, s->pc - 4);
+            gen_set_pc_im(s, s->base.pc_next);
             tmpptr = tcg_const_ptr(ri);
             tcg_syn = tcg_const_i32(syndrome);
             tcg_isread = tcg_const_i32(isread);
@@ -7629,7 +7629,7 @@ static void gen_srs(DisasContext *s,
     tmp = tcg_const_i32(mode);
     /* get_r13_banked() will raise an exception if called from System mode */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next);
     gen_helper_get_r13_banked(addr, cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     switch (amode) {
-- 
2.17.1


