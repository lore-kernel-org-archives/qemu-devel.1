Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B5C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1FB205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8dUMeDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1FB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8HM-0002Du-5z
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD846-0000r1-0V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD843-0006J2-TO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id z9so1561574wmk.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6ws90XvtbVpDrbHlmKv+IJMJXU630OcDdXAfQAJcrno=;
 b=g8dUMeDxaIYWVCVaG9AJ/m86kO2yj4snyn9qZso3IbpfwrXU5mYYouhwHUvZjRja1z
 C+ykPvYkMsTlQRacBaRWWF0ciktlQRCezKMGmQHhXp/gUh7FT21aGq15SFi6jAu+ihDr
 5AACMAvoHoMLngalmVrNUBkcfszYz2AioFuH3m18oB1HLV+emJ/3zv2ihkKorUuHWK+K
 UeIWP3CnJpnEReYhFF1Rd8ghAQlwHd2dO49VeN98dZdF4lcdFR8PDe3mVOcpT1aG30AR
 t96N6WZzAV2uoodoi0BNa6ymd2KPD6yCGuEUWb5UNiTp/bwEwEaTq44YSpUJTi7qelSU
 23kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ws90XvtbVpDrbHlmKv+IJMJXU630OcDdXAfQAJcrno=;
 b=obXTTZq+N/U/Z7J8Sw6IoVjum5EawMKs0ZYlpPBKcpoBkIRI06eyJg2UCFXWfU7AWV
 7JH771VsWamj3+V82Rk0C2Zxnh417Lb1Rp7sK4i3ZRso5glJ1WlWp8IwyaQn1VDOB32J
 s/lAe3jpKImC+jpRttUc58xAIpVEJ5Zk1XTKBZjtCwSDW4x06LuZBPzutHo5Z3C0e7Pn
 0xv3xkDJ8NLytwnuCkpluNlrI9fNYq/LmGjDgoSmzCgsUfLgwpP8HWPOPl+Uy2H9HTPI
 wjtf8xWz01s02YFnALbTYtieLMExX738MpO/AI8W2AL5b2Wc8UXO5X+LdBz2OcHkLmmm
 NrDA==
X-Gm-Message-State: AOAM530EG4hJIBUgiRpRyoPcJvfhSHBqr3SqGTvrI4iUAeHJs5FcwHAc
 Hnf9JFBdmYQQU+Z1IBV13q/Ss4PqCt4gSqJT
X-Google-Smtp-Source: ABdhPJzUbaAogYPMYJ7EG2vDNodvCeJ81HSdAzwQULVq9CXEyIl42jTHGM82KmAbXIIijJdMglCorQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr2257680wmi.186.1598973554219; 
 Tue, 01 Sep 2020 08:19:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/47] target/arm: Implement fp16 for Neon
 VRINT-with-specified-rounding-mode
Date: Tue,  1 Sep 2020 16:18:15 +0100
Message-Id: <20200901151823.29785-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Convert the Neon VRINT-with-specified-rounding-mode insns to gvec,
and use this to implement the fp16 versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-41-peter.maydell@linaro.org
---
 target/arm/helper.h             |  4 +-
 target/arm/vec_helper.c         | 21 +++++++++++
 target/arm/vfp_helper.c         | 17 ---------
 target/arm/translate-neon.c.inc | 67 +++------------------------------
 4 files changed, 30 insertions(+), 79 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index a2758ded287..83f7804dfe9 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -214,7 +214,6 @@ DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
 
 DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
-DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
 
 DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
 DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, ptr, i32)
@@ -638,6 +637,9 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index fae0fe75294..7ddf1e791c9 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1892,3 +1892,24 @@ DO_VCVT_RMODE(gvec_vcvt_rm_sh, helper_vfp_toshh, uint16_t)
 DO_VCVT_RMODE(gvec_vcvt_rm_uh, helper_vfp_touhh, uint16_t)
 
 #undef DO_VCVT_RMODE
