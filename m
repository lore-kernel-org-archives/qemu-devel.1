Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDEFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C27207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A4hwZBTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C27207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLAF-0001or-NT
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwy-0003ak-KF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwu-0001zK-Hj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:08 -0400
Received: by mail-pf1-x441.google.com with SMTP id n14so5522367pff.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kxfuJrIbuG10T9aWdxImSmUgxoRODYSu5Pl03SC7gB4=;
 b=A4hwZBTwI8OJXMdxskYoH45QXSJ8jcssGhk/DgcovzTOjVhpce+yJZhrWWjk69iEkz
 l+MTeWdnd/xRzDD3ylJAAdRrzoVdb9KuIdHoJthv1Ca/HVgQPbtJ9ImSvStRuw2Ro3x4
 k6uNK8httvhkhwR4Tlvhxw2Tzwd7q3PsTcBP5r5hcyCAs0MEgAAE6ezQXOWzlmXCiiL1
 r7r8ZLZdu1ikakxHXSpinjENxOtQHFSnq6SAeTCpQDj1xtLVbvSJdMKPVqJxhRcdBE2v
 z6mjnRLz0FYbEuOjIf2eiYLpgbUHqkdzjoZDPvG7L8R7vMfuP3+RL9lAYLHZyLnmX4Ht
 TCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kxfuJrIbuG10T9aWdxImSmUgxoRODYSu5Pl03SC7gB4=;
 b=ELuqW0LvSSPYdTsVmLi9Ch2YNJHfF4C+ckVJLsEdeR7tVcLVKYPO3B+y5gpG0bVotf
 2e0/bgch3y/EVai38wZDBx+pUTZYBq8NtxOyKMMEES+KC3ekqNQ3GO1poxdiuLXH+eTH
 F7+fkspwDC6uyFcG8kg4LAPL6XibP6t20j3sSOkKpEr3TpX1B8CR+VXJRiZ0EWFclEwg
 IXzQ9K0fR3o4Xqnp64UYIe/6PiaGE2REM5WWSCczrpKPLQHuy+fUx5xt4CVQOyryeMKb
 ZbKblBPDUTECnz3P9zRtFrQQhb7M/Nnf4qnNelxwDxoIz6esC9PQ8cyASNo2Zb7LrWfP
 Y7gQ==
X-Gm-Message-State: AOAM533ugSTTiKDbwfL13xVScbr9dzlI9a8SAjjNxl6YoAs0V33zYZ0w
 t2WGVF12Nos29Go4iChIuLDJhzLR+Scm6A==
X-Google-Smtp-Source: ABdhPJyHoD9y6E151iFwgw51pHwoalo/3I/gnECx4gcjmJFOPGH/PQj1QcuXti02seJ+uhShxUMXDg==
X-Received: by 2002:a63:703:: with SMTP id 3mr4354211pgh.159.1601406362319;
 Tue, 29 Sep 2020 12:06:02 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:06:01 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 14/68] target/riscv: rvv-1.0: update check functions
Date: Wed, 30 Sep 2020 03:03:49 +0800
Message-Id: <20200929190448.31116-15-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update check functions with RVV 1.0 rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 735 ++++++++++++++++--------
 1 file changed, 502 insertions(+), 233 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d32ce2b3de..91a08d4faf 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -19,11 +19,124 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 
