Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C624DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B1F2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/azhLBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B1F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjX2-0002Dv-Me
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD1-0003JF-DX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCz-00065c-BG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id t14so115243wmi.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LAWgNQM+vnTqdtPBlqJeiYdAB3l9B49QTWcg+ZvpciA=;
 b=H/azhLByVMPMzX7ecjuApMfGHgLe8DMQKfY06AicKjkH0ubKuWgssKhBGLLObK/q9P
 bQOF+e7apT/NqbL77qck2tqX5uhAohqJdSaGM0EH5kvluz/m+lre8msm/fR1jO0Lv0/5
 8D7LZih/4Rcydt3ZBj4f4rVsaS4nTF7VDUVE5vAsKCYnT6UwkNdORjE59lvOejpoC//e
 faaNW/64IDp+nF7C8MdtpM1Rja0EeDmiiI5Budpl2037P7EsoK+qwz3b9ebbyK4aMAJW
 r8yof+h1vMz+VrEznDyPkunLbSOQ2C4um/Gnf6To5475mxC9gcJW/kbvcZHH222DihM/
 hCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LAWgNQM+vnTqdtPBlqJeiYdAB3l9B49QTWcg+ZvpciA=;
 b=SOILvblovxhOXj43WddaOUMQmW4gAMy8ma196haO5R8AiNdAxR4haRdb8BcHKZrG/T
 JFOa+8VA5YZsTClTHJmLef6do3fiI7agAY+tIAbiRBe4giD7w3If7takt0HSo2cIqI+F
 FiuBeZE9/W8d71IZtVTmFXIeZXMzezD1/Clm5J7DQlArIH5MjLs74PmsWKRRlaKAgsZK
 GrLlMZXCP2ARZwqJamsp8B3Ntbb/Gsehd6icYnbyH4c1K5pEcO2hyPtuPyLF/P3NJS9O
 SKn0BihYltJFMWFuMzPyqhVKJ7KqNdWfYJVKHys13yJV6J82ZSMuirQbqN1YGFNBuc7a
 tSMw==
X-Gm-Message-State: AOAM532YGJFa17EL723hfHRkzsF+e1ixBXZPoUe2JTuk7IeUNDG2BSo7
 68claRe5JPyv+k+lL2TdoNiNTd+K+UO8Jq+b
X-Google-Smtp-Source: ABdhPJyFXcVwSVkJ4rQ7QhNSWvS++RIskBqSNJYn+1neK28pCHHLZx8MEDLWl3a3S3+L3/Yik7Icdw==
X-Received: by 2002:a1c:6708:: with SMTP id b8mr8895wmc.141.1598639679957;
 Fri, 28 Aug 2020 11:34:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 36/45] target/arm: Implement fp16 for Neon float-integer
 VCVT
Date: Fri, 28 Aug 2020 19:33:45 +0100
Message-Id: <20200828183354.27913-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
index 0248eb68f71..f77506dab24 100644
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
@@ -3756,6 +3745,10 @@ DO_2MISC_FP_VEC(VCGE0_F, gen_helper_gvec_fcge0_h, gen_helper_gvec_fcge0_s)
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


