Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2E6206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cgu4keC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2E6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxPT-0000jR-KO
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCU-0004BH-G2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCT-0008G4-E3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:50 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCQ-00080t-9K
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:49 -0500
Received: by mail-pf1-x442.google.com with SMTP id i6so511489pfc.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HjUXuNuvBc4fXgdi4ANi0ErXNoAiLv7hzhC90jxtiaE=;
 b=Cgu4keC0NsmHhsJt71MWgzLx0Pn3Ln+mYSdAWX09jmGpLkYixzTG7/9oBuY13QJ2XK
 sLDOCraVbk3KHODvVwHww4tDN6BvWSZElQE7vVj4dOhwmW7dxG6RtY/SJLfFRlPN3HQg
 BcFHJQ2jzEeOGqJscHncRs9b7N+Y5eVDbLUux1ne+giqS1sPAxbKd9Zz35sykudtGhVK
 ghZVU4FaJ+PglOEOTD0GVilew03VHivgY6YfXEdSw0aLqX97shXPcKiqzJgr1Keq8hZA
 CpbMCMIed7MOJcs4SdXqk9pBqjSBV0C7y5BBCqVTsBr/Rj2rw8kkLZqEeKLID8fXjUWW
 52zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HjUXuNuvBc4fXgdi4ANi0ErXNoAiLv7hzhC90jxtiaE=;
 b=HVFE6M1K2+DgpdsCv1DflG8tSu5reD/9jyMqmd1haNc4jiPbt/gwp5Q+Gj7Sws1PL6
 45cf0mSm7LBpZrQyOXyJ2genoRDJpWVKCxAo8nWCB9dtVjJh3xzXgZB+1ZS7sFOjYlea
 QY0llerBHSbDRM5J9le3NwcruNy7uuZIOSnyGn+4W4F/VBnxzCvu7pnOcyYtOBL1XpZz
 +dmiPWVq7MS3B94StDm2zCdEBC8n03OPzYxhM+5Xueh5BoS8RBmfujEAt+ah6yng1bU6
 aS/zHwPWPAk7dzbDpuEeTFiwBJExNkpQXVGKL7maQ8gr2I+Nk/bPNWmFj5dz+ViJItke
 sMoA==
X-Gm-Message-State: APjAAAW6xslJqq/9GveZAtj3l4mANgmBslknxHZs493i4rCiaWb8KAPn
 lmYJ8lBZxgzV3H0vOIFDDypqA/pP5l4=
X-Google-Smtp-Source: APXvYqyu1Fe/80hAep41GW74X3u0g40wzY/JQNkLiaxKlUY8N0NIevxiTsYcqDBk1WvfTyNcPwMnCw==
X-Received: by 2002:a63:778c:: with SMTP id s134mr1602805pgc.451.1580342202220; 
 Wed, 29 Jan 2020 15:56:42 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 21/41] target/arm: Update arm_mmu_idx for VHE
Date: Wed, 29 Jan 2020 15:55:54 -0800
Message-Id: <20200129235614.29829-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

Return the indexes for the EL2&0 regime when the appropriate bits
are set within HCR_EL2.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v4: Consistently check E2H & TGE & ELUsingAArch32(EL2).
    Do not apply TGE at EL2.
---
 target/arm/helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aba79db2a1..128a400011 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11317,12 +11317,16 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    /* See ARM pseudo-function ELIsInHost.  */
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
         if (arm_is_secure_below_el3(env)) {
             return ARMMMUIdx_SE10_0;
         }
+        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+            && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_0;
+        }
         return ARMMMUIdx_E10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
@@ -11330,8 +11334,11 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         }
         return ARMMMUIdx_E10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
+        /* Note that TGE does not apply at EL2.  */
+        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_2;
+        }
         return ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
-- 
2.20.1


