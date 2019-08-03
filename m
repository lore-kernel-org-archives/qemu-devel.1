Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B144C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628CF2073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYQqIug3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628CF2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz8F-0005H6-LF
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4h-0006CX-5p
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4e-00079o-R3
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4e-00079M-MD
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id r1so37612157pfq.12
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VC440BcwSuqOKz+Fo7ui0w+dupEF68UzkVylEVc+WDs=;
 b=xYQqIug3gmfLrgPuAZoKA+vetM7unvOZ/ZGAnj/U508vBjOOKgPiRgD1Kqn26Kleay
 mnfIK+wozNSd+s4VKGGZldx3aH3FaWGxLPvZSzApdwKxKPn/w3P1WTLmiXsteqysDCl9
 5qMHusOO+bNqRwvYOx5bHMiJTfGTve3JxSHWI5s4Fc/AU/EgdvoZDV1W5lK1Hvt6AJyn
 QjDuCJJieLrHL2oW5lE9Rye5CAhZ1gL07/LDHjywbVZQNj36hHP4+cLTKme9MziVU2eT
 nury2BWc68bWSp+ZCFqKt7H4fT0FRLejKjejROKZDnI2jgExCs0AaBwKMV86gRws5EIh
 ialA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VC440BcwSuqOKz+Fo7ui0w+dupEF68UzkVylEVc+WDs=;
 b=V9/DNaJ+/rXuQq0xAXqOjqdt5ztjvEcCjLcnjNwWT6+WkUK1v4lxTz1bqUgEWkn8wI
 GvBsXSUeQfqT/maGwUE2dA1ZPI4Wd1OtNQed59aMNOt/3iygLq6WtFILOn9F2oPNQH5H
 aeBUOYpTS2xwAjf4/SqwnI1uSoIgzm4h/y3bIM3dhdmPX2RRrD5T8uDd66m1NPI6pgg2
 Pa5/igTRa6EZtgqChDxINjkn6yvoKf1Ja65SVjytcmSnYe7wkpwPufDXFOV3A5XpDy5z
 x8lf19Cb9KQP18hmagu13c+6ZQQzkDmdvDjIvmXt9dK+Nb/C3YTQhTsANa3/Ct9UBVf/
 1zGQ==
X-Gm-Message-State: APjAAAWVZX+plKFWIvWQJ6uBhDaX2zsUIN1uzlqsJOkXhF7Nwwmfg5vy
 +A0nRetZyaRFfT1zAW3ezIagl4pnxCM=
X-Google-Smtp-Source: APXvYqz6lBWZaB/Djz8xzjkNxK72Fp1Nk7R2FXSOlEzz7gtgzwgysoidHM+p/ov4HizfXtY7fvjwfA==
X-Received: by 2002:a62:5c47:: with SMTP id q68mr66933851pfb.205.1564858091413; 
 Sat, 03 Aug 2019 11:48:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:33 -0700
Message-Id: <20190803184800.8221-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 07/34] target/arm: Enable HCR_E2H for VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
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
index e6a76d14c6..e37008a4f7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1366,13 +1366,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
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
index 65e3ffbb43..9a18ecf8f6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4623,7 +4623,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t valid_mask = HCR_MASK;
+    /* Begin with bits defined in base ARMv8.0.  */
+    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4637,6 +4638,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
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