+static inline bool is_overlapped(const int8_t astart, int8_t asize,
+                                 const int8_t bstart, int8_t bsize)
+{
+    const int8_t aend = astart + asize;
+    const int8_t bend = bstart + bsize;
+
+    return MAX(aend, bend) - MIN(astart, bstart) < asize + bsize;
+}
+
+static bool require_rvv(DisasContext *s)
+{
+    return s->mstatus_vs != 0;
+}
+
+static bool require_rvf(DisasContext *s)
+{
+    if (s->mstatus_fs == 0) {
+        return false;
+    }
+
+    switch (s->sew) {
+    case MO_16:
+    case MO_32:
+        return has_ext(s, RVF);
+    case MO_64:
+        return has_ext(s, RVD);
+    default:
+        return false;
+    }
+}
+
+static bool require_scale_rvf(DisasContext *s)
+{
+    if (s->mstatus_fs == 0) {
+        return false;
+    }
+
+    switch (s->sew) {
+    case MO_8:
+    case MO_16:
+        return has_ext(s, RVF);
+    case MO_32:
+        return has_ext(s, RVD);
+    default:
+        return false;
+    }
+}
+
+/* Destination vector register group cannot overlap source mask register. */
+static bool require_vm(int vm, int vd)
+{
+    return (vm != 0 || vd != 0);
+}
+
+static bool require_nf(int vd, int nf, int lmul)
+{
+    int size = nf << MAX(lmul, 0);
+    return size <= 8 && vd + size <= 32;
+}
+
+/*
+ * Vector register should aligned with the passed-in LMUL (EMUL).
+ * If LMUL < 0, i.e. fractional LMUL, any vector register is allowed.
+ */
+static bool require_align(const int8_t val, const int8_t lmul)
+{
+    return lmul <= 0 || extract32(val, 0, lmul) == 0;
+}
+
+/*
+ * A destination vector register group can overlap a source vector
+ * register group only if one of the following holds:
+ *  1. The destination EEW equals the source EEW.
+ *  2. The destination EEW is smaller than the source EEW and the overlap
+ *     is in the lowest-numbered part of the source register group.
+ *  3. The destination EEW is greater than the source EEW, the source EMUL
+ *     is at least 1, and the overlap is in the highest-numbered part of
+ *     the destination register group.
+ * (Section 5.2)
+ *
+ * This function returns true if one of the following holds:
+ *  * Destination vector register group does not overlap a source vector
+ *    register group.
+ *  * Rule 3 met.
+ * For rule 1, overlap is allowed so this function doesn't need to be called.
+ * For rule 2, (vd == vs). Caller has to check whether: (vd != vs) before
+ * calling this function.
+ */
+static bool require_noover(const int8_t dst, const int8_t dst_lmul,
+                           const int8_t src, const int8_t src_lmul)
+{
+    int8_t dst_size = dst_lmul <= 0 ? 1 : 1 << dst_lmul;
+    int8_t src_size = src_lmul <= 0 ? 1 : 1 << src_lmul;
+
+    /* Destination EEW is greater than the source EEW, check rule 3. */
+    if (dst_size > src_size) {
+        if (dst < src &&
+            src_lmul >= 0 &&
+            is_overlapped(dst, dst_size, src, src_size) &&
+            !is_overlapped(dst, dst_size, src + src_size, src_size)) {
+            return true;
+        }
+    }
+
+    return !is_overlapped(dst, dst_size, src, src_size);
+}
+
+static bool require_noover_seg(const int8_t dst, const int8_t nf,
+                               const int8_t src)
+{
+    return !is_overlapped(dst, nf, src, 1);
+}
+
 static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
 {
     TCGv s1, s2, dst;
 
-    if (!has_ext(ctx, RVV)) {
+    if (!require_rvv(ctx) || !has_ext(ctx, RVV)) {
         return false;
     }
 
@@ -56,7 +169,7 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
 {
     TCGv s1, s2, dst;
 
-    if (!has_ext(ctx, RVV)) {
+    if (!require_rvv(ctx) || !has_ext(ctx, RVV)) {
         return false;
     }
 
@@ -99,54 +212,248 @@ static bool vext_check_isa_ill(DisasContext *s)
     return !s->vill;
 }
 
+static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
+{
+    return require_vm(vm, vd) &&
+        require_align(vd, s->lmul) &&
+        require_align(vs, s->lmul);
+}
+
 /*
- * There are two rules check here.
+ * Check function for vector instruction with format:
+ * single-width result and single-width sources (SEW = SEW op SEW)
  *
- * 1. Vector register numbers are multiples of LMUL. (Section 3.2)
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
  *
- * 2. For all widening instructions, the destination LMUL value must also be
- *    a supported LMUL value. (Section 11.2)
+ * Rules to be checked here:
+ *   1. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 5.3)
+ *   2. Destination vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ *   3. Source (vs2, vs1) vector register number are multiples of LMUL.
+ *      (Section 3.3.2)
  */
-static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
+static bool vext_check_sss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
-    /*
-     * The destination vector register group results are arranged as if both
-     * SEW and LMUL were at twice their current settings. (Section 11.2).
-     */
-    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
+    return vext_check_ss(s, vd, vs2, vm) &&
+        require_align(vs1, s->lmul);
+}
 
-    return !((s->lmul == 0x3 && widen) || (reg % legal));
+static bool vext_check_ms(DisasContext *s, int vd, int vs)
+{
+    bool ret = require_align(vs, s->lmul);
+    if (vd != vs) {
+        ret &= require_noover(vd, 0, vs, s->lmul);
+    }
+    return ret;
 }
 
 /*
- * There are two rules check here.
+ * Check function for maskable vector instruction with format:
+ * single-width result and single-width sources (SEW = SEW op SEW)
+ *
+ * Rules to be checked here:
+ *   1. Source (vs2, vs1) vector register number are multiples of LMUL.
+ *      (Section 3.3.2)
+ *   2. Destination vector register cannot overlap a source vector
+ *      register (vs2, vs1) group.
+ *      (Section 5.2)
+ *   3. The destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0),
+ *      unless the destination vector register is being written
+ *      with a mask value (e.g., comparisons) or the scalar result
+ *      of a reduction. (Section 5.3)
+ */
+static bool vext_check_mss(DisasContext *s, int vd, int vs1, int vs2)
+{
+    bool ret = vext_check_ms(s, vd, vs2) &&
+        require_align(vs1, s->lmul);
+    if (vd != vs1) {
+        ret &= require_noover(vd, 0, vs1, s->lmul);
+    }
+    return ret;
+}
+
+/*
+ * Common check function for vector widening instructions
+ * of double-width result (2*SEW).
  *
- * 1. The destination vector register group for a masked vector instruction can
- *    only overlap the source mask register (v0) when LMUL=1. (Section 5.3)
+ * Rules to be checked here:
+ *   1. The largest vector register group used by an instruction
+ *      can not be greater than 8 vector registers (Section 5.2):
+ *      => LMUL < 8.
+ *      => SEW < 64.
+ *   2. Destination vector register number is multiples of 2 * LMUL.
+ *      (Section 3.3.2, 11.2)
+ *   3. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 5.3)
+ */
+static bool vext_wide_check_common(DisasContext *s, int vd, int vm)
+{
+    return (s->lmul <= 2) &&
+           (s->sew < MO_64) &&
+           require_align(vd, s->lmul + 1) &&
+           require_vm(vm, vd);
+}
+
+/*
+ * Common check function for vector narrowing instructions
+ * of single-width result (SEW) and double-width source (2*SEW).
  *
- * 2. In widen instructions and some other insturctions, like vslideup.vx,
- *    there is no need to check whether LMUL=1.
+ * Rules to be checked here:
+ *   1. The largest vector register group used by an instruction
+ *      can not be greater than 8 vector registers (Section 5.2):
+ *      => LMUL < 8.
+ *      => SEW < 64.
+ *   2. Source vector register number is multiples of 2 * LMUL.
+ *      (Section 3.3.2, 11.3)
+ *   3. Destination vector register number is multiples of LMUL.
+ *      (Section 3.3.2, 11.3)
+ *   4. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 5.3)
  */
-static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
-    bool force)
+static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
+                                     int vm)
+{
+    return (s->lmul <= 2) &&
+           (s->sew < MO_64) &&
+           require_align(vs2, s->lmul + 1) &&
+           require_align(vd, s->lmul) &&
+           require_vm(vm, vd);
+}
+
+static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 {
-    return (vm != 0 || vd != 0) || (!force && (s->lmul == 0));
+    return vext_wide_check_common(s, vd, vm) &&
+        require_align(vs, s->lmul) &&
+        require_noover(vd, s->lmul + 1, vs, s->lmul);
 }
 