+
+#define DO_VRINT_RMODE(NAME, FUNC, TYPE)                                \
+    void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
+    {                                                                   \
+        float_status *fpst = stat;                                      \
+        intptr_t i, oprsz = simd_oprsz(desc);                           \
+        uint32_t rmode = simd_data(desc);                               \
+        uint32_t prev_rmode = get_float_rounding_mode(fpst);            \
+        TYPE *d = vd, *n = vn;                                          \
+        set_float_rounding_mode(rmode, fpst);                           \
+        for (i = 0; i < oprsz / sizeof(TYPE); i++) {                    \
+            d[i] = FUNC(n[i], fpst);                                    \
+        }                                                               \
+        set_float_rounding_mode(prev_rmode, fpst);                      \
+        clear_tail(d, oprsz, simd_maxsz(desc));                         \
+    }
+
+DO_VRINT_RMODE(gvec_vrint_rm_h, helper_rinth, uint16_t)
+DO_VRINT_RMODE(gvec_vrint_rm_s, helper_rints, uint32_t)
+
+#undef DO_VRINT_RMODE
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 8a3dd176819..5666393ef79 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -459,23 +459,6 @@ uint32_t HELPER(set_rmode)(uint32_t rmode, void *fpstp)
     return prev_rmode;
 }
 
-/* Set the current fp rounding mode in the standard fp status and return
- * the old one. This is for NEON instructions that need to change the
- * rounding mode but wish to use the standard FPSCR values for everything
- * else. Always set the rounding mode back to the correct value after
- * modifying it.
- * The argument is a softfloat float_round_ value.
- */
-uint32_t HELPER(set_neon_rmode)(uint32_t rmode, CPUARMState *env)
-{
-    float_status *fp_status = &env->vfp.standard_fp_status;
-
-    uint32_t prev_rmode = get_float_rounding_mode(fp_status);
-    set_float_rounding_mode(rmode, fp_status);
-
-    return prev_rmode;
-}
-
 /* Half precision conversions.  */
 float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, void *fpstp, uint32_t ahp_mode)
 {
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 4ae6176ead8..77a85d468fb 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3766,67 +3766,6 @@ static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
     return do_2misc_fp(s, a, gen_helper_rints_exact);
 }
 
-static bool do_vrint(DisasContext *s, arg_2misc *a, int rmode)
-{
-    /*
-     * Handle a VRINT* operation by iterating 32 bits at a time,
-     * with a specified rounding mode in operation.
-     */
-    int pass;
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_rmode;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
-        !arm_dc_feature(s, ARM_FEATURE_V8)) {
-        return false;
-    }
-
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
-    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
-    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
-        gen_helper_rints(tmp, tmp, fpst);
-        neon_store_reg(a->vd, pass, tmp);
-    }
-    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
-    tcg_temp_free_i32(tcg_rmode);
-    tcg_temp_free_ptr(fpst);
-
-    return true;
-}
-
-#define DO_VRINT(INSN, RMODE)                                   \
-    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
-    {                                                           \
-        return do_vrint(s, a, RMODE);                           \
-    }
-
-DO_VRINT(VRINTN, FPROUNDING_TIEEVEN)
-DO_VRINT(VRINTA, FPROUNDING_TIEAWAY)
-DO_VRINT(VRINTZ, FPROUNDING_ZERO)
-DO_VRINT(VRINTM, FPROUNDING_NEGINF)
-DO_VRINT(VRINTP, FPROUNDING_POSINF)
-
 #define DO_VEC_RMODE(INSN, RMODE, OP)                                   \
     static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
                            uint32_t rm_ofs,                             \
@@ -3868,6 +3807,12 @@ DO_VEC_RMODE(VCVTPS, FPROUNDING_POSINF, vcvt_rm_s)
 DO_VEC_RMODE(VCVTMU, FPROUNDING_NEGINF, vcvt_rm_u)
 DO_VEC_RMODE(VCVTMS, FPROUNDING_NEGINF, vcvt_rm_s)
 
+DO_VEC_RMODE(VRINTN, FPROUNDING_TIEEVEN, vrint_rm_)
+DO_VEC_RMODE(VRINTA, FPROUNDING_TIEAWAY, vrint_rm_)
+DO_VEC_RMODE(VRINTZ, FPROUNDING_ZERO, vrint_rm_)
+DO_VEC_RMODE(VRINTM, FPROUNDING_NEGINF, vrint_rm_)
+DO_VEC_RMODE(VRINTP, FPROUNDING_POSINF, vrint_rm_)
+
 static bool trans_VSWP(DisasContext *s, arg_2misc *a)
 {
     TCGv_i64 rm, rd;
-- 
2.20.1


