Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E54C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AC52087B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBWKTX9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AC52087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS54s-0003K6-AO
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:33:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS53d-0002M5-QV
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4rt-0007an-2k
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:19:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4rs-0007aE-TG
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:19:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id z28so5286875pfk.0
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dhbfT4796Yk0sqYwrY2hvMjQ++yBmcBKZBeep64Y5Sk=;
	b=oBWKTX9GiPRVsgk6/epvq0wkd44GGfnYfB9G/GHH7qTQyyZjCyzQ/flkPiXYAV1kRj
	WxuKKjmwOOafUFE4FArJQNtTx0uLzYcqXGlp2GkJNS4wr8+YsKVwL2gROwSrfGgDd99H
	rqH7wbJlrPZn6O/BnSuM/7e9Ig5IGHybJP+Z9IV/2dCXmYUzWBPlb4lZZSE4CMA/AVvk
	PoYlfNjKnFEYI+ekl9a9hS1c1i1Dp2YmAeP3zVmfyEdPW9zNKaQV3NwvxTZjJlGG5//2
	lajxgilrwQ7cIOJs/CyjOJAONpdlZDtdIR/r0gZCNlCLz7/zTdXEHzVM2Pk2duuMeoSz
	Azyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dhbfT4796Yk0sqYwrY2hvMjQ++yBmcBKZBeep64Y5Sk=;
	b=cBSgOBI1OLG/TWaUmblx2fCXSYH7/1lT8jFimWtWsP4AHE9QTSAm/BQVrvvbVhLqAe
	90C0tfo7P4npS3UxhK7csPQ3ZBEk4WH/UHD5ezXPCNE3vRBMyEkPwb1BOkSxrJDPsQnX
	u//o3du5hPh4XfVzTVtZhTRUBcD7njbPmDzC79aIcbRTdKme/Gxnt3Cu1HGZaZMcOFmY
	fbns0v0lSsTCpYnwYcy8oSIQfnHQBf6dtt2Jh8jvEXnb4LreVNNFlq83lyT/LWvyG5gx
	1mQX0+HtNwH4sSnzUGVPw7D2HfVK+27/JoHSsv9Maz/zLmJq9aHgYBkdkTOcCkqGwyla
	kErw==
X-Gm-Message-State: APjAAAWdteAk1mKyBxJN8CGSpD9glk5g4OsoZULZdKZY7YCWpA9cBnh5
	7Nw7IDiUiEMhSKPJyoCelGg7vWjidw0=
X-Google-Smtp-Source: APXvYqz1X+U1Si5E9K3jY2eeltMo1uu7gV+6v3JSAxgQdUczUCyJlGArqFf2sjZPqO9GqmnfTebehA==
X-Received: by 2002:a62:d205:: with SMTP id c5mr69339862pfg.219.1558207179571; 
	Sat, 18 May 2019 12:19:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	r185sm19639625pfc.167.2019.05.18.12.19.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:19:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:19:34 -0700
Message-Id: <20190518191934.21887-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518191934.21887-1-richard.henderson@linaro.org>
References: <20190518191934.21887-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces 3 target-specific implementations for BIT, BIF, and BSL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h |  2 +
 target/arm/translate.h     |  3 --
 target/arm/translate-a64.c | 15 ++++++--
 target/arm/translate.c     | 78 +++-----------------------------------
 4 files changed, 20 insertions(+), 78 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 63d958cf50..9569bc5963 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -122,5 +122,7 @@ typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
                          uint32_t, uint32_t);
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
+typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
 
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index f357b767cb..01ae454dcf 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -238,9 +238,6 @@ static inline void gen_ss_advance(DisasContext *s)
 }
 
 /* Vector operations shared between ARM and AArch64.  */
-extern const GVecGen3 bsl_op;
-extern const GVecGen3 bit_op;
-extern const GVecGen3 bif_op;
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2c280243a9..955ab63ff8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -704,6 +704,15 @@ static void gen_gvec_fn3(DisasContext *s, bool is_q, int rd, int rn, int rm,
             vec_full_reg_offset(s, rm), is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
+/* Expand a 4-operand AdvSIMD vector operation using an expander function.  */
+static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
+                         int rx, GVecGen4Fn *gvec_fn, int vece)
+{
+    gvec_fn(vece, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), vec_full_reg_offset(s, rx),
+            is_q ? 16 : 8, vec_full_reg_size(s));
+}
+
 /* Expand a 2-operand + immediate AdvSIMD vector operation using
  * an op descriptor.
  */
@@ -10916,13 +10925,13 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
         return;
 
     case 5: /* BSL bitwise select */
-        gen_gvec_op3(s, is_q, rd, rn, rm, &bsl_op);
+        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
         return;
     case 6: /* BIT, bitwise insert if true */
-        gen_gvec_op3(s, is_q, rd, rn, rm, &bit_op);
+        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
         return;
     case 7: /* BIF, bitwise insert if false */
-        gen_gvec_op3(s, is_q, rd, rn, rm, &bif_op);
+        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
         return;
 
     default:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 49dfcdc90d..3abcae3a50 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5755,72 +5755,6 @@ static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
     return 1;
 }
 
-/*
- * Expanders for VBitOps_VBIF, VBIT, VBSL.
- */
-static void gen_bsl_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rm);
-    tcg_gen_and_i64(rn, rn, rd);
-    tcg_gen_xor_i64(rd, rm, rn);
-}
-
-static void gen_bit_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rd);
-    tcg_gen_and_i64(rn, rn, rm);
-    tcg_gen_xor_i64(rd, rd, rn);
-}
-
-static void gen_bif_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rd);
-    tcg_gen_andc_i64(rn, rn, rm);
-    tcg_gen_xor_i64(rd, rd, rn);
-}
-
-static void gen_bsl_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rm);
-    tcg_gen_and_vec(vece, rn, rn, rd);
-    tcg_gen_xor_vec(vece, rd, rm, rn);
-}
-
-static void gen_bit_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rd);
-    tcg_gen_and_vec(vece, rn, rn, rm);
-    tcg_gen_xor_vec(vece, rd, rd, rn);
-}
-
-static void gen_bif_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rd);
-    tcg_gen_andc_vec(vece, rn, rn, rm);
-    tcg_gen_xor_vec(vece, rd, rd, rn);
-}
-
-const GVecGen3 bsl_op = {
-    .fni8 = gen_bsl_i64,
-    .fniv = gen_bsl_vec,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    .load_dest = true
-};
-
-const GVecGen3 bit_op = {
-    .fni8 = gen_bit_i64,
-    .fniv = gen_bit_vec,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    .load_dest = true
-};
-
-const GVecGen3 bif_op = {
-    .fni8 = gen_bif_i64,
-    .fniv = gen_bif_vec,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    .load_dest = true
-};
-
 static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
     tcg_gen_vec_sar8i_i64(a, a, shift);
@@ -6830,16 +6764,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                  vec_size, vec_size);
                 break;
             case 5: /* VBSL */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &bsl_op);
+                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rd_ofs, rn_ofs, rm_ofs,
+                                    vec_size, vec_size);
                 break;
             case 6: /* VBIT */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &bit_op);
+                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rn_ofs, rd_ofs,
+                                    vec_size, vec_size);
                 break;
             case 7: /* VBIF */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &bif_op);
+                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rd_ofs, rn_ofs,
+                                    vec_size, vec_size);
                 break;
             }
             return 0;
-- 
2.17.1


