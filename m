Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD0EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4FF20663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qbwvukeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowZ7-0007By-K6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIT-0003IV-ON
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIQ-0002zW-PK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208446; x=1624744446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3dPO3aCr6BSjHldxcLS/M/6YAL0PjyvXSK4kkXkgaaU=;
 b=qbwvukeW70d/475Q7vQlTtHp82IgU0y/FSoT85mjy6NXJ5T49TpNPFz5
 TXbobt3mYD4IJQnA/1siyBZo8tuP8C9HvJZyciL90i3S3Y0OJ/vfmrRsN
 eyRz6oHqYKiDyiZ/A5puPMcTXTwqvkwoJaoMSYKr9z2tg6vPlFBv+Y/AL
 Fk0Ypu5VWy5+QHWlZcnL+6EcXkIOfUVvTLbrGWOtbkaH+22Wn+B7iMtiH
 TZWOi3NyaUZOyzaA3oruEFLT1ttctmUFJBViGPCgyCiKP4LXe7zxmIRmU
 H8TqOfC6MkyiX5ozlZwD5kBEakDQE1mG+KU4exC3gf2zjmHv8gGk5leTO w==;
IronPort-SDR: r9Ki6q7X8dEp0GCm9nKYASGs5QnO4zLLPlMZ227a5Q4XfX2iuAjrrFthAS+ThgKwk/DQSUOq1n
 +vz0mL/1l9D/yIWN/07Pk/zoASshtbQzd4BehQrxffE8i4kfqSoFhXJS5gE7DXBd1aQ3RPuyjj
 PrjsHi08Tb6eJ8MUaYxFy61lFuIQ4xyedWU+JaHkHT1EJfaCJDp/5KTCLAGK8aBxQAPLlm6iOr
 16Y7akjWrRUBb/24rCXilIY+pwXx1vR5+PfUKlh2nwwolyQN6OYgCDz5GhZtHIsboV0TfLcnI7
 3iU=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261263"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:40 +0800
IronPort-SDR: K4dxpUxW559ujLefDVGwVgfZApVrKBuSFrOLk4nLeCADRH8nR6gsGOiv4+7K59S909pZx4TN28
 oQXGPcjhazMjizGGyQxiTC4gOiC57Or6w=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:39 -0700
IronPort-SDR: nZFUZFyPwJU4oFPtOYeFWT+3BREEaz2xIb3eDXhz/ATdLLRXafl3lJEDAq2pqK0pvClblnY8vZ
 ZgUCREAHyiyg==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 23/63] target/riscv: vector single-width integer multiply-add
 instructions
Date: Fri, 26 Jun 2020 14:43:30 -0700
Message-Id: <20200626214410.3613258-24-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-22-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 33 ++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
 target/riscv/vector_helper.c            | 88 +++++++++++++++++++++++++
 4 files changed, 139 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 60c436616a..a65a38596b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -620,3 +620,36 @@ DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 877d999129..f01cf14777 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -387,6 +387,14 @@ vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
 vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
 vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
 vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
+vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
+vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
+vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
+vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9cd31ba1d8..0f549f7a19 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1599,3 +1599,13 @@ GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
 GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
+
+/* Vector Single-Width Integer Multiply-Add Instructions */
+GEN_OPIVV_TRANS(vmacc_vv, opivv_check)
+GEN_OPIVV_TRANS(vnmsac_vv, opivv_check)
+GEN_OPIVV_TRANS(vmadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vnmsub_vv, opivv_check)
+GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
+GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
+GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
+GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 03ce667c5e..0f3ae3c31a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1891,3 +1891,91 @@ GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
 GEN_VEXT_VX(vwmulsu_vx_b, 1, 2, clearh)
 GEN_VEXT_VX(vwmulsu_vx_h, 2, 4, clearl)
 GEN_VEXT_VX(vwmulsu_vx_w, 4, 8, clearq)
