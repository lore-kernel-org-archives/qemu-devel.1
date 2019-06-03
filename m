Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FFC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A7D25275
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmXKmYOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A7D25275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42263 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXwIT-0004Ht-Q2
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 19:23:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXwHW-0003xh-Gx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 19:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXwHS-0004LA-TN
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 19:22:22 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:45644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXwHS-0004JI-Ju
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 19:22:18 -0400
Received: by mail-ot1-x32c.google.com with SMTP id t24so4039513otl.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=znD6FRMjjaatu79mH4Gn9yMz88mFqFs0A+QPb/DzBh0=;
	b=FmXKmYOyiELDZzD0uFJju52DJKFENfoXFYewQxT+sh3Jypnr1HuzmtqFbsP+cM1+gF
	9dp0rcHbmoEaTs0VfiJK3rIuEdWMOQB298uTtIvIzPu0g7r6/pXLoxZgfPRAH/rcqRkK
	DHeKm+nWCNqaOchaNQhh96ObUIKa8kobOcaOyHcH5g1y3uV9wWcgLxny8kLslCahJO8L
	EV3A5wqhEA8i1ShhzNSHUnTWhcuBNMKnoDOsew6fBTntetdsH21NxPOLF9+X/9MBwg8M
	mSHDXUjaDLjv9b+dXO0TZzTZS3Mlii3M0jDnEi5/2KgQ2B8DOXBrhd+C+OVnxItpZzbY
	lpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=znD6FRMjjaatu79mH4Gn9yMz88mFqFs0A+QPb/DzBh0=;
	b=FA7F5TWnmSgRRtkkvkPkm6tbFxTmIZVvzBK5URPAWCnBYYtlLKzDc0eu/Qjqpdkx+a
	8sLJp26I6rfRyauqEvr60GewJUnfuZ/ZJHsekYCowgp9IjTJltE6A4XDN0YW0YBfAzRY
	IX5aI2jOw+Hb3k6FJ1R02DdD/Nd4wfVCWrKCtPMFsHCwUMshJL5ivxNfrMO8im4gxDdE
	MF/gO78dOXmO37x9exUmZUxXYJjwPOYrqpbEbJYdOi3bS26Ndg4QZl3trpuMVRp7vVBx
	sP+2B9QQh7JvhGyaSO4qfvDxAmkicCvceamiMQsQ6oGjsyFmgrj+kinEp61TJhPHHLzD
	J1zg==
X-Gm-Message-State: APjAAAVMNuA8E+n7XSBtIZiAB9cAvnYbIGDnMRFn+XOt6vgMkNrj9eA7
	rWC32keEHHg1o+L67Uz40gvStUgRqGiUBg==
X-Google-Smtp-Source: APXvYqxyaKNoENxWGIoRumu34CpUJ41h/z0jFra5KvHMXZzwNHMh2tQ+ti2/HcnXBEg18JnKKCh0pw==
X-Received: by 2002:a9d:3782:: with SMTP id x2mr2895203otb.354.1559604136667; 
	Mon, 03 Jun 2019 16:22:16 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	n10sm3047932otq.63.2019.06.03.16.22.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 16:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:22:09 -0500
Message-Id: <20190603232209.20704-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: [Qemu-devel] [PATCH v2] target/arm: Vectorize USHL and SSHL
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These instructions shift left or right depending on the sign
of the input, and 7 bits are significant to the shift.  This
requires several masks and selects in addition to the actual
shifts to form the complete answer.

That said, the operation is still a small improvement even for
two 64-bit elements -- 13 vector operations instead of 2 * 7
integer operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Changes in v2:
  * Clarify some commentary.
  * Remove unreachable out-of-line functions.
  * Use more comparisons more favorable to x86_64,
    and does not affect other vector hosts.

Example code generation (x86_64 and aarch64):

USHL:

