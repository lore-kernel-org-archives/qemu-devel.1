Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABEBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D615220756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuaN1nxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKCc-0003ON-R4
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7e-0005D1-7v
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:38 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7b-0005vM-Hf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so3983648pfp.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bhlXbEbWYnNuol5HsH6fu3cqY3M1Y2WKuzmjH4v4ad4=;
 b=kuaN1nxTxx4+GDRhdqgo7BxE6807MamHOEA3UKsxs4J5ebLgEnYEW3ZocLPCd1ARgQ
 ZcJTUobJVUvRnsv1Mi3Jp5R/oyPsyoDzkp9+QFOQm8/K4ON3t+53Hjw0jTYb1gjU5Tu8
 k82cIwpZUT2m+DB+h0+9MqAidskA0dIiJBdFIVUa4Qw/lnNhQ/R6gVNXkgUnvCmdASk7
 /HAyq1Dx53qgQk8UM9qpE+4KYLTn4ni/FAKHAUZHxqVvbo28AMOzemqprX6w2sQlshSt
 icwflbq1Ug4XTG3QtvgvPkbJ16oNDDZFAojMRAoBr2zlnkB/JNLRbZbC/OC6slSRMPke
 fPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bhlXbEbWYnNuol5HsH6fu3cqY3M1Y2WKuzmjH4v4ad4=;
 b=Z+sqjGvN92lGQsj43/fcG/VzGcDlfXQL9iJHDArELC9+QNWemnNui7n0xXsYmBkAfu
 NZtkKiTtuIb5m5LhRooag6kdx5fpjrdgukPBpFVjmbA46US+Q+AAzWEV3EVOdICVVlhg
 8m9MORVrtqJvU8NutAlscVznxC/L01Mq5aTa5mIWdmbzj/rsPnuRTNEEFV/WsbTXJvss
 WPEfv57EHrERtg37FloQPkOwBE6icPd71y8ePdXlr0JP9G5EkEMr3Kl9KlEmLlBNrBPZ
 otAP65GveL7hzEsLnfJoAURuRAvQaN0/30uHktrmqae/HZpOzdVQA11VJ0KUgdl7L3Te
 7q/g==
X-Gm-Message-State: AOAM532tWxBgoqcygxevSqWjQRfO9oG/J6d3VvtVWggXeszM0PyDiu4V
 U071qmi4D/8QGbJ7AUiPj24I96toN2yTKQ==
X-Google-Smtp-Source: ABdhPJzk+IED5cTEpCKiyVtEnda6Z+tkqYUPpj12iHUkag8MO8KrlEtvPD6VWI80LUiimXImV5ziyw==
X-Received: by 2002:a17:90a:fe82:: with SMTP id
 co2mr133926pjb.22.1604024789658; 
 Thu, 29 Oct 2020 19:26:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/11] target/arm: Rename neon_load_reg32 to vfp_load_reg32
Date: Thu, 29 Oct 2020 19:26:14 -0700
Message-Id: <20201030022618.785675-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
References: <20201030022618.785675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
single-precision values, and nothing to do with NEON.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c         |   4 +-
 target/arm/translate-vfp.c.inc | 184 ++++++++++++++++-----------------
 2 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 55d5f4ed73..8491ab705b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1142,12 +1142,12 @@ static inline void neon_store_reg64(TCGv_i64 var, int reg)
     tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(1, reg));
 }
 
-static inline void neon_load_reg32(TCGv_i32 var, int reg)
+static inline void vfp_load_reg32(TCGv_i32 var, int reg)
 {
     tcg_gen_ld_i32(var, cpu_env, vfp_reg_offset(false, reg));
 }
 
-static inline void neon_store_reg32(TCGv_i32 var, int reg)
+static inline void vfp_store_reg32(TCGv_i32 var, int reg)
 {
     tcg_gen_st_i32(var, cpu_env, vfp_reg_offset(false, reg));
 }
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28f22f9872..d2a9b658bb 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -283,8 +283,8 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         frn = tcg_temp_new_i32();
         frm = tcg_temp_new_i32();
         dest = tcg_temp_new_i32();
