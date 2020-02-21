Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C33C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EA3208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOPTAA/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EA3208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58YX-0001hL-Tg
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582q-0008OH-4D
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582o-0003tj-Bq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582o-0003t4-3f
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:38 -0500
Received: by mail-wr1-x444.google.com with SMTP id r11so1988611wrq.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z1Y6b6ExQtNuRQRhurbCAkV6WfKuu4Z4DVqSKk6+08k=;
 b=HOPTAA/2/eQsX1TqGrNXo8mE1ZdMUm55Ah4PNrs2x4Y0Una1aWJgohlOFXljy/SF3l
 FL+CBmmlQAQcVb33KeTh95dxGkBUiDOvx+G6nSFmQ+n2Shm52Cun/dOPuVslv/Bnozvm
 RDEUTLm4IzmjaHlElQbWOrmcGJ+fu5/uHZxxj3lMYRxKEYy0OQqJxYjDG/6n0HXDpy3v
 CD1yi4hxOEzOQmhcTw/xPdGhdsUT8IjF1asERxmlSrEcVDrF6NWBdmx+dVhm4jkTbFNE
 fWsp9U0sX8CiDP+hr0DEcz+0BBnoCDYkLUL9A2H5sUC4nqWIElLesTVF6y04b0jw8kyg
 k/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z1Y6b6ExQtNuRQRhurbCAkV6WfKuu4Z4DVqSKk6+08k=;
 b=dT1Ae6al6aKOXyuJXFwdyoV4uUoi0uEN/vFLPeXjrmIA+UdSTMdJJwogv+S0zm6dK4
 AvTJ+K6y1e5ah6Z47RLFK8Jv9eTEBH2d+CYLm5mweypJ7xtM0BrSuIcQzz9jWC6lgkxc
 socyQqS5X/a8CXrt2vP5X5xHHL3dv8hhHDs4FDXdZ0T/spsoJpghM5k48+vOX+EQRFtQ
 dR0qBmDJU5S4+em8TzXMDxyh4TN4WcI24NOdTMcK0hZSMVSRFNVhIH0q2w4bBR71B2q4
 +nvaM/Ym6GSheZCgSo/pjRGyBIgrbDOxCQFAL9A+n6Jx6Wh1TJKqoEl/2ovgCBulemCd
 8YCg==
X-Gm-Message-State: APjAAAW1u/EAzMo1wlZbRuFHRZsYBrNGnqv7FnHcdJE1d5zO/8z3B/zs
 Mk6z85IutBf+6mu9JLBd6lWs6sByPxrGfQ==
X-Google-Smtp-Source: APXvYqx+ofTxlaKn9fC4etbJmcI02I+tPfuG+gcXA11tmEEs6l//7MIiAjh+gF4haqL2V2ZrRq9Abg==
X-Received: by 2002:adf:a1d9:: with SMTP id v25mr47786645wrv.160.1582290516502; 
 Fri, 21 Feb 2020 05:08:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/52] target/arm: Rename isar_feature_aa32_simd_r32
Date: Fri, 21 Feb 2020 13:07:32 +0000
Message-Id: <20200221130740.7583-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The old name, isar_feature_aa32_fp_d32, does not reflect
the MVFR0 field name, SIMDReg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200214181547.21408-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: wrapped one long line]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  2 +-
 target/arm/translate-vfp.inc.c | 53 +++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b4c83a1cb52..65171cb30ee 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3450,7 +3450,7 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
-static inline bool isar_feature_aa32_fp_d32(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
     return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index bf90ac0e5b7..ba46e2557a1 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -201,7 +201,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
@@ -334,7 +334,7 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
@@ -420,7 +420,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vd) & 0x10)) {
         return false;
     }
@@ -484,7 +484,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -556,7 +556,7 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     uint32_t offset;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -615,7 +615,7 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     uint32_t offset;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -662,7 +662,7 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -912,7 +912,7 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
      */
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -978,7 +978,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     TCGv_i64 tmp;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -1101,7 +1101,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd + n) > 16) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd + n) > 16) {
         return false;
     }
 
@@ -1309,7 +1309,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     TCGv_ptr fpst;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((vd | vn | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
         return false;
     }
 
@@ -1458,7 +1458,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     TCGv_i64 f0, fd;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((vd | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
         return false;
     }
 
@@ -1822,7 +1822,8 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
 
@@ -1921,7 +1922,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     vd = a->vd;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
         return false;
     }
 
@@ -2065,7 +2066,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2138,7 +2139,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd  & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd  & 0x10)) {
         return false;
     }
 
@@ -2204,7 +2205,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm  & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm  & 0x10)) {
         return false;
     }
 
@@ -2264,7 +2265,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2325,7 +2326,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2384,7 +2385,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2412,7 +2413,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     TCGv_i32 vm;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2440,7 +2441,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     TCGv_i32 vd;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -2494,7 +2495,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     TCGv_ptr fpst;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2534,7 +2535,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -2627,7 +2628,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2723,7 +2724,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     TCGv_ptr fpst;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
-- 
2.20.1


