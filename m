Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43695ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE82121928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE82121928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wS4-0005yU-GE
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE6-0007np-RO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE0-0008AP-9u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55853)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDz-0007sI-71; Wed, 11 Sep 2019 02:35:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.257642-0.00741329-0.734945; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16367; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRZlKe_1568183704; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRZlKe_1568183704)
 by smtp.aliyun-inc.com(10.147.42.135);
 Wed, 11 Sep 2019 14:35:04 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:39 +0800
Message-Id: <1568183141-67641-16-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 15/17] RISC-V: add vector extension
 reduction instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |   17 +
 target/riscv/insn32.decode              |   17 +
 target/riscv/insn_trans/trans_rvv.inc.c |   17 +
 target/riscv/vector_helper.c            | 1275 +++++++++++++++++++++++++++++++
 4 files changed, 1326 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e2384eb..d36bd00 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -384,5 +384,22 @@ DEF_HELPER_4(vector_vfncvt_f_xu_v, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vfncvt_f_x_v, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vfncvt_f_f_v, void, env, i32, i32, i32)
 
+DEF_HELPER_5(vector_vredsum_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredand_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfredsum_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredor_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredxor_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfredosum_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredminu_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredmin_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfredmin_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredmaxu_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vredmax_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfredmax_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwredsumu_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwredsum_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwredsum_vs, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwredosum_vs, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 256d8ea..3f63bc1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -524,5 +524,22 @@ vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
 vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
 vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
 
+vredsum_vs      000000 . ..... ..... 010 ..... 1010111 @r_vm
+vredand_vs      000001 . ..... ..... 010 ..... 1010111 @r_vm
+vredor_vs       000010 . ..... ..... 010 ..... 1010111 @r_vm
+vredxor_vs      000011 . ..... ..... 010 ..... 1010111 @r_vm
+vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
+vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
+vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
+vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
+vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
+vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
+vfredsum_vs     000001 . ..... ..... 001 ..... 1010111 @r_vm
+vfredosum_vs    000011 . ..... ..... 001 ..... 1010111 @r_vm
+vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
+vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
+vfwredsum_vs    110001 . ..... ..... 001 ..... 1010111 @r_vm
+vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index e4d4576..9a3d31b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -427,5 +427,22 @@ GEN_VECTOR_R2_VM(vfncvt_f_xu_v)
 GEN_VECTOR_R2_VM(vfncvt_f_x_v)
 GEN_VECTOR_R2_VM(vfncvt_f_f_v)
 
+GEN_VECTOR_R_VM(vredsum_vs)
+GEN_VECTOR_R_VM(vredand_vs)
+GEN_VECTOR_R_VM(vredor_vs)
+GEN_VECTOR_R_VM(vredxor_vs)
+GEN_VECTOR_R_VM(vredminu_vs)
+GEN_VECTOR_R_VM(vredmin_vs)
+GEN_VECTOR_R_VM(vredmaxu_vs)
+GEN_VECTOR_R_VM(vredmax_vs)
+GEN_VECTOR_R_VM(vwredsumu_vs)
+GEN_VECTOR_R_VM(vwredsum_vs)
+GEN_VECTOR_R_VM(vfredsum_vs)
+GEN_VECTOR_R_VM(vfredosum_vs)
+GEN_VECTOR_R_VM(vfredmin_vs)
+GEN_VECTOR_R_VM(vfredmax_vs)
+GEN_VECTOR_R_VM(vfwredsum_vs)
+GEN_VECTOR_R_VM(vfwredosum_vs)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fd2ecb7..4a9083b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -22720,4 +22720,1279 @@ void VECTOR_HELPER(vfncvt_f_f_v)(CPURISCVState *env, uint32_t vm,
     return;
 }
 
+/* vredsum.vs vd, vs2, vs1, vm # vd[0] = sum(vs1[0] , vs2[*]) */
+void VECTOR_HELPER(vredsum_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
 
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t sum = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u8[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u8[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u8[0] = sum;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u16[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u16[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = sum;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u32[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u32[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = sum;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u64[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u64[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = sum;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+
+/* vredand.vs vd, vs2, vs1, vm # vd[0] = and( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredand_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t res = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res &= env->vfp.vreg[src2].u8[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u8[0] = res;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res &= env->vfp.vreg[src2].u16[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = res;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res &= env->vfp.vreg[src2].u32[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = res;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res &= env->vfp.vreg[src2].u64[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = res;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfredsum.vs vd, vs2, vs1, vm # Unordered sum */
+void VECTOR_HELPER(vfredsum_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    float16 sum16 = 0.0f;
+    float32 sum32 = 0.0f;
+    float64 sum64 = 0.0f;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 16:
+                if (i == 0) {
+                    sum16 = env->vfp.vreg[rs1].f16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum16 = float16_add(sum16, env->vfp.vreg[src2].f16[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f16[0] = sum16;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    sum32 = env->vfp.vreg[rs1].f32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum32 = float32_add(sum32, env->vfp.vreg[src2].f32[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f32[0] = sum32;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    sum64 = env->vfp.vreg[rs1].f64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum64 = float64_add(sum64, env->vfp.vreg[src2].f64[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f64[0] = sum64;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vredor.vs vd, vs2, vs1, vm # vd[0] = or( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredor_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t res = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res |= env->vfp.vreg[src2].u8[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u8[0] = res;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res |= env->vfp.vreg[src2].u16[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = res;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res |= env->vfp.vreg[src2].u32[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = res;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res |= env->vfp.vreg[src2].u64[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = res;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vredxor.vs vd, vs2, vs1, vm # vd[0] = xor( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredxor_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t res = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res ^= env->vfp.vreg[src2].u8[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u8[0] = res;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res ^= env->vfp.vreg[src2].u16[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = res;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res ^= env->vfp.vreg[src2].u32[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = res;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    res = env->vfp.vreg[rs1].u64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    res ^= env->vfp.vreg[src2].u64[j];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = res;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfredosum.vs vd, vs2, vs1, vm # Ordered sum */
+void VECTOR_HELPER(vfredosum_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    helper_vector_vfredsum_vs(env, vm, rs1, rs2, rd);
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vredminu.vs vd, vs2, vs1, vm # vd[0] = minu( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredminu_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t minu = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    minu = env->vfp.vreg[rs1].u8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (minu > env->vfp.vreg[src2].u8[j]) {
+                        minu = env->vfp.vreg[src2].u8[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u8[0] = minu;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    minu = env->vfp.vreg[rs1].u16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (minu > env->vfp.vreg[src2].u16[j]) {
+                        minu = env->vfp.vreg[src2].u16[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = minu;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    minu = env->vfp.vreg[rs1].u32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (minu > env->vfp.vreg[src2].u32[j]) {
+                        minu = env->vfp.vreg[src2].u32[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = minu;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    minu = env->vfp.vreg[rs1].u64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (minu > env->vfp.vreg[src2].u64[j]) {
+                        minu = env->vfp.vreg[src2].u64[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = minu;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vredmin.vs vd, vs2, vs1, vm # vd[0] = min( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredmin_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    int64_t min = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    min = env->vfp.vreg[rs1].s8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (min > env->vfp.vreg[src2].s8[j]) {
+                        min = env->vfp.vreg[src2].s8[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s8[0] = min;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    min = env->vfp.vreg[rs1].s16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (min > env->vfp.vreg[src2].s16[j]) {
+                        min = env->vfp.vreg[src2].s16[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s16[0] = min;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    min = env->vfp.vreg[rs1].s32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (min > env->vfp.vreg[src2].s32[j]) {
+                        min = env->vfp.vreg[src2].s32[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s32[0] = min;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    min = env->vfp.vreg[rs1].s64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (min > env->vfp.vreg[src2].s64[j]) {
+                        min = env->vfp.vreg[src2].s64[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s64[0] = min;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfredmin.vs vd, vs2, vs1, vm # Minimum value */
+void VECTOR_HELPER(vfredmin_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    float16 min16 = 0.0f;
+    float32 min32 = 0.0f;
+    float64 min64 = 0.0f;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 16:
+                if (i == 0) {
+                    min16 = env->vfp.vreg[rs1].f16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    min16 = float16_minnum(min16, env->vfp.vreg[src2].f16[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f16[0] = min16;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    min32 = env->vfp.vreg[rs1].f32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    min32 = float32_minnum(min32, env->vfp.vreg[src2].f32[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f32[0] = min32;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    min64 = env->vfp.vreg[rs1].f64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    min64 = float64_minnum(min64, env->vfp.vreg[src2].f64[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f64[0] = min64;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vredmaxu.vs vd, vs2, vs1, vm # vd[0] = maxu( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredmaxu_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t maxu = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    maxu = env->vfp.vreg[rs1].u8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (maxu < env->vfp.vreg[src2].u8[j]) {
+                        maxu = env->vfp.vreg[src2].u8[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u8[0] = maxu;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    maxu = env->vfp.vreg[rs1].u16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (maxu < env->vfp.vreg[src2].u16[j]) {
+                        maxu = env->vfp.vreg[src2].u16[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = maxu;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    maxu = env->vfp.vreg[rs1].u32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (maxu < env->vfp.vreg[src2].u32[j]) {
+                        maxu = env->vfp.vreg[src2].u32[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = maxu;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    maxu = env->vfp.vreg[rs1].u64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (maxu < env->vfp.vreg[src2].u64[j]) {
+                        maxu = env->vfp.vreg[src2].u64[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = maxu;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+/* vredmax.vs vd, vs2, vs1, vm # vd[0] = max( vs1[0] , vs2[*] ) */
+void VECTOR_HELPER(vredmax_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    int64_t max = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (i == 0) {
+                    max = env->vfp.vreg[rs1].s8[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (max < env->vfp.vreg[src2].s8[j]) {
+                        max = env->vfp.vreg[src2].s8[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s8[0] = max;
+                }
+                break;
+            case 16:
+                if (i == 0) {
+                    max = env->vfp.vreg[rs1].s16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (max < env->vfp.vreg[src2].s16[j]) {
+                        max = env->vfp.vreg[src2].s16[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s16[0] = max;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    max = env->vfp.vreg[rs1].s32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (max < env->vfp.vreg[src2].s32[j]) {
+                        max = env->vfp.vreg[src2].s32[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s32[0] = max;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    max = env->vfp.vreg[rs1].s64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (max < env->vfp.vreg[src2].s64[j]) {
+                        max = env->vfp.vreg[src2].s64[j];
+                    }
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s64[0] = max;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfredmax.vs vd, vs2, vs1, vm # Maximum value */
+void VECTOR_HELPER(vfredmax_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    float16 max16 = 0.0f;
+    float32 max32 = 0.0f;
+    float64 max64 = 0.0f;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 16:
+                if (i == 0) {
+                    max16 = env->vfp.vreg[rs1].f16[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    max16 = float16_maxnum(max16, env->vfp.vreg[src2].f16[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f16[0] = max16;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    max32 = env->vfp.vreg[rs1].f32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    max32 = float32_maxnum(max32, env->vfp.vreg[src2].f32[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f32[0] = max32;
+                }
+                break;
+            case 64:
+                if (i == 0) {
+                    max64 = env->vfp.vreg[rs1].f64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    max64 = float64_maxnum(max64, env->vfp.vreg[src2].f64[j],
+                        &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f64[0] = max64;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vwredsumu.vs vd, vs2, vs1, vm # 2*SEW = 2*SEW + sum(zero-extend(SEW)) */
+void VECTOR_HELPER(vwredsumu_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    uint64_t sum = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u8[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u16[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u16[0] = sum;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u16[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u32[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u32[0] = sum;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += env->vfp.vreg[src2].u32[j];
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].u64[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].u64[0] = sum;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vwredsum.vs vd, vs2, vs1, vm # 2*SEW = 2*SEW + sum(sign-extend(SEW)) */
+void VECTOR_HELPER(vwredsum_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    int64_t sum = 0;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += (int16_t)env->vfp.vreg[src2].s8[j] << 8 >> 8;
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].s16[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s16[0] = sum;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += (int32_t)env->vfp.vreg[src2].s16[j] << 16 >> 16;
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].s32[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s32[0] = sum;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum += (int64_t)env->vfp.vreg[src2].s32[j] << 32 >> 32;
+                }
+                if (i == 0) {
+                    sum += env->vfp.vreg[rs1].s64[0];
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].s64[0] = sum;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vfwredsum.vs vd, vs2, vs1, vm #
+ * Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW))
+ */
+void VECTOR_HELPER(vfwredsum_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2;
+    float32 sum32 = 0.0f;
+    float64 sum64 = 0.0f;
+
+    lmul = vector_get_lmul(env);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vl = env->vfp.vl;
+    if (vl == 0) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < VLEN / 64; i++) {
+        env->vfp.vreg[rd].u64[i] = 0;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+
+        if (i < vl) {
+            switch (width) {
+            case 16:
+                if (i == 0) {
+                    sum32 = env->vfp.vreg[rs1].f32[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum32 = float32_add(sum32,
+                                float16_to_float32(env->vfp.vreg[src2].f16[j],
+                                    true, &env->fp_status),
+                                &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f32[0] = sum32;
+                }
+                break;
+            case 32:
+                if (i == 0) {
+                    sum64 = env->vfp.vreg[rs1].f64[0];
+                }
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    sum64 = float64_add(sum64,
+                                float32_to_float64(env->vfp.vreg[src2].f32[j],
+                                    &env->fp_status),
+                                &env->fp_status);
+                }
+                if (i == vl - 1) {
+                    env->vfp.vreg[rd].f64[0] = sum64;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vfwredosum.vs vd, vs2, vs1, vm #
+ * Ordered reduce 2*SEW = 2*SEW + sum(promote(SEW))
+ */
+void VECTOR_HELPER(vfwredosum_vs)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    helper_vector_vfwredsum_vs(env, vm, rs1, rs2, rd);
+    env->vfp.vstart = 0;
+    return;
+}
-- 
2.7.4


