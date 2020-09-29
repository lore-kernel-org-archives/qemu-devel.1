Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F62C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B6020774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FHYaKOXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B6020774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLhW-0004OA-9L
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNL08-0008Sb-Ck
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:25 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNL04-0002Y9-Al
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id m34so4628174pgl.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9LfysLaLJosoTgoqFjJbkpZ+PPozIDfe3+SYrWh9l/w=;
 b=FHYaKOXuGWszhzps8kZLDz3tiNl23L3N9VBsJDtC9GD2NEsMP7QAF3JRKzXlNwn+JK
 MLwXdZAcZ1axYIOTWltcpQL5DZ+FDRfqs+4yR/FVc1f7xDG/nBjvDTR/Qw1EK9As2O2Z
 Yc+/1kCJbKqKyMmIA0rtj8QIZG9bZdGxkGiG88CAv9zo5ltrWAMh0sDUrJNZkJRRu1Je
 Ff86v16ihK2j90C3iBoQ8AQoT0oLZikUr84TqYY3wxkfFb3Sc/oa7/juS5P2lqMLI5zG
 OySEVR1wqhBQ/JlNp4QXU3VJisILH7/xDsw6lrxtld8VuvHL+SwYyhk2OY0dOnWD75wg
 xdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9LfysLaLJosoTgoqFjJbkpZ+PPozIDfe3+SYrWh9l/w=;
 b=kyVqK4UBQW01JBsHZjxtGWENXKEBFcBT3RF4ZbO5j32tp0ofD6ByjIzywG6+QQDQP1
 sZI8e/v6RSODXQKC5DiII2GvfwyAUWMjaZ2qA/b5Hl62GmpDYuNp/WD6b1VhIKZ7dAtx
 bG4VI7nBo8kRGwvruYKK05DwkGIn3NONlPMCz17w5YWd0daWrva/dZtVVFYtq6Ijw+Zw
 6mLEDveiWp0Crn7Nhu2qampf9YYW9DF6hFysgURFV5IGof7pZiF59VkNj9K02JIjmePN
 LA5Mam7QzQ2vIU8z6eaLjvXe0PqXMHLnM7+u5Bg+VC8DGJpCupeRsVHTllC6Kc/gbA9J
 sZTQ==
X-Gm-Message-State: AOAM531I3ee9zhcLrKZywXmcDfqdL5AjzeFBadoHRvIfO7j1Nsv6R9vY
 Lh+zUrKmQSBO87odepI7NSknSDi75TwxUA==
X-Google-Smtp-Source: ABdhPJzWK7cOHV+rJfn+L3leKipGtBnoUsC0PrUSUzSvlHXwljPM1s2obhWSfc6paNtE6LRSNRGtRg==
X-Received: by 2002:a17:902:9f97:b029:d2:89d4:bc with SMTP id
 g23-20020a1709029f97b02900d289d400bcmr6241010plq.12.1601406558074; 
 Tue, 29 Sep 2020 12:09:18 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:09:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 67/68] target/riscv: implement vstart CSR
Date: Wed, 30 Sep 2020 03:04:42 +0800
Message-Id: <20200929190448.31116-68-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x542.google.com
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

* Update and check vstart value for vector instructions.
* Add whole register move instruction helper functions as we have to
  call helper function for case where vstart is not zero.

Signed-off-by: Frank Chang <frank.chang@sifive.com>

--

Perhaps we can remove the probe functions in vector_helper.c to align with
the hardware's behavior, which raise the memory access exceptions and
update vstart value at the exact processing vector element.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/csr.c                      |   6 +-
 target/riscv/helper.h                   |   5 +
 target/riscv/insn_trans/trans_rvv.c.inc |  73 ++++++---
 target/riscv/translate.c                |   6 +-
 target/riscv/vector_helper.c            | 201 +++++++++++++++++-------
 5 files changed, 206 insertions(+), 85 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 21eeb4b791..bdf93a7fd0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -311,7 +311,11 @@ static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
     env->mstatus |= MSTATUS_VS;
 #endif
 
