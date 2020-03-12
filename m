Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1CFC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3977920663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3977920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPpB-0000XA-Dp
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPoE-0008CC-Cv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPoC-0005ug-K9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:31:42 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCPoB-0005l0-Lw; Thu, 12 Mar 2020 11:31:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07450939|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.271718-0.00564651-0.722635;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-Omi6J_1584027088; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-Omi6J_1584027088)
 by smtp.aliyun-inc.com(10.147.41.121);
 Thu, 12 Mar 2020 23:31:28 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 16/60] target/riscv: vector integer min/max instructions
Date: Thu, 12 Mar 2020 22:58:16 +0800
Message-Id: <20200312145900.2054-17-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 33 ++++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
 target/riscv/vector_helper.c            | 71 +++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4e6c47c2d2..c7d4ff185a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -492,3 +492,36 @@ DEF_HELPER_6(vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsgt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsgt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsgt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vminu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 525b2fa442..a7619f4e3d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -354,6 +354,14 @@ vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
 vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
 vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
 vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
+vminu_vv        000100 . ..... ..... 000 ..... 1010111 @r_vm
+vminu_vx        000100 . ..... ..... 100 ..... 1010111 @r_vm
+vmin_vv         000101 . ..... ..... 000 ..... 1010111 @r_vm
+vmin_vx         000101 . ..... ..... 100 ..... 1010111 @r_vm
+vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
+vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
+vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
+vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 078d275af6..4437a77878 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1424,3 +1424,13 @@ GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsle_vi, 0, vmsle_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsgtu_vi, 1, vmsgtu_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsgt_vi, 0, vmsgt_vx, opivx_cmp_check)
+
+/* Vector Integer Min/Max Instructions */
+GEN_OPIVV_GVEC_TRANS(vminu_vv, umin)
+GEN_OPIVV_GVEC_TRANS(vmin_vv,  smin)
+GEN_OPIVV_GVEC_TRANS(vmaxu_vv, umax)
+GEN_OPIVV_GVEC_TRANS(vmax_vv,  smax)
+GEN_OPIVX_TRANS(vminu_vx, opivx_check)
+GEN_OPIVX_TRANS(vmin_vx,  opivx_check)
+GEN_OPIVX_TRANS(vmaxu_vx, opivx_check)
+GEN_OPIVX_TRANS(vmax_vx,  opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e7a4e99f46..03e001262f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -849,6 +849,10 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 #define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
 #define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
 #define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
+#define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
+#define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
+#define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
+#define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
 
 /* operation of two vector elements */
 #define OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
@@ -1479,3 +1483,70 @@ GEN_VEXT_CMP_VX(vmsgt_vx_b, int8_t,  H1, DO_MSGT)
 GEN_VEXT_CMP_VX(vmsgt_vx_h, int16_t, H2, DO_MSGT)
 GEN_VEXT_CMP_VX(vmsgt_vx_w, int32_t, H4, DO_MSGT)
 GEN_VEXT_CMP_VX(vmsgt_vx_d, int64_t, H8, DO_MSGT)
+
+/* Vector Integer Min/Max Instructions */
+RVVCALL(OPIVV2, vminu_vv_b, OP_UUU_B, H1, H1, H1, DO_MIN)
+RVVCALL(OPIVV2, vminu_vv_h, OP_UUU_H, H2, H2, H2, DO_MIN)
+RVVCALL(OPIVV2, vminu_vv_w, OP_UUU_W, H4, H4, H4, DO_MIN)
+RVVCALL(OPIVV2, vminu_vv_d, OP_UUU_D, H8, H8, H8, DO_MIN)
+RVVCALL(OPIVV2, vmin_vv_b, OP_SSS_B, H1, H1, H1, DO_MIN)
+RVVCALL(OPIVV2, vmin_vv_h, OP_SSS_H, H2, H2, H2, DO_MIN)
+RVVCALL(OPIVV2, vmin_vv_w, OP_SSS_W, H4, H4, H4, DO_MIN)
+RVVCALL(OPIVV2, vmin_vv_d, OP_SSS_D, H8, H8, H8, DO_MIN)
+RVVCALL(OPIVV2, vmaxu_vv_b, OP_UUU_B, H1, H1, H1, DO_MAX)
+RVVCALL(OPIVV2, vmaxu_vv_h, OP_UUU_H, H2, H2, H2, DO_MAX)
+RVVCALL(OPIVV2, vmaxu_vv_w, OP_UUU_W, H4, H4, H4, DO_MAX)
+RVVCALL(OPIVV2, vmaxu_vv_d, OP_UUU_D, H8, H8, H8, DO_MAX)
+RVVCALL(OPIVV2, vmax_vv_b, OP_SSS_B, H1, H1, H1, DO_MAX)
+RVVCALL(OPIVV2, vmax_vv_h, OP_SSS_H, H2, H2, H2, DO_MAX)
+RVVCALL(OPIVV2, vmax_vv_w, OP_SSS_W, H4, H4, H4, DO_MAX)
+RVVCALL(OPIVV2, vmax_vv_d, OP_SSS_D, H8, H8, H8, DO_MAX)
+GEN_VEXT_VV(vminu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vminu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vminu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vminu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmin_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmin_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmin_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmin_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmaxu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmaxu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmaxu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmaxu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmax_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmax_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmax_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmax_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vminu_vx_b, OP_UUU_B, H1, H1, DO_MIN)
+RVVCALL(OPIVX2, vminu_vx_h, OP_UUU_H, H2, H2, DO_MIN)
+RVVCALL(OPIVX2, vminu_vx_w, OP_UUU_W, H4, H4, DO_MIN)
+RVVCALL(OPIVX2, vminu_vx_d, OP_UUU_D, H8, H8, DO_MIN)
+RVVCALL(OPIVX2, vmin_vx_b, OP_SSS_B, H1, H1, DO_MIN)
+RVVCALL(OPIVX2, vmin_vx_h, OP_SSS_H, H2, H2, DO_MIN)
+RVVCALL(OPIVX2, vmin_vx_w, OP_SSS_W, H4, H4, DO_MIN)
+RVVCALL(OPIVX2, vmin_vx_d, OP_SSS_D, H8, H8, DO_MIN)
+RVVCALL(OPIVX2, vmaxu_vx_b, OP_UUU_B, H1, H1, DO_MAX)
+RVVCALL(OPIVX2, vmaxu_vx_h, OP_UUU_H, H2, H2, DO_MAX)
+RVVCALL(OPIVX2, vmaxu_vx_w, OP_UUU_W, H4, H4, DO_MAX)
+RVVCALL(OPIVX2, vmaxu_vx_d, OP_UUU_D, H8, H8, DO_MAX)
+RVVCALL(OPIVX2, vmax_vx_b, OP_SSS_B, H1, H1, DO_MAX)
+RVVCALL(OPIVX2, vmax_vx_h, OP_SSS_H, H2, H2, DO_MAX)
+RVVCALL(OPIVX2, vmax_vx_w, OP_SSS_W, H4, H4, DO_MAX)
+RVVCALL(OPIVX2, vmax_vx_d, OP_SSS_D, H8, H8, DO_MAX)
+GEN_VEXT_VX(vminu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vminu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vminu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vminu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmin_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmin_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmin_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmin_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmaxu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmaxu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmaxu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmaxu_vx_d, 8, 8,  clearq)
+GEN_VEXT_VX(vmax_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmax_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmax_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmax_vx_d, 8, 8, clearq)
-- 
2.23.0


