Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A51FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513A620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513A620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFgQ-0001rQ-HW
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFfG-0008Tc-I2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFfE-0004pR-Ri
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:06:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40203)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFfE-0004Ci-0h; Tue, 17 Mar 2020 13:06:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07609229|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.63885-0.00227931-0.358871;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.tLpl_1584464748; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.tLpl_1584464748)
 by smtp.aliyun-inc.com(10.147.40.233);
 Wed, 18 Mar 2020 01:05:48 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 59/61] target/riscv: vector register gather instruction
Date: Tue, 17 Mar 2020 23:06:51 +0800
Message-Id: <20200317150653.9008-60-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |   9 ++
 target/riscv/insn32.decode              |   3 +
 target/riscv/insn_trans/trans_rvv.inc.c | 127 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            |  64 ++++++++++++
 4 files changed, 203 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3b1612012c..d07b416c33 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1135,3 +1135,12 @@ DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 34ccad53a9..e07ff7eff6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -572,6 +572,9 @@ vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
 vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
 vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
 vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
+vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
+vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
+vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 10482fd1d4..f781372b50 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2553,3 +2553,130 @@ GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
 GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
 GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
 GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
+
+/* Vector Register Gather Instruction */
+static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2) && (a->rd != a->rs1));
+}
+
+GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
+
+static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2));
+}
+
+static void gather_element(TCGv_i64 dest, TCGv_ptr base,
+                           int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_ld8u_i64(dest, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_ld16u_i64(dest, base, ofs);
+        break;
+    case MO_32:
+        tcg_gen_ld32u_i64(dest, base, ofs);
+        break;
+    default:
+        tcg_gen_ld_i64(dest, base, ofs);
+        break;
+    }
+}
+
+static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
+{
+    if (!vrgather_vx_check(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        int vlmax = s->vlen / s->mlen;
+        TCGv_i32 ofs = tcg_temp_new_i32();
+        TCGv_ptr base = tcg_temp_new_ptr();
+        TCGv_i64 t_vlmax, t_zero, dest = tcg_temp_new_i64();
+        TCGv s1 = tcg_temp_new();
+        TCGv_i64 s1_i64 = tcg_temp_new_i64();
+
+        /* Expand x[rs1] to TCGv_i64 */
+        gen_get_gpr(s1, a->rs1);
+        tcg_gen_extu_tl_i64(s1_i64, s1);
+        tcg_temp_free(s1);
+
+        /*
+         * Mask the index to the length so that we do
+         * not produce an out-of-range load.
+         */
+        tcg_gen_extrl_i64_i32(ofs, s1_i64);
+        tcg_gen_andi_i32(ofs, ofs, vlmax - 1);
+
+        /* Convert the index to an offset. */
+        endian_adjust(ofs, s->sew);
+        tcg_gen_shli_i32(ofs, ofs, s->sew);
+
+        /* Convert the index to a pointer. */
+        tcg_gen_ext_i32_ptr(base, ofs);
+        tcg_gen_add_ptr(base, base, cpu_env);
+
+        /* Perform the load. */
+        gather_element(dest, base,
+                       vreg_ofs(s, a->rs2), s->sew);
+        tcg_temp_free_ptr(base);
+        tcg_temp_free_i32(ofs);
+
+        /* Flush out-of-range indexing to zero.  */
+        t_vlmax = tcg_const_i64(vlmax);
+        t_zero = tcg_const_i64(0);
+        tcg_gen_movcond_i64(TCG_COND_LTU, dest, s1_i64,
+                            t_vlmax, dest, t_zero);
+        tcg_temp_free_i64(t_vlmax);
+        tcg_temp_free_i64(t_zero);
+        tcg_temp_free_i64(s1_i64);
+
+        tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                             MAXSZ(s), MAXSZ(s), dest);
+        tcg_temp_free_i64(dest);
+    } else {
+        static gen_helper_opivx * const fns[4] = {
+            gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
+            gen_helper_vrgather_vx_w, gen_helper_vrgather_vx_d
+        };
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);
+    }
+    return true;
+}
+
+static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
+{
+    if (!vrgather_vx_check(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        if (a->rs1 >= s->vlen / s->mlen) {
+            tcg_gen_gvec_dup64i(vreg_ofs(s, a->rd), MAXSZ(s), MAXSZ(s), 0);
+        } else {
+            tcg_gen_gvec_dup_mem(s->sew, vreg_ofs(s, a->rd),
+                                 endian_ofs(s, a->rs2, a->rs1),
+                                 MAXSZ(s), MAXSZ(s));
+        }
+    } else {
+        static gen_helper_opivx * const fns[4] = {
+            gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
+            gen_helper_vrgather_vx_w, gen_helper_vrgather_vx_d
+        };
+        opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s, 1);
+    }
+    return true;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b0439ac3d1..30620284cc 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4834,3 +4834,67 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
+
+/* Vector Register Gather Instruction */
+#define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t index, i;                                                    \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        index = *((ETYPE *)vs1 + H(i));                                   \
+        if (index >= vlmax) {                                             \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+        }                                                                 \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+/* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
+GEN_VEXT_VRGATHER_VV(vrgather_vv_b, uint8_t, H1, clearb)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_h, uint16_t, H2, clearh)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_w, uint32_t, H4, clearl)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VRGATHER_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t index = s1, i;                                               \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (index >= vlmax) {                                             \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+        }                                                                 \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+/* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
+GEN_VEXT_VRGATHER_VX(vrgather_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VRGATHER_VX(vrgather_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VRGATHER_VX(vrgather_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
-- 
2.23.0


