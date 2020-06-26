Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2B420B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nFgt02fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2B420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowO2-0004cZ-QU
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIC-00036k-HD
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI7-00031d-PC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208430; x=1624744430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tbklPidyoag+526OikMJvjaCDv2Vc7WfWRAIVv9bwqo=;
 b=nFgt02fqPT6hlf4+A4dLkX2VxgEH52cB5/6hgPQVrn0EUZ5mZEz/KNAS
 Ww3nsqnqWbjR4ebS+GgeeKmo7OyYvUw0joHb7QUOqnhnaE7HM4UzyBSqe
 33T6FKA66p7x/eGU7u9RLwfvopOMpyE9WuHuDV9ZeKtYjUa7p2PUURHWH
 tO7V+d5DV1ytES81yEI6TbglHgAuZB8tcpDCatPXj1ulxM5ElTCil+YFT
 AcHCaaYQGXbtw7rYjGu7dycqBCVQoh4BAmCsaNTMEZ70IfkcG4T2obgF6
 pmqOP4460pbOGFXETtvUEhtVU1E27QfVkCDaHyAFr1n+SRccCzuDqeKbz Q==;
IronPort-SDR: e4304jJQDV9YGX3pRrMeroyO2D3ujIFEMxiTuUoghtnG9HsZ8XojanRxJA34Rc3WH7Vi0eKMzI
 qJ6323sI/pZcdAreUxVZhfk2HYFJqo3jGW1lPzCjUEOofaJxhU5rJ+83w1PCULhwe83Rl6wnKb
 w63woE2Xk3MFe8gmhstWGifx8fGnmE4wLgVaJKGuWe4wKLpbJQF924ZZwUwvmT6esjywHXzK92
 Pjt5Sf5MXNsnpkP6eWMrnzrw7ebUiL9yMSwGLqTp1ZQLUg1KbMH2qDpptHue9K/ixylm/6Pm0v
 BPk=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048392"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:46 +0800
IronPort-SDR: ZZxKm8i+1gREAm+5P/rIBCo5HHsfuJfvpxkTUrIqh6Z/WYDiz4wRht1kYrDQDfgxDqyb5er6bR
 0mb37usUkyTYEq6sMvJ+MfxL8BS1zvCQ0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:43 -0700
IronPort-SDR: tTscqipsB4dAGr0fwHXlHgDNh5KAOSudDI+MzwDSjZrh3Ya0LSrC3PUZIYLyFBjcztOGMhydP4
 W3jXJyy2InRQ==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 36/63] target/riscv: vector single-width floating-point fused
 multiply-add instructions
Date: Fri, 26 Jun 2020 14:43:43 -0700
Message-Id: <20200626214410.3613258-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:44
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
Message-id: 20200623215920.2594-35-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  49 +++++
 target/riscv/insn32.decode              |  16 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  18 ++
 target/riscv/vector_helper.c            | 251 ++++++++++++++++++++++++
 4 files changed, 334 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 9d7dcfeef9..108a177f25 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -857,3 +857,52 @@ DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index dd9bca7eeb..9ca765d37f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -465,6 +465,22 @@ vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
 vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
 vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
+vfmacc_vv       101100 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmacc_vv      101101 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmacc_vf      101101 . ..... ..... 101 ..... 1010111 @r_vm
+vfmacc_vf       101100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmsac_vv       101110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmsac_vf       101110 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmsac_vv      101111 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmsac_vf      101111 . ..... ..... 101 ..... 1010111 @r_vm
+vfmadd_vv       101000 . ..... ..... 001 ..... 1010111 @r_vm
+vfmadd_vf       101000 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmadd_vv      101001 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmadd_vf      101001 . ..... ..... 101 ..... 1010111 @r_vm
+vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
+vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3ce7815f5d..ee601fd790 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2061,3 +2061,21 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 /* Vector Widening Floating-Point Multiply */
 GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
 GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
+
+/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
+GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmacc_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmsac_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmsac_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmadd_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmadd_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmsub_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmsub_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfmacc_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmacc_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmsac_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmsac_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmadd_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmadd_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6441d0ee08..1173964efd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3432,3 +3432,254 @@ RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
 RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
 GEN_VEXT_VF(vfwmul_vf_h, 2, 4, clearl)
 GEN_VEXT_VF(vfwmul_vf_w, 4, 8, clearq)
