Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AEBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D029C206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgKrDRGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D029C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxRY-0004l3-0Y
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCi-0004VU-CP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCc-0000Fd-Fn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:03 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCc-0000Eh-A8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:58 -0500
Received: by mail-pl1-x644.google.com with SMTP id p11so585731plq.10
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ZSqexQ7leS5PSUdHsU+Z61duescKn/V5EdZf5KtzFU=;
 b=TgKrDRGDBVMCkzdWLqeWvITlqD7OFvKKy/GQaHDX29UMnVotAYrkNOlD283l9u2TvI
 P+u81zJ0ifBh1FxOphbrBPgQ5jzqJvr0Yk6YTXWupXoKEwtkjGqN65Gc3ujwq3JGmdgz
 x6Xz5lCB6F8DknpjOwIJ8NnoZvIeVPd54YMXmCk3H8NEmbAMSbhTTgBqK3W9E0qEwmU5
 vDxse3nF473rhHH9hly5kHIXjG48V2rHNDBI3gTEL77SKRSSyWbl2bp+oLcLt6HzW6dH
 sdVR1rlRYPvcz/34xBepQMjAaNPb/GBWvKKSUxks9fBzhSA3iSf7hlJY+CgXhzP04syc
 R98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ZSqexQ7leS5PSUdHsU+Z61duescKn/V5EdZf5KtzFU=;
 b=KSs5oMewbeFQdt5uXps8rfYC/dIhZ8P3YFw91W+7Rdapi/Ez9dGEfjiW7Nio65ieab
 e48p9PYeug24Yk3E2VfEsE7yb+Av96BEva2YolriPtcd5tfkNsFfB2O9GrZTSvOQbHHJ
 jkLWgi2D/3BJ8virZcIRp+/FGOz7gFIeLzp3mi00xYtmnDI1eS4WxEjVSGAxWTXuQujC
 dukEZ9Hsq43qzEMvDPG989gw3UHzRdq0+MRcwQ9QrE0pihwRNSBr5+583xgqJvPR2ZlG
 In27EefpP76UXO9eWFP9GHgrPxAlpvaM/3/y6KKCyzqHjSAVQztfe8NEVoLMIhepRqJG
 b1Ww==
X-Gm-Message-State: APjAAAXRJB6bqBTSpegZdqJv7e9ZWejcE9T0t+skBOGTT42bwyM5KdUq
 nNiUe/bxLcQ/xQibbkF3IgEve8Ar+Xw=
X-Google-Smtp-Source: APXvYqzdS3qP9zugG4jgTVsd5+0SICMU13/w9VToQJvrfo04MLHEQWwm8IQBBf7xNeBt/qY2v3ggNg==
X-Received: by 2002:a17:90a:1785:: with SMTP id
 q5mr2527054pja.143.1580342217024; 
 Wed, 29 Jan 2020 15:56:57 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 32/41] target/arm: Update arm_phys_excp_target_el for TGE
Date: Wed, 29 Jan 2020 15:56:05 -0800
Message-Id: <20200129235614.29829-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

The TGE bit routes all asynchronous exceptions to EL2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9b12ff0ef0..0c1414acae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8465,6 +8465,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
+    /*
+     * For these purposes, TGE and AMO/IMO/FMO both force the
+     * interrupt to EL2.  Fold TGE into the bit extracted above.
+     */
+    hcr |= (hcr_el2 & HCR_TGE) != 0;
+
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.20.1


