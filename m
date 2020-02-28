Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F1EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B330F2468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXzMT4BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B330F2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ijC-0007vN-Rr
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifD-0007Ti-GX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifC-0001tX-Dn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifC-0001t8-7b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id a141so3904551wme.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LRuxsvUE6MoetAym138Cb7YXTKAQg191Q+D+Hx23Pq4=;
 b=PXzMT4BRRMw5gRXIMcOn92ZIHPyFhgclRxEAre7Yx34nFp3emrjojJsTPCuHrjykQY
 t6Tatg4Tz15eXBsyx7yk++kCZFf6EIWqSUpZuw787sKluQhPZGEYyDcPByNzTNi7dS/N
 pUBQUU9MwHn5dAPqRpY9J7rwqicLFzfq8w94kXPsy/MrnpSRtvkZlmWX/bYA9xLrqS8s
 mePB8bIJSdDbKWjpKOrn9hywe6ui4SBWzfvBhfJ86b/j2uE9XEvyzvijheQt8zSL9wu6
 pwJZnTXwPTr8lRroSv6ekAue9wCmjhEWHB6pBP6AHFby2hi8hW25WNWAyMTF5qKhBjL/
 vtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LRuxsvUE6MoetAym138Cb7YXTKAQg191Q+D+Hx23Pq4=;
 b=GTIDttXDpmTDrfePxyKejSoPra/uCkmjMDvCLAxgUjH+w5PK2BdyQqBaaG9h77iJCn
 Opo1G0sVGy+F20Wg21fkx6HXS0hZ6uGAXVb5xPvNSRJVDQlwxTy1nUlKAi83hxbTx+Mx
 q+s2X7NQJk9LFh318wx143+4KxXjVB+gxHTdlWTC3+Qou+e45qVQg8q9znqqn3My0izf
 Wv0mjfrpRn9835mLkpBwZqXCm5O2OLWeTpSxLjkDHFzaZ96jSSuSc856rL9kgxX/BKph
 QrPPIhNOn1NJN4qe6KBu1JBKuGwX/I5yYsWBJFl0J7g1xSBCnd9mZUlnRmJeBSf0QKsC
 8GMQ==
X-Gm-Message-State: APjAAAVm9srT8QbvVJYfCS2AnM/9yPRmCe10Z8skDbvWRPsPyj6OcEvR
 ZFFxzuAS8aK3IrxIQ4VNBBsA76GAab0j9A==
X-Google-Smtp-Source: APXvYqyA4R0mRr3xtGFFnc76L/eakytyw4jUjPxSce7AvheD1XivyRvTNpOVja694eQUDVqztoz+Mw==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr5028278wmc.49.1582907937046;
 Fri, 28 Feb 2020 08:38:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/33] target/arm: Replace ARM_FEATURE_VFP3 checks with fp{sp,
 dp}_v3
Date: Fri, 28 Feb 2020 16:38:19 +0000
Message-Id: <20200228163840.23585-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ff301650455..51d46f43027 100644
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
@@ -1873,12 +1873,12 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 
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
 
@@ -1923,7 +1923,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
     vd = a->vd;
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v3, s)) {
         return false;
     }
 
@@ -1937,10 +1937,6 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2565,7 +2561,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpsp_v3, s)) {
         return false;
     }
 
@@ -2625,11 +2621,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
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


