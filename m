Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4052076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pN2qeP0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4052076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbHe-0000xl-2M
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbD4-0000w7-Cl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbD1-0003sp-4H
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id z72so2875533wmc.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6WUuBCvwQjl4vjtsPhISoEx1Syp1mmE1uHgxZQrBY4A=;
 b=pN2qeP0xbN7eA6I//8+tBnfZdYkDiREPMMUAKyYVgoZPlxhOwEmRf/LlXM7D+tP4c1
 JAROSdxHPfpu60jz8k+axPhfHtH7EPzQx20QFPP9PTfYMt0VqEGa9ggmqACVfys/XPSs
 xEbOyoCXM3ZzCmUSt2e2HgovCtZvnynBbv9spE5NpNYBdFd2m1ua3GnhS7xQOnn+QH2S
 +CHNw1Q0AfUJVy9ftc8nRnwTPBZA+5s0AQiico5MtxijJjVYhVAeCwJYZ77rDVpTvdXN
 celcf/EJLIfWfl9T4nnQ3SFUVL5trs/w/iPPtFwvLQfpH8DPq0zJRbCooLOULHyXoEer
 iIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6WUuBCvwQjl4vjtsPhISoEx1Syp1mmE1uHgxZQrBY4A=;
 b=d0IGe1O1gWHv5mUtIOYHpnVgJ9H2nFbu+lv5v3cpafH9HC1O2zhm54KucMaabP4FWK
 1YtmId6JPLcLGFOHVlL/2j7sqTb0dkJ2dHtxQNBAMeFaE2frUWtYcJ7Wnh2v6dOAg9JD
 ZPNtFltRAbv8MEPLx81sSNPMiCrgJXh8q467oHxZnT5MLU4QLzzO/ZGEdQcEIim4o7LN
 s5xZkekGO8Gw2/uBRJTO3VpkWcxnw4+I8YrPOk0K2O9OGWURdR0YFH8p5dkURtE522mK
 BDa1ZflNwvVZWozlcg/51B5/5R0nK2Eg1KGJ3F+x29rOFHvCvjRLx6uIyLZtUqQQ08RV
 rZGA==
X-Gm-Message-State: AOAM532wku5Q2voZuPKn9DwshZlNhuWMbBGDBJjMvFJPelmk1OfwtMzn
 /S2RL8/bgokB3ltVOioo+Me8sC0Za3ijkQ==
X-Google-Smtp-Source: ABdhPJzIyXF6lxulg4O0m/wZxheQak7SZFgs7GlNedMgoJHxak5tTvWmdTPPuIx4Ml1XrGdgn4ncPQ==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr3508422wmn.68.1589552465562; 
 Fri, 15 May 2020 07:21:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm3738327wmh.18.2020.05.15.07.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:21:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/10] target/arm: Convert Neon narrowing shifts with op==8 to
 decodetree
Date: Fri, 15 May 2020 15:20:52 +0100
Message-Id: <20200515142056.21346-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515142056.21346-1-peter.maydell@linaro.org>
References: <20200515142056.21346-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon narrowing shifts where op==8 to decodetree:
 * VSHRN
 * VRSHRN
 * VQSHRUN
 * VQRSHRUN

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  32 ++++++
 target/arm/translate-neon.inc.c | 168 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |   1 +
 3 files changed, 201 insertions(+)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 6456b53a690..f8d19c5819c 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -208,6 +208,10 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 
 @2reg_shift      .... ... . . . ...... .... .... . q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp
+@2reg_shift_q0   .... ... . . . ...... .... .... . 0 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp q=0
+@2reg_shift_q1   .... ... . . . ...... .... .... . 1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp q=1
 
 # Right shifts are encoded as N - shift, where N is the element size in bits.
 %neon_rshift_i6  16:6 !function=rsub_64
@@ -340,3 +344,31 @@ VQSHL_U_2sh      1111 001 1 1 . 01 shift:4  .... 0111 0 . . 1 .... \
                  @2reg_shift size=1
 VQSHL_U_2sh      1111 001 1 1 . 001 shift:3 .... 0111 0 . . 1 .... \
                  @2reg_shift size=0
