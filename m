Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E0DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FA02089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PzpCwsuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FA02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowSg-0003JL-Bu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIP-0003Am-6M
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIB-00033f-Uv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208432; x=1624744432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AzvAT9ElWDL+ZcbGufGZK7eud0rImPPR6i3RsBIuuHI=;
 b=PzpCwsuHnFu9/1rxCj+H6xaaceJhfQYgh7wMnEdZJF268lbhenYKYoqP
 ibsDsmBolCPToumwmayU6W1hF2QK4NwsT4qJYTl95QRCeKkjEhDKxhL7L
 oFPyMcsuZz5kZRBfN1kRlp2ObRM1CE3/IfBg1JXI5n0vkdsU6lrnKCM0p
 PdcKlGgdW4UJrha6HYu1Z/Ugc/SQT83M1X9WnZbjKf190jj6KDyaF8ce5
 VOKgmaz9A3pmSgF+SpvQjkPvDeV5l2pdEc3IpJBaGcu/cd9JO5uBCfsrC
 u+fQEuirVgpUPn7dE7+vBPcO/TkIS1oUtmKlgObaiP5gSCiSBOPO/7UeH g==;
IronPort-SDR: cgVM7ou7LI7VzD3YatHH8I48NA+EFp5+fwu/Ay5T956Z+pwSHI1W5pkYZ0du7hjNgYc/KfUSpb
 eINoQWG8N+UB6Y94y/fDqZivkT6vd12jclqZ+qkHRdju05abr72hUBe4JS/K1WyPBGAXiIgG8/
 JpU/HxwfhwO0B9AITr/6XCalZttAKUZavuqmX7ZP70Hhgb4BOK7Fhe6Fs9+WUz6bIyvUxWYgP4
 xnEUtFLfWH8mH5zQGCcRqsIdcpRJBmlMAVP5nlcSS3DkCBPa7m2EUmSQxterk9q7pigmoPJZl3
 /Zk=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048395"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:46 +0800
IronPort-SDR: wxczb6avOEvK2PaYLg2DXyktHcjhP5Wysi3TbJUyIMfNjieLcoVRLrIW/mhUdYVsEdGaDTjJHO
 C0RV6mzedft7mXyJsBPmxOxTkxZLXY9+g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:44 -0700
IronPort-SDR: n4di0IKFEnS2S2uepXiR4C8xJTBT2EQuGX01EAwqbm8ihmiMJXNf7i/5lFN0TwImL7fSd5jKRk
 q8IJ5G6GYLTA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 39/63] target/riscv: vector floating-point min/max instructions
Date: Fri, 26 Jun 2020 14:43:46 -0700
Message-Id: <20200626214410.3613258-40-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-38-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 13 ++++++++++++
 target/riscv/insn32.decode              |  4 ++++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 ++++++
 target/riscv/vector_helper.c            | 27 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8d44154ad2..a080f8358a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -927,3 +927,16 @@ DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0d58c4c5e8..854ff9a38f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -492,6 +492,10 @@ vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
 vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
 vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
+vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
+vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index e875c0e48a..b40e8eec53 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2132,3 +2132,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 }
 
 GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cea62174c3..57f596be4f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3817,3 +3817,30 @@ RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
 GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
+RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
+RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
+GEN_VEXT_VV_ENV(vfmin_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmin_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmin_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
+RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
+RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
+GEN_VEXT_VF(vfmin_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmin_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmin_vf_d, 8, 8, clearq)
+
+RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
+GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
+GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
-- 
2.27.0