-        neon_load_reg32(frn, rn);
-        neon_load_reg32(frm, rm);
+        vfp_load_reg32(frn, rn);
+        vfp_load_reg32(frm, rm);
         switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
@@ -315,7 +315,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         if (sz == 1) {
             tcg_gen_andi_i32(dest, dest, 0xffff);
         }
-        neon_store_reg32(dest, rd);
+        vfp_store_reg32(dest, rd);
         tcg_temp_free_i32(frn);
         tcg_temp_free_i32(frm);
         tcg_temp_free_i32(dest);
@@ -395,13 +395,13 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         TCGv_i32 tcg_res;
         tcg_op = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
-        neon_load_reg32(tcg_op, rm);
+        vfp_load_reg32(tcg_op, rm);
         if (sz == 1) {
             gen_helper_rinth(tcg_res, tcg_op, fpst);
         } else {
             gen_helper_rints(tcg_res, tcg_op, fpst);
         }
-        neon_store_reg32(tcg_res, rd);
+        vfp_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_op);
         tcg_temp_free_i32(tcg_res);
     }
@@ -470,7 +470,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
             gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
         }
         tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
-        neon_store_reg32(tcg_tmp, rd);
+        vfp_store_reg32(tcg_tmp, rd);
         tcg_temp_free_i32(tcg_tmp);
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_double);
@@ -478,7 +478,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         TCGv_i32 tcg_single, tcg_res;
         tcg_single = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
-        neon_load_reg32(tcg_single, rm);
+        vfp_load_reg32(tcg_single, rm);
         if (sz == 1) {
             if (is_signed) {
                 gen_helper_vfp_toslh(tcg_res, tcg_single, tcg_shift, fpst);
@@ -492,7 +492,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
                 gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
             }
         }
-        neon_store_reg32(tcg_res, rd);
+        vfp_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_res);
         tcg_temp_free_i32(tcg_single);
     }
@@ -776,14 +776,14 @@ static bool trans_VMOV_half(DisasContext *s, arg_VMOV_single *a)
     if (a->l) {
         /* VFP to general purpose register */
         tmp = tcg_temp_new_i32();
-        neon_load_reg32(tmp, a->vn);
+        vfp_load_reg32(tmp, a->vn);
         tcg_gen_andi_i32(tmp, tmp, 0xffff);
         store_reg(s, a->rt, tmp);
     } else {
         /* general purpose register to VFP */
         tmp = load_reg(s, a->rt);
         tcg_gen_andi_i32(tmp, tmp, 0xffff);
-        neon_store_reg32(tmp, a->vn);
+        vfp_store_reg32(tmp, a->vn);
         tcg_temp_free_i32(tmp);
     }
 
