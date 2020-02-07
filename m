Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F5C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEC820720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v42MmWYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEC820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04ng-0003ep-9z
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hd-0008Bj-MG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hc-0002Md-IS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hc-0002K4-Bh
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so2926659wrd.9
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bwSjKwZXG2Y4ceRrzqVnC6VZZUFDFs7thXgtkHswvzI=;
 b=v42MmWYLxHNF+Y6o7H6JxpY99xDxptGjWe/YAuaknacWA1Ff/Sa/pKXg+8XPWe11Hz
 aAHkWInhpgKrWjUiNCdcaUExcO+SLp8ApgMk3fkiRng/YE+uKdHafTM1FAdFqqrOQ1VP
 GSRg+2Ot9jMMdBpri0H5Eq1NPUAdCJA1yS8E+Y4Bss4aGcWYjd7Jk018384oKT3Pwhc9
 zh118Lse3RIHO1UA7RJzLwYma/R2yloUQxpptmix4AQm2qrAQrfwyRgv0zpaoZluzwN1
 PUbx/oe8tLV/uVHp8WHNDUUqyuCpF4LmpGCtqqBaL5dLd84w2hGuNGA91h2aqkBmTWPk
 /gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bwSjKwZXG2Y4ceRrzqVnC6VZZUFDFs7thXgtkHswvzI=;
 b=nF8ssWBDw+WuAhMozylcM8S9VVAFjNcTkPpJYo798hkPUtV82irwqeH1os68+nQ9Vp
 iz1aHsJYmwlqCehoOuezULLCTuRu7FJ5A5FxdR/InvhUzErlqXRYfjZSkdY+px5zUAQE
 Bq+84Z57DkWKkW3VaYRIeL4XmDTQuLFZKmkwGgfIJtDyRmRnBLA2/svuDuVShpel4LUp
 0RyhgcnUw/2L+x03p5X7CyNZXbjhyEGdIBb0axkQTMpm4PfQVE+qAyRTdEmDbiucFa2S
 0jfBMo3wSpnNjs9ML9kjcGBpO1J8/kUrrTreVj6ZTPn41yh4Xm4I64N5VC9Ccjv0P7Yi
 lNKw==
X-Gm-Message-State: APjAAAUZ0Xfrgx8FgG5wMuBLgg7Q9++cksAFsuJGRUavARTQkSYf/JEa
 DA6aGAyewdNKHCb/lE3PkE8t4erCWV4=
X-Google-Smtp-Source: APXvYqyeT8XalQ3vAjjm75uHocQGEsrZiFR9Td/MpjuYPDwtX1V+1yp3asXzmv1XB7AglmExGhn6Vw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr5298708wrt.229.1581086031143; 
 Fri, 07 Feb 2020 06:33:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/48] target/arm: Add TTBR1_EL2
Date: Fri,  7 Feb 2020 14:33:00 +0000
Message-Id: <20200207143343.30322-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
A later patch will update any ASID therein.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe7991864a6..c7ee0d603f4 100644
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


