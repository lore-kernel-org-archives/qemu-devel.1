Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870ADC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC822078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6isDWKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC822078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDSL-0006pd-KE
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDML-0004Wb-Qe
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:57 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMK-0006Nh-0l
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:57 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ls15so3700433pjb.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2vl/rYCgMLXaJUMTeLyqPlVj0/LJH31XeOUQaewsmQ4=;
 b=M6isDWKa34K3GtZV1fKdd5THH0gqOzx5c64h0sYD3EdYN3b15U0CCxya/wpha5yEJH
 GUBiGLJTDIEywvG9jU9rWNsITc4vtbaLPDK4/w2tOSQAZUp3AGoKLYwX5VyXh6qGRPX4
 74zmlyyTLZvx9xEiUqFLlseXpU/C92Q/1qrk9d7bX1n6P+HFElnVyjb7KtnpdVAV3o1R
 xV5m21fjDsjNOi23+qhqcfu/udRx5/R1INNXoAmoHRj86USzxBMPuuSk4oDRXHXcpPjo
 DE5XGlezmUnuSvei+ySUsqMYBU5I30aTLMqhsmeyamYEUK9s2Kf5+7x96zV7B+CvZSuA
 MRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2vl/rYCgMLXaJUMTeLyqPlVj0/LJH31XeOUQaewsmQ4=;
 b=Eia4bFbwA2ppLo4DAtxZGNID8zYeQ+d/f+ntxm0lfI3GIjuB5wE8BzGP1ObzlCmc2R
 664NfATrRFbiTZ1PMwiTSiTSI3IQ3tcz/6TPcK8ViQ2FxjODbAqK7nkJR5snVTcF+waP
 pCTUOkozPLacZKpD18dO8BXkF0UW0jkKhl3U2NibvQTrV6gTvd2Yz/LZZN3CeuuOAkZr
 dkJHjwYBhTZyGdrmxSuOKOiyN2JPWEsBPS3bjNW57buuQSWt1vLHnN6Nfx3+2MUfB/CY
 hXfX9Ys0JipfVHLB6yKCiCl0o1AYiZzVQUfLq9Dkf7WSiSMgy+XfbQDJY93lQ9tplg8F
 5F4Q==
X-Gm-Message-State: AOAM530KvhRxRnNR7d/CHOiRyj1h37QItM1qDicmhfRsVd3JQicl6eHs
 bsSvBJBckSjunKOkbt5b1L3uGqsw
X-Google-Smtp-Source: ABdhPJxQbyN7rFyS9WdQJNi7UK4Rc8rFZT334MmQCEez1TFblnZm+oQTBBFw4wsA/SaLx/QfR0UGjw==
X-Received: by 2002:a17:90b:4a0f:: with SMTP id
 kk15mr5832689pjb.213.1594465674591; 
 Sat, 11 Jul 2020 04:07:54 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:54 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/22] target/xtensa: don't access BR regfile directly
Date: Sat, 11 Jul 2020 04:06:43 -0700
Message-Id: <20200711110655.20287-9-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1044.google.com
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

BR registers used in FPU comparison opcodes are available as opcode
arguments for translators. Use them. This simplifies comparison helpers
interface and makes them usable in FLIX bundles.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/fpu_helper.c | 42 +++++++++++++++++---------------------
 target/xtensa/helper.h     | 14 ++++++-------
 target/xtensa/translate.c  | 20 ++++++++++++++----
 3 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 46e231bdaa51..35dacbd14d68 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -120,49 +120,45 @@ float32 HELPER(uitof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
                           (int32_t)scale, &env->fp_status);
 }
 
