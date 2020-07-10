Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7813AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F1C2077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U4Xxe1oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F1C2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsok-0003Qr-Da
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcl-00056N-IU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:23 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcj-0006Xu-0J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id k27so2376457pgm.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/rldlRV0Ju7ecAcYGvhu7TjDF36DgLEmoYyxAEMea3o=;
 b=U4Xxe1oWbFVRadI1nQ1VydDb981vHLm3v5EkFx3HUFDszj0TEiUeTMDSqPgv4PNgxv
 Breu0MRqSe2ZYTv0v9gl68WWyoGsvbaIPqg94egN9dZQj7h0hgg5wJ/wUP7Hx3UTjX/k
 7k7hsw4wKaSVMgiVa+KbSHZ+C68paXT9scwN3pTwLfP9r/ToAmypTFrhJBUrXg0UeLC/
 8h/4JOH6k34EV7YMeHqyAWUaqzwJLywvrcf9vSO4FU/j2NNBrlZ/3YzWUy21Yae2FGgZ
 eIg3kKy92NY9t3ayBBECvd8cC4QUk6x7MYh8jtnlizhA5IV8FPQ8NfxP7hpEL1re1ppw
 yemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/rldlRV0Ju7ecAcYGvhu7TjDF36DgLEmoYyxAEMea3o=;
 b=tB0cYrjWC4wNWXpRVWG4/oZXeVlO/pgUTb+y8xomDaDLEPR8nDRx31vN1+EBAInQ0o
 HDZO+iB+IO+Yv0xdHfWk74rD+0ujwoYNxZMh6apcZY/0bpdZr7hWlMps3U07g5hhfkDo
 v8bmZJV/rp5XG3KyuHtvX1Udb1CKVd/SAba/eADPJxu0DUaae5JLTekAcaxNosG0btHI
 a2xM+/YGspixPP9FHwlCx+ik6GjdwR+pl0fVhBLEnNYgIsHFGq7xOA3yd/dYlCsqkDE1
 kgRNBJJUDGBF6k4TLcCpbMzu43JaxKxSgUjTBu/e+WSBuSSgEIsqojzRAyTuq7FPcnaY
 q74A==
X-Gm-Message-State: AOAM532UpX3Nej7tGP+2d+AIcdbuOwQrbyBzMijKhK5MohQw3DnSPrZk
 UUd26Hq4pre52T5jTvMtu9v/Mjk5HvyPEA==
X-Google-Smtp-Source: ABdhPJxcY01tSdlclxZMkK7hvPH3qOn9lO5fT4tojCDakhdZ73QwzcwQND8tHjsswBUaYHQrsHUp/w==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr56230397pgk.434.1594378279184; 
 Fri, 10 Jul 2020 03:51:19 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:51:18 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 12/65] target/riscv: rvv-0.9: update check functions
Date: Fri, 10 Jul 2020 18:48:26 +0800
Message-Id: <20200710104920.13550-13-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 507 ++++++++++++++----------
 1 file changed, 308 insertions(+), 199 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1cc58c86b2..fc1908389e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -19,6 +19,59 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 
