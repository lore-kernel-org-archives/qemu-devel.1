Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B37AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B922468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRTNhp6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B922468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iku-0002jq-UN
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifK-0007lJ-1M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifI-0001xe-TV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:05 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifI-0001xE-Mq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:04 -0500
Received: by mail-wr1-x443.google.com with SMTP id r7so3699343wro.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/szCr71Fa7E6rI1eZ/F7YIIPt2UZ+jHQ1gjDewWxJ5c=;
 b=qRTNhp6psz1En8zws8pb8ZlK5HXWzKliohebiQ7UbEAoUvLi1fsTcfUz2208sBZGxa
 Ojk0p2TaV26D5L7MDnPqcpM1IxPnx3AFBWzYOtivzcDIqzEXeB/B9iwBpSjlZ36ehTwA
 BucaYFDcSAzZdLH3WvG/F0gGi2t6Yr44GN7wwpaXXIJC8rf7KPDtea+L83pU3eSKWOlv
 hdSB51C1LB5UnIScYo/ShPMgDBm4BiKu/xSEyhfdNyXS58pV8dwmcgpeGzw795mz9x9j
 W9gk88dbhQ7PbekKotM7PLuho6P3ipDewzMHfz5Yr+fC2bKEBsv/th2/nL+4fNnWfJCa
 1mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/szCr71Fa7E6rI1eZ/F7YIIPt2UZ+jHQ1gjDewWxJ5c=;
 b=T0yliuYTZqK6unM/aejvlGDzrTrPVcU02Idm6oxyVDaNDKgxeVE3UziRxoPzWDwPhG
 k5wwrCNQiqloHmJk8YJ+l/KMNjdXgWMb06XJ6QNMhH6wVGG2V3HruJl5utFDzxY7NhPG
 6YzolKp+xMCImJUXC5DsDiylqR4vhz0FAOjG/zxYYmwypgDmbKUbbd6qqYz78mh/HCve
 w1Hu8c6vdlAK14uQ+560G+X8Q8JPKrKuA0yZazr1huu/SG64NtI10YzxcbfKGT1tBcxl
 pFJW3VESSQBP393V2gCyymohT4anUJRn7Y5itu+Hbp1lLwcQGa+eRLbsWOyQlrjjQ4u4
 DdTQ==
X-Gm-Message-State: APjAAAX4JHZ8e5lFaEjhoAfkEfIUYg3aUlFF6G10FnUMZ5YqfCKuAFZZ
 Y7w1l0c3XvXHE0pYE4HIUiO2O4kPZ0Y4Ug==
X-Google-Smtp-Source: APXvYqxpcvE+fFUvwvyH0hTV/yu2pwT9k9wq6bUoskSAjptK6REq6k1oOgjBFDicdsMjytt90HFyVQ==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr5816991wrv.114.1582907943447; 
 Fri, 28 Feb 2020 08:39:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/33] linux-user/arm: Replace ARM_FEATURE_VFP* tests for HWCAP
Date: Fri, 28 Feb 2020 16:38:25 +0000
Message-Id: <20200228163840.23585-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Use isar feature tests instead of feature bit tests.

Although none of QEMUs current cpus have VFPv3 without D32,
replace the large comment explaining why with one line that
sets ARM_HWCAP_ARM_VFPv3D16 under the correct conditions.
Mirror the test sequence used in the linux kernel.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200224222232.13807-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b1a895f24ce..86cda127b78 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -468,22 +468,25 @@ static uint32_t get_elf_hwcap(void)
 
     /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
-    GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
     GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
     GET_FEATURE(ARM_FEATURE_THUMB2EE, ARM_HWCAP_ARM_THUMBEE);
     GET_FEATURE(ARM_FEATURE_NEON, ARM_HWCAP_ARM_NEON);
-    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPv3);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
-    GET_FEATURE(ARM_FEATURE_VFP4, ARM_HWCAP_ARM_VFPv4);
+    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
     GET_FEATURE_ID(aa32_arm_div, ARM_HWCAP_ARM_IDIVA);
     GET_FEATURE_ID(aa32_thumb_div, ARM_HWCAP_ARM_IDIVT);
-    /* All QEMU's VFPv3 CPUs have 32 registers, see VFP_DREG in translate.c.
-     * Note that the ARM_HWCAP_ARM_VFPv3D16 bit is always the inverse of
-     * ARM_HWCAP_ARM_VFPD32 (and so always clear for QEMU); it is unrelated
-     * to our VFP_FP16 feature bit.
-     */
-    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPD32);
-    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
+    GET_FEATURE_ID(aa32_vfp, ARM_HWCAP_ARM_VFP);
+
+    if (cpu_isar_feature(aa32_fpsp_v3, cpu) ||
+        cpu_isar_feature(aa32_fpdp_v3, cpu)) {
+        hwcaps |= ARM_HWCAP_ARM_VFPv3;
+        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
+            hwcaps |= ARM_HWCAP_ARM_VFPD32;
+        } else {
+            hwcaps |= ARM_HWCAP_ARM_VFPv3D16;
+        }
+    }
+    GET_FEATURE_ID(aa32_simdfmac, ARM_HWCAP_ARM_VFPv4);
 
     return hwcaps;
 }
-- 
2.20.1


