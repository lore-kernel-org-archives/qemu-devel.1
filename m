Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347D120738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRa3pShF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347D120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhY5-0000S6-F9
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH4-00033d-L6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH2-0003FA-4u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id j18so2672968wmi.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0/e8tX0uOXBo9D63Bjooc66KZbzN4/gDa4yVcnCjX4o=;
 b=HRa3pShF6NKrk0vreTw8DEGYW7A6u0gvrv3F8psM+f/sHPxQTQB6s1W+aNM+qxlS45
 E3044scBfyfSGfsFZUKdhZEG/6zpnyGoKTdAGgDRpvm9ipWzvC5lzwjHKwYD5qKc7v0D
 qrPuc+huXD8HudoDOf02L65q71LDyZPMrQezQF+WYoMhuRnzoP0tjG2MeHRQa1rii/lR
 Fz//F5+uZ3AjxDjgxlkSN8PNc1AK9Y65ubRQsj8wUQWkxVN8h3HNReWb/+K3otKi8700
 Uqi3ISQXSdEDjsTr7w8uH/JzlhWe+hwJHNEChD51+gLDnbnJW+fFsmPpiqaGCaslLk6Z
 X/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0/e8tX0uOXBo9D63Bjooc66KZbzN4/gDa4yVcnCjX4o=;
 b=F9Ll9OBSip8LA/ob+J/jYoOEwu3QhCDjeVEHJ3URYoZgHfB2rVX5rvRV0XSJnShHga
 bWRV4blPPcFEVIQMRuOwBx3qy1hW/0IAHcNJZko27SlbwD+vHQnyoUx6XaHQxe/jdVfT
 raE5jNXiljzsKH1HXkkEzAB/p+w74IPiTUwiW5M6aDvKOrZkPnPXdOMWmzxJkYC5q4mD
 R2JngNuP1oAx3Y513KJqX8WdIalvxBuBxRxi4fe9mRLRVW+o2Xn7TPQunvh7QyTcxTFB
 Zve9vU4McSvT9x69zdARFgprLiN36rTmlJJH9IcRS8rvM2iDd/7h/G6iTisdH7PKl0re
 hcUQ==
X-Gm-Message-State: AOAM533evSJ3FyFarKa2Ga+kzNH0oRBdVoH83oM/7mcelpoDhXnq5TwR
 RqU0tJv15pVCT/UAXlVOTI08iyJyp/L3eg==
X-Google-Smtp-Source: ABdhPJw8qCLCd23d03KAop1QVc2DMvojRP57qlTGnR+PQ6s4rZ41cWcJAIIDK+rSnrBLhTEc1W7o6g==
X-Received: by 2002:a05:600c:410f:: with SMTP id
 j15mr534475wmi.128.1592912369283; 
 Tue, 23 Jun 2020 04:39:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/42] target/arm: Convert Neon 2-reg-misc VCVT insns to
 decodetree
Date: Tue, 23 Jun 2020 12:38:42 +0100
Message-Id: <20200623113904.28805-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Convert the VCVT instructions in the 2-reg-misc grouping to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-19-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  9 +++++
 target/arm/translate-neon.inc.c | 70 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 70 ++++-----------------------------
 3 files changed, 87 insertions(+), 62 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index e0717c7e4a6..5507c3e4623 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -516,6 +516,15 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VRINTP       1111 001 11 . 11 .. 10 .... 0 1111 . . 0 .... @2misc
 
+    VCVTAS       1111 001 11 . 11 .. 11 .... 0 0000 . . 0 .... @2misc
+    VCVTAU       1111 001 11 . 11 .. 11 .... 0 0001 . . 0 .... @2misc
+    VCVTNS       1111 001 11 . 11 .. 11 .... 0 0010 . . 0 .... @2misc
+    VCVTNU       1111 001 11 . 11 .. 11 .... 0 0011 . . 0 .... @2misc
+    VCVTPS       1111 001 11 . 11 .. 11 .... 0 0100 . . 0 .... @2misc
+    VCVTPU       1111 001 11 . 11 .. 11 .... 0 0101 . . 0 .... @2misc
+    VCVTMS       1111 001 11 . 11 .. 11 .... 0 0110 . . 0 .... @2misc
+    VCVTMU       1111 001 11 . 11 .. 11 .... 0 0111 . . 0 .... @2misc
+
     VRECPE       1111 001 11 . 11 .. 11 .... 0 1000 . . 0 .... @2misc
     VRSQRTE      1111 001 11 . 11 .. 11 .... 0 1001 . . 0 .... @2misc
     VRECPE_F     1111 001 11 . 11 .. 11 .... 0 1010 . . 0 .... @2misc
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0e7f86ad156..29bc161f36a 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3857,3 +3857,73 @@ DO_VRINT(VRINTA, FPROUNDING_TIEAWAY)
 DO_VRINT(VRINTZ, FPROUNDING_ZERO)
 DO_VRINT(VRINTM, FPROUNDING_NEGINF)
 DO_VRINT(VRINTP, FPROUNDING_POSINF)
