Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A43C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9364E20716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTPLwx8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9364E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxIE-0004Lc-Lq
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCI-0003p9-EZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCH-0007e2-DN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:38 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCH-0007aE-75
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:37 -0500
Received: by mail-pl1-x642.google.com with SMTP id d9so583406plo.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LeDolfSi5Vjl2C4cW823Vc6DsS16GoB8z85mdd7RN0c=;
 b=WTPLwx8k6slnkJZD8obFNswh9IKR5Ouj1qlPJ2jq2CgbJ/GMtOCtXLl/K9Nla32aD/
 RsSj9OAulkkcKPaLPGuvIZhwv/omcBhBRB7dfXUfVDQ2W0vmdudSqJv5GnD1/2jMBoT2
 8yyDsV9ArXitnHgrBiznLhPM/Ax2J8vCHBtL/2woOPAEfLzpKTAi/ytUFK9ITUDBatZz
 fPOhn880VdaYVCoavKzgoOnoESVJlrdsk5eccvQ+jAXX/OyuvmcsRZtbgixtwE9AuwHF
 EGHHpUlfaRgfHBH2l4z7ekncS6L+6uwZsgu4iSBK/LC+Z/ZxC8Eyt0HtFOqBPDsHpvGd
 1EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LeDolfSi5Vjl2C4cW823Vc6DsS16GoB8z85mdd7RN0c=;
 b=IvdnHStB3tiW1HaX8X3PTalYX/Bt/j4pDPNwCpd6RgDCVdI5UVjAqh805PQtrPNbhn
 a/4pyjSjxRVyrQ+7Iqju7TUfoiw+iJDa/z/ZF6QqJbiADy5T7zOcD0MMFDzULvk89nzt
 ZiOZnYBvXvFhTK4VlHYwh8jNDD/FQcuksBLiptOO+0DK49N2OaQyNgB/39JOVY0f0p4R
 l+pGaMtOG3Qp1qLfdFFETGa4KOvci5ricHIQAg/EZTzZioxd0FkLSUc8+jTL/4zOcyph
 o2A9BGjosdDuloa61vFYiCTRtGkzZKSWHi2az+ylVA+sv9cIfEAoxwAN6BDbw0qF6pQw
 4uHg==
X-Gm-Message-State: APjAAAXGSnpNpO81NuBlQU1tAPeana4Ug0sFdzkKk9fUENr/rugYell+
 XrCzhBLXw+LKbNxaZcArWQuVis8cFq0=
X-Google-Smtp-Source: APXvYqyhtWSyvyNSkDi24DNxVNqe5U3ZYr/YH8lXHwG9MvP8MdhAKfbEWZqzPDXlRZFL1cqbFdNFfA==
X-Received: by 2002:a17:902:b215:: with SMTP id
 t21mr1940163plr.190.1580342195952; 
 Wed, 29 Jan 2020 15:56:35 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/41] target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
Date: Wed, 29 Jan 2020 15:55:49 -0800
Message-Id: <20200129235614.29829-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

We are about to expand the number of mmuidx to 10, and so need 4 bits.
For the benefit of reading the number out of -d exec, align it to the
penultimate nibble.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 11f54556c9..893b1f1918 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3207,7 +3207,7 @@ typedef ARMCPU ArchCPU;
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
  *
- *  31          21    18    14          9              0
+ *  31          20    18    14          9              0
  * +--------------+-----+-----+----------+--------------+
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
@@ -3215,19 +3215,19 @@ typedef ARMCPU ArchCPU;
  * |              |           +-------------------------|
  * |              |           |       TBFLAG_A64        |
  * +--------------+-----------+-------------------------+
- *  31          21          14                         0
+ *  31          20          14                         0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
 FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
-FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
-FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
-FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
+FIELD(TBFLAG_ANY, SS_ACTIVE, 30, 1)
+FIELD(TBFLAG_ANY, PSTATE_SS, 29, 1)     /* Not cached. */
+FIELD(TBFLAG_ANY, BE_DATA, 28, 1)
+FIELD(TBFLAG_ANY, MMUIDX, 24, 4)
 /* Target EL if we take a floating-point-disabled exception */
-FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
-FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+FIELD(TBFLAG_ANY, FPEXC_EL, 22, 2)
 /* For A-profile only, target EL for debug exceptions.  */
-FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
+FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 20, 2)
 
 /*
  * Bit usage when in AArch32 state, both A- and M-profile.
-- 
2.20.1


