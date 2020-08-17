Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1252063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B9ibmdVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1252063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b2S-0004LN-6E
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqy-00070H-Jt
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:52 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqw-0004x1-H0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:52 -0400
Received: by mail-pg1-x541.google.com with SMTP id m34so7784845pgl.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fPYgfueDK3zjq1j3D6gacNXiYUEY5t8ziTpgFISfE6A=;
 b=B9ibmdVOLMmJTEE1h3FTTCpokj+0lBRBKp4fiS+Onxta1Raxs5CnYymoVXdQn75UDK
 wOPfHvz3NPqdoP+qjyt3RRLyOL2p1Ihs7HXbN0hHyzJx5nk7XkStLMzhxakiSuSc/t1k
 Gw+VW8UKII6hnPba4HJCLxp0vfn3w2Uo/uH82xjpc4aNnDkJG6kvHJDGc1fdbus8a34H
 zma14AAvAsIQN0iDzGCIqCdjiPOGTKpYiYeMjPE+fLuIOoGPzQnZ0vvg5xMZcA/ZT5Jv
 REqmLI30agf412oeUJtW1g0qPtyThf4+ycHTlg68MenhKopoFqZHmB72c94dYVzAQ8u+
 rvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fPYgfueDK3zjq1j3D6gacNXiYUEY5t8ziTpgFISfE6A=;
 b=PkEORnbP06YoxZ+trB7o3QmytqPO4DOmBRtRcrAqR4MOl1Ou15WG4Z0KaCyO4n8lkn
 s7+yuJoCN1pIabjmvdxWXuuwx/asbo6pnD6mKO6/4OichEli0jIO5vJiSygh0W/17Dwn
 5uQtX+PG4KiuVweMIwqo1+WXnuk1GtLxxWlg+mHxe5TCGEceKr2Z7+J4sE4X0Wrqr4CM
 Ma3LXTNmgev27znGJ75RAeQISenmjaPr7Igpx0iAcYF5a+S2yHzdFWlUYvkMl5CFFeNm
 /okAxWz1pim5MKuR7utcY3vRQdl5pk8TJAN5lbY4+BHAuWFIa8g4lltfazJPE6192x8t
 2DNA==
X-Gm-Message-State: AOAM5306T4XWcRrohRB5vtGbUA0Sps0kTzOcnUfv/ckxhlbkRpQG9WVe
 KrtoOB5EqnhWhvEjZHfbMaGSP/Knpozufw==
X-Google-Smtp-Source: ABdhPJygsPDEjgCE9+I39iFIaMu/DazbMFcle8kiTj+sZ6BIFbyVtfDcc+ori3+UThvtcaxfhpnK2w==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr10464254pfh.125.1597654248774; 
 Mon, 17 Aug 2020 01:50:48 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:48 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 15/70] target/riscv: introduce more imm value modes in
 translator functions
Date: Mon, 17 Aug 2020 16:49:00 +0800
Message-Id: <20200817084955.28793-16-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x541.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Immediate value in translator function is extended not only
zero-extended and sign-extended but with more modes to be applicable
with multiple formats of vector instructions.

* IMM_ZX:         Zero-extended
* IMM_SX:         Sign-extended
* IMM_TRUNC_SEW:  Truncate to log(SEW) bit
* IMM_TRUNC_2SEW: Truncate to log(2*SEW) bit

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 115 ++++++++++++++----------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4ab556f784d..daaa47ac9c3 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1283,8 +1283,32 @@ static void tcg_gen_gvec_rsubs(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 GEN_OPIVX_GVEC_TRANS(vrsub_vx, rsubs)
 
+typedef enum {
+    IMM_ZX,         /* Zero-extended */
+    IMM_SX,         /* Sign-extended */
+    IMM_TRUNC_SEW,  /* Truncate to log(SEW) bits */
+    IMM_TRUNC_2SEW, /* Truncate to log(2*SEW) bits */
+} imm_mode_t;
+
+static int64_t extract_imm(DisasContext *s, uint32_t imm, imm_mode_t imm_mode)
+{
+    switch (imm_mode) {
+    case IMM_ZX:
+        return extract64(imm, 0, 5);
+    case IMM_SX:
+        return sextract64(imm, 0, 5);
+    case IMM_TRUNC_SEW:
+        return extract64(imm, 0, s->sew + 3);
+    case IMM_TRUNC_2SEW:
+        return extract64(imm, 0, s->sew + 4);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
-                        gen_helper_opivx *fn, DisasContext *s, int zx)
+                        gen_helper_opivx *fn, DisasContext *s,
+                        imm_mode_t imm_mode)
 {
     TCGv_ptr dest, src2, mask;
     TCGv src1;
@@ -1297,11 +1321,8 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
-    if (zx) {
-        src1 = tcg_const_tl(imm);
-    } else {
-        src1 = tcg_const_tl(sextract64(imm, 0, 5));
-    }
+    src1 = tcg_const_tl(extract_imm(s, imm, imm_mode));
+
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
@@ -1327,28 +1348,23 @@ typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
 
 static inline bool
 do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
-              gen_helper_opivx *fn, int zx)
+              gen_helper_opivx *fn, imm_mode_t imm_mode)
 {
     if (!opivx_check(s, a)) {
         return false;
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        if (zx) {
-            gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
-                    extract64(a->rs1, 0, 5), MAXSZ(s), MAXSZ(s));
-        } else {
-            gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
-                    sextract64(a->rs1, 0, 5), MAXSZ(s), MAXSZ(s));
-        }
+        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
+                extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
         mark_vs_dirty(s);
         return true;
     }
