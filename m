Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B50EC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E192084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaLvYpO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RkU-0004W7-RP
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgX-0007uy-OM
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgV-0004wV-Vx
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:41 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3RgV-0004va-OA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:39 -0500
Received: by mail-pf1-x443.google.com with SMTP id p14so7793578pfn.4
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 13:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eMj4/+qaGhoNS+9r6sBtA5cZajrCIO2mP4pzA4t1Oe8=;
 b=ZaLvYpO7Plsa4JkrHEWOMHzEilmAl84Ww9Bs9YFX67ULjFzKwrz1bNXW/4NO6v2aai
 w0TjRvCuxeb1i+YtniFnEP2J6JfURLPtAECrB8gaAugVAIcVXcPZc6LSiyViGw8mON9g
 XcUU6kvVRvPIFh+BWMmXoxN34+Bkf7Ebg3WkmpiT2Rba4myqJ+JArNcsbQIkJP9Cc5Kj
 8Gm2iicF6UMawAijwMsxiEOwDliOCRMN98eNfk7SHZhY5Xw11Sx+GBptng+pugCtG6R5
 26SsMi1BW3z3AUUK5Ok8O4HUmzdQ5tg+fDwnexXknp2EDQGS592shvIvzQLQeruRE1+x
 aWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eMj4/+qaGhoNS+9r6sBtA5cZajrCIO2mP4pzA4t1Oe8=;
 b=Jih0ph2UAOp7IDwIUdD1b24EZTNcGQt8BOXHjCBYUPKSnufiRF2Bbmwb5AKk4Mffpr
 6ZTm47SJwGYyfaQ5Fw+QZ4WwcIzR88PzRA9Z2QKMiB/DFT7sNJmGd/sPF1WwSoNx9HYS
 1eCbPcxYU7PrFhzBHJj/1haGNLleenOFmuMVaS3If9cD7oVjuEZkhkTfmipwM05z1nE0
 ta9tHDf94h6P9Qwh9QoLVwadF2wAmco0835RKuGrqVLfFWa5vq1SVboFeUCljqEo8urn
 2p3/RPkYBqtxm3w4SprkT6V7fz1/uBxc17s3QLGYRR19Icw/X098TW/iWyoPEtsY54ib
 YXIg==
X-Gm-Message-State: APjAAAUuKwzmHxMcoND/TCyCSJAu66bKd6b24anANbEYRU/jXStpu6z9
 MK0tx+rRYEjlJ4XyP/SDmFfdXszHRi4=
X-Google-Smtp-Source: APXvYqyyJ29pJzabRZL+uf4gczrHw+yt+c+CrbDSeV2wy35D6raiDX7ZvY2RCdrjxCbvOtZMGjOBVw==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr13916456pgk.398.1581889358362; 
 Sun, 16 Feb 2020 13:42:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z29sm14821848pgc.21.2020.02.16.13.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 13:42:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] target/arm: Convert PMULL.8 to gvec
Date: Sun, 16 Feb 2020 13:42:32 -0800
Message-Id: <20200216214232.4230-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216214232.4230-1-richard.henderson@linaro.org>
References: <20200216214232.4230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We still need two different helpers, since NEON and SVE2 get the
inputs from different locations within the source vector.  However,
we can convert both to the same internal form for computation.

The sve2 helper is not used yet, but adding it with this patch
helps illustrate why the neon changes are helpful.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  2 ++
 target/arm/helper.h        |  3 +-
 target/arm/neon_helper.c   | 32 --------------------
 target/arm/translate-a64.c | 27 +++++++++++------
 target/arm/translate.c     | 26 ++++++++---------
 target/arm/vec_helper.c    | 60 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+), 55 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 9e79182ab4..2f47279155 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1574,3 +1574,5 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve2_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 4352fae3db..fcbf504121 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -342,7 +342,6 @@ DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
-DEF_HELPER_2(neon_mull_p8, i64, i32, i32)
 
 DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
 DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
@@ -695,6 +694,8 @@ DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(neon_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 6a107da0e1..c7a8438b42 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -1129,38 +1129,6 @@ NEON_VOP(mul_u8, neon_u8, 4)
 NEON_VOP(mul_u16, neon_u16, 2)
 #undef NEON_FN
 
-/* Polynomial multiplication is like integer multiplication except the
-   partial products are XORed, not added.  */
-uint64_t HELPER(neon_mull_p8)(uint32_t op1, uint32_t op2)
-{
-    uint64_t result = 0;
-    uint64_t mask;
-    uint64_t op2ex = op2;
-    op2ex = (op2ex & 0xff) |
-        ((op2ex & 0xff00) << 8) |
-        ((op2ex & 0xff0000) << 16) |
-        ((op2ex & 0xff000000) << 24);
-    while (op1) {
-        mask = 0;
-        if (op1 & 1) {
-            mask |= 0xffff;
-        }
-        if (op1 & (1 << 8)) {
-            mask |= (0xffffU << 16);
-        }
-        if (op1 & (1 << 16)) {
-            mask |= (0xffffULL << 32);
-        }
-        if (op1 & (1 << 24)) {
-            mask |= (0xffffULL << 48);
-        }
-        result ^= op2ex & mask;
-        op1 = (op1 >> 1) & 0x7f7f7f7f;
-        op2ex <<= 1;
-    }
-    return result;
-}
-
 #define NEON_FN(dest, src1, src2) dest = (src1 & src2) ? -1 : 0
 NEON_VOP(tst_u8, neon_u8, 4)
 NEON_VOP(tst_u16, neon_u16, 2)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6ce1131860..63ff042d60 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10533,10 +10533,6 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
                 gen_helper_neon_addl_saturate_s32(tcg_passres, cpu_env,
                                                   tcg_passres, tcg_passres);
                 break;
-            case 14: /* PMULL */
-                assert(size == 0);
-                gen_helper_neon_mull_p8(tcg_passres, tcg_op1, tcg_op2);
-                break;
             default:
                 g_assert_not_reached();
             }