0x564bc522df1b:  c5 e9 ef d2              vpxor    %xmm2, %xmm2, %xmm2
0x564bc522df1f:  c5 e9 fa d1              vpsubd   %xmm1, %xmm2, %xmm2
0x564bc522df23:  c5 fa 7e 1d 75 00 00 00  vmovq    0x75(%rip), %xmm3
0x564bc522df2b:  c5 f1 db cb              vpand    %xmm3, %xmm1, %xmm1
0x564bc522df2f:  c5 e9 db d3              vpand    %xmm3, %xmm2, %xmm2
0x564bc522df33:  c4 e2 79 47 d9           vpsllvd  %xmm1, %xmm0, %xmm3
0x564bc522df38:  c4 e2 79 45 c2           vpsrlvd  %xmm2, %xmm0, %xmm0
0x564bc522df3d:  c5 fa 7e 25 63 00 00 00  vmovq    0x63(%rip), %xmm4
0x564bc522df45:  c5 d9 66 c9              vpcmpgtd %xmm1, %xmm4, %xmm1
0x564bc522df49:  c5 d9 66 d2              vpcmpgtd %xmm2, %xmm4, %xmm2
0x564bc522df4d:  c5 e1 db c9              vpand    %xmm1, %xmm3, %xmm1
0x564bc522df51:  c5 f9 db c2              vpand    %xmm2, %xmm0, %xmm0
0x564bc522df55:  c5 f1 eb c0              vpor     %xmm0, %xmm1, %xmm0

0xaaaac8a29414:  6ea0b822  neg      v2.4s, v1.4s
0xaaaac8a29418:  6f00e623  movi     v3.2d, #0x0000ff000000ff
0xaaaac8a2941c:  4e231c21  and      v1.16b, v1.16b, v3.16b
0xaaaac8a29420:  4e231c42  and      v2.16b, v2.16b, v3.16b
0xaaaac8a29424:  6ea14403  ushl     v3.4s, v0.4s, v1.4s
0xaaaac8a29428:  6ea0b844  neg      v4.4s, v2.4s
0xaaaac8a2942c:  6ea44400  ushl     v0.4s, v0.4s, v4.4s
0xaaaac8a29430:  4f010404  movi     v4.4s, #0x20
0xaaaac8a29434:  4ea13481  cmgt     v1.4s, v4.4s, v1.4s
0xaaaac8a29438:  4ea23482  cmgt     v2.4s, v4.4s, v2.4s
0xaaaac8a2943c:  4e211c61  and      v1.16b, v3.16b, v1.16b
0xaaaac8a29440:  4e221c00  and      v0.16b, v0.16b, v2.16b
0xaaaac8a29444:  4ea01c20  orr      v0.16b, v1.16b, v0.16b

SSHL:

0x55787414385b:  c5 e9 ef d2              vpxor    %xmm2, %xmm2, %xmm2
0x55787414385f:  c5 e9 fa d1              vpsubd   %xmm1, %xmm2, %xmm2
0x557874143863:  c4 e2 79 59 1d 7c 00 00  vpbroadcastq 0x7c(%rip), %xmm3
0x55787414386b:  00
0x55787414386c:  c5 f1 db cb              vpand    %xmm3, %xmm1, %xmm1
0x557874143870:  c5 e9 db d3              vpand    %xmm3, %xmm2, %xmm2
0x557874143874:  c4 e2 79 59 1d 7b 00 00  vpbroadcastq 0x7b(%rip), %xmm3
0x55787414387c:  00
0x55787414387d:  c4 e2 69 3b d3           vpminud  %xmm3, %xmm2, %xmm2
0x557874143882:  c5 f1 66 db              vpcmpgtd %xmm3, %xmm1, %xmm3
0x557874143886:  c4 e2 79 47 e1           vpsllvd  %xmm1, %xmm0, %xmm4
0x55787414388b:  c4 e2 79 46 c2           vpsravd  %xmm2, %xmm0, %xmm0
0x557874143890:  c5 e1 df d4              vpandn   %xmm4, %xmm3, %xmm2
0x557874143894:  c4 e2 79 59 1d 53 00 00  vpbroadcastq 0x53(%rip), %xmm3
0x55787414389c:  00
0x55787414389d:  c5 e1 66 c9              vpcmpgtd %xmm1, %xmm3, %xmm1
0x5578741438a1:  c4 e3 79 4c c2 10        vpblendvb %xmm1, %xmm2, %xmm0, %xmm0