@@ -805,7 +805,7 @@ static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
     if (a->l) {
         /* VFP to general purpose register */
         tmp = tcg_temp_new_i32();
-        neon_load_reg32(tmp, a->vn);
+        vfp_load_reg32(tmp, a->vn);
         if (a->rt == 15) {
             /* Set the 4 flag bits in the CPSR.  */
             gen_set_nzcv(tmp);
@@ -816,7 +816,7 @@ static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
     } else {
         /* general purpose register to VFP */
         tmp = load_reg(s, a->rt);
-        neon_store_reg32(tmp, a->vn);
+        vfp_store_reg32(tmp, a->vn);
         tcg_temp_free_i32(tmp);
     }
 
@@ -842,18 +842,18 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
     if (a->op) {
         /* fpreg to gpreg */
         tmp = tcg_temp_new_i32();
-        neon_load_reg32(tmp, a->vm);
+        vfp_load_reg32(tmp, a->vm);
         store_reg(s, a->rt, tmp);
         tmp = tcg_temp_new_i32();
-        neon_load_reg32(tmp, a->vm + 1);
+        vfp_load_reg32(tmp, a->vm + 1);
         store_reg(s, a->rt2, tmp);
     } else {
         /* gpreg to fpreg */
         tmp = load_reg(s, a->rt);
-        neon_store_reg32(tmp, a->vm);
+        vfp_store_reg32(tmp, a->vm);
         tcg_temp_free_i32(tmp);
         tmp = load_reg(s, a->rt2);
-        neon_store_reg32(tmp, a->vm + 1);
+        vfp_store_reg32(tmp, a->vm + 1);
         tcg_temp_free_i32(tmp);
     }
 
@@ -885,18 +885,18 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
     if (a->op) {
         /* fpreg to gpreg */
         tmp = tcg_temp_new_i32();
-        neon_load_reg32(tmp, a->vm * 2);
+        vfp_load_reg32(tmp, a->vm * 2);
         store_reg(s, a->rt, tmp);
         tmp = tcg_temp_new_i32();
-        neon_load_reg32(tmp, a->vm * 2 + 1);
+        vfp_load_reg32(tmp, a->vm * 2 + 1);
         store_reg(s, a->rt2, tmp);
     } else {
         /* gpreg to fpreg */
         tmp = load_reg(s, a->rt);
-        neon_store_reg32(tmp, a->vm * 2);
+        vfp_store_reg32(tmp, a->vm * 2);
         tcg_temp_free_i32(tmp);
         tmp = load_reg(s, a->rt2);
-        neon_store_reg32(tmp, a->vm * 2 + 1);
+        vfp_store_reg32(tmp, a->vm * 2 + 1);
         tcg_temp_free_i32(tmp);
     }
 
@@ -927,9 +927,9 @@ static bool trans_VLDR_VSTR_hp(DisasContext *s, arg_VLDR_VSTR_sp *a)
     tmp = tcg_temp_new_i32();
     if (a->l) {
         gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-        neon_store_reg32(tmp, a->vd);
+        vfp_store_reg32(tmp, a->vd);
     } else {
-        neon_load_reg32(tmp, a->vd);
+        vfp_load_reg32(tmp, a->vd);
         gen_aa32_st16(s, tmp, addr, get_mem_index(s));
     }
     tcg_temp_free_i32(tmp);
@@ -961,9 +961,9 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
     tmp = tcg_temp_new_i32();
     if (a->l) {
         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-        neon_store_reg32(tmp, a->vd);
+        vfp_store_reg32(tmp, a->vd);
     } else {
-        neon_load_reg32(tmp, a->vd);
+        vfp_load_reg32(tmp, a->vd);
         gen_aa32_st32(s, tmp, addr, get_mem_index(s));
     }
     tcg_temp_free_i32(tmp);
@@ -1066,10 +1066,10 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
         if (a->l) {
             /* load */
             gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-            neon_store_reg32(tmp, a->vd + i);
+            vfp_store_reg32(tmp, a->vd + i);
         } else {
             /* store */
-            neon_load_reg32(tmp, a->vd + i);
+            vfp_load_reg32(tmp, a->vd + i);
             gen_aa32_st32(s, tmp, addr, get_mem_index(s));
         }
         tcg_gen_addi_i32(addr, addr, offset);
@@ -1285,15 +1285,15 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     fd = tcg_temp_new_i32();
     fpst = fpstatus_ptr(FPST_FPCR);
 
-    neon_load_reg32(f0, vn);
-    neon_load_reg32(f1, vm);
+    vfp_load_reg32(f0, vn);
+    vfp_load_reg32(f1, vm);
 
     for (;;) {
         if (reads_vd) {
-            neon_load_reg32(fd, vd);
+            vfp_load_reg32(fd, vd);
         }
         fn(fd, f0, f1, fpst);
-        neon_store_reg32(fd, vd);
+        vfp_store_reg32(fd, vd);
 
         if (veclen == 0) {
             break;
@@ -1303,10 +1303,10 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
         veclen--;
         vd = vfp_advance_sreg(vd, delta_d);
         vn = vfp_advance_sreg(vn, delta_d);
-        neon_load_reg32(f0, vn);
+        vfp_load_reg32(f0, vn);
         if (delta_m) {
             vm = vfp_advance_sreg(vm, delta_m);
-            neon_load_reg32(f1, vm);
+            vfp_load_reg32(f1, vm);
         }
     }
 
@@ -1349,14 +1349,14 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     fd = tcg_temp_new_i32();
     fpst = fpstatus_ptr(FPST_FPCR_F16);
 
-    neon_load_reg32(f0, vn);
-    neon_load_reg32(f1, vm);
+    vfp_load_reg32(f0, vn);
+    vfp_load_reg32(f1, vm);
 
     if (reads_vd) {
-        neon_load_reg32(fd, vd);
+        vfp_load_reg32(fd, vd);
     }
     fn(fd, f0, f1, fpst);
-    neon_store_reg32(fd, vd);
+    vfp_store_reg32(fd, vd);
 
     tcg_temp_free_i32(f0);
     tcg_temp_free_i32(f1);
@@ -1489,11 +1489,11 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     f0 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
 
-    neon_load_reg32(f0, vm);
+    vfp_load_reg32(f0, vm);
 
     for (;;) {
         fn(fd, f0);
-        neon_store_reg32(fd, vd);
+        vfp_store_reg32(fd, vd);
 
         if (veclen == 0) {
             break;
@@ -1503,7 +1503,7 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
             /* single source one-many */
             while (veclen--) {
                 vd = vfp_advance_sreg(vd, delta_d);
-                neon_store_reg32(fd, vd);
+                vfp_store_reg32(fd, vd);
             }
             break;
         }
@@ -1512,7 +1512,7 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
         veclen--;
         vd = vfp_advance_sreg(vd, delta_d);
         vm = vfp_advance_sreg(vm, delta_m);
-        neon_load_reg32(f0, vm);
+        vfp_load_reg32(f0, vm);
     }
 
     tcg_temp_free_i32(f0);
@@ -1545,9 +1545,9 @@ static bool do_vfp_2op_hp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     }
 
     f0 = tcg_temp_new_i32();
-    neon_load_reg32(f0, vm);
+    vfp_load_reg32(f0, vm);
     fn(f0, f0);
-    neon_store_reg32(f0, vd);
+    vfp_store_reg32(f0, vd);
     tcg_temp_free_i32(f0);
 
     return true;
@@ -2037,20 +2037,20 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i32();
 
-    neon_load_reg32(vn, a->vn);
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vn, a->vn);
+    vfp_load_reg32(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negh(vn, vn);
     }