-static inline void set_br(CPUXtensaState *env, bool v, uint32_t br)
+uint32_t HELPER(un_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    if (v) {
-        env->sregs[BR] |= br;
-    } else {
-        env->sregs[BR] &= ~br;
-    }
-}
-
-void HELPER(un_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    set_br(env, float32_unordered_quiet(a, b, &env->fp_status), br);
+    return float32_unordered_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(oeq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(oeq_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_br(env, float32_eq_quiet(a, b, &env->fp_status), br);
+    return float32_eq_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(ueq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ueq_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v == float_relation_equal || v == float_relation_unordered, br);
+
+    return v == float_relation_equal ||
+           v == float_relation_unordered;
 }
 
-void HELPER(olt_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(olt_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_br(env, float32_lt_quiet(a, b, &env->fp_status), br);
+    return float32_lt_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(ult_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ult_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v == float_relation_less || v == float_relation_unordered, br);
+
+    return v == float_relation_less ||
+           v == float_relation_unordered;
 }
 
-void HELPER(ole_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ole_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_br(env, float32_le_quiet(a, b, &env->fp_status), br);
+    return float32_le_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ule_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v != float_relation_greater, br);
+
+    return v != float_relation_greater;
 }
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index bce31cbd9ff1..02c00d8461c0 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -59,13 +59,13 @@ DEF_HELPER_FLAGS_3(ftoui_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
 DEF_HELPER_3(itof_s, f32, env, i32, i32)
 DEF_HELPER_3(uitof_s, f32, env, i32, i32)
 
-DEF_HELPER_4(un_s, void, env, i32, f32, f32)
-DEF_HELPER_4(oeq_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ueq_s, void, env, i32, f32, f32)
-DEF_HELPER_4(olt_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ult_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ole_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ule_s, void, env, i32, f32, f32)
+DEF_HELPER_3(un_s,  i32, env, f32, f32)
+DEF_HELPER_3(oeq_s, i32, env, f32, f32)
+DEF_HELPER_3(ueq_s, i32, env, f32, f32)
+DEF_HELPER_3(olt_s, i32, env, f32, f32)
+DEF_HELPER_3(ult_s, i32, env, f32, f32)
+DEF_HELPER_3(ole_s, i32, env, f32, f32)
+DEF_HELPER_3(ule_s, i32, env, f32, f32)
 
 DEF_HELPER_2(rer, i32, env, i32)
 DEF_HELPER_3(wer, void, env, i32, i32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 1b643881e6e9..67a92379f9dc 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -6319,7 +6319,7 @@ enum {
 static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
-    static void (* const helper[])(TCGv_env env, TCGv_i32 bit,
+    static void (* const helper[])(TCGv_i32 res, TCGv_env env,
                                    TCGv_i32 s, TCGv_i32 t) = {
         [COMPARE_UN] = gen_helper_un_s,
         [COMPARE_OEQ] = gen_helper_oeq_s,
@@ -6329,10 +6329,22 @@ static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
         [COMPARE_OLE] = gen_helper_ole_s,
         [COMPARE_ULE] = gen_helper_ule_s,
     };
-    TCGv_i32 bit = tcg_const_i32(1 << arg[0].imm);
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 res = tcg_temp_new_i32();
+    TCGv_i32 set_br = tcg_temp_new_i32();
+    TCGv_i32 clr_br = tcg_temp_new_i32();
 
-    helper[par[0]](cpu_env, bit, arg[1].in, arg[2].in);
-    tcg_temp_free(bit);
+    tcg_gen_ori_i32(set_br, arg[0].in, 1 << arg[0].imm);
+    tcg_gen_andi_i32(clr_br, arg[0].in, ~(1 << arg[0].imm));
+
+    helper[par[0]](res, cpu_env, arg[1].in, arg[2].in);
+    tcg_gen_movcond_i32(TCG_COND_NE,
+                        arg[0].out, res, zero,
+                        set_br, clr_br);
+    tcg_temp_free(zero);
+    tcg_temp_free(res);
+    tcg_temp_free(set_br);
+    tcg_temp_free(clr_br);
 }
 
 static void translate_float_s(DisasContext *dc, const OpcodeArg arg[],
-- 
2.20.1