+#define NVPR    32
+
+#define require(x) if (unlikely(!(x))) { return false; }
+#define require_align(val, pos) require(is_aligned(val, pos))
+
+/* Destination vector register group cannot overlap source mask register. */
+#define require_vm(vm, rd) do { if (vm == 0) require(rd != 0); } while (0)
+
+#define require_noover(astart, asize, bstart, bsize) \
+  require(!is_overlapped(astart, asize, bstart, bsize))
+#define require_noover_widen(astart, asize, bstart, bsize) \
+  require(!is_overlapped_widen(astart, asize, bstart, bsize))
+
+#define REQUIRE_RVV do {    \
+    if (s->mstatus_vs == 0) \
+        return false;       \
+} while (0)
+
+static inline bool is_aligned(const unsigned val, const unsigned pos)
+{
+    return pos ? (val & (pos - 1)) == 0 : true;
+}
+
+static inline bool is_overlapped(const int astart, int asize,
+                                 const int bstart, int bsize)
+{
+    asize = asize == 0 ? 1 : asize;
+    bsize = bsize == 0 ? 1 : bsize;
+
+    const int aend = astart + asize;
+    const int bend = bstart + bsize;
+
+    return MAX(aend, bend) - MIN(astart, bstart) < asize + bsize;
+}
+
+static inline bool is_overlapped_widen(const int astart, int asize,
+                                       const int bstart, int bsize)
+{
+    asize = asize == 0 ? 1 : asize;
+    bsize = bsize == 0 ? 1 : bsize;
+
+    const int aend = astart + asize;
+    const int bend = bstart + bsize;
+
+    if (astart < bstart &&
+        is_overlapped(astart, asize, bstart, bsize) &&
+        !is_overlapped(astart, asize, bstart + bsize, bsize)) {
+        return false;
+    } else  {
+        return MAX(aend, bend) - MIN(astart, bstart) < asize + bsize;
+    }
+}
+
 static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
 {
     TCGv s1, s2, dst;
@@ -103,29 +156,121 @@ static bool vext_check_isa_ill(DisasContext *s)
 }
 
 /*
- * There are two rules check here.
+ * Check function for vector instruction with format:
+ * single-width result and single-width sources (SEW = SEW op SEW)
+ *
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
+ */
+#define VEXT_CHECK_SSS(s, rd, rs1, rs2, vm, is_vs1) do { \
+    require_vm(vm, rd);                                  \
+    if (s->flmul > 1) {                                  \
+        require_align(rd, s->flmul);                     \
+        require_align(rs2, s->flmul);                    \
+        if (is_vs1) {                                    \
+            require_align(rs1, s->flmul);                \
+        }                                                \
+    }                                                    \
+} while (0)
+
+/*
+ * Check function for maskable vector instruction with format:
+ * single-width result and single-width sources (SEW = SEW op SEW)
  *
- * 1. Vector register numbers are multiples of LMUL. (Section 3.2)
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
+ */
+#define VEXT_CHECK_MSS(s, rd, rs1, rs2, is_vs1) do { \
+    if (rd != rs2) {                                 \
+        require_noover(rd, 1, rs2, s->flmul);        \
+    }                                                \
+    require_align(rs2, s->flmul);                    \
+    if (is_vs1) {                                    \
+        if (rd != rs1) {                             \
+            require_noover(rd, 1, rs1, s->flmul);    \
+        }                                            \
+        require_align(rs1, s->flmul);                \
+    }                                                \
+} while (0)
+
+/* Common check function for vector widening instructions */
+#define VEXT_WIDE_CHECK_COMMON(s, rd, vm) do { \
+    require(s->flmul <= 4);                    \
+    require(s->sew < 3);                       \
+    require_align(rd, s->flmul * 2);           \
+    require_vm(vm, rd);                        \
+} while (0)
+
+/* Common check function for vector narrowing instructions */
+#define VEXT_NARROW_CHECK_COMMON(s, rd, rs2, vm) do { \
+    require(s->flmul <= 4);                           \
+    require(s->sew < 3);                              \
+    require_align(rs2, s->flmul * 2);                 \
+    require_align(rd, s->flmul);                      \
+    require_vm(vm, rd);                               \
+} while (0)
+
+/*
+ * Check function for vector instruction with format:
+ * double-width result and single-width sources (2*SEW = SEW op SEW)
  *
- * 2. For all widening instructions, the destination LMUL value must also be
- *    a supported LMUL value. (Section 11.2)
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
  */
