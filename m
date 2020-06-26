Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CB4208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W6EON/Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CB4208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowTq-0005Pm-B2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowID-00039N-Uw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIA-0002zW-Gv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208430; x=1624744430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ypkTsOGvTQFgqFgmJpeG3QzF77HEDPaMws0x4eme6tM=;
 b=W6EON/CdjSOUklDrl6G4fNz7JtCRBuXNbmjaz1Y5GfghtPHEEYwTt1s1
 ZkBoGoskA+i3Lhpk2KqQn0CdVoJNuFE8NJAviKuHOoOkEZPmnphqV4JEH
 BfHvEhxUJfbCPf5e/0WQUSd7Ih7QQOD8v2FNndvbJ3yjy7ymJvb7bHYCK
 YH3LKxyklY9n4t5qMT+qHmaGBrzjtfsZfvPjAAHLf7Pws5C0fxQ22cK6o
 wISay0WgMTGH5tlN1PAkDzCHjyLJow3NzjEDzv1CX6zb2aJovBfawwka3
 AIMKvg8CPwN91atmiXYIZ/oRYVnOYwSJ0zGvzVn9mPTw5h6F0ejZB1iwX A==;
IronPort-SDR: EfpSMFM2TOxbRBao++BXYdapeEAqsaQeFOoMqPMpYrXMSjbPllsPhx9p2R9+k/niJYhYF0bQOL
 WiUazgKN1XvFtwELwVP4KVi8GCHMpUt+UjA6gqi3FAIVFjgzsghs1C98LKbJ/hq+A102wdcCWe
 YYVEsrCvN+wszMg1uYfWZbhu55lU7wWE2I7OwEympb2vzivF956SFA0ST3Sv1b8GYL+9Iwzy+8
 81CW5sHYqO4FwaPxacre8nuRcKdJfQk1NY77yqe5lIvGgAq1aX6fOK5tvoQs1OeE4miJZoAogT
 CZo=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261258"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:40 +0800
IronPort-SDR: mxidMkNNAN9rbkfKG243V2bOVyrYsCJBXOemn8uMJAFmNMpILCqFdV23xt3dKbe8Kgi5Jlg1xH
 xLn6iVsrFXAhxKBYY1fMIgJ1CDkb3d71c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:38 -0700
IronPort-SDR: Ul41lU7QZX7kyo+eF0QSwJUiRO5Gi2scwx2K+XD8+3pgePOHYNlVXEni02cl1uvqk0hqVzrbaP
 te+0/v+UlJ5Q==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 20/63] target/riscv: vector single-width integer multiply
 instructions
