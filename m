Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0604DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F491206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N1mpZhuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F491206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB3M-0002cU-S3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAth-00086W-9Z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:45 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:42629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtc-0005TQ-PD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:44 -0400
Received: by mail-pg1-x535.google.com with SMTP id m22so866642pgv.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fRfYEPLY7ZYXsxuuJ3MsW4upqL46MnI2RKQjrKz2E4s=;
 b=N1mpZhuSXlIhEuewdWrss26huCxfIlBh+dFeROhbtmklVafELe38DbleLXwfwaZ7NP
 gnRkgF2+a20o1nkI9hVBjteHZU7/dIpx+BZdKFrevWc25WHzfuT7xFnoS6yqvXAznek6
 rrji6m80UbQtna1scczOKSxB5u3kavSTdKyvTi4BRqtH2L4KmZ0EzfSH6RNCpFiLEi0O
 rFSbijtw6cWO+fXtWAq66V+19lOBEcrrJcjVoRtlWlf+4EevnfVZEa+D3NZgXV5lG1f/
 rtGGed44Phq9kmIDtjmRaUDyb5mYbRgj+i03FhgRixhlFUG6qqV/zn7s/GqRLO00jiUM
 fGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fRfYEPLY7ZYXsxuuJ3MsW4upqL46MnI2RKQjrKz2E4s=;
 b=mpEOarrwUj85oUPgOYcRTTPQKx1Dcrsnpqp0jQCHLcbDVwsATY/YwYwuEQiphjXz2h
 Qh8vGm4mvGFpaJZDOx87YTA6z7374oLDvz2gesOuKztTY1znTnV9yGJFRcGGXE1ANZef
 yVHA/Bdca0fLr2qVeOtRYzpqMgyVkpsJ3rHHz1ujE7PozZDbPMBDQ8jYataSimQrySsV
 686XsPiouTH5i4n7+RuCL2fLdXgnzsDyY0fHfgkWTj/cWHd4Z4/NFe91cAFkhWTRWBig
 j6zqblW8rNE8n+TMHF2fMCiWsWr7JmCxDKzN2/AdBmOngXQ/sPX7pIRfJT9kx4uG+QDd
 iApg==
X-Gm-Message-State: AOAM532HldjOJzZJpcwSFjEeNymsi48a5HSUL2YFzSBEFuBJjUIbg7Z7
 KDM1ylwKchd3DYtXpvGWWKFf66mKZK0=
X-Google-Smtp-Source: ABdhPJxnfYJJSUlIe8Z/CX301W8Bvt9MkyBVmwAkaV1R2HR+pUPzCcW/iLRv2mj4vtKWEIyxROjRbg==
X-Received: by 2002:a63:8f51:: with SMTP id r17mr26019687pgn.124.1595409517988; 
 Wed, 22 Jul 2020 02:18:37 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:37 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 16/76] target/riscv: rvv-0.9: add VMA and VTA
Date: Wed, 22 Jul 2020 17:15:39 +0800
Message-Id: <20200722091641.8834-17-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x535.google.com
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

Introduce the concepts of VMA and VTA for RVV 0.9.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h                      |  11 +-
 target/riscv/insn_trans/trans_rvv.inc.c |  62 +++++++++
 target/riscv/internals.h                |   6 +-
 target/riscv/translate.c                |   4 +
 target/riscv/vector_helper.c            | 165 +++++++++++++++++-------
 5 files changed, 195 insertions(+), 53 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a16c6ed8e6..a650df0441 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -97,6 +97,8 @@ typedef struct CPURISCVState CPURISCVState;
 FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
 FIELD(VTYPE, VFLMUL, 5, 1)
+FIELD(VTYPE, VTA, 6, 1)
+FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 9)
 FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
@@ -372,7 +374,10 @@ FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
 FIELD(TB_FLAGS, LMUL, 3, 3)
 FIELD(TB_FLAGS, SEW, 6, 3)
 /* Skip MSTATUS_VS (0x600) fields */