-/* The LMUL setting must be such that LMUL * NFIELDS <= 8. (Section 7.8) */
-static bool vext_check_nf(DisasContext *s, uint32_t nf)
+static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 {
-    return (1 << s->lmul) * nf <= 8;
+    return vext_wide_check_common(s, vd, vm) &&
+        require_align(vs, s->lmul + 1);
 }
 
 /*
- * The destination vector register group cannot overlap a source vector register
- * group of a different element width. (Section 11.2)
+ * Check function for vector instruction with format:
+ * double-width result and single-width sources (2*SEW = SEW op SEW)
+ *
+ * Rules to be checked here:
+ *   1. All rules in defined in widen common rules are applied.
+ *   2. Source (vs2, vs1) vector register number are multiples of LMUL.
+ *      (Section 3.3.2)
+ *   3. Destination vector register cannot overlap a source vector
+ *      register (vs2, vs1) group.
+ *      (Section 5.2)
+ */
+static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
+{
+    return vext_check_ds(s, vd, vs2, vm) &&
+        require_align(vs1, s->lmul) &&
+        require_noover(vd, s->lmul + 1, vs1, s->lmul);
+}
+
+/*
+ * Check function for vector instruction with format:
+ * double-width result and double-width source1 and single-width
+ * source2 (2*SEW = 2*SEW op SEW)
+ *
+ * Rules to be checked here:
+ *   1. All rules in defined in widen common rules are applied.
+ *   2. Source 1 (vs2) vector register number is multiples of 2 * LMUL.
+ *      (Section 3.3.2)
+ *   3. Source 2 (vs1) vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ *   4. Destination vector register cannot overlap a source vector
+ *      register (vs1) group.
+ *      (Section 5.2)
  */