-    env->vstart = val;
+    /*
+     * The vstart CSR is defined to have only enough writable bits
+     * to hold the largest element index, i.e. lg2(VLEN) bits.
+     */
+    env->vstart = val & ~(~0ULL << ctzl(env_archcpu(env)->cfg.vlen));
     return 0;
 }
 
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e5510be6f8..ec1d7ea443 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1123,6 +1123,11 @@ DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
 
+DEF_HELPER_4(vmv1r_v, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv2r_v, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv4r_v, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv8r_v, void, ptr, ptr, env, i32)
+
 DEF_HELPER_5(vzext_vf2_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vzext_vf2_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vzext_vf2_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 576d20c6eb..7a1571cee8 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3034,7 +3034,8 @@ GEN_MM_TRANS(vmxnor_mm)
 static bool trans_vpopc_m(DisasContext *s, arg_rmr *a)
 {
     if (require_rvv(s) &&
-        vext_check_isa_ill(s)) {
+        vext_check_isa_ill(s) &&
+        s->vstart == 0) {
         TCGv_ptr src2, mask;
         TCGv dst;
         TCGv_i32 desc;
@@ -3067,7 +3068,8 @@ static bool trans_vpopc_m(DisasContext *s, arg_rmr *a)
 static bool trans_vfirst_m(DisasContext *s, arg_rmr *a)
 {
     if (require_rvv(s) &&
-        vext_check_isa_ill(s)) {
+        vext_check_isa_ill(s) &&
+        s->vstart == 0) {
         TCGv_ptr src2, mask;
         TCGv dst;
         TCGv_i32 desc;
@@ -3104,7 +3106,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     if (require_rvv(s) &&                                          \
         vext_check_isa_ill(s) &&                                   \
         require_vm(a->vm, a->rd) &&                                \
-        (a->rd != a->rs2)) {                                       \
+        (a->rd != a->rs2) &&                                       \
+        (s->vstart == 0)) {                                        \
         uint32_t data = 0;                                         \
         gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
         TCGLabel *over = gen_new_label();                          \
@@ -3133,7 +3136,8 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         vext_check_isa_ill(s) &&
         require_noover(a->rd, s->lmul, a->rs2, 0) &&
         require_vm(a->vm, a->rd) &&
-        require_align(a->rd, s->lmul)) {
+        require_align(a->rd, s->lmul) &&
+        (s->vstart == 0)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -3355,6 +3359,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         TCGLabel *over = gen_new_label();
 
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
         s1 = tcg_temp_new();
@@ -3410,8 +3415,9 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         TCGv_i64 t1;
         TCGLabel *over = gen_new_label();
 
-        /* if vl == 0, skip vector register write back */
+        /* if vl == 0 or vstart >= vl, skip vector register write back */
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
@@ -3573,7 +3579,8 @@ static bool vcompress_vm_check(DisasContext *s, arg_r *a)
            require_align(a->rd, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
            (a->rd != a->rs2) &&
-           require_noover(a->rd, s->lmul, a->rs1, 0);
+           require_noover(a->rd, s->lmul, a->rs1, 0) &&
+           (s->vstart == 0);
 }
 
 static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
@@ -3602,26 +3609,40 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
  * Whole Vector Register Move Instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 17.6)
  */
-#define GEN_VMV_WHOLE_TRANS(NAME, LEN)                          \
-static bool trans_##NAME(DisasContext *s, arg_##NAME * a)       \
-{                                                               \
-    if (require_rvv(s) &&                                       \
-        QEMU_IS_ALIGNED(a->rd, LEN) &&                          \
-        QEMU_IS_ALIGNED(a->rs2, LEN)) {                         \
-        /* EEW = 8 */                                           \
-        tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),              \
-                         vreg_ofs(s, a->rs2),                   \
-                         s->vlen / 8 * LEN, s->vlen / 8 * LEN); \
-        mark_vs_dirty(s);                                       \
-        return true;                                            \
-    }                                                           \
-    return false;                                               \
-}
-
-GEN_VMV_WHOLE_TRANS(vmv1r_v, 1)
-GEN_VMV_WHOLE_TRANS(vmv2r_v, 2)
-GEN_VMV_WHOLE_TRANS(vmv4r_v, 4)
-GEN_VMV_WHOLE_TRANS(vmv8r_v, 8)
+#define GEN_VMV_WHOLE_TRANS(NAME, LEN, SEQ)                             \
+static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
+{                                                                       \
+    if (require_rvv(s) &&                                               \
+        QEMU_IS_ALIGNED(a->rd, LEN) &&                                  \
+        QEMU_IS_ALIGNED(a->rs2, LEN)) {                                 \
+        uint32_t maxsz = (s->vlen >> 3) * LEN;                          \
+        if (s->vstart == 0) {                                           \
+            /* EEW = 8 */                                               \
+            tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),                  \
+                             vreg_ofs(s, a->rs2), maxsz, maxsz);        \
+            mark_vs_dirty(s);                                           \
+        } else {                                                        \
+            TCGLabel *over = gen_new_label();                           \
+            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
+                                                                        \
+            static gen_helper_gvec_2_ptr * const fns[4] = {             \
+                gen_helper_vmv1r_v, gen_helper_vmv2r_v,                 \
+                gen_helper_vmv4r_v, gen_helper_vmv8r_v,                 \
+            };                                                          \
+            tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
+                               cpu_env, 0, maxsz, 0, fns[SEQ]);         \
+            mark_vs_dirty(s);                                           \
+            gen_set_label(over);                                        \
+        }                                                               \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_VMV_WHOLE_TRANS(vmv1r_v, 1, 0)
+GEN_VMV_WHOLE_TRANS(vmv2r_v, 2, 1)
+GEN_VMV_WHOLE_TRANS(vmv4r_v, 4, 2)
+GEN_VMV_WHOLE_TRANS(vmv8r_v, 8, 3)
 
 static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
 {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e6f4a662f5..7f923f2f12 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -33,7 +33,7 @@
 #include "internals.h"
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_pc, cpu_vl;
+static TCGv cpu_gpr[32], cpu_pc, cpu_vl, cpu_vstart;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -75,6 +75,7 @@ typedef struct DisasContext {
     int8_t lmul;
     uint8_t sew;
     uint16_t vlen;
+    target_ulong vstart;
     bool vl_eq_vlmax;
 } DisasContext;
 
@@ -869,6 +870,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = sextract32(FIELD_EX32(tb_flags, TB_FLAGS, LMUL), 0, 3);
+    ctx->vstart = env->vstart;
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
@@ -985,6 +987,8 @@ void riscv_translate_init(void)
 
     cpu_pc = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, pc), "pc");
     cpu_vl = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, vl), "vl");
