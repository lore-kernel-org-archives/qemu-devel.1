Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AF820709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sp8QJF6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AF820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLQ3-0005cp-Uw
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPC-00041Y-2v
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:38 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPA-0004bN-Jy
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:37 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ms17so31394pjb.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gQ13Nokc2QqY1T6dZahuQFzqk90ggUWz3QNTj8ciFBs=;
 b=sp8QJF6UJc8C8nzSrdwlq92S8lxC8kOzkY0LUKd2U0GL2ZUJOlmeGWS7yJ+7geNOel
 xhoJJH0lY4Lbiwr7IRv6AEnpID7JV7YLH3AtZ5+D+8Ary391OcH2A+3PSYkmaQFvXge6
 qV6welVO3PWIrKGk9uKI+/78QT3M+G81bCQP/YZL0rEp0bR9uq6HcFHo6dBuNt3DQwZp
 oJy4kdyuiY4NGhDYiwOtG326aGphaKD91hMyERz5ZO4FlX0Cp9JICV42ZaNPL0cIjyj9
 eg3QTI8ekqa6smr+5SntSj27WaQ9DNTxmph37PGBkUwC6vnr5+eCsYRFMHfDjO5yLgX3
 Dt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gQ13Nokc2QqY1T6dZahuQFzqk90ggUWz3QNTj8ciFBs=;
 b=faccT1WMnLMhv6NcYWedMJlFdWeU4G5HUuc0TzChc74meMAohuPPlToVgZ5bHbaZvJ
 iOCsDXZ+6tzQosqfCULQmsImpqcoZXSGkykhpgp0o+k8TFJ9WX0YoKW9QdJCPVzYD2RG
 iGx3T9R/QT0JZnsEJ3AM7axxp5IStNPNxvZkcOIR7C470uTXL8JN80aJbxs11/hyEr3T
 lPBw6isiyxiP4JioHFsq0zBnhrKWzALlI1uJ2SzQWAKYpysQh2ZT42FjD6dUKn8KPyyV
 RZHB0pR5hwGhEc/Afc4j+9bqM3JSjH0hTkOL1O+WTf1Xxw4ZcARMFF26EOxKX+XpWFKm
 mgSQ==
X-Gm-Message-State: AGi0Pubojacns7jlFzccSiKpmp4PBYYaoCNb9czzeSP6I8x1ALyN990X
 UIRNv7Np1nFnvWbyyBY+Fnt1jX75uDY=
X-Google-Smtp-Source: APiQypL4kY/zj2fECzh1GGFCwI/u5nQuc+ZafsYx7bJ0BfQaJ/d1kJzS0FcFGzWQus1cbF1dEqaffQ==
X-Received: by 2002:a17:90a:ea07:: with SMTP id
 w7mr42606511pjy.172.1589491714567; 
 Thu, 14 May 2020 14:28:34 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm4986pjj.33.2020.05.14.14.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 14:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/arm: Convert aes and sm4 to gvec helpers
Date: Thu, 14 May 2020 14:28:26 -0700
Message-Id: <20200514212831.31248-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514212831.31248-1-richard.henderson@linaro.org>
References: <20200514212831.31248-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this conversion, we will be able to use the same helpers
with sve.  In particular, pass 3 vector parameters for the
3-operand operations; for advsimd the destination register
is also an input.

This also fixes a bug in which we failed to clear the high bits
of the SVE register after an AdvSIMD operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 49336dc432..42759f82aa 100644
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
index 0000000000..00a8277765
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
index f800266727..6bd5a3d2d0 100644
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
index 991e451644..1e511529b8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -577,6 +577,15 @@ static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
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
@@ -13398,9 +13407,8 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
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
@@ -13410,19 +13418,19 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
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
@@ -13432,16 +13440,11 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
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
@@ -13590,7 +13593,8 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool feature;
-    CryptoThreeOpFn *genfn;
+    CryptoThreeOpFn *genfn = NULL;
+    gen_helper_gvec_3 *oolfn = NULL;
 
     if (o == 0) {
         switch (opcode) {
@@ -13625,7 +13629,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             break;
         case 2: /* SM4EKEY */
             feature = dc_isar_feature(aa64_sm4, s);
-            genfn = gen_helper_crypto_sm4ekey;
+            oolfn = gen_helper_crypto_sm4ekey;
             break;
         default:
             unallocated_encoding(s);
@@ -13642,6 +13646,11 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (oolfn) {
+        gen_gvec_op3_ool(s, true, rd, rn, rm, 0, oolfn);
+        return;
+    }
+
     if (genfn) {
         TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
 
@@ -13694,6 +13703,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
     bool feature;
     CryptoTwoOpFn *genfn;
+    gen_helper_gvec_3 *oolfn = NULL;
 
     switch (opcode) {
     case 0: /* SHA512SU0 */
@@ -13702,7 +13712,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         break;
     case 1: /* SM4E */
         feature = dc_isar_feature(aa64_sm4, s);
-        genfn = gen_helper_crypto_sm4e;
+        oolfn = gen_helper_crypto_sm4e;
         break;
     default:
         unallocated_encoding(s);
@@ -13718,6 +13728,11 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
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
index 4c9bb8b5ac..921359dfd4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6373,22 +6373,23 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
index 50a499299f..7d76412ee0 100644
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


