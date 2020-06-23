Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ECAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F3820724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pROU2lrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F3820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhM6-000476-D2
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGp-0002TQ-65
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGn-0003Aq-7o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id g75so2653908wme.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hNxPLLU5YxcQYsL+b5Qc2K9m6PnR63Dpa+71JoqbIwc=;
 b=pROU2lrcjKSTJyYOClVTaf/t9cHq2HQqYjx/QyRx7Zg77kSz9bqDTeYzJKItd/s4ja
 BBKOLCef5mkBtx3rcmTTQVxHvejkGQE0+fIlFiH4c9xdDrPlldq572hQTKDhgEdHnHPb
 wAC8pHRi6msMhyHiIOl7q95BTPVIZP+zTdosuFkaMhRZuCFsyOl3WAP4E5jmibpMh1qn
 ZZXSRNQ2w4sqndzwb6B6K7Id93F/pa4c0iYXYAnJrJm+nTJnEW1E4oXWu88/8c4cl0+h
 VR3zCVTw6trhg/wSt9x6HKNfiWKitAw3iWY2hapxo+NNAzXMLaiQCfMoEzgCOri4J7Wv
 8Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hNxPLLU5YxcQYsL+b5Qc2K9m6PnR63Dpa+71JoqbIwc=;
 b=oWs3PFZk1Kudaonh2bQcLurU9kNzfurQe4ps/FtSPB6tWLs/XY0pRqJvqEjIZr5uu/
 2oBEg7t0ibmEir8umJNv+CCJSY4fz406dcBegTQ11wtYyFkpxTbKEbBaw6lsHC+lpa/L
 8K1+1FkJLbDE/oNujMBfjFWrno2A+4moZlQm/bJUf4avDpJE/4wA4Q02fL2MDWsan7nN
 4nMOJLhN/+UpkVxkQgJ/oZzy8ZDFq/IcCeiCc8/kMRa5p3WJHvFWKeZwSJOoctpMXsuM
 ffyPlLmdSfQMaGKUXAu/V2Bs9HRrQiPymeY7Vo4BZXvmLwzfsA8nmg5Y3DB21WpD5ZOZ
 iPYQ==
X-Gm-Message-State: AOAM530Edf4S2AlsSq1qc5OJPZYMPNwgom0wgMGHbQtn31DNewPsZRlB
 M7bs8O9/6NjeKzZIKHqYisu/q5F1h0CAdA==
X-Google-Smtp-Source: ABdhPJwtXl654NAvsNXz436kAdMMUV9SRpPQHPcuiMIvdPFxjw1msZCPXjYG/VuzS8GkG0Dn6dUWCA==
X-Received: by 2002:a1c:154:: with SMTP id 81mr23325878wmb.23.1592912355376;
 Tue, 23 Jun 2020 04:39:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/42] target/arm: Convert Neon VCVT f16/f32 insns to decodetree
Date: Tue, 23 Jun 2020 12:38:30 +0100
Message-Id: <20200623113904.28805-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Convert the Neon insns in the 2-reg-misc group which are
VCVT between f32 and f16 to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-7-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 96 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 65 ++--------------------
 3 files changed, 102 insertions(+), 62 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 0102aa7254b..8174f2f92f4 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -461,6 +461,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VQMOVN_U     1111 001 11 . 11 .. 10 .... 0 0101 1 . 0 .... @2misc_q0
 
     VSHLL        1111 001 11 . 11 .. 10 .... 0 0110 0 . 0 .... @2misc_q0
+
+    VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
+    VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 78239ec1c1b..d37be597cf4 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3354,3 +3354,99 @@ static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
     tcg_temp_free_i32(rm1);
     return true;
 }