-static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
-{
-    /*
-     * The destination vector register group results are arranged as if both
-     * SEW and LMUL were at twice their current settings. (Section 11.2).
-     */
-    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
+#define VEXT_CHECK_DSS(s, rd, rs1, rs2, vm, is_vs1) do {           \
+    VEXT_WIDE_CHECK_COMMON(s, rd, vm);                             \
+    require_align(rs2, s->flmul);                                  \
+    if (s->flmul < 1) {                                            \
+        require_noover(rd, s->flmul * 2, rs2, s->flmul);           \
+    } else {                                                       \
+        require_noover_widen(rd, s->flmul * 2, rs2, s->flmul);     \
+    }                                                              \
+    if (is_vs1) {                                                  \
+        require_align(rs1, s->flmul);                              \
+        if (s->flmul < 1) {                                        \
+            require_noover(rd, s->flmul * 2, rs1, s->flmul);       \
+        } else {                                                   \
+            require_noover_widen(rd, s->flmul * 2, rs1, s->flmul); \
+        }                                                          \
+    }                                                              \
+} while (0)
 
-    return !((s->lmul == 0x3 && widen) || (reg % legal));
-}
+/*
+ * Check function for vector instruction with format:
+ * double-width result and double-width source1 and single-width
+ * source2 (2*SEW = 2*SEW op SEW)
+ *
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
+ */
+#define VEXT_CHECK_DDS(s, rd, rs1, rs2, vm, is_vs1) do {           \
+    VEXT_WIDE_CHECK_COMMON(s, rd, vm);                             \
+    require_align(rs2, s->flmul * 2);                              \
+    if (is_vs1) {                                                  \
+        require_align(rs1, s->flmul);                              \
+        if (s->flmul < 1) {                                        \
+            require_noover(rd, s->flmul * 2, rs1, s->flmul);       \
+        } else {                                                   \
+            require_noover_widen(rd, s->flmul * 2, rs1, s->flmul); \
+        }                                                          \
+    }                                                              \
+} while (0)
 
 /*
- * There are two rules check here.
+ * Check function for vector instruction with format:
+ * single-width result and double-width source1 and single-width
+ * source2 (SEW = 2*SEW op SEW)
  *
- * 1. The destination vector register group for a masked vector instruction can
- *    only overlap the source mask register (v0) when LMUL=1. (Section 5.3)
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
+ */
+#define VEXT_CHECK_SDS(s, rd, rs1, rs2, vm, is_vs1) do { \
+    VEXT_NARROW_CHECK_COMMON(s, rd, rs2, vm);            \
+    if (rd != rs2) {                                     \
+        require_noover(rd, s->flmul, rs2, s->flmul * 2); \
+    }                                                    \
+    if (is_vs1) {                                        \
+        require_align(rs1, s->flmul);                    \
+    }                                                    \
+} while (0)
+
+/*
+ * Check function for vector reduction instructions
  *
  * 2. In widen instructions and some other insturctions, like vslideup.vx,
  *    there is no need to check whether LMUL=1.
@@ -136,20 +281,14 @@ static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
     return (vm != 0 || vd != 0) || (!force && (s->lmul == 0));
 }
 
-/* The LMUL setting must be such that LMUL * NFIELDS <= 8. (Section 7.8) */
-static bool vext_check_nf(DisasContext *s, uint32_t nf)
-{
-    return (1 << s->lmul) * nf <= 8;
-}
-
 /*
- * The destination vector register group cannot overlap a source vector register
- * group of a different element width. (Section 11.2)
+ * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
+ * So RVV is also be checked in this function.
  */
-static inline bool vext_check_overlap_group(int rd, int dlen, int rs, int slen)
-{
-    return ((rd >= rs + slen) || (rs >= rd + dlen));
-}
+#define VEXT_CHECK_ISA_ILL(s) do { \
+    require(!s->vill)              \
+} while (0)
+
 /* common translation macro */
 #define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
 static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
@@ -824,11 +963,10 @@ GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    return true;
 }
 
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
@@ -922,10 +1060,10 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
 static bool opivx_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    return true;
 }
 
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t, TCGv_i64,
@@ -1129,16 +1267,10 @@ GEN_OPIVI_GVEC_TRANS(vrsub_vi, 0, vrsub_vx, rsubi)
 /* OPIVV with WIDEN */
 static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
-                                     1 << s->lmul) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DSS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    return true;
 }
 
 static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