-    return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, zx);
+    return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, imm_mode);
 }
 
 /* OPIVI with GVEC IR */
-#define GEN_OPIVI_GVEC_TRANS(NAME, ZX, OPIVX, SUF) \
+#define GEN_OPIVI_GVEC_TRANS(NAME, IMM_MODE, OPIVX, SUF) \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
 {                                                                  \
     static gen_helper_opivx * const fns[4] = {                     \
@@ -1356,10 +1372,10 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,            \
     };                                                             \
     return do_opivi_gvec(s, a, tcg_gen_gvec_##SUF,                 \
-                         fns[s->sew], ZX);                         \
+                         fns[s->sew], IMM_MODE);                   \
 }
 
-GEN_OPIVI_GVEC_TRANS(vadd_vi, 0, vadd_vx, addi)
+GEN_OPIVI_GVEC_TRANS(vadd_vi, IMM_SX, vadd_vx, addi)
 
 static void tcg_gen_gvec_rsubi(unsigned vece, uint32_t dofs, uint32_t aofs,
                                int64_t c, uint32_t oprsz, uint32_t maxsz)
@@ -1369,7 +1385,7 @@ static void tcg_gen_gvec_rsubi(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i64(tmp);
 }
 
-GEN_OPIVI_GVEC_TRANS(vrsub_vi, 0, vrsub_vx, rsubi)
+GEN_OPIVI_GVEC_TRANS(vrsub_vi, IMM_SX, vrsub_vx, rsubi)
 
 /* Vector Widening Integer Add/Subtract */
 
@@ -1624,7 +1640,7 @@ GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
 GEN_OPIVX_TRANS(vmsbc_vxm, opivx_vmadc_check)
 
 /* OPIVI without GVEC IR */
-#define GEN_OPIVI_TRANS(NAME, ZX, OPIVX, CHECK)                          \
+#define GEN_OPIVI_TRANS(NAME, IMM_MODE, OPIVX, CHECK)                    \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 {                                                                        \
     if (CHECK(s, a)) {                                                   \
@@ -1633,13 +1649,13 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
             gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,              \
         };                                                               \
         return opivi_trans(a->rd, a->rs1, a->rs2, a->vm,                 \
-                           fns[s->sew], s, ZX);                          \
+                           fns[s->sew], s, IMM_MODE);                    \
     }                                                                    \
     return false;                                                        \
 }
 
-GEN_OPIVI_TRANS(vadc_vim, 0, vadc_vxm, opivx_vadc_check)
-GEN_OPIVI_TRANS(vmadc_vim, 0, vmadc_vxm, opivx_vmadc_check)
+GEN_OPIVI_TRANS(vadc_vim, IMM_SX, vadc_vxm, opivx_vadc_check)
+GEN_OPIVI_TRANS(vmadc_vim, IMM_SX, vmadc_vxm, opivx_vmadc_check)
 
 /* Vector Bitwise Logical Instructions */
 GEN_OPIVV_GVEC_TRANS(vand_vv, and)
@@ -1648,9 +1664,9 @@ GEN_OPIVV_GVEC_TRANS(vxor_vv, xor)
 GEN_OPIVX_GVEC_TRANS(vand_vx, ands)
 GEN_OPIVX_GVEC_TRANS(vor_vx,  ors)
 GEN_OPIVX_GVEC_TRANS(vxor_vx, xors)
-GEN_OPIVI_GVEC_TRANS(vand_vi, 0, vand_vx, andi)
-GEN_OPIVI_GVEC_TRANS(vor_vi, 0, vor_vx,  ori)
-GEN_OPIVI_GVEC_TRANS(vxor_vi, 0, vxor_vx, xori)
+GEN_OPIVI_GVEC_TRANS(vand_vi, IMM_SX, vand_vx, andi)
+GEN_OPIVI_GVEC_TRANS(vor_vi, IMM_SX, vor_vx,  ori)
+GEN_OPIVI_GVEC_TRANS(vxor_vi, IMM_SX, vxor_vx, xori)
 
 /* Vector Single-Width Bit Shift Instructions */
 GEN_OPIVV_GVEC_TRANS(vsll_vv,  shlv)
@@ -1701,9 +1717,9 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
 
-GEN_OPIVI_GVEC_TRANS(vsll_vi, 1, vsll_vx,  shli)
-GEN_OPIVI_GVEC_TRANS(vsrl_vi, 1, vsrl_vx,  shri)
-GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
+GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_ZX, vsll_vx, shli)
+GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_ZX, vsrl_vx, shri)
+GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_ZX, vsra_vx, sari)
 
 /* Vector Narrowing Integer Right Shift Instructions */
 static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
