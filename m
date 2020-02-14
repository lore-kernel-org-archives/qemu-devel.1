Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C8C3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DC6222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c61cqr0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC6222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fYe-0001bc-Pk
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVW-0004Um-2d
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVV-0000Fx-03
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:05 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:33990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVU-0000F8-Q7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:04 -0500
Received: by mail-pl1-x62c.google.com with SMTP id j7so4026785plt.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a/LcTtPEaSKt2TqD4S4P5QmkhybGw6G87ufOx2pyeQw=;
 b=c61cqr0ruFzGdXgVtkN+YNg//bdC9gjAflB/RTCR+hibxY6RdyOLFzZxon4u+hZ8C4
 r4B3GUR2u/8Q8sD98MpGvpSbBFNCvrd+j5uRXOJBKXBTAblu8bALN3mfmTWof1kYQzsv
 N14y+wrNtk3HE6x41aUIwxr7+llq4sU7UHqnKUFFS4TaV6nHAG4gOIt4J+XJiRrM/xg0
 81DHM+qp0ujOaFXhAKQWymt5b6+/kzNndYYYYC7iayt1zOVtq8CfhY07ocvvdzNKDrDG
 DAuqpuRD8mzqRSDJdf3pKUTnEQ9lJNp5CyaGuh43K6L+H/pysgLZ5l3fgElXeMlHZa/I
 a1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a/LcTtPEaSKt2TqD4S4P5QmkhybGw6G87ufOx2pyeQw=;
 b=mGCWy+LfcC/6mvSZlUb3HxDOx9VL3zIzBjphzfIZ/3J5f70eLwbmZiaQiG5HyF50ng
 8wrPCMG58qJiLe15z67ktiIDGjiBjNrmiHWcoZa32uJNeQaEhmWopzJ9ZTjrnWotX5mo
 Maahv2BF5jW09sxMuRZfDmTm9NoGyvOR/fHcD3WvwSWP8rWzvOm9hj5kfMoQrCx2TCc4
 d/53DrrqZB4IPbpUQmnzRXhSYjNURKmH3osH/L+/F3HqUq+UHdWqgW43fZF/Rs4Dcsuc
 BFAAcoQLtn06jxAjubdxEIpesxX5q/z5jK0QIX4OceNd/Un06d/8xJ0We/2tzP1NU+f1
 1zmA==
X-Gm-Message-State: APjAAAXG7bU+4BZ/ML7vOoI4QAsrK/aoIFB2BEEtSPnjyvY1XfnZY95m
 oJSFGdoSmKFwFDIEYMQlMM/2FMYg4wY=
X-Google-Smtp-Source: APXvYqx7iArNF4CsabU32pLpZRdIpRtFQwaoHAgWfiXUaKpOnwPwX8CQCPnLgOLjrCI3bvImxamWow==
X-Received: by 2002:a17:90b:87:: with SMTP id bb7mr5164459pjb.49.1581704161742; 
 Fri, 14 Feb 2020 10:16:01 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/19] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
Date: Fri, 14 Feb 2020 10:15:39 -0800
Message-Id: <20200214181547.21408-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All remaining tests for VFP4 are for fused multiply-add insns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  5 +++++
 target/arm/translate-vfp.inc.c | 12 ++++++++----
 target/arm/translate.c         |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ff28418df..f27b8e35df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3468,6 +3468,11 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
 }
 
+static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
+}
+
 static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8913320259..f6f7601fe2 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1806,8 +1806,10 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
      */
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
-        (s->vec_len != 0 || s->vec_stride != 0)) {
+    if (!dc_isar_feature(aa32_simdfmac, s)) {
+        return false;
+    }
+    if (s->vec_len != 0 || s->vec_stride != 0) {
         return false;
     }
 
@@ -1864,8 +1866,10 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
      */
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
-        (s->vec_len != 0 || s->vec_stride != 0)) {
+    if (!dc_isar_feature(aa32_simdfmac, s)) {
+        return false;
+    }
+    if (s->vec_len != 0 || s->vec_stride != 0) {
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3b9bf13933..0da780102c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4877,7 +4877,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             break;
         case NEON_3R_VFM_VQRDMLSH:
-            if (!arm_dc_feature(s, ARM_FEATURE_VFP4)) {
+            if (!dc_isar_feature(aa32_simdfmac, s)) {
                 return 1;
             }
             break;
-- 
2.20.1


