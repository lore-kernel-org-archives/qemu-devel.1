Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16938C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D835D2088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yqj1pxEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D835D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2cW-0000us-5K
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AU-0005u2-3t
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AR-00009X-Od
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707671; x=1625243671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mnJUCVYgjkrmaNnANvWypBUz7KgZxM4JdjC17ylaeTg=;
 b=Yqj1pxEEDyBD0jn+vukbK3miGkp5HTRNx8WpwayNs1WYaUqkym7KJ3b7
 8hGnzzEgB+QSlJsmjk3dLyP/tOdEUlFxZvfgGROijzi6vCRfeIROJYTbW
 uxuGSceN13jDzVS1T2qt+64IbKoR7nghFm0cx0o61XREH+FaXFWN1tV33
 wp4qsUmr07bERssGCrbYlXIuimFIB6o7fdQPjjhDiQssTYwCOoqepslQa
 h40NgyTXLFecemwLoo0/z7r2uHD+FvoqdOep+KMsrQWfp1UPMJ1KWTZqK
 FYrxZUWV/CM0uc5u7uzHQW7Lro7DlhTd/k9LG1Y75LnuQ+wkgyaaxPOGR w==;
IronPort-SDR: gvT/2xbub4qVebF4X3uCxu4nx8H9jKuVUDIvRxtM0uVlPLk6TpffRAvq1RWd/FVCOiiczUKuE+
 M8gibsLXCOpFmPWJgjfN1rQjg4LK2OKNbOQ1Mk3KrAqRRZp4auFzUV59KcrbqfkitxftsZfyRa
 4oonXCg9eXQQwnF00rlIeY+kKkhsHm2qLCqpmNt8GgJfWKG6WA11J31VgmReJgFQh998Cy2rZb
 SPE4ih6DPq1Pc94KIeASb1HmZ/zTJ/is4ouK2o3EqTPrUfzgfiZWnF36UZWgRuXZnaygIUfasI
 lNA=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498517"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:30 +0800
IronPort-SDR: diiNPYDq6adkUQBzLYeEploZJOKt23lcPkPudW+8OqNXq1hsixZQdFG3uwD5Ey24GMkodgjBAQ
 u1uvkezxGB8HgGrh9Kz2Ws+gsjBHnKeaM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:45 -0700
IronPort-SDR: yb6fhM4nKmtCxcVupPX9T7R47P8KiuCbHVqy2fmScoXcWzmLl+dDgSAPPHMVQ40o/QV1xl6WbI
 vCGyG9yGODng==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 38/64] target/riscv: vector widening floating-point fused
 multiply-add instructions
Date: Thu,  2 Jul 2020 09:23:28 -0700
Message-Id: <20200702162354.928528-39-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-36-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 17 +++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
 target/riscv/vector_helper.c            | 91 +++++++++++++++++++++++++
 4 files changed, 126 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 108a177f25..b537030a11 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -906,3 +906,20 @@ DEF_HELPER_6(vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 9ca765d37f..c9d5078385 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -481,6 +481,14 @@ vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
 vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
 vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
 vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
+vfwmacc_vv      111100 . ..... ..... 001 ..... 1010111 @r_vm
+vfwmacc_vf      111100 . ..... ..... 101 ..... 1010111 @r_vm
+vfwnmacc_vv     111101 . ..... ..... 001 ..... 1010111 @r_vm
+vfwnmacc_vf     111101 . ..... ..... 101 ..... 1010111 @r_vm
+vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
+vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
+vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
+vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index ee601fd790..3a5fd0cf89 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2079,3 +2079,13 @@ GEN_OPFVF_TRANS(vfmadd_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfnmadd_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
+
+/* Vector Widening Floating-Point Fused Multiply-Add Instructions */
+GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 29dc1d1d73..607fcc8742 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3683,3 +3683,94 @@ RVVCALL(OPFVF3, vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
 GEN_VEXT_VF(vfnmsub_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfnmsub_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfnmsub_vf_d, 8, 8, clearq)
+
+/* Vector Widening Floating-Point Fused Multiply-Add Instructions */
+static uint32_t fwmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(float16_to_float32(a, true, s),
+                        float16_to_float32(b, true, s), d, 0, s);
+}
+
+static uint64_t fwmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(float32_to_float64(a, s),
+                        float32_to_float64(b, s), d, 0, s);
+}
+
+RVVCALL(OPFVV3, vfwmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwmacc16)
+RVVCALL(OPFVV3, vfwmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwmacc32)
+GEN_VEXT_VV_ENV(vfwmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwmacc_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF3, vfwmacc_vf_h, WOP_UUU_H, H4, H2, fwmacc16)
+RVVCALL(OPFVF3, vfwmacc_vf_w, WOP_UUU_W, H8, H4, fwmacc32)
+GEN_VEXT_VF(vfwmacc_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwmacc_vf_w, 4, 8, clearq)
+
+static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(float16_to_float32(a, true, s),
+                        float16_to_float32(b, true, s), d,
+                        float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+static uint64_t fwnmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(float32_to_float64(a, s),
+                        float32_to_float64(b, s), d,
+                        float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfwnmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwnmacc16)
+RVVCALL(OPFVV3, vfwnmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwnmacc32)
+GEN_VEXT_VV_ENV(vfwnmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwnmacc_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF3, vfwnmacc_vf_h, WOP_UUU_H, H4, H2, fwnmacc16)
+RVVCALL(OPFVF3, vfwnmacc_vf_w, WOP_UUU_W, H8, H4, fwnmacc32)
+GEN_VEXT_VF(vfwnmacc_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwnmacc_vf_w, 4, 8, clearq)
+
+static uint32_t fwmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(float16_to_float32(a, true, s),
+                        float16_to_float32(b, true, s), d,
+                        float_muladd_negate_c, s);
+}
+
+static uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(float32_to_float64(a, s),
+                        float32_to_float64(b, s), d,
+                        float_muladd_negate_c, s);
+}
+
+RVVCALL(OPFVV3, vfwmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwmsac16)
+RVVCALL(OPFVV3, vfwmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwmsac32)
+GEN_VEXT_VV_ENV(vfwmsac_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwmsac_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF3, vfwmsac_vf_h, WOP_UUU_H, H4, H2, fwmsac16)
+RVVCALL(OPFVF3, vfwmsac_vf_w, WOP_UUU_W, H8, H4, fwmsac32)
+GEN_VEXT_VF(vfwmsac_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwmsac_vf_w, 4, 8, clearq)
+
+static uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(float16_to_float32(a, true, s),
+                        float16_to_float32(b, true, s), d,
+                        float_muladd_negate_product, s);
+}
+
+static uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(float32_to_float64(a, s),
+                        float32_to_float64(b, s), d,
+                        float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfwnmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwnmsac16)
+RVVCALL(OPFVV3, vfwnmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwnmsac32)
+GEN_VEXT_VV_ENV(vfwnmsac_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwnmsac_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF3, vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
+RVVCALL(OPFVF3, vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
+GEN_VEXT_VF(vfwnmsac_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwnmsac_vf_w, 4, 8, clearq)
-- 
2.27.0


