Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF86C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C562072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ojjbGnRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C562072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MVS-0001e9-9Y
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR6-0001uT-46
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR3-0000E7-Se
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075503; x=1629611503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sFvFvjNjpUCti0g6dQBNn6K8GaHBoa/jE4d+xGvVp5E=;
 b=ojjbGnRHZVNFu5mOVT0Q7bS74anThPSpcL4rOCFF6baa0A8JXeKEHAAG
 pMGGUOFQm7yIUPGnBFm4J46JVRVeTKuldbX/h5X+VsuqX88RyKR1tHFUA
 PA0q3XtkNkRAzbJp7gIYXgMnv3Il4SiJJ/pj6FWPENMIUBFUzyozw9VsS
 NjEIif8sDGak8WVOMn0J0Nueo+TeEsmvYJcMpWW5ew8fSd6bZz5ZzSowp
 U2Q/vypPBAQjjYh3STbml7dcyUauc1pauwVuueIfaJhdbZYZ7WMKg0INI
 Nq31eOps7d+EcNjxqiGO4D77eIeaezHOCIXbHPDb5gsDFUb82RoOwIIdU g==;
IronPort-SDR: FVO892yeTC7NCK3hgV8WIbEfAl9xBxkIJykZEdBCU6z26Y2pdLggDIEq8xdeqmCdBiuJo3YeZD
 3UiRe3jmZ6capucll/+VNBzyyRJvYqzvdyJKLSpa6bMgW8OKz1ZMNqE8SgCo6n4/AjTH/8/yla
 pbYFxcC5NVKBo/lFVpIOXmcZmZHeS/wC/BYWfQ2/Or+V2UC0lzYCW+FBf5BfaGOYOWKZKZacTs
 iEcX3LkBGUYXafxBQZ4VJuGsA74FGPkbVz55lPc7xUgI6mKY+Sc7NfXtjOiSLVnKSf4+wNg4Kj
 sfI=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="248764773"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:29 +0800
IronPort-SDR: qK+6Utd7VEpRT0Eb3N+sKtjRBrsYtcqrV2g8Q+FoJ/hOJNorZHGl91EPOD994bInVx5ihE3QYe
 R85zxlvGPoXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:56 -0700
IronPort-SDR: OTO316WXzKiZTHzemN+SHnREg48czRNP8JgcBzXYQqje9kM0PwYYV0bgcAWebJ5tCg+jiABtEH
 2L3tRhSRPEGA==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/20] target/riscv: Check nanboxed inputs to fp helpers
Date: Fri, 21 Aug 2020 22:40:45 -0700
Message-Id: <20200822054101.1202175-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:51:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 alistair.francis@wdc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

If a 32-bit input is not properly nanboxed, then the input is
replaced with the default qnan.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200724002807.441147-5-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h  | 11 +++++++
 target/riscv/fpu_helper.c | 64 ++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 9f4ba7d617..f1a546dba6 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -43,4 +43,15 @@ static inline uint64_t nanbox_s(float32 f)
     return f | MAKE_64BIT_MASK(32, 32);
 }
 
+static inline float32 check_nanbox_s(uint64_t f)
+{
+    uint64_t mask = MAKE_64BIT_MASK(32, 32);
+
+    if (likely((f & mask) == mask)) {
+        return (uint32_t)f;
+    } else {
+        return 0x7fc00000u; /* default qnan */
+    }
+}
+
 #endif
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 72541958a7..bb346a8249 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -81,9 +81,12 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
     set_float_rounding_mode(softrm, &env->fp_status);
 }
 
-static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
-                           uint64_t frs3, int flags)
+static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
+                           uint64_t rs3, int flags)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
+    float32 frs3 = check_nanbox_s(rs3);
     return nanbox_s(float32_muladd(frs1, frs2, frs3, flags, &env->fp_status));
 }
 
@@ -139,74 +142,97 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                           float_muladd_negate_product, &env->fp_status);
 }
 
-uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return nanbox_s(float32_add(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return nanbox_s(float32_sub(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_fmul_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return nanbox_s(float32_mul(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return nanbox_s(float32_div(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_fmin_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return nanbox_s(float32_minnum(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_fmax_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return nanbox_s(float32_maxnum(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1)
+uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t rs1)
 {
+    float32 frs1 = check_nanbox_s(rs1);
     return nanbox_s(float32_sqrt(frs1, &env->fp_status));
 }
 
-target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return float32_le(frs1, frs2, &env->fp_status);
 }
 
-target_ulong helper_flt_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return float32_lt(frs1, frs2, &env->fp_status);
 }
 
-target_ulong helper_feq_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
+    float32 frs1 = check_nanbox_s(rs1);
+    float32 frs2 = check_nanbox_s(rs2);
     return float32_eq_quiet(frs1, frs2, &env->fp_status);
 }
 
-target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t frs1)
+target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
 {
+    float32 frs1 = check_nanbox_s(rs1);
     return float32_to_int32(frs1, &env->fp_status);
 }
 
-target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t frs1)
+target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
 {
+    float32 frs1 = check_nanbox_s(rs1);
     return (int32_t)float32_to_uint32(frs1, &env->fp_status);
 }
 
 #if defined(TARGET_RISCV64)
-uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t frs1)
+uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
 {
+    float32 frs1 = check_nanbox_s(rs1);
     return float32_to_int64(frs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1)
+uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
 {
+    float32 frs1 = check_nanbox_s(rs1);
     return float32_to_uint64(frs1, &env->fp_status);
 }
 #endif
@@ -233,8 +259,9 @@ uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
 }
 #endif
 
-target_ulong helper_fclass_s(uint64_t frs1)
+target_ulong helper_fclass_s(uint64_t rs1)
 {
+    float32 frs1 = check_nanbox_s(rs1);
     return fclass_s(frs1);
 }
 
@@ -275,7 +302,8 @@ uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
 
 uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
 {
-    return float32_to_float64(rs1, &env->fp_status);
+    float32 frs1 = check_nanbox_s(rs1);
+    return float32_to_float64(frs1, &env->fp_status);
 }
 
 uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
-- 
2.28.0


