Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323AC83004
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EA420B80
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpOmy8el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EA420B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyap-0000WP-WC
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYw-0006yS-Ub
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXh-0004jn-5s
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:30 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXg-0004jQ-Kf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:12 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a32so54397pje.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UBqJb5Jdsa7NV9JcGHmEClWTryX2MT6M5prjM2Nl448=;
 b=DpOmy8el0LgZG9lbalpewJt+t0k0JNzziaCR11MqU2AIbJ0/QEQjj15mkMQpdGHvce
 eSRGswcN4ZbjvSpqIJ4hmrBFmbrPyIfNCPYygVj+k3tyw5Pn/LIX4raWp3edMhzwar4t
 cT9xJsw5WMeiYfX+2LP4ZPgahM9nFB2+WJ+uUpDLE2smD3xbbSInC6yEvt9kUsRKHQDY
 OSAI4t+/5plgTRSDJd8zq5e56IRXar5/6Ye6yroo93wf5kBvlJV+aSbmRF8sjU5g1xvf
 yvAXeeEAZrCQwzhcGZHE1kPDHJiOvvtWTdpyr/ri/pIUYHEH8dNaeKtsPB1fhPkyLY7c
 ooEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UBqJb5Jdsa7NV9JcGHmEClWTryX2MT6M5prjM2Nl448=;
 b=S7MgGji+KASoOrPN72WKN+VKqG7OXgdEqVNyrRhLyf0Kbea6UrkXmneWo8juoDf5qa
 zoUV7b/GFQ4ot+KHOAJtaJ3woDsuPu8vRS7+sslQDh1wlt6OTEUw+qQtGLUFWPrd3Wsf
 wUHyk/hxvF183MJ1xiGd6USt5NIleuedt0Tmkg2lA6giRUdJel2bMqbhAUcIETM4pNqz
 7vHd7VkfM612TN+kt6/LMIAv5Pfaxek06t1Vj9iutZfEAt21dNVSOcxyuHXlL1OrWTSZ
 bsTIidpuNXgQEIo2A8V2OCAypLzmdIsi0eFOjFBSrMKrsRKJpbPVY2htI+T9/vOYedSF
 n8Rw==
X-Gm-Message-State: AGi0Puajc7yn/zJYJUszGuSK49ml8oT3ncdoQqnu2iyD6yoJ1fK3TE+b
 /PkhST7ZaCC03h9LGqVgrR49X8fVBA0=
X-Google-Smtp-Source: APiQypJUD7G6fOqJdq6ADrF4TTWNeDFZRKL+PBMhfPQe2hYmw+a1MmrAJZMGCuCt+7R0+p/Mi9H6LQ==
X-Received: by 2002:a17:902:d30a:: with SMTP id
 b10mr1357888plc.3.1588212189064; 
 Wed, 29 Apr 2020 19:03:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] target/arm: Convert sha512 and sm3 to gvec helpers
