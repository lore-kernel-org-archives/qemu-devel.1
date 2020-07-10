Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7744C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525342077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vi7LJsh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525342077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsmc-00088f-Ih
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcg-00054o-SG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcd-0006XC-KS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:18 -0400
Received: by mail-pl1-x644.google.com with SMTP id o1so2109353plk.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5uTP7oB6yrlRVhy7HpoTa+lnfmmPB1B/gM+zfITfhFU=;
 b=Vi7LJsh4OfYNlY5a5LOmL8u/0hsQjv+O30qVSIo+4BO4FDw7lKePe7J6KeEKnWCgAb
 /uGsXNRmPNaw/lKBqDqUdxlkEBP4T+5SmVi5RNe+1C5ykVe0A/smOMZfwhX4PKN+QzM5
 jVUsSYiIiR40ArElPmAKsehId1ShRJ8a56W2lXS7I/OxkJhBu+JAeIxhbkT/FLE8/QXl
 EbRoRakj51ygpqPbX/FLNcC2EFmJVV5aaiU9O510Quy42pW3iyWTbe5+ix7YrvonTbRX
 qwKzyyppZz1IeJon1yUNuMcTLY/QsFHnzg3h7oNB2+JT66Pf151D2wfgchFdxtazg2Ka
 dVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5uTP7oB6yrlRVhy7HpoTa+lnfmmPB1B/gM+zfITfhFU=;
 b=sdyR4f599XvYW/HmlcZZxh6juhgQVt9V9QaqItLECAx4EM5zav5zbqdlzx3CYMsJwr
 ln3/UHsUkXvN2l8BuEH/KgI/PNzaxeaMmKNaMjAP/+v9bKn3dwMrH0+VeEP8/jCkAGq+
 LLwbgGAJ9HdmY5WXI6DLAv8Je1BNGT8QffMTX57+0f8nfWdImr/+AjZ/wvh8+37NMQUE
 OSOVwENnwhbZ0eT+JGmeDf3yeCtYL3xof/nosSGglxpITDcIvqC4fG2l33gzkHlkuthw
 DVUksVWpjdpPCda8vwTjv1tsUXJMi+bNJhIB+tAdt75hR1jQHYQjkwk8wzAOA1s4iYDq
 BQsQ==
X-Gm-Message-State: AOAM530TWn9iPP+7hPPCPDXE1tSjypHl+/7GSBSORc3KllE/Ejh4STHB
 8x7fA4gnMbruckkSuUOZu0LIX3YvjrK1uw==
X-Google-Smtp-Source: ABdhPJzfRDD8uP1vNzERjtfbcT+27YdImWB1Y+wSWRncKORlCoFVdIhyNbm4Iv8CByLlm+ISy+RF/g==
X-Received: by 2002:a17:902:9f96:: with SMTP id
 g22mr14097012plq.306.1594378273348; 
 Fri, 10 Jul 2020 03:51:13 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:51:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 11/65] target/riscv: rvv-0.9: add fractional LMUL, VTA and VMA
Date: Fri, 10 Jul 2020 18:48:25 +0800
Message-Id: <20200710104920.13550-12-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x644.google.com
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
 target/riscv/cpu.h                      |  25 +++-
 target/riscv/insn_trans/trans_rvv.inc.c |  79 ++++++++++-
 target/riscv/internals.h                |  13 +-
 target/riscv/translate.c                |   8 ++
 target/riscv/vector_helper.c            | 166 +++++++++++++++++-------
 5 files changed, 232 insertions(+), 59 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 81c85bf4c2..61393c9e2e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,8 +96,11 @@ typedef struct CPURISCVState CPURISCVState;
 
 FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