@@ -1768,7 +1784,7 @@ GEN_OPIVX_NARROW_TRANS(vnsra_vx)
 GEN_OPIVX_NARROW_TRANS(vnsrl_vx)
 
 /* OPIVI with NARROW */
-#define GEN_OPIVI_NARROW_TRANS(NAME, ZX, OPIVX)                          \
+#define GEN_OPIVI_NARROW_TRANS(NAME, IMM_MODE, OPIVX)                    \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 {                                                                        \
     if (opivx_narrow_check(s, a)) {                                      \
@@ -1778,13 +1794,13 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
             gen_helper_##OPIVX##_w,                                      \
         };                                                               \
         return opivi_trans(a->rd, a->rs1, a->rs2, a->vm,                 \
-                           fns[s->sew], s, ZX);                          \
+                           fns[s->sew], s, IMM_MODE);                    \
     }                                                                    \
     return false;                                                        \
 }
 
-GEN_OPIVI_NARROW_TRANS(vnsra_vi, 1, vnsra_vx)
-GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
+GEN_OPIVI_NARROW_TRANS(vnsra_vi, IMM_ZX, vnsra_vx)
+GEN_OPIVI_NARROW_TRANS(vnsrl_vi, IMM_ZX, vnsrl_vx)
 
 /* Vector Integer Comparison Instructions */
 /*
@@ -1822,12 +1838,12 @@ GEN_OPIVX_TRANS(vmsle_vx, opivx_cmp_check)
 GEN_OPIVX_TRANS(vmsgtu_vx, opivx_cmp_check)
 GEN_OPIVX_TRANS(vmsgt_vx, opivx_cmp_check)
 
-GEN_OPIVI_TRANS(vmseq_vi, 0, vmseq_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsne_vi, 0, vmsne_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsle_vi, 0, vmsle_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsgtu_vi, 1, vmsgtu_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsgt_vi, 0, vmsgt_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmseq_vi, IMM_SX, vmseq_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsne_vi, IMM_SX, vmsne_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsleu_vi, IMM_ZX, vmsleu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsle_vi, IMM_SX, vmsle_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsgtu_vi, IMM_ZX, vmsgtu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsgt_vi, IMM_SX, vmsgt_vx, opivx_cmp_check)
 
 /* Vector Integer Min/Max Instructions */
 GEN_OPIVV_GVEC_TRANS(vminu_vv, umin)
@@ -2003,7 +2019,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
 
 GEN_OPIVV_TRANS(vmerge_vvm, opivv_vadc_check)
 GEN_OPIVX_TRANS(vmerge_vxm, opivx_vadc_check)
-GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vadc_check)
+GEN_OPIVI_TRANS(vmerge_vim, IMM_SX, vmerge_vxm, opivx_vadc_check)
 
 /*
  *** Vector Fixed-Point Arithmetic Instructions
@@ -2018,8 +2034,8 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
-GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
+GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
+GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
 GEN_OPIVV_TRANS(vaadd_vv, opivv_check)
@@ -2046,16 +2062,16 @@ GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
 GEN_OPIVV_TRANS(vssra_vv, opivv_check)
 GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
-GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
-GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
+GEN_OPIVI_TRANS(vssrl_vi, IMM_ZX, vssrl_vx, opivx_check)
+GEN_OPIVI_TRANS(vssra_vi, IMM_SX, vssra_vx, opivx_check)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
 GEN_OPIVV_NARROW_TRANS(vnclipu_vv)
 GEN_OPIVV_NARROW_TRANS(vnclip_vv)
 GEN_OPIVX_NARROW_TRANS(vnclipu_vx)
 GEN_OPIVX_NARROW_TRANS(vnclip_vx)
-GEN_OPIVI_NARROW_TRANS(vnclipu_vi, 1, vnclipu_vx)
-GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
+GEN_OPIVI_NARROW_TRANS(vnclipu_vi, IMM_ZX, vnclipu_vx)
+GEN_OPIVI_NARROW_TRANS(vnclip_vi, IMM_ZX, vnclip_vx)
 
 /*
  *** Vector Float Point Arithmetic Instructions
@@ -3031,7 +3047,7 @@ static bool slideup_check(DisasContext *s, arg_rmrr *a)
 
 GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
 GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
-GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
+GEN_OPIVI_TRANS(vslideup_vi, IMM_ZX, vslideup_vx, slideup_check)
 
 static bool slidedown_check(DisasContext *s, arg_rmrr *a)
 {
@@ -3042,7 +3058,7 @@ static bool slidedown_check(DisasContext *s, arg_rmrr *a)
 
 GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
 GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
-GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, slidedown_check)
+GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
@@ -3121,7 +3137,8 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
             gen_helper_vrgather_vx_w, gen_helper_vrgather_vx_d
         };
-        return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s, 1);
+        return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew],
+                           s, IMM_ZX);
     }
     return true;
 }
-- 
2.17.1