@@ -1185,13 +1317,10 @@ GEN_OPIVV_WIDEN_TRANS(vwsub_vv, opivv_widen_check)
 /* OPIVX with WIDEN */
 static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DSS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    return true;
 }
 
 static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
@@ -1222,14 +1351,10 @@ GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
 /* WIDEN OPIVV with WIDEN */
 static bool opiwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DDS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    return true;
 }
 
 static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
@@ -1274,11 +1399,10 @@ GEN_OPIWV_WIDEN_TRANS(vwsub_wv)
 /* WIDEN OPIVX with WIDEN */
 static bool opiwx_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DDS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    return true;
 }
 
 static bool do_opiwx_widen(DisasContext *s, arg_rmrr *a,
@@ -1341,11 +1465,11 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
  */
 static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            ((a->rd != 0) || (s->lmul == 0)));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require(a->rd != 0);
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    return true;
 }
 
 GEN_OPIVV_TRANS(vadc_vvm, opivv_vadc_check)
@@ -1357,11 +1481,10 @@ GEN_OPIVV_TRANS(vsbc_vvm, opivv_vadc_check)
  */
 static bool opivv_vmadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
-            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_MSS(s, a->rd, a->rs1, a->rs2, true);
+    return true;
 }
 
 GEN_OPIVV_TRANS(vmadc_vvm, opivv_vmadc_check)
@@ -1369,10 +1492,11 @@ GEN_OPIVV_TRANS(vmsbc_vvm, opivv_vmadc_check)
 
 static bool opivx_vadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            ((a->rd != 0) || (s->lmul == 0)));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require(a->rd != 0);
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    return true;
 }
 
 /* OPIVX without GVEC IR */
@@ -1395,9 +1519,10 @@ GEN_OPIVX_TRANS(vsbc_vxm, opivx_vadc_check)
 
 static bool opivx_vmadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_MSS(s, a->rd, a->rs1, a->rs2, false);
+    return true;
 }
 
 GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
@@ -1488,14 +1613,10 @@ GEN_OPIVI_TRANS(vsra_vi, 1, vsra_vx, opivx_check)
 /* Vector Narrowing Integer Right Shift Instructions */
 static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, true) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
-                2 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SDS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    return true;
 }
 
 /* OPIVV with NARROW */
@@ -1531,13 +1652,10 @@ GEN_OPIVV_NARROW_TRANS(vnsrl_vv)
 
 static bool opivx_narrow_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, true) &&
-            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
-                2 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SDS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    return true;
 }
 
 /* OPIVX with NARROW */
@@ -1585,13 +1703,12 @@ GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
  */
 static bool opivv_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
-              vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
-             (s->lmul == 0)));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_MSS(s, a->rd, a->rs1, a->rs2, true);
+    return true;
 }
+
 GEN_OPIVV_TRANS(vmseq_vv, opivv_cmp_check)
 GEN_OPIVV_TRANS(vmsne_vv, opivv_cmp_check)
 GEN_OPIVV_TRANS(vmsltu_vv, opivv_cmp_check)
@@ -1601,10 +1718,10 @@ GEN_OPIVV_TRANS(vmsle_vv, opivv_cmp_check)
 
 static bool opivx_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
-             (s->lmul == 0)));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_MSS(s, a->rd, a->rs1, a->rs2, false);
+    return true;
 }
 
 GEN_OPIVX_TRANS(vmseq_vx, opivx_cmp_check)
@@ -1863,12 +1980,11 @@ GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
  */
 static bool opfvv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    require(s->sew != 0);
+    return true;
 }
 
 /* OPFVV without GVEC IR */
@@ -1934,17 +2050,17 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     return true;
 }
 
-static bool opfvf_check(DisasContext *s, arg_rmrr *a)
-{
 /*
  * If the current SEW does not correspond to a supported IEEE floating-point
  * type, an illegal instruction exception is raised
  */
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0));
+static bool opfvf_check(DisasContext *s, arg_rmrr *a)
+{
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    require(s->sew != 0);
+    return true;
 }
 
 /* OPFVF without GVEC IR */
