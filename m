Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9448C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647FA20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mE9U60vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647FA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Cy-0003eA-LX
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29b-0003cC-Ni
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29Y-0000AQ-V0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707616; x=1625243616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=knbXT5CrpUzCxoiCi840YaAUhRWrmTG3TBH/mENPkHA=;
 b=mE9U60vwcsfMVqcEDhYlkwYaqk9eiyVjlTwh85ffPPpVw9gv/4FVEm2v
 ulL1Fky+3M8wN4O3cZsUCIGYJOIU5wiU69tmS9vLYrp856ncjT/q4iFHB
 EDQb2fcrKIOnKHKtcwI+VjrVA1VIhSz5Q17eYV5sk6wm0sxodxhk2ETWd
 R3LSZ8qyCOfUoqackJESiVXH3UfMrmhgqcC+wmqsG7bu2cmd4SWscUthw
 EN+RSAxqHQa3PTwUwgGAA8J8N4Ww0IYqdblFxfurdy/id4GBWp3OPD+RT
 HtVCxxJ2SVxJtqnxfUew0G9yBkGS+6gqNQs/X6AbitotOgayDMg8glT4D g==;
IronPort-SDR: Ako3RGJILzUh/ex1dR7WYJ7BOoD28s7bAsnnh5IwC0t/8caYQlnEI8rE3MRIvrNico3vGovlZe
 I0YXPfpH0O0hUC5k7kBPIQhb6IPElGFXJYm42VnTLNMIoX7Ymx4HzLFpVx9k8+QZ5UXkW8wJcV
 vZIiGQDZ98B9pfCXUvERq63293nSZopsP7a4fhd6iOYw24UvEw3+HBspXz8/LLNY/kDHASz8iY
 kt2hNKMnxscg/6Whjexamj+kK5WWJP7at3dJFgPNSOpCR+tB+zfOo/FLbmLrEQotKpUiGuAO3f
 AEI=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498475"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:23 +0800
IronPort-SDR: wy0GO9jIuH2jN+jY5/aE9FAtKkQZr9zDCrFFlS5DTtRvb0ezTm3yD7qN/ljR2Mt8mXgZ6dU4tc
 Q9mpenZi5avUPh96V/hDeOke4Pen1wXcU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:38 -0700
IronPort-SDR: hdE5KBdCU40oRJCZQZQ5diSjWgB0q0LCZan6TfvYs4J/Vfoqrmx64ssbQXleJcpecSAGxGXPnD
 NlMYNvlRTlLg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 14/64] target/riscv: vector widening integer add and subtract
