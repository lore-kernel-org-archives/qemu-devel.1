Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95265214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNz/25uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95265214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf4S-00016L-PG
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoh-0003Ul-R5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoe-00007d-6D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoc-0008PQ-9T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:22 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so5801354wmc.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YgnJTRdY4FfbIfCcdJNCBrzxflb5ZD/kYEjiNVohCOk=;
 b=LNz/25uqwE8uFYfAFGSTgr1c1rsC6CcaLEAQpBKvhC/s9OfHIKOXUfzFvk5w1KnomF
 5/lg7VJnFWcR1l9/rbPt+TrfWnS4/lGflaeAT25g2fem4IcfAd3mqXQb6fqQATmeimV2
 IgpdCrlA2KuQzQPzyUdC923yq+jaZY4XX17zRcox3rVhhStOH03RuI6xQxEI0yQNkkWm
 /0aKrsAXTsN81gR2dHNez0WLs4xif1FH7ld8suG6htOwskFyF3puA/BcDAq3UJHL1gS3
 7p+H67ApzbZE3wIFLR21+8bF5L66678Gp+TeMZm81Kc/uGI+PexT45YTUKKvx9eJsHZG
 H42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YgnJTRdY4FfbIfCcdJNCBrzxflb5ZD/kYEjiNVohCOk=;
 b=ADq6TujV5LZyvp+YnIQzcd8pmviAL4pmTwvT58a3St3N26lSolVk1oGol9SgABG7/2
 S+sY+R8HN0uhWUiZ/8Z29ce7g3/W0scCPFaATwdQr0X23XCXt6sLrPwSBsfZjp9j9Kj7
 iP1jN+0e1QDSkDa4m+OGPVCAe2BROTqAbvluj0UQZ/rwH2AeSN+2BPCORNJq7hvoKiWi
 hgC/lIjSgCxrKaPis3akNPO1AVr/1JrepArWVB4KokFLxs5C5yAHVsqySa3EmSTXQ9zc
 CtlQQIZrDkYPRp6YC3HEQ9TawsDdc5Dgg3LmHzBx25iX0l+COHqSurbOgojglLQSGQu8
 eOqg==
X-Gm-Message-State: APjAAAWKOS2KcOk7gjEg47q/048XV04Eo48rZS4CJfk0EidC2ZGt3rvA
 fpk+DlsGEJ9cKPnayWYXCCx1J9akg1AwLA==
X-Google-Smtp-Source: APXvYqwDRsRftz3GM+RbZsKFfrT0T5VlvHN/3Iw5wFjkCbqnFUeTxgROeb1+y+bytzgRR8ahNekt8w==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr3758679wmc.145.1580986520603; 
 Thu, 06 Feb 2020 02:55:20 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 36/41] target/arm: Update arm_cpu_do_interrupt_aarch64 for
 VHE
Date: Thu,  6 Feb 2020 10:54:43 +0000
Message-Id: <20200206105448.4726-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When VHE is enabled, the exception level below EL2 is not EL1,
but EL0, and so to identify the entry vector offset for exceptions
targeting EL2 we need to look at the width of EL0, not of EL1.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff2d957b7c..7d15d5c933 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9017,14 +9017,19 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * immediately lower than the target level is using AArch32 or AArch64
          */
         bool is_aa64;
+        uint64_t hcr;
 
         switch (new_el) {
         case 3:
             is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
             break;
         case 2:
-            is_aa64 = (env->cp15.hcr_el2 & HCR_RW) != 0;
-            break;
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+                is_aa64 = (hcr & HCR_RW) != 0;
+                break;
+            }
+            /* fall through */
         case 1:
             is_aa64 = is_a64(env);
             break;
-- 
2.20.1


