Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E1C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E44C24697
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z07IPW5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E44C24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7in0-0006Pf-Bq
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if8-0007Jp-Iz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if7-0001qI-8s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if7-0001pn-2D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id p18so3636781wre.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sePkBd54w+3287LZ8LJspmr9uwrTqj5oJOIrdf/A0uM=;
 b=z07IPW5IErtmdNtGsafxx25bHg7fqigpofL7hXnZ+NCU0ASILniY2ujLxFrjOxhXC3
 y+Oagn5NSACPency6dciLTgPXn+ph1HHr50HWHbdgCU/0nC3IBY6PpXnqiqs/VAM+4IX
 SI5G5njSSmK5cE+L1pLFUK3+kN3OuLruktcuBGkKM82wswIO/jKcMo1FhdBhzGeBQZyb
 02KrqdC7jjZHXQUGXKbPBF26MvVR8c3HAf7A31sflqTdC09WR5sKFY7q6tzmTnVyMsE7
 gFs/Re4raGpDD4AZ4nvjp/p+uH/Bpj+5HWUbc/SOSfcIGIFWnYs9SefHoLjLhOu0HEAZ
 tN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sePkBd54w+3287LZ8LJspmr9uwrTqj5oJOIrdf/A0uM=;
 b=YuxDJPcqGbVQBKFpeXzjTmGF0PAfu/wLjamvoufayXqzjNLbCx0YD2/gEViR9bY1yY
 cK19LgLNQKpIn7eautG64MQa/407Q+tUf50eu4cJ9Zn3N+dLq1vsE2kdPG3tCFQoSHcB
 aWuLo1K2mwGv7jkiZbKLyzEJojWMASdmCxjM43fJTlhBtzD/X214jzfBnnZ7jfcNd3BZ
 zlIjIHYZAVXuP//G3BbrWFqeUIFi0NrVVWXc9YHXcQN9McZaDNA4n/P7OCKUrdi6JVE9
 xlhxoYcGgX3pWeIUzYYukXjVj4zXMut4YmcGN4A2p8HqOSGzTFLC5Kc7/Ei6aP6/0fGw
 5YLQ==
X-Gm-Message-State: APjAAAVAUuKG/zZI+jAzXccV+vJ0ui3iDqc1Y7eslt6G/2xtZCvUS+pG
 yGGb0725qY774poBnV2hnf3KHfprLMHxng==
X-Google-Smtp-Source: APXvYqylST1/yH46ggQ8hjDRLDzT29KDXHPvcfMppKsj5y9uzxNw90pWyVMFdI/8Iv8Epl9ZJ2gRPw==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr5660291wrt.228.1582907931694; 
 Fri, 28 Feb 2020 08:38:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] target/arm: Rename isar_feature_aa32_fpdp_v2
Date: Fri, 28 Feb 2020 16:38:15 +0000
Message-Id: <20200228163840.23585-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

The old name, isar_feature_aa32_fpdp, does not reflect
that the test includes VFPv2.  We will introduce another
feature tests for VFPv3.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  4 ++--
 target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a128d48d405..1e6eac0cd2a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3470,9 +3470,9 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
-static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
-    /* Return true if CPU supports double precision floating point */
+    /* Return true if CPU supports double precision floating point, VFPv2 */
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ba46e2557a1..e94876c30ca 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -206,7 +206,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -339,7 +339,7 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -425,7 +425,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -488,7 +488,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1313,7 +1313,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1462,7 +1462,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1827,7 +1827,7 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1926,7 +1926,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2070,7 +2070,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2143,7 +2143,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2209,7 +2209,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2269,7 +2269,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2330,7 +2330,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2389,7 +2389,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2417,7 +2417,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2445,7 +2445,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2499,7 +2499,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2539,7 +2539,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2632,7 +2632,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2728,7 +2728,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-- 
2.20.1


