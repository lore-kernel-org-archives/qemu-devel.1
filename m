Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B495C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E1E2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0m3RAuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E1E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjau-0001H8-82
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCw-00036N-Ms
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCu-00064I-Fe
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so28166wrt.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dJYU2Ry2eB7dGlMsRwns5pnKgFniEVE8JEK6uxOoxIc=;
 b=h0m3RAuVP/D69CP9TS3WO+KCexjlkZb+PwHgg+pUmzNI8mZDwOQvdm1EPV+GmHEFfj
 s4AE6cqLaPoI0cNk9CnbWiWpbUft2QNmIIxpmDdZipDBaI04nde8W1l8BIyxE+h8KvbH
 skrNxNkC6K0R2arwwty65YZ+etZ6GC0/nyIQBGsnIhLVsDzhBC+X4v0rKI/1nZbplZ6Q
 QKSc5FNGbZRAESyuHVLWceLs5vL1moEE3qQ0LzYvdzKCMLhR6/syTbSUBsgVaTLqIh3i
 wAE2d21NwyP9CcQL4QV52cyg/HkP4q9BT7qISFoKt8JdIYMnqQIsCncmuAn8nEJhH6tm
 uLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dJYU2Ry2eB7dGlMsRwns5pnKgFniEVE8JEK6uxOoxIc=;
 b=rJtb/duxkR9guPSveHiEryvPeFThvvLV2ydF7Sb4c7/dSRbLwD7e6q6gZd+wLU6a+r
 cYwmTjtnUENeSRvvG1waS53GyiVF9GBkEQtL83ot4xdcidKYpuGo/WDcaer+aB/LOtrw
 7okXLpQbsclpJ5KzlKKx5+aHiinwB86rm2UADcLTCvWqABAr5APmC/tGemgH9XZ50sq5
 YhIceDlR51Wsefux3Bjn4YTfM++2goqtH9+3fhWZ3UhRjlH0Sz3l3lV03xofqy/veSEO
 vihjU3I1akmp1+BWB5U2BC/Hqb5bHwRbTn0kWl5BdGrop5FDo1j2T1No+czcyNkuW2vX
 i16w==
X-Gm-Message-State: AOAM531cXsqgbiL+1gykxYaUntlw3kmZ6n7eSOMbkXhWH3qUq6Me0FxJ
 m0rk6cVcQcY7rhmUEdnCLzqBVos7rY1IoDlR
X-Google-Smtp-Source: ABdhPJzgJ9ajVW6mIdOEyw7ctm+dyKR7UZSHPvWWCtnBBIrFD0R7b+BdP71UzuEyiKUW2nup5WVK+w==
X-Received: by 2002:adf:f106:: with SMTP id r6mr296038wro.106.1598639675098;
 Fri, 28 Aug 2020 11:34:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 32/45] target/arm: Implement fp16 for Neon fp compare-vs-0
Date: Fri, 28 Aug 2020 19:33:41 +0100
Message-Id: <20200828183354.27913-33-peter.maydell@linaro.org>
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

Convert the neon floating-point vector compare-vs-0 insns VCEQ0,
VCGT0, VCLE0, VCGE0 and VCLT0 to use a gvec helper, and use this to
implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 15 +++++++++++++++
 target/arm/vec_helper.c         | 25 +++++++++++++++++++++++++
 target/arm/translate-neon.c.inc | 33 +++++----------------------------
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e6f65c74614..bf2b9a7d028 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -617,6 +617,21 @@ DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 995f09fb71e..072bcd1a9d5 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -730,7 +730,32 @@ DO_2OP(gvec_frsqrte_h, helper_rsqrte_f16, float16)
 DO_2OP(gvec_frsqrte_s, helper_rsqrte_f32, float32)
 DO_2OP(gvec_frsqrte_d, helper_rsqrte_f64, float64)
 
