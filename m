Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F282C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5962F206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPSdDb0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5962F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFZV-0004Mk-Ji
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXy-0001PK-5d
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXw-0001f8-IP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id d128so9769957wmc.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DMliTjCAEAQB4bgJijmfBHEf2XjCv8KzYqoMZS3kesk=;
 b=EPSdDb0JTg0ZJNqku0WL+qx6sneTPsehx7oB2lUIEDB2zh00vXX2xtX8mg02Fik03L
 CNaGy126Uhb0f1vfz8RCCrv4ZY6D48EFKmoP6KyZZctSrUuGQqUtZnMo6cfG7lrvEbQ+
 VjcnxGnztNeJ2Gb3DEVi0BN1kSFNYM75HoeW+NfaFsAwAsD3Ujd4Yo1af/sakLCgETd3
 Tj4zpplYncQVWoj0OR++8otgpMu4mFivjO+NPh8Ge5lZ5zXZzVFsQaTWEtDRv3hHci9+
 veT288DY0IFlzS0fdqAGER2dsQi3EzPgkRDBB9pr+zqmeOKb0FyLrI5UpDlFLJLt35Y4
 Qgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DMliTjCAEAQB4bgJijmfBHEf2XjCv8KzYqoMZS3kesk=;
 b=tjDDK1H70y/cB/uzxDaytnQisvBIpKi32oKvhX9lbDD/rSiefYFk243xOfqwWVlGsh
 F830Pc9txXp5MdfmkJgv3zONuNQv7q1zYZdyavxLxuhhyrf/8PmvT6DMvjroR1CSdBD9
 Q+FFFTWqW7zauC73GYdM5QBoQJ7eRa5Vwm6SMPcwsQkyNxhk6y0ujDryDINFidgJ0gQs
 VRu1IgwiK9N56ivpT3+PgEdbaE6+DD4wTH+hS4nHyEONlMm1Oi4UilCXiwsxEYALX/NB
 zT40DlV+EnUqjnyNPlkmHu8QBjagVPHC5vZ/Q8J55mt2DxfoEKQSum4uzx9Ov5SZgoOS
 bTwQ==
X-Gm-Message-State: AOAM531I4DbCFX88DuLlCGnnQl1/wRchcooGUWxGlroTa86Pf4SvouSo
 AxOqlAaJUxlShS6UJMKRUe6YDQMFydOUNw==
X-Google-Smtp-Source: ABdhPJwnEBFz5kTiRBsSdhdrOpbCVqM8yxfXlB0VUS4weD1ZZEqTjsaT7b4KwLPCeB91Qg8PTB7+iQ==
X-Received: by 2002:a1c:49d6:: with SMTP id w205mr3718159wma.151.1591375818518; 
 Fri, 05 Jun 2020 09:50:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/29] target/arm: Convert sha1 and sha256 to gvec helpers