@@ -10700,11 +10696,21 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
         handle_3rd_narrowing(s, is_q, is_u, size, opcode, rd, rn, rm);
         break;
     case 14: /* PMULL, PMULL2 */
-        if (is_u || size == 1 || size == 2) {
+        if (is_u) {
             unallocated_encoding(s);
             return;
         }
-        if (size == 3) {
+        switch (size) {
+        case 0: /* PMULL.P8 */
+            if (!fp_access_check(s)) {
+                return;
+            }
+            /* The Q field specifies lo/hi half input for this insn.  */
+            gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
+                             gen_helper_neon_pmull_h);
+            break;
+
+        case 3: /* PMULL.P64 */
             if (!dc_isar_feature(aa64_pmull, s)) {
                 unallocated_encoding(s);
                 return;
@@ -10715,9 +10721,13 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             /* The Q field specifies lo/hi half input for this insn.  */
             gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
                              gen_helper_gvec_pmull_q);
-            return;
+            break;
+
+        default:
+            unallocated_encoding(s);
+            break;
         }
-        goto is_widening;
+        return;
     case 9: /* SQDMLAL, SQDMLAL2 */
     case 11: /* SQDMLSL, SQDMLSL2 */
     case 13: /* SQDMULL, SQDMULL2 */
@@ -10738,7 +10748,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-    is_widening:
         if (!fp_access_check(s)) {
             return;
         }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e2dbafa161..07178b632a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5866,15 +5866,20 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     return 1;
                 }
 
-                /* Handle VMULL.P64 (Polynomial 64x64 to 128 bit multiply)
-                 * outside the loop below as it only performs a single pass.
-                 */
-                if (op == 14 && size == 2) {
-                    if (!dc_isar_feature(aa32_pmull, s)) {
-                        return 1;
+                /* Handle polynomial VMULL in a single pass.  */
+                if (op == 14) {
+                    if (size == 0) {
+                        /* VMULL.P8 */
+                        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
+                                           0, gen_helper_neon_pmull_h);
+                    } else {
+                        /* VMULL.P64 */
+                        if (!dc_isar_feature(aa32_pmull, s)) {
+                            return 1;
+                        }
+                        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
+                                           0, gen_helper_gvec_pmull_q);
                     }
-                    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
-                                       0, gen_helper_gvec_pmull_q);
                     return 0;
                 }
 
@@ -5952,11 +5957,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         /* VMLAL, VQDMLAL, VMLSL, VQDMLSL, VMULL, VQDMULL */
                         gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
                         break;
-                    case 14: /* Polynomial VMULL */
-                        gen_helper_neon_mull_p8(cpu_V0, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        tcg_temp_free_i32(tmp);
-                        break;
                     default: /* 15 is RESERVED: caught earlier  */
                         abort();
                     }
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 79d2624f7b..8017bd88c4 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1197,3 +1197,63 @@ void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+/*
+ * 8x8->16 polynomial multiply.
+ *
+ * The byte inputs are expanded to (or extracted from) half-words.
+ * Note that neon and sve2 get the inputs from different positions.
+ * This allows 4 bytes to be processed in parallel with uint64_t.
+ */
+
+static uint64_t expand_byte_to_half(uint64_t x)
+{
+    return  (x & 0x000000ff)
+         | ((x & 0x0000ff00) << 8)
+         | ((x & 0x00ff0000) << 16)
+         | ((x & 0xff000000) << 24);
+}
+
+static uint64_t pmull_h(uint64_t op1, uint64_t op2)
+{
+    uint64_t result = 0;
+    int i;
+
+    for (i = 0; i < 8; ++i) {
+        uint64_t mask = (op1 & 0x0001000100010001ull) * 0xffff;
+        result ^= op2 & mask;
+        op1 >>= 1;
+        op2 <<= 1;
+    }
+    return result;
+}
+
+void HELPER(neon_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    int hi = simd_data(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint64_t nn = n[hi], mm = m[hi];
+
+    d[0] = pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
+    nn >>= 32;
+    mm >>= 32;
+    d[1] = pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
+
+    clear_tail(d, 16, simd_maxsz(desc));
+}
+
+#ifdef TARGET_AARCH64
+void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    int shift = simd_data(desc) * 8;
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        uint64_t nn = (n[i] >> shift) & 0x00ff00ff00ff00ffull;
+        uint64_t mm = (m[i] >> shift) & 0x00ff00ff00ff00ffull;
+
+        d[i] = pmull_h(nn, mm);
+    }
+}
+#endif
-- 
2.20.1


