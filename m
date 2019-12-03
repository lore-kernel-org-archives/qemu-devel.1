Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E56C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA162064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McUPS8Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA162064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHK6-00031B-B3
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3T-0002fl-IN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3R-0006lu-ED
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:03 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH3F-0006Yw-Cu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:51 -0500
Received: by mail-pl1-x643.google.com with SMTP id w7so2267962plz.12
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kdW9rejh1ibQajGq3OYdmfZLH8GvxDCl1d2Jfe7OmXM=;
 b=McUPS8EwimSh1/Fh5SI1znSlwb1sJgYucLyst9pmIYvO6GVt4QTxxDxTnWJrxE+29L
 98yJC/dLhgpW/aptS8ckulAeN6Wih1CJlNE6k8MeEnzNg7eChm/TEZmDXB49SuJvD/Oh
 g9iJT0ucE6FV8r4M4T18L87o0eBtvfi+793rJHjTmnSo4j6hiJ7tnecN7Vj6nIJbBQRE
 jd+6rKVZh9nDqrI4uD8xdaJ9VO2GKNS4u99aPnbXYVfDjQ2mIWo35XwgBv4+9K+7IDdN
 JjQeH0lRbJ4dRVQJLAr4ABM8nhJagfOLTLOJovrdDZzCTFymRKv0nSNqxgYyeQIJmryd
 WLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kdW9rejh1ibQajGq3OYdmfZLH8GvxDCl1d2Jfe7OmXM=;
 b=n8BMcA1gG2ux7cBzxIszAmkiBs47J2C1RIW/IlL53MPT2lSyCWqdHbR/lj0jusJjgT
 tJBR2/rkVNhw+rK5CmLWMqRH5Q2DWgV6dNte/jWUpycXjZ/6w5kM8kYvstkRhEFp8Hxy
 T8tnwNy7/o/pEokx1V7c7JFPf6mgidHjxeuk5las0mHzLfpZstKqB2DDH0M2ZiuAdYKC
 VACrpbrJarKVEDnNf/rjgttjoCmhb04gn5R12tSHljQs/n2MSFjqdsxordxJQr70K+qr
 vXbI2+VjG0E2zG5PlwtJGDxrntlvv2RN/k37HRFMsrrf/KVCQ5nQuCRk+GIFIDcScqZH
 Y+AQ==
X-Gm-Message-State: APjAAAU4rL066rC0QYowc35x+wGuBnjHynQdYLWE+kJbvD4lZNJf6oZZ
 9w8MfCiTkJDoCDlEhKlSj8wQauGrdzo=
X-Google-Smtp-Source: APXvYqx9sIgEx+ddkvSLwkpJ/hZ5lkrhMPYg9JQzZ/4mPA+S5eM5SDjDE3oYipGWTwe1jIk+vnG1nA==
X-Received: by 2002:a17:902:6bcc:: with SMTP id
 m12mr347091plt.272.1575413624119; 
 Tue, 03 Dec 2019 14:53:44 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] target/arm: Update arm_mmu_idx_el for PAN
Date: Tue,  3 Dec 2019 14:53:29 -0800
Message-Id: <20191203225333.17055-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

Examine the PAN bit for EL1, EL2, and Secure EL1 to
determine if it applies.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 512be5c644..6c65dd799e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11770,13 +11770,22 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return ARMMMUIdx_EL10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
+            if (env->pstate & PSTATE_PAN) {
+                return ARMMMUIdx_SE1_PAN;
+            }
             return ARMMMUIdx_SE1;
         }
+        if (env->pstate & PSTATE_PAN) {
+            return ARMMMUIdx_EL10_1_PAN;
+        }
         return ARMMMUIdx_EL10_1;
     case 2:
         /* TODO: ARMv8.4-SecEL2 */
         /* Note that TGE does not apply at EL2.  */
         if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            if (env->pstate & PSTATE_PAN) {
+                return ARMMMUIdx_EL20_2_PAN;
+            }
             return ARMMMUIdx_EL20_2;
         }
         return ARMMMUIdx_E2;
-- 
2.17.1


