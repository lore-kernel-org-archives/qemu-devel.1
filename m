Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE95C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1D520C09
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MYcBFgDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1D520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowWA-0001cd-5T
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIH-0003A5-GR
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIA-0002yu-SV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208430; x=1624744430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gj1u+FapHCwwuIZgqjGxFFgeMDqarp33uURoM2xuAB8=;
 b=MYcBFgDoYjG2lVd8rVsQszA6Ses+F9pMNFEJNFx0KwGV8L6cjA5qcVUf
 5KbOPKQi6aWge8jXbPG2c+buELbWVF01cCpatBbdjph2yspx11kZGyCAS
 g27mOjRrmCkzBxjP5OcSpDr48C1ZeVXPKK/nWBGjpFFZfBxq3zMmvvd5M
 iT3uOnHj2p71XjN9AoaWKEo511UizJafOOnFBX479du3KHzoN5aNoSX+l
 FBLcT957CVBTApjq2HpARHoxwV1+CT+vaXiN1HrDFK1YaX4wehqKTsI31
 ARcH5Q6/2h99IuineHp9dHkYN8IxQkKSr7nssr84xX4EJ8mR8gR8fhX4B g==;
IronPort-SDR: YkloRcOG+JHKiLAxVT5JflH0SOhgMFrYPobmS0lwEXF84KFANVAUDt+NFxjlPDTICRb1OiD4X3
 zPYfuruOTXVfdeYHhwH48GCZV/j62dyD7ww55G9TUQiwaTcwF6PVlce1DdKSO0zcJvEx9HC+HR
 d2tJ5UrXmb1B/NzudjIhKPZmzoBfIHAQ2a4m9cCUgGgZPZqC3qEHknW87K1a6cnUEQGFOspw9l
 e8xgzQfE58X1p5V4DKE/zZNY/YquZjlJV1QAY3rSBPqzS9Dzdu4WADQOQjmHPoV+SUI5xirAjD
 IEk=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261259"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:40 +0800
IronPort-SDR: XUtclv3oF28rqbCTFrl2dhv7RjZ7FmPG07X+N0YZwJvMrjO3Z+nSNYN6P0guzIaoZfVkhtXioI
 QuYGZf1zSH5pqmBPbJXB90K2L+RYdZ0pI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:38 -0700
IronPort-SDR: u9x9oi+I+CTA0LWNLNr4GOOSzfgKEeC8ndTD003KIkittX/kQSN50o/RPHIRWB+WgWGm6ZH9fX
 gW9xtCpPHpwA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 21/63] target/riscv: vector integer divide instructions
Date: Fri, 26 Jun 2020 14:43:28 -0700
Message-Id: <20200626214410.3613258-22-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-20-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 33 +++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
 target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c2de0d29ba..e14979e452 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -568,3 +568,36 @@ DEF_HELPER_6(vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vdivu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6b29aad4d2..cf58764308 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -373,6 +373,14 @@ vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
 vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
 vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
 vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
+vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
+vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
+vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
+vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
+vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
+vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
+vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
+vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b5ea1c59a1..f3a8baf581 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1581,3 +1581,13 @@ GEN_OPIVX_GVEC_TRANS(vmul_vx,  muls)
 GEN_OPIVX_TRANS(vmulh_vx, opivx_check)
 GEN_OPIVX_TRANS(vmulhu_vx, opivx_check)
 GEN_OPIVX_TRANS(vmulhsu_vx, opivx_check)
+
+/* Vector Integer Divide Instructions */
+GEN_OPIVV_TRANS(vdivu_vv, opivv_check)
+GEN_OPIVV_TRANS(vdiv_vv, opivv_check)
+GEN_OPIVV_TRANS(vremu_vv, opivv_check)
+GEN_OPIVV_TRANS(vrem_vv, opivv_check)
+GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
+GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
+GEN_OPIVX_TRANS(vremu_vx, opivx_check)
+GEN_OPIVX_TRANS(vrem_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ce4aae8753..e0a372967a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1766,3 +1766,77 @@ GEN_VEXT_VX(vmulhsu_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vmulhsu_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vmulhsu_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vmulhsu_vx_d, 8, 8, clearq)
+
+/* Vector Integer Divide Instructions */
+#define DO_DIVU(N, M) (unlikely(M == 0) ? (__typeof(N))(-1) : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? N : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? (__typeof(N))(-1) :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? N :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
+RVVCALL(OPIVV2, vdivu_vv_b, OP_UUU_B, H1, H1, H1, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_h, OP_UUU_H, H2, H2, H2, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_w, OP_UUU_W, H4, H4, H4, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_d, OP_UUU_D, H8, H8, H8, DO_DIVU)
+RVVCALL(OPIVV2, vdiv_vv_b, OP_SSS_B, H1, H1, H1, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_h, OP_SSS_H, H2, H2, H2, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_w, OP_SSS_W, H4, H4, H4, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_d, OP_SSS_D, H8, H8, H8, DO_DIV)
+RVVCALL(OPIVV2, vremu_vv_b, OP_UUU_B, H1, H1, H1, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_h, OP_UUU_H, H2, H2, H2, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_w, OP_UUU_W, H4, H4, H4, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_d, OP_UUU_D, H8, H8, H8, DO_REMU)
+RVVCALL(OPIVV2, vrem_vv_b, OP_SSS_B, H1, H1, H1, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_h, OP_SSS_H, H2, H2, H2, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_w, OP_SSS_W, H4, H4, H4, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_d, OP_SSS_D, H8, H8, H8, DO_REM)
+GEN_VEXT_VV(vdivu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdivu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdivu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdivu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vdiv_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdiv_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdiv_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdiv_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vremu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vremu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vremu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vremu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vrem_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vrem_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vrem_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vrem_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vdivu_vx_b, OP_UUU_B, H1, H1, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_h, OP_UUU_H, H2, H2, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_w, OP_UUU_W, H4, H4, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_d, OP_UUU_D, H8, H8, DO_DIVU)
+RVVCALL(OPIVX2, vdiv_vx_b, OP_SSS_B, H1, H1, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_h, OP_SSS_H, H2, H2, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_w, OP_SSS_W, H4, H4, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_d, OP_SSS_D, H8, H8, DO_DIV)
+RVVCALL(OPIVX2, vremu_vx_b, OP_UUU_B, H1, H1, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_h, OP_UUU_H, H2, H2, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_w, OP_UUU_W, H4, H4, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_d, OP_UUU_D, H8, H8, DO_REMU)
+RVVCALL(OPIVX2, vrem_vx_b, OP_SSS_B, H1, H1, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_h, OP_SSS_H, H2, H2, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_w, OP_SSS_W, H4, H4, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_d, OP_SSS_D, H8, H8, DO_REM)
+GEN_VEXT_VX(vdivu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdivu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdivu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdivu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vdiv_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdiv_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdiv_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdiv_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vremu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vremu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vremu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vremu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
-- 
2.27.0


