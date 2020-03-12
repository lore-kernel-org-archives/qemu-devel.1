Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38017C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACA82072F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACA82072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQXt-0007GS-4l
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQVF-0001JX-7h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQV8-00018Q-F3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:16:09 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQV7-000157-31; Thu, 12 Mar 2020 12:16:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0468137-8.8935e-05-0.953097;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-Phnyp_1584029751; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-Phnyp_1584029751)
 by smtp.aliyun-inc.com(10.147.41.187);
 Fri, 13 Mar 2020 00:15:52 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 38/60] target/riscv: vector floating-point compare
 instructions
Date: Thu, 12 Mar 2020 22:58:38 +0800
Message-Id: <20200312145900.2054-39-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  37 ++++
 target/riscv/insn32.decode              |  12 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  33 ++++
 target/riscv/vector_helper.c            | 221 ++++++++++++++++++++++++
 4 files changed, 303 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index efbd5d306d..323bed038e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -941,3 +941,40 @@ DEF_HELPER_6(vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vmfeq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmford_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmford_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d149eccd5c..2d61256981 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -495,6 +495,18 @@ vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
 vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
+vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
+vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
+vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
+vmfne_vf        011100 . ..... ..... 101 ..... 1010111 @r_vm
+vmflt_vv        011011 . ..... ..... 001 ..... 1010111 @r_vm
+vmflt_vf        011011 . ..... ..... 101 ..... 1010111 @r_vm
+vmfle_vv        011001 . ..... ..... 001 ..... 1010111 @r_vm
+vmfle_vf        011001 . ..... ..... 101 ..... 1010111 @r_vm
+vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
+vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
+vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
+vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index ff4ebd3f8c..9d9653e605 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1885,3 +1885,36 @@ GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
 GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
+
+/* Vector Floating-Point Compare Instructions */
+static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            (s->sew != 0) &&
+            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
+            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
+            (s->lmul == 0)));
+}
+GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmfne_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmflt_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmfle_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmford_vv, opfvv_cmp_check)
+
+static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (s->sew != 0) &&
+            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
+            (s->lmul == 0)));
+}
+GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfne_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmflt_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 79e261ff1a..dd44cc57a3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3631,3 +3631,224 @@ RVVCALL(OPFVF2, vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
 GEN_VEXT_VF(vfsgnjx_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
+
+/* Vector Floating-Point Compare Instructions */
+#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)            \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+        CPURISCVState *env, uint32_t desc)                    \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vm = vext_vm(desc);                              \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
+            continue;                                         \
+        }                                                     \
+        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1,         \
+            &env->fp_status));                                \
+    }                                                         \
+    if (i == 0) {                                             \
+        return;                                               \
+    }                                                         \
+    for (; i < vlmax; i++) {                                  \
+        vext_set_elem_mask(vd, mlen, i, 0);                   \
+    }                                                         \
+}
+
+static uint8_t float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare_quiet(a, b, s);
+    if (compare == float_relation_equal) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
+
+#define GEN_VEXT_CMP_VF(NAME, ETYPE, H, DO_OP)                      \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
+        CPURISCVState *env, uint32_t desc)                          \
+{                                                                   \
+    uint32_t mlen = vext_mlen(desc);                                \
+    uint32_t vm = vext_vm(desc);                                    \
+    uint32_t vl = env->vl;                                          \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
+    uint32_t i;                                                     \
+                                                                    \
+    for (i = 0; i < vl; i++) {                                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
+            continue;                                               \
+        }                                                           \
+        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, (ETYPE)s1,        \
+                &env->fp_status));                                  \
+    }                                                               \
+    if (i == 0) {                                                   \
+        return;                                                     \
+    }                                                               \
+    for (; i < vlmax; i++) {                                        \
+        vext_set_elem_mask(vd, mlen, i, 0);                         \
+    }                                                               \
+}
+GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
+GEN_VEXT_CMP_VF(vmfeq_vf_w, uint32_t, H4, float32_eq_quiet)
+GEN_VEXT_CMP_VF(vmfeq_vf_d, uint64_t, H8, float64_eq_quiet)
+
+static uint8_t vmfne16(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare_quiet(a, b, s);
+    if (compare != float_relation_equal &&
+            compare != float_relation_unordered) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+static uint8_t vmfne32(uint32_t a, uint32_t b, float_status *s)
+{
+    int compare = float32_compare_quiet(a, b, s);
+    if (compare != float_relation_equal &&
+            compare != float_relation_unordered) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+static uint8_t vmfne64(uint64_t a, uint64_t b, float_status *s)
+{
+    int compare = float64_compare_quiet(a, b, s);
+    if (compare != float_relation_equal &&
+            compare != float_relation_unordered) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_h, uint16_t, H2, vmfne16)
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_w, uint32_t, H4, vmfne32)
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_d, uint64_t, H8, vmfne64)
+GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
+GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
+GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
+
+static uint8_t float16_lt(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare(a, b, s);
+    if (compare == float_relation_less) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
+
+static uint8_t float16_le(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare(a, b, s);
+    if (compare == float_relation_less ||
+            compare == float_relation_equal) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
+GEN_VEXT_CMP_VF(vmfle_vf_h, uint16_t, H2, float16_le)
+GEN_VEXT_CMP_VF(vmfle_vf_w, uint32_t, H4, float32_le)
+GEN_VEXT_CMP_VF(vmfle_vf_d, uint64_t, H8, float64_le)
+
+static uint8_t vmfgt16(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare(a, b, s);
+    if (compare == float_relation_greater) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+static uint8_t vmfgt32(uint32_t a, uint32_t b, float_status *s)
+{
+    int compare = float32_compare(a, b, s);
+    if (compare == float_relation_greater) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+static uint8_t vmfgt64(uint64_t a, uint64_t b, float_status *s)
+{
+    int compare = float64_compare(a, b, s);
+    if (compare == float_relation_greater) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VF(vmfgt_vf_h, uint16_t, H2, vmfgt16)
+GEN_VEXT_CMP_VF(vmfgt_vf_w, uint32_t, H4, vmfgt32)
+GEN_VEXT_CMP_VF(vmfgt_vf_d, uint64_t, H8, vmfgt64)
+
+static uint8_t vmfge16(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare(a, b, s);
+    if (compare == float_relation_greater ||
+            compare == float_relation_equal) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+static uint8_t vmfge32(uint32_t a, uint32_t b, float_status *s)
+{
+    int compare = float32_compare(a, b, s);
+    if (compare == float_relation_greater ||
+            compare == float_relation_equal) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+static uint8_t vmfge64(uint64_t a, uint64_t b, float_status *s)
+{
+    int compare = float64_compare(a, b, s);
+    if (compare == float_relation_greater ||
+            compare == float_relation_equal) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VF(vmfge_vf_h, uint16_t, H2, vmfge16)
+GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
+GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
+
+static uint8_t float16_unordered_quiet(uint16_t a, uint16_t b, float_status *s)
+{
+    int compare = float16_compare_quiet(a, b, s);
+    if (compare == float_relation_unordered) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+GEN_VEXT_CMP_VV_ENV(vmford_vv_h, uint16_t, H2, !float16_unordered_quiet)
+GEN_VEXT_CMP_VV_ENV(vmford_vv_w, uint32_t, H4, !float32_unordered_quiet)
+GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
+GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
+GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
+GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
-- 
2.23.0