+
+/* Vector Single-Width Integer Multiply-Add Instructions */
+#define OPIVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)       \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d);                           \
+}
+
+#define DO_MACC(N, M, D) (M * N + D)
+#define DO_NMSAC(N, M, D) (-(M * N) + D)
+#define DO_MADD(N, M, D) (M * D + N)
+#define DO_NMSUB(N, M, D) (-(M * D) + N)
+RVVCALL(OPIVV3, vmacc_vv_b, OP_SSS_B, H1, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vmacc_vv_h, OP_SSS_H, H2, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vmacc_vv_w, OP_SSS_W, H4, H4, H4, DO_MACC)
+RVVCALL(OPIVV3, vmacc_vv_d, OP_SSS_D, H8, H8, H8, DO_MACC)
+RVVCALL(OPIVV3, vnmsac_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSAC)
+RVVCALL(OPIVV3, vnmsac_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSAC)
+RVVCALL(OPIVV3, vnmsac_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSAC)
+RVVCALL(OPIVV3, vnmsac_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSAC)
+RVVCALL(OPIVV3, vmadd_vv_b, OP_SSS_B, H1, H1, H1, DO_MADD)
+RVVCALL(OPIVV3, vmadd_vv_h, OP_SSS_H, H2, H2, H2, DO_MADD)
+RVVCALL(OPIVV3, vmadd_vv_w, OP_SSS_W, H4, H4, H4, DO_MADD)
+RVVCALL(OPIVV3, vmadd_vv_d, OP_SSS_D, H8, H8, H8, DO_MADD)
+RVVCALL(OPIVV3, vnmsub_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSUB)
+RVVCALL(OPIVV3, vnmsub_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSUB)
+RVVCALL(OPIVV3, vnmsub_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSUB)
+RVVCALL(OPIVV3, vnmsub_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSUB)
+GEN_VEXT_VV(vmacc_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmacc_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vnmsac_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vnmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vnmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vnmsac_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmadd_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vnmsub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vnmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vnmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vnmsub_vv_d, 8, 8, clearq)
+
+#define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    TD d = *((TD *)vd + HD(i));                                     \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d);                   \
+}
+
+RVVCALL(OPIVX3, vmacc_vx_b, OP_SSS_B, H1, H1, DO_MACC)
+RVVCALL(OPIVX3, vmacc_vx_h, OP_SSS_H, H2, H2, DO_MACC)
+RVVCALL(OPIVX3, vmacc_vx_w, OP_SSS_W, H4, H4, DO_MACC)
+RVVCALL(OPIVX3, vmacc_vx_d, OP_SSS_D, H8, H8, DO_MACC)
+RVVCALL(OPIVX3, vnmsac_vx_b, OP_SSS_B, H1, H1, DO_NMSAC)
+RVVCALL(OPIVX3, vnmsac_vx_h, OP_SSS_H, H2, H2, DO_NMSAC)
+RVVCALL(OPIVX3, vnmsac_vx_w, OP_SSS_W, H4, H4, DO_NMSAC)
+RVVCALL(OPIVX3, vnmsac_vx_d, OP_SSS_D, H8, H8, DO_NMSAC)
+RVVCALL(OPIVX3, vmadd_vx_b, OP_SSS_B, H1, H1, DO_MADD)
+RVVCALL(OPIVX3, vmadd_vx_h, OP_SSS_H, H2, H2, DO_MADD)
+RVVCALL(OPIVX3, vmadd_vx_w, OP_SSS_W, H4, H4, DO_MADD)
+RVVCALL(OPIVX3, vmadd_vx_d, OP_SSS_D, H8, H8, DO_MADD)
+RVVCALL(OPIVX3, vnmsub_vx_b, OP_SSS_B, H1, H1, DO_NMSUB)
+RVVCALL(OPIVX3, vnmsub_vx_h, OP_SSS_H, H2, H2, DO_NMSUB)
+RVVCALL(OPIVX3, vnmsub_vx_w, OP_SSS_W, H4, H4, DO_NMSUB)
+RVVCALL(OPIVX3, vnmsub_vx_d, OP_SSS_D, H8, H8, DO_NMSUB)
+GEN_VEXT_VX(vmacc_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmacc_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmacc_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmacc_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vnmsac_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vnmsac_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vnmsac_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vnmsac_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmadd_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
-- 
2.27.0


