Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8268C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E436206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UxbcO7dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E436206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAzg-0003pu-2v
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtp-0008PN-2t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:53 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtj-0005UD-0I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:52 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a9so864110pjd.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3UYjmAKXEemclQT2GNQL9q27nCWVr8w1IQcxyVQ3KqM=;
 b=UxbcO7dWKcqtJWaxmwox9OBz+qav/IeSd1VeQ0yNu90ehE12GK2BIHPN6Nv+kDXK/O
 p3soYIAnnIF5jL9ugXoh5ttyz/2MdPwK+k342GLl6J1l6ztkBtRYCCvwOg7MbAUcypE1
 UxzwjI3LgV5wbEfHiv/HkGu/ageeHMa6pqhVuWk7U145Y+7oFybpIukoNOCOCTvExRAv
 DuSq2oJFUIHuZgOXY/rdLepv/S1DWLFeF1QHTSVuDOj/lmU6J0d7L0UeiA062r0CjrXT
 +puuXwoia1ALSnHv8NCqEgH74PPtLqMkCQRITbVkg/hp1hsYd3IxX8w6tLVLwfgkc9fe
 cYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3UYjmAKXEemclQT2GNQL9q27nCWVr8w1IQcxyVQ3KqM=;
 b=VxRwqTzuflXIdYmn8XhPstvp0+lX78AgkK9m3k2PD2TEAUqhAJ6wopBnnozPy2C6Zm
 YDpDTUqmBeVi4A+y4Z7RJAUCT9SZvSPAhxTOOPKeuBMLchysfCSxdh1TrVxOrfs+tReH
 utC/xWliodPrjVQl3VcWnk3irNcF+2cVCkFDx0s2P4251Jm4jJjSUJDWC/H+jwwRHOC0
 fmgQEBUtdeYUkoIbw3j3IU9SKxm+VqwR0x6j8wzRExOqofD0u+1hTmDzWuderGoJP0PK
 QHjZILUOGAMOmQ/klpY5Oq1sovyzHziSd58ilHokyjOj1nFzkX1St3FCEZHoi93Jedl4
 9Cyg==
X-Gm-Message-State: AOAM531OyuveZkKR5V7FAKA7k/rfZMy072sVXLUQwrwSYSDMk1dcDsEX
 9aJb6Y/xAphSXMsKIqoHm0c9Fo3qARo=
X-Google-Smtp-Source: ABdhPJwQcVO2UKwGq4G5fyPQ7LdRnTWi/HGQY5z2z0wuQuFI3aLoAH9kJmUSg6s7QFYEE9zwjQPBTQ==
X-Received: by 2002:a17:902:b412:: with SMTP id
 x18mr24597285plr.116.1595409524618; 
 Wed, 22 Jul 2020 02:18:44 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:44 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 17/76] target/riscv: rvv-0.9: update check functions
Date: Wed, 22 Jul 2020 17:15:40 +0800
Message-Id: <20200722091641.8834-18-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Update check functions with RVV 0.9 rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 706 ++++++++++++++++--------
 1 file changed, 474 insertions(+), 232 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0cbecdd786..13b6098153 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -19,11 +19,79 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 