-    neon_load_reg32(vd, a->vd);
+    vfp_load_reg32(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negh(vd, vd);
     }
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_vfp_muladdh(vd, vn, vm, vd, fpst);
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
 
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(vn);
@@ -2102,20 +2102,20 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i32();
 
-    neon_load_reg32(vn, a->vn);
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vn, a->vn);
+    vfp_load_reg32(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negs(vn, vn);
     }
-    neon_load_reg32(vd, a->vd);
+    vfp_load_reg32(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negs(vd, vd);
     }
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
 
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(vn);
@@ -2230,7 +2230,7 @@ static bool trans_VMOV_imm_hp(DisasContext *s, arg_VMOV_imm_sp *a)
     }
 
     fd = tcg_const_i32(vfp_expand_imm(MO_16, a->imm));
-    neon_store_reg32(fd, a->vd);
+    vfp_store_reg32(fd, a->vd);
     tcg_temp_free_i32(fd);
     return true;
 }
@@ -2270,7 +2270,7 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
     fd = tcg_const_i32(vfp_expand_imm(MO_32, a->imm));
 
     for (;;) {
-        neon_store_reg32(fd, vd);
+        vfp_store_reg32(fd, vd);
 
         if (veclen == 0) {
             break;
@@ -2397,11 +2397,11 @@ static bool trans_VCMP_hp(DisasContext *s, arg_VCMP_sp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i32();
 
-    neon_load_reg32(vd, a->vd);
+    vfp_load_reg32(vd, a->vd);
     if (a->z) {
         tcg_gen_movi_i32(vm, 0);
     } else {
-        neon_load_reg32(vm, a->vm);
+        vfp_load_reg32(vm, a->vm);
     }
 
     if (a->e) {
@@ -2436,11 +2436,11 @@ static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i32();
 
-    neon_load_reg32(vd, a->vd);
+    vfp_load_reg32(vd, a->vd);
     if (a->z) {
         tcg_gen_movi_i32(vm, 0);
     } else {
-        neon_load_reg32(vm, a->vm);
+        vfp_load_reg32(vm, a->vm);
     }
 
     if (a->e) {
@@ -2519,7 +2519,7 @@ static bool trans_VCVT_f32_f16(DisasContext *s, arg_VCVT_f32_f16 *a)
     /* The T bit tells us if we want the low or high 16 bits of Vm */
     tcg_gen_ld16u_i32(tmp, cpu_env, vfp_f16_offset(a->vm, a->t));
     gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp_mode);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_i32(ahp_mode);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tmp);
@@ -2583,7 +2583,7 @@ static bool trans_VCVT_f16_f32(DisasContext *s, arg_VCVT_f16_f32 *a)
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
 
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp_mode);
     tcg_gen_st16_i32(tmp, cpu_env, vfp_f16_offset(a->vd, a->t));
     tcg_temp_free_i32(ahp_mode);
@@ -2645,10 +2645,10 @@ static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_rinth(tmp, tmp, fpst);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tmp);
     return true;
@@ -2668,10 +2668,10 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rints(tmp, tmp, fpst);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tmp);
     return true;
