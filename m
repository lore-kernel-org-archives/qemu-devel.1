Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA2C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896EB2078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd53Y98j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896EB2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDPn-0002EV-Qt
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMK-0004Rw-2u
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMI-0006NO-6u
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id k5so3286598plk.13
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q49uChfas7CYxIJFPA71vIJuUFm6gLeemk+SocOgFZk=;
 b=bd53Y98jnTpYzEIyMR90rzDpSPy40MYIqwL1+2mhUnMrJlwKuoti226D725JpKVmMA
 e3pUdcqNZ4jLGZnBOR6Q+OmtSpitPruMQNOGP0c7Jpntod37o8IAlcSzn5J8K0vMC53A
 WIG5U1YZ6z2s6IXVsZXkzsoOtCHhUALL0nn3g/VPAwA0ydTJJSkJN1dpiTEFw7A6QGZt
 9G3S+yOINuWAOI7uG9DlaAnzQQOysZig6vcBugLUSrQDjCw7swcRC3BRqZbMre87Wm8r
 2Fij17ExrMZ9AumKLbZ1DAb0n8JmUv4nOdq58YeHrba9/p0Tijl68ifVx5onp/kUT27h
 X+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q49uChfas7CYxIJFPA71vIJuUFm6gLeemk+SocOgFZk=;
 b=nOoOk9sC51FNfE3z7yv9MVnpOC5gu5bNvGE4todVmThf/8u6I3eN2oArI7SyjrSgKM
 RLnji/a824d9a4ywR4oFZ58siUXtIJLroMQRKZll6gDKH3fF0Iau9SxtKxeadbCQDVDL
 vhVTua8EzJ0nCqYqNnLi/49TcAqN8xihw+0olQ8WBMciueWlAkDXOp+PeYGMEN/2XXUK
 /XmTpMG0NtHGbR6B7MeWqem8xjVVCYGnedOtmmi395SkeDLFLHNuHWah4ViwpP6hL4bJ
 g8wafBS6LOr+f+isVPAQpTWN+ZOWA1UJSV7cWjugqFypF4AKqN66a+S9yG+uzF3fN4b2
 ZWxg==
X-Gm-Message-State: AOAM532UxsEjreeeFZmOSsdGAmOAsVkTgIfAlS433HqNDCogKVunJrcu
 0f2XC82E+c1y+F/CyaeFdtFIrjri
X-Google-Smtp-Source: ABdhPJzIrZjW/HaWdrEyG72Bt7ZTJq8VBJMi78jdHrESZ55YHI5FJLiIZev8kqkqio80ZS2L9iOOcg==
X-Received: by 2002:a17:90b:1103:: with SMTP id
 gi3mr4854115pjb.132.1594465672609; 
 Sat, 11 Jul 2020 04:07:52 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:52 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/22] target/xtensa: rename FPU2000 translators and helpers