-static inline bool vext_check_overlap_group(int rd, int dlen, int rs, int slen)
+static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
-    return ((rd >= rs + slen) || (rs >= rd + dlen));
+    return vext_check_ds(s, vd, vs1, vm) &&
+        require_align(vs2, s->lmul + 1);
 }
+
+static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
+{
+    bool ret = vext_narrow_check_common(s, vd, vs, vm);
+    if (vd != vs) {
+        ret &= require_noover(vd, s->lmul, vs, s->lmul + 1);
+    }
+    return ret;
+}
+
+/*
+ * Check function for vector instruction with format:
+ * single-width result and double-width source 1 and single-width
+ * source 2 (SEW = 2*SEW op SEW)
+ *
+ * Rules to be checked here:
+ *   1. All rules in defined in narrow common rules are applied.
+ *   2. Destination vector register cannot overlap a source vector
+ *      register (vs2) group.
+ *      (Section 5.2)
+ *   3. Source 2 (vs1) vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ */
+static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
+{
+    return vext_check_sd(s, vd, vs2, vm) &&
+        require_align(vs1, s->lmul);
+}
+
+/*
+ * Check function for vector reduction instructions.
+ *
+ * Rules to be checked here:
+ *   1. Source 1 (vs2) vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ */
+static bool vext_check_reduction(DisasContext *s, int vs2)
+{
+    return require_align(vs2, s->lmul) && (s->vstart == 0);
+}
+
+/*
+ * Check function for vector slide instructions.
+ *
+ * Rules to be checked here:
+ *   1. Source 1 (vs2) vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ *   2. Destination vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ *   3. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 5.3)
+ *   4. The destination vector register group for vslideup, vslide1up,
+ *      vfslide1up, cannot overlap the source vector register (vs2) group.
+ *      (Section 5.2, 17.3.1, 17.3.3)
+ */
+static bool vext_check_slide(DisasContext *s, int vd, int vs2,
+                             int vm, bool is_over)
+{
+    bool ret = require_align(vs2, s->lmul) &&
+               require_align(vd, s->lmul) &&
+               require_vm(vm, vd);
+    if (is_over) {
+        ret &= (vd != vs2);
+    }
+    return ret;
+}
+
+/*
+ * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
+ * So RVV is also be checked in this function.
+ */
+static bool vext_check_isa_ill(DisasContext *s)
+{
+    return !s->vill;
+}
+
 /* common translation macro */
 #define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
 static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
@@ -802,11 +1109,9 @@ GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
@@ -897,10 +1202,9 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
 static bool opivx_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ss(s, a->rd, a->rs2, a->vm);
 }
 
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t, TCGv_i64,
@@ -1097,16 +1401,9 @@ GEN_OPIVI_GVEC_TRANS(vrsub_vi, 0, vrsub_vx, rsubi)
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
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
@@ -1151,13 +1448,9 @@ GEN_OPIVV_WIDEN_TRANS(vwsub_vv, opivv_widen_check)
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
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
 static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