-FIELD(TB_FLAGS, VILL, 11, 1)
+FIELD(TB_FLAGS, VTA, 11, 1)
+FIELD(TB_FLAGS, VMA, 12, 1)
+/* Skip MSTATUS_FS (0x6000) fields */
+FIELD(TB_FLAGS, VILL, 15, 1)
 
 /*
  * A simplification for VLMAX
@@ -409,6 +414,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
                     (FIELD_EX64(env->vtype, VTYPE, VFLMUL) << 2)
                         | FIELD_EX64(env->vtype, VTYPE, VLMUL));
+        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
+                    FIELD_EX64(env->vtype, VTYPE, VTA));
+        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
+                    FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index f6f0954c60..0cbecdd786 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -250,6 +250,8 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
@@ -303,6 +305,8 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
@@ -390,6 +394,8 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
@@ -429,6 +435,8 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     fn =  fns[seq][s->sew];
     if (fn == NULL) {
@@ -521,6 +529,8 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
@@ -565,6 +575,8 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
@@ -644,6 +656,8 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldff_trans(a->rd, a->rs1, data, fn, s);
 }
@@ -754,6 +768,8 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, SEW, s->sew);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     data = FIELD_DP32(data, VDATA, WD, a->wd);
     return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
@@ -832,6 +848,8 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fn);
@@ -877,6 +895,8 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
 
     tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
@@ -1025,6 +1045,8 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     }
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
 
     tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
@@ -1120,6 +1142,8 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
@@ -1208,6 +1232,8 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
@@ -1286,6 +1312,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -1476,6 +1504,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -1654,6 +1684,7 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
         } else {
             uint32_t data = 0;
             data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);
             static gen_helper_gvec_2_ptr * const fns[4] = {
                 gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
@@ -1693,6 +1724,7 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             TCGv_ptr dest = tcg_temp_new_ptr();
             uint32_t data = 0;
             data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);
             static gen_helper_vmv_vx * const fns[4] = {
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
@@ -1732,6 +1764,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             TCGv_ptr dest;
             uint32_t data = 0;
             data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);
+            data = FIELD_DP32(data, VDATA, VMA, s->vma);
             static gen_helper_vmv_vx * const fns[4] = {
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
@@ -1848,6 +1882,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -1920,6 +1956,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
         gen_set_rm(s, 7);                                         \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);              \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);              \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
                            fns[s->sew - 1], s);                   \
     }                                                             \
@@ -1960,6 +1998,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
                            vreg_ofs(s, a->rs1),                  \
                            vreg_ofs(s, a->rs2), cpu_env, 0,      \
@@ -1997,6 +2037,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         gen_set_rm(s, 7);                                        \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
                            fns[s->sew - 1], s);                  \
     }                                                            \
@@ -2033,6 +2075,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -2068,6 +2112,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         gen_set_rm(s, 7);                                        \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
                            fns[s->sew - 1], s);                  \
     }                                                            \
@@ -2147,6 +2193,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
@@ -2289,6 +2337,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
@@ -2337,6 +2387,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
@@ -2398,6 +2450,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
@@ -2428,6 +2481,7 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
         uint32_t data = 0;
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
 
         mask = tcg_temp_new_ptr();
         src2 = tcg_temp_new_ptr();
@@ -2459,6 +2513,7 @@ static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
         uint32_t data = 0;
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
 
         mask = tcg_temp_new_ptr();
         src2 = tcg_temp_new_ptr();
@@ -2494,6 +2549,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
                            vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
                            cpu_env, 0, s->vlen / 8, data, fn);     \
@@ -2521,6 +2577,8 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         static gen_helper_gvec_3_ptr * const fns[4] = {
             gen_helper_viota_m_b, gen_helper_viota_m_h,
             gen_helper_viota_m_w, gen_helper_viota_m_d,
@@ -2547,6 +2605,8 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         static gen_helper_gvec_2_ptr * const fns[4] = {
             gen_helper_vid_v_b, gen_helper_vid_v_h,
             gen_helper_vid_v_w, gen_helper_vid_v_d,
@@ -2907,6 +2967,8 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index eaf792db5b..4538e5faf8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -25,8 +25,10 @@
 FIELD(VDATA, VM, 0, 1)
 FIELD(VDATA, LMUL, 1, 3)
 FIELD(VDATA, SEW, 4, 3)
-FIELD(VDATA, NF, 7, 4)
-FIELD(VDATA, WD, 7, 1)
+FIELD(VDATA, VTA, 7, 1)
+FIELD(VDATA, VMA, 8, 1)
+FIELD(VDATA, NF, 9, 4)
+FIELD(VDATA, WD, 9, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h(uint64_t frs1);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 72eb7c2e74..4599e3574e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -63,6 +63,8 @@ typedef struct DisasContext {
     float flmul;
     uint8_t eew;
     float emul;
+    uint8_t vta;
+    uint8_t vma;
     uint8_t sew;
     uint16_t vlen;
     bool vl_eq_vlmax;
@@ -827,6 +829,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
     ctx->flmul = flmul_table[ctx->lmul];
+    ctx->vta = FIELD_EX32(tb_flags, TB_FLAGS, VTA);
+    ctx->vma = FIELD_EX32(tb_flags, TB_FLAGS, VMA);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a7963c3a2b..83e317c500 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -102,6 +102,16 @@ static uint32_t vext_wd(uint32_t desc)
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
@@ -141,9 +151,15 @@ static void probe_pages(CPURISCVState *env, target_ulong addr,
 }
 
 #ifdef HOST_WORDS_BIGENDIAN
-static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t tot)
 {
+    if (vta == 0) {
+        /* tail element undisturbed */
+        return;
+    }
+
     /*
+     * Tail element agnostic.
      * Split the remaining range to two parts.
      * The first part is in the last uint64_t unit.
      * The second part start from the next uint64_t unit.
@@ -152,41 +168,50 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
     if (cnt % 8) {
         part1 = 8 - (cnt % 8);
         part2 = tot - cnt - part1;
-        memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
-        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
+        memset((void *)((uintptr_t)tail & ~(7ULL)), 1, part1);
+        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 1, part2);
     } else {
-        memset(tail, 0, part2);
+        memset(tail, 1, part2);
     }
 }
 #else
-static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t tot)
 {
-    memset(tail, 0, tot - cnt);
+    if (vta == 0) {
+        /* tail element undisturbed */
+        return;
+    }
+    /* tail element agnostic */
+    memset(tail, 1, tot - cnt);
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
@@ -213,7 +238,8 @@ static inline int vext_elem_mask(void *v0, int index)
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn(CPURISCVState *env, target_ulong addr,
                                uint32_t idx, void *vd, uintptr_t retaddr);
