Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B78AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8451206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hjpQTLgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8451206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAy0-0000ED-3a
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAta-0007q5-Ry
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:38 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:55325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtX-0005S2-Bz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:38 -0400
Received: by mail-pj1-x1031.google.com with SMTP id k1so859528pjt.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=97Clcn71S/L6VR8rlTbL9H14IlZkmHMKNRDBEmcKVTU=;
 b=hjpQTLgxNJw139lZ7V1ElII0YE9oCDTojkDSXAAHLCLqnGlI0mXKTPTWQ5Y3zyKwHc
 ge359v8z6Ln9WCDzcGu1W6SLoQ1iroy4ZMEWmINheSh2xfiVdxAl1VyQxjQtWxyi5ZZn
 mk8CJLyVuUl46tqnCFrdpaQ58ChGnwaQ0pEOF/fsZqQ1zjSXnUcEHRl5lPW1WrKjOsWK
 fJ9mwQfBm5IXM0VBZxut1c4rYWvK2sc1O/MAj5i0TI5mGHoKbuxmO+B/kMuWFrQ0r3KZ
 ZMB7iak4+Oudr8wEB5KynIXfGv/TZKABF1PxEZtqLM+5n8Ycdar9oXVsa1NNuvnRgNIA
 W6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=97Clcn71S/L6VR8rlTbL9H14IlZkmHMKNRDBEmcKVTU=;
 b=BEHZxFSIRtgLG6sQcgGzqrQd9yyisWGORw83EsHIk+Vm3Oe++h6g0/6ZBcw1w4YuAR
 gz4q5CaphTueRS8U5My78UJ74f6vxEt8lWZsm6pOJ/fHmB6Vys4zuiSlgqXihhTsZl5x
 Jvdnsx37sjQYHVxWCznIOoLHrsRHQv46OtLte6FbDoJ31tKDkiCiCQt2jAA1jCc7LGff
 UQGeQ1AEAIoIOXG0SCnynUc/nZ4wu62QT8FlHzDj3lAviydKsUscS3J7G3fhGUXu9S+j
 zr6SLxyEjZgIk7Y1Crb+JoO74xZZBkhM1NtvvKdl5CNzhxEm9a9kKvbfEKJmDMbfdrNh
 OgRQ==
X-Gm-Message-State: AOAM533h2iytbZ/0z5MTAdvYdmbEhOlD9UI+8oNs6FvNkK1fxalaJFFR
 /0EB3/YDwo6WTIRsbvVufwHMbq/T78M=
X-Google-Smtp-Source: ABdhPJwyT5uIx6zjmxyZ0kLFU6FbcIZuheXR/O+ClmK2SWy2qXmsDYn3gGWA8XY2BCR37a4oJUPvJw==
X-Received: by 2002:a17:90a:43c3:: with SMTP id
 r61mr9729709pjg.216.1595409513881; 
 Wed, 22 Jul 2020 02:18:33 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:33 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 15/76] target/riscv: rvv-0.9: add fractional LMUL
Date: Wed, 22 Jul 2020 17:15:38 +0800
Message-Id: <20200722091641.8834-16-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
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

Introduce the concepts of fractional LMUL, EEW and EMUL for RVV 0.9.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h                      | 16 ++++++++++------
 target/riscv/insn_trans/trans_rvv.inc.c | 17 ++++++++++++++---
 target/riscv/internals.h                | 11 +++++++++--
 target/riscv/translate.c                |  4 ++++
 target/riscv/vector_helper.c            | 10 ++++++++--
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0a175151da..a16c6ed8e6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,8 +96,9 @@ typedef struct CPURISCVState CPURISCVState;
 
 FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
-FIELD(VTYPE, VEDIV, 5, 2)
-FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
+FIELD(VTYPE, VFLMUL, 5, 1)
+FIELD(VTYPE, VEDIV, 8, 9)
+FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
 
 struct CPURISCVState {
@@ -368,9 +369,10 @@ typedef RISCVCPU ArchCPU;
 #include "exec/cpu-all.h"
 
 FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
-FIELD(TB_FLAGS, LMUL, 3, 2)
-FIELD(TB_FLAGS, SEW, 5, 3)
-FIELD(TB_FLAGS, VILL, 8, 1)
+FIELD(TB_FLAGS, LMUL, 3, 3)
+FIELD(TB_FLAGS, SEW, 6, 3)
+/* Skip MSTATUS_VS (0x600) fields */
+FIELD(TB_FLAGS, VILL, 11, 1)
 
 /*
  * A simplification for VLMAX
@@ -399,12 +401,14 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
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
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 018a134599..f6f0954c60 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -249,6 +249,7 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
@@ -301,6 +302,7 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
@@ -387,6 +389,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
@@ -425,6 +428,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     fn =  fns[seq][s->sew];
     if (fn == NULL) {
@@ -516,6 +520,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
@@ -559,6 +564,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
@@ -637,6 +643,7 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldff_trans(a->rd, a->rs1, data, fn, s);
 }
@@ -746,6 +753,7 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);
     data = FIELD_DP32(data, VDATA, WD, a->wd);
     return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
@@ -1644,7 +1652,8 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                              vreg_ofs(s, a->rs1),
                              MAXSZ(s), MAXSZ(s));
         } else {
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            uint32_t data = 0;
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
             static gen_helper_gvec_2_ptr * const fns[4] = {
                 gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
@@ -1682,7 +1691,8 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             TCGv_i32 desc ;
             TCGv_i64 s1_i64 = tcg_temp_new_i64();
             TCGv_ptr dest = tcg_temp_new_ptr();
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            uint32_t data = 0;
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
             static gen_helper_vmv_vx * const fns[4] = {
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
@@ -1720,7 +1730,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             TCGv_i32 desc;
             TCGv_i64 s1;
             TCGv_ptr dest;
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            uint32_t data = 0;
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
             static gen_helper_vmv_vx * const fns[4] = {
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 89fc0753bc..eaf792db5b 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -24,8 +24,9 @@
 /* share data between vector helpers and decode code */
 FIELD(VDATA, VM, 0, 1)
 FIELD(VDATA, LMUL, 1, 3)
-FIELD(VDATA, NF, 4, 4)
-FIELD(VDATA, WD, 4, 1)
+FIELD(VDATA, SEW, 4, 3)
+FIELD(VDATA, NF, 7, 4)
+FIELD(VDATA, WD, 7, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h(uint64_t frs1);
@@ -37,4 +38,10 @@ target_ulong fclass_d(uint64_t frs1);
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
index 7593b41a1f..72eb7c2e74 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -60,6 +60,9 @@ typedef struct DisasContext {
     /* vector extension */
     bool vill;
     uint8_t lmul;
+    float flmul;
+    uint8_t eew;
+    float emul;
     uint8_t sew;
     uint16_t vlen;
     bool vl_eq_vlmax;
@@ -823,6 +826,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
+    ctx->flmul = flmul_table[ctx->lmul];
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6545f91732..a7963c3a2b 100644
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
-- 
2.17.1