+#define WRAP_CMP0_FWD(FN, CMPOP, TYPE)                          \
+    static TYPE TYPE##_##FN##0(TYPE op, float_status *stat)     \
+    {                                                           \
+        return TYPE##_##CMPOP(op, TYPE##_zero, stat);           \
+    }
+
+#define WRAP_CMP0_REV(FN, CMPOP, TYPE)                          \
+    static TYPE TYPE##_##FN##0(TYPE op, float_status *stat)    \
+    {                                                           \
+        return TYPE##_##CMPOP(TYPE##_zero, op, stat);           \
+    }
+
+#define DO_2OP_CMP0(FN, CMPOP, DIRN)                    \
+    WRAP_CMP0_##DIRN(FN, CMPOP, float16)                \
+    WRAP_CMP0_##DIRN(FN, CMPOP, float32)                \
+    DO_2OP(gvec_f##FN##0_h, float16_##FN##0, float16)   \
+    DO_2OP(gvec_f##FN##0_s, float32_##FN##0, float32)
+
+DO_2OP_CMP0(cgt, cgt, FWD)
+DO_2OP_CMP0(cge, cge, FWD)
+DO_2OP_CMP0(ceq, ceq, FWD)
+DO_2OP_CMP0(clt, cgt, REV)
+DO_2OP_CMP0(cle, cge, REV)
+
 #undef DO_2OP
+#undef DO_2OP_CMP0
 
 /* Floating-point trigonometric starting value.
  * See the ARM ARM pseudocode function FPTrigSMul.
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index cf5eab784bd..fe9d09973c2 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3799,6 +3799,11 @@ DO_2MISC_FP(VCVT_UF, gen_helper_vfp_touizs)
 
 DO_2MISC_FP_VEC(VRECPE_F, gen_helper_gvec_frecpe_h, gen_helper_gvec_frecpe_s)
 DO_2MISC_FP_VEC(VRSQRTE_F, gen_helper_gvec_frsqrte_h, gen_helper_gvec_frsqrte_s)
+DO_2MISC_FP_VEC(VCGT0_F, gen_helper_gvec_fcgt0_h, gen_helper_gvec_fcgt0_s)
+DO_2MISC_FP_VEC(VCGE0_F, gen_helper_gvec_fcge0_h, gen_helper_gvec_fcge0_s)
+DO_2MISC_FP_VEC(VCEQ0_F, gen_helper_gvec_fceq0_h, gen_helper_gvec_fceq0_s)
+DO_2MISC_FP_VEC(VCLT0_F, gen_helper_gvec_fclt0_h, gen_helper_gvec_fclt0_s)
+DO_2MISC_FP_VEC(VCLE0_F, gen_helper_gvec_fcle0_h, gen_helper_gvec_fcle0_s)
 
 static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
 {
@@ -3808,34 +3813,6 @@ static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
     return do_2misc_fp(s, a, gen_helper_rints_exact);
 }
 
-#define WRAP_FP_CMP0_FWD(WRAPNAME, FUNC)                        \
-    static void WRAPNAME(TCGv_i32 d, TCGv_i32 m, TCGv_ptr fpst) \
-    {                                                           \
-        TCGv_i32 zero = tcg_const_i32(0);                       \
-        FUNC(d, m, zero, fpst);                                 \
-        tcg_temp_free_i32(zero);                                \
-    }
-#define WRAP_FP_CMP0_REV(WRAPNAME, FUNC)                        \
-    static void WRAPNAME(TCGv_i32 d, TCGv_i32 m, TCGv_ptr fpst) \
-    {                                                           \
-        TCGv_i32 zero = tcg_const_i32(0);                       \
-        FUNC(d, zero, m, fpst);                                 \
-        tcg_temp_free_i32(zero);                                \
-    }
-
-#define DO_FP_CMP0(INSN, FUNC, REV)                             \
-    WRAP_FP_CMP0_##REV(gen_##INSN, FUNC)                        \
-    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
-    {                                                           \
-        return do_2misc_fp(s, a, gen_##INSN);                   \
-    }
-
-DO_FP_CMP0(VCGT0_F, gen_helper_neon_cgt_f32, FWD)
-DO_FP_CMP0(VCGE0_F, gen_helper_neon_cge_f32, FWD)
-DO_FP_CMP0(VCEQ0_F, gen_helper_neon_ceq_f32, FWD)
-DO_FP_CMP0(VCLE0_F, gen_helper_neon_cge_f32, REV)
-DO_FP_CMP0(VCLT0_F, gen_helper_neon_cgt_f32, REV)
-
 static bool do_vrint(DisasContext *s, arg_2misc *a, int rmode)
 {
     /*
-- 
2.20.1


