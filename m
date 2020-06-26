Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F73C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7892089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nF5uDrvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7892089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowS0-0001v4-OW
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI9-0002zW-P6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI6-00030Y-1b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208427; x=1624744427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C1qKTCKJcCY5Q7ovLUR1GlsfNuM3cb2zWgcXN2kfEt8=;
 b=nF5uDrvJVsHls893yv+kRheCXnOEQh+CRgAatI4VCujSiaM35MqY6vCI
 UU13dUD9NAomYZdIdOEcpYUcWDw31IJw/hqIM6f08e6ZaChpyXjwuWXTQ
 oWHD+UsBZxIYZ07j9AYcgcLbmTp65qnq3fT6RTWcjylWjgHQ2t+PHcYuI
 pTJgqU/duFBtUKefjsK+8dBN96vwYLdxJgVSRbfD1c3q8WRoqKBEXALpT
 tTqR7Ya1sOEUaPEPBDrLeq+dL0ReaLpJLxiwMEMqQ9A1hHFi+iCqUBmLz
 LiGgeOtI8FU02KpZFeXYBZjPrgD0VRsKUVLAvTaSbu3bpfK2018Kauqtr g==;
IronPort-SDR: 9rTOptvXR9gcKVcrmc1l2usiJ+Lv/IIqjGVq+dkxcPr01dgRseIWkKcpqxI1vVtxZ90u5Iw+C1
 LJ1thuDntAeOzTb5jASmwAoS5IqVMqshjEcM1BOopkj491SLo6lOe16Bj3q23LjMhflmetDYsA
 o1qmu6iuZXl0mStBiNeSBnwFeujjmR7H7dx5ZSuYEXa6XZrK8lOVfxzYGAmptfJu8i9CxAspKk
 iZBBLeInLTEnJZe3l2ssLY93MFU5WeFPHv30hUkq2Omayepziq9AJbLlFLZo78s1icgEhJoaTZ
 iIw=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048389"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:45 +0800
IronPort-SDR: G+jHbwvzAE8R3TxkguBT2jmxJuUwbvzFvVT2wxCis0AN8h/iqCLC68JfS3tw07Nq/hmgoBAWvb
 HNqaLIZjbBu5ANKoCWTcV24zZ1qNRjE70=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:42 -0700
IronPort-SDR: b3XiOrbv/XsMYoQn0qW4c+YuQiFZzsAbsQTz7ZKo0LTrvilBWOPFbCb0CAJKacB9nsMpgPzE0n
 4MVL097Jl+KA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 34/63] target/riscv: vector single-width floating-point
 multiply/divide instructions
Date: Fri, 26 Jun 2020 14:43:41 -0700
Message-Id: <20200626214410.3613258-35-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-33-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 16 ++++++++
 target/riscv/insn32.decode              |  5 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  7 ++++
 target/riscv/vector_helper.c            | 49 +++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 828b145150..94305bd870 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -836,3 +836,19 @@ DEF_HELPER_6(vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmul_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 42d8a967d0..5db02f0c0a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -458,6 +458,11 @@ vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
 vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
 vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
 vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
+vfmul_vv        100100 . ..... ..... 001 ..... 1010111 @r_vm
+vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
+vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
+vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
+vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0224b66962..be9a9a8295 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2050,3 +2050,10 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
 
 GEN_OPFWF_WIDEN_TRANS(vfwadd_wf)
 GEN_OPFWF_WIDEN_TRANS(vfwsub_wf)
+
+/* Vector Single-Width Floating-Point Multiply/Divide Instructions */
+GEN_OPFVV_TRANS(vfmul_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfdiv_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfmul_vf,  opfvf_check)
+GEN_OPFVF_TRANS(vfdiv_vf,  opfvf_check)
+GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 85d1f08bd0..8538a63419 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3361,3 +3361,52 @@ RVVCALL(OPFVF2, vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
 RVVCALL(OPFVF2, vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
 GEN_VEXT_VF(vfwsub_wf_h, 2, 4, clearl)
 GEN_VEXT_VF(vfwsub_wf_w, 4, 8, clearq)
+
+/* Vector Single-Width Floating-Point Multiply/Divide Instructions */
+RVVCALL(OPFVV2, vfmul_vv_h, OP_UUU_H, H2, H2, H2, float16_mul)
+RVVCALL(OPFVV2, vfmul_vv_w, OP_UUU_W, H4, H4, H4, float32_mul)
+RVVCALL(OPFVV2, vfmul_vv_d, OP_UUU_D, H8, H8, H8, float64_mul)
+GEN_VEXT_VV_ENV(vfmul_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmul_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmul_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmul_vf_h, OP_UUU_H, H2, H2, float16_mul)
+RVVCALL(OPFVF2, vfmul_vf_w, OP_UUU_W, H4, H4, float32_mul)
+RVVCALL(OPFVF2, vfmul_vf_d, OP_UUU_D, H8, H8, float64_mul)
+GEN_VEXT_VF(vfmul_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmul_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmul_vf_d, 8, 8, clearq)
+
+RVVCALL(OPFVV2, vfdiv_vv_h, OP_UUU_H, H2, H2, H2, float16_div)
+RVVCALL(OPFVV2, vfdiv_vv_w, OP_UUU_W, H4, H4, H4, float32_div)
+RVVCALL(OPFVV2, vfdiv_vv_d, OP_UUU_D, H8, H8, H8, float64_div)
+GEN_VEXT_VV_ENV(vfdiv_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfdiv_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfdiv_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfdiv_vf_h, OP_UUU_H, H2, H2, float16_div)
+RVVCALL(OPFVF2, vfdiv_vf_w, OP_UUU_W, H4, H4, float32_div)
+RVVCALL(OPFVF2, vfdiv_vf_d, OP_UUU_D, H8, H8, float64_div)
+GEN_VEXT_VF(vfdiv_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfdiv_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfdiv_vf_d, 8, 8, clearq)
+
+static uint16_t float16_rdiv(uint16_t a, uint16_t b, float_status *s)
+{
+    return float16_div(b, a, s);
+}
+
+static uint32_t float32_rdiv(uint32_t a, uint32_t b, float_status *s)
+{
+    return float32_div(b, a, s);
+}
+
+static uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s)
+{
+    return float64_div(b, a, s);
+}
+
+RVVCALL(OPFVF2, vfrdiv_vf_h, OP_UUU_H, H2, H2, float16_rdiv)
+RVVCALL(OPFVF2, vfrdiv_vf_w, OP_UUU_W, H4, H4, float32_rdiv)
+RVVCALL(OPFVF2, vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
+GEN_VEXT_VF(vfrdiv_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfrdiv_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfrdiv_vf_d, 8, 8, clearq)
-- 
2.27.0


