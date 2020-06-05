Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD69D2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTlfDR+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD69D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFaj-0007T4-4S
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXv-0001Jf-Ql
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXt-0001eO-Cm
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so9061203wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VxhNIIzO5Mq3zD1DtaExkWPMndS2p338l9M10gx8Alo=;
 b=fTlfDR+urezpyY6MJTQSsR+YH+DbqGrDMaxlEJYAaxdSej+SMtAOBwvsQzMhscQaSp
 7uUHd01en3qmx22Iv+Zqhh/bmOXKSt9JNLVqRBwqqz5hDkG2PselB0Hk8hWp1Sf73ax3
 y/trHWWyVmxbmoLiyuXYXJXiSTxNQdnvL2GWAVJdKQfPSTDCZI2NkhHw6tP+j07EjI/5
 nP9A6e9kuI6810YzkApFhyucPAr/GX/lp9UCCxbI5HblNEnwISNpGExCHADL01UIJSGq
 NEwkCVSNLE19PUQGW3tXESFONUY7vh39D5LzN5IeaJsI9OwKRLl7e3//Q3xw1+GZcIC9
 QB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VxhNIIzO5Mq3zD1DtaExkWPMndS2p338l9M10gx8Alo=;
 b=uDGBw6VEKg6XKrEEdEK/YL+a+hOGC4iuq6HTOFVw9IYOHeMAaYaurvdf9PsGCDUny+
 bSbf8G4eALcJmr+iVnOCdntfbylTUeT75Cx0Wx2UThuqd94B0ZKJyCQqJKN+kJHogJtv
 Fw14QCTUCMKjFR/1eQnKdC5pZvZt7MGJ7oCb4yEsUG3bD0kZFsTHK4I/L4inktKWfKuQ
 b3AXUdBqo++x8iyyNfJwXa69vSrbJIfoNc8pwlYunzqaqaMf64vfUU+PaRCcjDumwE7Q
 nY3eU5kKvcuIMu/xFaVL1C3dI5GrSzKBX4D98b8I7fN0ldNjTRbdyuhiJrI2NImgl8O4
 mXbA==
X-Gm-Message-State: AOAM531w78ThLNcckgqhIbmqsLd/B/zlWmDhMS1jhfbYkwL67WM95XKb
 0I8NYJJFX5zccgSmK5T7dAre8purIU+AyA==
X-Google-Smtp-Source: ABdhPJytgT6QIkiMjx7CiLyDTWdxTjSAXmApTrgYnlxdXGSu33FWSc4erZQSctjtV/6ibzIh2Umtgw==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr3578776wmp.73.1591375815189; 
 Fri, 05 Jun 2020 09:50:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] target/arm: Convert aes and sm4 to gvec helpers
Date: Fri,  5 Jun 2020 17:49:43 +0100
Message-Id: <20200605165007.12095-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

With this conversion, we will be able to use the same helpers
with sve.  In particular, pass 3 vector parameters for the
3-operand operations; for advsimd the destination register
is also an input.

