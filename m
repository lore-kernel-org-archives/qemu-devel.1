Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ABC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D98206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O45yb+jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D98206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgam-00060N-6K
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3s-0008Pc-30
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:56 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3p-0001xE-Rh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:55 -0400
Received: by mail-pj1-x1044.google.com with SMTP id g6so130096pjl.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Gx/7ND2enUqh97byGs4EhjEjQPx9quOoqiJMUHgOSo=;
 b=O45yb+jxuepWiNX5iiTN2suhFZOkV76zhEejPcjLvzeHyaVFUSeSxgEwonQrOcKn4I
 JCyknw1yiV2Bp+kMpEf7Zntqj6WS5A3CWj8YbHZdKw9t4VUJcds10QixF6qqPvj1Dz9c
 77/99j8JjurUYt7vVd1S/aTG6BNR1dscG8Fj7SLnfa/spZFaoOzJ/eLFvf0Wyt3Bflv9
 zwFnnqUaFVc9w3PKr+v5RcxKUJPtpjacoF29693NiCovODOxhqC5LkvCfl6rsWtZMQ7d
 FK+Vd2O7XewHG+2IGrwmqE5lNRIdaU+CDkCEzWUkampH8Bjtx4i1wC18EYRjT/4Vva3q
 39dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Gx/7ND2enUqh97byGs4EhjEjQPx9quOoqiJMUHgOSo=;
 b=YMc7i0xNGARQ/gyzAo+v7YyjCX6nFqq8NnbXsWGAbnyZFH1zhqVKlVB+4WkWtwn0nd
 fEcQMM+REYoukXV9bwdiHa7GNoVWwLGC9g2jbIbOTBqgdyYSs7wE/07zXYwgtxoeiEvM
 e4lYxXVpAzR6R/4g9hLWPqRXDIpxPCQgCl98IqwrWBpsFqr6a50tyRT89XAVUNxzBu91
 nm6ghrXQMo9mCSdQ12Ce1vjgOP+YaEaZUGouCybkxWMggEIpM3JeD72A3pwPNsdlkMsL
 yRhXVavkNH8JjfCa35RdZZ1xyG1cDY5KpNHEXCOLLbPPr1q6yF1Lo84oKnMd0HlJqSA8
 dftQ==
X-Gm-Message-State: AOAM5317IoWv0/OKlgJZoLgCJqM7GZNe2SXM1Hx78wnCgGLw9vpS1fAE
 ynGDqxDzmGRaub5yWqPFPmtWBPWTlurVPw==
X-Google-Smtp-Source: ABdhPJyR/3RaPEK4HODR48MbmQrXXnFNYbdBkFLTm7FOxHZV9DHzDV8kamZj0/y9eoBmmUMDw932Bg==
X-Received: by 2002:a17:90a:de10:: with SMTP id
 m16mr3098906pjv.34.1598389252138; 
 Tue, 25 Aug 2020 14:00:52 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/77] target/microblaze: Fix cpu unwind for fpu exceptions
Date: Tue, 25 Aug 2020 13:59:21 -0700
Message-Id: <20200825205950.730499-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct PC when an exception must be raised.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 37 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index d99d98051a..2c59d4492d 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -104,13 +104,16 @@ uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
 }
 
 /* raise FPU exception.  */
-static void raise_fpu_exception(CPUMBState *env)
+static void raise_fpu_exception(CPUMBState *env, uintptr_t ra)
 {
+    CPUState *cs = env_cpu(env);
+
     env->esr = ESR_EC_FPU;
-    helper_raise_exception(env, EXCP_HW_EXCP);
+    cs->exception_index = EXCP_HW_EXCP;
+    cpu_loop_exit_restore(cs, ra);
 }
 
-static void update_fpu_flags(CPUMBState *env, int flags)
+static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
 {
     int raise = 0;
 
@@ -133,7 +136,7 @@ static void update_fpu_flags(CPUMBState *env, int flags)
     if (raise
         && (env->pvr.regs[2] & PVR2_FPU_EXC_MASK)
         && (env->msr & MSR_EE)) {
-        raise_fpu_exception(env);
+        raise_fpu_exception(env, ra);
     }
 }
 