Date: Sat, 11 Jul 2020 04:06:41 -0700
Message-Id: <20200711110655.20287-7-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add _s suffix to all FPU2000 opcode translators and helpers that also
have double-precision variant to unify naming and allow adding DFPU
implementations. Add _fpu2k_ to the names of helpers that will have
different implementation for the DFPU .

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v3->v4:
- add _fpu2k_ to single-precision arithmetic helpers that do NaN
  selection to make space for helpers that will have to call
  set_use_first_nan

 target/xtensa/fpu_helper.c | 22 ++++++------
 target/xtensa/helper.h     | 20 +++++------
 target/xtensa/translate.c  | 70 +++++++++++++++++++-------------------
 3 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 87487293f9a1..46e231bdaa51 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -33,7 +33,7 @@
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 
-void HELPER(wur_fcr)(CPUXtensaState *env, uint32_t v)
+void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
 {
     static const int rounding_mode[] = {
         float_round_nearest_even,
@@ -56,33 +56,35 @@ float32 HELPER(neg_s)(float32 v)
     return float32_chs(v);
 }
 
-float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
+float32 HELPER(fpu2k_add_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     return float32_add(a, b, &env->fp_status);
 }
 
-float32 HELPER(sub_s)(CPUXtensaState *env, float32 a, float32 b)
+float32 HELPER(fpu2k_sub_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     return float32_sub(a, b, &env->fp_status);
 }
 
-float32 HELPER(mul_s)(CPUXtensaState *env, float32 a, float32 b)
+float32 HELPER(fpu2k_mul_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     return float32_mul(a, b, &env->fp_status);
 }
 
-float32 HELPER(madd_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
+float32 HELPER(fpu2k_madd_s)(CPUXtensaState *env,
+                             float32 a, float32 b, float32 c)
 {
     return float32_muladd(b, c, a, 0, &env->fp_status);
 }
 
-float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
+float32 HELPER(fpu2k_msub_s)(CPUXtensaState *env,
+                             float32 a, float32 b, float32 c)
 {
     return float32_muladd(b, c, a, float_muladd_negate_product,
                           &env->fp_status);
 }
 
-uint32_t HELPER(ftoi)(float32 v, uint32_t rounding_mode, uint32_t scale)
+uint32_t HELPER(ftoi_s)(float32 v, uint32_t rounding_mode, uint32_t scale)
 {
     float_status fp_status = {0};
 
@@ -90,7 +92,7 @@ uint32_t HELPER(ftoi)(float32 v, uint32_t rounding_mode, uint32_t scale)
     return float32_to_int32(float32_scalbn(v, scale, &fp_status), &fp_status);
 }
 
-uint32_t HELPER(ftoui)(float32 v, uint32_t rounding_mode, uint32_t scale)
+uint32_t HELPER(ftoui_s)(float32 v, uint32_t rounding_mode, uint32_t scale)
 {
     float_status fp_status = {0};
     float32 res;
@@ -106,13 +108,13 @@ uint32_t HELPER(ftoui)(float32 v, uint32_t rounding_mode, uint32_t scale)
     }
 }
 
-float32 HELPER(itof)(CPUXtensaState *env, uint32_t v, uint32_t scale)
+float32 HELPER(itof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
 {
     return float32_scalbn(int32_to_float32(v, &env->fp_status),
                           (int32_t)scale, &env->fp_status);
 }
 
-float32 HELPER(uitof)(CPUXtensaState *env, uint32_t v, uint32_t scale)
+float32 HELPER(uitof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
 {
     return float32_scalbn(uint32_to_float32(v, &env->fp_status),
                           (int32_t)scale, &env->fp_status);
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 8532de0b35f5..bce31cbd9ff1 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -46,18 +46,18 @@ DEF_HELPER_3(wsr_dbreaka, void, env, i32, i32)
 DEF_HELPER_3(wsr_dbreakc, void, env, i32, i32)
 #endif
 
-DEF_HELPER_2(wur_fcr, void, env, i32)
+DEF_HELPER_2(wur_fpu2k_fcr, void, env, i32)
 DEF_HELPER_FLAGS_1(abs_s, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_1(neg_s, TCG_CALL_NO_RWG_SE, f32, f32)
-DEF_HELPER_3(add_s, f32, env, f32, f32)
-DEF_HELPER_3(sub_s, f32, env, f32, f32)
-DEF_HELPER_3(mul_s, f32, env, f32, f32)
-DEF_HELPER_4(madd_s, f32, env, f32, f32, f32)
-DEF_HELPER_4(msub_s, f32, env, f32, f32, f32)
-DEF_HELPER_FLAGS_3(ftoi, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
-DEF_HELPER_FLAGS_3(ftoui, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
-DEF_HELPER_3(itof, f32, env, i32, i32)
-DEF_HELPER_3(uitof, f32, env, i32, i32)
+DEF_HELPER_3(fpu2k_add_s, f32, env, f32, f32)
+DEF_HELPER_3(fpu2k_sub_s, f32, env, f32, f32)
+DEF_HELPER_3(fpu2k_mul_s, f32, env, f32, f32)
+DEF_HELPER_4(fpu2k_madd_s, f32, env, f32, f32, f32)
+DEF_HELPER_4(fpu2k_msub_s, f32, env, f32, f32, f32)
+DEF_HELPER_FLAGS_3(ftoi_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
+DEF_HELPER_FLAGS_3(ftoui_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
+DEF_HELPER_3(itof_s, f32, env, i32, i32)
+DEF_HELPER_3(uitof_s, f32, env, i32, i32)
 
 DEF_HELPER_4(un_s, void, env, i32, f32, f32)
 DEF_HELPER_4(oeq_s, void, env, i32, f32, f32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index bc01a720719d..47951acd1669 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2813,10 +2813,10 @@ static void translate_wur(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(cpu_UR[par[0]], arg[0].in);
 }
 
-static void translate_wur_fcr(DisasContext *dc, const OpcodeArg arg[],
-                              const uint32_t par[])
+static void translate_wur_fpu2k_fcr(DisasContext *dc, const OpcodeArg arg[],
+                                    const uint32_t par[])
 {
-    gen_helper_wur_fcr(cpu_env, arg[0].in);
+    gen_helper_wur_fpu2k_fcr(cpu_env, arg[0].in);
 }
 
 static void translate_wur_fsr(DisasContext *dc, const OpcodeArg arg[],
@@ -5583,7 +5583,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){EXPSTATE},
     }, {
         .name = "wur.fcr",
-        .translate = translate_wur_fcr,
+        .translate = translate_wur_fpu2k_fcr,
         .par = (const uint32_t[]){FCR},
         .coprocessor = 0x1,
     }, {
@@ -6331,11 +6331,11 @@ static void translate_abs_s(DisasContext *dc, const OpcodeArg arg[],
     gen_helper_abs_s(arg[0].out, arg[1].in);
 }
 
-static void translate_add_s(DisasContext *dc, const OpcodeArg arg[],
-                            const uint32_t par[])
+static void translate_fpu2k_add_s(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
 {
-    gen_helper_add_s(arg[0].out, cpu_env,
-                     arg[1].in, arg[2].in);
+    gen_helper_fpu2k_add_s(arg[0].out, cpu_env,
+                           arg[1].in, arg[2].in);
 }
 
 enum {
@@ -6373,9 +6373,9 @@ static void translate_float_s(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 scale = tcg_const_i32(-arg[2].imm);
 
     if (par[0]) {
-        gen_helper_uitof(arg[0].out, cpu_env, arg[1].in, scale);
+        gen_helper_uitof_s(arg[0].out, cpu_env, arg[1].in, scale);
     } else {
-        gen_helper_itof(arg[0].out, cpu_env, arg[1].in, scale);
+        gen_helper_itof_s(arg[0].out, cpu_env, arg[1].in, scale);
     }
     tcg_temp_free(scale);
 }
@@ -6387,11 +6387,11 @@ static void translate_ftoi_s(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 scale = tcg_const_i32(arg[2].imm);
 
     if (par[1]) {
-        gen_helper_ftoui(arg[0].out, arg[1].in,
-                         rounding_mode, scale);
+        gen_helper_ftoui_s(arg[0].out, arg[1].in,
+                           rounding_mode, scale);
     } else {
-        gen_helper_ftoi(arg[0].out, arg[1].in,
-                        rounding_mode, scale);
+        gen_helper_ftoi_s(arg[0].out, arg[1].in,
+                          rounding_mode, scale);
     }
     tcg_temp_free(rounding_mode);
     tcg_temp_free(scale);
@@ -6433,11 +6433,11 @@ static void translate_ldstx(DisasContext *dc, const OpcodeArg arg[],
     tcg_temp_free(addr);
 }
 
-static void translate_madd_s(DisasContext *dc, const OpcodeArg arg[],
-                             const uint32_t par[])
+static void translate_fpu2k_madd_s(DisasContext *dc, const OpcodeArg arg[],
+                                   const uint32_t par[])
 {
-    gen_helper_madd_s(arg[0].out, cpu_env,
-                      arg[0].in, arg[1].in, arg[2].in);
+    gen_helper_fpu2k_madd_s(arg[0].out, cpu_env,
+                            arg[0].in, arg[1].in, arg[2].in);
 }
 
 static void translate_mov_s(DisasContext *dc, const OpcodeArg arg[],
@@ -6471,18 +6471,18 @@ static void translate_movp_s(DisasContext *dc, const OpcodeArg arg[],
     tcg_temp_free(zero);
 }
 
-static void translate_mul_s(DisasContext *dc, const OpcodeArg arg[],
-                            const uint32_t par[])
+static void translate_fpu2k_mul_s(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
 {
-    gen_helper_mul_s(arg[0].out, cpu_env,
-                     arg[1].in, arg[2].in);
+    gen_helper_fpu2k_mul_s(arg[0].out, cpu_env,
+                           arg[1].in, arg[2].in);
 }
 
-static void translate_msub_s(DisasContext *dc, const OpcodeArg arg[],
-                             const uint32_t par[])
+static void translate_fpu2k_msub_s(DisasContext *dc, const OpcodeArg arg[],
+                                   const uint32_t par[])
 {
-    gen_helper_msub_s(arg[0].out, cpu_env,
-                      arg[0].in, arg[1].in, arg[2].in);
+    gen_helper_fpu2k_msub_s(arg[0].out, cpu_env,
+                            arg[0].in, arg[1].in, arg[2].in);
 }
 
 static void translate_neg_s(DisasContext *dc, const OpcodeArg arg[],
@@ -6497,11 +6497,11 @@ static void translate_rfr_s(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_sub_s(DisasContext *dc, const OpcodeArg arg[],
-                            const uint32_t par[])
+static void translate_fpu2k_sub_s(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
 {
-    gen_helper_sub_s(arg[0].out, cpu_env,
-                     arg[1].in, arg[2].in);
+    gen_helper_fpu2k_sub_s(arg[0].out, cpu_env,
+                           arg[1].in, arg[2].in);
 }
 
 static void translate_wfr_s(DisasContext *dc, const OpcodeArg arg[],
@@ -6517,7 +6517,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .coprocessor = 0x1,
     }, {
         .name = "add.s",
-        .translate = translate_add_s,
+        .translate = translate_fpu2k_add_s,
         .coprocessor = 0x1,
     }, {
         .name = "ceil.s",
@@ -6560,7 +6560,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .coprocessor = 0x1,
     }, {
         .name = "madd.s",
-        .translate = translate_madd_s,
+        .translate = translate_fpu2k_madd_s,
         .coprocessor = 0x1,
     }, {
         .name = "mov.s",
@@ -6598,11 +6598,11 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .coprocessor = 0x1,
     }, {
         .name = "msub.s",
-        .translate = translate_msub_s,
+        .translate = translate_fpu2k_msub_s,
         .coprocessor = 0x1,
     }, {
         .name = "mul.s",
-        .translate = translate_mul_s,
+        .translate = translate_fpu2k_mul_s,
         .coprocessor = 0x1,
     }, {
         .name = "neg.s",
@@ -6658,7 +6658,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .coprocessor = 0x1,
     }, {
         .name = "sub.s",
-        .translate = translate_sub_s,
+        .translate = translate_fpu2k_sub_s,
         .coprocessor = 0x1,
     }, {
         .name = "trunc.s",
-- 
2.20.1


