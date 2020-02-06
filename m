Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA796C352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A2C20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPSRBJHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A2C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izepg-0004sj-RL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoB-0002nD-79
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoA-0006AK-5b
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeo9-00065a-Uy
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id s144so611871wme.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eznmV40028rpODdWwUUxQDx2BghUEVK7B/QLx5Y9Mw4=;
 b=KPSRBJHw4YE45hmPFVS3E7x9ZGqBcA5luo1dS2ICDFDRKnW8gC/UUw794/OE44/rWn
 x7+2jMVJxOGt699kgTjG2AEdQAYMANreZzUgfg2NqzqJAhfwnGZ4lK/miGmYA2MvULHe
 wzVkh5joSuPROYpHu5FoSAiXDYudN9wopVoOwKpb7HVMIi+Xz2eMl1cE0GS7HTmytNUm
 Qnv1cIaYXeTBNtrHt4MJjZesurD8j9TBlHK4ABEObhh4xbEYKgTQKEZcEsl+EyNNwPw8
 G/tqIrgd9Y9A5V7rad0kXF/QDpLTSypChQJ5BT3Br3FVRKGdwg7yRLoLsJRC8jyjoH+9
 qqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eznmV40028rpODdWwUUxQDx2BghUEVK7B/QLx5Y9Mw4=;
 b=EpRXWlvzmicTOvP2BudoO9kEhymdUTC3n/aR+zTFJuATscqrzYDW3NeXOrMQEDF5ZQ
 nqsH72vyIGKuUo0glc0z6I8X83AD08LUyaySj5q0mf6lyxc9N46Hj9ivglA7I04TZlJ5
 HCWralChmq+4JherDQxbXbCnKfy33mo8CnZSRcEf+Xnb5s0V2WvYhRAt0hwJIIj1BY8n
 NeVVzUpT8QcMrBM8v1O+sXjXABbGRMrAD2Hz0cZSyA3oUWYm6ech4c+eeo89cxBlghkm
 3Ca9F89WA7V9eizLKZX2Dhj6MFCOTszpfDhJ2vkx8a+1MBTuXBaVPpjCLahbKCdI0QOQ
 mZJg==
X-Gm-Message-State: APjAAAWnD3ci4DUHLbWOEjZP01G+fTvK0sPJtINtw2Ib4YhXZxCihaej
 1AQmBdbOVIiQexx1HDeU+j7BQH1WIM59hQ==
X-Google-Smtp-Source: APXvYqzd/6qY5+aXaCUBcxrzPPLT344Cuek8W6k9F+nMaqEeCdoQ9/95q+tgm8xzdcNNgDO+V9gTIw==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr4067507wmi.17.1580986492716; 
 Thu, 06 Feb 2020 02:54:52 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/41] target/arm: Add TTBR1_EL2
Date: Thu,  6 Feb 2020 10:54:11 +0000
Message-Id: <20200206105448.4726-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
A later patch will update any ASID therein.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Do not update TCR_EL2 yet; delay that til we handle ASIDs.
---
 target/arm/helper.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe7991864a..c7ee0d603f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3533,6 +3533,13 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
+    raw_write(env, ri, value);
+}
+
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -4979,7 +4986,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0,
+      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -6131,6 +6138,10 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
       .access = PL2_RW,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+    { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
+      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
     REGINFO_SENTINEL
 };
 
-- 
2.20.1