+    cpu_vstart = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, vstart),
+                            "vstart");
     load_res = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_val),
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 16331939b6..efa32565d9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -232,14 +232,14 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t max_elems = vext_max_elems(desc, esz);
 
     /* probe every access*/
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         probe_pages(env, base + stride * i, nf << esz, ra, access_type);
     }
     /* do real access */
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         k = 0;
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
@@ -249,7 +249,9 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
             ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
+        env->vstart = i;
     }
+    env->vstart = 0;
 }
 
 #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)                        \
@@ -299,14 +301,16 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     /* probe every access */
     probe_pages(env, base, env->vl * (nf << esz), ra, access_type);
     /* load bytes from guest memory */
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << esz);
             ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
+        env->vstart = i;
     }
+    env->vstart = 0;
 }
 
 /*
@@ -387,7 +391,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t max_elems = vext_max_elems(desc, esz);
 
     /* probe every access*/
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
@@ -395,7 +399,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
                     access_type);
     }
     /* load bytes from guest memory */
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         k = 0;
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
@@ -405,7 +409,9 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
             ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
+        env->vstart = i;
     }
+    env->vstart = 0;
 }
 
 #define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)                  \
@@ -476,7 +482,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     target_ulong addr, offset, remain;
 
     /* probe every access*/
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
@@ -516,7 +522,7 @@ ProbeSuccess:
     if (vl != 0) {
         env->vl = vl;
     }
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         k = 0;
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
@@ -527,6 +533,7 @@ ProbeSuccess:
             k++;
         }
     }