0xaaaab5996414:  6ea0b822  neg      v2.4s, v1.4s
0xaaaab5996418:  6f00e623  movi     v3.2d, #0x0000ff000000ff
0xaaaab599641c:  4e231c21  and      v1.16b, v1.16b, v3.16b
0xaaaab5996420:  4e231c42  and      v2.16b, v2.16b, v3.16b
0xaaaab5996424:  4f0007e3  movi     v3.4s, #0x1f
0xaaaab5996428:  6ea36c42  umin     v2.4s, v2.4s, v3.4s
0xaaaab599642c:  4ea33423  cmgt     v3.4s, v1.4s, v3.4s
0xaaaab5996430:  6ea14404  ushl     v4.4s, v0.4s, v1.4s
0xaaaab5996434:  6ea0b842  neg      v2.4s, v2.4s
0xaaaab5996438:  4ea24400  sshl     v0.4s, v0.4s, v2.4s
0xaaaab599643c:  4e631c82  bic      v2.16b, v4.16b, v3.16b
0xaaaab5996440:  4f040403  movi     v3.4s, #0x80
0xaaaab5996444:  4ea13461  cmgt     v1.4s, v3.4s, v1.4s
0xaaaab5996448:  6ea11c40  bit      v0.16b, v2.16b, v1.16b


r~

---
 target/arm/helper.h        |  11 +-
 target/arm/translate.h     |   6 +
 target/arm/neon_helper.c   |  33 ----
 target/arm/translate-a64.c |  18 +--
 target/arm/translate.c     | 300 +++++++++++++++++++++++++++++++++++--
 target/arm/vec_helper.c    |  88 +++++++++++
 6 files changed, 390 insertions(+), 66 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 132aa1682e..1ab0fe597a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -297,14 +297,8 @@ DEF_HELPER_2(neon_abd_s16, i32, i32, i32)
 DEF_HELPER_2(neon_abd_u32, i32, i32, i32)
 DEF_HELPER_2(neon_abd_s32, i32, i32, i32)
 
-DEF_HELPER_2(neon_shl_u8, i32, i32, i32)
-DEF_HELPER_2(neon_shl_s8, i32, i32, i32)
 DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
 DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
-DEF_HELPER_2(neon_shl_u32, i32, i32, i32)
-DEF_HELPER_2(neon_shl_s32, i32, i32, i32)
-DEF_HELPER_2(neon_shl_u64, i64, i64, i64)
-DEF_HELPER_2(neon_shl_s64, i64, i64, i64)
 DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
 DEF_HELPER_2(neon_rshl_s8, i32, i32, i32)
 DEF_HELPER_2(neon_rshl_u16, i32, i32, i32)
@@ -691,6 +685,11 @@ DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 
+DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index dc06dce767..01ae454dcf 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -241,6 +241,8 @@ static inline void gen_ss_advance(DisasContext *s)
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
+extern const GVecGen3 sshl_op[4];
+extern const GVecGen3 ushl_op[4];
 extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
@@ -250,6 +252,10 @@ extern const GVecGen4 sqadd_op[4];
 extern const GVecGen4 uqsub_op[4];
 extern const GVecGen4 sqsub_op[4];
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 4259056723..c581ffb7d3 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -615,24 +615,9 @@ NEON_VOP(abd_u32, neon_u32, 1)
     } else { \
         dest = src1 << tmp; \
     }} while (0)
-NEON_VOP(shl_u8, neon_u8, 4)
 NEON_VOP(shl_u16, neon_u16, 2)
-NEON_VOP(shl_u32, neon_u32, 1)
 #undef NEON_FN
 
-uint64_t HELPER(neon_shl_u64)(uint64_t val, uint64_t shiftop)
-{
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 64 || shift <= -64) {
-        val = 0;
-    } else if (shift < 0) {
-        val >>= -shift;
-    } else {
-        val <<= shift;
-    }
-    return val;
-}
-
 #define NEON_FN(dest, src1, src2) do { \
     int8_t tmp; \
     tmp = (int8_t)src2; \
@@ -645,27 +630,9 @@ uint64_t HELPER(neon_shl_u64)(uint64_t val, uint64_t shiftop)
     } else { \
         dest = src1 << tmp; \
     }} while (0)
-NEON_VOP(shl_s8, neon_s8, 4)
 NEON_VOP(shl_s16, neon_s16, 2)
