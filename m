Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81695C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EA4208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="isccezTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EA4208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowTl-0005Pe-Lu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIB-00033E-62
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI7-0002ze-Pt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208427; x=1624744427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7rbFNCq4JZJAXHMdUTJ2w1MwZ5JunIW4ZjbwTz5lMyw=;
 b=isccezTJrDpxxeRXWs5lnzqO/IE4tYxZbjwMYVcdVevQB8arZBu0pkV7
 RQJm/1TS1wGV9PgRA1BLhIfcat6WG1mTimRlIrzCf6BTiZ4wBoP9TLxa/
 gnT0UkGaVpTNH3orbeSKls9//4XV1F7So3JKVG7lSMG1BSr0XeCsQZEcZ
 b3eJ4qTzaJA59bsUMqpFl4dAE6gSonEKsfxl+gsCR1VEMRxRighMS3w4s
 ftoD2pbtdZVkQI93ULssPNUAZB8Noo1UAaEhbWE986huZuO76M5bbVNdz
 aBVwbaMvHWrvdcdvnWE1wCkMh7oJ0SdXFVayIZ2diDBC5h0T90rNaMJyi A==;
IronPort-SDR: eF2+kyolYB5H2+m1yY1z+I38tcQu9u58qxDSQ/QjunXb9K3tdoShPDEXmVzR5+4MpAJsuYtvXS
 o+Ce7GnLOIjezwXt7K+qZfYZk3Bi5D1a9PSn5vlLYNWvaOMN6/wzJp2E4Fa1QQ6j27ErPaxKPX
 0fO3O+386FGZ2s7zNWHGxTkaXLT9fBDeK5MbTzlt17kO11AS7YV8LN0FsPcA8oXUtvKcNOGzWX
 lpAxpuo1c0z99ylrfjnvic5Xq0Yht+QQU4PSOhcUqXOZE1ElKz2EpYTkTIuMNFNLb+ulT1QYA9
 FD8=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261256"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:39 +0800
IronPort-SDR: OfRDbF36rcflYuELcRygvUxv6wad1fs35ccCqCC6IxP0tEf++vwhzDH1W+bTWu2SGDZZvzmWLI
 JIapDUDS311bqITjuEOnqA2asY+fDga1M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:38 -0700
IronPort-SDR: v79bH1kOJzfxA8+nOLuW7B3F44lJ5zk6p8OfWdi7lKvYuJ2n8ACml40dYaF/q6kAUU1xxn+x+Q
 lMh1NjKd0VNw==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/63] target/riscv: vector integer min/max instructions
Date: Fri, 26 Jun 2020 14:43:26 -0700
Message-Id: <20200626214410.3613258-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200623215920.2594-18-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 33 ++++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
 target/riscv/vector_helper.c            | 71 +++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2bcb6c7889..9c576e1220 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -502,3 +502,36 @@ DEF_HELPER_6(vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
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
index 5d022ff414..3d8986c74d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -357,6 +357,14 @@ vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
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
index 7d7e3d4cd8..861fd3bf1a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1561,3 +1561,13 @@ GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
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
index 07e474781c..cb41daa3ac 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -855,6 +855,10 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 #define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
 #define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
 #define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
+#define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
+#define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
+#define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
+#define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
 
 /* operation of two vector elements */
 typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
@@ -1532,3 +1536,70 @@ GEN_VEXT_CMP_VX(vmsgt_vx_b, int8_t,  H1, DO_MSGT)
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
2.27.0


