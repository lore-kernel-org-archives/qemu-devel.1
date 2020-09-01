Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD2C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A7D2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUom8zca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A7D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8d5-0007Qu-Vr
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD844-0000nX-NX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD842-0006Ir-P2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id l9so1557220wme.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sIVV0C9f6IchNsSh0LB5J+JPv24sdIc0A4YvG0mbdPY=;
 b=LUom8zcaVChlJnRYCPv2qqov6NxZUINU3blhtqsd5HoPVb063D6zg1xrcHx61AFBb8
 pH3hkDG5sVfrgII4zTIJOKYQJAE++XB85lm3q5aMQQPCGYNX4ppFJHbHeNc9b/pIpGnd
 Z+IkRelwQNRd6jMHQW2Q4+kULazgzWpx29OYRSgtxyyPfO1rdzLXKmUYB53zr4TV7L7c
 dqCj8wDsCOosB45VR/81rQQcbJkVMT0fxD7Ry7BJUKepipIB7cYek2uSr4MQBK+SFr/8
 3yFHhSZeBgde222zZAPA+SJpB8yJ100u1gZHX6ESwsVIgh/zc0PoO7RhW9RHcgOB1jTq
 GIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sIVV0C9f6IchNsSh0LB5J+JPv24sdIc0A4YvG0mbdPY=;
 b=bLVVzYKorLxO3x8p6TWfPbjpn9xgN8nyjzpOYZs26sq/BMqg8JAoCIiL2f32JVTWF+
 tls59fxusb5kN1rSdMD5r+5/PqRFER931mJELMAnj+Iv3GR8CgOX5YDLe+3xryyj+syN
 6aVgo0DyUcRxbhIQca44EK4o78isCHKLPWDj1Bwx8EcUQSkzaK3K64JgbCtKEPKhDoCk
 5OZQAkgELn5S+Aw9o2anvmeW3odQuF03lRH37tUQBDK1aW05Rod6mqD6fawr51XwhCkD
 FnytPUTEuP2oIdv0RKtSlAE99YiQGZJi1PTlwTzkMZHP/fGfx36uOYE/6xvubt4gopZQ
 9bHw==
X-Gm-Message-State: AOAM530C/fedBGXj2RHm4/r6+aWe/t+IiE59Cs/tYt7zbMqWxadxIdgf
 CSaHFRx8hPJf14f+1kI2r24sW2AwmHeHT2o5
X-Google-Smtp-Source: ABdhPJzQqxzm722DakjyQkYiDwN8GjY6SqBZFPOn09T+7UXU7wTsUBaBkYIIMZOWC/rPeGRm7mf0DA==
X-Received: by 2002:a05:600c:24d:: with SMTP id
 13mr2365194wmj.86.1598973553123; 
 Tue, 01 Sep 2020 08:19:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/47] target/arm: Implement fp16 for Neon VCVT with rounding
 modes
Date: Tue,  1 Sep 2020 16:18:14 +0100
Message-Id: <20200901151823.29785-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Convert the Neon VCVT with-specified-rounding-mode instructions
to gvec, and use this to implement fp16 support for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-40-peter.maydell@linaro.org
---
 target/arm/helper.h             |   5 ++
 target/arm/vec_helper.c         |  23 +++++++
 target/arm/translate-neon.c.inc | 105 ++++++++++++--------------------
 3 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8c98bc40eb3..a2758ded287 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -633,6 +633,11 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index ea401910f37..fae0fe75294 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1869,3 +1869,26 @@ DO_VCVT_FIXED(gvec_vcvt_hs, helper_vfp_toshh_round_to_zero, uint16_t)
 DO_VCVT_FIXED(gvec_vcvt_hu, helper_vfp_touhh_round_to_zero, uint16_t)
 
 #undef DO_VCVT_FIXED
+
+#define DO_VCVT_RMODE(NAME, FUNC, TYPE)                                 \
+    void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
+    {                                                                   \
+        float_status *fpst = stat;                                      \
+        intptr_t i, oprsz = simd_oprsz(desc);                           \
+        uint32_t rmode = simd_data(desc);                               \
+        uint32_t prev_rmode = get_float_rounding_mode(fpst);            \
+        TYPE *d = vd, *n = vn;                                          \
+        set_float_rounding_mode(rmode, fpst);                           \
+        for (i = 0; i < oprsz / sizeof(TYPE); i++) {                    \
+            d[i] = FUNC(n[i], 0, fpst);                                 \
+        }                                                               \
+        set_float_rounding_mode(prev_rmode, fpst);                      \
+        clear_tail(d, oprsz, simd_maxsz(desc));                         \
+    }
+
+DO_VCVT_RMODE(gvec_vcvt_rm_ss, helper_vfp_tosls, uint32_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_us, helper_vfp_touls, uint32_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_sh, helper_vfp_toshh, uint16_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_uh, helper_vfp_touhh, uint16_t)
+
+#undef DO_VCVT_RMODE
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 2f982bb7260..4ae6176ead8 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3827,75 +3827,46 @@ DO_VRINT(VRINTZ, FPROUNDING_ZERO)
 DO_VRINT(VRINTM, FPROUNDING_NEGINF)
 DO_VRINT(VRINTP, FPROUNDING_POSINF)
 
