Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E4C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4214220661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdrCtHqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4214220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyWc-0003fd-7d
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySL-00071P-8c
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySK-0006R3-97
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:25 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySK-0006QR-3d
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:24 -0500
Received: by mail-pf1-x442.google.com with SMTP id s1so5255677pfh.10
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRIyxc7vWfkpiQTZE4LZxFudoV8Un+UW9c4R2EG99Mo=;
 b=RdrCtHqhyXLoNV8lhd1fezwRgu+MSYzV606AGW1HhpxIx1kqTBXs+EDCXWc0FnDeFl
 YdG5cFnjPJnWLpHTQH5Q6BOphZbkWGyv8dJoumgORbRnPSXZkkpnGk3UukiU0asM1NN7
 OhQZgvytEfu9E+dJ1p3JBlF8vZhQhqOKiQyBCdif7RWe5e5S2yOmW13/MDppNI/YCedP
 gH/2m5WmtDPjvDlOZnkG7UJ/qfJRtwvNf8rxCBlJ8bTYDNmdZc5yVWwGhJBGjYne59S8
 0kcdc4ly2p0Ei3WoFRntc+GwwsXMirMlgTb5TgqNkfaCpftFTWppEsjSY9i4OGlvsvCj
 vN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRIyxc7vWfkpiQTZE4LZxFudoV8Un+UW9c4R2EG99Mo=;
 b=Y8wtJH80m6h9oFgX5ZlWUPMQ5Qa0DhSH7lT8CEItscOr+jH9V2VXDavr7S4X7tY27W
 0Kc1VWy/hAxYcN7AxZS4mo4gEEc+F34bwN+HaYI1N9NSeEoLdPYf+nN9mbu7DJaO4I9p
 LLk6HZEWK3MgELN2RgsrLjKaS5qXNcBVF9Wq4ohTswVrzMtqCMBc4Cl1iwsQtyAAaKyk
 EnSi5D+54FhA2YtZdYConMKAy68EtqsJdWPpaKLrG+an1b/NZsq2O0xTzrJQDWfKfL0y
 8luNBifvqWZmVFlQZbfpOrIRdnRKTzQJCFfiy+RR74NUf8Q2/90WTD58hP+sCSKDVS1O
 ikSw==
X-Gm-Message-State: APjAAAVmd3lXszAlga5dkSmku9bseL+VpsmtfA1ri5cKeJVJ0UPsKdAE
 1mqMvW75J6XLT6/fQDb85Gcm+jISEBY=
X-Google-Smtp-Source: APXvYqye7hjN7Wf7OPUC93WbL5ZeNC2MSQPvbEd/jWp3CFkyXIfCa6rrwXKejoGsO0ymftPCNRcOyQ==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr16165481pfn.232.1580585362568; 
 Sat, 01 Feb 2020 11:29:22 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/41] target/arm: Add TTBR1_EL2
Date: Sat,  1 Feb 2020 11:28:39 -0800
Message-Id: <20200201192916.31796-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
A later patch will update any ASID therein.

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