+    env->vstart = 0;
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
@@ -550,21 +557,37 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
                 vext_ldst_elem_fn *ldst_elem, uint32_t esz, uintptr_t ra,
                 MMUAccessType access_type)
 {
-    uint32_t i, k;
+    uint32_t i, k, off, pos;
     uint32_t nf = vext_nf(desc);
     uint32_t vlenb = env_archcpu(env)->cfg.vlen >> 3;
     uint32_t max_elems = vlenb >> esz;
 
     /* probe every access */
-    probe_pages(env, base, vlenb * nf, ra, access_type);
+    probe_pages(env, base, max_elems * nf, ra, access_type);
 
-    /* load bytes from guest memory */
-    for (k = 0; k < nf; k++) {
+    k = env->vstart / max_elems;
+    off = env->vstart % max_elems;
+
+    if (off) {
+        /* load/store rest of elements of current segment pointed by vstart */
+        for (pos = off; pos < max_elems; pos++) {
+            target_ulong addr = base + ((pos + k * max_elems) << esz);
+            ldst_elem(env, addr, pos + k * max_elems, vd, ra);
+            env->vstart++;
+        }
+        k++;
+    }
+
+    /* load/store elements for rest of segments */
+    for (; k < nf; k++) {
         for (i = 0; i < max_elems; i++) {
             target_ulong addr = base + ((i + k * max_elems) << esz);
             ldst_elem(env, addr, i + k * max_elems, vd, ra);
+            env->vstart++;
         }
     }
+
+    env->vstart = 0;
 }
 
 #define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN)      \
@@ -725,20 +748,21 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     uint32_t wd = vext_wd(desc);
     uint32_t vm = vext_vm(desc);
 
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         probe_pages(env, get_index_addr(base, i, vs2), esz, ra, MMU_DATA_LOAD);
         probe_pages(env, get_index_addr(base, i, vs2), esz, ra, MMU_DATA_STORE);
     }
-    for (i = 0; i < env->vl; i++) {
+    for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         addr = get_index_addr(base, i, vs2);
         noatomic_op(vs3, addr, wd, i, env, ra);
     }
+    env->vstart = 0;
 }
 
 #define GEN_VEXT_AMO(NAME, ETYPE, INDEX_FN)                     \
@@ -895,12 +919,13 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vl = env->vl;
     uint32_t i;
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, vs1, vs2, i);
     }
+    env->vstart = 0;
 }
 
 /* generate the helpers for OPIVV */
@@ -957,12 +982,13 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vl = env->vl;
     uint32_t i;
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, s1, vs2, i);
     }
+    env->vstart = 0;
 }
 
 /* generate the helpers for OPIVX */
@@ -1150,13 +1176,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vl = env->vl;                                    \
     uint32_t i;                                               \
                                                               \
-    for (i = 0; i < vl; i++) {                                \
+    for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         ETYPE carry = vext_elem_mask(v0, i);                  \
                                                               \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
     }                                                         \
+    env->vstart = 0;                                          \
 }
 
 GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC)
@@ -1176,12 +1203,13 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vl = env->vl;                                               \
     uint32_t i;                                                          \
                                                                          \
-    for (i = 0; i < vl; i++) {                                           \
+    for (i = env->vstart; i < vl; i++) {                                 \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
         ETYPE carry = vext_elem_mask(v0, i);                             \
                                                                          \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
     }                                                                    \
+    env->vstart = 0;                                          \
 }
 
 GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC)
@@ -1206,12 +1234,13 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t i;                                               \
                                                               \
-    for (i = 0; i < vl; i++) {                                \
+    for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         ETYPE carry = !vm && vext_elem_mask(v0, i);           \
         vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));      \
     }                                                         \
+    env->vstart = 0;                                          \
 }
 
 GEN_VEXT_VMADC_VVM(vmadc_vvm_b, uint8_t,  H1, DO_MADC)
@@ -1232,12 +1261,13 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
     uint32_t vm = vext_vm(desc);                                \
     uint32_t i;                                                 \
                                                                 \