This also fixes a bug in which we failed to clear the high bits
of the SVE register after an AdvSIMD operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200514212831.31248-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  6 ++--
 target/arm/vec_internal.h  | 33 +++++++++++++++++
 target/arm/crypto_helper.c | 72 +++++++++++++++++++++++++++-----------
 target/arm/translate-a64.c | 55 ++++++++++++++++++-----------
 target/arm/translate.c     | 27 +++++++-------
 target/arm/vec_helper.c    | 12 +------
 6 files changed, 138 insertions(+), 67 deletions(-)
 create mode 100644 target/arm/vec_internal.h

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 49336dc432c..42759f82aa6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -510,7 +510,7 @@ DEF_HELPER_FLAGS_2(neon_qzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
 
-DEF_HELPER_FLAGS_3(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -531,8 +531,8 @@ DEF_HELPER_FLAGS_5(crypto_sm3tt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(crypto_sm3partw1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
-DEF_HELPER_FLAGS_2(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_4(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
diff --git a/target/arm/vec_internal.h b/target/arm/vec_internal.h
new file mode 100644
index 00000000000..00a82777654
--- /dev/null
+++ b/target/arm/vec_internal.h
@@ -0,0 +1,33 @@
+/*
+ * ARM AdvSIMD / SVE Vector Helpers
+ *
+ * Copyright (c) 2020 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARM_VEC_INTERNALS_H
+#define TARGET_ARM_VEC_INTERNALS_H
+
+static inline void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
+{
+    uint64_t *d = vd + opr_sz;
+    uintptr_t i;
+
+    for (i = opr_sz; i < max_sz; i += 8) {
+        *d++ = 0;
+    }
+}
+
+#endif /* TARGET_ARM_VEC_INTERNALS_H */
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index f8002667275..6bd5a3d2d03 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -13,7 +13,9 @@
 
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
+#include "vec_internal.h"
 
 union CRYPTO_STATE {
     uint8_t    bytes[16];
@@ -29,18 +31,15 @@ union CRYPTO_STATE {
 #define CR_ST_WORD(state, i)   (state.words[i])
 #endif
 
-void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
+static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
+                           uint64_t *rm, bool decrypt)
 {
     static uint8_t const * const sbox[2] = { AES_sbox, AES_isbox };
     static uint8_t const * const shift[2] = { AES_shifts, AES_ishifts };
-    uint64_t *rd = vd;
-    uint64_t *rm = vm;
     union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
-    union CRYPTO_STATE st = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
     int i;
 
-    assert(decrypt < 2);
-
     /* xor state vector with round key */
     rk.l[0] ^= st.l[0];
     rk.l[1] ^= st.l[1];
@@ -54,7 +53,18 @@ void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
     rd[1] = st.l[1];
 }
 
-void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
+void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    bool decrypt = simd_data(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_aese(vd + i, vn + i, vm + i, decrypt);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
+static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
 {
     static uint32_t const mc[][256] = { {
         /* MixColumns lookup table */
@@ -190,13 +200,9 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
         0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
     } };
 
-    uint64_t *rd = vd;
-    uint64_t *rm = vm;
     union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
     int i;
 
-    assert(decrypt < 2);
-
     for (i = 0; i < 16; i += 4) {
         CR_ST_WORD(st, i >> 2) =
             mc[decrypt][CR_ST_BYTE(st, i)] ^
@@ -209,6 +215,17 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
     rd[1] = st.l[1];
 }
 
+void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    bool decrypt = simd_data(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_aesmc(vd + i, vm + i, decrypt);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
 /*
  * SHA-1 logical functions
  */
@@ -638,12 +655,10 @@ static uint8_t const sm4_sbox[] = {
     0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48,
 };
 
-void HELPER(crypto_sm4e)(void *vd, void *vn)
+static void do_crypto_sm4e(uint64_t *rd, uint64_t *rn, uint64_t *rm)
 {
-    uint64_t *rd = vd;
-    uint64_t *rn = vn;
-    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
-    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE d = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE n = { .l = { rm[0], rm[1] } };
     uint32_t t, i;
 
     for (i = 0; i < 4; i++) {
@@ -665,11 +680,18 @@ void HELPER(crypto_sm4e)(void *vd, void *vn)
     rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
+void HELPER(crypto_sm4e)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_sm4e(vd + i, vn + i, vm + i);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
+static void do_crypto_sm4ekey(uint64_t *rd, uint64_t *rn, uint64_t *rm)
 {
-    uint64_t *rd = vd;
-    uint64_t *rn = vn;
-    uint64_t *rm = vm;
     union CRYPTO_STATE d;
     union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
     union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
@@ -693,3 +715,13 @@ void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
     rd[0] = d.l[0];
     rd[1] = d.l[1];
 }
+
+void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_sm4ekey(vd + i, vn + i, vm + i);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 874f3eb4f97..b3f42230063 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -571,6 +571,15 @@ static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
             is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
+/* Expand a 2-operand operation using an out-of-line helper.  */
+static void gen_gvec_op2_ool(DisasContext *s, bool is_q, int rd,
+                             int rn, int data, gen_helper_gvec_2 *fn)
+{
+    tcg_gen_gvec_2_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
+}
+
 /* Expand a 3-operand operation using an out-of-line helper.  */
 static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
                              int rn, int rm, int data, gen_helper_gvec_3 *fn)
@@ -13403,9 +13412,8 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int decrypt;
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
-    TCGv_i32 tcg_decrypt;
-    CryptoThreeOpIntFn *genfn;
+    gen_helper_gvec_2 *genfn2 = NULL;
+    gen_helper_gvec_3 *genfn3 = NULL;
 
     if (!dc_isar_feature(aa64_aes, s) || size != 0) {
         unallocated_encoding(s);
@@ -13415,19 +13423,19 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     switch (opcode) {
     case 0x4: /* AESE */
         decrypt = 0;
-        genfn = gen_helper_crypto_aese;
+        genfn3 = gen_helper_crypto_aese;
         break;
     case 0x6: /* AESMC */
         decrypt = 0;
-        genfn = gen_helper_crypto_aesmc;
+        genfn2 = gen_helper_crypto_aesmc;
         break;
     case 0x5: /* AESD */
         decrypt = 1;
-        genfn = gen_helper_crypto_aese;
+        genfn3 = gen_helper_crypto_aese;
         break;
     case 0x7: /* AESIMC */
         decrypt = 1;
-        genfn = gen_helper_crypto_aesmc;
+        genfn2 = gen_helper_crypto_aesmc;
         break;
     default:
         unallocated_encoding(s);
@@ -13437,16 +13445,11 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     if (!fp_access_check(s)) {
         return;
     }
-
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-    tcg_decrypt = tcg_const_i32(decrypt);
-
-    genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_decrypt);
-
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
-    tcg_temp_free_i32(tcg_decrypt);
+    if (genfn2) {
+        gen_gvec_op2_ool(s, true, rd, rn, decrypt, genfn2);
+    } else {
+        gen_gvec_op3_ool(s, true, rd, rd, rn, decrypt, genfn3);
+    }
 }
 
 /* Crypto three-reg SHA
@@ -13595,7 +13598,8 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool feature;
-    CryptoThreeOpFn *genfn;
+    CryptoThreeOpFn *genfn = NULL;
+    gen_helper_gvec_3 *oolfn = NULL;
 
     if (o == 0) {
         switch (opcode) {
@@ -13630,7 +13634,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             break;
         case 2: /* SM4EKEY */
             feature = dc_isar_feature(aa64_sm4, s);
-            genfn = gen_helper_crypto_sm4ekey;
+            oolfn = gen_helper_crypto_sm4ekey;
             break;
         default:
             unallocated_encoding(s);
@@ -13647,6 +13651,11 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (oolfn) {
+        gen_gvec_op3_ool(s, true, rd, rn, rm, 0, oolfn);
+        return;
+    }
+
     if (genfn) {
         TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
 
@@ -13699,6 +13708,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
     bool feature;
     CryptoTwoOpFn *genfn;
+    gen_helper_gvec_3 *oolfn = NULL;
 
     switch (opcode) {
     case 0: /* SHA512SU0 */
@@ -13707,7 +13717,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         break;
     case 1: /* SM4E */
         feature = dc_isar_feature(aa64_sm4, s);
-        genfn = gen_helper_crypto_sm4e;
+        oolfn = gen_helper_crypto_sm4e;
         break;
     default:
         unallocated_encoding(s);
@@ -13723,6 +13733,11 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (oolfn) {
+        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, oolfn);
+        return;
+    }
+
     tcg_rd_ptr = vec_full_reg_ptr(s, rd);
     tcg_rn_ptr = vec_full_reg_ptr(s, rn);
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c8296116d4b..74c1b5be424 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6350,22 +6350,23 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     if (!dc_isar_feature(aa32_aes, s) || ((rm | rd) & 1)) {
                         return 1;
                     }
-                    ptr1 = vfp_reg_ptr(true, rd);
-                    ptr2 = vfp_reg_ptr(true, rm);
-
-                     /* Bit 6 is the lowest opcode bit; it distinguishes between
-                      * encryption (AESE/AESMC) and decryption (AESD/AESIMC)
-                      */
-                    tmp3 = tcg_const_i32(extract32(insn, 6, 1));
-
+                    /*
+                     * Bit 6 is the lowest opcode bit; it distinguishes
+                     * between encryption (AESE/AESMC) and decryption
+                     * (AESD/AESIMC).
+                     */
                     if (op == NEON_2RM_AESE) {
-                        gen_helper_crypto_aese(ptr1, ptr2, tmp3);
+                        tcg_gen_gvec_3_ool(vfp_reg_offset(true, rd),
+                                           vfp_reg_offset(true, rd),
+                                           vfp_reg_offset(true, rm),
+                                           16, 16, extract32(insn, 6, 1),
+                                           gen_helper_crypto_aese);
                     } else {
-                        gen_helper_crypto_aesmc(ptr1, ptr2, tmp3);
+                        tcg_gen_gvec_2_ool(vfp_reg_offset(true, rd),
+                                           vfp_reg_offset(true, rm),
+                                           16, 16, extract32(insn, 6, 1),
+                                           gen_helper_crypto_aesmc);
                     }
-                    tcg_temp_free_ptr(ptr1);
-                    tcg_temp_free_ptr(ptr2);
-                    tcg_temp_free_i32(tmp3);
                     break;
                 case NEON_2RM_SHA1H:
                     if (!dc_isar_feature(aa32_sha1, s) || ((rm | rd) & 1)) {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 50a499299fd..7d76412ee0d 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -22,7 +22,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
-
+#include "vec_internal.h"
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
    so addressing units smaller than that needs a host-endian fixup.  */
@@ -36,16 +36,6 @@
 #define H4(x)  (x)
 #endif
 
-static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
-{
-    uint64_t *d = vd + opr_sz;
-    uintptr_t i;
-
-    for (i = opr_sz; i < max_sz; i += 8) {
-        *d++ = 0;
-    }
-}
-
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
 static int16_t inl_qrdmlah_s16(int16_t src1, int16_t src2,
                                int16_t src3, uint32_t *sat)
-- 
2.20.1


