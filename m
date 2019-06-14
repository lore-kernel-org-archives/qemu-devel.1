Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21798C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D092082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBOOEWHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D092082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjtX-0005AX-5J
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbjhg-0007xP-Eb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbjhe-00077Y-TU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbjhe-00076H-LX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so1835984wmm.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=08Z7f4ISnw8IsjRb+rdkg212YqVM77nn40XmfzlB6eY=;
 b=HBOOEWHYhDoCDaVMxHlMQskSwEIpWvgwGujwDhIOBvMmKXeKs/2nOg9US7rvOE92VJ
 md4O4MyvJyCmfXru1ocEXzs4XTh0I4RGfHxzSKJxUZDluUKFStFNhYi4TEmxj5M0L18F
 y1cA0MksR0JX7wNOYbtCeXLIk15DRAjPA+iUVtrBFyRA7lt5a5gn/+0TyFBb+Q0r9f8f
 KtcW6R53WH4kiHZwMWwF7Cd+lyaMgs1GZF5MTViVpCvENuUiaomeS8Ng9B8oXJ6TUxVa
 41iMo5ia7225Mv0+C6/1syaaZc8uRwzBB9F9ClUWZvGuR8ZfPVuK4TSOnSzqb0rBo4XB
 wJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=08Z7f4ISnw8IsjRb+rdkg212YqVM77nn40XmfzlB6eY=;
 b=Ly4VzWPjm7eHyo70X8Rn+QcmJc/gQbZY3BByPLVUlBpO1Uly6KgUIcG61iSgacR5/f
 wGpxpCybHMBdkbrJoFKkgkteKPgpQDSAL8hIbrQt6xqUbpRMr8+nlCEyPCa8L3VneoTU
 2RKIXyA5e2yDlpafRR1DOMP211Su5Yg/Po3BMwa0ME6oTZnj0lWzbOV8pbdP9Nk4LGPG
 Qc1Ab3z2TIh/Dlg4bCXqKBXjT1OE6EAfl1kkfOsuy4ZH7QEoeS4Q5GR/lkOkfMGfokXx
 HOvm2xsUgwpnYPnWZ1g1X/gqhiDTxnO55R8875OHMYacxPMVjOGeG+YQbYqea+WHowM/
 kRxQ==
X-Gm-Message-State: APjAAAXngjKMKprABJ5GfhR7THLroYOvsY8JdwCa4N6hQiCOr0VFDCBY
 eWFdpb1NO9lAZb7BjPd1v8GynQbrXh9OQg==
X-Google-Smtp-Source: APXvYqy0kZkDbtYWpYNivI9UjFC/x1x0oakT3xeI5sGrR9BJFU8cj5Hyt9XTijU5xfLCHo995KTv8w==
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr7296493wmd.124.1560509101448; 
 Fri, 14 Jun 2019 03:45:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y24sm2091238wmi.10.2019.06.14.03.45.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 03:45:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 11:44:57 +0100
Message-Id: <20190614104457.24703-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614104457.24703-1-peter.maydell@linaro.org>
References: <20190614104457.24703-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Only implement doubles if the
 FPU supports them
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The architecture permits FPUs which have only single-precision
support, not double-precision; Cortex-M4 and Cortex-M33 are
both like that. Add the necessary checks on the MVFR0 FPDP
field so that we UNDEF any double-precision instructions on
CPUs like this.

Note that even if FPDP==0 the insns like VMOV-to/from-gpreg,
VLDM/VSTM, VLDR/VSTR which take double precision registers
still exist.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  6 +++
 target/arm/translate-vfp.inc.c | 84 ++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 92298624215..29be1f7ea97 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3382,6 +3382,12 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
+static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point */
+    return FIELD_EX64(id->mvfr0, MVFR0, FPDP) > 0;
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 85187bcc9dc..a3df81d3b07 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -173,6 +173,11 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rn = a->vn;
     rm = a->vm;
@@ -301,6 +306,11 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rn = a->vn;
     rm = a->vm;
@@ -382,6 +392,11 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         ((a->vm | a->vd) & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rm = a->vm;
 
@@ -440,6 +455,11 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rm = a->vm;
 
@@ -1268,6 +1288,10 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -1413,6 +1437,10 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -1773,6 +1801,10 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -1878,6 +1910,10 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -2028,6 +2064,10 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2097,6 +2137,10 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2159,6 +2203,10 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2215,6 +2263,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2272,6 +2324,10 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2327,6 +2383,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2351,6 +2411,10 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2375,6 +2439,10 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2425,6 +2493,10 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2461,6 +2533,10 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2550,6 +2626,10 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2642,6 +2722,10 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
-- 
2.20.1


