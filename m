Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20424ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52312089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52312089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wLp-0007u7-IE
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDc-00075N-Ev
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDV-0007ni-EM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDU-0007kP-5Z; Wed, 11 Sep 2019 02:35:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.273373-0.00435976-0.722268; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRDYQn_1568183696; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRDYQn_1568183696)
 by smtp.aliyun-inc.com(10.147.44.118);
 Wed, 11 Sep 2019 14:34:56 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:33 +0800
Message-Id: <1568183141-67641-10-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 09/17] RISC-V: add vector extension integer
 instructions part2, bit/shift
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
 target/riscv/helper.h                   |   25 +
 target/riscv/insn32.decode              |   25 +
 target/riscv/insn_trans/trans_rvv.inc.c |   25 +
 target/riscv/vector_helper.c            | 1477 +++++++++++++++++++++++++++++++
 4 files changed, 1552 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 31e20dc..28863e2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -175,5 +175,30 @@ DEF_HELPER_5(vector_vwsubu_wx, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vwsub_wv, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vwsub_wx, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_5(vector_vand_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vand_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vand_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vor_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vor_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vor_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vxor_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vxor_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vxor_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsll_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsll_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsll_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsrl_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsrl_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsrl_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsra_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsra_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsra_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnsrl_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnsrl_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnsrl_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnsra_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnsra_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnsra_vi, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index fc7e498..19710f5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -315,5 +315,30 @@ vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r
 vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r
 vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r
 
+vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
+vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
+vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
+vor_vv          001010 . ..... ..... 000 ..... 1010111 @r_vm
+vor_vx          001010 . ..... ..... 100 ..... 1010111 @r_vm
+vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
+vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
+vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
+vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
+vsll_vv         100101 . ..... ..... 000 ..... 1010111 @r_vm
+vsll_vx         100101 . ..... ..... 100 ..... 1010111 @r_vm
+vsll_vi         100101 . ..... ..... 011 ..... 1010111 @r_vm
+vsrl_vv         101000 . ..... ..... 000 ..... 1010111 @r_vm
+vsrl_vx         101000 . ..... ..... 100 ..... 1010111 @r_vm
+vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
+vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
+vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
+vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
+vnsrl_vv        101100 . ..... ..... 000 ..... 1010111 @r_vm
+vnsrl_vx        101100 . ..... ..... 100 ..... 1010111 @r_vm
+vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
+vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
+vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
+vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index a1c1960..6af29d0 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -204,5 +204,30 @@ GEN_VECTOR_R_VM(vwsubu_wx)
 GEN_VECTOR_R_VM(vwsub_wv)
 GEN_VECTOR_R_VM(vwsub_wx)
 
+GEN_VECTOR_R_VM(vand_vv)
+GEN_VECTOR_R_VM(vand_vx)
+GEN_VECTOR_R_VM(vand_vi)
+GEN_VECTOR_R_VM(vor_vv)
+GEN_VECTOR_R_VM(vor_vx)
+GEN_VECTOR_R_VM(vor_vi)
+GEN_VECTOR_R_VM(vxor_vv)
+GEN_VECTOR_R_VM(vxor_vx)
+GEN_VECTOR_R_VM(vxor_vi)
+GEN_VECTOR_R_VM(vsll_vv)
+GEN_VECTOR_R_VM(vsll_vx)
+GEN_VECTOR_R_VM(vsll_vi)
+GEN_VECTOR_R_VM(vsrl_vv)
+GEN_VECTOR_R_VM(vsrl_vx)
+GEN_VECTOR_R_VM(vsrl_vi)
+GEN_VECTOR_R_VM(vsra_vv)
+GEN_VECTOR_R_VM(vsra_vx)
+GEN_VECTOR_R_VM(vsra_vi)
+GEN_VECTOR_R_VM(vnsrl_vv)
+GEN_VECTOR_R_VM(vnsrl_vx)
+GEN_VECTOR_R_VM(vnsrl_vi)
+GEN_VECTOR_R_VM(vnsra_vv)
+GEN_VECTOR_R_VM(vnsra_vx)
+GEN_VECTOR_R_VM(vnsra_vi)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 95336c9..298a10a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -268,6 +268,25 @@ static void vector_tail_widen(CPURISCVState *env, int vreg, int index,
     }
 }
 
+static void vector_tail_narrow(CPURISCVState *env, int vreg, int index,
+    int width)
+{
+    switch (width) {
+    case 8:
+        env->vfp.vreg[vreg].u8[index] = 0;
+        break;
+    case 16:
+        env->vfp.vreg[vreg].u16[index] = 0;
+        break;
+    case 32:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
 static inline int vector_get_carry(CPURISCVState *env, int width, int lmul,
     int index)
 {
@@ -7131,3 +7150,1461 @@ void VECTOR_HELPER(vwsub_wx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
     }
     env->vfp.vstart = 0;
 }
+
+void VECTOR_HELPER(vand_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
+                        & env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j]
+                        & env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j]
+                        & env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j]
+                        & env->vfp.vreg[src2].u64[j];
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
+void VECTOR_HELPER(vand_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->gpr[rs1]
+                        & env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->gpr[rs1]
+                        & env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->gpr[rs1]
+                        & env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        (uint64_t)extend_gpr(env->gpr[rs1])
+                        & env->vfp.vreg[src2].u64[j];
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
+void VECTOR_HELPER(vand_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].s8[j] = sign_extend(rs1, 5)
+                        & env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sign_extend(rs1, 5)
+                        & env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sign_extend(rs1, 5)
+                        & env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sign_extend(rs1, 5)
+                        & env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vor_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
+                        | env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j]
+                        | env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j]
+                        | env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j]
+                        | env->vfp.vreg[src2].u64[j];
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
+void VECTOR_HELPER(vor_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->gpr[rs1]
+                        | env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->gpr[rs1]
+                        | env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->gpr[rs1]
+                        | env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        (uint64_t)extend_gpr(env->gpr[rs1])
+                        | env->vfp.vreg[src2].u64[j];
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
+void VECTOR_HELPER(vor_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].s8[j] = sign_extend(rs1, 5)
+                        | env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sign_extend(rs1, 5)
+                        | env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sign_extend(rs1, 5)
+                        | env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sign_extend(rs1, 5)
+                        | env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vxor_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
+                        ^ env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j]
+                        ^ env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j]
+                        ^ env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j]
+                        ^ env->vfp.vreg[src2].u64[j];
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
+void VECTOR_HELPER(vxor_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->gpr[rs1]
+                        ^ env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->gpr[rs1]
+                        ^ env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->gpr[rs1]
+                        ^ env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        (uint64_t)extend_gpr(env->gpr[rs1])
+                        ^ env->vfp.vreg[src2].u64[j];
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
+void VECTOR_HELPER(vxor_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].s8[j] = sign_extend(rs1, 5)
+                        ^ env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sign_extend(rs1, 5)
+                        ^ env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sign_extend(rs1, 5)
+                        ^ env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sign_extend(rs1, 5)
+                        ^ env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vsll_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        << (env->vfp.vreg[src1].u8[j] & 0x7);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        << (env->vfp.vreg[src1].u16[j] & 0xf);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        << (env->vfp.vreg[src1].u32[j] & 0x1f);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        << (env->vfp.vreg[src1].u64[j] & 0x3f);
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
+void VECTOR_HELPER(vsll_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        << (env->gpr[rs1] & 0x7);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        << (env->gpr[rs1] & 0xf);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        << (env->gpr[rs1] & 0x1f);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        << ((uint64_t)extend_gpr(env->gpr[rs1]) & 0x3f);
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
+void VECTOR_HELPER(vsll_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        << (rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        << (rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        << (rs1);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        << (rs1);
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
+void VECTOR_HELPER(vsrl_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        >> (env->vfp.vreg[src1].u8[j] & 0x7);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        >> (env->vfp.vreg[src1].u16[j] & 0xf);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        >> (env->vfp.vreg[src1].u32[j] & 0x1f);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        >> (env->vfp.vreg[src1].u64[j] & 0x3f);
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
+void VECTOR_HELPER(vsrl_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        >> (env->gpr[rs1] & 0x7);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        >> (env->gpr[rs1] & 0xf);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        >> (env->gpr[rs1] & 0x1f);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        >> ((uint64_t)extend_gpr(env->gpr[rs1]) & 0x3f);
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
+void VECTOR_HELPER(vsrl_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        >> (rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        >> (rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        >> (rs1);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        >> (rs1);
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
+void VECTOR_HELPER(vsra_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j]
+                        >> (env->vfp.vreg[src1].s8[j] & 0x7);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                        >> (env->vfp.vreg[src1].s16[j] & 0xf);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                        >> (env->vfp.vreg[src1].s32[j] & 0x1f);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        >> (env->vfp.vreg[src1].s64[j] & 0x3f);
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
+void VECTOR_HELPER(vsra_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j]
+                        >> (env->gpr[rs1] & 0x7);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                        >> (env->gpr[rs1] & 0xf);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                        >> (env->gpr[rs1] & 0x1f);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        >> ((uint64_t)extend_gpr(env->gpr[rs1]) & 0x3f);
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
+void VECTOR_HELPER(vsra_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
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
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j]
+                        >> (rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                        >> (rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                        >> (rs1);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        >> (rs1);
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
+void VECTOR_HELPER(vnsrl_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u16[k]
+                        >> (env->vfp.vreg[src1].u8[j] & 0xf);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u32[k]
+                        >> (env->vfp.vreg[src1].u16[j] & 0x1f);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u64[k]
+                        >> (env->vfp.vreg[src1].u32[j] & 0x3f);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_narrow(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vnsrl_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u16[k]
+                        >> (env->gpr[rs1] & 0xf);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u32[k]
+                        >> (env->gpr[rs1] & 0x1f);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u64[k]
+                        >> (env->gpr[rs1] & 0x3f);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_narrow(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vnsrl_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u16[k]
+                        >> (rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u32[k]
+                        >> (rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u64[k]
+                        >> (rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_narrow(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vnsra_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s16[k]
+                        >> (env->vfp.vreg[src1].s8[j] & 0xf);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s32[k]
+                        >> (env->vfp.vreg[src1].s16[j] & 0x1f);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s64[k]
+                        >> (env->vfp.vreg[src1].s32[j] & 0x3f);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_narrow(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vnsra_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s16[k]
+                        >> (env->gpr[rs1] & 0xf);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s32[k]
+                        >> (env->gpr[rs1] & 0x1f);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s64[k]
+                        >> (env->gpr[rs1] & 0x3f);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_narrow(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vnsra_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s16[k]
+                        >> (rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s32[k]
+                        >> (rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s64[k]
+                        >> (rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_narrow(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
-- 
2.7.4