-    for (i = 0; i < vl; i++) {                                  \
+    for (i = env->vstart; i < vl; i++) {                        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
         ETYPE carry = !vm && vext_elem_mask(v0, i);             \
         vext_set_elem_mask(vd, i,                               \
                 DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
     }                                                           \
+    env->vstart = 0;                                            \
 }
 
 GEN_VEXT_VMADC_VXM(vmadc_vxm_b, uint8_t,  H1, DO_MADC)
@@ -1314,7 +1344,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
-    for (i = 0; i < vl; i++) {                                            \
+    for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
@@ -1322,6 +1352,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
         *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
     }                                                                     \
+    env->vstart = 0;                                                      \
 }
 
 GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7)
@@ -1348,13 +1379,14 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     uint32_t vl = env->vl;                                  \
     uint32_t i;                                             \
                                                             \
-    for (i = 0; i < vl; i++) {                              \
+    for (i = env->vstart; i < vl; i++) {                    \
         if (!vm && !vext_elem_mask(v0, i)) {                \
             continue;                                       \
         }                                                   \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                    \
         *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);            \
     }                                                       \
+    env->vstart = 0;                                        \
 }
 
 GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7)
@@ -1401,7 +1433,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vl = env->vl;                                    \
     uint32_t i;                                               \
                                                               \
-    for (i = 0; i < vl; i++) {                                \
+    for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         if (!vm && !vext_elem_mask(v0, i)) {                  \
@@ -1409,6 +1441,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
         }                                                     \
         vext_set_elem_mask(vd, i, DO_OP(s2, s1));             \
     }                                                         \
+    env->vstart = 0;                                          \
 }
 
 GEN_VEXT_CMP_VV(vmseq_vv_b, uint8_t,  H1, DO_MSEQ)
@@ -1449,7 +1482,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
     uint32_t vl = env->vl;                                          \
     uint32_t i;                                                     \
                                                                     \
-    for (i = 0; i < vl; i++) {                                      \
+    for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
         if (!vm && !vext_elem_mask(v0, i)) {                        \
             continue;                                               \
@@ -1457,6 +1490,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
         vext_set_elem_mask(vd, i,                                   \
                 DO_OP(s2, (ETYPE)(target_long)s1));                 \
     }                                                               \
+    env->vstart = 0;                                                \
 }
 
 GEN_VEXT_CMP_VX(vmseq_vx_b, uint8_t,  H1, DO_MSEQ)
@@ -1979,10 +2013,11 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vl = env->vl;                                           \
     uint32_t i;                                                      \
                                                                      \
-    for (i = 0; i < vl; i++) {                                       \
+    for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
         *((ETYPE *)vd + H(i)) = s1;                                  \
     }                                                                \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1)
@@ -1997,9 +2032,10 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vl = env->vl;                                           \
     uint32_t i;                                                      \
                                                                      \
-    for (i = 0; i < vl; i++) {                                       \
+    for (i = env->vstart; i < vl; i++) {                             \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
     }                                                                \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1)
@@ -2014,10 +2050,11 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vl = env->vl;                                           \
     uint32_t i;                                                      \
                                                                      \
-    for (i = 0; i < vl; i++) {                                       \
+    for (i = env->vstart; i < vl; i++) {                             \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
         *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
     }                                                                \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1)
@@ -2032,12 +2069,13 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vl = env->vl;                                           \
     uint32_t i;                                                      \
                                                                      \
-    for (i = 0; i < vl; i++) {                                       \
+    for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
         ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
                    (ETYPE)(target_long)s1);                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1)
@@ -2074,12 +2112,13 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn)
 {
-    for (uint32_t i = 0; i < vl; i++) {
+    for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, vs1, vs2, i, env, vxrm);
     }
+    env->vstart = 0;
 }
 
 static inline void
@@ -2190,12 +2229,13 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn)
 {
-    for (uint32_t i = 0; i < vl; i++) {
+    for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, s1, vs2, i, env, vxrm);
     }
+    env->vstart = 0;
 }
 
 static inline void
