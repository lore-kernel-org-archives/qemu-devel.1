Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A5CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E51E20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mBBJ90Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E51E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zTc-0007G9-Kd
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQT-0002G6-JO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQQ-0005mK-0t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272050; x=1628808050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/sYwq4jJBFVrhAN6HvnU9aC89Zg8os3gcPnGisptQJw=;
 b=mBBJ90MrBvWyJ3f2lWXUrNwNIuRPzWKJsEYRo9RTjSmG61YnDRna39F+
 wzg+GC6t8oq6PENPuR8bwztWaI4RZPmQHJrm9qJR6I4UA6qWppoFvBZK8
 XKSxKCo12umpwnffjhsbn5MzuMzUFygJoEkG9rXDMyS/9RZuUoVWkfN96
 hb4sFRbjMrSgmLS3PRyQBUHxB4RUz5XQMvr03VHOUEuHQ3kgjAryfMb8z
 BpsrZd/shFavGHBB32fmLrl0x7Off/ieuvWSzEWtvWgF+aLKBatFr5PZ6
 1P/hy/b1AX3nTW8eKkWo5UWD92klnLiLHLf2TKVuisthrG3h7N0EXTMDl g==;
IronPort-SDR: UwQhcaXd3NKmw789Tf4mrCYZ0rFJ6tgYptaBcsBQQ1k089antaB/RjbCRAxaKPnvAB0FsD2zoZ
 Kanzgg0Hnp3FIPhZQGqh/ZbharDWEYXLQK18QOmry4HBcB+73oPQ/ML/cmjYx+NMqM6t7rl6V6
 PCsZmBAe9Tb9vgUwxZ1DJJAqECt76n1xi8dnrOwjYlwhXBaKuyY08hMfLisGxnBZ2St2RvOVxM
 q/r+R+P0UCcsJEWihga2zuyioz1LR+s0/Zzdfjy6I7gOAC2k3sQLdxmKsrHlkTZ67jDM36rI+E
 xGI=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853390"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:47 +0800
IronPort-SDR: JkJzWU0ElCHVdrhoc7w/6sEo/CuOOIUI0jaENcKDZvCJGRj17G2NmF2fP5K1CFSeqgeR99ktXw
 AQ/baa3UIN1Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:38 -0700
IronPort-SDR: 8SiIO+Ee6UoeuDOlGgCjljMtx3khNKQfqen4eCpPre+4tSo/1U+u81Fx45dr48fMdBUMlkVcoV
 nvDVYY/OcAAw==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] target/riscv: Generate nanboxed results from fp helpers
Date: Wed, 12 Aug 2020 15:30:26 -0700
Message-Id: <20200812223045.96803-2-alistair.francis@wdc.com>
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