@@ -2724,13 +2724,13 @@ static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     tcg_rmode = tcg_const_i32(float_round_to_zero);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     gen_helper_rinth(tmp, tmp, fpst);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tcg_rmode);
     tcg_temp_free_i32(tmp);
@@ -2752,13 +2752,13 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     tcg_rmode = tcg_const_i32(float_round_to_zero);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     gen_helper_rints(tmp, tmp, fpst);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tcg_rmode);
     tcg_temp_free_i32(tmp);
@@ -2816,10 +2816,10 @@ static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_rinth_exact(tmp, tmp, fpst);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tmp);
     return true;
@@ -2839,10 +2839,10 @@ static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    neon_load_reg32(tmp, a->vm);
+    vfp_load_reg32(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rints_exact(tmp, tmp, fpst);
-    neon_store_reg32(tmp, a->vd);
+    vfp_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
     tcg_temp_free_i32(tmp);
     return true;
@@ -2900,7 +2900,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
 
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vm, a->vm);
     gen_helper_vfp_fcvtds(vd, vm, cpu_env);
     neon_store_reg64(vd, a->vd);
     tcg_temp_free_i32(vm);
@@ -2930,7 +2930,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     vm = tcg_temp_new_i64();
     neon_load_reg64(vm, a->vm);
     gen_helper_vfp_fcvtsd(vd, vm, cpu_env);
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i32(vd);
     tcg_temp_free_i64(vm);
     return true;
@@ -2950,7 +2950,7 @@ static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
     }
 
     vm = tcg_temp_new_i32();
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vm, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     if (a->s) {
         /* i32 -> f16 */
@@ -2959,7 +2959,7 @@ static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
         /* u32 -> f16 */
         gen_helper_vfp_uitoh(vm, vm, fpst);
     }
-    neon_store_reg32(vm, a->vd);
+    vfp_store_reg32(vm, a->vd);
     tcg_temp_free_i32(vm);
     tcg_temp_free_ptr(fpst);
     return true;
@@ -2979,7 +2979,7 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
     }
 
     vm = tcg_temp_new_i32();
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vm, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     if (a->s) {
         /* i32 -> f32 */
@@ -2988,7 +2988,7 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
         /* u32 -> f32 */
         gen_helper_vfp_uitos(vm, vm, fpst);
     }
-    neon_store_reg32(vm, a->vd);
+    vfp_store_reg32(vm, a->vd);
     tcg_temp_free_i32(vm);
     tcg_temp_free_ptr(fpst);
     return true;