-typedef void clear_fn(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot);
+typedef void clear_fn(void *vd, uint32_t vta, uint32_t idx,
+                      uint32_t cnt, uint32_t tot);
 
 #define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)     \
 static void NAME(CPURISCVState *env, abi_ptr addr,         \
@@ -284,6 +310,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
@@ -307,7 +334,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * vlmax,
+                       env->vl * esz, vlmax * esz);
         }
     }
 }
@@ -385,6 +413,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     /* probe every access */
     probe_pages(env, base, env->vl * nf * msz, ra, access_type);
@@ -400,7 +429,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * vlmax,
+                       env->vl * esz, vlmax * esz);
         }
     }
 }
@@ -512,6 +542,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
@@ -536,7 +567,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * vlmax,
+                       env->vl * esz, vlmax * esz);
         }
     }
 }
@@ -611,6 +643,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
     target_ulong addr, offset, remain;
 
     /* probe every access*/
@@ -670,7 +703,8 @@ ProbeSuccess:
         return;
     }
     for (k = 0; k < nf; k++) {
-        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        clear_elem(vd, vta, env->vl + k * vlmax,
+                   env->vl * esz, vlmax * esz);
     }
 }
 
@@ -788,6 +822,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     uint32_t wd = vext_wd(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vta = vext_vta(desc);
 
     for (i = 0; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -803,7 +838,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
         addr = get_index_addr(base, i, vs2);
         noatomic_op(vs3, addr, wd, i, env, ra);
     }
-    clear_elem(vs3, env->vl, env->vl * esz, vlmax * esz);
+    clear_elem(vs3, vta, env->vl, env->vl * esz, vlmax * esz);
 }
 
 #define GEN_VEXT_AMO(NAME, MTYPE, ETYPE, INDEX_FN, CLEAR_FN)    \
