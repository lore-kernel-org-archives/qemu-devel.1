Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D02C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEC720771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iEVIbjP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEC720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zVc-0002R5-CD
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQV-0002HV-Cs
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQT-0005lp-Bi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272053; x=1628808053;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2uxc3mgF5IfdNIUdAxumFcq0huRtRLtJ8AaE/KG/tlI=;
 b=iEVIbjP+shTWlXCY6MG9biTRdzyCfx87EiM0ZrAa34ngdX4KQqal4aYh
 RiTvBV1+ENTwgvFYg9AQLCLTH1O+9Yw4jhl7WI3UCIiWqQxpMGFjQORFg
 ZMP5+py01Ocb6LFPNUC38qU45hix2Zd2q5R/2Pc2rSv5yNCe9X1NXMrcL
 i0tidUP5rVEAnlUYco0LNoR3M2lqwkoFm3Mbt0Oglz8I5R8DKkTjiJqld
 ZnYQGCFcmtiIlWAMVwJ7ZmRsw2thFT5ZzOwzVg8pmfWMMb00jQfwWT8yB
 GXW31bvlPfUviEC5suVdsWLstkyKvBkvtihw/oteBRKo5hrAYEZnSVgCa Q==;
IronPort-SDR: olnGD2aMzfJ13Xuv5NrlYK4O1I1X6MYGo7Xtuhli1Q593fOEXDMbu0VKEYqKVVPr3a74SfntU5
 6Nq1c0FHES2fhoVZVStpxPAebXLZ84jdtuDSe0KN2dd/MEXEy56B83yhCK4Qk/HPouWrfTd56/
 97qS9tVuRXe0yosJ0kEoRfAzPk1T9s4ANas8ueIty/nHgUPJHZjhMbnheMqmWT3iE0eZHWI8h7
 VBwjMc+fPifZmh6fiMhfEwp+eyx9fieFPyIQSNQjucdpUCswWfL3D8vtHbYVx4Nky4Fa2/7Xxd
 dQQ=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853392"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:48 +0800
IronPort-SDR: h0/DA1k1cxFQxidcjGALa8qaO4/nDmNkHmBlYjATnyA4pUmT/9gcwdxvbkgRq6k9t+zv/XMJ0k
 Bwkvgsm7xzwA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:39 -0700
IronPort-SDR: EA9DnRyBVp9lkVY5dRSkpmPqHsvhbhxzMB7QGfF1K6NB0IZasYf3umhrMSlQkMnZ2oyZ46IWCM
 KsfT9cEzBSdA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] target/riscv: Check nanboxed inputs to fp helpers
Date: Wed, 12 Aug 2020 15:30:29 -0700
Message-Id: <20200812223045.96803-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:47
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
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
2.27.0