@@ -1976,16 +2092,11 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
 /* Vector Widening Floating-Point Add/Subtract Instructions */
 static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
-                                     1 << s->lmul) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DSS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    require(s->sew != 0);
+    return true;
 }
 
 /* OPFVV with WIDEN */
@@ -2021,13 +2132,11 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
 
 static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DSS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    require(s->sew != 0);
+    return true;
 }
 
 /* OPFVF with WIDEN */
@@ -2055,14 +2164,11 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
 
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DDS(s, a->rd, a->rs1, a->rs2, a->vm, true);
+    require(s->sew != 0);
+    return true;
 }
 
 /* WIDEN OPFVV with WIDEN */
@@ -2098,11 +2204,11 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
 
 static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_DDS(s, a->rd, a->rs1, a->rs2, a->vm, false);
+    require(s->sew != 0);
+    return true;
 }
 
 /* WIDEN OPFVF with WIDEN */
@@ -2175,11 +2281,12 @@ GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
  */
 static bool opfv_check(DisasContext *s, arg_rmr *a)
 {
-   return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* OPFV instructions ignore vs1 check */
+    VEXT_CHECK_SSS(s, a->rd, 0, a->rs2, a->vm, false);
+    require(s->sew != 0);
+    return true;
 }
 
 #define GEN_OPFV_TRANS(NAME, CHECK)                                \
@@ -2229,13 +2336,11 @@ GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
 /* Vector Floating-Point Compare Instructions */
 static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            (s->sew != 0) &&
-            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
-              vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
-             (s->lmul == 0)));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_MSS(s, a->rd, a->rs1, a->rs2, true);
+    require(s->sew != 0);
+    return true;
 }
 
 GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
@@ -2246,11 +2351,11 @@ GEN_OPFVV_TRANS(vmford_vv, opfvv_cmp_check)
 
 static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0) &&
-            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
-             (s->lmul == 0)));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_MSS(s, a->rd, a->rs1, a->rs2, false);
+    require(s->sew != 0);
+    return true;
 }
 
 GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
@@ -2316,13 +2421,12 @@ GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
  */
 static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* OPFV widening instructions ignore vs1 check */
+    VEXT_CHECK_DSS(s, a->rd, 0, a->rs2, a->vm, false);
+    require(s->sew != 0);
+    return true;
 }
 
 #define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
@@ -2366,13 +2470,12 @@ GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
  */
 static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, true) &&
-            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
-                                     2 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* OPFV narrowing instructions ignore vs1 check */
+    VEXT_CHECK_SDS(s, a->rd, 0, a->rs2, a->vm, false);
+    require(s->sew != 0);
+    return true;
 }
 
 #define GEN_OPFV_NARROW_TRANS(NAME)                                \
@@ -2865,23 +2968,27 @@ GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (a->rd != a->rs2) && (a->rd != a->rs1));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require_align(a->rd, s->flmul);
+    require_align(a->rs1, s->flmul);
+    require_align(a->rs2, s->flmul);
+    require(a->rd != a->rs2 && a->rd != a->rs1);
+    require_vm(a->vm, a->rd);
+    return true;
 }
 
 GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
 
 static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (a->rd != a->rs2));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require_align(a->rd, s->flmul);
+    require_align(a->rs2, s->flmul);
+    require(a->rd != a->rs2);
+    require_vm(a->vm, a->rd);
+    return true;
 }
 
 /* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -2945,11 +3052,13 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
 /* Vector Compress Instruction */
 static bool vcompress_vm_check(DisasContext *s, arg_r *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs1, 1) &&
-            (a->rd != a->rs2));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require_align(a->rd, s->flmul);
+    require_align(a->rs2, s->flmul);
+    require(a->rd != a->rs2);
+    require_noover(a->rd, s->flmul, a->rs1, 1);
+    return true;
 }
 
 static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
-- 
2.17.1