-NEON_VOP(shl_s32, neon_s32, 1)
 #undef NEON_FN
 
-uint64_t HELPER(neon_shl_s64)(uint64_t valop, uint64_t shiftop)
-{
-    int8_t shift = (int8_t)shiftop;
-    int64_t val = valop;
-    if (shift >= 64) {
-        val = 0;
-    } else if (shift <= -64) {
-        val >>= 63;
-    } else if (shift < 0) {
-        val >>= -shift;
-    } else {
-        val <<= shift;
-    }
-    return val;
-}
-
 #define NEON_FN(dest, src1, src2) do { \
     int8_t tmp; \
     tmp = (int8_t)src2; \
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d7d1ef088f..9a308db97e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8856,9 +8856,9 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         break;
     case 0x8: /* SSHL, USHL */
         if (u) {
-            gen_helper_neon_shl_u64(tcg_rd, tcg_rn, tcg_rm);
+            gen_ushl_i64(tcg_rd, tcg_rn, tcg_rm);
         } else {
-            gen_helper_neon_shl_s64(tcg_rd, tcg_rn, tcg_rm);
+            gen_sshl_i64(tcg_rd, tcg_rn, tcg_rm);
         }
         break;
     case 0x9: /* SQSHL, UQSHL */
@@ -11253,6 +11253,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                        is_q ? 16 : 8, vec_full_reg_size(s),
                        (u ? uqsub_op : sqsub_op) + size);
         return;