Date: Fri,  5 Jun 2020 17:49:46 +0100
Message-Id: <20200605165007.12095-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not yet convert the helpers to loop over opr_sz, but the
descriptor allows the vector tail to be cleared.  Which fixes
an existing bug vs SVE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200514212831.31248-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  12 ++--
 target/arm/neon-dp.decode       |  12 ++--
 target/arm/crypto_helper.c      |  24 +++++--
 target/arm/translate-a64.c      |  34 ++++-----
 target/arm/translate-neon.inc.c | 124 +++++---------------------------
 target/arm/translate.c          |  24 ++-----
 6 files changed, 67 insertions(+), 163 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 784dc29ce24..cee23adbfcd 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -514,13 +514,13 @@ DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_2(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_3(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_2(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_4(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha512h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 8beb1db768b..5b2fc65d72c 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -165,14 +165,14 @@ VPADD_3s         1111 001 0 0 . .. .... .... 1011 . . . 1 .... @3same_q0
 
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
 
+@3same_crypto    .... .... .... .... .... .... .... .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0 q=1
+
 SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
                  vm=%vm_dp vn=%vn_dp vd=%vd_dp
-SHA256H_3s       1111 001 1 0 . 00 .... .... 1100 . 1 . 0 .... \
-                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
-SHA256H2_3s      1111 001 1 0 . 01 .... .... 1100 . 1 . 0 .... \
-                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
-SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... \
-                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256H_3s       1111 001 1 0 . 00 .... .... 1100 . 1 . 0 .... @3same_crypto
+SHA256H2_3s      1111 001 1 0 . 01 .... .... 1100 . 1 . 0 .... @3same_crypto
+SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... @3same_crypto
 
 VFMA_fp_3s       1111 001 0 0 . 0 . .... .... 1100 ... 1 .... @3same_fp
 VFMS_fp_3s       1111 001 0 0 . 1 . .... .... 1100 ... 1 .... @3same_fp
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 637e4c00bba..7124745c32a 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -303,7 +303,7 @@ void HELPER(crypto_sha1_3reg)(void *vd, void *vn, void *vm, uint32_t op)
     rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sha1h)(void *vd, void *vm)
+void HELPER(crypto_sha1h)(void *vd, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rm = vm;
@@ -314,9 +314,11 @@ void HELPER(crypto_sha1h)(void *vd, void *vm)
 
     rd[0] = m.l[0];
     rd[1] = m.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha1su1)(void *vd, void *vm)
+void HELPER(crypto_sha1su1)(void *vd, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rm = vm;
@@ -330,6 +332,8 @@ void HELPER(crypto_sha1su1)(void *vd, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
 /*
@@ -357,7 +361,7 @@ static uint32_t s1(uint32_t x)
     return ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10);
 }
 
-void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -388,9 +392,11 @@ void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -413,9 +419,11 @@ void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha256su0)(void *vd, void *vm)
+void HELPER(crypto_sha256su0)(void *vd, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rm = vm;
@@ -429,9 +437,11 @@ void HELPER(crypto_sha256su0)(void *vd, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -447,6 +457,8 @@ void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
 /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d24cfbe2f8..5a4f8196bdd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13465,8 +13465,7 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    CryptoThreeOpFn *genfn;
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
+    gen_helper_gvec_3 *genfn;
     bool feature;
 
     if (size != 0) {
@@ -13508,23 +13507,22 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-    tcg_rm_ptr = vec_full_reg_ptr(s, rm);
-
     if (genfn) {
-        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
+        gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
     } else {
         TCGv_i32 tcg_opcode = tcg_const_i32(opcode);
+        TCGv_ptr tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+        TCGv_ptr tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+        TCGv_ptr tcg_rm_ptr = vec_full_reg_ptr(s, rm);
 
         gen_helper_crypto_sha1_3reg(tcg_rd_ptr, tcg_rn_ptr,
                                     tcg_rm_ptr, tcg_opcode);
-        tcg_temp_free_i32(tcg_opcode);
-    }
 
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
-    tcg_temp_free_ptr(tcg_rm_ptr);
+        tcg_temp_free_i32(tcg_opcode);
+        tcg_temp_free_ptr(tcg_rd_ptr);
+        tcg_temp_free_ptr(tcg_rn_ptr);
+        tcg_temp_free_ptr(tcg_rm_ptr);
+    }
 }
 
 /* Crypto two-reg SHA
@@ -13539,9 +13537,8 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    CryptoTwoOpFn *genfn;
+    gen_helper_gvec_2 *genfn;
     bool feature;
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
 
     if (size != 0) {
         unallocated_encoding(s);
@@ -13574,14 +13571,7 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     if (!fp_access_check(s)) {
         return;
     }
-
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-
-    genfn(tcg_rd_ptr, tcg_rn_ptr);
-
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
+    gen_gvec_op2_ool(s, true, rd, rn, 0, genfn);
 }
 
 static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 3fe65a0b080..205877ca48e 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -661,12 +661,14 @@ DO_3SAME_CMP(VCGE_S, TCG_COND_GE)
 DO_3SAME_CMP(VCGE_U, TCG_COND_GEU)
 DO_3SAME_CMP(VCEQ, TCG_COND_EQ)
 
-static void gen_VMUL_p_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                           uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz,
-                       0, gen_helper_gvec_pmul_b);
-}
+#define WRAP_OOL_FN(WRAPNAME, FUNC)                                        \
+    static void WRAPNAME(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,  \
+                         uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)  \
+    {                                                                      \
+        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, 0, FUNC); \
+    }
+
+WRAP_OOL_FN(gen_VMUL_p_3s, gen_helper_gvec_pmul_b)
 
 static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
 {
@@ -728,107 +730,19 @@ static bool trans_SHA1_3s(DisasContext *s, arg_SHA1_3s *a)
     return true;
 }
 
-static bool trans_SHA256H_3s(DisasContext *s, arg_SHA256H_3s *a)
-{
-    TCGv_ptr ptr1, ptr2, ptr3;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
-        !dc_isar_feature(aa32_sha2, s)) {
-        return false;
+#define DO_SHA2(NAME, FUNC)                                             \
+    WRAP_OOL_FN(gen_##NAME##_3s, FUNC)                                  \
+    static bool trans_##NAME##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (!dc_isar_feature(aa32_sha2, s)) {                           \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, gen_##NAME##_3s);                         \
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vn | a->vm | a->vd) & 1) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    ptr1 = vfp_reg_ptr(true, a->vd);
-    ptr2 = vfp_reg_ptr(true, a->vn);
-    ptr3 = vfp_reg_ptr(true, a->vm);
-    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
-    tcg_temp_free_ptr(ptr1);
-    tcg_temp_free_ptr(ptr2);
-    tcg_temp_free_ptr(ptr3);
-
-    return true;
-}
-
-static bool trans_SHA256H2_3s(DisasContext *s, arg_SHA256H2_3s *a)
-{
-    TCGv_ptr ptr1, ptr2, ptr3;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
-        !dc_isar_feature(aa32_sha2, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vn | a->vm | a->vd) & 1) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    ptr1 = vfp_reg_ptr(true, a->vd);
-    ptr2 = vfp_reg_ptr(true, a->vn);
-    ptr3 = vfp_reg_ptr(true, a->vm);
-    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
-    tcg_temp_free_ptr(ptr1);
-    tcg_temp_free_ptr(ptr2);
-    tcg_temp_free_ptr(ptr3);
-
-    return true;
-}
-
-static bool trans_SHA256SU1_3s(DisasContext *s, arg_SHA256SU1_3s *a)
-{
-    TCGv_ptr ptr1, ptr2, ptr3;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
-        !dc_isar_feature(aa32_sha2, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vn | a->vm | a->vd) & 1) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    ptr1 = vfp_reg_ptr(true, a->vd);
-    ptr2 = vfp_reg_ptr(true, a->vn);
-    ptr3 = vfp_reg_ptr(true, a->vm);
-    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
-    tcg_temp_free_ptr(ptr1);
-    tcg_temp_free_ptr(ptr2);
-    tcg_temp_free_ptr(ptr3);
-
-    return true;
-}
+DO_SHA2(SHA256H, gen_helper_crypto_sha256h)
+DO_SHA2(SHA256H2, gen_helper_crypto_sha256h2)
+DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
 
 #define DO_3SAME_64(INSN, FUNC)                                         \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 74c1b5be424..c61180ea618 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5257,7 +5257,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int vec_size;
     uint32_t imm;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
-    TCGv_ptr ptr1, ptr2;
+    TCGv_ptr ptr1;
     TCGv_i64 tmp64;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -6372,13 +6372,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     if (!dc_isar_feature(aa32_sha1, s) || ((rm | rd) & 1)) {
                         return 1;
                     }
-                    ptr1 = vfp_reg_ptr(true, rd);
-                    ptr2 = vfp_reg_ptr(true, rm);
-
-                    gen_helper_crypto_sha1h(ptr1, ptr2);
-
-                    tcg_temp_free_ptr(ptr1);
-                    tcg_temp_free_ptr(ptr2);
+                    tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, 16, 16, 0,
+                                       gen_helper_crypto_sha1h);
                     break;
                 case NEON_2RM_SHA1SU1:
                     if ((rm | rd) & 1) {
@@ -6392,17 +6387,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     } else if (!dc_isar_feature(aa32_sha1, s)) {
                         return 1;
                     }
-                    ptr1 = vfp_reg_ptr(true, rd);
-                    ptr2 = vfp_reg_ptr(true, rm);
-                    if (q) {
-                        gen_helper_crypto_sha256su0(ptr1, ptr2);
-                    } else {
-                        gen_helper_crypto_sha1su1(ptr1, ptr2);
-                    }
-                    tcg_temp_free_ptr(ptr1);
-                    tcg_temp_free_ptr(ptr2);
+                    tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, 16, 16, 0,
+                                       q ? gen_helper_crypto_sha256su0
+                                       : gen_helper_crypto_sha1su1);
                     break;
-
                 case NEON_2RM_VMVN:
                     tcg_gen_gvec_not(0, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
-- 
2.20.1


