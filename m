Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D77B207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZAYosU27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D77B207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bWG-000697-IN
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQR-0003aX-DD
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQK-0007eB-Vp
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418117; x=1628954117;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/sYwq4jJBFVrhAN6HvnU9aC89Zg8os3gcPnGisptQJw=;
 b=ZAYosU2787TF9WTS2onBTnUqzPMJ8hOh+/IaDXDYn7NkLly+Xv/1YP7t
 MBHHmwwpP4Hiz8xCKxPl693ZeVbN/sp972nwLhuRXVTImSWQls7HQR1Ke
 3JLipIc/sY8gAVKQWs6wpDzxvIrZCb47CP04wc89JLDmjlCCFDREJpgOK
 QaXIhIu0l9AjB10Kae+h+YCHsnt6YxAE7KRo5sA2mGJhL5xqmk3zgdH6E
 O4mSXcsE76HyWUPa9CGheE4qXE6C7K+Q+ZPtdR2Cf8ZWK2J3m6s4P2+/o
 fmyys6wbREWHx43ITI60v2WEnRGzCyiLJkzNUMkQMUaQx4OpfTBClPyj6 w==;
IronPort-SDR: 9yLeTZKHIhAm/1O/9AF+EEnLqJHlA7jRCrip3pnTcfJ5zlUoDp0Vi6mthnWzb+fWnfN7EQZXv+
 LztzwEd12d/Bvi5bv+hiJhTl8dI0bVJknKLvCw/axohRsMzYQoex1aFKX4eHvBBPJr2GiM/Zhn
 qSVA9VpGngdhHY4mm/LSAwk6a9MW7OWkJM/TW34si4beWW/SzQcHL8TzsxgRLK6ekdpqOectEs
 WszCVGUZ+6OphZXrrjjJeP2VEiZZwKwBRkdjFL4XMnSQ+aUr69WRt5WFHjPi5Zdwsr4HjsCTbs
 KaQ=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994803"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:12 +0800
IronPort-SDR: 2So8M/8TjkRo3it4q6h92CQUNm6IiaLnRCPF0IKT+vw3An2p4kCyls11m4Qrl+z8YxzLIJBEti
 KT27n0EGuKqw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:16 -0700
IronPort-SDR: H1SZ8i+o4A2qoeYeZnl1PGyH5KrzEIzIXQExwPpVDCss8uCU3W42+wprMOnsB/4NNNuPQ25nWM
 52nX9V5SCSNA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/20] target/riscv: Generate nanboxed results from fp
 helpers
Date: Fri, 14 Aug 2020 08:04:47 -0700
Message-Id: <20200814150506.2070566-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:11
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

Make sure that all results from single-precision scalar helpers
are properly nan-boxed to 64-bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200724002807.441147-2-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h  |  5 +++++
 target/riscv/fpu_helper.c | 42 +++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 37d33820ad..9f4ba7d617 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -38,4 +38,9 @@ target_ulong fclass_d(uint64_t frs1);
 #define SEW32 2
 #define SEW64 3
 
+static inline uint64_t nanbox_s(float32 f)
+{
+    return f | MAKE_64BIT_MASK(32, 32);
+}
+
 #endif
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 4379756dc4..72541958a7 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -81,10 +81,16 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
     set_float_rounding_mode(softrm, &env->fp_status);
 }
 
+static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                           uint64_t frs3, int flags)
+{
+    return nanbox_s(float32_muladd(frs1, frs2, frs3, flags, &env->fp_status));
+}
+
 uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, 0, &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3, 0);
 }
 
 uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -96,8 +102,7 @@ uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c,
-                          &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_c);
 }
 
 uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -110,8 +115,7 @@ uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_product,
-                          &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_product);
 }
 
 uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -124,8 +128,8 @@ uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c |
-                          float_muladd_negate_product, &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3,
+                      float_muladd_negate_c | float_muladd_negate_product);
 }
 
 uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -137,37 +141,37 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 
 uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_add(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_add(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_sub(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_sub(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_mul(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_mul(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_div(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_div(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_minnum(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_minnum(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_maxnum(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_maxnum(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1)
 {
-    return float32_sqrt(frs1, &env->fp_status);
+    return nanbox_s(float32_sqrt(frs1, &env->fp_status));
 }
 
 target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
@@ -209,23 +213,23 @@ uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1)
 
 uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
 {
-    return int32_to_float32((int32_t)rs1, &env->fp_status);
+    return nanbox_s(int32_to_float32((int32_t)rs1, &env->fp_status));
 }
 
 uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
 {
-    return uint32_to_float32((uint32_t)rs1, &env->fp_status);
+    return nanbox_s(uint32_to_float32((uint32_t)rs1, &env->fp_status));
 }
 
 #if defined(TARGET_RISCV64)
 uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
 {
-    return int64_to_float32(rs1, &env->fp_status);
+    return nanbox_s(int64_to_float32(rs1, &env->fp_status));
 }
 
 uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
 {
-    return uint64_to_float32(rs1, &env->fp_status);
+    return nanbox_s(uint64_to_float32(rs1, &env->fp_status));
 }
 #endif
 
@@ -266,7 +270,7 @@ uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 
 uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
 {
-    return float64_to_float32(rs1, &env->fp_status);
+    return nanbox_s(float64_to_float32(rs1, &env->fp_status));
 }
 
 uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
-- 
2.27.0


