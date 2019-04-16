Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95C7C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A231920674
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HreNCUuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A231920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNsT-0007e1-Rp
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:11:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfJ-0004r8-PB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfI-0001M6-2A
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfH-0001Kz-Oi
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id h18so25327460wml.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=oKhQw5TgUN0CJPeTbE7gAN8kI/N1+VlPzRCCDtvAZtE=;
	b=HreNCUuvD0e5wQi79dWBWrQu3YZa7sNIr2l3kmLrc2xcNsq2h4683HclK6gO+ngrci
	JJCuYA9A+T3gDvIW5mvk/0YPo05OjNJPFsN30neivj+YJUQlyAaeqyvJ6x5QHcs/JA+Z
	mbwKJHL3UQ+lS5P3LS61SMqJtpC6sM3DxeS9KkXybVqskZjkVJ4vxMYljFnzXNS5wfSc
	e2fHGU4zj346ylL09uE5ZbVKuucmEf4ZIid7mtvQ2NSAi5qo9DHtONczqaqoDE5zLaoI
	glpWQUuAo2XasdZsXGjn+jq/KXlEbUCzgkNYNgjK415krxxnEYIjEFOJhAQP5hQ12jtE
	WZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oKhQw5TgUN0CJPeTbE7gAN8kI/N1+VlPzRCCDtvAZtE=;
	b=DVjwx+7CrrksnODN3sXmSDI0FgZo1Lvk+0QWqGP02CFBsKE5Wjn0DGcGu817dDfXGF
	HnyAlUKrIWlYjXaXbZU9H1xSPEksSmhV7MM24jgg/QCDey8Tz8epAQuqazwjvKAki70x
	ZbyrYrTX1lYSG8yqDf6Conw6qeV8bBSPSGSOoRe0LGtn//oC7baDHNBblq100uw84vxQ
	WwWRP/MtEa6qw2YriIrderWItWx9NBmbOX9vry9NxDIMhKQ6RHO1Qa8sbjvMWIODQxVX
	R18Cw/oY5B1PGQCGcZyNILItMLsBjukwmgSbnHHfmuenW7tL263/DZo7mB9s+f1LOtwh
	AYNA==
X-Gm-Message-State: APjAAAXkDd22i93gXAjGSZNiNg/VK/HTdk8xywVGAMJE+4mfT6tBt3q3
	czxvFQZwAAlRjzWu5nBz+JBPYQ==
X-Google-Smtp-Source: APXvYqwl95al5Y3LOtRhbHMoOQ56YCImnsEa1pPOHGSI6GwjogiYdO5Gdp59W8agAfVht11CsZdYyA==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr26600232wmc.51.1555419498715; 
	Tue, 16 Apr 2019 05:58:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:32 +0100
Message-Id: <20190416125744.27770-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PATCH 14/26] target/arm: Allow for floating point in
 callee stack integrity check
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125732.Q6ZFCSKLcPMpiTUeABj5AIRWKN_xpprM_B-XSbaEb_k@z>

The magic value pushed onto the callee stack as an integrity
check is different if floating point is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe8e78fe36d..2f6382a0b24 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7984,6 +7984,21 @@ load_fail:
     return false;
 }
 
+static uint32_t v7m_integrity_sig(CPUARMState *env, uint32_t lr)
+{
+    /*
+     * Return the integrity signature value for the callee-saves
+     * stack frame section. @lr is the exception return payload/LR value
+     * whose FType bit forms bit 0 of the signature if FP is present.
+     */
+    uint32_t sig = 0xfefa125a;
+
+    if (!arm_feature(env, ARM_FEATURE_VFP) || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
+        sig |= 1;
+    }
+    return sig;
+}
+
 static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                                   bool ignore_faults)
 {
@@ -7998,6 +8013,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     bool stacked_ok;
     uint32_t limit;
     bool want_psp;
+    uint32_t sig;
 
     if (dotailchain) {
         bool mode = lr & R_V7M_EXCRET_MODE_MASK;
@@ -8039,8 +8055,9 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     /* Write as much of the stack frame as we can. A write failure may
      * cause us to pend a derived exception.
      */
+    sig = v7m_integrity_sig(env, lr);
     stacked_ok =
-        v7m_stack_write(cpu, frameptr, 0xfefa125b, mmu_idx, ignore_faults) &&
+        v7m_stack_write(cpu, frameptr, sig, mmu_idx, ignore_faults) &&
         v7m_stack_write(cpu, frameptr + 0x8, env->regs[4], mmu_idx,
                         ignore_faults) &&
         v7m_stack_write(cpu, frameptr + 0xc, env->regs[5], mmu_idx,
@@ -8645,12 +8662,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         if (return_to_secure &&
             ((excret & R_V7M_EXCRET_ES_MASK) == 0 ||
              (excret & R_V7M_EXCRET_DCRS_MASK) == 0)) {
-            uint32_t expected_sig = 0xfefa125b;
             uint32_t actual_sig;
 
             pop_ok = v7m_stack_read(cpu, &actual_sig, frameptr, mmu_idx);
 
-            if (pop_ok && expected_sig != actual_sig) {
+            if (pop_ok && v7m_integrity_sig(env, excret) != actual_sig) {
                 /* Take a SecureFault on the current stack */
                 env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-- 
2.20.1