@@ -2977,12 +3017,13 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
-    for (i = 0; i < vl; i++) {                            \
+    for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             continue;                                     \
         }                                                 \
         do_##NAME(vd, vs1, vs2, i, env);                  \
     }                                                     \
+    env->vstart = 0;                                      \
 }
 
 RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
@@ -3009,12 +3050,13 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
-    for (i = 0; i < vl; i++) {                            \
+    for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             continue;                                     \
         }                                                 \
         do_##NAME(vd, s1, vs2, i, env);                   \
     }                                                     \
+    env->vstart = 0;                                      \
 }
 
 RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
@@ -3580,12 +3622,13 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     if (vl == 0) {                                     \
         return;                                        \
     }                                                  \
-    for (i = 0; i < vl; i++) {                         \
+    for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
             continue;                                  \
         }                                              \
         do_##NAME(vd, vs2, i, env);                    \
     }                                                  \
+    env->vstart = 0;                                   \
 }
 
 RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
@@ -3716,7 +3759,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vl = env->vl;                                    \
     uint32_t i;                                               \
                                                               \
-    for (i = 0; i < vl; i++) {                                \
+    for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         if (!vm && !vext_elem_mask(v0, i)) {                  \
@@ -3725,6 +3768,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
         vext_set_elem_mask(vd, i,                             \
                            DO_OP(s2, s1, &env->fp_status));   \
     }                                                         \
+    env->vstart = 0;                                          \
 }
 
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
@@ -3739,7 +3783,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vl = env->vl;                                          \
     uint32_t i;                                                     \
                                                                     \
-    for (i = 0; i < vl; i++) {                                      \
+    for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
         if (!vm && !vext_elem_mask(v0, i)) {                        \
             continue;                                               \
@@ -3747,6 +3791,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
         vext_set_elem_mask(vd, i,                                   \
                            DO_OP(s2, (ETYPE)s1, &env->fp_status));  \
     }                                                               \
+    env->vstart = 0;                                                \
 }
 
 GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
@@ -3855,12 +3900,13 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
                                                        \
-    for (i = 0; i < vl; i++) {                         \
+    for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
             continue;                                  \
         }                                              \
         do_##NAME(vd, vs2, i);                         \
     }                                                  \
+    env->vstart = 0;                                   \
 }
 
 target_ulong fclass_h(uint64_t frs1)
@@ -3936,11 +3982,12 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vl = env->vl;                                    \
     uint32_t i;                                               \
                                                               \
-    for (i = 0; i < vl; i++) {                                \
+    for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         *((ETYPE *)vd + H(i))                                 \
           = (!vm && !vext_elem_mask(v0, i) ? s2 : s1);        \
     }                                                         \
+    env->vstart = 0;                                          \
 }
 
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2)
@@ -4084,7 +4131,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
-    for (i = 0; i < vl; i++) {                            \
+    for (i = env->vstart; i < vl; i++) {                  \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             continue;                                     \
@@ -4092,6 +4139,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
     *((TD *)vd + HD(0)) = s1;                             \
+    env->vstart = 0;                                      \
 }
 
 /* vd[0] = sum(vs1[0], vs2[*]) */
@@ -4164,7 +4212,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     uint32_t i;                                            \
     TD s1 =  *((TD *)vs1 + HD(0));                         \
                                                            \
-    for (i = 0; i < vl; i++) {                             \
+    for (i = env->vstart; i < vl; i++) {                   \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
         if (!vm && !vext_elem_mask(v0, i)) {               \
             continue;                                      \
@@ -4172,6 +4220,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
     }                                                      \
     *((TD *)vd + HD(0)) = s1;                              \
+    env->vstart = 0;                                       \
 }
 
 /* Unordered sum */
@@ -4199,7 +4248,7 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
     uint32_t i;
     uint32_t s1 =  *((uint32_t *)vs1 + H4(0));
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         uint16_t s2 = *((uint16_t *)vs2 + H2(i));
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
@@ -4208,6 +4257,7 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
                          &env->fp_status);
     }
     *((uint32_t *)vd + H4(0)) = s1;
+    env->vstart = 0;
 }
 
 void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