-FIELD(VTYPE, VEDIV, 5, 2)
-FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
+FIELD(VTYPE, VFLMUL, 5, 1)
+FIELD(VTYPE, VTA, 6, 1)
+FIELD(VTYPE, VMA, 7, 1)
+FIELD(VTYPE, VEDIV, 8, 2)
+FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
 
 struct CPURISCVState {
@@ -369,9 +372,13 @@ typedef RISCVCPU ArchCPU;
 #include "exec/cpu-all.h"
 
 FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
-FIELD(TB_FLAGS, LMUL, 3, 2)
-FIELD(TB_FLAGS, SEW, 5, 3)
-FIELD(TB_FLAGS, VILL, 8, 1)
+FIELD(TB_FLAGS, LMUL, 3, 3)
+FIELD(TB_FLAGS, SEW, 6, 3)
+/* Skip MSTATUS_VS (0x600) fields */
+FIELD(TB_FLAGS, VTA, 11, 1)
+FIELD(TB_FLAGS, VMA, 12, 1)
+/* Skip MSTATUS_VS (0x6000) fields */
+FIELD(TB_FLAGS, VILL, 15, 1)
 
 /*
  * A simplification for VLMAX
@@ -400,12 +407,18 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     if (riscv_has_ext(env, RVV)) {
         uint32_t vlmax = vext_get_vlmax(env_archcpu(env), env->vtype);
         bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl);
+
         flags = FIELD_DP32(flags, TB_FLAGS, VILL,
                     FIELD_EX64(env->vtype, VTYPE, VILL));
         flags = FIELD_DP32(flags, TB_FLAGS, SEW,
                     FIELD_EX64(env->vtype, VTYPE, VSEW));
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
-                    FIELD_EX64(env->vtype, VTYPE, VLMUL));
+                    (FIELD_EX64(env->vtype, VTYPE, VFLMUL) << 2)
+                        | FIELD_EX64(env->vtype, VTYPE, VLMUL));
+        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
+                    FIELD_EX64(env->vtype, VTYPE, VTA));
+        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
+                    FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index e222bd78a2..1cc58c86b2 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -248,6 +248,9 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     ret = ldst_us_trans(a->rd, a->rs1, data, fn, s);
     mark_vs_dirty(s);
@@ -302,6 +305,9 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s);
 }
@@ -386,6 +392,9 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     ret  = ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
     mark_vs_dirty(s);
@@ -431,6 +440,9 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
 
     return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
@@ -516,6 +528,9 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     ret = ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
     mark_vs_dirty(s);
@@ -561,6 +576,9 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
@@ -639,6 +657,9 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     ret = ldff_trans(a->rd, a->rs1, data, fn, s);
     mark_vs_dirty(s);
@@ -750,6 +771,9 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, WD, a->wd);
     ret = amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
     mark_vs_dirty(s);
@@ -830,6 +854,8 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fn);
@@ -875,6 +901,8 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
 
     tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
@@ -1025,6 +1053,8 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     }
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
 
     tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
@@ -1122,6 +1152,8 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
@@ -1210,6 +1242,8 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
@@ -1288,6 +1322,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -1478,6 +1514,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -1654,7 +1692,9 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                              vreg_ofs(s, a->rs1),
                              MAXSZ(s), MAXSZ(s));
         } else {
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            uint32_t data = 0;
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);
             static gen_helper_gvec_2_ptr * const fns[4] = {
                 gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
@@ -1691,7 +1731,9 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             TCGv_i32 desc ;
             TCGv_i64 s1_i64 = tcg_temp_new_i64();
             TCGv_ptr dest = tcg_temp_new_ptr();
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            uint32_t data = 0;
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);
             static gen_helper_vmv_vx * const fns[4] = {
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
@@ -1727,7 +1769,10 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             TCGv_i32 desc;
             TCGv_i64 s1;
             TCGv_ptr dest;
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            uint32_t data = 0;
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);
+            data = FIELD_DP32(data, VDATA, VMA, s->vma);
             static gen_helper_vmv_vx * const fns[4] = {
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
@@ -1843,6 +1888,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -1914,6 +1961,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
         gen_set_rm(s, 7);                                         \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);              \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);              \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
                            fns[s->sew - 1], s);                   \
     }                                                             \
@@ -1954,6 +2003,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
                            vreg_ofs(s, a->rs1),                  \
                            vreg_ofs(s, a->rs2), cpu_env, 0,      \
@@ -1991,6 +2042,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         gen_set_rm(s, 7);                                        \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
                            fns[s->sew - 1], s);                  \
     }                                                            \
@@ -2027,6 +2080,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -2062,6 +2117,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         gen_set_rm(s, 7);                                        \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
                            fns[s->sew - 1], s);                  \
     }                                                            \
@@ -2141,6 +2198,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
@@ -2281,6 +2340,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
@@ -2329,6 +2390,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
@@ -2390,6 +2453,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -2419,6 +2483,7 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
         uint32_t data = 0;
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
 
         mask = tcg_temp_new_ptr();
         src2 = tcg_temp_new_ptr();
@@ -2450,6 +2515,7 @@ static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
         uint32_t data = 0;
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
 
         mask = tcg_temp_new_ptr();
         src2 = tcg_temp_new_ptr();
@@ -2485,6 +2551,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
                            vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
                            cpu_env, 0, s->vlen / 8, data, fn);     \
@@ -2511,6 +2578,8 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         static gen_helper_gvec_3_ptr * const fns[4] = {
             gen_helper_viota_m_b, gen_helper_viota_m_h,
             gen_helper_viota_m_w, gen_helper_viota_m_d,
@@ -2536,6 +2605,8 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         static gen_helper_gvec_2_ptr * const fns[4] = {
             gen_helper_vid_v_b, gen_helper_vid_v_h,
             gen_helper_vid_v_w, gen_helper_vid_v_d,
@@ -2893,6 +2964,8 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 89fc0753bc..4538e5faf8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -24,8 +24,11 @@
 /* share data between vector helpers and decode code */
 FIELD(VDATA, VM, 0, 1)
 FIELD(VDATA, LMUL, 1, 3)
-FIELD(VDATA, NF, 4, 4)
-FIELD(VDATA, WD, 4, 1)
+FIELD(VDATA, SEW, 4, 3)
+FIELD(VDATA, VTA, 7, 1)
+FIELD(VDATA, VMA, 8, 1)
+FIELD(VDATA, NF, 9, 4)
+FIELD(VDATA, WD, 9, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h(uint64_t frs1);
@@ -37,4 +40,10 @@ target_ulong fclass_d(uint64_t frs1);
 #define SEW32 2
 #define SEW64 3
 
+/* table to convert fractional LMUL value */
+static const float flmul_table[8] = {
+    1, 2, 4, 8,      /* LMUL */
+    -1,              /* reserved */
+    0.125, 0.25, 0.5 /* fractional LMUL */
+};
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 7593b41a1f..4599e3574e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -60,6 +60,11 @@ typedef struct DisasContext {
     /* vector extension */
     bool vill;
     uint8_t lmul;
+    float flmul;
+    uint8_t eew;
+    float emul;
+    uint8_t vta;
+    uint8_t vma;
     uint8_t sew;
     uint16_t vlen;
     bool vl_eq_vlmax;
@@ -823,6 +828,9 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
+    ctx->flmul = flmul_table[ctx->lmul];
+    ctx->vta = FIELD_EX32(tb_flags, TB_FLAGS, VTA);
+    ctx->vma = FIELD_EX32(tb_flags, TB_FLAGS, VMA);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6545f91732..db54288c08 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -86,9 +86,15 @@ static inline uint32_t vext_vm(uint32_t desc)
     return FIELD_EX32(simd_data(desc), VDATA, VM);
 }
 
-static inline uint32_t vext_lmul(uint32_t desc)
+static inline uint32_t vext_sew(uint32_t desc)
 {
-    return FIELD_EX32(simd_data(desc), VDATA, LMUL);
+    return 1 << (FIELD_EX32(simd_data(desc), VDATA, SEW) + 3);
+}
+
+static inline float vext_vflmul(uint32_t desc)
+{
+    uint32_t lmul = FIELD_EX32(simd_data(desc), VDATA, LMUL);
+    return flmul_table[lmul];
 }
 
 static uint32_t vext_wd(uint32_t desc)
@@ -96,6 +102,16 @@ static uint32_t vext_wd(uint32_t desc)
     return FIELD_EX32(simd_data(desc), VDATA, WD);
 }
 
+static inline uint32_t vext_vta(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VTA);
+}
+
+static inline uint32_t vext_vma(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VMA);
+}
+
 /*
  * Get vector group length in bytes. Its range is [64, 2048].
  *
@@ -135,8 +151,13 @@ static void probe_pages(CPURISCVState *env, target_ulong addr,
 }
 
 #ifdef HOST_WORDS_BIGENDIAN
-static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t tot)
 {
+    /* tail element undisturbed */
+    if (vta == 0) {
+        return;
+    }
+
     /*
      * Split the remaining range to two parts.
      * The first part is in the last uint64_t unit.
@@ -153,34 +174,43 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
     }
 }
 #else
-static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t tot)
 {
+    /* tail element undisturbed */
+    if (vta == 0) {
+        return;
+    }
+
     memset(tail, 0, tot - cnt);
 }
 #endif
 