+#define NVPR    32
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
+static bool require_rvv(DisasContext *s)
+{
+    if (s->mstatus_vs == 0) {
+        return false;
+    }
+    return true;
+}
+
+/* Destination vector register group cannot overlap source mask register. */
+static bool require_vm(int vm, int rd)
+{
+    return (vm != 0 || rd != 0);
+}
+
+static bool require_align(const unsigned val, const unsigned pos)
+{
+    return is_aligned(val, pos);
+}
+
+static bool require_noover(const int astart, const int asize,
+                           const int bstart, const int bsize)
+{
+    return !is_overlapped(astart, asize, bstart, bsize);
+}
+
+static bool require_noover_widen(const int astart, const int asize,
+                                 const int bstart, const int bsize)
+{
+    return !is_overlapped_widen(astart, asize, bstart, bsize);
+}
+
 static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
 {
     TCGv s1, s2, dst;
 
-    if (!has_ext(ctx, RVV)) {
+    if (!require_rvv(ctx) || !has_ext(ctx, RVV)) {
         return false;
     }
 
@@ -56,7 +124,7 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
 {
     TCGv s1, s2, dst;
 
-    if (!has_ext(ctx, RVV)) {
+    if (!require_rvv(ctx) || !has_ext(ctx, RVV)) {
         return false;
     }
 
@@ -101,53 +169,264 @@ static bool vext_check_isa_ill(DisasContext *s)
 }
 
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
+static bool vext_check_sss(DisasContext *s, int vd, int vs1,
+                           int vs2, int vm, bool is_vs1)
+{
+    bool ret = require_vm(vm, vd);
+    if (s->flmul > 1) {
+        ret &= require_align(vd, s->flmul) &&
+               require_align(vs2, s->flmul);
+        if (is_vs1) {
+            ret &= require_align(vs1, s->flmul);
+        }
+    }
+    return ret;
+}
+
+/*
+ * Check function for maskable vector instruction with format:
+ * single-width result and single-width sources (SEW = SEW op SEW)
+ *
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
+ *
+ * Rules to be checked here:
+ *   1. Source (vs2, vs1) vector register number are multiples of LMUL.
+ *      (Section 3.3.2)
+ *   2. Destination vector register cannot overlap a source vector
+ *      register (vs2, vs1) group.
+ *      (Section 5.2)
+ */
+static bool vext_check_mss(DisasContext *s, int vd, int vs1,
+                           int vs2, bool is_vs1)
 {
-    /*
-     * The destination vector register group results are arranged as if both
-     * SEW and LMUL were at twice their current settings. (Section 11.2).
-     */
-    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
+    bool ret = require_align(vs2, s->flmul);
+    if (vd != vs2) {
+        ret &= require_noover(vd, 1, vs2, s->flmul);
+    }
+    if (is_vs1) {
+        if (vd != vs1) {
+            ret &= require_noover(vd, 1, vs1, s->flmul);
+        }
+        ret &= require_align(vs1, s->flmul);
+    }
+    return ret;
+}
 
-    return !((s->lmul == 0x3 && widen) || (reg % legal));
+/*
+ * Common check function for vector widening instructions
+ * of double-width result (2*SEW).
+ *
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
+    return (s->flmul <= 4) &&
+           (s->sew < 3) &&
+           require_align(vd, s->flmul * 2) &&
+           require_vm(vm, vd);
 }
 
 /*
- * There are two rules check here.
+ * Common check function for vector narrowing instructions
+ * of single-width result (SEW) and double-width source (2*SEW).
+ *
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
+ */
+static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
+                                     int vm)
+{
+    return (s->flmul <= 4) &&
+           (s->sew < 3) &&
+           require_align(vs2, s->flmul * 2) &&
+           require_align(vd, s->flmul) &&
+           require_vm(vm, vd);
+}
+
+/*
+ * Check function for vector instruction with format:
+ * double-width result and single-width sources (2*SEW = SEW op SEW)
  *
- * 1. The destination vector register group for a masked vector instruction can
- *    only overlap the source mask register (v0) when LMUL=1. (Section 5.3)
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
  *
- * 2. In widen instructions and some other insturctions, like vslideup.vx,
- *    there is no need to check whether LMUL=1.
+ * Rules to be checked here:
+ *   1. All rules in defined in widen common rules are applied.
+ *   2. Source (vs2, vs1) vector register number are multiples of LMUL.
+ *      (Section 3.3.2)
+ *   3. Destination vector register cannot overlap a source vector
+ *      register (vs2, vs1) group.
+ *      (Section 5.2)
  */
-static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
-    bool force)
+static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2,
+                           int vm, bool is_vs1)
 {
-    return (vm != 0 || vd != 0) || (!force && (s->lmul == 0));
+    bool ret = (vext_wide_check_common(s, vd, vm) &&
+                require_align(vs2, s->flmul));
+    if (s->flmul < 1) {
+        ret &= require_noover(vd, s->flmul * 2, vs2, s->flmul);
+    } else {
+        ret &= require_noover_widen(vd, s->flmul * 2, vs2, s->flmul);
+    }
+    if (is_vs1) {
+        ret &= require_align(vs1, s->flmul);
+        if (s->flmul < 1) {
+            ret &= require_noover(vd, s->flmul * 2, vs1, s->flmul);
+        } else {
+            ret &= require_noover_widen(vd, s->flmul * 2, vs1, s->flmul);
+        }
+    }
+    return ret;
 }
 
