Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E280C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C52620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vflkItrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C52620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eg7-0006bu-Jr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edP-0002Ha-V1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edO-0004Rg-Rc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:43 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6edO-0004QB-Ln
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:42 -0500
Received: by mail-pl1-x641.google.com with SMTP id q4so115842pls.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rCn9KEM9PXXgFtnK73d+AiT9YkDrEQbzS/XrB8FG7Ao=;
 b=vflkItrc76uuDrQG3Tf30j6zvOA2ZxcI4pATWtQjVFikv4q0rLhi8sBYziu61Y94qB
 fxVX/1YjWKKC/HyHcHNrkNIKRJunZhg1UBLl+iKbIlO/wj3Z50cPEg6NKtb3xEmfT037
 mGWtSkJ+UgIEzQPAKyEcUG3VbTAIf7GmclcE1T2rHOPEo2USHMWF/cfglm/S/9N7kbLN
 EsqW6f0FGbsDdpRigVoB2XEMwRiX/wsX8VMLBnPM5oqJP75NYGrxjYhTjmuhAZ+VRvf+
 crW6Jvu6TCux6c1xO83lE5UzAdzwZTQmkKG0D4LXPP7BJs8xVpxm2WsXk26X3HWJJ2uQ
 Heyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rCn9KEM9PXXgFtnK73d+AiT9YkDrEQbzS/XrB8FG7Ao=;
 b=hVZD9RKIwY+RdAtnrcZmh1f44JaFGgar98z83C5h0avrNsIZMIjgCoZNb0CrM4QqKv
 wcI8u1mRUlpBWakl9tGWeVfzpf8/ZLl+IlzElK1t3RR2YvEiVdNgdF+h524hoRR5rnpI
 WBfxb3FsCpioje4XxXU9tMOj0wErTyLWXNDmD4E+SuCx0Sr4Hxr5tSl7UV0uh+OqyVTP
 gdk3TWkdsBWVAdrnmMD0eE1aCr6l2uN7sDTrMoEziPdFDno9vbXVfnsLRG19M6q0UTJn
 w8ciU/YMj+MY77I9AucUCDrt0i7AtBQ+OEuY0k7GiwtAFw0FAKED23+atREsE14Lvxro
 tYkw==
X-Gm-Message-State: APjAAAWAZEO28OZ8qaCJU8Xs9s+YUXJglaRVlmviljEytsqun4Bmdj+L
 KkrQ+zFX6c/Z2Acv+cscIYMMTJAgpSA=
X-Google-Smtp-Source: APXvYqyI3pF//CtmJBrjeEBzqu2S+F9FgGk5b5PwPGE1xkC6/TVfcmY3RrII2EfKZnGw0/+3RthPmA==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id
 a15mr248731pjo.86.1582654121046; 
 Tue, 25 Feb 2020 10:08:41 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id d69sm19069704pfd.72.2020.02.25.10.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:08:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] target/arm: Honor the HCR_EL2.TACR bit
Date: Tue, 25 Feb 2020 10:08:28 -0800
Message-Id: <20200225180831.26078-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225180831.26078-1-richard.henderson@linaro.org>
References: <20200225180831.26078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bit traps EL1 access to the auxiliary control registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ea42e0d26d..5cb7844f3f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -553,6 +553,16 @@ static CPAccessResult access_tsw(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TACR.  */
+static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TACR)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -6924,8 +6934,8 @@ static const ARMCPRegInfo ats1cp_reginfo[] = {
 static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
     { .name = "ACTLR2", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 3,
-      .access = PL1_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tacr,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
       .access = PL2_RW, .type = ARM_CP_CONST,
@@ -7681,8 +7691,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo auxcr_reginfo[] = {
             { .name = "ACTLR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 1,
-              .access = PL1_RW, .type = ARM_CP_CONST,
-              .resetvalue = cpu->reset_auxcr },
+              .access = PL1_RW, .accessfn = access_tacr,
+              .type = ARM_CP_CONST, .resetvalue = cpu->reset_auxcr },
             { .name = "ACTLR_EL2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL2_RW, .type = ARM_CP_CONST,
-- 
2.20.1


