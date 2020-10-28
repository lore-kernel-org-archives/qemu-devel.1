Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6D62242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+Am5Fng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6D62242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcIS-000124-Lk
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7R-00062q-4A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:25 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7O-0005r2-Sa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id e15so2113169pfh.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I1RxcADQNWXG6kJXZJzeM0kiw0mxZyWZrvQsQoREMmo=;
 b=g+Am5FngPgmTr/0tGjUcihdbCea4vAppVBtllr16G4pNKZnXmU06Db8HEhGd6CLlP7
 WK6y6lgej9IPezdd5yfhP7noGq1uF5XdvJzmePmYJfmIZVmya1BZVGPMqr6wxmTBmRih
 M0YAmYAzl9lGhPrMeknzmjuBn1mlcP3vl8AHJaa0G+uFWfgDqSFgNZDxzJUU7mK7Kczn
 bZplHscNNoO90K4xtCR8NEBMAb1ERWOONTnXmAA7QnLHwJVt3yX4HcyyPDuxaeUMYMvV
 lFKK4NkLk7Z5txW3zlnWr8YoV1Td4rtNmCwcnhqUpVL7njYui8ox1LxpjSAyyT7z+nze
 nH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I1RxcADQNWXG6kJXZJzeM0kiw0mxZyWZrvQsQoREMmo=;
 b=uRrU8zbgKYjIbLzHID2A64T8Bou4LWPPLiCZsuqG58XSv2SsZGjWrJIvt/nylm1IRk
 HqSKGSmJvF6+VyqvV/uI2FZQVYRercBux4JGwZd0bIGm66XVdd3Bs9Lra/b2iZ6DYwSj
 7eekZxkTf+6uR/2cG4pNlYx/eEVMewjkLSLbr54n9Jr9g2woNxp/Jwmyh9Z5PJljxRLw
 2thPYpN5n5+2ksVtYbcDX3fed5DKsJez74pbIHqw4VbaBNYNBDluxhBm/38eq3EZA0CF
 52P5IeRlFlp0UdBNyP0lNs0RW0OQCea0WldgkbKFHqHvsLCf2HF/P21vCEM71SXTqP7Q
 hiwA==
X-Gm-Message-State: AOAM530G0GAafmAXJ70Xx+qhSyVbbItM6JhLykTJCr4PGsVswc4zO1fl
 xYLf2cOgKrsZWEXEawjQpZQ64iuyKhjYyQ==
X-Google-Smtp-Source: ABdhPJwzUPvSQgbiGzcWLw54sqjlVyeAE8ERHPClLl5wF9fvt8+pZw6WvV7cgLja1YH1LKkvTXX+cg==
X-Received: by 2002:a05:6a00:2d5:b029:152:197a:a23a with SMTP id
 b21-20020a056a0002d5b0290152197aa23amr5311316pft.66.1603855640831; 
 Tue, 27 Oct 2020 20:27:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] target/arm: Rename neon_load_reg64 to vfp_load_reg64
Date: Tue, 27 Oct 2020 20:27:01 -0700
Message-Id: <20201028032703.201526-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only uses of this function are for loading VFP
double-precision values, and nothing to do with NEON.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c         |  8 ++--
 target/arm/translate-vfp.c.inc | 84 +++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4fb0a62200..7611c1f0f1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1132,14 +1132,14 @@ static long vfp_reg_offset(bool dp, unsigned reg)
     }
 }
 
-static inline void neon_load_reg64(TCGv_i64 var, int reg)
+static inline void vfp_load_reg64(TCGv_i64 var, int reg)
 {
-    tcg_gen_ld_i64(var, cpu_env, vfp_reg_offset(1, reg));
+    tcg_gen_ld_i64(var, cpu_env, vfp_reg_offset(true, reg));
 }
 
-static inline void neon_store_reg64(TCGv_i64 var, int reg)
+static inline void vfp_store_reg64(TCGv_i64 var, int reg)
 {
-    tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(1, reg));
+    tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(true, reg));
 }
 
 static inline void vfp_load_reg32(TCGv_i32 var, int reg)
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index d2a9b658bb..f966de5b1f 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -236,8 +236,8 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         tcg_gen_ext_i32_i64(nf, cpu_NF);
         tcg_gen_ext_i32_i64(vf, cpu_VF);
 
-        neon_load_reg64(frn, rn);
-        neon_load_reg64(frm, rm);
+        vfp_load_reg64(frn, rn);
+        vfp_load_reg64(frm, rm);
         switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
@@ -264,7 +264,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
             tcg_temp_free_i64(tmp);
             break;
         }
-        neon_store_reg64(dest, rd);
+        vfp_store_reg64(dest, rd);
         tcg_temp_free_i64(frn);
         tcg_temp_free_i64(frm);
         tcg_temp_free_i64(dest);
