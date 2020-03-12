Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94DE206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94DE206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQQ9-0006M6-Te
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQPM-00059P-Lt
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQPJ-0005H8-P7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:10:04 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQPG-0005Ap-EY; Thu, 12 Mar 2020 12:10:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07627372|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.203792-0.00091317-0.795295;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-PGdbe_1584029388; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-PGdbe_1584029388)
 by smtp.aliyun-inc.com(10.147.41.121);
 Fri, 13 Mar 2020 00:09:48 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 35/60] target/riscv: vector floating-point square-root
 instruction
Date: Thu, 12 Mar 2020 22:58:35 +0800
Message-Id: <20200312145900.2054-36-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  4 +++
 target/riscv/insn32.decode              |  3 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 37 +++++++++++++++++++++++
 target/riscv/vector_helper.c            | 40 +++++++++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 57e0fee929..c2f9871490 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -905,3 +905,7 @@ DEF_HELPER_6(vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b7cb116cf4..fc9aebc6d6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -45,6 +45,7 @@
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 &rmrr      vm rd rs1 rs2
+&rmr       vm rd rs2
 &rwdvm     vm wd rd rs1 rs2
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
@@ -68,6 +69,7 @@
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
+@r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
@@ -482,6 +484,7 @@ vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
 vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
+vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 06d6e2625b..3e4f7de240 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1834,3 +1834,40 @@ GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
 GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
 GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
 GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
+
+/* Vector Floating-Point Square-Root Instruction */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_check(DisasContext *s, arg_rmr *a)
+{
+   return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (s->sew != 0));
+}
+
+#define GEN_OPFV_TRANS(NAME, CHECK)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+            gen_helper_##NAME##_d,                                 \
+        };                                                         \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs2), cpu_env, 0,                       \
+            s->vlen / 8, data, fns[s->sew - 1]);                   \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9bff516a15..088bb51af0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3488,3 +3488,43 @@ RVVCALL(OPFVF3, vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
 RVVCALL(OPFVF3, vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
 GEN_VEXT_VF(vfwnmsac_vf_h, 2, 4, clearl)
 GEN_VEXT_VF(vfwnmsac_vf_w, 4, 8, clearq)
+
+/* Vector Floating-Point Square-Root Instruction */
+/* (TD, T2, TX2) */
+#define OP_UU_H uint16_t, uint16_t, uint16_t
+#define OP_UU_W uint32_t, uint32_t, uint32_t
+#define OP_UU_D uint64_t, uint64_t, uint64_t
+
+#define OPFVV1(NAME, TD, T2, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, void *vs2, int i,      \
+        CPURISCVState *env)                            \
+{                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
+    *((TD *)vd + HD(i)) = OP(s2, &env->fp_status);     \
+}
+
+#define GEN_VEXT_V_ENV(NAME, ESZ, DSZ, CLEAR_FN)       \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+        CPURISCVState *env, uint32_t desc)             \
+{                                                      \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t mlen = vext_mlen(desc);                   \
+    uint32_t vm = vext_vm(desc);                       \
+    uint32_t vl = env->vl;                             \
+    uint32_t i;                                        \
+    for (i = 0; i < vl; i++) {                         \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i, env);                    \
+    }                                                  \
+    if (i != 0) {                                      \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);      \
+    }                                                  \
+}
+RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
+RVVCALL(OPFVV1, vfsqrt_v_w, OP_UU_W, H4, H4, float32_sqrt)
+RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
+GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
-- 
2.23.0


