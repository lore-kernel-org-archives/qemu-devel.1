Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A3BECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12112089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12112089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wK3-00067T-Gx
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE5-0007mZ-PC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDz-0008AD-LQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDy-0007rn-IX; Wed, 11 Sep 2019 02:35:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.442378-0.00542541-0.552197; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRMCTm_1568183706; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRMCTm_1568183706)
 by smtp.aliyun-inc.com(10.147.41.199);
 Wed, 11 Sep 2019 14:35:06 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:41 +0800
Message-Id: <1568183141-67641-18-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 17/17] RISC-V: add vector extension
 premutation instructions
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
 target/riscv/helper.h                   |   15 +
 target/riscv/insn32.decode              |   16 +
 target/riscv/insn_trans/trans_rvv.inc.c |   15 +
 target/riscv/vector_helper.c            | 1068 +++++++++++++++++++++++++++++++
 4 files changed, 1114 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 337ac2e..2d153ce 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -417,5 +417,20 @@ DEF_HELPER_3(vector_vid_v, void, env, i32, i32)
 DEF_HELPER_4(vector_vmpopc_m, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vmfirst_m, void, env, i32, i32, i32)
 
+DEF_HELPER_4(vector_vext_x_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmv_s_x, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfmv_f_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfmv_s_f, void, env, i32, i32, i32)
+DEF_HELPER_5(vector_vslideup_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vslideup_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vslide1up_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vslidedown_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vslidedown_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vslide1down_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrgather_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrgather_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrgather_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(vector_vcompress_vm, void, env, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1de776b..c98915b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -558,5 +558,21 @@ vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 
+vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
+vmv_s_x         001101 1 ..... ..... 110 ..... 1010111 @r
+vfmv_f_s        001100 1 ..... ..... 001 ..... 1010111 @r
+vfmv_s_f        001101 1 ..... ..... 101 ..... 1010111 @r
+vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
+vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
+vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
+vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
+vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
+vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
+vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
+vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
+vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
+vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
+
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 85e435a..1774d1f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -471,5 +471,20 @@ GEN_VECTOR_R2_VM(vmsif_m)
 GEN_VECTOR_R2_VM(viota_m)
 GEN_VECTOR_R1_VM(vid_v)
 
+GEN_VECTOR_R(vmv_s_x)
+GEN_VECTOR_R(vfmv_f_s)
+GEN_VECTOR_R(vfmv_s_f)
+GEN_VECTOR_R(vext_x_v)
+GEN_VECTOR_R_VM(vslideup_vx)
+GEN_VECTOR_R_VM(vslideup_vi)
+GEN_VECTOR_R_VM(vslide1up_vx)
+GEN_VECTOR_R_VM(vslidedown_vx)
+GEN_VECTOR_R_VM(vslidedown_vi)
+GEN_VECTOR_R_VM(vslide1down_vx)
+GEN_VECTOR_R_VM(vrgather_vv)
+GEN_VECTOR_R_VM(vrgather_vx)
+GEN_VECTOR_R_VM(vrgather_vi)
+GEN_VECTOR_R(vcompress_vm)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9e15df9..0a25996 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1010,6 +1010,26 @@ static inline bool vector_overlap_dstgp_srcgp(int rd, int dlen, int rs,
     return false;
 }
 
+/* fetch unsigned element by width */
+static inline uint64_t vector_get_iu_elem(CPURISCVState *env, uint32_t width,
+    uint32_t rs2, uint32_t index)
+{
+    uint64_t elem;
+    if (width == 8) {
+        elem = env->vfp.vreg[rs2].u8[index];
+    } else if (width == 16) {
+        elem = env->vfp.vreg[rs2].u16[index];
+    } else if (width == 32) {
+        elem = env->vfp.vreg[rs2].u32[index];
+    } else if (width == 64) {
+        elem = env->vfp.vreg[rs2].u64[index];
+    } else { /* the max of (XLEN, FLEN) is no bigger than 64 */
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return 0;
+    }
+    return elem;
+}
+
 static inline void vector_get_layout(CPURISCVState *env, int width, int lmul,
     int index, int *idx, int *pos)
 {
@@ -24631,3 +24651,1051 @@ void VECTOR_HELPER(vid_v)(CPURISCVState *env, uint32_t vm, uint32_t rd)
     env->vfp.vstart = 0;
     return;
 }
+
+/* vfmv.f.s rd, vs2 # rd = vs2[0] (rs1=0)  */
+void VECTOR_HELPER(vfmv_f_s)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
+    uint32_t rd)
+{
+    int width, flen;
+    uint64_t mask;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    if (env->misa & RVD) {
+        flen = 8;
+    } else if (env->misa & RVF) {
+        flen = 4;
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width =  vector_get_width(env);
+    mask  = (~((uint64_t)0)) << width;
+
+    if (width == 8) {
+            env->fpr[rd] = (uint64_t)env->vfp.vreg[rs2].s8[0] | mask;
+    } else if (width == 16) {
+            env->fpr[rd] = (uint64_t)env->vfp.vreg[rs2].s16[0] | mask;
+    } else if (width == 32) {
+            env->fpr[rd] = (uint64_t)env->vfp.vreg[rs2].s32[0] | mask;
+    } else if (width == 64) {
+        if (flen == 4) {
+            env->fpr[rd] = env->vfp.vreg[rs2].s64[0] & 0xffffffff;
+        } else {
+            env->fpr[rd] = env->vfp.vreg[rs2].s64[0];
+        }
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmv.s.x vd, rs1 # vd[0] = rs1 */
+void VECTOR_HELPER(vmv_s_x)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
+    uint32_t rd)
+{
+    int width;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= env->vfp.vl) {
+        return;
+    }
+
+    memset(&env->vfp.vreg[rd].u8[0], 0, VLEN / 8);
+    width =  vector_get_width(env);
+
+    if (width == 8) {
+        env->vfp.vreg[rd].u8[0] = env->gpr[rs1];
+    } else if (width == 16) {
+        env->vfp.vreg[rd].u16[0] = env->gpr[rs1];
+    } else if (width == 32) {
+        env->vfp.vreg[rd].u32[0] = env->gpr[rs1];
+    } else if (width == 64) {
+        env->vfp.vreg[rd].u64[0] = env->gpr[rs1];
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmv.s.f vd, rs1 #  vd[0] = rs1 (vs2 = 0)  */
+void VECTOR_HELPER(vfmv_s_f)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, flen;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    if (env->vfp.vstart >= env->vfp.vl) {
+        return;
+    }
+    if (env->misa & RVD) {
+        flen = 8;
+    } else if (env->misa & RVF) {
+        flen = 4;
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width =  vector_get_width(env);
+
+    if (width == 8) {
+        env->vfp.vreg[rd].u8[0] = env->fpr[rs1];
+    } else if (width == 16) {
+        env->vfp.vreg[rd].u16[0] = env->fpr[rs1];
+    } else if (width == 32) {
+        env->vfp.vreg[rd].u32[0] = env->fpr[rs1];
+    } else if (width == 64) {
+        if (flen == 4) { /* 1-extended to FLEN bits */
+            env->vfp.vreg[rd].u64[0] = (uint64_t)env->fpr[rs1]
+                                        | 0xffffffff00000000;
+        } else {
+            env->vfp.vreg[rd].u64[0] = env->fpr[rs1];
+        }
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
+void VECTOR_HELPER(vslideup_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax, offset;
+    int i, j, dest, src, k;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_vm_force(vm, rd)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    offset = env->gpr[rs1];
+
+    if (offset < env->vfp.vstart) {
+        offset = env->vfp.vstart;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + ((i - offset) / (VLEN / width));
+        j = i % (VLEN / width);
+        k = (i - offset) % (VLEN / width);
+        if (i < offset) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] =
+                        env->vfp.vreg[src].u8[k];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] =
+                        env->vfp.vreg[src].u16[k];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] =
+                        env->vfp.vreg[src].u32[k];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        env->vfp.vreg[src].u64[k];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vslideup.vi vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
+void VECTOR_HELPER(vslideup_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax, offset;
+    int i, j, dest, src, k;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_vm_force(vm, rd)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    offset = rs1;
+
+    if (offset < env->vfp.vstart) {
+        offset = env->vfp.vstart;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + ((i - offset) / (VLEN / width));
+        j = i % (VLEN / width);
+        k = (i - offset) % (VLEN / width);
+        if (i < offset) {
+            continue;
+        } else if (i < vl) {
+            if (width == 8) {
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] =
+                        env->vfp.vreg[src].u8[k];
+                }
+            } else if (width == 16) {
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] =
+                        env->vfp.vreg[src].u16[k];
+                }
+            } else if (width == 32) {
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] =
+                        env->vfp.vreg[src].u32[k];
+                }
+            } else if (width == 64) {
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        env->vfp.vreg[src].u64[k];
+                }
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
+void VECTOR_HELPER(vslide1up_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src, k;
+    uint64_t s1;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_vm_force(vm, rd)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    s1 = env->gpr[rs1];
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + ((i - 1) / (VLEN / width));
+        j = i % (VLEN / width);
+        k = (i - 1) % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i == 0 && env->vfp.vstart == 0) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = s1;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = s1;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = s1;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = s1;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src].u8[k];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] =
+                        env->vfp.vreg[src].u16[k];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] =
+                        env->vfp.vreg[src].u32[k];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        env->vfp.vreg[src].u64[k];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i + rs1] */
+void VECTOR_HELPER(vslidedown_vx)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax, offset;
+    int i, j, dest, src, k;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    offset = env->gpr[rs1];
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + ((i + offset) / (VLEN / width));
+        j = i % (VLEN / width);
+        k = (i + offset) % (VLEN / width);
+        if (i < offset) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src].u8[k];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = 0;
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src].u16[k];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = 0;
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src].u32[k];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = 0;
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src].u64[k];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] = 0;
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+void VECTOR_HELPER(vslidedown_vi)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax, offset;
+    int i, j, dest, src, k;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    offset = rs1;
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + ((i + offset) / (VLEN / width));
+        j = i % (VLEN / width);
+        k = (i + offset) % (VLEN / width);
+        if (i < offset) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src].u8[k];
+                    } else {
+                        env->vfp.vreg[dest].u8[j] = 0;
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src].u16[k];
+                    } else {
+                        env->vfp.vreg[dest].u16[j] = 0;
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src].u32[k];
+                    } else {
+                        env->vfp.vreg[dest].u32[j] = 0;
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (i + offset < vlmax) {
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src].u64[k];
+                    } else {
+                        env->vfp.vreg[dest].u64[j] = 0;
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vslide1down.vx vd, vs2, rs1, vm # vd[vl - 1]=x[rs1], vd[i] = vs2[i + 1] */
+void VECTOR_HELPER(vslide1down_vx)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src, k;
+    uint64_t s1;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    s1 = env->gpr[rs1];
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + ((i + 1) / (VLEN / width));
+        j = i % (VLEN / width);
+        k = (i + 1) % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i == vl - 1 && i >= env->vfp.vstart) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = s1;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = s1;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = s1;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = s1;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else if (i < vl - 1) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src].u8[k];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] =
+                        env->vfp.vreg[src].u16[k];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] =
+                        env->vfp.vreg[src].u32[k];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        env->vfp.vreg[src].u64[k];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vcompress.vm vd, vs2, vs1
+ * Compress into vd elements of vs2 where vs1 is enabled
+ */
+void VECTOR_HELPER(vcompress_vm)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
+    uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src;
+    uint32_t vd_idx, num = 0;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs1, 1)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+       if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    /* zeroed all elements */
+    for (i = 0; i < lmul; i++) {
+        memset(&env->vfp.vreg[rd + i].u64[0], 0, VLEN / 8);
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (num / (VLEN / width));
+        src = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        vd_idx = num % (VLEN / width);
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_mask_reg(env, rs1, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[vd_idx] =
+                        env->vfp.vreg[src].u8[j];
+                    num++;
+                }
+                break;
+            case 16:
+                if (vector_mask_reg(env, rs1, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[vd_idx] =
+                        env->vfp.vreg[src].u16[j];
+                    num++;
+                }
+                break;
+            case 32:
+                if (vector_mask_reg(env, rs1, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[vd_idx] =
+                        env->vfp.vreg[src].u32[j];
+                    num++;
+                }
+                break;
+            case 64:
+                if (vector_mask_reg(env, rs1, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[vd_idx] =
+                        env->vfp.vreg[src].u64[j];
+                    num++;
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
+void VECTOR_HELPER(vext_x_v)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
+    uint32_t rd)
+{
+    int width;
+    uint64_t elem;
+    target_ulong index = env->gpr[rs1];
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width =  vector_get_width(env);
+
+    elem = vector_get_iu_elem(env, width, rs2, index);
+    if (index >= VLEN / width) { /* index is too big */
+        env->gpr[rd] = 0;
+    } else {
+        env->gpr[rd] = elem;
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vrgather.vv vd, vs2, vs1, vm #
+ * vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]];
+ */
+void VECTOR_HELPER(vrgather_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src, src1;
+    uint32_t index;
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_vm_force(vm, rd)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs1, lmul)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                index = env->vfp.vreg[src1].u8[j];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u8[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src].u8[index];
+                    }
+                }
+                break;
+            case 16:
+                index = env->vfp.vreg[src1].u16[j];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u16[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src].u16[index];
+                    }
+                }
+                break;
+            case 32:
+                index = env->vfp.vreg[src1].u32[j];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u32[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src].u32[index];
+                    }
+                }
+                break;
+            case 64:
+                index = env->vfp.vreg[src1].u64[j];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u64[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src].u64[index];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
+void VECTOR_HELPER(vrgather_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src;
+    uint32_t index;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_vm_force(vm, rd)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                index = env->gpr[rs1];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u8[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src].u8[index];
+                    }
+                }
+                break;
+            case 16:
+                index = env->gpr[rs1];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u16[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src].u16[index];
+                    }
+                }
+                break;
+            case 32:
+                index = env->gpr[rs1];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u32[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src].u32[index];
+                    }
+                }
+                break;
+            case 64:
+                index = env->gpr[rs1];
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u64[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src].u64[index];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vrgather.vi vd, vs2, imm, vm # vd[i] = (imm >= VLMAX) ? 0 : vs2[imm] */
+void VECTOR_HELPER(vrgather_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src;
+    uint32_t index;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_vm_force(vm, rd)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                index = rs1;
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u8[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u8[j] =
+                            env->vfp.vreg[src].u8[index];
+                    }
+                }
+                break;
+            case 16:
+                index = rs1;
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u16[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u16[j] =
+                            env->vfp.vreg[src].u16[index];
+                    }
+                }
+                break;
+            case 32:
+                index = rs1;
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u32[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u32[j] =
+                            env->vfp.vreg[src].u32[index];
+                    }
+                }
+                break;
+            case 64:
+                index = rs1;
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    if (index >= vlmax) {
+                        env->vfp.vreg[dest].u64[j] = 0;
+                    } else {
+                        src = rs2 + (index / (VLEN / width));
+                        index = index % (VLEN / width);
+                        env->vfp.vreg[dest].u64[j] =
+                            env->vfp.vreg[src].u64[index];
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
-- 
2.7.4


