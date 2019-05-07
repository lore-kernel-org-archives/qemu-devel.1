Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED48C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1BA206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFkTd4+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1BA206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyrF-0002vL-8N
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:06:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylz-0007kU-TM
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylu-0003z3-W5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylu-0003yX-PX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f2so14778563wmj.3
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=upDb/oCermKTFkACDchj8gTFhCiWSrAdwy8aQAIaTNU=;
	b=RFkTd4+HINl2p1PF9S8NL/bhp0yu4IAOARxQHwLQoJo+ETIQOl9Tedzq4nYBtAANIq
	gtVrtuA5KUKaGRX/7NxndzUEeB2/uJtmTJHZk4UQLQN1jsD9KhgBJtjZ6bGLp0z6Y9iH
	VI0VSHXczFd3LhUGZnwgD+efOc7kFLBv4xf5h1q2a8DFP8+zVgKCZt7swAjcV/y2MA5V
	/bSD9dfp0jKzrLpJUgGvcGU9blCOKLfB8jFfVznHtIJf4BabvumE5ltnz7kranINr22z
	yDE5pUqLVL3QbvZGxWsGI+Kq0USikQC59Lo1IyDkTBfPVuTnwcvOTwsKgR1yh2R8xpUV
	TNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=upDb/oCermKTFkACDchj8gTFhCiWSrAdwy8aQAIaTNU=;
	b=gWiHz5eIOhuPwHMD5M6MuA8r4ZLdUevOE8hBTiSIifvGhY3/NKi+xzJY5vHvY+lTOr
	PgWVkDRrwWsIJILjmi4TxzbMMo3hsn+KKLpOPdqIwf6ErSCDwChriDG5j5o4Vwv90M8V
	EpUOvdi+3h5H1IpTjVSujAE9oMInTjzNKfKGWmwWZNuXqqrK9YbyXDofzOEvYeVTUz60
	ZXRxZuREAS1ecOC2SCJWvUPOI60DNRWSGoZy3nEBontnqUK2Suoz7LK053x+27uOq1JA
	ygTZHMSJPhv/5aq2FMCpGWjBZYGd+FK2x30OYoG5DgbpL3+PLGaoDjuzViJ5ea0diY/R
	ZkyQ==
X-Gm-Message-State: APjAAAWxClsnF3P5ywPXNtjF3jmebUwKvAIayYGE4s67SlC4Vqbz7FEH
	w7gEUGWEfMrxYqg4a96rxYMmipo+IT8=
X-Google-Smtp-Source: APXvYqx/QgGxv4busUonjI3JJWIO40s35oYBN3cPWmsZio3Zdimsl6VVZ2P+L34vEnMdHIXL2L3ZJw==
X-Received: by 2002:a1c:540e:: with SMTP id i14mr8545301wmb.129.1557230433439; 
	Tue, 07 May 2019 05:00:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.32
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:10 +0100
Message-Id: <20190507120011.18100-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 14/15] target/arm: Implement XPSR GE bits
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

In the M-profile architecture, if the CPU implements the DSP extension
then the XPSR has GE bits, in the same way as the A-profile CPSR. When
we added DSP extension support we forgot to add support for reading
and writing the GE bits, which are stored in env->GE. We did put in
the code to add XPSR_GE to the mask of bits to update in the v7m_msr
helper, but forgot it in v7m_mrs. We also must not allow the XPSR we
pull off the stack on exception return to set the nonexistent GE bits.
Correct these errors:
 * read and write env->GE in xpsr_read() and xpsr_write()
 * only set GE bits on exception return if DSP present
 * read GE bits for MRS if DSP present

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190430131439.25251-5-peter.maydell@linaro.org
---
 target/arm/cpu.h    |  4 ++++
 target/arm/helper.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0304ddd9f11..733b840a712 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1285,6 +1285,7 @@ static inline uint32_t xpsr_read(CPUARMState *env)
         | (env->CF << 29) | ((env->VF & 0x80000000) >> 3) | (env->QF << 27)
         | (env->thumb << 24) | ((env->condexec_bits & 3) << 25)
         | ((env->condexec_bits & 0xfc) << 8)
+        | (env->GE << 16)
         | env->v7m.exception;
 }
 
@@ -1300,6 +1301,9 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
     if (mask & XPSR_Q) {
         env->QF = ((val & XPSR_Q) != 0);
     }
+    if (mask & XPSR_GE) {
+        env->GE = (val & XPSR_GE) >> 16;
+    }
     if (mask & XPSR_T) {
         env->thumb = ((val & XPSR_T) != 0);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9b805d0e6bd..b9745a42bab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8727,7 +8727,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     uint32_t excret;
-    uint32_t xpsr;
+    uint32_t xpsr, xpsr_mask;
     bool ufault = false;
     bool sfault = false;
     bool return_to_sp_process;
@@ -9179,8 +9179,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         }
         *frame_sp_p = frameptr;
     }
+
+    xpsr_mask = ~(XPSR_SPREALIGN | XPSR_SFPA);
+    if (!arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
+        xpsr_mask &= ~XPSR_GE;
+    }
     /* This xpsr_write() will invalidate frame_sp_p as it may switch stack */
-    xpsr_write(env, xpsr, ~(XPSR_SPREALIGN | XPSR_SFPA));
+    xpsr_write(env, xpsr, xpsr_mask);
 
     if (env->v7m.secure) {
         bool sfpa = xpsr & XPSR_SFPA;
@@ -12665,6 +12670,9 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         }
         if (!(reg & 4)) {
             mask |= XPSR_NZCV | XPSR_Q; /* APSR */
+            if (arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
+                mask |= XPSR_GE;
+            }
         }
         /* EPSR reads as zero */
         return xpsr_read(env) & mask;
-- 
2.20.1


