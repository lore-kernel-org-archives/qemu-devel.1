Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44CFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943DE20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B/IHYQJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943DE20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2RE-0006wi-Ql
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AG-0005GJ-4u
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AE-0000AQ-0J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707658; x=1625243658;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sEhGHDkDV029AXlbaYbGCLH5Xh/MUa6wXt0Lw+zTQ8E=;
 b=B/IHYQJinsk7EQ3WI+QYX+HAJ843Dg6d46fXav8rTjizzkgRT6+1SXAa
 wQSN5ZMoE175Q0waaEPhTl9PrYnTk+hIFC++1r+s1gEg2YN4z2ol2bfll
 MYq7Xk+45Fd/DL8f1Hu9mbJj4GHxH3keLg+toVHX2CG+ZHzJoOHhmnXhr
 OKtghhcs/zDRjK8sJ2IH/uDiYPbc1aSqZ8rJzSPDxHI59CaxwzmuOkU0r
 msxjI+TQn4dQKUL/lqxZVQgrAUx2iW6BXZwYznTKHT7SvWPMKMdXwojJ6
 pBhlAE+Xvx49bTIziunmBKh6onJyYPLZcPHyzO+W+/K6BgSil2BCbyulC Q==;
IronPort-SDR: IRIMJJnwnvK1ow6mPItoFrA93LShLIjqhRahf2rdGtwZCfg/JbZkgOKpW8oWL9agWGo2SH3HKF
 8ilpxdP4HhF67RsQzKrmNJwslw1h6CsDesUpJRmIOAfcH1rUEUkFRAzquaJ7RXuidGA168yJBd
 CAgIQrz1EcMoSHBhPQGy8Sw8iYPbmEOD+FXFvTKiJVVcK6T+DteEVnYBfdiv5Hxhz6nhPo3TA0
 mC7g+Napb6D/z1Z9jDaH3OoRzAMXht32ZpGfnEzxlpOdSGDaQtt/URIvkZCd/LHvPtXtUuErkG
 dOo=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498486"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:25 +0800
IronPort-SDR: typiW+1V3s7xkLySbcgMnaCSxu069fdGMO/ZWbsdAIX/UM1yGkMUz6Pjk7zxN9S6R+3Uj7jSlR
 JDCJ5d3OOTH9mJb9jw6bzj9t0DKS/XJn0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:40 -0700
IronPort-SDR: qi2hxNWnyw3AlEOSMzGJDynTil6FssqIqaC7pNnfPfCvpSLlIAIj6M+uKXjuMvYKqd0er37TeG
 lqlVPewXqVPg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 23/64] target/riscv: vector widening integer multiply
 instructions
Date: Thu,  2 Jul 2020 09:23:13 -0700
Message-Id: <20200702162354.928528-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
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
Message-Id: <20200701152549.1218-21-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 19 +++++++++
 target/riscv/insn32.decode              |  6 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  8 ++++
 target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e14979e452..60c436616a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -601,3 +601,22 @@ DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vwmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cf58764308..877d999129 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -381,6 +381,12 @@ vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
 vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
 vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
 vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
+vwmulu_vv       111000 . ..... ..... 010 ..... 1010111 @r_vm
+vwmulu_vx       111000 . ..... ..... 110 ..... 1010111 @r_vm
+vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
+vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
+vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
+vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index f3a8baf581..9cd31ba1d8 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1591,3 +1591,11 @@ GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
 GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
 GEN_OPIVX_TRANS(vremu_vx, opivx_check)
 GEN_OPIVX_TRANS(vrem_vx, opivx_check)
+
+/* Vector Widening Integer Multiply Instructions */
+GEN_OPIVV_WIDEN_TRANS(vwmul_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmulu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1a90f6e967..f27543914f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -863,6 +863,18 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 #define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
 #define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
 #define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
+#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
+#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
+#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
+#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
+#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
+#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
+#define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
+#define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
+#define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
+#define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
+#define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
+#define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
 
 /* operation of two vector elements */
 typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
@@ -1840,3 +1852,42 @@ GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
+
+/* Vector Widening Integer Multiply Instructions */
+RVVCALL(OPIVV2, vwmul_vv_b, WOP_SSS_B, H2, H1, H1, DO_MUL)
+RVVCALL(OPIVV2, vwmul_vv_h, WOP_SSS_H, H4, H2, H2, DO_MUL)
+RVVCALL(OPIVV2, vwmul_vv_w, WOP_SSS_W, H8, H4, H4, DO_MUL)
+RVVCALL(OPIVV2, vwmulu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MUL)
+RVVCALL(OPIVV2, vwmulu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MUL)
+RVVCALL(OPIVV2, vwmulu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MUL)
+RVVCALL(OPIVV2, vwmulsu_vv_b, WOP_SUS_B, H2, H1, H1, DO_MUL)
+RVVCALL(OPIVV2, vwmulsu_vv_h, WOP_SUS_H, H4, H2, H2, DO_MUL)
+RVVCALL(OPIVV2, vwmulsu_vv_w, WOP_SUS_W, H8, H4, H4, DO_MUL)
+GEN_VEXT_VV(vwmul_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmul_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmul_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmulu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmulu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmulu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmulsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmulsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmulsu_vv_w, 4, 8, clearq)
+
+RVVCALL(OPIVX2, vwmul_vx_b, WOP_SSS_B, H2, H1, DO_MUL)
+RVVCALL(OPIVX2, vwmul_vx_h, WOP_SSS_H, H4, H2, DO_MUL)
+RVVCALL(OPIVX2, vwmul_vx_w, WOP_SSS_W, H8, H4, DO_MUL)
+RVVCALL(OPIVX2, vwmulu_vx_b, WOP_UUU_B, H2, H1, DO_MUL)
+RVVCALL(OPIVX2, vwmulu_vx_h, WOP_UUU_H, H4, H2, DO_MUL)
+RVVCALL(OPIVX2, vwmulu_vx_w, WOP_UUU_W, H8, H4, DO_MUL)
+RVVCALL(OPIVX2, vwmulsu_vx_b, WOP_SUS_B, H2, H1, DO_MUL)
+RVVCALL(OPIVX2, vwmulsu_vx_h, WOP_SUS_H, H4, H2, DO_MUL)
+RVVCALL(OPIVX2, vwmulsu_vx_w, WOP_SUS_W, H8, H4, DO_MUL)
+GEN_VEXT_VX(vwmul_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmul_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmul_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmulu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmulu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmulsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmulsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmulsu_vx_w, 4, 8, clearq)
-- 
2.27.0


