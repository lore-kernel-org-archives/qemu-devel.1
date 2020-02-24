Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C916EC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AA12176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQ2dparv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AA12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MAS-0001Ui-OG
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7i-0004Gp-91
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7h-0005qj-3B
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:46 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7g-0005qI-US
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:45 -0500
Received: by mail-pl1-x644.google.com with SMTP id d9so4608418plo.11
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BR6sc2PsWl2NSv+8xYHc8XwgP3dTmPaC/PPPaHkcT3I=;
 b=DQ2dparviTdEn1mh9O1lQXFqY3QilS/OGLcCZ+Huii0oWHWSzMo2G6iYtJircXbGPC
 /gAs6Dz8gir/vzxWET88fVpkmNSKc9+2luOAiZAjF0Ku+ZxAu4d6PYJwpeTPwXFh5sbL
 WfbVPfeBSClTLbogMwUlHYwdhKFqwxIDs79mlGZwtkLb7rU8oQkS/7vn4aqqy5Bi12jK
 RMKhCYFJiMk6wKsXBKcc+8aHSsbS5aUVr3WOL1zmUoexLsBHUEDkdmR3/YUp1WnIvznY
 wHHoF6y1K2n+o4Xn2vd+RYvHv5u7D+lA+gSZexh7+p0KLkcIlT3EpzoqEcoSlJppmiJ5
 5TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BR6sc2PsWl2NSv+8xYHc8XwgP3dTmPaC/PPPaHkcT3I=;
 b=Tr10TcxxPt9iQNmKbz+BIhsCB9ReHaaqnRNCYspgRtgEKhvjOp/F28c8gGYv5QmLi4
 Rf4t4JqEetsu7oyfBIXiRcpUlKQ9bF9PNSD/cd6yBdxY/RlNCh0Gyd5NcpUNf7fCb04g
 c/9U9A8jm8WXl0O7l7a7Mp+dGPkXkPlnxMWXNgD57a5M0kek+3QpwntZ5zQXtQsfOVWi
 btN92ZTsA9t+Rfxlt+qFd0frBRh9FoQvWE3EEius7Nlth9cgk9fMrNLrQ935ix5hLO8R
 YXSDNZ62dz3Y9aykk4u2KclPdJwJp2YASm+8Lrcn3J5XNDbxM6CxcA8Y7Ps7OwUl784p
 l6FQ==
X-Gm-Message-State: APjAAAWclI+iAr2ASR+UpaI5no/8K9kZz7+f8uU97V0J/4L1Ui5gfSTN
 VvUQg3Wuq9xABM8Lz4Cp9alVYrmF61I=
X-Google-Smtp-Source: APXvYqyb7t5Cgw7jnuo9osC/qJYgdzVjWov5uP2Cf+UeEWNbr6Qr0dKvubbcol54DIhUKT/nRLdClA==
X-Received: by 2002:a17:902:8d83:: with SMTP id
 v3mr52983013plo.282.1582582963580; 
 Mon, 24 Feb 2020 14:22:43 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/17] target/arm: Replace ARM_FEATURE_VFP3 checks with
 fp{sp, dp}_v3
Date: Mon, 24 Feb 2020 14:22:22 -0800
Message-Id: <20200224222232.13807-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sort this check to the start of a trans_* function.
Merge this with any existing test for fpdp_v2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ff30165045..51d46f4302 100644
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