@@ -914,6 +949,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
 
@@ -923,7 +959,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
         }
         fn(vd, vs1, vs2, i);
     }
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate the helpers for OPIVV */
@@ -978,6 +1014,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
 
@@ -987,7 +1024,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
         }
         fn(vd, s1, vs2, i);
     }
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate the helpers for OPIVX */
@@ -1175,6 +1212,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
     for (i = 0; i < vl; i++) {                                \
@@ -1184,7 +1222,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                                                               \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
     }                                                         \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);             \
 }
 
 GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC, clearb)
@@ -1204,6 +1242,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vl = env->vl;                                               \
     uint32_t esz = sizeof(ETYPE);                                        \
     uint32_t vlmax = vext_maxsz(desc) / esz;                             \
+    uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
     for (i = 0; i < vl; i++) {                                           \
@@ -1212,7 +1251,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
                                                                          \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
     }                                                                    \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                             \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                        \
 }
 
 GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC, clearb)
@@ -1353,6 +1392,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS1);                                           \
     uint32_t vlmax = vext_maxsz(desc) / esz;                              \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
@@ -1363,7 +1403,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
         *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                              \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                         \
 }
 
 GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7, clearb)
@@ -1390,6 +1430,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
     uint32_t vl = env->vl;                                            \
     uint32_t esz = sizeof(TD);                                        \
     uint32_t vlmax = vext_maxsz(desc) / esz;                          \
+    uint32_t vta = vext_vta(desc);                                    \
     uint32_t i;                                                       \
                                                                       \
     for (i = 0; i < vl; i++) {                                        \
@@ -1399,7 +1440,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                              \
         *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);                      \
     }                                                                 \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                          \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                     \
 }
 
 GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7, clearb)
@@ -2032,13 +2073,14 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
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
@@ -2053,12 +2095,13 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
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
@@ -2073,13 +2116,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
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
@@ -2094,6 +2138,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
@@ -2102,7 +2147,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
                    (ETYPE)(target_long)s1);                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);                    \
 }
 
 GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1, clearb)
@@ -2155,6 +2200,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
 
     switch (env->vxrm) {
@@ -2176,7 +2222,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
         break;
     }
 
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate helpers for fixed point instructions with OPIVV format */
@@ -2274,6 +2320,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
 
     switch (env->vxrm) {
@@ -2295,7 +2342,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
         break;
     }
 
-    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
 }
 
 /* generate helpers for fixed point instructions with OPIVX format */
@@ -3177,6 +3224,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
 {                                                         \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
     uint32_t vm = vext_vm(desc);                          \
+    uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
@@ -3186,7 +3234,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         }                                                 \
         do_##NAME(vd, vs1, vs2, i, env);                  \
     }                                                     \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);        \
 }
 
 RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
@@ -3211,6 +3259,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
 {                                                         \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
     uint32_t vm = vext_vm(desc);                          \
+    uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
@@ -3220,7 +3269,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
         }                                                 \
         do_##NAME(vd, s1, vs2, i, env);                   \
     }                                                     \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);        \
 }
 
 RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