+    case 0x08: /* SSHL, USHL */
+        gen_gvec_op3(s, is_q, rd, rn, rm,
+                     u ? &ushl_op[size] : &sshl_op[size]);
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11368,16 +11372,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x8: /* SSHL, USHL */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_shl_s8, gen_helper_neon_shl_u8 },
-                    { gen_helper_neon_shl_s16, gen_helper_neon_shl_u16 },
-                    { gen_helper_neon_shl_s32, gen_helper_neon_shl_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x9: /* SQSHL, UQSHL */
             {
                 static NeonGenTwoOpEnvFn * const fns[3][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 83b4d858af..ed9cd1e590 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5374,13 +5374,13 @@ static inline void gen_neon_shift_narrow(int size, TCGv_i32 var, TCGv_i32 shift,
         if (u) {
             switch (size) {
             case 1: gen_helper_neon_shl_u16(var, var, shift); break;
-            case 2: gen_helper_neon_shl_u32(var, var, shift); break;
+            case 2: gen_ushl_i32(var, var, shift); break;
             default: abort();
             }
         } else {
             switch (size) {
             case 1: gen_helper_neon_shl_s16(var, var, shift); break;
-            case 2: gen_helper_neon_shl_s32(var, var, shift); break;
+            case 2: gen_sshl_i32(var, var, shift); break;
             default: abort();
             }
         }
@@ -6193,6 +6193,282 @@ const GVecGen3 cmtst_op[4] = {
       .vece = MO_64 },
 };
 
+void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 max = tcg_const_i32(32);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, b);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, a, lsh);
+    tcg_gen_shr_i32(rval, a, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, rsh, max, rval, d);
+
+    tcg_temp_free_i32(lval);
+    tcg_temp_free_i32(rval);
+    tcg_temp_free_i32(lsh);
+    tcg_temp_free_i32(rsh);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(max);
+}
+
+void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 max = tcg_const_i64(64);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, b);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, a, lsh);
+    tcg_gen_shr_i64(rval, a, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, rsh, max, rval, d);
+
+    tcg_temp_free_i64(lval);
+    tcg_temp_free_i64(rval);
+    tcg_temp_free_i64(lsh);
+    tcg_temp_free_i64(rsh);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(max);
+}
+
+static void gen_ushl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(d);
+    TCGv_vec rval = tcg_temp_new_vec_matching(d);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec msk, max;
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_neg_vec(vece, rsh, b);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, b);
+    } else {
+        msk = tcg_temp_new_vec_matching(d);
+        tcg_gen_dupi_vec(vece, msk, 0xff);
+        tcg_gen_and_vec(vece, lsh, b, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
+        tcg_temp_free_vec(msk);
+    }
+
+    /*
+     * Perform possibly out of range shifts, trusting that the operation
+     * does not trap.  Discard unused results after the fact.
+     */
+    tcg_gen_shlv_vec(vece, lval, a, lsh);
+    tcg_gen_shrv_vec(vece, rval, a, rsh);
+
+    max = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, max, 8 << vece);
+
+    /*
+     * The choice of LT (signed) and GEU (unsigned) are biased toward
+     * the instructions of the x86_64 host.  For MO_8, the whole byte
+     * is significant so we must use an unsigned compare; otherwise we
+     * have already masked to a byte and so a signed compare works.
+     * Other tcg hosts have a full set of comparisons and do not care.
+     */
+    if (vece == MO_8) {
+        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
+        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
+        tcg_gen_andc_vec(vece, lval, lval, lsh);
+        tcg_gen_andc_vec(vece, rval, rval, rsh);
+    } else {
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
+        tcg_gen_and_vec(vece, lval, lval, lsh);
+        tcg_gen_and_vec(vece, rval, rval, rsh);
+    }
+    tcg_gen_or_vec(vece, d, lval, rval);
+
+    tcg_temp_free_vec(max);
+    tcg_temp_free_vec(lval);
+    tcg_temp_free_vec(rval);
+    tcg_temp_free_vec(lsh);
+    tcg_temp_free_vec(rsh);
+}
+
+static const TCGOpcode ushl_list[] = {
+    INDEX_op_neg_vec, INDEX_op_shlv_vec,
+    INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
+};
+
+const GVecGen3 ushl_op[4] = {
+    { .fniv = gen_ushl_vec,
+      .fno = gen_helper_gvec_ushl_b,
+      .opt_opc = ushl_list,
+      .vece = MO_8 },
+    { .fniv = gen_ushl_vec,
+      .fno = gen_helper_gvec_ushl_h,
+      .opt_opc = ushl_list,
+      .vece = MO_16 },
+    { .fni4 = gen_ushl_i32,
+      .fniv = gen_ushl_vec,
+      .opt_opc = ushl_list,
+      .vece = MO_32 },
+    { .fni8 = gen_ushl_i64,
+      .fniv = gen_ushl_vec,
+      .opt_opc = ushl_list,
+      .vece = MO_64 },
+};
+
+void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 max = tcg_const_i32(31);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, b);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, a, lsh);
+    tcg_gen_umin_i32(rsh, rsh, max);
+    tcg_gen_sar_i32(rval, a, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LT, d, lsh, zero, rval, lval);
+
+    tcg_temp_free_i32(lval);
+    tcg_temp_free_i32(rval);
+    tcg_temp_free_i32(lsh);
+    tcg_temp_free_i32(rsh);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(max);
+}
+
+void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 max = tcg_const_i64(63);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, b);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, a, lsh);
+    tcg_gen_umin_i64(rsh, rsh, max);
+    tcg_gen_sar_i64(rval, a, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LT, d, lsh, zero, rval, lval);
+
+    tcg_temp_free_i64(lval);
+    tcg_temp_free_i64(rval);
+    tcg_temp_free_i64(lsh);
+    tcg_temp_free_i64(rsh);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(max);
+}
+
+static void gen_sshl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(d);
+    TCGv_vec rval = tcg_temp_new_vec_matching(d);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec tmp = tcg_temp_new_vec_matching(d);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_neg_vec(vece, rsh, b);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, b);
+    } else {
+        tcg_gen_dupi_vec(vece, tmp, 0xff);
+        tcg_gen_and_vec(vece, lsh, b, tmp);
+        tcg_gen_and_vec(vece, rsh, rsh, tmp);
+    }
+
+    /* Bound rsh so out of bound right shift gets -1.  */
+    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
+    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
+
+    tcg_gen_shlv_vec(vece, lval, a, lsh);
+    tcg_gen_sarv_vec(vece, rval, a, rsh);
+
+    /* Select in-bound left shift.  */
+    tcg_gen_andc_vec(vece, lval, lval, tmp);
+
+    /* Select between left and right shift.  */
+    if (vece == MO_8) {
+        tcg_gen_dupi_vec(vece, tmp, 0);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, d, lsh, tmp, rval, lval);
+    } else {
+        tcg_gen_dupi_vec(vece, tmp, 0x80);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, d, lsh, tmp, lval, rval);
+    }
+
+    tcg_temp_free_vec(lval);
+    tcg_temp_free_vec(rval);
+    tcg_temp_free_vec(lsh);
+    tcg_temp_free_vec(rsh);
+    tcg_temp_free_vec(tmp);
+}
+
+static const TCGOpcode sshl_list[] = {
+    INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
+    INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
+};
+
+const GVecGen3 sshl_op[4] = {
+    { .fniv = gen_sshl_vec,
+      .fno = gen_helper_gvec_sshl_b,
+      .opt_opc = sshl_list,
+      .vece = MO_8 },
+    { .fniv = gen_sshl_vec,
+      .fno = gen_helper_gvec_sshl_h,
+      .opt_opc = sshl_list,
+      .vece = MO_16 },
+    { .fni4 = gen_sshl_i32,
+      .fniv = gen_sshl_vec,
+      .opt_opc = sshl_list,
+      .vece = MO_32 },
+    { .fni8 = gen_sshl_i64,
+      .fniv = gen_sshl_vec,
+      .opt_opc = sshl_list,
+      .vece = MO_64 },
+};
+
 static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -6596,6 +6872,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                   vec_size, vec_size);
             }
             return 0;
