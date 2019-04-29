Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA2C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9020020675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLskodHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9020020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9n1-00033G-RM
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:10:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eV-0004Wh-N8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eS-0006aN-4K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eK-0006RW-GN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p21so186918wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=LNk5BgsGn2MS4PJAKvZ63GneIJcCBb8awXqH/62zPxI=;
	b=lLskodHS+aoOfkWKD38C0roDblJkHi/RdukuFq2vlmfq48r2N40TwKRZgnclcoN3ID
	6HVMqwg4pGY4e73ceQ+FERdAiyzF4S5M7lboW5YqC4W/ikeEtl674k1jJfLRVqrUA+Mg
	XDkHWm9z6nMaZOcmFz9X3j6GVF8ihFiX3PvE4V6YlxfUxcC70A+/qEb7QIe1+gAl43zI
	QhkQW4RR7qtBLwUNd+3D8oDtvasDV49QpLUq5GbpC8UEYblOei/h1tc5rwDOHYcUXSSn
	E4hoCsEFmJSD7OFmj8M9Xz1rSx0s5NcvVjPUkyB8lI2lNG+OUb2KJ7fhVrN3L8RZBkzq
	sJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LNk5BgsGn2MS4PJAKvZ63GneIJcCBb8awXqH/62zPxI=;
	b=Mn5v2g+oWkYhVAUeKD+H7m0v12c6CeYE5AYLIQ+Yro1p9INg6+gqYgj8IoVy/3h2Rk
	CS0xOU8pVV5+r+HUwBmzzfB5/pS+Gg62HI3dO2h70XgNu8qHtGDWVas0nfAIxUueYb9L
	iSeIw3RmdNDsrTDD0WLE/V3NMTvygDpwvDa6dll9qIlNWNsaIc9I8Wzeitkz5UId+7WO
	UCxpOhZXJD8rEs+m+qH5cSns0pWf2L7K0+Bhi3xyxfsARdPM86/ZyyFOVPRYVp4dZ0Uo
	LXzwTy0/uwqSLsu3lvaU7W7N6U/kAodAW4IS3zN1SSEzdUvLULhR6II9Xzr4426E+suN
	6D6Q==
X-Gm-Message-State: APjAAAWJM5uTJ8Ojx4EiutzknGxX6yguzfqvn9a7FTLUhcV3/pXJZpYr
	QBhBpk6Ok6JPeKMff7xVnVcRv5MgMW0=
X-Google-Smtp-Source: APXvYqwOH2QNhUFXSsmZnz1V0Qpsl6XWpFY/4HerxeIeilWt3+Ln15hMkd7dAQ1Ghy8egJ7LQF+9cg==
X-Received: by 2002:a1c:4d04:: with SMTP id o4mr44261wmh.126.1556557254084;
	Mon, 29 Apr 2019 10:00:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.53
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:05 +0100
Message-Id: <20190429170030.11323-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 17/42] target/arm: Allow for floating point in
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
Message-ID: <20190429170005.qYMjj43V-lyK_78DEcXxSPom9-80R6rW0eRl_0OEhp0@z>

The magic value pushed onto the callee stack as an integrity
check is different if floating point is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-15-peter.maydell@linaro.org
---
 target/arm/helper.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index da0b6202400..c7b1a8d231d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7979,6 +7979,21 @@ load_fail:
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
@@ -7993,6 +8008,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     bool stacked_ok;
     uint32_t limit;
     bool want_psp;
+    uint32_t sig;
 
     if (dotailchain) {
         bool mode = lr & R_V7M_EXCRET_MODE_MASK;
@@ -8034,8 +8050,9 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
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
@@ -8640,12 +8657,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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