@@ -1188,14 +1481,9 @@ GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
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
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
@@ -1238,11 +1526,9 @@ GEN_OPIWV_WIDEN_TRANS(vwsub_wv)
 /* WIDEN OPIVX with WIDEN */
 static bool opiwx_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dd(s, a->rd, a->rs2, a->vm);
 }
 
 static bool do_opiwx_widen(DisasContext *s, arg_rmrr *a,
@@ -1303,11 +1589,10 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
  */
 static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            ((a->rd != 0) || (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (a->rd != 0) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 GEN_OPIVV_TRANS(vadc_vvm, opivv_vadc_check)
@@ -1319,11 +1604,9 @@ GEN_OPIVV_TRANS(vsbc_vvm, opivv_vadc_check)
  */
 static bool opivv_vmadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
-            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2);
 }
 
 GEN_OPIVV_TRANS(vmadc_vvm, opivv_vmadc_check)
@@ -1331,10 +1614,10 @@ GEN_OPIVV_TRANS(vmsbc_vvm, opivv_vmadc_check)
 
 static bool opivx_vadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            ((a->rd != 0) || (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (a->rd != 0) &&
+           vext_check_ss(s, a->rd, a->rs2, a->vm);
 }
 
 /* OPIVX without GVEC IR */
@@ -1357,9 +1640,9 @@ GEN_OPIVX_TRANS(vsbc_vxm, opivx_vadc_check)
 
 static bool opivx_vmadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ms(s, a->rd, a->rs2);
 }
 
 GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
@@ -1450,14 +1733,9 @@ GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
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
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sds(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 /* OPIVV with NARROW */
@@ -1491,13 +1769,9 @@ GEN_OPIVV_NARROW_TRANS(vnsrl_vv)
 
 static bool opivx_narrow_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, true) &&
-            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
-                2 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sd(s, a->rd, a->rs2, a->vm);
 }
 
 /* OPIVX with NARROW */
@@ -1545,13 +1819,11 @@ GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
  */
 static bool opivv_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
-              vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
-             (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2);
 }
+
 GEN_OPIVV_TRANS(vmseq_vv, opivv_cmp_check)
 GEN_OPIVV_TRANS(vmsne_vv, opivv_cmp_check)
 GEN_OPIVV_TRANS(vmsltu_vv, opivv_cmp_check)
@@ -1561,10 +1833,9 @@ GEN_OPIVV_TRANS(vmsle_vv, opivv_cmp_check)
 
 static bool opivx_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
-             (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ms(s, a->rd, a->rs2);
 }
 
 GEN_OPIVX_TRANS(vmseq_vx, opivx_cmp_check)
@@ -1643,10 +1914,10 @@ GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
 /* Vector Integer Merge and Move Instructions */
 static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_reg(s, a->rs1, false)) {
-
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        /* vmv.v.v has rs2 = 0 and vm = 1 */
+        vext_check_sss(s, a->rd, a->rs1, 0, 1)) {
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
                              vreg_ofs(s, a->rs1),
@@ -1673,9 +1944,10 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
 typedef void gen_helper_vmv_vx(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i32);
 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false)) {
-
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        /* vmv.v.x has rs2 = 0 and vm = 1 */
+        vext_check_ss(s, a->rd, 0, 1)) {
         TCGv s1;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -1716,9 +1988,10 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
 
 static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false)) {
-
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        /* vmv.v.i has rs2 = 0 and vm = 1 */
+        vext_check_ss(s, a->rd, 0, 1)) {
         int64_t simm = sextract64(a->rs1, 0, 5);
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
@@ -1820,12 +2093,10 @@ GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
  */
 static bool opfvv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            (s->sew != 0));
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 /* OPFVV without GVEC IR */
@@ -1890,17 +2161,17 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
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
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           has_ext(s, RVF) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ss(s, a->rd, a->rs2, a->vm);
 }
 
 /* OPFVF without GVEC IR */
@@ -1930,16 +2201,10 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
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
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 /* OPFVV with WIDEN */
@@ -1973,13 +2238,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
 
 static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
-                                     1 << s->lmul) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
 /* OPFVF with WIDEN */
@@ -2005,14 +2267,10 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
 
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
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
 /* WIDEN OPFVV with WIDEN */
@@ -2046,11 +2304,10 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
 
 static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dd(s, a->rd, a->rs2, a->vm);
 }
 
 /* WIDEN OPFVF with WIDEN */
@@ -2121,11 +2378,11 @@ GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
  */
 static bool opfv_check(DisasContext *s, arg_rmr *a)
 {
-   return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0));
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV instructions ignore vs1 check */
+           vext_check_ss(s, a->rd, a->rs2, a->vm);
 }
 
 #define GEN_OPFV_TRANS(NAME, CHECK)                                \