@@ -148,7 +151,7 @@ uint32_t helper_fadd(CPUMBState *env, uint32_t a, uint32_t b)
     fd.f = float32_add(fa.f, fb.f, &env->fp_status);
 
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags);
+    update_fpu_flags(env, flags, GETPC());
     return fd.l;
 }
 
@@ -162,7 +165,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
     fb.l = b;
     fd.f = float32_sub(fb.f, fa.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags);
+    update_fpu_flags(env, flags, GETPC());
     return fd.l;
 }
 
@@ -176,7 +179,7 @@ uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
     fb.l = b;
     fd.f = float32_mul(fa.f, fb.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags);
+    update_fpu_flags(env, flags, GETPC());
 
     return fd.l;
 }
@@ -191,7 +194,7 @@ uint32_t helper_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
     fb.l = b;
     fd.f = float32_div(fb.f, fa.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags);
+    update_fpu_flags(env, flags, GETPC());
 
     return fd.l;
 }
@@ -206,7 +209,7 @@ uint32_t helper_fcmp_un(CPUMBState *env, uint32_t a, uint32_t b)
 
     if (float32_is_signaling_nan(fa.f, &env->fp_status) ||
         float32_is_signaling_nan(fb.f, &env->fp_status)) {
-        update_fpu_flags(env, float_flag_invalid);
+        update_fpu_flags(env, float_flag_invalid, GETPC());
         r = 1;
     }
 
@@ -229,7 +232,7 @@ uint32_t helper_fcmp_lt(CPUMBState *env, uint32_t a, uint32_t b)
     fb.l = b;
     r = float32_lt(fb.f, fa.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags & float_flag_invalid);
+    update_fpu_flags(env, flags & float_flag_invalid, GETPC());
 
     return r;
 }
@@ -245,7 +248,7 @@ uint32_t helper_fcmp_eq(CPUMBState *env, uint32_t a, uint32_t b)
     fb.l = b;
     r = float32_eq_quiet(fa.f, fb.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags & float_flag_invalid);
+    update_fpu_flags(env, flags & float_flag_invalid, GETPC());
 
     return r;
 }
@@ -261,7 +264,7 @@ uint32_t helper_fcmp_le(CPUMBState *env, uint32_t a, uint32_t b)
     set_float_exception_flags(0, &env->fp_status);
     r = float32_le(fa.f, fb.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags & float_flag_invalid);
+    update_fpu_flags(env, flags & float_flag_invalid, GETPC());
 
 
     return r;
@@ -277,7 +280,7 @@ uint32_t helper_fcmp_gt(CPUMBState *env, uint32_t a, uint32_t b)
     set_float_exception_flags(0, &env->fp_status);
     r = float32_lt(fa.f, fb.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags & float_flag_invalid);
+    update_fpu_flags(env, flags & float_flag_invalid, GETPC());
     return r;
 }
 
@@ -291,7 +294,7 @@ uint32_t helper_fcmp_ne(CPUMBState *env, uint32_t a, uint32_t b)
     set_float_exception_flags(0, &env->fp_status);
     r = !float32_eq_quiet(fa.f, fb.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags & float_flag_invalid);
+    update_fpu_flags(env, flags & float_flag_invalid, GETPC());
 
     return r;
 }
@@ -306,7 +309,7 @@ uint32_t helper_fcmp_ge(CPUMBState *env, uint32_t a, uint32_t b)
     set_float_exception_flags(0, &env->fp_status);
     r = !float32_lt(fa.f, fb.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags & float_flag_invalid);
+    update_fpu_flags(env, flags & float_flag_invalid, GETPC());
 
     return r;
 }
@@ -330,7 +333,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
     fa.l = a;
     r = float32_to_int32(fa.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags);
+    update_fpu_flags(env, flags, GETPC());
 
     return r;
 }
@@ -344,7 +347,7 @@ uint32_t helper_fsqrt(CPUMBState *env, uint32_t a)
     fa.l = a;
     fd.l = float32_sqrt(fa.f, &env->fp_status);
     flags = get_float_exception_flags(&env->fp_status);
-    update_fpu_flags(env, flags);
+    update_fpu_flags(env, flags, GETPC());
 
     return fd.l;
 }
-- 
2.25.1