-static bool do_vcvt(DisasContext *s, arg_2misc *a, int rmode, bool is_signed)
-{
-    /*
-     * Handle a VCVT* operation by iterating 32 bits at a time,
-     * with a specified rounding mode in operation.
-     */
-    int pass;
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_rmode, tcg_shift;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
-        !arm_dc_feature(s, ARM_FEATURE_V8)) {
-        return false;
+#define DO_VEC_RMODE(INSN, RMODE, OP)                                   \
+    static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
+                           uint32_t rm_ofs,                             \
+                           uint32_t oprsz, uint32_t maxsz)              \
+    {                                                                   \
+        static gen_helper_gvec_2_ptr * const fns[4] = {                 \
+            NULL,                                                       \
+            gen_helper_gvec_##OP##h,                                    \
+            gen_helper_gvec_##OP##s,                                    \
+            NULL,                                                       \
+        };                                                              \
+        TCGv_ptr fpst;                                                  \
+        fpst = fpstatus_ptr(vece == 1 ? FPST_STD_F16 : FPST_STD);       \
+        tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, oprsz, maxsz,          \
+                           arm_rmode_to_sf(RMODE), fns[vece]);          \
+        tcg_temp_free_ptr(fpst);                                        \
+    }                                                                   \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)             \
+    {                                                                   \
+        if (!arm_dc_feature(s, ARM_FEATURE_V8)) {                       \
+            return false;                                               \
+        }                                                               \
+        if (a->size == MO_16) {                                         \
+            if (!dc_isar_feature(aa32_fp16_arith, s)) {                 \
+                return false;                                           \
+            }                                                           \
+        } else if (a->size != MO_32) {                                  \
+            return false;                                               \
+        }                                                               \
+        return do_2misc_vec(s, a, gen_##INSN);                          \
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if (a->size != 2) {
-        /* TODO: FP16 will be the size == 1 case */
-        return false;
-    }
-
-    if ((a->vd | a->vm) & a->q) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = fpstatus_ptr(FPST_STD);
-    tcg_shift = tcg_const_i32(0);
-    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
-    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
-        if (is_signed) {
-            gen_helper_vfp_tosls(tmp, tmp, tcg_shift, fpst);
-        } else {
-            gen_helper_vfp_touls(tmp, tmp, tcg_shift, fpst);
-        }
-        neon_store_reg(a->vd, pass, tmp);
-    }
-    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
-    tcg_temp_free_i32(tcg_rmode);
-    tcg_temp_free_i32(tcg_shift);
-    tcg_temp_free_ptr(fpst);
-
-    return true;
-}
-
-#define DO_VCVT(INSN, RMODE, SIGNED)                            \
-    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
-    {                                                           \
-        return do_vcvt(s, a, RMODE, SIGNED);                    \
-    }
-
-DO_VCVT(VCVTAU, FPROUNDING_TIEAWAY, false)
-DO_VCVT(VCVTAS, FPROUNDING_TIEAWAY, true)
-DO_VCVT(VCVTNU, FPROUNDING_TIEEVEN, false)
-DO_VCVT(VCVTNS, FPROUNDING_TIEEVEN, true)
-DO_VCVT(VCVTPU, FPROUNDING_POSINF, false)
-DO_VCVT(VCVTPS, FPROUNDING_POSINF, true)
-DO_VCVT(VCVTMU, FPROUNDING_NEGINF, false)
-DO_VCVT(VCVTMS, FPROUNDING_NEGINF, true)
+DO_VEC_RMODE(VCVTAU, FPROUNDING_TIEAWAY, vcvt_rm_u)
+DO_VEC_RMODE(VCVTAS, FPROUNDING_TIEAWAY, vcvt_rm_s)
+DO_VEC_RMODE(VCVTNU, FPROUNDING_TIEEVEN, vcvt_rm_u)
+DO_VEC_RMODE(VCVTNS, FPROUNDING_TIEEVEN, vcvt_rm_s)
+DO_VEC_RMODE(VCVTPU, FPROUNDING_POSINF, vcvt_rm_u)
+DO_VEC_RMODE(VCVTPS, FPROUNDING_POSINF, vcvt_rm_s)
+DO_VEC_RMODE(VCVTMU, FPROUNDING_NEGINF, vcvt_rm_u)
+DO_VEC_RMODE(VCVTMS, FPROUNDING_NEGINF, vcvt_rm_s)
 
 static bool trans_VSWP(DisasContext *s, arg_2misc *a)
 {
-- 
2.20.1


