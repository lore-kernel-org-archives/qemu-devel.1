Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D9CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42497206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6BJGvEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42497206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXxT-0008Hj-8n
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXvz-0006Ah-UJ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXvy-00061V-QX
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id 50so15763962wrc.11
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WX2yhGL+5A/xIoAy1lX3eCz5+m+tDDilj9TcJLBfsZo=;
 b=R6BJGvEsANjNW2tuQi1uy9ImNNdc/a7cgoXPqR9uVBLZ5bFj/Dq3WWlBitTMxcv0DI
 e2bx9ilOL4mC1sSHwMOUrnfzTpNh6sLwS+tB98w62JnuwGAQkaEnWwqglmnHJZOYqcii
 VCbmb95d7DBH1nMDEzoLJH9WFoym2fP7fGhmP6X9ABL7hy6vLwZ5d5FemiJ4CVyvZ7ZC
 Z+2lnhW+BPBCH9Zb0BiKYBXIRrEgD9VjbwscSfMvVAv8pMQVB1/cD33eGht3tUAiim47
 PcCFO5xR+rqR5qw+oWiOiCv1Pq8Y0IQqLMSulp4juctHsTg1gUe78FT8UNaEegmcOsEo
 v12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WX2yhGL+5A/xIoAy1lX3eCz5+m+tDDilj9TcJLBfsZo=;
 b=aAQ6uPfN4TyPGtWoNUhfeyTIdcUe403Nr/7STsbue0/f5z3Cd0EJ/byhd0U5uykIJ9
 AutmO5s2HrbEeiTV2A++PPrAQ19U8YNqO/of9MruNOuPVnKtPPD1jVH7BWkCv8hMaso8
 XguZVcK8jDbXBeXtUaUS8mV3Ab1VA8DHIwzEEZaGk6NpalDqCrgVbySn3t8oCB0YbNuh
 HVjFGSZvO4B6SyWNvsUCqjU1rvhXl7dgqgKb6ooNrmPv6AwyYnHBU9/WRwGlT8p2rZR0
 Oi9fPt5uwF6ysskaMghxtZysSvERvkLN7tSlV/JhX/yffgyIXre6x4JugqkE22/gJs7p
 a5pg==
X-Gm-Message-State: AGi0Puap+cnRLuBrXYCxjzDAgxdghEazX/862ym62dhME238bpIagTdh
 JMv/XZmcFvqqAm8TPZITOJKuVw==
X-Google-Smtp-Source: APiQypJe8TC6yZh6d5OBnMVYkr8HWHcyjF9JPG3LHR1Uu5M5wgO7Wd4UsZwCBs9n3BCF5Ttln07ELw==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr25283374wrw.17.1589301549505; 
 Tue, 12 May 2020 09:39:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/17] target/arm: Convert Neon 3-reg-same SHA to decodetree
Date: Tue, 12 May 2020 17:38:49 +0100
Message-Id: <20200512163904.10918-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

Convert the Neon SHA instructions in the 3-reg-same group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  10 +++
 target/arm/translate-neon.inc.c | 139 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  46 +----------
 3 files changed, 151 insertions(+), 44 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 04aff438410..68b0a44793f 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -91,4 +91,14 @@ VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
 VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
 
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
+
+SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256H_3s       1111 001 1 0 . 00 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256H2_3s      1111 001 1 0 . 01 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
 VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 661b5fc4cf2..03b3337e460 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -686,3 +686,142 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
 
 DO_VQRDMLAH(VQRDMLAH, gen_gvec_sqrdmlah_qc)
 DO_VQRDMLAH(VQRDMLSH, gen_gvec_sqrdmlsh_qc)
+
+static bool trans_SHA1_3s(DisasContext *s, arg_SHA1_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+    TCGv_i32 tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha1, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    tmp = tcg_const_i32(a->optype);
+    gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
+
+static bool trans_SHA256H_3s(DisasContext *s, arg_SHA256H_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha2, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
+
+static bool trans_SHA256H2_3s(DisasContext *s, arg_SHA256H2_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha2, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
+
+static bool trans_SHA256SU1_3s(DisasContext *s, arg_SHA256SU1_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha2, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1f06cb5a87f..ee2b8d6f6e3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5359,7 +5359,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int vec_size;
     uint32_t imm;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
-    TCGv_ptr ptr1, ptr2, ptr3;
+    TCGv_ptr ptr1, ptr2;
     TCGv_i64 tmp64;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -5403,49 +5403,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_SHA:
-            /* The SHA-1/SHA-256 3-register instructions require special
-             * treatment here, as their size field is overloaded as an
-             * op type selector, and they all consume their input in a
-             * single pass.
-             */
-            if (!q) {
-                return 1;
-            }
-            if (!u) { /* SHA-1 */
-                if (!dc_isar_feature(aa32_sha1, s)) {
-                    return 1;
-                }
-                ptr1 = vfp_reg_ptr(true, rd);
-                ptr2 = vfp_reg_ptr(true, rn);
-                ptr3 = vfp_reg_ptr(true, rm);
-                tmp4 = tcg_const_i32(size);
-                gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
-                tcg_temp_free_i32(tmp4);
-            } else { /* SHA-256 */
-                if (!dc_isar_feature(aa32_sha2, s) || size == 3) {
-                    return 1;
-                }
-                ptr1 = vfp_reg_ptr(true, rd);
-                ptr2 = vfp_reg_ptr(true, rn);
-                ptr3 = vfp_reg_ptr(true, rm);
-                switch (size) {
-                case 0:
-                    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
-                    break;
-                case 1:
-                    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
-                    break;
-                case 2:
-                    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
-                    break;
-                }
-            }
-            tcg_temp_free_ptr(ptr1);
-            tcg_temp_free_ptr(ptr2);
-            tcg_temp_free_ptr(ptr3);
-            return 0;
-
         case NEON_3R_VPADD_VQRDMLAH:
             if (!u) {
                 break;  /* VPADD */
@@ -5496,6 +5453,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VMUL:
         case NEON_3R_VML:
         case NEON_3R_VSHL:
+        case NEON_3R_SHA:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