+
+static bool do_vcvt(DisasContext *s, arg_2misc *a, int rmode, bool is_signed)
+{
+    /*
+     * Handle a VCVT* operation by iterating 32 bits at a time,
+     * with a specified rounding mode in operation.
+     */
+    int pass;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode, tcg_shift;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size != 2) {
+        /* TODO: FP16 will be the size == 1 case */
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(1);
+    tcg_shift = tcg_const_i32(0);
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
+    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        if (is_signed) {
+            gen_helper_vfp_tosls(tmp, tmp, tcg_shift, fpst);
+        } else {
+            gen_helper_vfp_touls(tmp, tmp, tcg_shift, fpst);
+        }
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    tcg_temp_free_i32(tcg_rmode);
+    tcg_temp_free_i32(tcg_shift);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
+#define DO_VCVT(INSN, RMODE, SIGNED)                            \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        return do_vcvt(s, a, RMODE, SIGNED);                    \
+    }
+
+DO_VCVT(VCVTAU, FPROUNDING_TIEAWAY, false)
+DO_VCVT(VCVTAS, FPROUNDING_TIEAWAY, true)
+DO_VCVT(VCVTNU, FPROUNDING_TIEEVEN, false)
+DO_VCVT(VCVTNS, FPROUNDING_TIEEVEN, true)
+DO_VCVT(VCVTPU, FPROUNDING_POSINF, false)
+DO_VCVT(VCVTPS, FPROUNDING_POSINF, true)
+DO_VCVT(VCVTMU, FPROUNDING_NEGINF, false)
+DO_VCVT(VCVTMS, FPROUNDING_NEGINF, true)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 61dfc3ae7af..b0181062020 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3042,30 +3042,6 @@ static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
 #define NEON_2RM_VCVT_SF 62
 #define NEON_2RM_VCVT_UF 63
 
-static bool neon_2rm_is_v8_op(int op)
-{
-    /* Return true if this neon 2reg-misc op is ARMv8 and up */
-    switch (op) {
-    case NEON_2RM_VRINTN:
-    case NEON_2RM_VRINTA:
-    case NEON_2RM_VRINTM:
-    case NEON_2RM_VRINTP:
-    case NEON_2RM_VRINTZ:
-    case NEON_2RM_VRINTX:
-    case NEON_2RM_VCVTAU:
-    case NEON_2RM_VCVTAS:
-    case NEON_2RM_VCVTNU:
-    case NEON_2RM_VCVTNS:
-    case NEON_2RM_VCVTPU:
-    case NEON_2RM_VCVTPS:
-    case NEON_2RM_VCVTMU:
-    case NEON_2RM_VCVTMS:
-        return true;
-    default:
-        return false;
-    }
-}
-
 /* Each entry in this array has bit n set if the insn allows
  * size value n (otherwise it will UNDEF). Since unallocated
  * op values will have no bits set they always UNDEF.
@@ -4908,10 +4884,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 if ((neon_2rm_sizes[op] & (1 << size)) == 0) {
                     return 1;
                 }
-                if (neon_2rm_is_v8_op(op) &&
-                    !arm_dc_feature(s, ARM_FEATURE_V8)) {
-                    return 1;
-                }
                 if (q && ((rm | rd) & 1)) {
                     return 1;
                 }
@@ -4964,6 +4936,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VRINTM:
                 case NEON_2RM_VRINTP:
                 case NEON_2RM_VRINTZ:
+                case NEON_2RM_VCVTAU:
+                case NEON_2RM_VCVTAS:
+                case NEON_2RM_VCVTNU:
+                case NEON_2RM_VCVTNS:
+                case NEON_2RM_VCVTPU:
+                case NEON_2RM_VCVTPS:
+                case NEON_2RM_VCVTMU:
+                case NEON_2RM_VCVTMS:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4998,40 +4978,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                             neon_store_reg(rm, pass, tmp2);
                             break;
-                        case NEON_2RM_VCVTAU:
-                        case NEON_2RM_VCVTAS:
-                        case NEON_2RM_VCVTNU:
-                        case NEON_2RM_VCVTNS:
-                        case NEON_2RM_VCVTPU:
-                        case NEON_2RM_VCVTPS:
-                        case NEON_2RM_VCVTMU:
-                        case NEON_2RM_VCVTMS:
-                        {
-                            bool is_signed = !extract32(insn, 7, 1);
-                            TCGv_ptr fpst = get_fpstatus_ptr(1);
-                            TCGv_i32 tcg_rmode, tcg_shift;
-                            int rmode = fp_decode_rm[extract32(insn, 8, 2)];
-
-                            tcg_shift = tcg_const_i32(0);
-                            tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-                            gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
-                                                      cpu_env);
-
-                            if (is_signed) {
-                                gen_helper_vfp_tosls(tmp, tmp,
-                                                     tcg_shift, fpst);
-                            } else {
-                                gen_helper_vfp_touls(tmp, tmp,
-                                                     tcg_shift, fpst);
-                            }
-
-                            gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
-                                                      cpu_env);
-                            tcg_temp_free_i32(tcg_rmode);
-                            tcg_temp_free_i32(tcg_shift);
-                            tcg_temp_free_ptr(fpst);
-                            break;
-                        }
                         default:
                             /* Reserved op values were caught by the
                              * neon_2rm_sizes[] check earlier.
-- 
2.20.1


