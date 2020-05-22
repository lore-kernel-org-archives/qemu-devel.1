Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6EBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E824205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udv+PsN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E824205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc988-0008R7-OD
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc959-00025g-G8
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:31 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc958-0006Rt-44
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so172076wml.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mF+Z1XhT8U/1VxQ4F6ob+fshPU7TCq1DJXBWTZ4vj/o=;
 b=udv+PsN8wZhW2rZkQlPACtiyJIO3eIJx3iLzcEVjDTIOvqjSCJNlC564VlDDPVUVJK
 vq3q/qljKEWrWtJpK6VDV07QLQonuUMA2YQ2qJ9yW7g9qeFptDs62gTyXMVl3TPHi6KP
 f+7qqVJU2dsrYwJKyjEBQNLf1HNyhfhPD7BbtEvwV2UMu05LuS+jtuKBPOpbutrWgw+a
 rFMOMJfI1bralfON9q3ewnUzwYkJ2FGrGmo1dfYpEqC5np8u6eVH5yaPiwuex5W4pZHa
 5gWfUE8mSa6prl+nnwhiezeE5i+suM18Eiw0sfvJqS8GCU5Tlvbi8ZtwcbTOun3GWqol
 /zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mF+Z1XhT8U/1VxQ4F6ob+fshPU7TCq1DJXBWTZ4vj/o=;
 b=FIY7otJTHm7ichpbsMqfo+q2MYzxOAmh37vBTC6etZXJQyQvHMNLLPSdui/gSGDA2G
 66RMvbRyh2F1/xdBUD63sMFKPHPOsVXGYShVpk5aOniXZn+LgyL3f7jMKSiAnOorWzYl
 BN0v2UssJip/LxndTOpY3QqauYovobvDU77rVVsmR0WqoAYsPK7WC/VM2Fa+Aw/vh8Y8
 5fRHdH+yrfu6BsmAD8BKmXpO1+mIB/KAtcSvsGnIZDrku/Tmz7bBav/V2kRtspA6m/Sf
 RiYVsSJ0uEuvXKTaGnZMQoJTIm7/1KbuMjFiO7Lxr5sZUEubygESFXXpd5Vz0ncRYxmd
 A58A==
X-Gm-Message-State: AOAM531xBY2Ioljn0U+EB71d8nFTwEoyAtlEnFJJqmJ01PqG5+oEMz0C
 1rysHtd02n39f8Rfk7azc0yHaUG1G6zX1w==
X-Google-Smtp-Source: ABdhPJz1XQ8hZY4Fw+jdN83S7mZ+AufV7+XaQU3DHhr6JzfRb3vmMcn5l7oEeOaXCgqm2DiRcfB9vg==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr13793237wmr.58.1590159328692; 
 Fri, 22 May 2020 07:55:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y8sm1100561wmc.37.2020.05.22.07.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:55:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] target/arm: Convert Neon narrowing shifts with op==8
 to decodetree
Date: Fri, 22 May 2020 15:55:16 +0100
Message-Id: <20200522145520.6778-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
References: <20200522145520.6778-1-peter.maydell@linaro.org>
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
 target/arm/neon-dp.decode       |  27 +++++
 target/arm/translate-neon.inc.c | 168 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |   1 +
 3 files changed, 196 insertions(+)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f9183060a51..01887240b4a 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -230,6 +230,17 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 @2reg_shl_b      .... ... . . . 001 shift:3  .... .... 0 q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0
 
+# Narrowing right shifts: here the Q bit is part of the opcode decode
+@2reg_shrn_d     .... ... . . . 1 ..... .... .... 0 . . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=3 q=0 \
+                 shift=%neon_rshift_i5
+@2reg_shrn_s     .... ... . . . 01 .... .... .... 0 . . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=2 q=0 \
+                 shift=%neon_rshift_i4
+@2reg_shrn_h     .... ... . . . 001 ... .... .... 0 . . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=1 q=0 \
+                 shift=%neon_rshift_i3
+
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
@@ -299,3 +310,19 @@ VQSHL_U_64_2sh   1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
 VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
 VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
 VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
+
+VSHRN_64_2sh     1111 001 0 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_d
+VSHRN_32_2sh     1111 001 0 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_s
+VSHRN_16_2sh     1111 001 0 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_h
+
+VRSHRN_64_2sh    1111 001 0 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_d
+VRSHRN_32_2sh    1111 001 0 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_s
+VRSHRN_16_2sh    1111 001 0 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_h
+
+VQSHRUN_64_2sh   1111 001 1 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_d
+VQSHRUN_32_2sh   1111 001 1 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_s
+VQSHRUN_16_2sh   1111 001 1 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_h
+
+VQRSHRUN_64_2sh  1111 001 1 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_d
+VQRSHRUN_32_2sh  1111 001 1 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_s
+VQRSHRUN_16_2sh  1111 001 1 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_h
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


