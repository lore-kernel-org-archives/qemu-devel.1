Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A9CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DE52075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZQWLOB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DE52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBja4-0007zx-0j
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjDD-0003Y8-Us
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD9-00068J-3R
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id a5so56875wrm.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HeYlTgG2nVHL2C245Ht4MOVEngVsjvNT2o9I6+aEd/g=;
 b=DZQWLOB1snAQ7+MVdOHjGG5wlhZXyEV2Y5fDs4OvECl2schG1LumXVlHdHOeCP+g8X
 dWm70UBx8zpN8rOrfHG4rotrbBI2UQPP2UhC8eFWTZMrpItoZwoiTvOfGgbKoqqmZ13l
 hoFL+Ody+AMoqTx6PCHt5dsDutx3uFI7ETH83IB1CjjAxUz7tXRwRQLt0esj8Yp+j3c0
 qSGFkJNp6j3JqXSg/3HQIS0c3yJvlk4MFdkvdBMGlBstQnXJGIU/jsVYV6baCz5kM78Z
 9en1lbXiYhp3DgqRhX01M36cWWFLJs0+hGOE3tUw+mWUeeWlUhnpiroUfvqV68n21frZ
 2DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HeYlTgG2nVHL2C245Ht4MOVEngVsjvNT2o9I6+aEd/g=;
 b=Cn3peuiA1+X7FB5GT4iFX42KtaiTa8SZ7l+G5ogK2ULLrqmqZTuvUI1RNRAv+XshgP
 eYx3X058E6nRWMQw0+iPUglwDoDNZvVAWal/DbGSlImvMWLY6KdfZ2SxZxduu7x1Veuk
 hjHtyeGmfYQoEPo7UVIT3c7kqmYsMpODigOwXBC9P0HUQMKkk2KQKm2Y/o+MffJfyQCa
 yV2U4WR3jWaDTAVY+LwSfw+TzkLxHFau5IU4jLEEE6TdlSvY5wNiIOpaBg/c+2BMW0w6
 PUAP2mAntYlRGNjqcRVkYJES8U93R/bRY3Qn2PHAr2u5seYDWZY2Pop7eW9PmyXstb4E
 mOPg==
X-Gm-Message-State: AOAM533i/Hs3ciXbyBfPlCI1v6igxAEGHUoEmCzW+1fcK2HXuWW2JYTD
 rEuUf4zlcO+L9Lx7TSyGxBH8ng==
X-Google-Smtp-Source: ABdhPJwz+EvxzcKUgBFcub3FXBA+tkNW6By5kRQn8CULDQoxcFoUF2sx6rHuTfnjB84CensgsT4R9w==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr259422wrl.313.1598639689208;
 Fri, 28 Aug 2020 11:34:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 44/45] target/arm: Implement fp16 for Neon VMUL, VMLA, VMLS
Date: Fri, 28 Aug 2020 19:33:53 +0100
Message-Id: <20200828183354.27913-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

Convert the Neon floating-point VMUL, VMLA and VMLS to use gvec,
and use this to implement fp16 support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.c.inc | 114 ++++++++++++++++----------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index e728415c276..f971a5f57ae 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2432,70 +2432,70 @@ static bool trans_VMLS_2sc(DisasContext *s, arg_2scalar *a)
     return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
 }
 
-/*
- * Rather than have a float-specific version of do_2scalar just for
- * three insns, we wrap a NeonGenTwoSingleOpFn to turn it into
- * a NeonGenTwoOpFn.
- */
-#define WRAP_FP_FN(WRAPNAME, FUNC)                              \
-    static void WRAPNAME(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm) \
-    {                                                           \
-        TCGv_ptr fpstatus = fpstatus_ptr(FPST_STD);             \
-        FUNC(rd, rn, rm, fpstatus);                             \
-        tcg_temp_free_ptr(fpstatus);                            \
+static bool do_2scalar_fp_vec(DisasContext *s, arg_2scalar *a,
+                              gen_helper_gvec_3_ptr *fn)
+{
+    /* Two registers and a scalar, using gvec */
+    int vec_size = a->q ? 16 : 8;
+    int rd_ofs = neon_reg_offset(a->vd, 0);
+    int rn_ofs = neon_reg_offset(a->vn, 0);
+    int rm_ofs;
+    int idx;
+    TCGv_ptr fpstatus;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
     }
 
-WRAP_FP_FN(gen_VMUL_F_mul, gen_helper_vfp_muls)
-WRAP_FP_FN(gen_VMUL_F_add, gen_helper_vfp_adds)
-WRAP_FP_FN(gen_VMUL_F_sub, gen_helper_vfp_subs)
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
 
-static bool trans_VMUL_F_2sc(DisasContext *s, arg_2scalar *a)
-{
-    static NeonGenTwoOpFn * const opfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_mul,
-        NULL,
-    };
+    if (!fn) {
+        /* Bad size (including size == 3, which is a different insn group) */
+        return false;
+    }
 
-    return do_2scalar(s, a, opfn[a->size], NULL);
+    if (a->q && ((a->vd | a->vn) & 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* a->vm is M:Vm, which encodes both register and index */
+    idx = extract32(a->vm, a->size + 2, 2);
+    a->vm = extract32(a->vm, 0, a->size + 2);
+    rm_ofs = neon_reg_offset(a->vm, 0);
+
+    fpstatus = fpstatus_ptr(a->size == 1 ? FPST_STD_F16 : FPST_STD);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, fpstatus,
+                       vec_size, vec_size, idx, fn);
+    tcg_temp_free_ptr(fpstatus);
+    return true;
 }
 
-static bool trans_VMLA_F_2sc(DisasContext *s, arg_2scalar *a)
-{
-    static NeonGenTwoOpFn * const opfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_mul,
-        NULL,
-    };
-    static NeonGenTwoOpFn * const accfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_add,
-        NULL,
-    };
+#define DO_VMUL_F_2sc(NAME, FUNC)                                       \
+    static bool trans_##NAME##_F_2sc(DisasContext *s, arg_2scalar *a)   \
+    {                                                                   \
+        static gen_helper_gvec_3_ptr * const opfn[] = {                 \
+            NULL,                                                       \
+            gen_helper_##FUNC##_h,                                      \
+            gen_helper_##FUNC##_s,                                      \
+            NULL,                                                       \
+        };                                                              \
+        if (a->size == 1 && !dc_isar_feature(aa32_fp16_arith, s)) {     \
+            return false;                                               \
+        }                                                               \
+        return do_2scalar_fp_vec(s, a, opfn[a->size]);                  \
+    }
 
-    return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
-}
-
-static bool trans_VMLS_F_2sc(DisasContext *s, arg_2scalar *a)
-{
-    static NeonGenTwoOpFn * const opfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_mul,
-        NULL,
-    };
-    static NeonGenTwoOpFn * const accfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_sub,
-        NULL,
-    };
-
-    return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
-}
+DO_VMUL_F_2sc(VMUL, gvec_fmul_idx)
+DO_VMUL_F_2sc(VMLA, gvec_fmla_nf_idx)
+DO_VMUL_F_2sc(VMLS, gvec_fmls_nf_idx)
 
 WRAP_ENV_FN(gen_VQDMULH_16, gen_helper_neon_qdmulh_s16)
 WRAP_ENV_FN(gen_VQDMULH_32, gen_helper_neon_qdmulh_s32)
-- 
2.20.1


