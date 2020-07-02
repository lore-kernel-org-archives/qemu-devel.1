Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B791FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741152088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ny666gFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741152088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2VQ-0005vL-OU
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AV-0005yP-GD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AS-0000AD-V5
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707672; x=1625243672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KqiJRCraz2h+aV9EbckPMv6cdsGJq0qRpzCsnwZ5XYc=;
 b=Ny666gFSeUmTsmjSqA3PCyI/njPWscaiGWCIkO/fPF1WeiHcY8GGuLsQ
 qFysjp1PK0ycnD7odvmR/gH4hJ0xvklolmR3J59AlipHlX/06ZGnpAzv/
 46HAqdN2Q8XSsG+u4LKFGKgFPenxxWocDmOeeprhQHDeVwUTGPsICirmG
 LEchOLBGnGTwJQ0e0hLiBmD0ihuhN6s0gBaVd4yz1JhcK7TRoC2wL1nGC
 BU7xBWh0nmGpUiYupTOx4NaVwC5ofQPYSsUVXuD+Ux7KffDYRWp1Bm4Fl
 irnVb93dyQ95fgA/MkOluL4VCIr+cEGWts9gyoWz9yQBHfWwKabFmJadK A==;
IronPort-SDR: 25nOfNmPb73aQACkOuPr4XPPNw4cFqLw6ylNA3HsJjjaje97rbfm5Wvqz75n4RnPUaxjoMpia6
 KcDB72qRGfvTNzkxRCrsmxQ9zDGkT23+lusZI7i7uaGs9F3zsvbQ1dZKZJRKmeS86wKc1SIUBX
 ASienSeZdYxsyZVqtyfPcalEnDYrx2JOteheZkyPtOJa2SBuxp2JlFAVVlv8TMGqGQ8aZQoxKd
 jTPJrJ/vR90zSzIn2U2u85xxHCUUCUUeRgk9iqcuzr+rtKlWN+D8t6PWUlco+2L688dxTONKJR
 7mw=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498500"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:27 +0800
IronPort-SDR: j8wAyCIBm1FDfhLN0anGOgF/+aFmm2z5IaiF01miDfOkGBFsHCvpyUzWuJ8xCyHHJMcCGNYoAy
 QjaP4g2JZGp9mBBDwVWp+2eRRDVeFvc8I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:43 -0700
IronPort-SDR: 0BqG7VzglO8ku4jJhm+09ZHCGFeOYSbp+7R63rlCHMsAK2HWejW7DIIRDgI0QVXLqBnzpExx+y
 5t0jmILJxxtQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 30/64] target/riscv: vector widening saturating scaled
 multiply-add
