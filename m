Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47653C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 04:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F040D20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 04:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqasWzus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F040D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKxjV-0004eQ-3o
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 00:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKxcb-0007CU-02
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKxcY-00027Q-7q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:43 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKxcY-00026h-0i
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id q21so772678pfn.11
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zOC1XFUB3wi7uYonQZJi3b57G5irg2dMBLyQa/p2Rwg=;
 b=PqasWzusV5n8E3FTj5KAwIup8KIFEElEg4opN7fBG35UMUfAmUVUR4vf7HI8LbR9az
 +uVJBjR6ouG7FVGpCwaI2wl7JIpL+fFUae4OrCaPI0TOIM9GvDk8hcbNcf25owk0iQ7h
 /9QvZ44yAkI5+/Zqbw4sdZUBelVefNdS3hCIndTp7+wv6hmWQF/bkiCnZ+4dEyZq52kV
 SlZPKdgoauQwj9l2kXusIP0Zbx5qrhkL/eBvB3LBrB23JEw2D/lNJQpxBWYlSGh+Pw8y
 8oj98Xj4TmGucpjiOQlGS/XlUCBwSdMASw2Ffpdm5COMvQ3nQdLj7OwZwYgiX7jm6B+g
 szIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zOC1XFUB3wi7uYonQZJi3b57G5irg2dMBLyQa/p2Rwg=;
 b=d45WR1UwXzvHBWTTRGXPvtIOWBWjzjFwU+MX9BslRR9ML1ZsAayJ7qNgoMBNlmM6OF
 vlPRyGrU7MakaRWFKK3UqTcw2ilwi2aBCU/vYYzA58GDH0kaOZtetUAB1UlbQyQ6I9o5
 hLt2KVXCIzE+3Up3LYkOQ0gV7fp7Sy1CkFLi1bvSL8hQ9d0FWya9NcMDxRiFLzalc1MH
 Ug8FNE9C36ZTixsXZfXGAxG3Zh5kuGhbGiFB0IxrRfNxHI0xVqTrhH0yNhM43P/c03y0
 Ss4WX8eBJw6hw+o1CuxnqVg0NP9PcM5Wrrsg13VcgoFxLN7Ct5PESw/oe1qbYihUH04i
 2MSg==
X-Gm-Message-State: APjAAAXE0uJ3oDlJYmWnr86Yoejg/pfk5iweycmp68ZvMl0MUOXG0bDt
 pBYrzoFH0D99H9bRxvmJlkkIEIBOPxc=
X-Google-Smtp-Source: APXvYqxpCNftxJggwUkeVGcf5l44WTaRBu5M31kiY3C+Oi6+VYzjV3j1C34kuYMcPqZY+XuVb/Xkwg==
X-Received: by 2002:a63:e055:: with SMTP id n21mr1852972pgj.411.1571287360556; 
 Wed, 16 Oct 2019 21:42:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n15sm718923pjt.13.2019.10.16.21.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 21:42:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/arm: Convert PMULL.8 to gvec
Date: Wed, 16 Oct 2019 21:42:32 -0700
Message-Id: <20191017044232.27601-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017044232.27601-1-richard.henderson@linaro.org>
References: <20191017044232.27601-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We still need two different helpers, since NEON and SVE2 get the
inputs from different locations within the source vector.  However,
we can convert both to the same internal form for computation.

The sve2 helper is not used yet, but adding it with this patch
helps illustrate why the neon changes are helpful.

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
index d954399b7e..8a8517cf34 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -335,7 +335,6 @@ DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
-DEF_HELPER_2(neon_mull_p8, i64, i32, i32)
 
 DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
 DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
@@ -688,6 +687,8 @@ DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
index 12588d18df..2934e4fc16 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10483,10 +10483,6 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
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
@@ -10650,11 +10646,21 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
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
@@ -10665,9 +10671,13 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
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
@@ -10688,7 +10698,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-    is_widening:
         if (!fp_access_check(s)) {
             return;
         }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4e34249672..c3abf130cc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5873,15 +5873,20 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
 
@@ -5959,11 +5964,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
index 5c1074374e..04b4d7402d 100644
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
2.17.1