-/* The LMUL setting must be such that LMUL * NFIELDS <= 8. (Section 7.8) */
-static bool vext_check_nf(DisasContext *s, uint32_t nf)
+/*
+ * Check function for vector instruction with format:
+ * double-width result and double-width source1 and single-width
+ * source2 (2*SEW = 2*SEW op SEW)
+ *
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
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
+ */
+static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2,
+                           int vm, bool is_vs1)
+{
+    bool ret = (vext_wide_check_common(s, vd, vm) &&
+                require_align(vs2, s->flmul * 2));
+    if (is_vs1) {
+        ret &= require_align(vs1, s->flmul);
+        if (s->flmul < 1) {
+            ret &= require_noover(vd, s->flmul * 2, vs1, s->flmul);
+        } else {
+            ret &= require_noover_widen(vd, s->flmul * 2, vs1, s->flmul);
+        }
+    }
+    return ret;
+}
+
+/*
+ * Check function for vector instruction with format:
+ * single-width result and double-width source 1 and single-width
+ * source 2 (SEW = 2*SEW op SEW)
+ *
+ * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
+ *
+ * Rules to be checked here:
+ *   1. All rules in defined in narrow common rules are applied.
+ *   2. Destination vector register cannot overlap a source vector
+ *      register (vs2) group.
+ *      (Section 5.2)
+ *   3. Source 2 (vs1) vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ */
+static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2,
+                           int vm, bool is_vs1)
 {
-    return (1 << s->lmul) * nf <= 8;
+    bool ret = vext_narrow_check_common(s, vd, vs2, vm);
+    if (vd != vs2) {
+        ret &= require_noover(vd, s->flmul, vs2, s->flmul * 2);
+    }
+    if (is_vs1) {
+        ret &= require_align(vs1, s->flmul);
+    }
+    return ret;
 }
 
 /*
- * The destination vector register group cannot overlap a source vector register
- * group of a different element width. (Section 11.2)
+ * Check function for vector reduction instructions.
+ *
+ * Rules to be checked here:
+ *   1. Source 1 (vs2) vector register number is multiples of LMUL.
+ *      (Section 3.3.2)
+ *   2. For widening reduction instructions, SEW < 64.
+ *
+ * TODO: Check vstart == 0
  */
-static inline bool vext_check_overlap_group(int rd, int dlen, int rs, int slen)
+static bool vext_check_reduction(DisasContext *s, int vs2, bool is_wide)
 {
-    return ((rd >= rs + slen) || (rs >= rd + dlen));
+    bool ret = require_align(vs2, s->flmul);
+    if (is_wide) {
+        ret &= s->sew < 3;
+    }
+    return ret;
 }
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
+    bool ret = require_align(vs2, s->flmul) &&
+               require_align(vd, s->flmul) &&
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
@@ -818,11 +1097,9 @@ GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_reg(s, a->rs1, false));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm, true);
 }
 
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
@@ -917,10 +1194,9 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
 static bool opivx_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm, false);
 }
 
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t, TCGv_i64,
@@ -1119,16 +1395,9 @@ GEN_OPIVI_GVEC_TRANS(vrsub_vi, 0, vrsub_vx, rsubi)
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
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm, true);
 }
 
 static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
@@ -1175,13 +1444,9 @@ GEN_OPIVV_WIDEN_TRANS(vwsub_vv, opivv_widen_check)
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
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm, false);
 }
 
 static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
@@ -1212,14 +1477,9 @@ GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
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
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm, true);
 }
 
 static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
@@ -1264,11 +1524,9 @@ GEN_OPIWV_WIDEN_TRANS(vwsub_wv)
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
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm, false);
 }
 
 static bool do_opiwx_widen(DisasContext *s, arg_rmrr *a,
@@ -1331,11 +1589,10 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
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
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm, true);
 }
 
 GEN_OPIVV_TRANS(vadc_vvm, opivv_vadc_check)
