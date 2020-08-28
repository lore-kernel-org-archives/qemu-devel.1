Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24515C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71E1207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qA5mw518"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71E1207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfZb-0001TA-6J
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF9-0001YQ-0p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF5-0005GP-6c
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id x143so742272pfc.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Gx/7ND2enUqh97byGs4EhjEjQPx9quOoqiJMUHgOSo=;
 b=qA5mw5183j4C2riftZcJS/xxiquLrd2YOqH2saW9Urioj5ZZjZVb5KIeNLyatvxVzk
 r8LVfuSZz3Trqzjlje9igeeglGbm216EBVHlllj81SZLnQFwuGfDF0qIjdylFIXLVTIV
 VTJs/3d1qaHKbLihudq4VM6ZaFBSBP88HF33kpXBGeqbH5D24FVoQtGvDpQBlsW2HUql
 GFFs1InJsnxU6rJp+XMOtrfJeJ0Hlzi7+YqeM3hGuL4IdoCg6B29JiEHQofiupRJRG8/
 QOn0ppaKCJgFZoYOZLalp4jPkADyfvz491SosX0p9/QJRj8xr78gjqoY6dpzWWCAnxqN
 A2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Gx/7ND2enUqh97byGs4EhjEjQPx9quOoqiJMUHgOSo=;
 b=kG7cFaxf0LkCTDeEvk8yxH9XQFQ/HydaTYd2XEQjVi0kO2X7qwhtqj2ptJTE6NdHwR
 OZhuq8QgUjrRcYSOgDfHs1K6QmbOt1FOTWzVAQfJyJ+KpL3nLKd9sXWZss4dwUsbRt7d
 y8yE7Vt9qDS01j0/O4t6EWtekPuSJcsA3Wk3H3vmzwZlt8nOKnW9IZzrbA0UUD+FZkwf
 GvbXzzBbWnyjguElBK6YtS9CZ5H/juEiNtDkOQSM0BKI4OMoDajJ/YvrA3dxEA1kGkx5
 rCaoeWTAKaJrvvlH3afZ24d1bFg7esb0XVIya7b7LSPYbMK4fI/JFECzOQXJ9O/kxaLA
 OPMg==
X-Gm-Message-State: AOAM5326AVv9Lxo4jQNL5WytPJyIhHXmkojHO9Cx4oUmwcK7U9IniSgk
 2lS4wnacq4bvHY4hb7+xo13YSL24o+LZcw==
X-Google-Smtp-Source: ABdhPJxzXZly1bQYz4n0nEmN4BkGXs6Sck64FbhJYf6WIK1KbnDluBmXVO/W7/7lxtPgC92H/tEGhQ==
X-Received: by 2002:a05:6a00:22cc:: with SMTP id
 f12mr1523842pfj.42.1598624432279; 
 Fri, 28 Aug 2020 07:20:32 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 48/76] target/microblaze: Fix cpu unwind for fpu exceptions
Date: Fri, 28 Aug 2020 07:19:01 -0700
Message-Id: <20200828141929.77854-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@xilinx.com
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