-static void clearb(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+static void clearb(void *vd, uint32_t vta, uint32_t idx,
+                   uint32_t cnt, uint32_t tot)
 {
     int8_t *cur = ((int8_t *)vd + H1(idx));
-    vext_clear(cur, cnt, tot);
+    vext_clear(cur, vta, cnt, tot);
 }
 
-static void clearh(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+static void clearh(void *vd, uint32_t vta, uint32_t idx,
+                   uint32_t cnt, uint32_t tot)
 {
     int16_t *cur = ((int16_t *)vd + H2(idx));
-    vext_clear(cur, cnt, tot);
+    vext_clear(cur, vta, cnt, tot);
 }
 
-static void clearl(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+static void clearl(void *vd, uint32_t vta, uint32_t idx,
+                   uint32_t cnt, uint32_t tot)
 {
     int32_t *cur = ((int32_t *)vd + H4(idx));
-    vext_clear(cur, cnt, tot);
+    vext_clear(cur, vta, cnt, tot);
 }
 
-static void clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+static void clearq(void *vd, uint32_t vta, uint32_t idx,
+                   uint32_t cnt, uint32_t tot)
 {
     int64_t *cur = (int64_t *)vd + idx;
-    vext_clear(cur, cnt, tot);
+    vext_clear(cur, vta, cnt, tot);
 }
 
 static inline void vext_set_elem_mask(void *v0, int index,
@@ -207,7 +237,8 @@ static inline int vext_elem_mask(void *v0, int index)
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn(CPURISCVState *env, target_ulong addr,
                                uint32_t idx, void *vd, uintptr_t retaddr);
-typedef void clear_fn(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot);
+typedef void clear_fn(void *vd, uint32_t vta, uint32_t idx,
+                      uint32_t cnt, uint32_t tot);
 
 #define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)     \
 static void NAME(CPURISCVState *env, abi_ptr addr,         \
@@ -278,6 +309,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
@@ -301,7 +333,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * vlmax,
+                       env->vl * esz, vlmax * esz);
         }
     }
 }
@@ -379,6 +412,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     /* probe every access */
     probe_pages(env, base, env->vl * nf * msz, ra, access_type);
@@ -394,7 +428,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * vlmax,
+                       env->vl * esz, vlmax * esz);
         }
     }
 }
