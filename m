Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC9ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB28206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB28206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wSw-00070U-2R
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wED-0007xC-HT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE2-0008BA-Sc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wE0-0007mn-TG; Wed, 11 Sep 2019 02:35:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.352111-0.00568075-0.642208; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01l07423; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRLrNg_1568183697; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRLrNg_1568183697)
 by smtp.aliyun-inc.com(10.147.43.95); Wed, 11 Sep 2019 14:34:58 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:35 +0800
Message-Id: <1568183141-67641-12-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 11/17] RISC-V: add vector extension integer
 instructions part4, mul/div/merge
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
 target/riscv/helper.h                   |   41 +
 target/riscv/insn32.decode              |   41 +
 target/riscv/insn_trans/trans_rvv.inc.c |   41 +
 target/riscv/vector_helper.c            | 2838 +++++++++++++++++++++++++++++++
 4 files changed, 2961 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7354b12..ab31ef7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -229,5 +229,46 @@ DEF_HELPER_5(vector_vmsgtu_vi, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vmsgt_vx, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vmsgt_vi, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_5(vector_vmul_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmul_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmulhsu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmulhsu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmulh_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmulh_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vdivu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vdivu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vdiv_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vdiv_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vremu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vremu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrem_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrem_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmulhu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmulhu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmadd_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnmsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnmsub_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmacc_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmacc_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnmsac_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnmsac_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmulu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmulu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmulsu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmulsu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmul_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmul_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmaccu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmaccu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmacc_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmacc_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmaccsu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmaccsu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwmaccus_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmerge_vvm, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmerge_vxm, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmerge_vim, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1ff0b08..6db18c5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -369,5 +369,46 @@ vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
 vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
 vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
 
+vmul_vv         100101 . ..... ..... 010 ..... 1010111 @r_vm
+vmul_vx         100101 . ..... ..... 110 ..... 1010111 @r_vm
+vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
+vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
+vmulh_vv        100111 . ..... ..... 010 ..... 1010111 @r_vm
+vmulh_vx        100111 . ..... ..... 110 ..... 1010111 @r_vm
+vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
+vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
+vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
+vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
+vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
+vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
+vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
+vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
+vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
+vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
+vwmulu_vv       111000 . ..... ..... 010 ..... 1010111 @r_vm
+vwmulu_vx       111000 . ..... ..... 110 ..... 1010111 @r_vm
+vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
+vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
+vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
+vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
+vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
+vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
+vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
+vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
+vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
+vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vmerge_vvm      010111 . ..... ..... 000 ..... 1010111 @r_vm
+vmerge_vxm      010111 . ..... ..... 100 ..... 1010111 @r_vm
+vmerge_vim      010111 . ..... ..... 011 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index cd5ab07..1ba52e7 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -258,5 +258,46 @@ GEN_VECTOR_R_VM(vmaxu_vx)
 GEN_VECTOR_R_VM(vmax_vv)
 GEN_VECTOR_R_VM(vmax_vx)
 
+GEN_VECTOR_R_VM(vmulhu_vv)
+GEN_VECTOR_R_VM(vmulhu_vx)
+GEN_VECTOR_R_VM(vmul_vv)
+GEN_VECTOR_R_VM(vmul_vx)
+GEN_VECTOR_R_VM(vmulhsu_vv)
+GEN_VECTOR_R_VM(vmulhsu_vx)
+GEN_VECTOR_R_VM(vmulh_vv)
+GEN_VECTOR_R_VM(vmulh_vx)
+GEN_VECTOR_R_VM(vdivu_vv)
+GEN_VECTOR_R_VM(vdivu_vx)
+GEN_VECTOR_R_VM(vdiv_vv)
+GEN_VECTOR_R_VM(vdiv_vx)
+GEN_VECTOR_R_VM(vremu_vv)
+GEN_VECTOR_R_VM(vremu_vx)
+GEN_VECTOR_R_VM(vrem_vv)
+GEN_VECTOR_R_VM(vrem_vx)
+GEN_VECTOR_R_VM(vmacc_vv)
+GEN_VECTOR_R_VM(vmacc_vx)
+GEN_VECTOR_R_VM(vnmsac_vv)
+GEN_VECTOR_R_VM(vnmsac_vx)
+GEN_VECTOR_R_VM(vmadd_vv)
+GEN_VECTOR_R_VM(vmadd_vx)
+GEN_VECTOR_R_VM(vnmsub_vv)
+GEN_VECTOR_R_VM(vnmsub_vx)
+GEN_VECTOR_R_VM(vwmulu_vv)
+GEN_VECTOR_R_VM(vwmulu_vx)
+GEN_VECTOR_R_VM(vwmulsu_vv)
+GEN_VECTOR_R_VM(vwmulsu_vx)
+GEN_VECTOR_R_VM(vwmul_vv)
+GEN_VECTOR_R_VM(vwmul_vx)
+GEN_VECTOR_R_VM(vwmaccu_vv)
+GEN_VECTOR_R_VM(vwmaccu_vx)
+GEN_VECTOR_R_VM(vwmacc_vv)
+GEN_VECTOR_R_VM(vwmacc_vx)
+GEN_VECTOR_R_VM(vwmaccsu_vv)
+GEN_VECTOR_R_VM(vwmaccsu_vx)
+GEN_VECTOR_R_VM(vwmaccus_vx)
+GEN_VECTOR_R_VM(vmerge_vvm)
+GEN_VECTOR_R_VM(vmerge_vxm)
+GEN_VECTOR_R_VM(vmerge_vim)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fbf2145..49f1cb8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -10888,3 +10888,2841 @@ void VECTOR_HELPER(vmax_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
     env->vfp.vstart = 0;
 }
 
+void VECTOR_HELPER(vmulhu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].u8[j] =
+                        ((uint16_t)env->vfp.vreg[src1].u8[j]
+                        * (uint16_t)env->vfp.vreg[src2].u8[j]) >> width;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] =
+                        ((uint32_t)env->vfp.vreg[src1].u16[j]
+                        * (uint32_t)env->vfp.vreg[src2].u16[j]) >> width;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] =
+                        ((uint64_t)env->vfp.vreg[src1].u32[j]
+                        * (uint64_t)env->vfp.vreg[src2].u32[j]) >> width;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = u64xu64_lh(
+                        env->vfp.vreg[src1].u64[j], env->vfp.vreg[src2].u64[j]);
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
+void VECTOR_HELPER(vmulhu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].u8[j] =
+                        ((uint16_t)(uint8_t)env->gpr[rs1]
+                        * (uint16_t)env->vfp.vreg[src2].u8[j]) >> width;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] =
+                        ((uint32_t)(uint16_t)env->gpr[rs1]
+                        * (uint32_t)env->vfp.vreg[src2].u16[j]) >> width;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] =
+                        ((uint64_t)(uint32_t)env->gpr[rs1]
+                        * (uint64_t)env->vfp.vreg[src2].u32[j]) >> width;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = u64xu64_lh(
+                        (uint64_t)extend_gpr(env->gpr[rs1])
+                        , env->vfp.vreg[src2].u64[j]);
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
+void VECTOR_HELPER(vmul_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src1].s8[j]
+                        * env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src1].s16[j]
+                        * env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src1].s32[j]
+                        * env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src1].s64[j]
+                        * env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vmul_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] = env->gpr[rs1]
+                        * env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->gpr[rs1]
+                        * env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->gpr[rs1]
+                        * env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] =
+                        (int64_t)extend_gpr(env->gpr[rs1])
+                        * env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vmulhsu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] =
+                        ((uint16_t)env->vfp.vreg[src1].u8[j]
+                        * (int16_t)env->vfp.vreg[src2].s8[j]) >> width;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] =
+                        ((uint32_t)env->vfp.vreg[src1].u16[j]
+                        * (int32_t)env->vfp.vreg[src2].s16[j]) >> width;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] =
+                        ((uint64_t)env->vfp.vreg[src1].u32[j]
+                        * (int64_t)env->vfp.vreg[src2].s32[j]) >> width;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = s64xu64_lh(
+                        env->vfp.vreg[src2].s64[j], env->vfp.vreg[src1].u64[j]);
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
+void VECTOR_HELPER(vmulhsu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] =
+                        ((uint16_t)(uint8_t)env->gpr[rs1]
+                        * (int16_t)env->vfp.vreg[src2].s8[j]) >> width;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] =
+                        ((uint32_t)(uint16_t)env->gpr[rs1]
+                        * (int32_t)env->vfp.vreg[src2].s16[j]) >> width;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] =
+                        ((uint64_t)(uint32_t)env->gpr[rs1]
+                        * (int64_t)env->vfp.vreg[src2].s32[j]) >> width;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = s64xu64_lh(
+                        env->vfp.vreg[src2].s64[j],
+                        (uint64_t)extend_gpr(env->gpr[rs1]));
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
+void VECTOR_HELPER(vmulh_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] =
+                        ((int16_t)env->vfp.vreg[src1].s8[j]
+                        * (int16_t)env->vfp.vreg[src2].s8[j]) >> width;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] =
+                        ((int32_t)env->vfp.vreg[src1].s16[j]
+                        * (int32_t)env->vfp.vreg[src2].s16[j]) >> width;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] =
+                        ((int64_t)env->vfp.vreg[src1].s32[j]
+                        * (int64_t)env->vfp.vreg[src2].s32[j]) >> width;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = s64xs64_lh(
+                        env->vfp.vreg[src1].s64[j], env->vfp.vreg[src2].s64[j]);
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
+void VECTOR_HELPER(vmulh_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] =
+                        ((int16_t)(int8_t)env->gpr[rs1]
+                        * (int16_t)env->vfp.vreg[src2].s8[j]) >> width;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] =
+                        ((int32_t)(int16_t)env->gpr[rs1]
+                        * (int32_t)env->vfp.vreg[src2].s16[j]) >> width;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] =
+                        ((int64_t)(int32_t)env->gpr[rs1]
+                        * (int64_t)env->vfp.vreg[src2].s32[j]) >> width;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = s64xs64_lh(
+                        (int64_t)extend_gpr(env->gpr[rs1])
+                        , env->vfp.vreg[src2].s64[j]);
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
+void VECTOR_HELPER(vdivu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if (env->vfp.vreg[src1].u8[j] == 0) {
+                        env->vfp.vreg[dest].u8[j] = UINT8_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j] /
+                            env->vfp.vreg[src1].u8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u16[j] == 0) {
+                        env->vfp.vreg[dest].u16[j] = UINT16_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                            / env->vfp.vreg[src1].u16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u32[j] == 0) {
+                        env->vfp.vreg[dest].u32[j] = UINT32_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                            / env->vfp.vreg[src1].u32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u64[j] == 0) {
+                        env->vfp.vreg[dest].u64[j] = UINT64_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        / env->vfp.vreg[src1].u64[j];
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
+void VECTOR_HELPER(vdivu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if ((uint8_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].u8[j] = UINT8_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j] /
+                            (uint8_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].u16[j] = UINT16_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                            / (uint16_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].u32[j] = UINT32_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                            / (uint32_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)extend_gpr(env->gpr[rs1]) == 0) {
+                        env->vfp.vreg[dest].u64[j] = UINT64_MAX;
+                    } else {
+                        env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        / (uint64_t)extend_gpr(env->gpr[rs1]);
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
+void VECTOR_HELPER(vdiv_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if (env->vfp.vreg[src1].s8[j] == 0) {
+                        env->vfp.vreg[dest].s8[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s8[j] == INT8_MIN) &&
+                        (env->vfp.vreg[src1].s8[j] == (int8_t)(-1))) {
+                        env->vfp.vreg[dest].s8[j] = INT8_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j] /
+                            env->vfp.vreg[src1].s8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s16[j] == 0) {
+                        env->vfp.vreg[dest].s16[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s16[j] == INT16_MIN) &&
+                        (env->vfp.vreg[src1].s16[j] == (int16_t)(-1))) {
+                        env->vfp.vreg[dest].s16[j] = INT16_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                            / env->vfp.vreg[src1].s16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s32[j] == 0) {
+                        env->vfp.vreg[dest].s32[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s32[j] == INT32_MIN) &&
+                        (env->vfp.vreg[src1].s32[j] == (int32_t)(-1))) {
+                        env->vfp.vreg[dest].s32[j] = INT32_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                            / env->vfp.vreg[src1].s32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s64[j] == 0) {
+                        env->vfp.vreg[dest].s64[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s64[j] == INT64_MIN) &&
+                        (env->vfp.vreg[src1].s64[j] == (int64_t)(-1))) {
+                        env->vfp.vreg[dest].s64[j] = INT64_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        / env->vfp.vreg[src1].s64[j];
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
+void VECTOR_HELPER(vdiv_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if ((int8_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].s8[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s8[j] == INT8_MIN) &&
+                        ((int8_t)env->gpr[rs1] == (int8_t)(-1))) {
+                        env->vfp.vreg[dest].s8[j] = INT8_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j] /
+                            (int8_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int16_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].s16[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s16[j] == INT16_MIN) &&
+                        ((int16_t)env->gpr[rs1] == (int16_t)(-1))) {
+                        env->vfp.vreg[dest].s16[j] = INT16_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                            / (int16_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int32_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].s32[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s32[j] == INT32_MIN) &&
+                        ((int32_t)env->gpr[rs1] == (int32_t)(-1))) {
+                        env->vfp.vreg[dest].s32[j] = INT32_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                            / (int32_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int64_t)extend_gpr(env->gpr[rs1]) == 0) {
+                        env->vfp.vreg[dest].s64[j] = -1;
+                    } else if ((env->vfp.vreg[src2].s64[j] == INT64_MIN) &&
+                        ((int64_t)extend_gpr(env->gpr[rs1]) == (int64_t)(-1))) {
+                        env->vfp.vreg[dest].s64[j] = INT64_MIN;
+                    } else {
+                        env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        / (int64_t)extend_gpr(env->gpr[rs1]);
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
+void VECTOR_HELPER(vremu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if (env->vfp.vreg[src1].u8[j] == 0) {
+                        env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j] %
+                            env->vfp.vreg[src1].u8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u16[j] == 0) {
+                        env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                            % env->vfp.vreg[src1].u16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u32[j] == 0) {
+                        env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                            % env->vfp.vreg[src1].u32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].u64[j] == 0) {
+                        env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        % env->vfp.vreg[src1].u64[j];
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
+void VECTOR_HELPER(vremu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if ((uint8_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j] %
+                            (uint8_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint16_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                            % (uint16_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint32_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                            % (uint32_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((uint64_t)extend_gpr(env->gpr[rs1]) == 0) {
+                        env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        % (uint64_t)extend_gpr(env->gpr[rs1]);
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
+void VECTOR_HELPER(vrem_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if (env->vfp.vreg[src1].s8[j] == 0) {
+                        env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j];
+                    } else if ((env->vfp.vreg[src2].s8[j] == INT8_MIN) &&
+                        (env->vfp.vreg[src1].s8[j] == (int8_t)(-1))) {
+                        env->vfp.vreg[dest].s8[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j] %
+                            env->vfp.vreg[src1].s8[j];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s16[j] == 0) {
+                        env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j];
+                    } else if ((env->vfp.vreg[src2].s16[j] == INT16_MIN) &&
+                        (env->vfp.vreg[src1].s16[j] == (int16_t)(-1))) {
+                        env->vfp.vreg[dest].s16[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                            % env->vfp.vreg[src1].s16[j];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s32[j] == 0) {
+                        env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j];
+                    } else if ((env->vfp.vreg[src2].s32[j] == INT32_MIN) &&
+                        (env->vfp.vreg[src1].s32[j] == (int32_t)(-1))) {
+                        env->vfp.vreg[dest].s32[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                            % env->vfp.vreg[src1].s32[j];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (env->vfp.vreg[src1].s64[j] == 0) {
+                        env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j];
+                    } else if ((env->vfp.vreg[src2].s64[j] == INT64_MIN) &&
+                        (env->vfp.vreg[src1].s64[j] == (int64_t)(-1))) {
+                        env->vfp.vreg[dest].s64[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        % env->vfp.vreg[src1].s64[j];
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
+void VECTOR_HELPER(vrem_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    if ((int8_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j];
+                    } else if ((env->vfp.vreg[src2].s8[j] == INT8_MIN) &&
+                        ((int8_t)env->gpr[rs1] == (int8_t)(-1))) {
+                        env->vfp.vreg[dest].s8[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src2].s8[j] %
+                            (int8_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int16_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j];
+                    } else if ((env->vfp.vreg[src2].s16[j] == INT16_MIN) &&
+                        ((int16_t)env->gpr[rs1] == (int16_t)(-1))) {
+                        env->vfp.vreg[dest].s16[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                            % (int16_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int32_t)env->gpr[rs1] == 0) {
+                        env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j];
+                    } else if ((env->vfp.vreg[src2].s32[j] == INT32_MIN) &&
+                        ((int32_t)env->gpr[rs1] == (int32_t)(-1))) {
+                        env->vfp.vreg[dest].s32[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                            % (int32_t)env->gpr[rs1];
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if ((int64_t)extend_gpr(env->gpr[rs1]) == 0) {
+                        env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j];
+                    } else if ((env->vfp.vreg[src2].s64[j] == INT64_MIN) &&
+                        ((int64_t)extend_gpr(env->gpr[rs1]) == (int64_t)(-1))) {
+                        env->vfp.vreg[dest].s64[j] = 0;
+                    } else {
+                        env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        % (int64_t)extend_gpr(env->gpr[rs1]);
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
+void VECTOR_HELPER(vmacc_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] += env->vfp.vreg[src1].s8[j]
+                        * env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] += env->vfp.vreg[src1].s16[j]
+                        * env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] += env->vfp.vreg[src1].s32[j]
+                        * env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] += env->vfp.vreg[src1].s64[j]
+                        * env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vmacc_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] += env->gpr[rs1]
+                        * env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] += env->gpr[rs1]
+                        * env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] += env->gpr[rs1]
+                        * env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] +=
+                        (int64_t)extend_gpr(env->gpr[rs1])
+                        * env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vnmsac_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] -= env->vfp.vreg[src1].s8[j]
+                        * env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] -= env->vfp.vreg[src1].s16[j]
+                        * env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] -= env->vfp.vreg[src1].s32[j]
+                        * env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] -= env->vfp.vreg[src1].s64[j]
+                        * env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vnmsac_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] -= env->gpr[rs1]
+                        * env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] -= env->gpr[rs1]
+                        * env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] -= env->gpr[rs1]
+                        * env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] -=
+                        (int64_t)extend_gpr(env->gpr[rs1])
+                        * env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vmadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] = env->vfp.vreg[src1].s8[j]
+                        * env->vfp.vreg[dest].s8[j]
+                        + env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src1].s16[j]
+                        * env->vfp.vreg[dest].s16[j]
+                        + env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src1].s32[j]
+                        * env->vfp.vreg[dest].s32[j]
+                        + env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src1].s64[j]
+                        * env->vfp.vreg[dest].s64[j]
+                        + env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vmadd_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                    env->vfp.vreg[dest].s8[j] = env->gpr[rs1]
+                        * env->vfp.vreg[dest].s8[j]
+                        + env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->gpr[rs1]
+                        * env->vfp.vreg[dest].s16[j]
+                        + env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->gpr[rs1]
+                        * env->vfp.vreg[dest].s32[j]
+                        + env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] =
+                        (int64_t)extend_gpr(env->gpr[rs1])
+                        * env->vfp.vreg[dest].s64[j]
+                        + env->vfp.vreg[src2].s64[j];
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
+void VECTOR_HELPER(vnmsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                        - env->vfp.vreg[src1].s8[j]
+                        * env->vfp.vreg[dest].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                        - env->vfp.vreg[src1].s16[j]
+                        * env->vfp.vreg[dest].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                        - env->vfp.vreg[src1].s32[j]
+                        * env->vfp.vreg[dest].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        - env->vfp.vreg[src1].s64[j]
+                        * env->vfp.vreg[dest].s64[j];
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
+void VECTOR_HELPER(vnmsub_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
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
+                        - env->gpr[rs1]
+                        * env->vfp.vreg[dest].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = env->vfp.vreg[src2].s16[j]
+                        - env->gpr[rs1]
+                        * env->vfp.vreg[dest].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = env->vfp.vreg[src2].s32[j]
+                        - env->gpr[rs1]
+                        * env->vfp.vreg[dest].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = env->vfp.vreg[src2].s64[j]
+                        - (int64_t)extend_gpr(env->gpr[rs1])
+                        * env->vfp.vreg[dest].s64[j];
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
+void VECTOR_HELPER(vwmulu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src1].u8[j] *
+                        (uint16_t)env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src1].u16[j] *
+                        (uint32_t)env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src1].u32[j] *
+                        (uint64_t)env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwmulu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u8[j] *
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u16[j] *
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u32[j] *
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwmulsu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src2].s8[j] *
+                        (uint16_t)env->vfp.vreg[src1].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src2].s16[j] *
+                        (uint32_t)env->vfp.vreg[src1].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src2].s32[j] *
+                        (uint64_t)env->vfp.vreg[src1].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwmulsu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)((int8_t)env->vfp.vreg[src2].s8[j]) *
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)((int16_t)env->vfp.vreg[src2].s16[j]) *
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)((int32_t)env->vfp.vreg[src2].s32[j]) *
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwmul_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src1].s8[j] *
+                        (int16_t)env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src1].s16[j] *
+                        (int32_t)env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src1].s32[j] *
+                        (int64_t)env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwmul_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)((int8_t)env->vfp.vreg[src2].s8[j]) *
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)((int16_t)env->vfp.vreg[src2].s16[j]) *
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)((int32_t)env->vfp.vreg[src2].s32[j]) *
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwmaccu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] +=
+                        (uint16_t)env->vfp.vreg[src1].u8[j] *
+                        (uint16_t)env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] +=
+                        (uint32_t)env->vfp.vreg[src1].u16[j] *
+                        (uint32_t)env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] +=
+                        (uint64_t)env->vfp.vreg[src1].u32[j] *
+                        (uint64_t)env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwmaccu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] +=
+                        (uint16_t)env->vfp.vreg[src2].u8[j] *
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] +=
+                        (uint32_t)env->vfp.vreg[src2].u16[j] *
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] +=
+                        (uint64_t)env->vfp.vreg[src2].u32[j] *
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwmaccsu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] +=
+                        (int16_t)env->vfp.vreg[src1].s8[j]
+                        * (uint16_t)env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] +=
+                        (int32_t)env->vfp.vreg[src1].s16[j] *
+                        (uint32_t)env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] +=
+                        (int64_t)env->vfp.vreg[src1].s32[j] *
+                        (uint64_t)env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwmaccsu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] +=
+                        (uint16_t)((uint8_t)env->vfp.vreg[src2].u8[j]) *
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] +=
+                        (uint32_t)((uint16_t)env->vfp.vreg[src2].u16[j]) *
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] +=
+                        (uint64_t)((uint32_t)env->vfp.vreg[src2].u32[j]) *
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwmaccus_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] +=
+                        (int16_t)((int8_t)env->vfp.vreg[src2].s8[j]) *
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] +=
+                        (int32_t)((int16_t)env->vfp.vreg[src2].s16[j]) *
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] +=
+                        (int64_t)((int32_t)env->vfp.vreg[src2].s32[j]) *
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwmacc_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] +=
+                        (int16_t)env->vfp.vreg[src1].s8[j]
+                        * (int16_t)env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] +=
+                        (int32_t)env->vfp.vreg[src1].s16[j] *
+                        (int32_t)env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] +=
+                        (int64_t)env->vfp.vreg[src1].s32[j] *
+                        (int64_t)env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwmacc_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] +=
+                        (int16_t)((int8_t)env->vfp.vreg[src2].s8[j]) *
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] +=
+                        (int32_t)((int16_t)env->vfp.vreg[src2].s16[j]) *
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] +=
+                        (int64_t)((int32_t)env->vfp.vreg[src2].s32[j]) *
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmerge_vvm)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl, idx, pos;
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
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src1].u8[j];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j];
+                }
+                break;
+            case 16:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src1].u16[j];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j];
+                }
+                break;
+            case 32:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src1].u32[j];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j];
+                }
+                break;
+            case 64:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src1].u64[j];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j];
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
+void VECTOR_HELPER(vmerge_vxm)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl, idx, pos;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = env->gpr[rs1];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u8[j] = env->gpr[rs1];
+                }
+                break;
+            case 16:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = env->gpr[rs1];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u16[j] = env->gpr[rs1];
+                }
+                break;
+            case 32:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = env->gpr[rs1];
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u32[j] = env->gpr[rs1];
+                }
+                break;
+            case 64:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            (uint64_t)extend_gpr(env->gpr[rs1]);
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u64[j] =
+                        (uint64_t)extend_gpr(env->gpr[rs1]);
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
+void VECTOR_HELPER(vmerge_vim)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl, idx, pos;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src2].u8[j];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] =
+                            (uint8_t)sign_extend(rs1, 5);
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u8[j] = (uint8_t)sign_extend(rs1, 5);
+                }
+                break;
+            case 16:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src2].u16[j];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] =
+                            (uint16_t)sign_extend(rs1, 5);
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u16[j] = (uint16_t)sign_extend(rs1, 5);
+                }
+                break;
+            case 32:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src2].u32[j];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] =
+                            (uint32_t)sign_extend(rs1, 5);
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u32[j] = (uint32_t)sign_extend(rs1, 5);
+                }
+                break;
+            case 64:
+                if (vm == 0) {
+                    vector_get_layout(env, width, lmul, i, &idx, &pos);
+                    if (((env->vfp.vreg[0].u8[idx] >> pos) & 0x1) == 0) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src2].u64[j];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] =
+                            (uint64_t)sign_extend(rs1, 5);
+                    }
+                } else {
+                    if (rs2 != 0) {
+                        riscv_raise_exception(env,
+                                RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    }
+                    env->vfp.vreg[dest].u64[j] = (uint64_t)sign_extend(rs1, 5);
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