+
+/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
+#define OPFVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)       \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
+        CPURISCVState *env)                                        \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d, &env->fp_status);          \
+}
+
+static uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d, 0, s);
+}
+
+static uint32_t fmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d, 0, s);
+}
+
+static uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d, 0, s);
+}
+
+RVVCALL(OPFVV3, vfmacc_vv_h, OP_UUU_H, H2, H2, H2, fmacc16)
+RVVCALL(OPFVV3, vfmacc_vv_w, OP_UUU_W, H4, H4, H4, fmacc32)
+RVVCALL(OPFVV3, vfmacc_vv_d, OP_UUU_D, H8, H8, H8, fmacc64)
+GEN_VEXT_VV_ENV(vfmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmacc_vv_d, 8, 8, clearq)
+
+#define OPFVF3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)           \
+static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i,    \
+        CPURISCVState *env)                                       \
+{                                                                 \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                               \
+    TD d = *((TD *)vd + HD(i));                                   \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d, &env->fp_status);\
+}
+
+RVVCALL(OPFVF3, vfmacc_vf_h, OP_UUU_H, H2, H2, fmacc16)
+RVVCALL(OPFVF3, vfmacc_vf_w, OP_UUU_W, H4, H4, fmacc32)
+RVVCALL(OPFVF3, vfmacc_vf_d, OP_UUU_D, H8, H8, fmacc64)
+GEN_VEXT_VF(vfmacc_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmacc_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmacc_vf_d, 8, 8, clearq)
+
+static uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+static uint32_t fnmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+static uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfnmacc_vv_h, OP_UUU_H, H2, H2, H2, fnmacc16)
+RVVCALL(OPFVV3, vfnmacc_vv_w, OP_UUU_W, H4, H4, H4, fnmacc32)
+RVVCALL(OPFVV3, vfnmacc_vv_d, OP_UUU_D, H8, H8, H8, fnmacc64)
+GEN_VEXT_VV_ENV(vfnmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmacc_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmacc_vf_h, OP_UUU_H, H2, H2, fnmacc16)
+RVVCALL(OPFVF3, vfnmacc_vf_w, OP_UUU_W, H4, H4, fnmacc32)
+RVVCALL(OPFVF3, vfnmacc_vf_d, OP_UUU_D, H8, H8, fnmacc64)
+GEN_VEXT_VF(vfnmacc_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmacc_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmacc_vf_d, 8, 8, clearq)
+
+static uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d, float_muladd_negate_c, s);
+}
+
+static uint32_t fmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d, float_muladd_negate_c, s);
+}
+
+static uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d, float_muladd_negate_c, s);
+}
+
+RVVCALL(OPFVV3, vfmsac_vv_h, OP_UUU_H, H2, H2, H2, fmsac16)
+RVVCALL(OPFVV3, vfmsac_vv_w, OP_UUU_W, H4, H4, H4, fmsac32)
+RVVCALL(OPFVV3, vfmsac_vv_d, OP_UUU_D, H8, H8, H8, fmsac64)
+GEN_VEXT_VV_ENV(vfmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmsac_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfmsac_vf_h, OP_UUU_H, H2, H2, fmsac16)
+RVVCALL(OPFVF3, vfmsac_vf_w, OP_UUU_W, H4, H4, fmsac32)
+RVVCALL(OPFVF3, vfmsac_vf_d, OP_UUU_D, H8, H8, fmsac64)
+GEN_VEXT_VF(vfmsac_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmsac_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmsac_vf_d, 8, 8, clearq)
+
+static uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d, float_muladd_negate_product, s);
+}
+
+static uint32_t fnmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d, float_muladd_negate_product, s);
+}
+
+static uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d, float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfnmsac_vv_h, OP_UUU_H, H2, H2, H2, fnmsac16)
+RVVCALL(OPFVV3, vfnmsac_vv_w, OP_UUU_W, H4, H4, H4, fnmsac32)
+RVVCALL(OPFVV3, vfnmsac_vv_d, OP_UUU_D, H8, H8, H8, fnmsac64)
+GEN_VEXT_VV_ENV(vfnmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmsac_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmsac_vf_h, OP_UUU_H, H2, H2, fnmsac16)
+RVVCALL(OPFVF3, vfnmsac_vf_w, OP_UUU_W, H4, H4, fnmsac32)
+RVVCALL(OPFVF3, vfnmsac_vf_d, OP_UUU_D, H8, H8, fnmsac64)
+GEN_VEXT_VF(vfnmsac_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmsac_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmsac_vf_d, 8, 8, clearq)
+
+static uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a, 0, s);
+}
+
+static uint32_t fmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a, 0, s);
+}
+
+static uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a, 0, s);
+}
+
+RVVCALL(OPFVV3, vfmadd_vv_h, OP_UUU_H, H2, H2, H2, fmadd16)
+RVVCALL(OPFVV3, vfmadd_vv_w, OP_UUU_W, H4, H4, H4, fmadd32)
+RVVCALL(OPFVV3, vfmadd_vv_d, OP_UUU_D, H8, H8, H8, fmadd64)
+GEN_VEXT_VV_ENV(vfmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmadd_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfmadd_vf_h, OP_UUU_H, H2, H2, fmadd16)
+RVVCALL(OPFVF3, vfmadd_vf_w, OP_UUU_W, H4, H4, fmadd32)
+RVVCALL(OPFVF3, vfmadd_vf_d, OP_UUU_D, H8, H8, fmadd64)
+GEN_VEXT_VF(vfmadd_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmadd_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmadd_vf_d, 8, 8, clearq)
+
+static uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+static uint32_t fnmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+static uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfnmadd_vv_h, OP_UUU_H, H2, H2, H2, fnmadd16)
+RVVCALL(OPFVV3, vfnmadd_vv_w, OP_UUU_W, H4, H4, H4, fnmadd32)
+RVVCALL(OPFVV3, vfnmadd_vv_d, OP_UUU_D, H8, H8, H8, fnmadd64)
+GEN_VEXT_VV_ENV(vfnmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmadd_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmadd_vf_h, OP_UUU_H, H2, H2, fnmadd16)
+RVVCALL(OPFVF3, vfnmadd_vf_w, OP_UUU_W, H4, H4, fnmadd32)
+RVVCALL(OPFVF3, vfnmadd_vf_d, OP_UUU_D, H8, H8, fnmadd64)
+GEN_VEXT_VF(vfnmadd_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmadd_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmadd_vf_d, 8, 8, clearq)
+
+static uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a, float_muladd_negate_c, s);
+}
+
+static uint32_t fmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a, float_muladd_negate_c, s);
+}
+
+static uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a, float_muladd_negate_c, s);
+}
+
+RVVCALL(OPFVV3, vfmsub_vv_h, OP_UUU_H, H2, H2, H2, fmsub16)
+RVVCALL(OPFVV3, vfmsub_vv_w, OP_UUU_W, H4, H4, H4, fmsub32)
+RVVCALL(OPFVV3, vfmsub_vv_d, OP_UUU_D, H8, H8, H8, fmsub64)
+GEN_VEXT_VV_ENV(vfmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmsub_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfmsub_vf_h, OP_UUU_H, H2, H2, fmsub16)
+RVVCALL(OPFVF3, vfmsub_vf_w, OP_UUU_W, H4, H4, fmsub32)
+RVVCALL(OPFVF3, vfmsub_vf_d, OP_UUU_D, H8, H8, fmsub64)
+GEN_VEXT_VF(vfmsub_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmsub_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmsub_vf_d, 8, 8, clearq)
+
+static uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a, float_muladd_negate_product, s);
+}
+
+static uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a, float_muladd_negate_product, s);
+}
+
+static uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a, float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfnmsub_vv_h, OP_UUU_H, H2, H2, H2, fnmsub16)
+RVVCALL(OPFVV3, vfnmsub_vv_w, OP_UUU_W, H4, H4, H4, fnmsub32)
+RVVCALL(OPFVV3, vfnmsub_vv_d, OP_UUU_D, H8, H8, H8, fnmsub64)
+GEN_VEXT_VV_ENV(vfnmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmsub_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmsub_vf_h, OP_UUU_H, H2, H2, fnmsub16)
+RVVCALL(OPFVF3, vfnmsub_vf_w, OP_UUU_W, H4, H4, fnmsub32)
+RVVCALL(OPFVF3, vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
+GEN_VEXT_VF(vfnmsub_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmsub_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmsub_vf_d, 8, 8, clearq)
-- 
2.27.0