@@ -506,6 +541,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
@@ -530,7 +566,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * vlmax,
+                       env->vl * esz, vlmax * esz);
         }
     }
 }
@@ -605,6 +642,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
     target_ulong addr, offset, remain;
 
     /* probe every access*/
@@ -664,7 +702,8 @@ ProbeSuccess:
         return;
     }
     for (k = 0; k < nf; k++) {
-        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        clear_elem(vd, vta, env->vl + k * vlmax,
+                   env->vl * esz, vlmax * esz);
     }
 }
 
@@ -782,6 +821,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     uint32_t wd = vext_wd(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     for (i = 0; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -797,7 +837,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
         addr = get_index_addr(base, i, vs2);
         noatomic_op(vs3, addr, wd, i, env, ra);
     }
-    clear_elem(vs3, env->vl, env->vl * esz, vlmax * esz);
+    clear_elem(vs3, vta, env->vl, env->vl * esz, vlmax * esz);
 }
 
 #define GEN_VEXT_AMO(NAME, MTYPE, ETYPE, INDEX_FN, CLEAR_FN)    \
@@ -908,6 +948,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
 
@@ -917,7 +958,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
         }
         fn(vd, vs1, vs2, i);
     }
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate the helpers for OPIVV */
@@ -972,6 +1013,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
 