+
+        case NEON_3R_VSHL:
+            tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
+                           u ? &ushl_op[size] : &sshl_op[size]);
+            return 0;
         }
 
         if (size == 3) {
@@ -6604,13 +6885,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 neon_load_reg64(cpu_V0, rn + pass);
                 neon_load_reg64(cpu_V1, rm + pass);
                 switch (op) {
-                case NEON_3R_VSHL:
-                    if (u) {
-                        gen_helper_neon_shl_u64(cpu_V0, cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_shl_s64(cpu_V0, cpu_V1, cpu_V0);
-                    }
-                    break;
                 case NEON_3R_VQSHL:
                     if (u) {
                         gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
@@ -6645,7 +6919,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VSHL:
         case NEON_3R_VQSHL:
         case NEON_3R_VRSHL:
         case NEON_3R_VQRSHL:
@@ -6725,9 +6998,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VHSUB:
             GEN_NEON_INTEGER_OP(hsub);
             break;
-        case NEON_3R_VSHL:
-            GEN_NEON_INTEGER_OP(shl);
-            break;
         case NEON_3R_VQSHL:
             GEN_NEON_INTEGER_OP_ENV(qshl);
             break;
@@ -7136,9 +7406,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                         } else {
                             if (input_unsigned) {
-                                gen_helper_neon_shl_u64(cpu_V0, in, tmp64);
+                                gen_ushl_i64(cpu_V0, in, tmp64);
                             } else {
-                                gen_helper_neon_shl_s64(cpu_V0, in, tmp64);
+                                gen_sshl_i64(cpu_V0, in, tmp64);
                             }
                         }
                         tmp = tcg_temp_new_i32();
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index dedef62403..fcb3663903 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1046,3 +1046,91 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
+
+void HELPER(gvec_sshl_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        int8_t mm = m[i];
+        int8_t nn = n[i];
+        int8_t res = 0;
+        if (mm >= 0) {
+            if (mm < 8) {
+                res = nn << mm;
+            }
+        } else {
+            res = nn >> (mm > -8 ? -mm : 7);
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sshl_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        int16_t nn = n[i];
+        int16_t res = 0;
+        if (mm >= 0) {
+            if (mm < 16) {
+                res = nn << mm;
+            }
+        } else {
+            res = nn >> (mm > -16 ? -mm : 15);
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ushl_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        int8_t mm = m[i];
+        uint8_t nn = n[i];
+        uint8_t res = 0;
+        if (mm >= 0) {
+            if (mm < 8) {
+                res = nn << mm;
+            }
+        } else {
+            if (mm > -8) {
+                res = nn >> -mm;
+            }
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ushl_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        uint16_t nn = n[i];
+        uint16_t res = 0;
+        if (mm >= 0) {
+            if (mm < 16) {
+                res = nn << mm;
+            }
+        } else {
+            if (mm > -16) {
+                res = nn >> -mm;
+            }
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.17.1