@@ -3781,6 +3830,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
 {                                                      \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
     uint32_t vm = vext_vm(desc);                       \
+    uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
                                                        \
@@ -3793,7 +3843,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         }                                              \
         do_##NAME(vd, vs2, i, env);                    \
     }                                                  \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);     \
 }
 
 RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
@@ -4101,6 +4151,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
 {                                                      \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
     uint32_t vm = vext_vm(desc);                       \
+    uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
                                                        \
@@ -4110,7 +4161,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         }                                              \
         do_##NAME(vd, vs2, i);                         \
     }                                                  \
-    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+    CLEAR_FN(vd, vta, vl, vl * DSZ,  vlmax * DSZ);     \
 }
 
 target_ulong fclass_h(uint64_t frs1)
@@ -4186,6 +4237,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
     for (i = 0; i < vl; i++) {                                \
@@ -4193,7 +4245,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
         *((ETYPE *)vd + H(i))                                 \
           = (!vm && !vext_elem_mask(v0, i) ? s2 : s1);        \
     }                                                         \
-    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+    CLEAR_FN(vd, vta, vl, vl * esz, vlmax * esz);             \
 }
 
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
@@ -4323,6 +4375,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         void *vs2, CPURISCVState *env, uint32_t desc)     \
 {                                                         \
     uint32_t vm = vext_vm(desc);                          \
+    uint32_t vta = vext_vm(desc);                         \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;        \
@@ -4336,7 +4389,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
     *((TD *)vd + HD(0)) = s1;                             \
-    CLEAR_FN(vd, 1, sizeof(TD), tot);                     \
+    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                \
 }
 
 /* vd[0] = sum(vs1[0], vs2[*]) */
@@ -4405,6 +4458,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
                   uint32_t desc)                           \
 {                                                          \
     uint32_t vm = vext_vm(desc);                           \
+    uint32_t vta = vext_vta(desc);                         \
     uint32_t vl = env->vl;                                 \
     uint32_t i;                                            \
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;         \
@@ -4418,7 +4472,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
     }                                                      \
     *((TD *)vd + HD(0)) = s1;                              \
-    CLEAR_FN(vd, 1, sizeof(TD), tot);                      \
+    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                 \
 }
 
 /* Unordered sum */
@@ -4442,6 +4496,7 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
                             void *vs2, CPURISCVState *env, uint32_t desc)
 {
     uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
     uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
@@ -4456,13 +4511,14 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
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
@@ -4477,7 +4533,7 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
                          &env->fp_status);
     }
     *((uint64_t *)vd) = s1;
-    clearq(vd, 1, sizeof(uint64_t), tot);
+    clearq(vd, vta, 1, sizeof(uint64_t), tot);
 }
 
 /*
@@ -4625,6 +4681,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
@@ -4638,7 +4695,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
             sum++;                                                        \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
@@ -4652,6 +4709,7 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     int i;                                                                \
                                                                           \
@@ -4661,7 +4719,7 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = i;                                        \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 GEN_VEXT_VID_V(vid_v_b, uint8_t, H1, clearb)
@@ -4680,6 +4738,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
@@ -4689,7 +4748,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
@@ -4704,6 +4763,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
@@ -4714,7 +4774,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
@@ -4729,6 +4789,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -4742,7 +4803,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
@@ -4757,6 +4818,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -4770,7 +4832,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
@@ -4786,6 +4848,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t index, i;                                                    \
                                                                           \
@@ -4800,7 +4863,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
@@ -4815,6 +4878,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t index = s1, i;                                               \
                                                                           \
@@ -4828,7 +4892,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -4843,6 +4907,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t num = 0, i;                                                  \
                                                                           \
@@ -4853,7 +4918,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
         *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
         num++;                                                            \
     }                                                                     \
-    CLEAR_FN(vd, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+    CLEAR_FN(vd, vta, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));   \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
-- 
2.17.1