@@ -981,7 +1023,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
         }
         fn(vd, s1, vs2, i);
     }
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate the helpers for OPIVX */
@@ -1169,6 +1211,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
     for (i = 0; i < vl; i++) {                                \
@@ -1178,7 +1221,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                                                               \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
     }                                                         \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);             \
 }
 
 GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC, clearb)
@@ -1198,6 +1241,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vl = env->vl;                                               \
     uint32_t esz = sizeof(ETYPE);                                        \
     uint32_t vlmax = vext_maxsz(desc) / esz;                             \
+    uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
     for (i = 0; i < vl; i++) {                                           \
@@ -1206,7 +1250,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
                                                                          \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
     }                                                                    \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                             \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                        \
 }
 
 GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC, clearb)
@@ -1347,6 +1391,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS1);                                           \
     uint32_t vlmax = vext_maxsz(desc) / esz;                              \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
@@ -1357,7 +1402,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
         *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                              \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                         \
 }
 
 GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7, clearb)
@@ -1384,6 +1429,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
     uint32_t vl = env->vl;                                            \
     uint32_t esz = sizeof(TD);                                        \
     uint32_t vlmax = vext_maxsz(desc) / esz;                          \
+    uint32_t vta = vext_vta(desc);                                    \
     uint32_t i;                                                       \
                                                                       \
     for (i = 0; i < vl; i++) {                                        \
@@ -1393,7 +1439,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                              \
         *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);                      \
     }                                                                 \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                          \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                     \
 }
 
 GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7, clearb)
@@ -2026,13 +2072,14 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
         *((ETYPE *)vd + H(i)) = s1;                                  \
     }                                                                \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                    \
 }
 
 GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1, clearb)
@@ -2047,12 +2094,13 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
     }                                                                \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                    \
 }
 
 GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1, clearb)
@@ -2067,13 +2115,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
         *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
     }                                                                \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                    \
 }
 
 GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1, clearb)
@@ -2088,6 +2137,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
@@ -2096,7 +2146,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
                    (ETYPE)(target_long)s1);                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                    \
 }
 
 GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1, clearb)
@@ -2149,6 +2199,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
 
     switch (env->vxrm) {
@@ -2170,7 +2221,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
         break;
     }
 
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate helpers for fixed point instructions with OPIVV format */
@@ -2268,6 +2319,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
 
     switch (env->vxrm) {
@@ -2289,7 +2341,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
         break;
     }
 
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate helpers for fixed point instructions with OPIVX format */
@@ -3171,6 +3223,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
 {                                                         \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
     uint32_t vm = vext_vm(desc);                          \
+    uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
@@ -3180,7 +3233,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         }                                                 \
         do_##NAME(vd, vs1, vs2, i, env);                  \
     }                                                     \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);        \
 }
 
 RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
@@ -3205,6 +3258,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
 {                                                         \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
     uint32_t vm = vext_vm(desc);                          \
+    uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
@@ -3214,7 +3268,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
         }                                                 \
         do_##NAME(vd, s1, vs2, i, env);                   \
     }                                                     \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);        \
 }
 
 RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