Date: Thu,  2 Jul 2020 09:23:04 -0700
Message-Id: <20200702162354.928528-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200701152549.1218-12-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  49 +++++++
 target/riscv/insn32.decode              |  16 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 186 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 111 ++++++++++++++
 4 files changed, 362 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7660bec01f..da6acc067b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -300,3 +300,52 @@ DEF_HELPER_FLAGS_4(vec_rsubs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vec_rsubs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vec_rsubs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vec_rsubs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_6(vwaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_wx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bb1e47a2be..6ec166d0ed 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -286,6 +286,22 @@ vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
 vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
 vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
 vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
+vwaddu_vv       110000 . ..... ..... 010 ..... 1010111 @r_vm
+vwaddu_vx       110000 . ..... ..... 110 ..... 1010111 @r_vm
+vwadd_vv        110001 . ..... ..... 010 ..... 1010111 @r_vm
+vwadd_vx        110001 . ..... ..... 110 ..... 1010111 @r_vm
+vwsubu_vv       110010 . ..... ..... 010 ..... 1010111 @r_vm
+vwsubu_vx       110010 . ..... ..... 110 ..... 1010111 @r_vm
+vwsub_vv        110011 . ..... ..... 010 ..... 1010111 @r_vm
+vwsub_vx        110011 . ..... ..... 110 ..... 1010111 @r_vm
+vwaddu_wv       110100 . ..... ..... 010 ..... 1010111 @r_vm
+vwaddu_wx       110100 . ..... ..... 110 ..... 1010111 @r_vm
+vwadd_wv        110101 . ..... ..... 010 ..... 1010111 @r_vm
+vwadd_wx        110101 . ..... ..... 110 ..... 1010111 @r_vm
+vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
+vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
+vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
+vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c2b276809a..850df9df66 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -138,6 +138,14 @@ static bool vext_check_nf(DisasContext *s, uint32_t nf)
     return (1 << s->lmul) * nf <= 8;
 }
 
+/*
+ * The destination vector register group cannot overlap a source vector register
+ * group of a different element width. (Section 11.2)
+ */
+static inline bool vext_check_overlap_group(int rd, int dlen, int rs, int slen)
+{
+    return ((rd >= rs + slen) || (rs >= rd + dlen));
+}
 /* common translation macro */
 #define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
 static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
@@ -1063,3 +1071,181 @@ static void tcg_gen_gvec_rsubi(unsigned vece, uint32_t dofs, uint32_t aofs,
 }
 
 GEN_OPIVI_GVEC_TRANS(vrsub_vi, 0, vrsub_vx, rsubi)
+
+/* Vector Widening Integer Add/Subtract */
+
+/* OPIVV with WIDEN */
+static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
+                           gen_helper_gvec_4_ptr *fn,
+                           bool (*checkfn)(DisasContext *, arg_rmrr *))
+{
+    if (checkfn(s, a)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1),
+                           vreg_ofs(s, a->rs2),
+                           cpu_env, 0, s->vlen / 8,
+                           data, fn);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
+
+#define GEN_OPIVV_WIDEN_TRANS(NAME, CHECK) \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_gvec_4_ptr * const fns[3] = {          \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opivv_widen(s, a, fns[s->sew], CHECK);         \
+}
+
+GEN_OPIVV_WIDEN_TRANS(vwaddu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwadd_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwsubu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwsub_vv, opivv_widen_check)
+
+/* OPIVX with WIDEN */
+static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
+                           gen_helper_opivx *fn)
+{
+    if (opivx_widen_check(s, a)) {
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
+    }
+    return true;
+}
+
+#define GEN_OPIVX_WIDEN_TRANS(NAME) \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_opivx * const fns[3] = {               \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opivx_widen(s, a, fns[s->sew]);                \
+}
+
+GEN_OPIVX_WIDEN_TRANS(vwaddu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwadd_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsubu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
+
+/* WIDEN OPIVV with WIDEN */
+static bool opiwv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
+                           gen_helper_gvec_4_ptr *fn)
+{
+    if (opiwv_widen_check(s, a)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1),
+                           vreg_ofs(s, a->rs2),
+                           cpu_env, 0, s->vlen / 8, data, fn);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
+
+#define GEN_OPIWV_WIDEN_TRANS(NAME) \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_gvec_4_ptr * const fns[3] = {          \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opiwv_widen(s, a, fns[s->sew]);                \
+}
+
+GEN_OPIWV_WIDEN_TRANS(vwaddu_wv)
+GEN_OPIWV_WIDEN_TRANS(vwadd_wv)
+GEN_OPIWV_WIDEN_TRANS(vwsubu_wv)
+GEN_OPIWV_WIDEN_TRANS(vwsub_wv)
+
+/* WIDEN OPIVX with WIDEN */
+static bool opiwx_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+static bool do_opiwx_widen(DisasContext *s, arg_rmrr *a,
+                           gen_helper_opivx *fn)
+{
+    if (opiwx_widen_check(s, a)) {
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
+    }
+    return false;
+}
+
+#define GEN_OPIWX_WIDEN_TRANS(NAME) \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_opivx * const fns[3] = {               \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opiwx_widen(s, a, fns[s->sew]);                \
+}
+
+GEN_OPIWX_WIDEN_TRANS(vwaddu_wx)
+GEN_OPIWX_WIDEN_TRANS(vwadd_wx)
+GEN_OPIWX_WIDEN_TRANS(vwsubu_wx)
+GEN_OPIWX_WIDEN_TRANS(vwsub_wx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 26ddc2dc6f..06435ed82a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1017,3 +1017,114 @@ void HELPER(vec_rsubs64)(void *d, void *a, uint64_t b, uint32_t desc)
         *(uint64_t *)(d + i) = b - *(uint64_t *)(a + i);
     }
 }
