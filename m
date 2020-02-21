Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD4C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD2B24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtrZtE2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD2B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58VJ-00040g-3W
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582y-0000Fo-2s
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582w-0004CF-UZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582w-0004B9-Nu
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id e8so1997576wrm.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=81QiuxFnI/2n9UAjb2neO09HEKDLboGr1Lbfkl3Yhyw=;
 b=AtrZtE2SDaB6Z7hRDalZ2iSpfqYdejY6tXwoah+8JlSM12NO1PwXiZ0oxs+Rhrqrkq
 0mkJC4jiE3rjuUBVAGKYB48wKJ7/OF2zSoqqtxnd2QlIfqFRb29Xkf+8DBzKieCsZ0O5
 ssaII7XPlktm3Fvr8NOx9wkAxH8vaTbJf5c9v5rFyOw4paMMSo73vBGsAbccbtSetO65
 QQYR+NSvPcbJ2dcW0gvxLNg+67tp0pDn4L+49Q09u0Yv/PUBnPhBj+RUDpuDHBX+ih+j
 TNBoSJjDE33vLeNOv7ShNN0p9t8Gq7BeJls7ZRU5RELIbMWYAI528VSvX6cV2QCdwWkp
 +hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=81QiuxFnI/2n9UAjb2neO09HEKDLboGr1Lbfkl3Yhyw=;
 b=IhSzBk49mIhMu6M/+dTC6CRfa1QO2D9X5fadZOEHpOUfZFNwzcwzxp8TW5nmElpfGC
 gV2AFjl0aU8NBopX2RTFqw5xo7BAfBW1x4Xl/3Z3ZOv60MSx8ZeRV2iz8+o8cRTElu9G
 ZLc2MZzx1OpjTGbyODFm0lkgVVJl2w3htmnzrQxQ6bMw2BDEtT3VUivnH9z8yVUjhMsz
 yZfFJWgUEr5dIWClQqcv0WvPqvK8QkGLbENVHmsvLhEbW4cajGURuJk/qKcJ5X1pDzbY
 tot3BNGLQ/Uh8t9iwdXPuXYCdZH4KDob31a1cH0S01pua18UXWKo1YlbkPv7hLEaLPfZ
 LwwQ==
X-Gm-Message-State: APjAAAX0Xos942ner8e1ZYIxbdNGnQBK5wiHI5rymY4zLLDxVhnNX/MF
 ApsYDMFHflK2a0BIDFPt83Q6RGyDxUYtNw==
X-Google-Smtp-Source: APXvYqzTht2iBDy6qAxMZMw7eXegGteO3KnQdKlG4zFNqQGFUNJKelUlnM4+X/y8tn2ekzj3hl4PDA==
X-Received: by 2002:adf:d850:: with SMTP id k16mr47831546wrl.216.1582290525353; 
 Fri, 21 Feb 2020 05:08:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/52] target/arm: Replace ARM_FEATURE_VFP3 checks with fp{sp,
 dp}_v3
Date: Fri, 21 Feb 2020 13:07:39 +0000
Message-Id: <20200221130740.7583-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Sort this check to the start of a trans_* function.
Merge this with any existing test for fpdp_v2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-10-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 0c551401273..9e5516f208b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -717,7 +717,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
          * VFPv2 allows access to FPSID from userspace; VFPv3 restricts
          * all ID registers to privileged access only.
          */
-        if (IS_USER(s) && arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        if (IS_USER(s) && dc_isar_feature(aa32_fpsp_v3, s)) {
             return false;
         }
         ignore_vfp_enabled = true;
@@ -746,7 +746,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     case ARM_VFP_FPINST:
     case ARM_VFP_FPINST2:
         /* Not present in VFPv3 */
-        if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        if (IS_USER(s) || dc_isar_feature(aa32_fpsp_v3, s)) {
             return false;
         }
         break;
@@ -1871,12 +1871,12 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 
     vd = a->vd;
 
-    if (!dc_isar_feature(aa32_fpshvec, s) &&
-        (veclen != 0 || s->vec_stride != 0)) {
+    if (!dc_isar_feature(aa32_fpsp_v3, s)) {
         return false;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpshvec, s) &&
+        (veclen != 0 || s->vec_stride != 0)) {
         return false;
     }
 
@@ -1921,7 +1921,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
     vd = a->vd;
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v3, s)) {
         return false;
     }
 
@@ -1935,10 +1935,6 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2563,7 +2559,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpsp_v3, s)) {
         return false;
     }
 
@@ -2623,11 +2619,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpdp_v3, s)) {
         return false;
     }
 
-- 
2.20.1