@@ -3775,6 +3829,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
 {                                                      \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
     uint32_t vm = vext_vm(desc);                       \
+    uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
                                                        \
@@ -3787,7 +3842,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         }                                              \
         do_##NAME(vd, vs2, i, env);                    \
     }                                                  \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);     \
 }
 
 RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
@@ -4095,6 +4150,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
 {                                                      \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
     uint32_t vm = vext_vm(desc);                       \
+    uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
                                                        \
@@ -4104,7 +4160,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         }                                              \
         do_##NAME(vd, vs2, i);                         \
     }                                                  \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);     \
 }
 
 target_ulong fclass_h(uint64_t frs1)
@@ -4180,6 +4236,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
     for (i = 0; i < vl; i++) {                                \
@@ -4187,7 +4244,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
         *((ETYPE *)vd + H(i))                                 \
           = (!vm && !vext_elem_mask(v0, i) ? s2 : s1);        \
     }                                                         \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);             \
 }
 
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
@@ -4317,6 +4374,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         void *vs2, CPURISCVState *env, uint32_t desc)     \
 {                                                         \
     uint32_t vm = vext_vm(desc);                          \
+    uint32_t vta = vext_vm(desc);                         \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;        \
@@ -4330,7 +4388,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
     *((TD *)vd + HD(0)) = s1;                             \
-    CLEAR_FN(vd, 1, sizeof(TD), tot);                     \
+    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                \
 }
 
 /* vd[0] = sum(vs1[0], vs2[*]) */
@@ -4399,6 +4457,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
                   uint32_t desc)                           \
 {                                                          \
     uint32_t vm = vext_vm(desc);                           \
+    uint32_t vta = vext_vta(desc);                         \
     uint32_t vl = env->vl;                                 \
     uint32_t i;                                            \
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;         \
@@ -4412,7 +4471,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
     }                                                      \
     *((TD *)vd + HD(0)) = s1;                              \
-    CLEAR_FN(vd, 1, sizeof(TD), tot);                      \
+    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                 \
 }
 
 /* Unordered sum */
@@ -4436,6 +4495,7 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
                             void *vs2, CPURISCVState *env, uint32_t desc)
 {
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
@@ -4450,13 +4510,14 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
                          &env->fp_status);
     }
     *((uint32_t *)vd + H4(0)) = s1;
-    clearl(vd, 1, sizeof(uint32_t), tot);
+    clearl(vd, vta, 1, sizeof(uint32_t), tot);
 }
 
 void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
                             void *vs2, CPURISCVState *env, uint32_t desc)
 {
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
@@ -4471,7 +4532,7 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
                          &env->fp_status);
     }
     *((uint64_t *)vd) = s1;
-    clearq(vd, 1, sizeof(uint64_t), tot);
+    clearq(vd, vta, 1, sizeof(uint64_t), tot);
 }
 
 /*
@@ -4619,6 +4680,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
@@ -4632,7 +4694,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
             sum++;                                                        \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
@@ -4646,6 +4708,7 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     int i;                                                                \
                                                                           \
@@ -4655,7 +4718,7 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = i;                                        \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 GEN_VEXT_VID_V(vid_v_b, uint8_t, H1, clearb)
@@ -4674,6 +4737,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
@@ -4683,7 +4747,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
@@ -4698,6 +4762,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
@@ -4708,7 +4773,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
@@ -4723,6 +4788,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -4736,7 +4802,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
@@ -4751,6 +4817,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -4764,7 +4831,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
@@ -4780,6 +4847,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t index, i;                                                    \
                                                                           \
@@ -4794,7 +4862,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
@@ -4809,6 +4877,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t index = s1, i;                                               \
                                                                           \
@@ -4822,7 +4891,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -4837,6 +4906,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t num = 0, i;                                                  \
                                                                           \
@@ -4847,7 +4917,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
         *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
         num++;                                                            \
     }                                                                     \
-    CLEAR_FN(vd, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+    CLEAR_FN(vd, vta, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));   \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
-- 
2.17.1