@@ -2173,13 +2430,10 @@ GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
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
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2);
 }
 
 GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
@@ -2190,11 +2444,10 @@ GEN_OPFVV_TRANS(vmford_vv, opfvv_cmp_check)
 
 static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0) &&
-            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
-             (s->lmul == 0)));
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ms(s, a->rd, a->rs2);
 }
 
 GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
@@ -2213,10 +2466,10 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
 
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        (s->sew != 0)) {
-
+    if (require_rvv(s) &&
+        require_rvf(s) &&
+        vext_check_isa_ill(s) &&
+        require_align(a->rd, s->lmul)) {
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
@@ -2262,13 +2515,11 @@ GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
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
+    return require_rvv(s) &&
+           require_scale_rvf(s) &&
+           (s->sew != MO_8) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
 #define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
@@ -2310,13 +2561,12 @@ GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
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
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           (s->sew != MO_64) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV narrowing instructions ignore vs1 check */
+           vext_check_sd(s, a->rd, a->rs2, a->vm);
 }
 
 #define GEN_OPFV_NARROW_TRANS(NAME)                                \
@@ -2356,7 +2606,9 @@ GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
 /* Vector Single-Width Integer Reduction Instructions */
 static bool reduction_check(DisasContext *s, arg_rmrr *a)
 {
-    return vext_check_isa_ill(s) && vext_check_reg(s, a->rs2, false);
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_reduction(s, a->rs2);
 }
 
 GEN_OPIVV_TRANS(vredsum_vs, reduction_check)
@@ -2369,8 +2621,13 @@ GEN_OPIVV_TRANS(vredor_vs, reduction_check)
 GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 
 /* Vector Widening Integer Reduction Instructions */
-GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
-GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
+static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return reduction_check(s, a) && (s->sew < MO_64);
+}
+
+GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_widen_check)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
 GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
@@ -2418,7 +2675,8 @@ GEN_MM_TRANS(vmxnor_mm)
 /* Vector mask population count vmpopc */
 static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
 {
-    if (vext_check_isa_ill(s)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s)) {
         TCGv_ptr src2, mask;
         TCGv dst;
         TCGv_i32 desc;
@@ -2449,7 +2707,8 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
 /* vmfirst find-first-set mask bit */
 static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
 {
-    if (vext_check_isa_ill(s)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s)) {
         TCGv_ptr src2, mask;
         TCGv dst;
         TCGv_i32 desc;
@@ -2508,10 +2767,11 @@ GEN_M_TRANS(vmsof_m)
 /* Vector Iota Instruction */
 static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2, 1) &&
-        (a->vm != 0 || a->rd != 0)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        require_noover(a->rd, s->lmul, a->rs2, 0) &&
+        require_vm(a->vm, a->rd) &&
+        require_align(a->rd, s->lmul)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -2535,9 +2795,10 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 /* Vector Element Index Instruction */
 static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_overlap_mask(s, a->rd, a->vm, false)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        require_align(a->rd, s->lmul) &&
+        require_vm(a->vm, a->rd)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -2787,41 +3048,48 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 /* Vector Slide Instructions */
 static bool slideup_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (a->rd != a->rs2));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_slide(s, a->rd, a->rs2, a->vm, true);
 }
 
 GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
 GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
 GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
 
-GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
-GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
-GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
+static bool slidedown_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_slide(s, a->rd, a->rs2, a->vm, false);
+}
+
+GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
+GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
+GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, slidedown_check)
 
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs1, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (a->rd != a->rs2) && (a->rd != a->rs1));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs1, s->lmul) &&
+           require_align(a->rs2, s->lmul) &&
+           (a->rd != a->rs2 && a->rd != a->rs1) &&
+           require_vm(a->vm, a->rd);
 }
 
 GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
 
 static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (a->rd != a->rs2));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul) &&
+           (a->rd != a->rs2) &&
+           require_vm(a->vm, a->rd);
 }
 
 /* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -2885,11 +3153,12 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
 /* Vector Compress Instruction */
 static bool vcompress_vm_check(DisasContext *s, arg_r *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs1, 1) &&
-            (a->rd != a->rs2));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul) &&
+           (a->rd != a->rs2) &&
+           require_noover(a->rd, s->lmul, a->rs1, 0);
 }
 
 static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
-- 
2.17.1