@@ -1347,11 +1604,9 @@ GEN_OPIVV_TRANS(vsbc_vvm, opivv_vadc_check)
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
+           vext_check_mss(s, a->rd, a->rs1, a->rs2, true);
 }
 
 GEN_OPIVV_TRANS(vmadc_vvm, opivv_vmadc_check)
@@ -1359,10 +1614,10 @@ GEN_OPIVV_TRANS(vmsbc_vvm, opivv_vmadc_check)
 
 static bool opivx_vadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            ((a->rd != 0) || (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (a->rd != 0) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm, false);
 }
 
 /* OPIVX without GVEC IR */
@@ -1385,9 +1640,9 @@ GEN_OPIVX_TRANS(vsbc_vxm, opivx_vadc_check)
 
 static bool opivx_vmadc_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2, false);
 }
 
 GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
@@ -1478,14 +1733,9 @@ GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
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
+           vext_check_sds(s, a->rd, a->rs1, a->rs2, a->vm, true);
 }
 
 /* OPIVV with NARROW */
@@ -1521,13 +1771,9 @@ GEN_OPIVV_NARROW_TRANS(vnsrl_vv)
 
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
+           vext_check_sds(s, a->rd, a->rs1, a->rs2, a->vm, false);
 }
 
 /* OPIVX with NARROW */
@@ -1575,13 +1821,11 @@ GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
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
+           vext_check_mss(s, a->rd, a->rs1, a->rs2, true);
 }
+
 GEN_OPIVV_TRANS(vmseq_vv, opivv_cmp_check)
 GEN_OPIVV_TRANS(vmsne_vv, opivv_cmp_check)
 GEN_OPIVV_TRANS(vmsltu_vv, opivv_cmp_check)
@@ -1591,10 +1835,9 @@ GEN_OPIVV_TRANS(vmsle_vv, opivv_cmp_check)
 
 static bool opivx_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
-             (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2, false);
 }
 
 GEN_OPIVX_TRANS(vmseq_vx, opivx_cmp_check)
@@ -1673,10 +1916,10 @@ GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
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
+        vext_check_sss(s, a->rd, a->rs1, 0, 1, true)) {
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
                              vreg_ofs(s, a->rs1),
@@ -1705,9 +1948,10 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
 typedef void gen_helper_vmv_vx(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i32);
 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false)) {
-
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        /* vmv.v.x has rs2 = 0 and vm = 1 */
+        vext_check_sss(s, a->rd, a->rs1, 0, 1, false)) {
         TCGv s1;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -1750,9 +1994,10 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
 
 static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false)) {
-
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        /* vmv.v.i has rs2 = 0 and vm = 1 */
+        vext_check_sss(s, a->rd, a->rs1, 0, 1, false)) {
         int64_t simm = sextract64(a->rs1, 0, 5);
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
@@ -1857,12 +2102,10 @@ GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
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
+           vext_check_isa_ill(s) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm, true) &&
+           (s->sew != 0);
 }
 
 /* OPFVV without GVEC IR */
@@ -1929,17 +2172,17 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
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
+           has_ext(s, RVF) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm, false) &&
+           (s->sew != 0);
 }
 
 /* OPFVF without GVEC IR */
@@ -1971,16 +2214,10 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
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
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm, true) &&
+           (s->sew != 0);
 }
 
 /* OPFVV with WIDEN */
@@ -2016,13 +2253,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
 
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
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm, false) &&
+           (s->sew != 0);
 }
 
 /* OPFVF with WIDEN */
@@ -2050,14 +2284,10 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
 
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
+           vext_check_isa_ill(s) &&
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm, true) &&
+           (s->sew != 0);
 }
 
 /* WIDEN OPFVV with WIDEN */
@@ -2093,11 +2323,10 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
 
 static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, true) &&
-            vext_check_reg(s, a->rs2, true) &&
-            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm, false) &&
+           (s->sew != 0);
 }
 
 /* WIDEN OPFVF with WIDEN */
