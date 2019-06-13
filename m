Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF6C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6332147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dF70GZqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6332147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbP9h-0003l8-DJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdN-000828-7Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdJ-0004Mb-CS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdF-00046j-Cr
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so20520052wrm.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=p3d6LVQh8jIBuSkoLGFeMkgwvGAqT2KuhV1VbxTzLfc=;
 b=dF70GZquXtytIOxrzkicyKANNZmo78PdUVvZVmlKr6un7lS3LT+nUVbquoS5Rp0ybX
 Rz4yEPw3ZiCIOWuhjyRwZDH7N0b/hOZg0ECUfTLIHa0oclP4KVJrRf4jAiYR++LnEPix
 DvXYwSd5LZQXvgKBMwiQ722wH8IOcfIEiB26mKGPEX8adrLZrA6hN18w7sXspzL6oBbI
 /+CNYWheCPhhm54JsrGkDHl+YI39NZeUiSVbk/7jAQe0TMBo/p6QH/MfeWXp2bAyuQAB
 N+KmkWmB0zKpFDPAhWQzM0xBrytya8ynRkJ/LhMPiYk4n8j36861O5yP5GujEZShi7RR
 tSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p3d6LVQh8jIBuSkoLGFeMkgwvGAqT2KuhV1VbxTzLfc=;
 b=PjqU0ByBN0mo4cazlumFgoYcvs8O1jRXvulSk6GK5GIWO9zC0YBkXLdtkjPFYS1p16
 7A6Fw7XS2hRVFg1296/VngOmUemJRrKO46c9gNp8oPpZ3TDIeo/W7H9fRbfOQWFYkfEr
 HLxdzuxyz8Lqm6ynqRpMJfW0OA/iHjmCg1YSSwPv5LemZ+CC1+gADCL1QN2OOsKOHkix
 vvKBefDx3NBJfxgAxHgorp6ZK+6O0NgJQ9bI2LuHxZaaFjKKLGEKIIIoNElK0GrqqGay
 mfM36ynQhWH7Ob3zov1jECB/8yhrG7RZnJTHl4WgN5cCnw1wxTq+vovzoTcaEFsqKy/T
 KAuw==
X-Gm-Message-State: APjAAAV9xIaVEHEGlnfCsQoiJfeU0nvzeF7DSTFPcubkocYBimBU1hAZ
 i8AzRvOFz/8VWP197q6QljMwisi6oMcvrg==
X-Google-Smtp-Source: APXvYqy5SKUzc9YwzhTPc4LAAXR3Ju08GXpL0USPpFRdNU/AfMwMEHR39t+36xu/mjcliyQFlYH03Q==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr6397452wru.242.1560428094042; 
 Thu, 13 Jun 2019 05:14:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:02 +0100
Message-Id: <20190613121433.5246-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 17/48] target/arm: Add helpers for VFP register
 loads and stores
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

The current VFP code has two different idioms for
loading and storing from the VFP register file:
 1 using the gen_mov_F0_vreg() and similar functions,
   which load and store to a fixed set of TCG globals
   cpu_F0s, CPU_F0d, etc
 2 by direct calls to tcg_gen_ld_f64() and friends

We want to phase out idiom 1 (because the use of the
fixed globals is a relic of a much older version of TCG),
but idiom 2 is quite longwinded:
 tcg_gen_ld_f64(tmp, cpu_env, vfp_reg_offset(true, reg))
requires us to specify the 64-bitness twice, once in
the function name and once by passing 'true' to
vfp_reg_offset(). There's no guard against accidentally
passing the wrong flag.

Instead, let's move to a convention of accessing 64-bit
registers via the existing neon_load_reg64() and
neon_store_reg64(), and provide new neon_load_reg32()
and neon_store_reg32() for the 32-bit equivalents.

Implement the new functions and use them in the code in
translate-vfp.inc.c. We will convert the rest of the VFP
code as we do the decodetree conversion in subsequent
commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
 target/arm/translate.c         | 10 +++++++++
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 2f070a6e0d9..24358f3d3eb 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -179,8 +179,8 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         tcg_gen_ext_i32_i64(nf, cpu_NF);
         tcg_gen_ext_i32_i64(vf, cpu_VF);
 
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg64(frn, rn);
+        neon_load_reg64(frm, rm);
         switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