@@ -385,9 +385,9 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         TCGv_i64 tcg_res;
         tcg_op = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
-        neon_load_reg64(tcg_op, rm);
+        vfp_load_reg64(tcg_op, rm);
         gen_helper_rintd(tcg_res, tcg_op, fpst);
-        neon_store_reg64(tcg_res, rd);
+        vfp_store_reg64(tcg_res, rd);
         tcg_temp_free_i64(tcg_op);
         tcg_temp_free_i64(tcg_res);
     } else {
@@ -463,7 +463,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         tcg_double = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
         tcg_tmp = tcg_temp_new_i32();
-        neon_load_reg64(tcg_double, rm);
+        vfp_load_reg64(tcg_double, rm);
         if (is_signed) {
             gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
         } else {
@@ -1002,9 +1002,9 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     tmp = tcg_temp_new_i64();
     if (a->l) {
         gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
-        neon_store_reg64(tmp, a->vd);
+        vfp_store_reg64(tmp, a->vd);
     } else {
-        neon_load_reg64(tmp, a->vd);
+        vfp_load_reg64(tmp, a->vd);
         gen_aa32_st64(s, tmp, addr, get_mem_index(s));
     }
     tcg_temp_free_i64(tmp);
@@ -1149,10 +1149,10 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
         if (a->l) {
             /* load */
             gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
-            neon_store_reg64(tmp, a->vd + i);
+            vfp_store_reg64(tmp, a->vd + i);
         } else {
             /* store */
-            neon_load_reg64(tmp, a->vd + i);
+            vfp_load_reg64(tmp, a->vd + i);
             gen_aa32_st64(s, tmp, addr, get_mem_index(s));
         }
         tcg_gen_addi_i32(addr, addr, offset);
@@ -1416,15 +1416,15 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     fd = tcg_temp_new_i64();
     fpst = fpstatus_ptr(FPST_FPCR);
 
-    neon_load_reg64(f0, vn);
-    neon_load_reg64(f1, vm);
+    vfp_load_reg64(f0, vn);
+    vfp_load_reg64(f1, vm);
 
     for (;;) {
         if (reads_vd) {
-            neon_load_reg64(fd, vd);
+            vfp_load_reg64(fd, vd);
         }
         fn(fd, f0, f1, fpst);
-        neon_store_reg64(fd, vd);
+        vfp_store_reg64(fd, vd);
 
         if (veclen == 0) {
             break;
@@ -1433,10 +1433,10 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         veclen--;
         vd = vfp_advance_dreg(vd, delta_d);
         vn = vfp_advance_dreg(vn, delta_d);
-        neon_load_reg64(f0, vn);
+        vfp_load_reg64(f0, vn);
         if (delta_m) {
             vm = vfp_advance_dreg(vm, delta_m);
-            neon_load_reg64(f1, vm);
+            vfp_load_reg64(f1, vm);
         }
     }
 
@@ -1599,11 +1599,11 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     f0 = tcg_temp_new_i64();
     fd = tcg_temp_new_i64();
 
-    neon_load_reg64(f0, vm);
+    vfp_load_reg64(f0, vm);
 
     for (;;) {
         fn(fd, f0);
-        neon_store_reg64(fd, vd);
+        vfp_store_reg64(fd, vd);
 
         if (veclen == 0) {
             break;
@@ -1613,7 +1613,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
             /* single source one-many */
             while (veclen--) {
                 vd = vfp_advance_dreg(vd, delta_d);
-                neon_store_reg64(fd, vd);
+                vfp_store_reg64(fd, vd);
             }
             break;
         }
@@ -1622,7 +1622,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         veclen--;
         vd = vfp_advance_dreg(vd, delta_d);
         vd = vfp_advance_dreg(vm, delta_m);
-        neon_load_reg64(f0, vm);
+        vfp_load_reg64(f0, vm);
     }
 
     tcg_temp_free_i64(f0);
@@ -2173,20 +2173,20 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i64();
 
-    neon_load_reg64(vn, a->vn);
-    neon_load_reg64(vm, a->vm);
+    vfp_load_reg64(vn, a->vn);
+    vfp_load_reg64(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negd(vn, vn);
     }
-    neon_load_reg64(vd, a->vd);
+    vfp_load_reg64(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negd(vd, vd);
     }
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
-    neon_store_reg64(vd, a->vd);
+    vfp_store_reg64(vd, a->vd);
 
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i64(vn);
@@ -2325,7 +2325,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     fd = tcg_const_i64(vfp_expand_imm(MO_64, a->imm));
 
     for (;;) {
-        neon_store_reg64(fd, vd);
+        vfp_store_reg64(fd, vd);
 
         if (veclen == 0) {
             break;
@@ -2480,11 +2480,11 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
     vd = tcg_temp_new_i64();
     vm = tcg_temp_new_i64();
 
-    neon_load_reg64(vd, a->vd);
+    vfp_load_reg64(vd, a->vd);
     if (a->z) {
         tcg_gen_movi_i64(vm, 0);
     } else {
-        neon_load_reg64(vm, a->vm);
+        vfp_load_reg64(vm, a->vm);
     }
 
     if (a->e) {
@@ -2557,7 +2557,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     tcg_gen_ld16u_i32(tmp, cpu_env, vfp_f16_offset(a->vm, a->t));
     vd = tcg_temp_new_i64();
     gen_helper_vfp_fcvt_f16_to_f64(vd, tmp, fpst, ahp_mode);
-    neon_store_reg64(vd, a->vd);
+    vfp_store_reg64(vd, a->vd);
     tcg_temp_free_i32(ahp_mode);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tmp);
@@ -2621,7 +2621,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     tmp = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
 
-    neon_load_reg64(vm, a->vm);
+    vfp_load_reg64(vm, a->vm);
     gen_helper_vfp_fcvt_f64_to_f16(tmp, vm, fpst, ahp_mode);
     tcg_temp_free_i64(vm);
     tcg_gen_st16_i32(tmp, cpu_env, vfp_f16_offset(a->vd, a->t));
@@ -2700,10 +2700,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     }
 
     tmp = tcg_temp_new_i64();
-    neon_load_reg64(tmp, a->vm);
+    vfp_load_reg64(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rintd(tmp, tmp, fpst);
-    neon_store_reg64(tmp, a->vd);
+    vfp_store_reg64(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i64(tmp);
     return true;
@@ -2789,13 +2789,13 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     }
 
     tmp = tcg_temp_new_i64();
-    neon_load_reg64(tmp, a->vm);
+    vfp_load_reg64(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     tcg_rmode = tcg_const_i32(float_round_to_zero);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     gen_helper_rintd(tmp, tmp, fpst);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    neon_store_reg64(tmp, a->vd);
+    vfp_store_reg64(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i64(tmp);
     tcg_temp_free_i32(tcg_rmode);
@@ -2871,10 +2871,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     }
 
     tmp = tcg_temp_new_i64();
-    neon_load_reg64(tmp, a->vm);
+    vfp_load_reg64(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rintd_exact(tmp, tmp, fpst);
-    neon_store_reg64(tmp, a->vd);
+    vfp_store_reg64(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i64(tmp);
     return true;
@@ -2902,7 +2902,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
     gen_helper_vfp_fcvtds(vd, vm, cpu_env);
-    neon_store_reg64(vd, a->vd);
+    vfp_store_reg64(vd, a->vd);
     tcg_temp_free_i32(vm);
     tcg_temp_free_i64(vd);
     return true;
@@ -2928,7 +2928,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
 
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
-    neon_load_reg64(vm, a->vm);
+    vfp_load_reg64(vm, a->vm);
     gen_helper_vfp_fcvtsd(vd, vm, cpu_env);
     vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i32(vd);
@@ -3024,7 +3024,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         /* u32 -> f64 */
         gen_helper_vfp_uitod(vd, vm, fpst);
     }
-    neon_store_reg64(vd, a->vd);
+    vfp_store_reg64(vd, a->vd);
     tcg_temp_free_i32(vm);
     tcg_temp_free_i64(vd);
     tcg_temp_free_ptr(fpst);
@@ -3055,7 +3055,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
 
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i32();
-    neon_load_reg64(vm, a->vm);
+    vfp_load_reg64(vm, a->vm);
     gen_helper_vjcvt(vd, vm, cpu_env);
     vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i64(vm);
@@ -3204,7 +3204,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     frac_bits = (a->opc & 1) ? (32 - a->imm) : (16 - a->imm);
 
     vd = tcg_temp_new_i64();
-    neon_load_reg64(vd, a->vd);
+    vfp_load_reg64(vd, a->vd);
 
     fpst = fpstatus_ptr(FPST_FPCR);
     shift = tcg_const_i32(frac_bits);
@@ -3239,7 +3239,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         g_assert_not_reached();
     }
 
-    neon_store_reg64(vd, a->vd);
+    vfp_store_reg64(vd, a->vd);
     tcg_temp_free_i64(vd);
     tcg_temp_free_i32(shift);
     tcg_temp_free_ptr(fpst);
@@ -3340,7 +3340,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     fpst = fpstatus_ptr(FPST_FPCR);
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i32();
-    neon_load_reg64(vm, a->vm);
+    vfp_load_reg64(vm, a->vm);
 
     if (a->s) {
         if (a->rz) {
-- 
2.25.1


