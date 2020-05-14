Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D36C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1D5205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr+CpkfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1D5205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF5P-0001gM-Sz
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkg-0003bG-OF
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkf-0005zS-Iq
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id l17so4380197wrr.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TdPpeoTHitQZeq3EKviTzp7kPEV6WJt0TBSu0NetBw4=;
 b=Gr+CpkfD2e7+KLhQ72I+nJ2a+DxVPC3py2Kg2W6OSq1tPWV5VOmp/nfADHWbLX1EHI
 UD+DMOb4tbHOrLj4H3O4AYLFV+UqgvlceitFlOw84YtQoCiSReMnrVrJiCUdKk8PA8EF
 cOFsXCNAmgC3zYiGu3c6WcA3d9G50t29abXA0ShFxgn8FSXFwNijSfkmI2yqSLJ3J/d7
 oM7i+NWTjy+PoN2kQEYMVxYbWykJurauWPasIMu7Wyva9wrfieykN54HSIPynYC/Ycbo
 ZIkt4ttGsdqAnnzFLRHmhjBW0IzdzUDZ+4Mc3oCkHi8MSsdUgqZKs5loJXPmN7/F5iL9
 v2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TdPpeoTHitQZeq3EKviTzp7kPEV6WJt0TBSu0NetBw4=;
 b=Um/JKmG9vIgSyCTHW96j+HSimz81mkZ8Cg4HoKl7yW5LVbyQj6xww7BvACvJeb0MDD
 pZHuubrCwY7Mjp9lwJBPWLnBbbErd+Q/9X8Q0tT453G9ppbS67witA4WsajBYr7ne45z
 nqIASp/a4NZH1+KCdqwAbn9RfSTPlxUWZz6jRfvloTJXWIjf0+92ZvxUeh2iI/VzWV1p
 TKYmMkKVApeu7yXlaRJZp66nCYu5HVb2RdriIXBKHSAWy5K7ogGc29BNW+plx0ZEXTnw
 rPwYR1jzkkbC4hd9OytC16EXStJC1pY58BOk9fSj921gIUF6shUtujDEFd9styprmB6s
 M7Dg==
X-Gm-Message-State: AOAM532XTMYmBiohTAmk9Bu/FciUcAiP5Va8znMvHRmtS3xtxf1ACzVX
 TCe45mDc6XcQ1Wde4Iy62w8PTa+wgx6AOw==
X-Google-Smtp-Source: ABdhPJzkeRE9ItIc1aeuD3Cb4LpMWW21itq7NVXDn4MYTVpVX6M49xKkcUHSHxN7s9NobU0lZELYJQ==
X-Received: by 2002:a5d:53c7:: with SMTP id a7mr6012754wrw.334.1589466139837; 
 Thu, 14 May 2020 07:22:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/45] target/arm: Convert Neon 3-reg-same SHA to decodetree
Date: Thu, 14 May 2020 15:21:23 +0100
Message-Id: <20200514142138.20875-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon SHA instructions in the 3-reg-same group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-3-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  10 +++
 target/arm/translate-neon.inc.c | 139 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  46 +----------
 3 files changed, 151 insertions(+), 44 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 82503c582ef..72eae12b265 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -99,4 +99,14 @@ VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
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


