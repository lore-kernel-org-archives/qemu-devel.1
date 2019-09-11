Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7551ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F80E21928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F80E21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wRB-0004SM-5W
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDf-0007AC-Vj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDW-0007pq-VE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:11 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDV-0007lg-3B; Wed, 11 Sep 2019 02:35:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.186311-0.00318493-0.810504; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16370; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRIpfa_1568183696; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRIpfa_1568183696)
 by smtp.aliyun-inc.com(10.147.41.120);
 Wed, 11 Sep 2019 14:34:56 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:34 +0800
Message-Id: <1568183141-67641-11-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 10/17] RISC-V: add vector extension integer
 instructions part3, cmp/min/max
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
 target/riscv/helper.h                   |   29 +
 target/riscv/insn32.decode              |   29 +
 target/riscv/insn_trans/trans_rvv.inc.c |   29 +
 target/riscv/vector_helper.c            | 2280 +++++++++++++++++++++++++++++++
 4 files changed, 2367 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 28863e2..7354b12 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -200,5 +200,34 @@ DEF_HELPER_5(vector_vnsra_vv, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vnsra_vx, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vnsra_vi, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_5(vector_vminu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vminu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmin_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmin_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmaxu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmaxu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmax_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmax_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmseq_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmseq_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmseq_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsne_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsne_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsne_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsltu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsltu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmslt_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmslt_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsleu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsleu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsleu_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsle_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsle_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsle_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsgtu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsgtu_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsgt_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmsgt_vi, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 19710f5..1ff0b08 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -340,5 +340,34 @@ vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
 vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
 vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
 
+vmseq_vv        011000 . ..... ..... 000 ..... 1010111 @r_vm
+vmseq_vx        011000 . ..... ..... 100 ..... 1010111 @r_vm
+vmseq_vi        011000 . ..... ..... 011 ..... 1010111 @r_vm
+vmsne_vv        011001 . ..... ..... 000 ..... 1010111 @r_vm
+vmsne_vx        011001 . ..... ..... 100 ..... 1010111 @r_vm
+vmsne_vi        011001 . ..... ..... 011 ..... 1010111 @r_vm
+vmsltu_vv       011010 . ..... ..... 000 ..... 1010111 @r_vm
+vmsltu_vx       011010 . ..... ..... 100 ..... 1010111 @r_vm
+vmslt_vv        011011 . ..... ..... 000 ..... 1010111 @r_vm
+vmslt_vx        011011 . ..... ..... 100 ..... 1010111 @r_vm
+vmsleu_vv       011100 . ..... ..... 000 ..... 1010111 @r_vm
+vmsleu_vx       011100 . ..... ..... 100 ..... 1010111 @r_vm
+vmsleu_vi       011100 . ..... ..... 011 ..... 1010111 @r_vm
+vmsle_vv        011101 . ..... ..... 000 ..... 1010111 @r_vm
+vmsle_vx        011101 . ..... ..... 100 ..... 1010111 @r_vm
+vmsle_vi        011101 . ..... ..... 011 ..... 1010111 @r_vm
+vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
+vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
+vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
+vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
+vminu_vv        000100 . ..... ..... 000 ..... 1010111 @r_vm
+vminu_vx        000100 . ..... ..... 100 ..... 1010111 @r_vm
+vmin_vv         000101 . ..... ..... 000 ..... 1010111 @r_vm
+vmin_vx         000101 . ..... ..... 100 ..... 1010111 @r_vm
+vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
+vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
+vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
+vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 6af29d0..cd5ab07 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -229,5 +229,34 @@ GEN_VECTOR_R_VM(vnsra_vv)
 GEN_VECTOR_R_VM(vnsra_vx)
 GEN_VECTOR_R_VM(vnsra_vi)
 
+GEN_VECTOR_R_VM(vmseq_vv)
+GEN_VECTOR_R_VM(vmseq_vx)
+GEN_VECTOR_R_VM(vmseq_vi)
+GEN_VECTOR_R_VM(vmsne_vv)
+GEN_VECTOR_R_VM(vmsne_vx)
+GEN_VECTOR_R_VM(vmsne_vi)
+GEN_VECTOR_R_VM(vmsltu_vv)
+GEN_VECTOR_R_VM(vmsltu_vx)
+GEN_VECTOR_R_VM(vmslt_vv)
+GEN_VECTOR_R_VM(vmslt_vx)
+GEN_VECTOR_R_VM(vmsleu_vv)
+GEN_VECTOR_R_VM(vmsleu_vx)
+GEN_VECTOR_R_VM(vmsleu_vi)
+GEN_VECTOR_R_VM(vmsle_vv)
+GEN_VECTOR_R_VM(vmsle_vx)
+GEN_VECTOR_R_VM(vmsle_vi)
+GEN_VECTOR_R_VM(vmsgtu_vx)
+GEN_VECTOR_R_VM(vmsgtu_vi)
+GEN_VECTOR_R_VM(vmsgt_vx)
+GEN_VECTOR_R_VM(vmsgt_vi)
+GEN_VECTOR_R_VM(vminu_vv)
+GEN_VECTOR_R_VM(vminu_vx)
+GEN_VECTOR_R_VM(vmin_vv)
+GEN_VECTOR_R_VM(vmin_vx)
+GEN_VECTOR_R_VM(vmaxu_vv)
+GEN_VECTOR_R_VM(vmaxu_vx)
+GEN_VECTOR_R_VM(vmax_vv)
+GEN_VECTOR_R_VM(vmax_vx)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 298a10a..fbf2145 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -8608,3 +8608,2283 @@ void VECTOR_HELPER(vnsra_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
     env->vfp.vstart = 0;
 }
 
+void VECTOR_HELPER(vmseq_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u8[j] ==
+                            env->vfp.vreg[src2].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u16[j] ==
+                            env->vfp.vreg[src2].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u32[j] ==
+                            env->vfp.vreg[src2].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u64[j] ==
+                            env->vfp.vreg[src2].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmseq_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint8_t)env->gpr[rs1] == env->vfp.vreg[src2].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)env->gpr[rs1] == env->vfp.vreg[src2].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)env->gpr[rs1] == env->vfp.vreg[src2].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)extend_gpr(env->gpr[rs1]) ==
+                            env->vfp.vreg[src2].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmseq_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint8_t)sign_extend(rs1, 5)
+                        == env->vfp.vreg[src2].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)sign_extend(rs1, 5)
+                        == env->vfp.vreg[src2].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)sign_extend(rs1, 5)
+                        == env->vfp.vreg[src2].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)sign_extend(rs1, 5) ==
+                            env->vfp.vreg[src2].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmsne_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u8[j] !=
+                            env->vfp.vreg[src2].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u16[j] !=
+                            env->vfp.vreg[src2].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u32[j] !=
+                            env->vfp.vreg[src2].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u64[j] !=
+                            env->vfp.vreg[src2].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsne_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint8_t)env->gpr[rs1] != env->vfp.vreg[src2].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)env->gpr[rs1] != env->vfp.vreg[src2].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)env->gpr[rs1] != env->vfp.vreg[src2].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)extend_gpr(env->gpr[rs1]) !=
+                            env->vfp.vreg[src2].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsne_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint8_t)sign_extend(rs1, 5)
+                        != env->vfp.vreg[src2].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)sign_extend(rs1, 5)
+                        != env->vfp.vreg[src2].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)sign_extend(rs1, 5)
+                        != env->vfp.vreg[src2].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)sign_extend(rs1, 5) !=
+                        env->vfp.vreg[src2].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmsltu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] <
+                            env->vfp.vreg[src1].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] <
+                            env->vfp.vreg[src1].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] <
+                            env->vfp.vreg[src1].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] <
+                            env->vfp.vreg[src1].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsltu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] < (uint8_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] < (uint16_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] < (uint32_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] <
+                        (uint64_t)extend_gpr(env->gpr[rs1])) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmslt_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] <
+                            env->vfp.vreg[src1].s8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] <
+                            env->vfp.vreg[src1].s16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] <
+                            env->vfp.vreg[src1].s32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] <
+                            env->vfp.vreg[src1].s64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmslt_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] < (int8_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] < (int16_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] < (int32_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] <
+                            (int64_t)extend_gpr(env->gpr[rs1])) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmsleu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] <=
+                            env->vfp.vreg[src1].u8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] <=
+                            env->vfp.vreg[src1].u16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] <=
+                            env->vfp.vreg[src1].u32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] <=
+                            env->vfp.vreg[src1].u64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsleu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] <= (uint8_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] <= (uint16_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] <= (uint32_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] <=
+                        (uint64_t)extend_gpr(env->gpr[rs1])) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsleu_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] <= (uint8_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] <= (uint16_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] <= (uint32_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] <=
+                        (uint64_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmsle_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] <=
+                            env->vfp.vreg[src1].s8[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] <=
+                            env->vfp.vreg[src1].s16[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] <=
+                            env->vfp.vreg[src1].s32[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] <=
+                            env->vfp.vreg[src1].s64[j]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsle_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] <= (int8_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] <= (int16_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] <= (int32_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] <=
+                            (int64_t)extend_gpr(env->gpr[rs1])) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsle_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] <=
+                        (int8_t)sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] <=
+                        (int16_t)sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] <=
+                        (int32_t)sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] <=
+                        sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmsgtu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] > (uint8_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] > (uint16_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] > (uint32_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] >
+                        (uint64_t)extend_gpr(env->gpr[rs1])) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsgtu_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u8[j] > (uint8_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u16[j] > (uint16_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u32[j] > (uint32_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].u64[j] >
+                        (uint64_t)rs1) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmsgt_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] > (int8_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] > (int16_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] > (int32_t)env->gpr[rs1]) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] >
+                            (int64_t)extend_gpr(env->gpr[rs1])) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsgt_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax;
+
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s8[j] >
+                        (int8_t)sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s16[j] >
+                        (int16_t)sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s32[j] >
+                        (int32_t)sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src2].s64[j] >
+                        sign_extend(rs1, 5)) {
+                        vector_mask_result(env, rd, width, lmul, i, 1);
+                    } else {
+                        vector_mask_result(env, rd, width, lmul, i, 0);
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vminu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u8[j] <=
+                            env->vfp.vreg[src2].u8[j]) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src1].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u16[j] <=
+                            env->vfp.vreg[src2].u16[j]) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src1].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u32[j] <=
+                            env->vfp.vreg[src2].u32[j]) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src1].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u64[j] <=
+                            env->vfp.vreg[src2].u64[j]) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src1].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vminu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint8_t)env->gpr[rs1] <=
+                            env->vfp.vreg[src2].u8[j]) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)env->gpr[rs1] <=
+                            env->vfp.vreg[src2].u16[j]) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)env->gpr[rs1] <=
+                            env->vfp.vreg[src2].u32[j]) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)extend_gpr(env->gpr[rs1]) <=
+                            env->vfp.vreg[src2].u64[j]) {
+                        env->vfp.vreg[dest].u64[j] =
+                            (uint64_t)extend_gpr(env->gpr[rs1]);
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmin_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s8[j] <=
+                            env->vfp.vreg[src2].s8[j]) {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->vfp.vreg[src1].s8[j];
+                    } else {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->vfp.vreg[src2].s8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s16[j] <=
+                            env->vfp.vreg[src2].s16[j]) {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->vfp.vreg[src1].s16[j];
+                    } else {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->vfp.vreg[src2].s16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s32[j] <=
+                            env->vfp.vreg[src2].s32[j]) {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->vfp.vreg[src1].s32[j];
+                    } else {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->vfp.vreg[src2].s32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s64[j] <=
+                            env->vfp.vreg[src2].s64[j]) {
+                        env->vfp.vreg[dest].s64[j] =
+                            env->vfp.vreg[src1].s64[j];
+                    } else {
+                        env->vfp.vreg[dest].s64[j] =
+                            env->vfp.vreg[src2].s64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmin_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int8_t)env->gpr[rs1] <=
+                            env->vfp.vreg[src2].s8[j]) {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->vfp.vreg[src2].s8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int16_t)env->gpr[rs1] <=
+                            env->vfp.vreg[src2].s16[j]) {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->vfp.vreg[src2].s16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int32_t)env->gpr[rs1] <=
+                            env->vfp.vreg[src2].s32[j]) {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->vfp.vreg[src2].s32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int64_t)extend_gpr(env->gpr[rs1]) <=
+                            env->vfp.vreg[src2].s64[j]) {
+                        env->vfp.vreg[dest].s64[j] =
+                            (int64_t)extend_gpr(env->gpr[rs1]);
+                    } else {
+                        env->vfp.vreg[dest].s64[j] =
+                            env->vfp.vreg[src2].s64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmaxu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u8[j] >=
+                            env->vfp.vreg[src2].u8[j]) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src1].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u16[j] >=
+                            env->vfp.vreg[src2].u16[j]) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src1].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u32[j] >=
+                            env->vfp.vreg[src2].u32[j]) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src1].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u64[j] >=
+                            env->vfp.vreg[src2].u64[j]) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src1].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmaxu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint8_t)env->gpr[rs1] >=
+                            env->vfp.vreg[src2].u8[j]) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)env->gpr[rs1] >=
+                            env->vfp.vreg[src2].u16[j]) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)env->gpr[rs1] >=
+                            env->vfp.vreg[src2].u32[j]) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)extend_gpr(env->gpr[rs1]) >=
+                            env->vfp.vreg[src2].u64[j]) {
+                        env->vfp.vreg[dest].u64[j] =
+                            (uint64_t)extend_gpr(env->gpr[rs1]);
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmax_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s8[j] >=
+                            env->vfp.vreg[src2].s8[j]) {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->vfp.vreg[src1].s8[j];
+                    } else {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->vfp.vreg[src2].s8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s16[j] >=
+                            env->vfp.vreg[src2].s16[j]) {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->vfp.vreg[src1].s16[j];
+                    } else {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->vfp.vreg[src2].s16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s32[j] >=
+                            env->vfp.vreg[src2].s32[j]) {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->vfp.vreg[src1].s32[j];
+                    } else {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->vfp.vreg[src2].s32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s64[j] >=
+                            env->vfp.vreg[src2].s64[j]) {
+                        env->vfp.vreg[dest].s64[j] =
+                            env->vfp.vreg[src1].s64[j];
+                    } else {
+                        env->vfp.vreg[dest].s64[j] =
+                            env->vfp.vreg[src2].s64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmax_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int8_t)env->gpr[rs1] >=
+                            env->vfp.vreg[src2].s8[j]) {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].s8[j] =
+                            env->vfp.vreg[src2].s8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int16_t)env->gpr[rs1] >=
+                            env->vfp.vreg[src2].s16[j]) {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].s16[j] =
+                            env->vfp.vreg[src2].s16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int32_t)env->gpr[rs1] >=
+                            env->vfp.vreg[src2].s32[j]) {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->gpr[rs1];
+                    } else {
+                        env->vfp.vreg[dest].s32[j] =
+                            env->vfp.vreg[src2].s32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int64_t)extend_gpr(env->gpr[rs1]) >=
+                            env->vfp.vreg[src2].s64[j]) {
+                        env->vfp.vreg[dest].s64[j] =
+                            (int64_t)extend_gpr(env->gpr[rs1]);
+                    } else {
+                        env->vfp.vreg[dest].s64[j] =
+                            env->vfp.vreg[src2].s64[j];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
-- 
2.7.4