Date: Fri, 26 Jun 2020 14:43:27 -0700
Message-Id: <20200626214410.3613258-21-alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-19-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  33 +++++
 target/riscv/insn32.decode              |   8 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  10 ++
 target/riscv/vector_helper.c            | 163 ++++++++++++++++++++++++
 4 files changed, 214 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 9c576e1220..c2de0d29ba 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -535,3 +535,36 @@ DEF_HELPER_6(vmax_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmax_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmax_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmax_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 3d8986c74d..6b29aad4d2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -365,6 +365,14 @@ vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
 vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
 vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
 vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
+vmul_vv         100101 . ..... ..... 010 ..... 1010111 @r_vm
+vmul_vx         100101 . ..... ..... 110 ..... 1010111 @r_vm
+vmulh_vv        100111 . ..... ..... 010 ..... 1010111 @r_vm
+vmulh_vx        100111 . ..... ..... 110 ..... 1010111 @r_vm
+vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
+vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
+vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
+vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 861fd3bf1a..b5ea1c59a1 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1571,3 +1571,13 @@ GEN_OPIVX_TRANS(vminu_vx, opivx_check)
 GEN_OPIVX_TRANS(vmin_vx,  opivx_check)
 GEN_OPIVX_TRANS(vmaxu_vx, opivx_check)
 GEN_OPIVX_TRANS(vmax_vx,  opivx_check)
+
+/* Vector Single-Width Integer Multiply Instructions */
+GEN_OPIVV_GVEC_TRANS(vmul_vv,  mul)
+GEN_OPIVV_TRANS(vmulh_vv, opivv_check)
+GEN_OPIVV_TRANS(vmulhu_vv, opivv_check)
+GEN_OPIVV_TRANS(vmulhsu_vv, opivv_check)
+GEN_OPIVX_GVEC_TRANS(vmul_vx,  muls)
+GEN_OPIVX_TRANS(vmulh_vx, opivx_check)
+GEN_OPIVX_TRANS(vmulhu_vx, opivx_check)
+GEN_OPIVX_TRANS(vmulhsu_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cb41daa3ac..ce4aae8753 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -859,6 +859,10 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 #define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
 #define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
 #define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
+#define OP_SUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
+#define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
+#define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
+#define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
 
 /* operation of two vector elements */
 typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
@@ -1603,3 +1607,162 @@ GEN_VEXT_VX(vmax_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vmax_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vmax_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vmax_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Integer Multiply Instructions */
+#define DO_MUL(N, M) (N * M)
+RVVCALL(OPIVV2, vmul_vv_b, OP_SSS_B, H1, H1, H1, DO_MUL)
+RVVCALL(OPIVV2, vmul_vv_h, OP_SSS_H, H2, H2, H2, DO_MUL)
+RVVCALL(OPIVV2, vmul_vv_w, OP_SSS_W, H4, H4, H4, DO_MUL)
+RVVCALL(OPIVV2, vmul_vv_d, OP_SSS_D, H8, H8, H8, DO_MUL)
+GEN_VEXT_VV(vmul_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmul_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmul_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmul_vv_d, 8, 8, clearq)
+
+static int8_t do_mulh_b(int8_t s2, int8_t s1)
+{
+    return (int16_t)s2 * (int16_t)s1 >> 8;
+}
+
+static int16_t do_mulh_h(int16_t s2, int16_t s1)
+{
+    return (int32_t)s2 * (int32_t)s1 >> 16;
+}
+
+static int32_t do_mulh_w(int32_t s2, int32_t s1)
+{
+    return (int64_t)s2 * (int64_t)s1 >> 32;
+}
+
+static int64_t do_mulh_d(int64_t s2, int64_t s1)
+{
+    uint64_t hi_64, lo_64;
+
+    muls64(&lo_64, &hi_64, s1, s2);
+    return hi_64;
+}
+
+static uint8_t do_mulhu_b(uint8_t s2, uint8_t s1)
+{
+    return (uint16_t)s2 * (uint16_t)s1 >> 8;
+}
+
+static uint16_t do_mulhu_h(uint16_t s2, uint16_t s1)
+{
+    return (uint32_t)s2 * (uint32_t)s1 >> 16;
+}
+
+static uint32_t do_mulhu_w(uint32_t s2, uint32_t s1)
+{
+    return (uint64_t)s2 * (uint64_t)s1 >> 32;
+}
+
+static uint64_t do_mulhu_d(uint64_t s2, uint64_t s1)
+{
+    uint64_t hi_64, lo_64;
+
+    mulu64(&lo_64, &hi_64, s2, s1);
+    return hi_64;
+}
+
+static int8_t do_mulhsu_b(int8_t s2, uint8_t s1)
+{
+    return (int16_t)s2 * (uint16_t)s1 >> 8;
+}
+
+static int16_t do_mulhsu_h(int16_t s2, uint16_t s1)
+{
+    return (int32_t)s2 * (uint32_t)s1 >> 16;
+}
+
+static int32_t do_mulhsu_w(int32_t s2, uint32_t s1)
+{
+    return (int64_t)s2 * (uint64_t)s1 >> 32;
+}
+
+/*
+ * Let  A = signed operand,
+ *      B = unsigned operand
+ *      P = mulu64(A, B), unsigned product
+ *
+ * LET  X = 2 ** 64  - A, 2's complement of A
+ *      SP = signed product
+ * THEN
+ *      IF A < 0
+ *          SP = -X * B
+ *             = -(2 ** 64 - A) * B
+ *             = A * B - 2 ** 64 * B
+ *             = P - 2 ** 64 * B
+ *      ELSE
+ *          SP = P
+ * THEN
+ *      HI_P -= (A < 0 ? B : 0)
+ */
+
+static int64_t do_mulhsu_d(int64_t s2, uint64_t s1)
+{
+    uint64_t hi_64, lo_64;
+
+    mulu64(&lo_64, &hi_64, s2, s1);
+
+    hi_64 -= s2 < 0 ? s1 : 0;
+    return hi_64;
+}
+
+RVVCALL(OPIVV2, vmulh_vv_b, OP_SSS_B, H1, H1, H1, do_mulh_b)
+RVVCALL(OPIVV2, vmulh_vv_h, OP_SSS_H, H2, H2, H2, do_mulh_h)
+RVVCALL(OPIVV2, vmulh_vv_w, OP_SSS_W, H4, H4, H4, do_mulh_w)
+RVVCALL(OPIVV2, vmulh_vv_d, OP_SSS_D, H8, H8, H8, do_mulh_d)
+RVVCALL(OPIVV2, vmulhu_vv_b, OP_UUU_B, H1, H1, H1, do_mulhu_b)
+RVVCALL(OPIVV2, vmulhu_vv_h, OP_UUU_H, H2, H2, H2, do_mulhu_h)
+RVVCALL(OPIVV2, vmulhu_vv_w, OP_UUU_W, H4, H4, H4, do_mulhu_w)
+RVVCALL(OPIVV2, vmulhu_vv_d, OP_UUU_D, H8, H8, H8, do_mulhu_d)
+RVVCALL(OPIVV2, vmulhsu_vv_b, OP_SUS_B, H1, H1, H1, do_mulhsu_b)
+RVVCALL(OPIVV2, vmulhsu_vv_h, OP_SUS_H, H2, H2, H2, do_mulhsu_h)
+RVVCALL(OPIVV2, vmulhsu_vv_w, OP_SUS_W, H4, H4, H4, do_mulhsu_w)
+RVVCALL(OPIVV2, vmulhsu_vv_d, OP_SUS_D, H8, H8, H8, do_mulhsu_d)
+GEN_VEXT_VV(vmulh_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmulh_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmulh_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmulh_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmulhu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmulhu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmulhu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmulhu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmulhsu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmulhsu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmulhsu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmulhsu_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vmul_vx_b, OP_SSS_B, H1, H1, DO_MUL)
+RVVCALL(OPIVX2, vmul_vx_h, OP_SSS_H, H2, H2, DO_MUL)
+RVVCALL(OPIVX2, vmul_vx_w, OP_SSS_W, H4, H4, DO_MUL)
+RVVCALL(OPIVX2, vmul_vx_d, OP_SSS_D, H8, H8, DO_MUL)
+RVVCALL(OPIVX2, vmulh_vx_b, OP_SSS_B, H1, H1, do_mulh_b)
+RVVCALL(OPIVX2, vmulh_vx_h, OP_SSS_H, H2, H2, do_mulh_h)
+RVVCALL(OPIVX2, vmulh_vx_w, OP_SSS_W, H4, H4, do_mulh_w)
+RVVCALL(OPIVX2, vmulh_vx_d, OP_SSS_D, H8, H8, do_mulh_d)
+RVVCALL(OPIVX2, vmulhu_vx_b, OP_UUU_B, H1, H1, do_mulhu_b)
+RVVCALL(OPIVX2, vmulhu_vx_h, OP_UUU_H, H2, H2, do_mulhu_h)
+RVVCALL(OPIVX2, vmulhu_vx_w, OP_UUU_W, H4, H4, do_mulhu_w)
+RVVCALL(OPIVX2, vmulhu_vx_d, OP_UUU_D, H8, H8, do_mulhu_d)
+RVVCALL(OPIVX2, vmulhsu_vx_b, OP_SUS_B, H1, H1, do_mulhsu_b)
+RVVCALL(OPIVX2, vmulhsu_vx_h, OP_SUS_H, H2, H2, do_mulhsu_h)
+RVVCALL(OPIVX2, vmulhsu_vx_w, OP_SUS_W, H4, H4, do_mulhsu_w)
+RVVCALL(OPIVX2, vmulhsu_vx_d, OP_SUS_D, H8, H8, do_mulhsu_d)
+GEN_VEXT_VX(vmul_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmul_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmul_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmul_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmulh_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmulh_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmulh_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmulh_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmulhu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmulhu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmulhu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmulhu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmulhsu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmulhsu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmulhsu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmulhsu_vx_d, 8, 8, clearq)
-- 
2.27.0