+
+/* Vector Widening Integer Add/Subtract */
+#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
+#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
+#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
+#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
+#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
+#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
+#define WOP_WUUU_B  uint16_t, uint8_t, uint16_t, uint16_t, uint16_t
+#define WOP_WUUU_H  uint32_t, uint16_t, uint32_t, uint32_t, uint32_t
+#define WOP_WUUU_W  uint64_t, uint32_t, uint64_t, uint64_t, uint64_t
+#define WOP_WSSS_B  int16_t, int8_t, int16_t, int16_t, int16_t
+#define WOP_WSSS_H  int32_t, int16_t, int32_t, int32_t, int32_t
+#define WOP_WSSS_W  int64_t, int32_t, int64_t, int64_t, int64_t
+RVVCALL(OPIVV2, vwaddu_vv_b, WOP_UUU_B, H2, H1, H1, DO_ADD)
+RVVCALL(OPIVV2, vwaddu_vv_h, WOP_UUU_H, H4, H2, H2, DO_ADD)
+RVVCALL(OPIVV2, vwaddu_vv_w, WOP_UUU_W, H8, H4, H4, DO_ADD)
+RVVCALL(OPIVV2, vwsubu_vv_b, WOP_UUU_B, H2, H1, H1, DO_SUB)
+RVVCALL(OPIVV2, vwsubu_vv_h, WOP_UUU_H, H4, H2, H2, DO_SUB)
+RVVCALL(OPIVV2, vwsubu_vv_w, WOP_UUU_W, H8, H4, H4, DO_SUB)
+RVVCALL(OPIVV2, vwadd_vv_b, WOP_SSS_B, H2, H1, H1, DO_ADD)
+RVVCALL(OPIVV2, vwadd_vv_h, WOP_SSS_H, H4, H2, H2, DO_ADD)
+RVVCALL(OPIVV2, vwadd_vv_w, WOP_SSS_W, H8, H4, H4, DO_ADD)
+RVVCALL(OPIVV2, vwsub_vv_b, WOP_SSS_B, H2, H1, H1, DO_SUB)
+RVVCALL(OPIVV2, vwsub_vv_h, WOP_SSS_H, H4, H2, H2, DO_SUB)
+RVVCALL(OPIVV2, vwsub_vv_w, WOP_SSS_W, H8, H4, H4, DO_SUB)
+RVVCALL(OPIVV2, vwaddu_wv_b, WOP_WUUU_B, H2, H1, H1, DO_ADD)
+RVVCALL(OPIVV2, vwaddu_wv_h, WOP_WUUU_H, H4, H2, H2, DO_ADD)
+RVVCALL(OPIVV2, vwaddu_wv_w, WOP_WUUU_W, H8, H4, H4, DO_ADD)
+RVVCALL(OPIVV2, vwsubu_wv_b, WOP_WUUU_B, H2, H1, H1, DO_SUB)
+RVVCALL(OPIVV2, vwsubu_wv_h, WOP_WUUU_H, H4, H2, H2, DO_SUB)
+RVVCALL(OPIVV2, vwsubu_wv_w, WOP_WUUU_W, H8, H4, H4, DO_SUB)
+RVVCALL(OPIVV2, vwadd_wv_b, WOP_WSSS_B, H2, H1, H1, DO_ADD)
+RVVCALL(OPIVV2, vwadd_wv_h, WOP_WSSS_H, H4, H2, H2, DO_ADD)
+RVVCALL(OPIVV2, vwadd_wv_w, WOP_WSSS_W, H8, H4, H4, DO_ADD)
+RVVCALL(OPIVV2, vwsub_wv_b, WOP_WSSS_B, H2, H1, H1, DO_SUB)
+RVVCALL(OPIVV2, vwsub_wv_h, WOP_WSSS_H, H4, H2, H2, DO_SUB)
+RVVCALL(OPIVV2, vwsub_wv_w, WOP_WSSS_W, H8, H4, H4, DO_SUB)
+GEN_VEXT_VV(vwaddu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwaddu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwaddu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsubu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsubu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsubu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwadd_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwadd_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwadd_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsub_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsub_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsub_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwaddu_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwaddu_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwaddu_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsubu_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsubu_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsubu_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwadd_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwadd_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwadd_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsub_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsub_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsub_wv_w, 4, 8, clearq)
+
+RVVCALL(OPIVX2, vwaddu_vx_b, WOP_UUU_B, H2, H1, DO_ADD)
+RVVCALL(OPIVX2, vwaddu_vx_h, WOP_UUU_H, H4, H2, DO_ADD)
+RVVCALL(OPIVX2, vwaddu_vx_w, WOP_UUU_W, H8, H4, DO_ADD)
+RVVCALL(OPIVX2, vwsubu_vx_b, WOP_UUU_B, H2, H1, DO_SUB)
+RVVCALL(OPIVX2, vwsubu_vx_h, WOP_UUU_H, H4, H2, DO_SUB)
+RVVCALL(OPIVX2, vwsubu_vx_w, WOP_UUU_W, H8, H4, DO_SUB)
+RVVCALL(OPIVX2, vwadd_vx_b, WOP_SSS_B, H2, H1, DO_ADD)
+RVVCALL(OPIVX2, vwadd_vx_h, WOP_SSS_H, H4, H2, DO_ADD)
+RVVCALL(OPIVX2, vwadd_vx_w, WOP_SSS_W, H8, H4, DO_ADD)
+RVVCALL(OPIVX2, vwsub_vx_b, WOP_SSS_B, H2, H1, DO_SUB)
+RVVCALL(OPIVX2, vwsub_vx_h, WOP_SSS_H, H4, H2, DO_SUB)
+RVVCALL(OPIVX2, vwsub_vx_w, WOP_SSS_W, H8, H4, DO_SUB)
+RVVCALL(OPIVX2, vwaddu_wx_b, WOP_WUUU_B, H2, H1, DO_ADD)
+RVVCALL(OPIVX2, vwaddu_wx_h, WOP_WUUU_H, H4, H2, DO_ADD)
+RVVCALL(OPIVX2, vwaddu_wx_w, WOP_WUUU_W, H8, H4, DO_ADD)
+RVVCALL(OPIVX2, vwsubu_wx_b, WOP_WUUU_B, H2, H1, DO_SUB)
+RVVCALL(OPIVX2, vwsubu_wx_h, WOP_WUUU_H, H4, H2, DO_SUB)
+RVVCALL(OPIVX2, vwsubu_wx_w, WOP_WUUU_W, H8, H4, DO_SUB)
+RVVCALL(OPIVX2, vwadd_wx_b, WOP_WSSS_B, H2, H1, DO_ADD)
+RVVCALL(OPIVX2, vwadd_wx_h, WOP_WSSS_H, H4, H2, DO_ADD)
+RVVCALL(OPIVX2, vwadd_wx_w, WOP_WSSS_W, H8, H4, DO_ADD)
+RVVCALL(OPIVX2, vwsub_wx_b, WOP_WSSS_B, H2, H1, DO_SUB)
+RVVCALL(OPIVX2, vwsub_wx_h, WOP_WSSS_H, H4, H2, DO_SUB)
+RVVCALL(OPIVX2, vwsub_wx_w, WOP_WSSS_W, H8, H4, DO_SUB)
+GEN_VEXT_VX(vwaddu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwaddu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwaddu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsubu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsubu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsubu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwadd_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwadd_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwadd_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsub_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsub_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsub_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwaddu_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwaddu_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwaddu_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsubu_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsubu_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsubu_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwadd_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwadd_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwadd_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsub_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsub_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsub_wx_w, 4, 8, clearq)
-- 
2.27.0


