Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659B3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D14121582
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvmjt4UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D14121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8O3-0006dk-Aw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD841-0000ez-Pd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:33297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83z-0006I0-J0
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id e11so1185535wme.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j46OVS7erArobrPBcvwOw1jqk4UsFIeKb2ubQ91KiuU=;
 b=xvmjt4UQt+sKqY8kOfnVDsPrypDPKcM29ur1kA9d5HPWvmP1EEOQ5aMrVfgOx80WIl
 EgQI1/jgBsn4/khBjZY4YnEHI3OIOjIwBU+IxpbmLCsodMQ8QYbmV1k6v57+sILRb6Ak
 vbV1ZqcQ4kp3NF7O7ju77+gnI77Hl+ya28X7/0T+vpFYySgilP0ykidvRw09lqoMcj+w
 ayNTz8wIT3hwhelZ5WCGrLHdqfWSQtbaJ94LR3Q78UlFJEXnKlYIGcRJTMG5lPu1w+9b
 +HQvhoHuOhWb0Nko+5yS/VKs3J5I4uvYVw74qa62WoiD1ic4I8J3FN80ixFIF37zc6cP
 ZaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j46OVS7erArobrPBcvwOw1jqk4UsFIeKb2ubQ91KiuU=;
 b=peDsUAFzL2MmVKonwscTEJinY6ZISw194y/v58doWXahtXAWO1zjbYrC2chRA0X8Yh
 52nUr9mOwTNngnjPiS62TCETb3SQsdzUvRcKoVr8moqN6XrqIUwhAS3M+P7t09cVG/Rr
 c/rvWErswaflVbhXs7Kb+ay87GbCrae1PuvXBJFYzY7ea2Z9daY1AyoC+s/CPFovOaHW
 zTdZoJc+sWNEV6Lg1gnW0FlWwhyFXrvwjfVboCnEApqP2ef2kcYVkQI77mBYhBEM6u8Z
 2/XjsGKhgs8xjAgXOmT35x/GuQEHpjYajh77wQ+7FvGFpbZBYJk+omEZMXLve/R5jzk3
 pyaw==
X-Gm-Message-State: AOAM533rLOKx2ajEtfvkTo4zllmyqakOBoTHhldweQkhG9R7RYSwZIUY
 6bOAq/ayl/dYBl6XFA2DgM5tmsD6ZufDXeQK
X-Google-Smtp-Source: ABdhPJyVnbqV0dNGEGBe8lLxaItHZZ9ri5ewn2+eeCkcKhvCvt9rya1tuWvHIhSfzZ++i6y2NItSjg==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr2245298wme.89.1598973549687;
 Tue, 01 Sep 2020 08:19:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/47] target/arm: Implement fp16 for Neon float-integer VCVT
Date: Tue,  1 Sep 2020 16:18:11 +0100
Message-Id: <20200901151823.29785-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon float-integer VCVT insns to gvec, and use this
to implement fp16 support for them.

Note that unlike the VFP int<->fp16 VCVT insns we converted
earlier and which convert to/from a 32-bit integer, these
Neon insns convert to/from 16-bit integers. So we can use
the existing vfp conversion helpers for the f32<->u32/i32
case but need to provide our own for f16<->u16/i16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-37-peter.maydell@linaro.org
---
 target/arm/helper.h             |  9 +++++++++
 target/arm/vec_helper.c         | 29 +++++++++++++++++++++++++++++
 target/arm/translate-neon.c.inc | 15 ++++-----------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f1f33c696d9..1d8badf4a21 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -614,6 +614,15 @@ DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_tosszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 46623d401e7..6ea9807b790 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -711,6 +711,26 @@ static uint32_t float32_acgt(float32 op1, float32 op2, float_status *stat)
     return -float32_lt(float32_abs(op2), float32_abs(op1), stat);
 }
 
+static int16_t vfp_tosszh(float16 x, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    if (float16_is_any_nan(x)) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_int16_round_to_zero(x, fpst);
+}
+
+static uint16_t vfp_touszh(float16 x, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    if (float16_is_any_nan(x)) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_uint16_round_to_zero(x, fpst);
+}
+
 #define DO_2OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
 {                                                                 \
@@ -730,6 +750,15 @@ DO_2OP(gvec_frsqrte_h, helper_rsqrte_f16, float16)
 DO_2OP(gvec_frsqrte_s, helper_rsqrte_f32, float32)
 DO_2OP(gvec_frsqrte_d, helper_rsqrte_f64, float64)
 
+DO_2OP(gvec_sitos, helper_vfp_sitos, int32_t)
+DO_2OP(gvec_uitos, helper_vfp_uitos, uint32_t)
+DO_2OP(gvec_tosizs, helper_vfp_tosizs, float32)
+DO_2OP(gvec_touizs, helper_vfp_touizs, float32)
+DO_2OP(gvec_sstoh, int16_to_float16, int16_t)
+DO_2OP(gvec_ustoh, uint16_to_float16, uint16_t)
+DO_2OP(gvec_tosszh, vfp_tosszh, float16)
+DO_2OP(gvec_touszh, vfp_touszh, float16)
+
 #define WRAP_CMP0_FWD(FN, CMPOP, TYPE)                          \
     static TYPE TYPE##_##FN##0(TYPE op, float_status *stat)     \
     {                                                           \
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index d13075986e5..5aaea867d8c 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3714,17 +3714,6 @@ static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
     return true;
 }
 
-#define DO_2MISC_FP(INSN, FUNC)                                 \
-    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
-    {                                                           \
-        return do_2misc_fp(s, a, FUNC);                         \
-    }
-
-DO_2MISC_FP(VCVT_FS, gen_helper_vfp_sitos)
-DO_2MISC_FP(VCVT_FU, gen_helper_vfp_uitos)
-DO_2MISC_FP(VCVT_SF, gen_helper_vfp_tosizs)
-DO_2MISC_FP(VCVT_UF, gen_helper_vfp_touizs)
-
 #define DO_2MISC_FP_VEC(INSN, HFUNC, SFUNC)                             \
     static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
                            uint32_t rm_ofs,                             \
@@ -3758,6 +3747,10 @@ DO_2MISC_FP_VEC(VCGE0_F, gen_helper_gvec_fcge0_h, gen_helper_gvec_fcge0_s)
 DO_2MISC_FP_VEC(VCEQ0_F, gen_helper_gvec_fceq0_h, gen_helper_gvec_fceq0_s)
 DO_2MISC_FP_VEC(VCLT0_F, gen_helper_gvec_fclt0_h, gen_helper_gvec_fclt0_s)
 DO_2MISC_FP_VEC(VCLE0_F, gen_helper_gvec_fcle0_h, gen_helper_gvec_fcle0_s)
+DO_2MISC_FP_VEC(VCVT_FS, gen_helper_gvec_sstoh, gen_helper_gvec_sitos)
+DO_2MISC_FP_VEC(VCVT_FU, gen_helper_gvec_ustoh, gen_helper_gvec_uitos)
+DO_2MISC_FP_VEC(VCVT_SF, gen_helper_gvec_tosszh, gen_helper_gvec_tosizs)
+DO_2MISC_FP_VEC(VCVT_UF, gen_helper_gvec_touszh, gen_helper_gvec_touizs)
 
 static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
 {
-- 
2.20.1