@@ -207,7 +207,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
             tcg_temp_free_i64(tmp);
             break;
         }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg64(dest, rd);
         tcg_temp_free_i64(frn);
         tcg_temp_free_i64(frm);
         tcg_temp_free_i64(dest);
@@ -226,8 +226,8 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         frn = tcg_temp_new_i32();
         frm = tcg_temp_new_i32();
         dest = tcg_temp_new_i32();
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg32(frn, rn);
+        neon_load_reg32(frm, rm);
         switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
@@ -254,7 +254,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
             tcg_temp_free_i32(tmp);
             break;
         }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg32(dest, rd);
         tcg_temp_free_i32(frn);
         tcg_temp_free_i32(frm);
         tcg_temp_free_i32(dest);
@@ -298,14 +298,14 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         frm = tcg_temp_new_i64();
         dest = tcg_temp_new_i64();
 
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg64(frn, rn);
+        neon_load_reg64(frm, rm);
         if (vmin) {
             gen_helper_vfp_minnumd(dest, frn, frm, fpst);
         } else {
             gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
         }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg64(dest, rd);
         tcg_temp_free_i64(frn);
         tcg_temp_free_i64(frm);
         tcg_temp_free_i64(dest);
@@ -316,14 +316,14 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         frm = tcg_temp_new_i32();
         dest = tcg_temp_new_i32();
 
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg32(frn, rn);
+        neon_load_reg32(frm, rm);
         if (vmin) {
             gen_helper_vfp_minnums(dest, frn, frm, fpst);
         } else {
             gen_helper_vfp_maxnums(dest, frn, frm, fpst);
         }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg32(dest, rd);
         tcg_temp_free_i32(frn);
         tcg_temp_free_i32(frm);
         tcg_temp_free_i32(dest);
@@ -379,9 +379,9 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         TCGv_i64 tcg_res;
         tcg_op = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
-        tcg_gen_ld_f64(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg64(tcg_op, rm);
         gen_helper_rintd(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f64(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg64(tcg_res, rd);
         tcg_temp_free_i64(tcg_op);
         tcg_temp_free_i64(tcg_res);
     } else {
@@ -389,9 +389,9 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         TCGv_i32 tcg_res;
         tcg_op = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg32(tcg_op, rm);
         gen_helper_rints(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_op);
         tcg_temp_free_i32(tcg_res);
     }
@@ -440,14 +440,14 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         tcg_double = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
         tcg_tmp = tcg_temp_new_i32();
-        tcg_gen_ld_f64(tcg_double, cpu_env, vfp_reg_offset(1, rm));
+        neon_load_reg64(tcg_double, rm);
         if (is_signed) {
             gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
         } else {
             gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
         }
         tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
-        tcg_gen_st_f32(tcg_tmp, cpu_env, vfp_reg_offset(0, rd));
+        neon_store_reg32(tcg_tmp, rd);
         tcg_temp_free_i32(tcg_tmp);
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_double);
@@ -455,13 +455,13 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         TCGv_i32 tcg_single, tcg_res;
         tcg_single = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_single, cpu_env, vfp_reg_offset(0, rm));
+        neon_load_reg32(tcg_single, rm);
         if (is_signed) {
             gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
         } else {
             gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
         }
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(0, rd));
+        neon_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_res);
         tcg_temp_free_i32(tcg_single);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 62a6c860d8a..bebd03f9da8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1689,6 +1689,16 @@ static inline void neon_store_reg64(TCGv_i64 var, int reg)
     tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(1, reg));
 }
 
+static inline void neon_load_reg32(TCGv_i32 var, int reg)
+{
+    tcg_gen_ld_i32(var, cpu_env, vfp_reg_offset(false, reg));
+}
+
+static inline void neon_store_reg32(TCGv_i32 var, int reg)
+{
+    tcg_gen_st_i32(var, cpu_env, vfp_reg_offset(false, reg));
+}
+
 static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 {
     TCGv_ptr ret = tcg_temp_new_ptr();
-- 
2.20.1


