Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C61C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2314218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ml/LGDeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2314218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MAC-0000vu-Ta
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7l-0004OL-0i
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7j-0005sN-Jo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:48 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7j-0005s0-EQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:47 -0500
Received: by mail-pf1-x443.google.com with SMTP id 4so6063238pfz.9
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ABqg53SHadErlQ1KJw2EVsyG66DudT3m5ptP92s2kV4=;
 b=ml/LGDeM83+tA/QuI9WQvvsXX+P52t3WEQ5SAtw+bAXUiCz0nN4ReHgPEwUqPnhZsD
 fvaMa4fOI+ttGPyxkAZ9L1Lmrvf8zS1PcbbxL1VHrWWls1eInuHQnSTvLqjuv3VJ/z6j
 xEknPQQu8h1NZrIAz9KLGE92mSw1cUXs3TPPo7TxBramSMrtftYEeINKRFenVtvGrtQ3
 ag2l6KyYT3IwXljfc13/ciUf7TWjY2fEQfAAmXsfiZFwCaVutE8sSFASLtWEi1hibzgz
 fXsfpQNt1C1TKFcdttXosEUF7SQv5UM7zM4I4khWEUSsKbbDQSICfBSyAWs4adBpF/uL
 +Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ABqg53SHadErlQ1KJw2EVsyG66DudT3m5ptP92s2kV4=;
 b=Wl/+dzLAELPNeJDe1FU30Hr+CwxUDVcENljyV7olbxWt1pLTva1OMxQS6ZP7pRx+iU
 vN26uoyeo6YBPQhZZHCkF5MYxA9U9nMCr0+D7k2kdGbzzZQjKocEu5IDQfCL4HWrsB5X
 6wUHqNvTzRKZklvUIPgR1f/28g5X9cxRYJT/ZdwAXYtb/mmUdwLF7L56UfmvO3An6VoL
 Qsa89UKokj68SgB2UQgq7n3yT1vRgKjch8gIaS5PW6S09GXlw8pEoVPM94Xv7+eBpdTc
 TrtBBLltvtzG1BmFgR/hv3MZA07wPff5GpPliPG2ExlehQ5O4OVnRHPLCjKly/R/NzFY
 l0og==
X-Gm-Message-State: APjAAAWyKTwrmmEN8reYwRAtUlFLUjvutgNW+iN5E52AgWi3bsaK2Z2j
 TV1nxdnrabbzZCpRW0v2c+x7pEdMBHM=
X-Google-Smtp-Source: APXvYqyRh9lcxlT3hIw4otRhwLAUUnR28xRJVkiTYMMPrOoQnnKhSGxwJ2yPZb3PZakxHREoIjm88Q==
X-Received: by 2002:a65:5905:: with SMTP id f5mr17972398pgu.87.1582582966092; 
 Mon, 24 Feb 2020 14:22:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/17] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
Date: Mon, 24 Feb 2020 14:22:24 -0800
Message-Id: <20200224222232.13807-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

All remaining tests for VFP4 are for fused multiply-add insns.

Since the MVFR1 field is used for both VFP and NEON, move its adjustment
from the !has_neon block to the (!has_vfp && !has_neon) block.

Test for vfp of the appropraite width alongside the test for simdfmac
within translate-vfp.inc.c.  Within disas_neon_data_insn, we have
already tested for ARM_FEATURE_NEON.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Applied Peter's fixups, plus test fpdp_v2 in trans_VFM_dp.
---
 target/arm/cpu.h               | 12 ++++++++++++
 target/arm/cpu.c               |  6 +++++-
 target/arm/translate-vfp.inc.c | 22 ++++++++++++++++++----
 target/arm/translate.c         |  2 +-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b94d2a5ace..b29b0eddfc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3514,6 +3514,18 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
 }
 
+/*
+ * Note that this ID register field covers both VFP and Neon FMAC,
+ * so should usually be tested in combination with some other
+ * check that confirms the presence of whichever of VFP or Neon is
+ * relevant, to avoid accidentally enabling a Neon feature on
+ * a VFP-no-Neon core or vice-versa.
+ */
+static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
+}
+
 static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f10f34b655..bdcaa46b8a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1501,7 +1501,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
         u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
         u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
         cpu->isar.mvfr1 = u;
 
         u = cpu->isar.mvfr2;
@@ -1524,6 +1523,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
         cpu->isar.mvfr0 = u;
+
+        /* Despite the name, this field covers both VFP and Neon */
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
+        cpu->isar.mvfr1 = u;
     }
 
     if (arm_feature(env, ARM_FEATURE_AARCH64) &&
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index f88a95438f..03ba8d7aac 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1803,11 +1803,18 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
 
     /*
      * Present in VFPv4 only.
+     * Note that we can't rely on the SIMDFMAC check alone, because
+     * in a Neon-no-VFP core that ID register field will be non-zero.
+     */
+    if (!dc_isar_feature(aa32_simdfmac, s) ||
+        !dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+    /*
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
      */
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
-        (s->vec_len != 0 || s->vec_stride != 0)) {
+    if (s->vec_len != 0 || s->vec_stride != 0) {
         return false;
     }
 
@@ -1861,11 +1868,18 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 
     /*
      * Present in VFPv4 only.
+     * Note that we can't rely on the SIMDFMAC check alone, because
+     * in a Neon-no-VFP core that ID register field will be non-zero.
+     */
+    if (!dc_isar_feature(aa32_simdfmac, s) ||
+        !dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+    /*
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
      */
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
-        (s->vec_len != 0 || s->vec_stride != 0)) {
+    if (s->vec_len != 0 || s->vec_stride != 0) {
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 79880adaad..0489e0cdaa 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5150,7 +5150,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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


