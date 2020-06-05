Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BDCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547F6207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7v2RNu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547F6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFdL-0004ri-GZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXw-0001Lx-Qq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXv-0001es-DR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id r15so9761323wmh.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qB17Dl9lQ/3CL8Mzo6IR+JDTx2QvbAHeIbICOVJDoxU=;
 b=Z7v2RNu/zc6Iyy1sg9AbGqlA+nxGjJQn9b+/XjyQYV8YdEzUxcqj9NODH/NLFqHczG
 v7Hn5U0i7cKm79oeluKxoc+r/2U2p7nEUwIzGxAgrFFciR3KinKcRgdHespod2siI9Np
 z0SZkTTZyCkovqFQXbum69UwF4fE5M526NEAJ8Onrl0SXB08ADs0FNZI2LjmBIBMdUS8
 1RjYJhQB67OjSprOITvAagf8DuRfD0ynRbmkZgtiFqldTH2gVidHyPAOOm3rqPlsraT6
 JEm1+Je0JWsKOcuXaCceOx+ueB1s9kXtJTZ3Dr8PqiLKg23DdfWbtPCo1hk00xUAN54o
 EGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qB17Dl9lQ/3CL8Mzo6IR+JDTx2QvbAHeIbICOVJDoxU=;
 b=swTAKxcbDh4F8zButU6grGTl5WXZyrEw1403IADGbY4r7X6dih9q9ogNpk6RZj3swi
 NBIE5nI0/CvcNfI991vkEIkRyJsW7QQ7LTBSZtU3hQ+7ZY1JhIHUquiWRKNDKVDNnmrD
 ZZgQwmgiyjIMdJ35+QxK0kHi0c+XmLyx9V50b7IJHICIUSmiS0V9ZGUg/H7uDrT9tI1A
 m5em/KbwuPBssG6LW7xrfIbvddeI6JD5zV0bhG2yXIRjlS3z9uJCtCLN4LgBtP6rcLPg
 xyiYkYNRg8eSZ8ccHL+HB7ZR99jXcgAJZ/UMCuSC//+rPHGA0yK9pbmwV/Zs8xbfHigs
 soOA==
X-Gm-Message-State: AOAM530d1mkXDMwwRRxRC4ZP76508G1t5cqdWzR7371FNl4TpubQuIdg
 HKy/iIC22OzLgOYGQOitvpecYKWVhkEXrA==
X-Google-Smtp-Source: ABdhPJxc7v+vGGFZHkW5vQEdD3TcYLXM3ubI7oKXHZIID6pGvBU2N4L+WWWSp+382vbi2iqVq9E0mQ==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr3745186wmg.21.1591375817344; 
 Fri, 05 Jun 2020 09:50:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] target/arm: Convert sha512 and sm3 to gvec helpers
Date: Fri,  5 Jun 2020 17:49:45 +0100
Message-Id: <20200605165007.12095-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Message-id: 20200514212831.31248-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        | 15 +++++++-----
 target/arm/crypto_helper.c | 37 +++++++++++++++++++++++-----
 target/arm/translate-a64.c | 50 ++++++++++++--------------------------
 3 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6c4eb9befb4..784dc29ce24 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -522,14 +522,17 @@ DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
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
index 372d8350e4b..637e4c00bba 100644
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
index 45c797f8fc3..2d24cfbe2f8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13624,7 +13624,6 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool feature;
-    CryptoThreeOpFn *genfn = NULL;
     gen_helper_gvec_3 *oolfn = NULL;
     GVecGen3Fn *gvecfn = NULL;
 
@@ -13632,15 +13631,15 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         switch (opcode) {
         case 0: /* SHA512H */
             feature = dc_isar_feature(aa64_sha512, s);
-            genfn = gen_helper_crypto_sha512h;
+            oolfn = gen_helper_crypto_sha512h;
             break;
         case 1: /* SHA512H2 */
             feature = dc_isar_feature(aa64_sha512, s);
-            genfn = gen_helper_crypto_sha512h2;
+            oolfn = gen_helper_crypto_sha512h2;
             break;
         case 2: /* SHA512SU1 */
             feature = dc_isar_feature(aa64_sha512, s);
-            genfn = gen_helper_crypto_sha512su1;
+            oolfn = gen_helper_crypto_sha512su1;
             break;
         case 3: /* RAX1 */
             feature = dc_isar_feature(aa64_sha3, s);
@@ -13653,11 +13652,11 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         switch (opcode) {
         case 0: /* SM3PARTW1 */
             feature = dc_isar_feature(aa64_sm3, s);
-            genfn = gen_helper_crypto_sm3partw1;
+            oolfn = gen_helper_crypto_sm3partw1;
             break;
         case 1: /* SM3PARTW2 */
             feature = dc_isar_feature(aa64_sm3, s);
-            genfn = gen_helper_crypto_sm3partw2;
+            oolfn = gen_helper_crypto_sm3partw2;
             break;
         case 2: /* SM4EKEY */
             feature = dc_isar_feature(aa64_sm4, s);
@@ -13680,20 +13679,8 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 
     if (oolfn) {
         gen_gvec_op3_ool(s, true, rd, rn, rm, 0, oolfn);
-    } else if (gvecfn) {
-        gen_gvec_fn3(s, true, rd, rn, rm, gvecfn, MO_64);
     } else {
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
+        gen_gvec_fn3(s, true, rd, rn, rm, gvecfn, MO_64);
     }
 }
 
@@ -13708,19 +13695,14 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 10, 2);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
     bool feature;
-    CryptoTwoOpFn *genfn;
-    gen_helper_gvec_3 *oolfn = NULL;
 
     switch (opcode) {
     case 0: /* SHA512SU0 */
         feature = dc_isar_feature(aa64_sha512, s);
-        genfn = gen_helper_crypto_sha512su0;
         break;
     case 1: /* SM4E */
         feature = dc_isar_feature(aa64_sm4, s);
-        oolfn = gen_helper_crypto_sm4e;
         break;
     default:
         unallocated_encoding(s);
@@ -13736,18 +13718,16 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (oolfn) {
-        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, oolfn);
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


