Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B68C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6132088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cQuk7yjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6132088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Vy-0006Vq-Bo
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AH-0005Js-Gm
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AF-00009X-0X
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707659; x=1625243659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2rIIVxA0UduAqmh0CswL/VSe8d81pR7QsZV2DvD4nhs=;
 b=cQuk7yjvJKo5J/hNzsnX/quzw3dwHPrW+c6jlwBF/9cN72miqwFGTZcN
 k1Jv0zfYHSXs/HLCx7wrouMuKLQBc6WkLtWQB3z2NiQMcabxOwDQ7v/gt
 h+9VZptLcs/UQrLFz454O6W9kg8aqh36sFjl0qdaEAGbDaBn1G8kDLfa+
 2LxqDaFk+ihAUFsG7/jFyBurbqs1AzWrimIZTQ5QfSlF0c3lDlBR/yd37
 VJR5Ke9VOlnPqvSYuD0NCRvJAiiOVGQBxtPKPYpiqjBHvL3NTACMIw01F
 zSlyHNPcs0lxK5oBd1lYcNT3E7HUFBDzkHNsrjcMkciAugdPGXDvK89GG A==;
IronPort-SDR: cwcRwOXabnVu3+bV3xSQXMyhsvTkQC8nWPPZI3fw5MZSK4qTvuX4BkEj/n9S1WpeOyFD5TAZbJ
 QmcobSKvHdLjbuci6C8Wzd4rj35J8F0asUQaMg0YxD1vKHllhNkhxnl7VCe9NWn71HPCSXLVqr
 OYaSRAumH+xNvXXxjpK8hH8za39qcppgqiZSj8hbVkQh7sobikw40LUBqTmapoI5DhFAAYsynH
 46UuG4RQPH+K7ZC/PnGD2FmRGH55gOO9fzqj3cwN2zjE3IJ6alvbXOtpPfWaNe4rP+KyZ5kWqV
 jAk=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498502"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:28 +0800
IronPort-SDR: w0wWvx7uxSFVQYOeArbTa+oirUhP74K6mcGgY904TKPtj64GTfOd2RE29+8lu7jVuZ5hfRnqbh
 3ZnjNnR2CjgCaLJ2++xKG85v/BJjTIgj4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:43 -0700
IronPort-SDR: kstPa3Y3cjyoXKzl2DyO5qPtXEnA+U1k2ZNfmxBipntk3B34WpVHBHLXkVO87pGwltIvNqwLRQ
 1pXileOZPekA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 31/64] target/riscv: vector single-width scaling shift
 instructions
Date: Thu,  2 Jul 2020 09:23:21 -0700
Message-Id: <20200702162354.928528-32-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-29-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   6 ++
 target/riscv/insn_trans/trans_rvv.inc.c |   8 ++
 target/riscv/vector_helper.c            | 117 ++++++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f123302b82..78438f1ad6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -773,3 +773,20 @@ DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vssrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 8cc2bf4864..7d5dfeb5c7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -433,6 +433,12 @@ vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
 vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
 vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
 vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
+vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
+vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
+vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
+vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
+vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
+vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 5e36ee8de5..31be40f4ba 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1767,3 +1767,11 @@ GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
 GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
+
+/* Vector Single-Width Scaling Shift Instructions */
+GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
+GEN_OPIVV_TRANS(vssra_vv, opivv_check)
+GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
+GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
+GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
+GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d818c32d97..acd44599ba 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2909,3 +2909,120 @@ RVVCALL(OPIVX3_RM, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
 GEN_VEXT_VX_RM(vwsmaccus_vx_b, 1, 2, clearh)
 GEN_VEXT_VX_RM(vwsmaccus_vx_h, 2, 4, clearl)
 GEN_VEXT_VX_RM(vwsmaccus_vx_w, 4, 8, clearq)
+
+/* Vector Single-Width Scaling Shift Instructions */
+static inline uint8_t
+vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
+{
+    uint8_t round, shift = b & 0x7;
+    uint8_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline uint16_t
+vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
+{
+    uint8_t round, shift = b & 0xf;
+    uint16_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline uint32_t
+vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
+{
+    uint8_t round, shift = b & 0x1f;
+    uint32_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline uint64_t
+vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b)
+{
+    uint8_t round, shift = b & 0x3f;
+    uint64_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+RVVCALL(OPIVV2_RM, vssrl_vv_b, OP_UUU_B, H1, H1, H1, vssrl8)
+RVVCALL(OPIVV2_RM, vssrl_vv_h, OP_UUU_H, H2, H2, H2, vssrl16)
+RVVCALL(OPIVV2_RM, vssrl_vv_w, OP_UUU_W, H4, H4, H4, vssrl32)
+RVVCALL(OPIVV2_RM, vssrl_vv_d, OP_UUU_D, H8, H8, H8, vssrl64)
+GEN_VEXT_VV_RM(vssrl_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vssrl_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vssrl_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vssrl_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vssrl_vx_b, OP_UUU_B, H1, H1, vssrl8)
+RVVCALL(OPIVX2_RM, vssrl_vx_h, OP_UUU_H, H2, H2, vssrl16)
+RVVCALL(OPIVX2_RM, vssrl_vx_w, OP_UUU_W, H4, H4, vssrl32)
+RVVCALL(OPIVX2_RM, vssrl_vx_d, OP_UUU_D, H8, H8, vssrl64)
+GEN_VEXT_VX_RM(vssrl_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vssrl_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vssrl_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vssrl_vx_d, 8, 8, clearq)
+
+static inline int8_t
+vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+{
+    uint8_t round, shift = b & 0x7;
+    int8_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline int16_t
+vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+{
+    uint8_t round, shift = b & 0xf;
+    int16_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline int32_t
+vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    uint8_t round, shift = b & 0x1f;
+    int32_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline int64_t
+vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    uint8_t round, shift = b & 0x3f;
+    int64_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+RVVCALL(OPIVV2_RM, vssra_vv_b, OP_SSS_B, H1, H1, H1, vssra8)
+RVVCALL(OPIVV2_RM, vssra_vv_h, OP_SSS_H, H2, H2, H2, vssra16)
+RVVCALL(OPIVV2_RM, vssra_vv_w, OP_SSS_W, H4, H4, H4, vssra32)
+RVVCALL(OPIVV2_RM, vssra_vv_d, OP_SSS_D, H8, H8, H8, vssra64)
+GEN_VEXT_VV_RM(vssra_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vssra_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vssra_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vssra_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vssra_vx_b, OP_SSS_B, H1, H1, vssra8)
+RVVCALL(OPIVX2_RM, vssra_vx_h, OP_SSS_H, H2, H2, vssra16)
+RVVCALL(OPIVX2_RM, vssra_vx_w, OP_SSS_W, H4, H4, vssra32)
+RVVCALL(OPIVX2_RM, vssra_vx_d, OP_SSS_D, H8, H8, vssra64)
+GEN_VEXT_VX_RM(vssra_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vssra_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vssra_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vssra_vx_d, 8, 8, clearq)
-- 
2.27.0