Date: Wed, 29 Apr 2020 19:02:57 -0700
Message-Id: <20200430020303.20264-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not yet convert the helpers to loop over opr_sz, but the
descriptor allows the vector tail to be cleared.  Which fixes
an existing bug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 15 +++++----
 target/arm/crypto_helper.c | 37 +++++++++++++++++++----
 target/arm/translate-a64.c | 62 +++++++++++++++-----------------------
 3 files changed, 64 insertions(+), 50 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 96cf4464be..d564747808 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -525,14 +525,17 @@ DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_2(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
-DEF_HELPER_FLAGS_3(crypto_sha512h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_2(crypto_sha512su0, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sha512su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_4(crypto_sha512h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_sha512su0, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha512su1, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(crypto_sm3tt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
-DEF_HELPER_FLAGS_3(crypto_sm3partw1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_4(crypto_sm3partw1, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sm3partw2, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 372d8350e4..637e4c00bb 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -31,6 +31,19 @@ union CRYPTO_STATE {
 #define CR_ST_WORD(state, i)   (state.words[i])
 #endif
 
+/*
+ * The caller has not been converted to full gvec, and so only
+ * modifies the low 16 bytes of the vector register.
+ */
+static void clear_tail_16(void *vd, uint32_t desc)
+{
+    int opr_sz = simd_oprsz(desc);
+    int max_sz = simd_maxsz(desc);
+
+    assert(opr_sz == 16);
+    clear_tail(vd, opr_sz, max_sz);
+}
+
 static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
                            uint64_t *rm, bool decrypt)
 {
@@ -470,7 +483,7 @@ static uint64_t s1_512(uint64_t x)
     return ror64(x, 19) ^ ror64(x, 61) ^ (x >> 6);
 }
 
-void HELPER(crypto_sha512h)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha512h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -483,9 +496,11 @@ void HELPER(crypto_sha512h)(void *vd, void *vn, void *vm)
 
     rd[0] = d0;
     rd[1] = d1;
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha512h2)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha512h2)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -498,9 +513,11 @@ void HELPER(crypto_sha512h2)(void *vd, void *vn, void *vm)
 
     rd[0] = d0;
     rd[1] = d1;
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha512su0)(void *vd, void *vn)
+void HELPER(crypto_sha512su0)(void *vd, void *vn, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -512,9 +529,11 @@ void HELPER(crypto_sha512su0)(void *vd, void *vn)
 
     rd[0] = d0;
     rd[1] = d1;
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha512su1)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha512su1)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -522,9 +541,11 @@ void HELPER(crypto_sha512su1)(void *vd, void *vn, void *vm)
 
     rd[0] += s1_512(rn[0]) + rm[0];
     rd[1] += s1_512(rn[1]) + rm[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sm3partw1)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sm3partw1)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -548,9 +569,11 @@ void HELPER(crypto_sm3partw1)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sm3partw2)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sm3partw2)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -568,6 +591,8 @@ void HELPER(crypto_sm3partw2)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
 void HELPER(crypto_sm3tt)(void *vd, void *vn, void *vm, uint32_t imm2,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2eb4315b6d..c737a409d0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14668,28 +14668,36 @@ const GVecGen3 rax1_op =
 static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 {
     static const GVecGen3 sm4ekey_op = { .fno = gen_helper_crypto_sm4ekey };
+    static const GVecGen3 sha512h_op = { .fno = gen_helper_crypto_sha512h };
+    static const GVecGen3 sha512h2_op
+        = { .fno = gen_helper_crypto_sha512h2 };
+    static const GVecGen3 sha512su1_op
+        = { .fno = gen_helper_crypto_sha512su1 };
+    static const GVecGen3 sm3partw1_op
+        = { .fno = gen_helper_crypto_sm3partw1 };
+    static const GVecGen3 sm3partw2_op
+        = { .fno = gen_helper_crypto_sm3partw2 };
     int opcode = extract32(insn, 10, 2);
     int o =  extract32(insn, 14, 1);
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool feature;
-    CryptoThreeOpFn *genfn = NULL;
     const GVecGen3 *gvecop = NULL;
 
     if (o == 0) {
         switch (opcode) {
         case 0: /* SHA512H */
             feature = dc_isar_feature(aa64_sha512, s);
-            genfn = gen_helper_crypto_sha512h;
+            gvecop = &sha512h_op;
             break;
         case 1: /* SHA512H2 */
             feature = dc_isar_feature(aa64_sha512, s);
-            genfn = gen_helper_crypto_sha512h2;
+            gvecop = &sha512h2_op;
             break;
         case 2: /* SHA512SU1 */
             feature = dc_isar_feature(aa64_sha512, s);
-            genfn = gen_helper_crypto_sha512su1;
+            gvecop = &sha512su1_op;
             break;
         case 3: /* RAX1 */
             feature = dc_isar_feature(aa64_sha3, s);
@@ -14702,11 +14710,11 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         switch (opcode) {
         case 0: /* SM3PARTW1 */
             feature = dc_isar_feature(aa64_sm3, s);
-            genfn = gen_helper_crypto_sm3partw1;
+            gvecop = &sm3partw1_op;
             break;
         case 1: /* SM3PARTW2 */
             feature = dc_isar_feature(aa64_sm3, s);
-            genfn = gen_helper_crypto_sm3partw2;
+            gvecop = &sm3partw2_op;
             break;
         case 2: /* SM4EKEY */
             feature = dc_isar_feature(aa64_sm4, s);
@@ -14726,22 +14734,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     if (!fp_access_check(s)) {
         return;
     }
-
-    if (gvecop) {
-        gen_gvec_op3(s, true, rd, rn, rm, gvecop);
-    } else {
-        TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
-
-        tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-        tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-        tcg_rm_ptr = vec_full_reg_ptr(s, rm);
-
-        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
-
-        tcg_temp_free_ptr(tcg_rd_ptr);
-        tcg_temp_free_ptr(tcg_rn_ptr);
-        tcg_temp_free_ptr(tcg_rm_ptr);
-    }
+    gen_gvec_op3(s, true, rd, rn, rm, gvecop);
 }
 
 /* Crypto two-reg SHA512
@@ -14755,19 +14748,14 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 10, 2);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
     bool feature;
-    CryptoTwoOpFn *genfn;
-    gen_helper_gvec_3 *gvecfn = NULL;
 
     switch (opcode) {
     case 0: /* SHA512SU0 */
         feature = dc_isar_feature(aa64_sha512, s);
-        genfn = gen_helper_crypto_sha512su0;
         break;
     case 1: /* SM4E */
         feature = dc_isar_feature(aa64_sm4, s);
-        gvecfn = gen_helper_crypto_sm4e;
         break;
     default:
         unallocated_encoding(s);
@@ -14783,18 +14771,16 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (gvecfn) {
-        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, gvecfn);
-        return;
+    switch (opcode) {
+    case 0: /* SHA512SU0 */
+        gen_gvec_op2_ool(s, true, rd, rn, 0, gen_helper_crypto_sha512su0);
+        break;
+    case 1: /* SM4E */
+        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, gen_helper_crypto_sm4e);
+        break;
+    default:
+        g_assert_not_reached();
     }
-
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-
-    genfn(tcg_rd_ptr, tcg_rn_ptr);
-
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
 }
 
 /* Crypto four-register
-- 
2.20.1


