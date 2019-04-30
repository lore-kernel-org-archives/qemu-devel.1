Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D9C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C52205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsV1RfBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C52205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLSfL-0004Yc-KA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 09:19:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSau-00012m-OF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSat-0002Du-Mg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSat-0002DG-GG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id s15so20931621wra.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=KjnNslhjeAVB43ev2plnZmB2mvGNvdHo3ozswBo1758=;
	b=HsV1RfBXMD1XBjZGomeprBuZWd2xYzlQWf1PoS+CplVCmcJVGdNJSYodcPJRrXcKgf
	pzinhIMtpePedJDmTHjGn1qOG4fjlqH3J80si0jFhzjZFwsxISkHEfuVjHIED4p9wLL+
	qOtg5Q0mvkVe0ji8YcKen1yDA73rJ8wGPIbilXpYbdMzuN1sM81cAIm57FKq0VlIHqmF
	sTGY1Rbr33CbktlWwjbnmrTZ+qtu5a4hvtf1QpQpWM76nQrvMnGJ2u7/pyV36Jvr6rsC
	ECubcTtARpa7NwZvN7rjAnqzO6dGcA8hfXe/Itd3gyrOQOKHdgbJzR/xnjYzMPDIZdOl
	QLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KjnNslhjeAVB43ev2plnZmB2mvGNvdHo3ozswBo1758=;
	b=ChETVE3www5YvH0vy6MyxLTblPJQ4f0x/4EDfKFNq8XoBCl5S4JecgFGyzkqQBJbao
	iiZoBr4wslQZH1anWy2wiwENgGpqXr+L0/WVeFePdKpCDCjqmLKVdERIpRLKrT1PhZqi
	YBaKYVQrzotwJY7i7VH486AoMTmN4+VRvPUZWwDefTV8869+vMQMayVktMLphvnQVDiw
	umSWPhkSdI/9ixeumbLXOg/O26W/Xl5XqBz2xOzm6h0iz7hIXyvsnOmNJ7lGg0b+7KTM
	FjbzRMcPFTcaRPz51LrT7Qh3T3j9AWUDwcutOFIEY5rp3s5w/qrd+xsz84w0u8i3MR/A
	yixg==
X-Gm-Message-State: APjAAAUr4WtQKVFsAj4wlfv4n/Rf48bTTJBdDIQCAGMl2AoDTr3MPBfp
	6avzlO1qv+9iGDdK+jMxvZJ5ixpLwi0=
X-Google-Smtp-Source: APXvYqx7GCssL3ndoRJwFTkznx94O0Hd0b8TH9R2xj8TNLUOGtt1aD56J+DCau0hIWGSb+44JBbJ6Q==
X-Received: by 2002:a05:6000:11ce:: with SMTP id
	i14mr16693110wrx.37.1556630086557; 
	Tue, 30 Apr 2019 06:14:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	a12sm16557460wrh.46.2019.04.30.06.14.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 06:14:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 14:14:39 +0100
Message-Id: <20190430131439.25251-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Implement XPSR GE bits
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
Message-ID: <20190430131439.P0KnQMPW-NWCjs5u01waEUy1aSPawGhyT2t_aaDsIjk@z>

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
---
 target/arm/cpu.h    |  4 ++++
 target/arm/helper.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 22bc6e00ab9..2ae1b36eaee 100644
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
index 81a92ab4911..59ee5ee7c4a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8704,7 +8704,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     uint32_t excret;
-    uint32_t xpsr;
+    uint32_t xpsr, xpsr_mask;
     bool ufault = false;
     bool sfault = false;
     bool return_to_sp_process;
@@ -9156,8 +9156,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -12642,6 +12647,9 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
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


