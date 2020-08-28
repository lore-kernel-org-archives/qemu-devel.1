Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A01CC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3320620776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybTTfEdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3320620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjcV-0003dU-AO
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD9-0003SI-FP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD3-00066P-29
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id e16so75613wrm.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H+SA5BtJZZsSmfjNYqMp1Lvncj89UN93oPcUQSiNQtg=;
 b=ybTTfEdXG4i6fqt5l6HLVgx+eprgPBfCYLc+yYBUGvh8IQku4tcbD6OyNqqLR2DTZr
 JitJ/ryMlbQR6OPoXC7SXyKapi8T9TsSgijW/21H6W/OW7dxDYLIpIdVdNnJXIA027db
 AIA3fVqoLYEqCDjAR4gOZ5gMcbqam2dKZ5p73aFngDo7E0wsc2tpxr8Paw6GySSwPpnN
 6/iA0bv0X99X03C6sGFFVdrWaYJDT1hRF7BssB97GbK12OWV5DT/J0DetIl7hToBidAZ
 U24YJNWoNNkSZ93SJlBGFdEoHYIjtDkZUNBvs0qc1mdVwDvs4GogE/k+c/AzVpuyaO1c
 7SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H+SA5BtJZZsSmfjNYqMp1Lvncj89UN93oPcUQSiNQtg=;
 b=gCwjYKqWR3a+oSjQIDy6ck7Hfo/gNurDhOLEw7Kj0lOvpPsfnj6CckcGjg6De4BH1J
 2ok+NvWCuH6u9G2oCgIH5gppPdbZ0dnEqcSMOlYeN3LARH8tpqY7TdALRVDtCoIg+Tvk
 Bm7yirHpWF5EaO8dVOysGKKp98C7AeHcF8NI2WoGWcFWTxuJf872NOHDwBSYjm5D6qua
 Y/hi5ovzrNUFFLJUZkYxbZKgZP4ovIfrPUouNSyzf39vWADY4qYRQXnZLlDOyaMzLWjl
 QPjoZr43RwIQxUj58PrCQVJTY4N2Q/w+6sQI6Y2YhVtc+zGXD0uipKltYR4gbfs/+9CB
 6j3Q==
X-Gm-Message-State: AOAM5305HIJzOEawL3ad8zuVlP0IILWQ7615obcjKKYSsA7hQlkoYxS0
 ybetsZoegoiXhOAqA8muM53cZg==
X-Google-Smtp-Source: ABdhPJyvUXi9wbdbv3o7sdVoR2p5WUTkG5yk0mFOjRUmny/RvZnIOjx5uBLcn+JT4hEC8azjyLzsWQ==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr282401wrw.308.1598639683620;
 Fri, 28 Aug 2020 11:34:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 39/45] target/arm: Implement fp16 for Neon VCVT with
 rounding modes
Date: Fri, 28 Aug 2020 19:33:48 +0100
Message-Id: <20200828183354.27913-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
---
 target/arm/helper.h             |   5 ++
 target/arm/vec_helper.c         |  23 +++++++
 target/arm/translate-neon.c.inc | 103 +++++++++++---------------------
 3 files changed, 64 insertions(+), 67 deletions(-)

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
index b3b1d46e958..899de360bf8 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3825,75 +3825,44 @@ DO_VRINT(VRINTZ, FPROUNDING_ZERO)
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
+        if (a->size == 0 ||                                             \
+            (a->size == 1 && !dc_isar_feature(aa32_fp16_arith, s)))     \
+        {                                                               \
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


