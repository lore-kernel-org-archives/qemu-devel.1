Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2640D206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbrcsSof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2640D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIr1-0003y3-Cv
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS2-0002dm-0j
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:02 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIRz-00017G-WE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id u5so91242pfn.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=40QD+uLXYWVx6bn2yCaxKFXN5y6qp5sHYryZzSPuYNU=;
 b=rbrcsSofEuaPmcwjhXrWSmwHOZ95+jB5LzNQ8/MGlKNY2mmeWUwWBgBIEEuehDkzfp
 rxBY9MAkoDRXMuHCMQX/XGI0LcKOQmTmv0aVnZwTGefWzlhwKfeAdaj4UHUfBcKCEBhx
 9qubn+L4VAbRXVS6eBTzrLx6ITa4KwGkyCcb88lKJWYy0H37KrnAW+17jqGtmqqFTNkH
 hAmGWACWaITkauCb4LgOl8gzA6chQ3q4L/78ronNBKprf+PDcC636lByTEUhmnb1YHyB
 EeV3qroDZ8M4HUP9CgaffwJcLt/mHffygaqPpCP344xUpFVHBudhsLsIN+HP47XThuvn
 p85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=40QD+uLXYWVx6bn2yCaxKFXN5y6qp5sHYryZzSPuYNU=;
 b=J5VW5/kMV65Wa48FY5RYR71oVU35RHrre6xhutAdP/q1kH9zQA4LovEdKZo0Qqx1qJ
 iiOZWpJMayWK5e64ME+IHK3NLvY48lKd4H2HHtbvKthkPQid8NAnkbT5yfZnAq71PA37
 MRXpgda2PSQyPsPslTAxTkL7b/Nn3tZztrSKakWPuwk5w83+goU9R+EjDR/kJWquZI1v
 cYeO6f7bIr5E/nrz7b7Jog+XXPBbt5Zk64tfSCegLBvophLLwIyv+FgUYe0Snn3I97Ym
 4HpB6d2Vbv+sHUR2Xq0cJ+tewbHoM6HmsAqoGiEiBAC2nGVeaSjT1WnhFu/PHrlwkbvr
 rhjA==
X-Gm-Message-State: AOAM532Qisj5Kf4R4DuqVs3UqG4LMuYj9Mw7qQfX74SDnbReaLTlJTcV
 gVlO4sy0SgjZXBLAgunAEJnQsccA
X-Google-Smtp-Source: ABdhPJyUcXyzLVyPQ8YtAd2ViDMQNx77TIzAZzNZh/40ILzeWvSFFRDKlop6/5UbTFTlFxEmQbgHSA==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr48665377pgj.19.1594246918520; 
 Wed, 08 Jul 2020 15:21:58 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:21:57 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/21] target/xtensa: rename FPU2000 translators and helpers
Date: Wed,  8 Jul 2020 15:20:46 -0700
Message-Id: <20200708222101.24568-7-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x443.google.com
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
implementations. Add _fpu2k_ to the name of wur_fcr helper to make space
for the DFPU wur_fcr helper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/fpu_helper.c | 10 +++++-----
 target/xtensa/helper.h     | 10 +++++-----
 target/xtensa/translate.c  | 20 ++++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 87487293f9a1..57a284924045 100644
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
@@ -82,7 +82,7 @@ float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
                           &env->fp_status);
 }
 
-uint32_t HELPER(ftoi)(float32 v, uint32_t rounding_mode, uint32_t scale)
+uint32_t HELPER(ftoi_s)(float32 v, uint32_t rounding_mode, uint32_t scale)
 {
     float_status fp_status = {0};
 
@@ -90,7 +90,7 @@ uint32_t HELPER(ftoi)(float32 v, uint32_t rounding_mode, uint32_t scale)
     return float32_to_int32(float32_scalbn(v, scale, &fp_status), &fp_status);
 }
 
-uint32_t HELPER(ftoui)(float32 v, uint32_t rounding_mode, uint32_t scale)
+uint32_t HELPER(ftoui_s)(float32 v, uint32_t rounding_mode, uint32_t scale)
 {
     float_status fp_status = {0};
     float32 res;
@@ -106,13 +106,13 @@ uint32_t HELPER(ftoui)(float32 v, uint32_t rounding_mode, uint32_t scale)
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
index 8532de0b35f5..a692254fe10a 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -46,7 +46,7 @@ DEF_HELPER_3(wsr_dbreaka, void, env, i32, i32)
 DEF_HELPER_3(wsr_dbreakc, void, env, i32, i32)
 #endif
 
-DEF_HELPER_2(wur_fcr, void, env, i32)
+DEF_HELPER_2(wur_fpu2k_fcr, void, env, i32)
 DEF_HELPER_FLAGS_1(abs_s, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_1(neg_s, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_3(add_s, f32, env, f32, f32)
@@ -54,10 +54,10 @@ DEF_HELPER_3(sub_s, f32, env, f32, f32)
 DEF_HELPER_3(mul_s, f32, env, f32, f32)
 DEF_HELPER_4(madd_s, f32, env, f32, f32, f32)
 DEF_HELPER_4(msub_s, f32, env, f32, f32, f32)
-DEF_HELPER_FLAGS_3(ftoi, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
-DEF_HELPER_FLAGS_3(ftoui, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
-DEF_HELPER_3(itof, f32, env, i32, i32)
-DEF_HELPER_3(uitof, f32, env, i32, i32)
+DEF_HELPER_FLAGS_3(ftoi_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
+DEF_HELPER_FLAGS_3(ftoui_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
+DEF_HELPER_3(itof_s, f32, env, i32, i32)
+DEF_HELPER_3(uitof_s, f32, env, i32, i32)
 
 DEF_HELPER_4(un_s, void, env, i32, f32, f32)
 DEF_HELPER_4(oeq_s, void, env, i32, f32, f32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index bc01a720719d..0deaeef6b5fa 100644
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
-- 
2.20.1