Date: Thu,  2 Jul 2020 09:23:20 -0700
Message-Id: <20200702162354.928528-31-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-28-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  22 +++
 target/riscv/insn32.decode              |   7 +
 target/riscv/insn_trans/trans_rvv.inc.c |   9 ++
 target/riscv/vector_helper.c            | 205 ++++++++++++++++++++++++
 4 files changed, 243 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b2fc71c2ea..f123302b82 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -751,3 +751,25 @@ DEF_HELPER_6(vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vwsmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1dfc5f7ca0..8cc2bf4864 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -426,6 +426,13 @@ vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
 vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
 vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
 vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 8e85a2aed3..5e36ee8de5 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1758,3 +1758,12 @@ GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
 /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
 GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
 GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
+
+/* Vector Widening Saturating Scaled Multiply-Add */
+GEN_OPIVV_WIDEN_TRANS(vwsmaccu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwsmacc_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwsmaccsu_vv, opivv_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d062d904ca..d818c32d97 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2704,3 +2704,208 @@ GEN_VEXT_VX_RM(vsmul_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_RM(vsmul_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_RM(vsmul_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_RM(vsmul_vx_d, 8, 8, clearq)
+
+/* Vector Widening Saturating Scaled Multiply-Add */
+static inline uint16_t
+vwsmaccu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b,
+          uint16_t c)
+{
+    uint8_t round;
+    uint16_t res = (uint16_t)a * b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return saddu16(env, vxrm, c, res);
+}
+
+static inline uint32_t
+vwsmaccu16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b,
+           uint32_t c)
+{
+    uint8_t round;
+    uint32_t res = (uint32_t)a * b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return saddu32(env, vxrm, c, res);
+}
+
+static inline uint64_t
+vwsmaccu32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b,
+           uint64_t c)
+{
+    uint8_t round;
+    uint64_t res = (uint64_t)a * b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return saddu64(env, vxrm, c, res);
+}
+
+#define OPIVV3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
+static inline void                                                 \
+do_##NAME(void *vd, void *vs1, void *vs2, int i,                   \
+          CPURISCVState *env, int vxrm)                            \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1, d);                \
+}
+
+RVVCALL(OPIVV3_RM, vwsmaccu_vv_b, WOP_UUU_B, H2, H1, H1, vwsmaccu8)
+RVVCALL(OPIVV3_RM, vwsmaccu_vv_h, WOP_UUU_H, H4, H2, H2, vwsmaccu16)
+RVVCALL(OPIVV3_RM, vwsmaccu_vv_w, WOP_UUU_W, H8, H4, H4, vwsmaccu32)
+GEN_VEXT_VV_RM(vwsmaccu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV_RM(vwsmaccu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_RM(vwsmaccu_vv_w, 4, 8, clearq)
+
+#define OPIVX3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)         \
+static inline void                                                 \
+do_##NAME(void *vd, target_long s1, void *vs2, int i,              \
+          CPURISCVState *env, int vxrm)                            \
+{                                                                  \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1, d);       \
+}
+
+RVVCALL(OPIVX3_RM, vwsmaccu_vx_b, WOP_UUU_B, H2, H1, vwsmaccu8)
+RVVCALL(OPIVX3_RM, vwsmaccu_vx_h, WOP_UUU_H, H4, H2, vwsmaccu16)
+RVVCALL(OPIVX3_RM, vwsmaccu_vx_w, WOP_UUU_W, H8, H4, vwsmaccu32)
+GEN_VEXT_VX_RM(vwsmaccu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_RM(vwsmaccu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_RM(vwsmaccu_vx_w, 4, 8, clearq)
+
+static inline int16_t
+vwsmacc8(CPURISCVState *env, int vxrm, int8_t a, int8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (int16_t)a * b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return sadd16(env, vxrm, c, res);
+}
+
+static inline int32_t
+vwsmacc16(CPURISCVState *env, int vxrm, int16_t a, int16_t b, int32_t c)
+{
+    uint8_t round;
+    int32_t res = (int32_t)a * b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return sadd32(env, vxrm, c, res);
+
+}
+
+static inline int64_t
+vwsmacc32(CPURISCVState *env, int vxrm, int32_t a, int32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = (int64_t)a * b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return sadd64(env, vxrm, c, res);
+}
+
+RVVCALL(OPIVV3_RM, vwsmacc_vv_b, WOP_SSS_B, H2, H1, H1, vwsmacc8)
+RVVCALL(OPIVV3_RM, vwsmacc_vv_h, WOP_SSS_H, H4, H2, H2, vwsmacc16)
+RVVCALL(OPIVV3_RM, vwsmacc_vv_w, WOP_SSS_W, H8, H4, H4, vwsmacc32)
+GEN_VEXT_VV_RM(vwsmacc_vv_b, 1, 2, clearh)
+GEN_VEXT_VV_RM(vwsmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_RM(vwsmacc_vv_w, 4, 8, clearq)
+RVVCALL(OPIVX3_RM, vwsmacc_vx_b, WOP_SSS_B, H2, H1, vwsmacc8)
+RVVCALL(OPIVX3_RM, vwsmacc_vx_h, WOP_SSS_H, H4, H2, vwsmacc16)
+RVVCALL(OPIVX3_RM, vwsmacc_vx_w, WOP_SSS_W, H8, H4, vwsmacc32)
+GEN_VEXT_VX_RM(vwsmacc_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_RM(vwsmacc_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_RM(vwsmacc_vx_w, 4, 8, clearq)
+
+static inline int16_t
+vwsmaccsu8(CPURISCVState *env, int vxrm, uint8_t a, int8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = a * (int16_t)b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return ssub16(env, vxrm, c, res);
+}
+
+static inline int32_t
+vwsmaccsu16(CPURISCVState *env, int vxrm, uint16_t a, int16_t b, uint32_t c)
+{
+    uint8_t round;
+    int32_t res = a * (int32_t)b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return ssub32(env, vxrm, c, res);
+}
+
+static inline int64_t
+vwsmaccsu32(CPURISCVState *env, int vxrm, uint32_t a, int32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = a * (int64_t)b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return ssub64(env, vxrm, c, res);
+}
+
+RVVCALL(OPIVV3_RM, vwsmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, vwsmaccsu8)
+RVVCALL(OPIVV3_RM, vwsmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, vwsmaccsu16)
+RVVCALL(OPIVV3_RM, vwsmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, vwsmaccsu32)
+GEN_VEXT_VV_RM(vwsmaccsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV_RM(vwsmaccsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_RM(vwsmaccsu_vv_w, 4, 8, clearq)
+RVVCALL(OPIVX3_RM, vwsmaccsu_vx_b, WOP_SSU_B, H2, H1, vwsmaccsu8)
+RVVCALL(OPIVX3_RM, vwsmaccsu_vx_h, WOP_SSU_H, H4, H2, vwsmaccsu16)
+RVVCALL(OPIVX3_RM, vwsmaccsu_vx_w, WOP_SSU_W, H8, H4, vwsmaccsu32)
+GEN_VEXT_VX_RM(vwsmaccsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_RM(vwsmaccsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_RM(vwsmaccsu_vx_w, 4, 8, clearq)
+
+static inline int16_t
+vwsmaccus8(CPURISCVState *env, int vxrm, int8_t a, uint8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (int16_t)a * b;
+
+    round = get_round(vxrm, res, 4);
+    res   = (res >> 4) + round;
+    return ssub16(env, vxrm, c, res);
+}
+
+static inline int32_t
+vwsmaccus16(CPURISCVState *env, int vxrm, int16_t a, uint16_t b, int32_t c)
+{
+    uint8_t round;
+    int32_t res = (int32_t)a * b;
+
+    round = get_round(vxrm, res, 8);
+    res   = (res >> 8) + round;
+    return ssub32(env, vxrm, c, res);
+}
+
+static inline int64_t
+vwsmaccus32(CPURISCVState *env, int vxrm, int32_t a, uint32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = (int64_t)a * b;
+
+    round = get_round(vxrm, res, 16);
+    res   = (res >> 16) + round;
+    return ssub64(env, vxrm, c, res);
+}
+
+RVVCALL(OPIVX3_RM, vwsmaccus_vx_b, WOP_SUS_B, H2, H1, vwsmaccus8)
+RVVCALL(OPIVX3_RM, vwsmaccus_vx_h, WOP_SUS_H, H4, H2, vwsmaccus16)
+RVVCALL(OPIVX3_RM, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
+GEN_VEXT_VX_RM(vwsmaccus_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_RM(vwsmaccus_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_RM(vwsmaccus_vx_w, 4, 8, clearq)
-- 
2.27.0


