Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A0C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9A9206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="al9UUL+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9A9206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby09-00056a-9G
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwe-0002y2-Ge
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwd-0007wm-Bj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:44 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwd-0007vP-5m
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:43 -0500
Received: by mail-pl1-x643.google.com with SMTP id ay6so1015793plb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6+PxY8SIDMEG7zwbqXLvGydymJLf+U0upJ2ABich2l0=;
 b=al9UUL+mkN/6t8YLEzPqgmKq3KP+bXg/GqpsiXjwJmVI+m/fqSe72I8bDU4VWRzNCZ
 Eul2lGK362EcZWctjX90DzRcqJuNG737U57oIIN9U5diQYdD9dQRTclXicOSOQSrwkFE
 IfTxWobn6+Vi8QL9+6bpzH/28SACDKLtEQTOg7AOk3XY3VOpn0mkl5ldz1mukWyK8oV+
 aS1N101hwbXfl/Z3Ff228RkUmlRculRB6r/C03EyfzqWLp8WIM/bulJrcr3gowplq1F2
 r212Xqnydt3DPhjS/+mCh5khYI4qYc3dHZTPASCsKOvJrBlrV+M66stql0t2hs8VqSBM
 e9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6+PxY8SIDMEG7zwbqXLvGydymJLf+U0upJ2ABich2l0=;
 b=GBGSDYMMy4x9LWZAnXA6O83iF0a4T9wETy3ujC+RFvEndhhGNR1igv2U6aesDOZWfR
 q5O+4opndlVCDD4EOq/T3YVf7wpQ/UgvLV/kTql/5ZvoCG7I9wukD/JYRtqqj035aV7v
 6AMoG2wdMSXspdSEuaxK0G4P6M/QaI7BUifY2wbQwrs38vy13kI60DOhSv3njyJt7TJu
 tlXefHAmrnl5s8PUpeYtpNWyPP6rsVkt0yYl7FHeEkkIrcueAm3bBECswBRIZRkey/EE
 XLXCAQyJoOCFlOTjvVTl27MWC+xHSrf0O1y4jAknhzd3W0FhiwTyivsRlyssTjwStC02
 pjHw==
X-Gm-Message-State: APjAAAWXn5XuUr8Y3BFnIpoK4DpKODFojTcLq+rM4T7m8lreYZrw7Wse
 J9SJsH6kRvcaxZLn1iqBsQV2EUbg2FE=
X-Google-Smtp-Source: APXvYqx8qG34kGzIm0bTrpS2oFEQexXgcxKp00bCl0HDU7PLKTMGa0GBTsI7BGjoVXQj+AIdQZsuEg==
X-Received: by 2002:a17:90a:c592:: with SMTP id
 l18mr2810677pjt.69.1575340181879; 
 Mon, 02 Dec 2019 18:29:41 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/40] target/arm: Enable HCR_E2H for VHE
Date: Mon,  2 Dec 2019 18:28:59 -0800
Message-Id: <20191203022937.1474-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 -------
 target/arm/helper.c | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 994cad2014..9729e62d2c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1387,13 +1387,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_ATA       (1ULL << 56)
 #define HCR_DCT       (1ULL << 57)
 
-/*
- * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
- * HCR_MASK and then clear it again if the feature bit is not set in
- * hcr_write().
- */
-#define HCR_MASK      ((1ULL << 34) - 1)
-
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
 #define SCR_FIQ               (1U << 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0bf8f53d4b..d81daadf45 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4672,7 +4672,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t valid_mask = HCR_MASK;
+    /* Begin with bits defined in base ARMv8.0.  */
+    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4686,6 +4687,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
          */
         valid_mask &= ~HCR_TSC;
     }
+    if (cpu_isar_feature(aa64_vh, cpu)) {
+        valid_mask |= HCR_E2H;
+    }
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= HCR_TLOR;
     }
-- 
2.17.1


