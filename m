Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86BFC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FBB205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nreHzP/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FBB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixynL-0000F8-Mn
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySw-0007tL-2u
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySt-00075K-TB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:01 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySt-00074j-NU
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:59 -0500
Received: by mail-pf1-x444.google.com with SMTP id x185so5269819pfc.5
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=47cVy0hqEAMv3Vw0sowdk1lwNWBNZcow7HnX+kqWQog=;
 b=nreHzP/AL6DR+QP+b96GKwlhvgqj9Cxv8YbY130AkFx8l/14bTJPQu2yABTz613UQ+
 hDsb0my0hVLjHvjzZnwLDiI2DEIYH5Z6RVaPigj7trciHU5P7yWotSH+NZFCgtQ4D8f5
 X5oAkl8IkSB3y4cNAWwbfWX9dnK+MuEYsCEY4bqq9G89N3GFOPV+KOSHpiRYTOLkYerM
 D/BJd8/tQnji1gog9Nw7+mt3teoidf9oti4HraBfloE6Qx1kD+phCfXqp/3rTJwL9K7x
 FiPG8w3/GSMVe5JPQnimPvS80CzmMTFk6gUUPALnH6KTKwWQueaK5+x+mwApYrzcbYLE
 l5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=47cVy0hqEAMv3Vw0sowdk1lwNWBNZcow7HnX+kqWQog=;
 b=Zq4fDvoNUjB9O+jwldWNvc3uhaW2RzfPVHXO+jdnormEiEVfaITToqeZO0YQAryxYx
 EcG3cdx4PV2/Scuv5DUpnzPv2k+FXnD5oa9TbQEAQAcW4oHPc/jK+08Md6iGW60kT6O8
 WrPN/BNNgASSePCvHhNo2N82HPN/lNC5WN1mHZghQQj2+yXtB1Yfum5p3xIx06A1gOPE
 +Lsxo0oaAAiLL4MV9RjRsM5x1BobledS1pF58MGA/D/a6bM8sygEj5JKyfBcNhLEFcQA
 DbhHVjT0NcbFM7gF7oxSxm8hmDh6yzoJql6fbav/6RpnN4d/2uArHSsaxbwkq09FOJVl
 yb0w==
X-Gm-Message-State: APjAAAXpiovSpC/I9VnheyDAqD687amR0sSSGjWopq2oaRudjO9RYf+a
 ZdWv2IpESMCwbyDMZTNpfs+WCYbQeTs=
X-Google-Smtp-Source: APXvYqzsFRL3zkE+0/MBuOz9nOXHlBT/I9bqDq3pIHLNjKU3cOEh3iG3wDVLb+JTjxNKDhpYyXe5ag==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr17257231pfb.184.1580585398151; 
 Sat, 01 Feb 2020 11:29:58 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 34/41] target/arm: check TGE and E2H flags for EL0 pauth
 traps
Date: Sat,  1 Feb 2020 11:29:09 -0800
Message-Id: <20200201192916.31796-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from the EL1&0 regime.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index e0c401c4a9..9746e32bf8 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -371,7 +371,10 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
     if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         bool trap = !(hcr & HCR_API);
-        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        if (el == 0) {
+            /* Trap only applies to EL1&0 regime.  */
+            trap &= (hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE);
+        }
         /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
         if (trap) {
             pauth_trap(env, 2, ra);
-- 
2.20.1