@@ -2170,11 +2399,11 @@ GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
  */
 static bool opfv_check(DisasContext *s, arg_rmr *a)
 {
-   return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV instructions ignore vs1 check */
+           vext_check_sss(s, a->rd, 0, a->rs2, a->vm, false) &&
+           (s->sew != 0);
 }
 
 #define GEN_OPFV_TRANS(NAME, CHECK)                                \
@@ -2224,13 +2453,10 @@ GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
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
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2, true) &&
+           (s->sew != 0);
 }
 
 GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
@@ -2241,11 +2467,10 @@ GEN_OPFVV_TRANS(vmford_vv, opfvv_cmp_check)
 
 static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (s->sew != 0) &&
-            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
-             (s->lmul == 0)));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_mss(s, a->rd, a->rs1, a->rs2, false) &&
+           (s->sew != 0);
 }
 
 GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
@@ -2264,10 +2489,10 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
 
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        require_align(a->rd, s->flmul) &&
         (s->sew != 0)) {
-
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
@@ -2313,13 +2538,11 @@ GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
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
+           vext_check_isa_ill(s) &&
+           /* OPFV widening instructions ignore vs1 check */
+           vext_check_dss(s, a->rd, 0, a->rs2, a->vm, false) &&
+           (s->sew != 0);
 }
 
 #define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
@@ -2363,13 +2586,11 @@ GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
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
+           vext_check_isa_ill(s) &&
+           /* OPFV narrowing instructions ignore vs1 check */
+           vext_check_sds(s, a->rd, 0, a->rs2, a->vm, false) &&
+           (s->sew != 0);
 }
 
 #define GEN_OPFV_NARROW_TRANS(NAME)                                \
@@ -2411,7 +2632,9 @@ GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
 /* Vector Single-Width Integer Reduction Instructions */
 static bool reduction_check(DisasContext *s, arg_rmrr *a)
 {
-    return vext_check_isa_ill(s) && vext_check_reg(s, a->rs2, false);
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_reduction(s, a->rs2, false);
 }
 
 GEN_OPIVV_TRANS(vredsum_vs, reduction_check)
@@ -2424,8 +2647,15 @@ GEN_OPIVV_TRANS(vredor_vs, reduction_check)
 GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 
 /* Vector Widening Integer Reduction Instructions */
-GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
-GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
+static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_reduction(s, a->rs2, true);
+}
+
+GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_widen_check)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
 GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
@@ -2474,7 +2704,8 @@ GEN_MM_TRANS(vmxnor_mm)
 /* Vector mask population count vmpopc */
 static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
 {
-    if (vext_check_isa_ill(s)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s)) {
         TCGv_ptr src2, mask;
         TCGv dst;
         TCGv_i32 desc;
@@ -2506,7 +2737,8 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
 /* vmfirst find-first-set mask bit */
 static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
 {
-    if (vext_check_isa_ill(s)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s)) {
         TCGv_ptr src2, mask;
         TCGv dst;
         TCGv_i32 desc;
@@ -2567,10 +2799,11 @@ GEN_M_TRANS(vmsof_m)
 /* Vector Iota Instruction */
 static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2, 1) &&
-        (a->vm != 0 || a->rd != 0)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        require_noover(a->rd, s->flmul, a->rs2, 1) &&
+        require_vm(a->vm, a->rd) &&
+        require_align(a->rd, s->flmul)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -2596,9 +2829,10 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 /* Vector Element Index Instruction */
 static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_overlap_mask(s, a->rd, a->vm, false)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        require_align(a->rd, s->flmul) &&
+        require_vm(a->vm, a->rd)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -2850,41 +3084,48 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
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
+           require_align(a->rd, s->flmul) &&
+           require_align(a->rs1, s->flmul) &&
+           require_align(a->rs2, s->flmul) &&
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
+           require_align(a->rd, s->flmul) &&
+           require_align(a->rs2, s->flmul) &&
+           (a->rd != a->rs2) &&
+           require_vm(a->vm, a->rd);
 }
 
 /* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -2948,11 +3189,12 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
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
+           require_align(a->rd, s->flmul) &&
+           require_align(a->rs2, s->flmul) &&
+           (a->rd != a->rs2) &&
+           require_noover(a->rd, s->flmul, a->rs1, 1);
 }
 
 static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
-- 
2.17.1