+
+VSHRN_64_2sh     1111 001 0 1 . 1 .....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q0 size=3 shift=%neon_rshift_i5
+VSHRN_32_2sh     1111 001 0 1 . 01 ....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q0 size=2 shift=%neon_rshift_i4
+VSHRN_16_2sh     1111 001 0 1 . 001 ...     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q0 size=1 shift=%neon_rshift_i3
+
+VRSHRN_64_2sh    1111 001 0 1 . 1 .....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q1 size=3 shift=%neon_rshift_i5
+VRSHRN_32_2sh    1111 001 0 1 . 01 ....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q1 size=2 shift=%neon_rshift_i4
+VRSHRN_16_2sh    1111 001 0 1 . 001 ...     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q1 size=1 shift=%neon_rshift_i3
+
+VQSHRUN_64_2sh   1111 001 1 1 . 1 .....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q0 size=3 shift=%neon_rshift_i5
+VQSHRUN_32_2sh   1111 001 1 1 . 01 ....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q0 size=2 shift=%neon_rshift_i4
+VQSHRUN_16_2sh   1111 001 1 1 . 001 ...     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q0 size=1 shift=%neon_rshift_i3
+
+VQRSHRUN_64_2sh  1111 001 1 1 . 1 .....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q1 size=3 shift=%neon_rshift_i5
+VQRSHRUN_32_2sh  1111 001 1 1 . 01 ....     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q1 size=2 shift=%neon_rshift_i4
+VQRSHRUN_16_2sh  1111 001 1 1 . 001 ...     .... 1000 0 . . 1 .... \
+                 @2reg_shift_q1 size=1 shift=%neon_rshift_i3
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 396db55565f..18ea7255e38 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1504,3 +1504,171 @@ static bool do_2shift_env_32(DisasContext *s, arg_2reg_shift *a,
 DO_2SHIFT_ENV(VQSHLU, qshlu_s)
 DO_2SHIFT_ENV(VQSHL_U, qshl_u)
 DO_2SHIFT_ENV(VQSHL_S, qshl_s)
+
+static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
+                                NeonGenTwo64OpFn *shiftfn,
+                                NeonGenNarrowEnvFn *narrowfn)
+{
+    /* 2-reg-and-shift narrowing-shift operations, size == 3 case */
+    TCGv_i64 constimm, rm1, rm2;
+    TCGv_i32 rd;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->vm & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * This is always a right shift, and the shiftfn is always a
+     * left-shift helper, which thus needs the negated shift count.
+     */
+    constimm = tcg_const_i64(-a->shift);
+    rm1 = tcg_temp_new_i64();
+    rm2 = tcg_temp_new_i64();
+
+    /* Load both inputs first to avoid potential overwrite if rm == rd */
+    neon_load_reg64(rm1, a->vm);
+    neon_load_reg64(rm2, a->vm + 1);
+
+    shiftfn(rm1, rm1, constimm);
+    rd = tcg_temp_new_i32();
+    narrowfn(rd, cpu_env, rm1);
+    neon_store_reg(a->vd, 0, rd);
+
+    shiftfn(rm2, rm2, constimm);
+    rd = tcg_temp_new_i32();
+    narrowfn(rd, cpu_env, rm2);
+    neon_store_reg(a->vd, 1, rd);
+
+    tcg_temp_free_i64(rm1);
+    tcg_temp_free_i64(rm2);
+    tcg_temp_free_i64(constimm);
+
+    return true;
+}
+
+static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
+                                NeonGenTwoOpFn *shiftfn,
+                                NeonGenNarrowEnvFn *narrowfn)
+{
+    /* 2-reg-and-shift narrowing-shift operations, size < 3 case */
+    TCGv_i32 constimm, rm1, rm2, rm3, rm4;
+    TCGv_i64 rtmp;
+    uint32_t imm;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->vm & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * This is always a right shift, and the shiftfn is always a
+     * left-shift helper, which thus needs the negated shift count
+     * duplicated into each lane of the immediate value.
+     */
+    if (a->size == 1) {
+        imm = (uint16_t)(-a->shift);
+        imm |= imm << 16;
+    } else {
+        /* size == 2 */
+        imm = -a->shift;
+    }
+    constimm = tcg_const_i32(imm);
+
+    /* Load all inputs first to avoid potential overwrite */
+    rm1 = neon_load_reg(a->vm, 0);
+    rm2 = neon_load_reg(a->vm, 1);
+    rm3 = neon_load_reg(a->vm + 1, 0);
+    rm4 = neon_load_reg(a->vm + 1, 1);
+    rtmp = tcg_temp_new_i64();
+
+    // todo expand out the shift-narrow and the narrow-op
+    shiftfn(rm1, rm1, constimm);
+    shiftfn(rm2, rm2, constimm);
+
+    tcg_gen_concat_i32_i64(rtmp, rm1, rm2);
+    tcg_temp_free_i32(rm2);
+
+    narrowfn(rm1, cpu_env, rtmp);
+    neon_store_reg(a->vd, 0, rm1);
+
+    shiftfn(rm3, rm3, constimm);
+    shiftfn(rm4, rm4, constimm);
+    tcg_temp_free_i32(constimm);
+
+    tcg_gen_concat_i32_i64(rtmp, rm3, rm4);
+    tcg_temp_free_i32(rm4);
+
+    narrowfn(rm3, cpu_env, rtmp);
+    tcg_temp_free_i64(rtmp);
+    neon_store_reg(a->vd, 1, rm3);
+    return true;
+}
+
+#define DO_2SN_64(INSN, FUNC, NARROWFUNC)                               \
+    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
+    {                                                                   \
+        return do_2shift_narrow_64(s, a, FUNC, NARROWFUNC);             \
+    }
+#define DO_2SN_32(INSN, FUNC, NARROWFUNC)                               \
+    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
+    {                                                                   \
+        return do_2shift_narrow_32(s, a, FUNC, NARROWFUNC);             \
+    }
+
+static void gen_neon_narrow_u32(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+{
+    tcg_gen_extrl_i64_i32(dest, src);
+}
+
+static void gen_neon_narrow_u16(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+{
+    gen_helper_neon_narrow_u16(dest, src);
+}
+
+static void gen_neon_narrow_u8(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+{
+    gen_helper_neon_narrow_u8(dest, src);
+}
+
+DO_2SN_64(VSHRN_64, gen_ushl_i64, gen_neon_narrow_u32)
+DO_2SN_32(VSHRN_32, gen_ushl_i32, gen_neon_narrow_u16)
+DO_2SN_32(VSHRN_16, gen_helper_neon_shl_u16, gen_neon_narrow_u8)
+
+DO_2SN_64(VRSHRN_64, gen_helper_neon_rshl_u64, gen_neon_narrow_u32)
+DO_2SN_32(VRSHRN_32, gen_helper_neon_rshl_u32, gen_neon_narrow_u16)
+DO_2SN_32(VRSHRN_16, gen_helper_neon_rshl_u16, gen_neon_narrow_u8)
+
+DO_2SN_64(VQSHRUN_64, gen_sshl_i64, gen_helper_neon_unarrow_sat32)
+DO_2SN_32(VQSHRUN_32, gen_sshl_i32, gen_helper_neon_unarrow_sat16)
+DO_2SN_32(VQSHRUN_16, gen_helper_neon_shl_s16, gen_helper_neon_unarrow_sat8)
+
+DO_2SN_64(VQRSHRUN_64, gen_helper_neon_rshl_s64, gen_helper_neon_unarrow_sat32)
+DO_2SN_32(VQRSHRUN_32, gen_helper_neon_rshl_s32, gen_helper_neon_unarrow_sat16)
+DO_2SN_32(VQRSHRUN_16, gen_helper_neon_rshl_s16, gen_helper_neon_unarrow_sat8)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d711d39eb9d..f884db535b4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5280,6 +5280,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             case 5: /* VSHL, VSLI */
             case 6: /* VQSHLU */
             case 7: /* VQSHL */
+            case 8: /* VSHRN, VRSHRN, VQSHRUN, VQRSHRUN */
                 return 1; /* handled by decodetree */
             default:
                 break;
-- 
2.20.1


