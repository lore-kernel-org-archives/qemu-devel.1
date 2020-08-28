Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F07C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6773520776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYRaAy5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6773520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjer-00073x-Iu
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD2-0003M1-Gn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:56295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD0-00065r-Ho
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id a65so115883wme.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YxYS6bedwXk9fQo5XTWT6l9ay8TcjftA/wL59SqMRkk=;
 b=ZYRaAy5a0InMlW+RfPFwYAsn5yQ4tLaCS3PTjd4+w0CaXvWE9REOPbS9/e4n66lWiF
 5fEamfKH0uFwSGzgNQ9D0hpPkXNIN1ty8g2F4gGdrMGy2qRjM+KuLhh4EoyGv4UWoFl5
 vtVTrW46oOaNwJIaVTViWh9Qn9/bpE7AucKu6c4exfh0YEtp6Pw8wPhwhb+aJ1OP0c7C
 uz2RnjV0oAvrMtuRCE+b9g5jFEz1icE1hurIeKoGefNMhmQxKw9Bx4uUO7JWkqRv1QFY
 tCdfkQ2Zh6HrtXZEqB96mW/Cg76nzsUDrMdP3GOvxwGLyIIUnVDoIqqjenS5QqEx7kvN
 i9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YxYS6bedwXk9fQo5XTWT6l9ay8TcjftA/wL59SqMRkk=;
 b=BEIgs+qWUuYXROGZgcLgG4a0sA5WCcKeYqYLmR90Frf+Fdq+K4UrDiFpZ0wwm0Gz/+
 8MpmrImqxGFmN5oIyKxi+6m/JkE5zpk2kaVfmIghx00xqGxaAkRCO6io3im1eXbxPXuI
 9zdlHXovCjpiIggI2gNWXJYZQfmAq1GJx2Q4uIlhcODA4GlvjkhA1Q1+e8pp/zDx0ePl
 54XSXaUxj4wscrQTOcGocqAVoNcJ8OKunozcsANnGIRHpeZlH16Mep/31Qv/5LnNijLL
 OKt9XDuqlxnqOkmv3oaT7ukYSCPVOksij1EkcjQb1CYXjUJtFGM0W9rda2xJ0hCg4EC9
 hJ8w==
X-Gm-Message-State: AOAM530sTcXTslHNThFG/wuFcZI/rwNad05foNcQV7BiXV1jEwN1imD7
 eTUtHK+SO+A0T+D0ou2KdvpcSQ==
X-Google-Smtp-Source: ABdhPJyB8c1sHZb/9qWWyesgH+bvOn94vBxARDafi6Qjx3Vuhad190az2OWgxwUNS13wsF9afyx6RQ==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr15745wmj.79.1598639681164;
 Fri, 28 Aug 2020 11:34:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 37/45] target/arm: Convert Neon VCVT fixed-point to gvec
Date: Fri, 28 Aug 2020 19:33:46 +0100
Message-Id: <20200828183354.27913-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Convert the Neon VCVT float<->fixed-point insns to a
gvec style, in preparation for adding fp16 support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  5 +++++
 target/arm/vec_helper.c         | 20 +++++++++++++++++++
 target/arm/translate-neon.c.inc | 35 +++++++++++++++++----------------
 3 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1d8badf4a21..09e0fa052ef 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -623,6 +623,11 @@ DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 6ea9807b790..6d83953ee8f 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1845,3 +1845,23 @@ DO_NEON_PAIRWISE(neon_pmax, max)
 DO_NEON_PAIRWISE(neon_pmin, min)
 
 #undef DO_NEON_PAIRWISE
+
+#define DO_VCVT_FIXED(NAME, FUNC, TYPE)                                 \
+    void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
+    {                                                                   \
+        intptr_t i, oprsz = simd_oprsz(desc);                           \
+        int shift = simd_data(desc);                                    \
+        TYPE *d = vd, *n = vn;                                          \
+        float_status *fpst = stat;                                      \
+        for (i = 0; i < oprsz / sizeof(TYPE); i++) {                    \
+            d[i] = FUNC(n[i], shift, fpst);                             \
+        }                                                               \
+        clear_tail(d, oprsz, simd_maxsz(desc));                         \
+    }
+
+DO_VCVT_FIXED(gvec_vcvt_sf, helper_vfp_sltos, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_uf, helper_vfp_ultos, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_fs, helper_vfp_tosls_round_to_zero, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_fu, helper_vfp_touls_round_to_zero, uint32_t)
+
+#undef DO_VCVT_FIXED
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index f77506dab24..50fcf4159ea 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1608,17 +1608,24 @@ static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
 }
 
 static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
-                      NeonGenTwoSingleOpFn *fn)
+                      gen_helper_gvec_2_ptr *fn)
 {
     /* FP operations in 2-reg-and-shift group */
-    TCGv_i32 tmp, shiftv;
-    TCGv_ptr fpstatus;
-    int pass;
+    int vec_size = a->q ? 16 : 8;
+    int rd_ofs = neon_reg_offset(a->vd, 0);
+    int rm_ofs = neon_reg_offset(a->vm, 0);
+    TCGv_ptr fpst;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
     }
 
+    if (a->size != 0) {
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist. */
     if (!dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vd | a->vm) & 0x10)) {
@@ -1633,15 +1640,9 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return true;
     }
 
-    fpstatus = fpstatus_ptr(FPST_STD);
-    shiftv = tcg_const_i32(a->shift);
-    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        tmp = neon_load_reg(a->vm, pass);
-        fn(tmp, tmp, shiftv, fpstatus);
-        neon_store_reg(a->vd, pass, tmp);
-    }
-    tcg_temp_free_ptr(fpstatus);
-    tcg_temp_free_i32(shiftv);
+    fpst = fpstatus_ptr(a->size ? FPST_STD_F16 : FPST_STD);
+    tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, vec_size, vec_size, a->shift, fn);
+    tcg_temp_free_ptr(fpst);
     return true;
 }
 
@@ -1651,10 +1652,10 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return do_fp_2sh(s, a, FUNC);                                   \
     }
 
-DO_FP_2SH(VCVT_SF, gen_helper_vfp_sltos)
-DO_FP_2SH(VCVT_UF, gen_helper_vfp_ultos)
-DO_FP_2SH(VCVT_FS, gen_helper_vfp_tosls_round_to_zero)
-DO_FP_2SH(VCVT_FU, gen_helper_vfp_touls_round_to_zero)
+DO_FP_2SH(VCVT_SF, gen_helper_gvec_vcvt_sf)
+DO_FP_2SH(VCVT_UF, gen_helper_gvec_vcvt_uf)
+DO_FP_2SH(VCVT_FS, gen_helper_gvec_vcvt_fs)
+DO_FP_2SH(VCVT_FU, gen_helper_gvec_vcvt_fu)
 
 static uint64_t asimd_imm_const(uint32_t imm, int cmode, int op)
 {
-- 
2.20.1