+
+static bool trans_VCVT_F16_F32(DisasContext *s, arg_2misc *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp, tmp, tmp2, tmp3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_fp16_spconv, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vm & 1) || (a->size != 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(true);
+    ahp = get_ahp_flag();
+    tmp = neon_load_reg(a->vm, 0);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+    tmp2 = neon_load_reg(a->vm, 1);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
+    tcg_gen_shli_i32(tmp2, tmp2, 16);
+    tcg_gen_or_i32(tmp2, tmp2, tmp);
+    tcg_temp_free_i32(tmp);
+    tmp = neon_load_reg(a->vm, 2);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+    tmp3 = neon_load_reg(a->vm, 3);
+    neon_store_reg(a->vd, 0, tmp2);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
+    tcg_gen_shli_i32(tmp3, tmp3, 16);
+    tcg_gen_or_i32(tmp3, tmp3, tmp);
+    neon_store_reg(a->vd, 1, tmp3);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(ahp);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
+static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp, tmp, tmp2, tmp3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_fp16_spconv, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd & 1) || (a->size != 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(true);
+    ahp = get_ahp_flag();
+    tmp3 = tcg_temp_new_i32();
+    tmp = neon_load_reg(a->vm, 0);
+    tmp2 = neon_load_reg(a->vm, 1);
+    tcg_gen_ext16u_i32(tmp3, tmp);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
+    neon_store_reg(a->vd, 0, tmp3);
+    tcg_gen_shri_i32(tmp, tmp, 16);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp);
+    neon_store_reg(a->vd, 1, tmp);
+    tmp3 = tcg_temp_new_i32();
+    tcg_gen_ext16u_i32(tmp3, tmp2);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
+    neon_store_reg(a->vd, 2, tmp3);
+    tcg_gen_shri_i32(tmp2, tmp2, 16);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp2, tmp2, fpst, ahp);
+    neon_store_reg(a->vd, 3, tmp2);
+    tcg_temp_free_i32(ahp);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 94d5e34fff4..1ea09695546 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4860,7 +4860,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int pass;
     int u;
     int vec_size;
-    TCGv_i32 tmp, tmp2, tmp3;
+    TCGv_i32 tmp, tmp2;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return 1;
@@ -4927,6 +4927,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VZIP:
                 case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
                 case NEON_2RM_VSHLL:
+                case NEON_2RM_VCVT_F16_F32:
+                case NEON_2RM_VCVT_F32_F16:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4942,67 +4944,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         goto elementwise;
                     }
                     break;
-                case NEON_2RM_VCVT_F16_F32:
-                {
-                    TCGv_ptr fpst;
-                    TCGv_i32 ahp;
-
-                    if (!dc_isar_feature(aa32_fp16_spconv, s) ||
-                        q || (rm & 1)) {
-                        return 1;
-                    }
-                    fpst = get_fpstatus_ptr(true);
-                    ahp = get_ahp_flag();
-                    tmp = neon_load_reg(rm, 0);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-                    tmp2 = neon_load_reg(rm, 1);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
-                    tcg_gen_shli_i32(tmp2, tmp2, 16);
-                    tcg_gen_or_i32(tmp2, tmp2, tmp);
-                    tcg_temp_free_i32(tmp);
-                    tmp = neon_load_reg(rm, 2);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-                    tmp3 = neon_load_reg(rm, 3);
-                    neon_store_reg(rd, 0, tmp2);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
-                    tcg_gen_shli_i32(tmp3, tmp3, 16);
-                    tcg_gen_or_i32(tmp3, tmp3, tmp);
-                    neon_store_reg(rd, 1, tmp3);
-                    tcg_temp_free_i32(tmp);
-                    tcg_temp_free_i32(ahp);
-                    tcg_temp_free_ptr(fpst);
-                    break;
-                }
-                case NEON_2RM_VCVT_F32_F16:
-                {
-                    TCGv_ptr fpst;
-                    TCGv_i32 ahp;
-                    if (!dc_isar_feature(aa32_fp16_spconv, s) ||
-                        q || (rd & 1)) {
-                        return 1;
-                    }
-                    fpst = get_fpstatus_ptr(true);
-                    ahp = get_ahp_flag();
-                    tmp3 = tcg_temp_new_i32();
-                    tmp = neon_load_reg(rm, 0);
-                    tmp2 = neon_load_reg(rm, 1);
-                    tcg_gen_ext16u_i32(tmp3, tmp);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
-                    neon_store_reg(rd, 0, tmp3);
-                    tcg_gen_shri_i32(tmp, tmp, 16);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp);
-                    neon_store_reg(rd, 1, tmp);
-                    tmp3 = tcg_temp_new_i32();
-                    tcg_gen_ext16u_i32(tmp3, tmp2);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
-                    neon_store_reg(rd, 2, tmp3);
-                    tcg_gen_shri_i32(tmp2, tmp2, 16);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp2, tmp2, fpst, ahp);
-                    neon_store_reg(rd, 3, tmp2);
-                    tcg_temp_free_i32(ahp);
-                    tcg_temp_free_ptr(fpst);
-                    break;
-                }
                 case NEON_2RM_AESE: case NEON_2RM_AESMC:
                     if (!dc_isar_feature(aa32_aes, s) || ((rm | rd) & 1)) {
                         return 1;
-- 
2.20.1


