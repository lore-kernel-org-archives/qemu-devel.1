Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E42C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0AF20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIqpCsoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0AF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G6g-0004XB-Fl
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgy-0004PX-Ga
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgx-0001tm-Be
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgx-0001rd-3C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id r11so6955866wrq.10
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9tFGVjt/GzRfWPBxkYgLYTC/HKT0pYq/v3Uvgjdh4bY=;
 b=uIqpCsoDSFdkQayU1x2GtBIFGQRt9/4V1wxrfmdz8r6qRzPyrfp8SAvaHhDP8e0HCi
 3g7kAZW6KkiRvqo9BG7Bxqp2gxjAAYqYtLliZFBNecsaupymtrQWIsBlbPo+JhZEfA1+
 WBq4AjvNhVSLhv6UtUZM8RyiJ+uKz6Z0QsfoP9rOoMUyKoEW5XwYpMw4s4pIWRTCmxkB
 74pFnwfRxyQsZ7yD0WJUwjVPEbH8MovdnqRxpWoTWMSUZ3p3kfqmmmo9qXulha3XvbOV
 gpa+9HCZkVhq6duazP2szy5LCDxAQ2PVbVrPCktnrmuw/IzveMUPyQ4RVdT90iXpcaiJ
 x2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9tFGVjt/GzRfWPBxkYgLYTC/HKT0pYq/v3Uvgjdh4bY=;
 b=LkEwlJQzlIkArm0SzjGYnps55f5EGRV5qJUI99Z4dtSlH1eFBUJN5QCvGjbtYFaKmc
 mIX36I8nCmfE+4+fbHxGvjNxas3FEWLbbGm1ItxIEDAQw9VCZ4L4j66YuxfU2WexPWsa
 6Hwv0EfboRAfvvttrj+7D/t3dd3FH6Bag360lpcFpq4ulj/99TwBcw0OuMfIYk1DLef3
 4yw7/vOciKJ4LfopGQbSNHf0V6Mjer9OlQDZ56HMljm9ZTHTzca7pEqBF8q78l2oDXLh
 2d55ONl5izSFFjKRtsM/Vgt1S1Jwcnskp065PiLDnJ5eLrj3/e+clIlSpElbVS8ZqFaH
 MG4w==
X-Gm-Message-State: APjAAAVlI1oePs1vbFo0fffm4cXcQdR2tuRW5dkZEePjBehjAketqBEV
 PmNtav+tsKJ2yLG8szSy6gSknuBN1EQ=
X-Google-Smtp-Source: APXvYqyUUf9BVIgTUhscSck7207Bsb5wxH5MAC75aca1w2a/7usbaZzDM5FTD3pMlAN6GQPCcdJMGg==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr24014325wrw.60.1581604929740; 
 Thu, 13 Feb 2020 06:42:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/46] target/arm: Remove CPSR_RESERVED
Date: Thu, 13 Feb 2020 14:41:17 +0000
Message-Id: <20200213144145.818-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

The only remaining use was in op_helper.c.  Use PSTATE_SS
directly, and move the commentary so that it is more obvious
what is going on.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200208125816.14954-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 6 ------
 target/arm/op_helper.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 694b0742983..c6dff1d55b6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1186,12 +1186,6 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_IT_2_7 (0xfc00U)
 #define CPSR_GE (0xfU << 16)
 #define CPSR_IL (1U << 20)
-/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
- * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
- * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch32,
- * where it is live state but not accessible to the AArch32 code.
- */
-#define CPSR_RESERVED (0x7U << 21)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index acf1815ea3e..af3020b78f8 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -387,7 +387,14 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
 
 uint32_t HELPER(cpsr_read)(CPUARMState *env)
 {
-    return cpsr_read(env) & ~(CPSR_EXEC | CPSR_RESERVED);
+    /*
+     * We store the ARMv8 PSTATE.SS bit in env->uncached_cpsr.
+     * This is convenient for populating SPSR_ELx, but must be
+     * hidden from aarch32 mode, where it is not visible.
+     *
+     * TODO: ARMv8.4-DIT -- need to move SS somewhere else.
+     */
+    return cpsr_read(env) & ~(CPSR_EXEC | PSTATE_SS);
 }
 
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
-- 
2.20.1