@@ -4218,7 +4268,7 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
     uint32_t i;
     uint64_t s1 =  *((uint64_t *)vs1);
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         uint32_t s2 = *((uint32_t *)vs2 + H4(i));
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
@@ -4227,6 +4277,7 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
                          &env->fp_status);
     }
     *((uint64_t *)vd) = s1;
+    env->vstart = 0;
 }
 
 /*
@@ -4242,11 +4293,12 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
-    for (i = 0; i < vl; i++) {                            \
+    for (i = env->vstart; i < vl; i++) {                  \
         a = vext_elem_mask(vs1, i);                       \
         b = vext_elem_mask(vs2, i);                       \
         vext_set_elem_mask(vd, i, OP(b, a));              \
     }                                                     \
+    env->vstart = 0;                                      \
 }
 
 #define DO_NAND(N, M)  (!(N & M))
@@ -4273,13 +4325,14 @@ target_ulong HELPER(vpopc_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env->vl;
     int i;
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {
                 cnt++;
             }
         }
     }
+    env->vstart = 0;
     return cnt;
 }
 
@@ -4291,13 +4344,14 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env->vl;
     int i;
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {
                 return i;
             }
         }
     }
+    env->vstart = 0;
     return -1LL;
 }
 
@@ -4315,7 +4369,7 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
     int i;
     bool first_mask_bit = false;
 
-    for (i = 0; i < vl; i++) {
+    for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
@@ -4339,6 +4393,7 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
             }
         }
     }
+    env->vstart = 0;
 }
 
 void HELPER(vmsbf_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
@@ -4369,7 +4424,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
                                                                           \
-    for (i = 0; i < vl; i++) {                                            \
+    for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
@@ -4378,6 +4433,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
             sum++;                                                        \
         }                                                                 \
     }                                                                     \
+    env->vstart = 0;                                                      \
 }
 
 GEN_VEXT_VIOTA_M(viota_m_b, uint8_t,  H1)
@@ -4393,12 +4449,13 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     uint32_t vl = env->vl;                                                \
     int i;                                                                \
                                                                           \
-    for (i = 0; i < vl; i++) {                                            \
+    for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = i;                                        \
     }                                                                     \
+    env->vstart = 0;                                                      \
 }
 
 GEN_VEXT_VID_V(vid_v_b, uint8_t,  H1)
@@ -4417,9 +4474,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
 {                                                                         \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
-    target_ulong offset = s1, i;                                          \
+    target_ulong offset = s1, i_min, i;                                   \
                                                                           \
-    for (i = offset; i < vl; i++) {                                       \
+    i_min = MAX(env->vstart, offset);                                     \
+    for (i = i_min; i < vl; i++) {                                        \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
@@ -4442,8 +4500,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vl = env->vl;                                                \
     target_ulong i_max, i;                                                \
                                                                           \
-    i_max = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
-    for (i = 0; i < i_max; ++i) {                                         \
+    i_max = MAX(MIN(s1 < vlmax ? vlmax - s1 : 0, vl), env->vstart);       \
+    for (i = env->vstart; i < i_max; ++i) {                               \
         if (vm || vext_elem_mask(v0, i)) {                                \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + s1));          \
         }                                                                 \
@@ -4454,6 +4512,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = 0;                                    \
         }                                                                 \
     }                                                                     \
+                                                                          \
+    env->vstart = 0;                                                      \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
@@ -4471,7 +4531,7 @@ static void vslide1up_##ESZ(void *vd, void *v0, target_ulong s1, void *vs2, \
     uint32_t vl = env->vl;                                                  \
     uint32_t i;                                                             \
                                                                             \
-    for (i = 0; i < vl; i++) {                                              \
+    for (i = env->vstart; i < vl; i++) {                                    \
         if (!vm && !vext_elem_mask(v0, i)) {                                \
             continue;                                                       \
         }                                                                   \
@@ -4481,6 +4541,7 @@ static void vslide1up_##ESZ(void *vd, void *v0, target_ulong s1, void *vs2, \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));             \
         }                                                                   \
     }                                                                       \
+    env->vstart = 0;                                                        \
 }
 
 GEN_VEXT_VSLIE1UP(8,  H1)
@@ -4510,7 +4571,7 @@ static void vslide1down_##ESZ(void *vd, void *v0, target_ulong s1, void *vs2, \
     uint32_t vl = env->vl;                                                    \
     uint32_t i;                                                               \
                                                                               \
-    for (i = 0; i < vl; i++) {                                                \
+    for (i = env->vstart; i < vl; i++) {                                      \
         if (!vm && !vext_elem_mask(v0, i)) {                                  \
             continue;                                                         \
         }                                                                     \
@@ -4520,6 +4581,7 @@ static void vslide1down_##ESZ(void *vd, void *v0, target_ulong s1, void *vs2, \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));               \
         }                                                                     \
     }                                                                         \
+    env->vstart = 0;                                                          \
 }
 
 GEN_VEXT_VSLIDE1DOWN(8,  H1)
@@ -4570,12 +4632,12 @@ GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_d, 64)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(TS1)));             \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(TS2)));             \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t index, i;                                                    \
                                                                           \
-    for (i = 0; i < vl; i++) {                                            \
+    for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
@@ -4586,6 +4648,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
             *((TS2 *)vd + HS2(i)) = *((TS2 *)vs2 + HS2(index));           \
         }                                                                 \
     }                                                                     \
+    env->vstart = 0;                                                      \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
@@ -4608,7 +4671,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vl = env->vl;                                                \
     uint32_t index = s1, i;                                               \
                                                                           \
-    for (i = 0; i < vl; i++) {                                            \
+    for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
@@ -4618,6 +4681,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
         }                                                                 \
     }                                                                     \
+    env->vstart = 0;                                                      \
 }
 
 /* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -4634,13 +4698,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vl = env->vl;                                                \
     uint32_t num = 0, i;                                                  \
                                                                           \
-    for (i = 0; i < vl; i++) {                                            \
+    for (i = env->vstart; i < vl; i++) {                                  \
         if (!vext_elem_mask(vs1, i)) {                                    \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
         num++;                                                            \
     }                                                                     \
+    env->vstart = 0;                                                      \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
@@ -4649,6 +4714,27 @@ GEN_VEXT_VCOMPRESS_VM(vcompress_vm_h, uint16_t, H2)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_w, uint32_t, H4)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_d, uint64_t, H8)
 
+/* Vector Whole Register Move */
+#define GEN_VEXT_VMV_WHOLE(NAME, LEN)                      \
+void HELPER(NAME)(void *vd, void *vs2, CPURISCVState *env, \
+                  uint32_t desc)                           \
+{                                                          \
+    /* EEW = 8 */                                          \
+    uint32_t maxsz = simd_maxsz(desc);                     \
+    uint32_t i = env->vstart;                              \
+                                                           \
+    memcpy((uint8_t *)vd + H1(i),                          \
+           (uint8_t *)vs2 + H1(i),                         \
+           maxsz - env->vstart);                           \
+                                                           \
+    env->vstart = 0;                                       \
+}
+
+GEN_VEXT_VMV_WHOLE(vmv1r_v, 1)
+GEN_VEXT_VMV_WHOLE(vmv2r_v, 2)
+GEN_VEXT_VMV_WHOLE(vmv4r_v, 4)
+GEN_VEXT_VMV_WHOLE(vmv8r_v, 8)
+
 /* Vector Integer Extension */
 #define GEN_VEXT_INT_EXT(NAME, ETYPE, DTYPE, HD, HS1)            \
 void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
@@ -4658,12 +4744,13 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     uint32_t vm = vext_vm(desc);                                 \
     uint32_t i;                                                  \
                                                                  \
-    for (i = 0; i < vl; i++) {                                   \
+    for (i = env->vstart; i < vl; i++) {                         \
         if (!vm && !vext_elem_mask(v0, i)) {                     \
             continue;                                            \
         }                                                        \
         *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));       \
     }                                                            \
+    env->vstart = 0;                                             \
 }
 
 GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1)
-- 
2.17.1