@@ -3015,7 +3015,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
 
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vm, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR);
     if (a->s) {
         /* i32 -> f64 */
@@ -3057,7 +3057,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     vd = tcg_temp_new_i32();
     neon_load_reg64(vm, a->vm);
     gen_helper_vjcvt(vd, vm, cpu_env);
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i64(vm);
     tcg_temp_free_i32(vd);
     return true;
@@ -3080,7 +3080,7 @@ static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
     frac_bits = (a->opc & 1) ? (32 - a->imm) : (16 - a->imm);
 
     vd = tcg_temp_new_i32();
-    neon_load_reg32(vd, a->vd);
+    vfp_load_reg32(vd, a->vd);
 
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     shift = tcg_const_i32(frac_bits);
@@ -3115,7 +3115,7 @@ static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
         g_assert_not_reached();
     }
 
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i32(vd);
     tcg_temp_free_i32(shift);
     tcg_temp_free_ptr(fpst);
@@ -3139,7 +3139,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     frac_bits = (a->opc & 1) ? (32 - a->imm) : (16 - a->imm);
 
     vd = tcg_temp_new_i32();
-    neon_load_reg32(vd, a->vd);
+    vfp_load_reg32(vd, a->vd);
 
     fpst = fpstatus_ptr(FPST_FPCR);
     shift = tcg_const_i32(frac_bits);
@@ -3174,7 +3174,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
         g_assert_not_reached();
     }
 
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i32(vd);
     tcg_temp_free_i32(shift);
     tcg_temp_free_ptr(fpst);
@@ -3261,7 +3261,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
 
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     vm = tcg_temp_new_i32();
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vm, a->vm);
 
     if (a->s) {
         if (a->rz) {
@@ -3276,7 +3276,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
             gen_helper_vfp_touih(vm, vm, fpst);
         }
     }
-    neon_store_reg32(vm, a->vd);
+    vfp_store_reg32(vm, a->vd);
     tcg_temp_free_i32(vm);
     tcg_temp_free_ptr(fpst);
     return true;
@@ -3297,7 +3297,7 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
 
     fpst = fpstatus_ptr(FPST_FPCR);
     vm = tcg_temp_new_i32();
-    neon_load_reg32(vm, a->vm);
+    vfp_load_reg32(vm, a->vm);
 
     if (a->s) {
         if (a->rz) {
@@ -3312,7 +3312,7 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
             gen_helper_vfp_touis(vm, vm, fpst);
         }
     }
-    neon_store_reg32(vm, a->vd);
+    vfp_store_reg32(vm, a->vd);
     tcg_temp_free_i32(vm);
     tcg_temp_free_ptr(fpst);
     return true;
@@ -3355,7 +3355,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
             gen_helper_vfp_touid(vd, vm, fpst);
         }
     }
-    neon_store_reg32(vd, a->vd);
+    vfp_store_reg32(vd, a->vd);
     tcg_temp_free_i32(vd);
     tcg_temp_free_i64(vm);
     tcg_temp_free_ptr(fpst);
@@ -3468,10 +3468,10 @@ static bool trans_VINS(DisasContext *s, arg_VINS *a)
     /* Insert low half of Vm into high half of Vd */
     rm = tcg_temp_new_i32();
     rd = tcg_temp_new_i32();
-    neon_load_reg32(rm, a->vm);
-    neon_load_reg32(rd, a->vd);
+    vfp_load_reg32(rm, a->vm);
+    vfp_load_reg32(rd, a->vd);
     tcg_gen_deposit_i32(rd, rd, rm, 16, 16);
-    neon_store_reg32(rd, a->vd);
+    vfp_store_reg32(rd, a->vd);
     tcg_temp_free_i32(rm);
     tcg_temp_free_i32(rd);
     return true;
@@ -3495,9 +3495,9 @@ static bool trans_VMOVX(DisasContext *s, arg_VINS *a)
 
     /* Set Vd to high half of Vm */
     rm = tcg_temp_new_i32();
-    neon_load_reg32(rm, a->vm);
+    vfp_load_reg32(rm, a->vm);
     tcg_gen_shri_i32(rm, rm, 16);
-    neon_store_reg32(rm, a->vd);
+    vfp_store_reg32(rm, a->vd);
     tcg_temp_free_i32(rm);
     return true;
 }
-- 
2.25.1


