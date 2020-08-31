Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA574C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7DC2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxGguRan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7DC2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmgD-0001co-Dq
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKu-0005cv-HE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKs-00065E-Jr
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id o20so799450pfp.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5MvRykgMTcIF07iOKyUuKHIQ1MzsLcRrDLZyuwy1N1o=;
 b=RxGguRanxxr7PBvN+flPPZ6N76nr8f1ySYtzxzmOkIJJKYBVY5WqBePv5abjHjRArZ
 2U7hZTY2VyaMqAE0pQtKMC8IYhMfKK4rb4n7NjTzjNq8SQS3on5F3vYH3uhQii5x/PfJ
 izFgZyc0blhaQniolgXg3U1bxbhbpUfbU0+YZRUG1ZEEciJoXn5Uw4WUDjq9qMhu0ymx
 axDbHeI2CGNK0OWeQdoXW/bzrbb/M1ZAqwDD4+qzKU1MySMHwz2+5lyxe1MJ9AZjYz4a
 zy4xtI2FMUNIx4EXTXgVqpR41Ni/SQSNiubFdLGiBjoVnfQPt59ECVhKbT2wYlAtvNQE
 /H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5MvRykgMTcIF07iOKyUuKHIQ1MzsLcRrDLZyuwy1N1o=;
 b=a3WxBo+2/44HOQIojpHsR+xIeXWm62QvzFoBtSiEdZ3/UD48Vm0SKORcfgbe8+eUW+
 GhTEKNGrMpg1+J8JiHLRZ3YAYsNWsbstMeA6GdHxBEEaEtUs2SLeON2amofW4rgzdzcJ
 ZF6yyxXAeu9N76zKQV893b9zYO9E2D9wBJQ21EfvbrGOVHMj+9cLvl+HPfEFeJTIiNSd
 GTLXddgGZTFB+Dvm8FqQX+/gpmGbjkS1U0MuiUUCJloCa6MrSE+vz0Meuj0bzzXlyCC6
 MCTvD/rDaj9ZVWCWw3MenMKfgM+mXDjEd86Qi3kVRRPAm839K8Zs21pwlGMmlO2Or2wI
 enOw==
X-Gm-Message-State: AOAM530xrR90tNBh4IFIjQz1KnYDCwv87jjXCHZzBCn/ZIrgIX+DqxUh
 QaH9ZFk7HWyzfLg1X7FjGPGMNR7/Cv4cfA==
X-Google-Smtp-Source: ABdhPJzg9tDuWdHtBjmSpKL5i6ew3SYrDxM8rzzcJec1O2C/Dcqcq/HGkprWu4uE+Y74VvfT9sX8og==
X-Received: by 2002:a63:50c:: with SMTP id 12mr1768523pgf.173.1598890028847;
 Mon, 31 Aug 2020 09:07:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/76] target/microblaze: Fix cpu unwind for fpu exceptions
Date: Mon, 31 Aug 2020 09:05:33 -0700
Message-Id: <20200831160601.833692-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct PC when an exception must be raised.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


