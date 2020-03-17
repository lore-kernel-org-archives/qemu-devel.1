Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B659C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC3A20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC3A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFGk-0004g7-AD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEF4E-0006VO-DL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEF4C-0004E5-N2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:27:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEF4B-0003N3-OG; Tue, 17 Mar 2020 12:27:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436284|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.087669-0.00119931-0.911132;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.4bei_1584462454; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.4bei_1584462454) by smtp.aliyun-inc.com(10.147.40.7);
 Wed, 18 Mar 2020 00:27:34 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 40/61] target/riscv: vector floating-point classify
 instructions
Date: Tue, 17 Mar 2020 23:06:32 +0800
Message-Id: <20200317150653.9008-41-zhiwei_liu@c-sky.com>
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
 target/riscv/fpu_helper.c               | 33 +--------
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c |  3 +
 target/riscv/internals.h                |  5 ++
 target/riscv/vector_helper.c            | 93 +++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 30 deletions(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 0b79562a69..4379756dc4 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
+#include "internals.h"
 
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
@@ -230,21 +231,7 @@ uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
 
 target_ulong helper_fclass_s(uint64_t frs1)
 {
-    float32 f = frs1;
-    bool sign = float32_is_neg(f);
-
-    if (float32_is_infinity(f)) {
-        return sign ? 1 << 0 : 1 << 7;
-    } else if (float32_is_zero(f)) {
-        return sign ? 1 << 3 : 1 << 4;
-    } else if (float32_is_zero_or_denormal(f)) {
-        return sign ? 1 << 2 : 1 << 5;
-    } else if (float32_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
-    } else {
-        return sign ? 1 << 1 : 1 << 6;
-    }
+    return fclass_s(frs1);
 }
 
 uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
@@ -353,19 +340,5 @@ uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
 
 target_ulong helper_fclass_d(uint64_t frs1)
 {
-    float64 f = frs1;
-    bool sign = float64_is_neg(f);
-
-    if (float64_is_infinity(f)) {
-        return sign ? 1 << 0 : 1 << 7;
-    } else if (float64_is_zero(f)) {
-        return sign ? 1 << 3 : 1 << 4;
-    } else if (float64_is_zero_or_denormal(f)) {
-        return sign ? 1 << 2 : 1 << 5;
-    } else if (float64_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
-    } else {
-        return sign ? 1 << 1 : 1 << 6;
-    }
+    return fclass_d(frs1);
 }
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 74a2ad897f..93914fc7c4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -986,3 +986,7 @@ DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b0f1c54d53..23e80fe954 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -512,6 +512,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
 vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
+vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 6bf4bd1e98..b7327a2972 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2033,3 +2033,6 @@ GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
+
+/* Vector Floating-Point Classify Instruction */
+GEN_OPFV_TRANS(vfclass_v, opfv_check)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 6a27d7c716..c9dc2d682a 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -27,4 +27,9 @@ FIELD(VDATA, VM, 8, 1)
 FIELD(VDATA, LMUL, 9, 2)
 FIELD(VDATA, NF, 11, 4)
 FIELD(VDATA, WD, 11, 1)
+
+/* float point classify helpers */
+target_ulong fclass_h(uint64_t frs1);
+target_ulong fclass_s(uint64_t frs1);
+target_ulong fclass_d(uint64_t frs1);
 #endif
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 70bb51b6a8..c1a0d14ea8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4053,3 +4053,96 @@ GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
+
+/* Vector Floating-Point Classify Instruction */
+#define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
+static void do_##NAME(void *vd, void *vs2, int i)      \
+{                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
+    *((TD *)vd + HD(i)) = OP(s2);                      \
+}
+
+#define GEN_VEXT_V(NAME, ESZ, DSZ, CLEAR_FN)           \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+        CPURISCVState *env, uint32_t desc)             \
+{                                                      \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t mlen = vext_mlen(desc);                   \
+    uint32_t vm = vext_vm(desc);                       \
+    uint32_t vl = env->vl;                             \
+    uint32_t i;                                        \
+    if (vl == 0) {                                     \
+        return;                                        \
+    }                                                  \
+    for (i = 0; i < vl; i++) {                         \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i);                         \
+    }                                                  \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+}
+
+target_ulong fclass_h(uint64_t frs1)
+{
+    float16 f = frs1;
+    bool sign = float16_is_neg(f);
+
+    if (float16_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float16_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float16_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float16_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+
+target_ulong fclass_s(uint64_t frs1)
+{
+    float32 f = frs1;
+    bool sign = float32_is_neg(f);
+
+    if (float32_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float32_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float32_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float32_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+
+target_ulong fclass_d(uint64_t frs1)
+{
+    float64 f = frs1;
+    bool sign = float64_is_neg(f);
+
+    if (float64_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float64_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float64_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float64_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+
+RVVCALL(OPIVV1, vfclass_v_h, OP_UU_H, H2, H2, fclass_h)
+RVVCALL(OPIVV1, vfclass_v_w, OP_UU_W, H4, H4, fclass_s)
+RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
+GEN_VEXT_V(vfclass_v_h, 2, 2, clearh)
+GEN_VEXT_V(vfclass_v_w, 4, 4, clearl)
+GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
-- 
2.23.0


