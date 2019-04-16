Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B64C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E325A20675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCxrSCP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E325A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNmc-0002OR-49
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:05:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf8-0004cs-Mb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf6-0001Bk-Oy
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf6-00017t-Ea
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id y7so26892221wrn.11
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=FJePOyZA9Q3WiPn2k7ahGOza/ZX3bYrlq3y5WZmHrm8=;
	b=UCxrSCP0eboG54fxzgq65yS18UP31ZSBcboUV8nMm2G9k2XUGj7s8gq9Q9NtIjzq94
	4DCyBggg0BKfLwtJFNiytIcIuhBN+7Rpjt5svYgPHLJqJtl8AWp8R4pWsVDqP2w38SXq
	ua9Rufc8OiECFQwTH3mMmxMZYvqWPDku/ryXgWbW1SnT0ptgP9jkNHmt+w9SO/oQ9gRp
	wQ1cmyQLhOBE4pE31iNmPscs4Z5j4nawFqSHRXgg14IYjmYVwK3agPBCet0ZkO7HhFSL
	68WucII1TcFTeLuzaB36FkvCzBfvVYuSeDSFCTHYfbmfAOjp2MPI6dMABPlCEJwgVo9g
	ByYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FJePOyZA9Q3WiPn2k7ahGOza/ZX3bYrlq3y5WZmHrm8=;
	b=nRL0UCOD8xbNPO4LE70pvy3brksSwOU2ZKWQrADY6q7IhgNqKhHT2MAZHDp4s1Lez+
	gpQW/kL8NsRW0QvYcAJ7wMoAZ9PeW4r3vpfk4LjOp/v+O2iL6RZcxGCxsOnjqqrH01IJ
	JgKNmgier7RroqLrP4y2FEpaOzDOPIGKJMuK6SFUMoD0XerHDhFnCKR+CFPNXrvegeNw
	xyVGsDC+K9VpB5qXekLm5csuJsExjf9s3oxwZ+0JtfgXGpVoF99p8uhLvf5OReWfiM5D
	n8t6ul9LqR5Kwn4ZsyKEeI2l5t3Bj4b9ku+QVA63KviIf7U0GNiaZDfKYABjU/hBGk7u
	iFlw==
X-Gm-Message-State: APjAAAVrUzjwMDKtAnsPY/pn5uPGs6O9hLksuZMVx6jqtol+fgkk3cHI
	8l3RHhdh0nTswZG876c3n+Np1Q==
X-Google-Smtp-Source: APXvYqw9l4wnEmEtIMaZZC/0sVVLC8/pgvpe2hqJK05P9azhdTK9PxwD+fTc47rGerYAw6xKNNJUQw==
X-Received: by 2002:adf:e951:: with SMTP id m17mr42025658wrn.287.1555419482909;
	Tue, 16 Apr 2019 05:58:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:26 +0100
Message-Id: <20190416125744.27770-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 08/26] target/arm: Handle SFPA and FPCA bits in
 reads and writes of CONTROL
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
Message-ID: <20190416125726.ztGu4pUkV0Mcxc_SskrZudPLM7EnnjC_IJdsrhfAW5w@z>

The M-profile CONTROL register has two bits -- SFPA and FPCA --
which relate to floating-point support, and should be RES0 otherwise.
Handle them correctly in the MSR/MRS register access code.
Neither is banked between security states, so they are stored
in v7m.control[M_REG_S] regardless of current security state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 57 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b4f1609a1c6..297eb38fef0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12032,7 +12032,14 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return xpsr_read(env) & mask;
         break;
     case 20: /* CONTROL */
-        return env->v7m.control[env->v7m.secure];
+    {
+        uint32_t value = env->v7m.control[env->v7m.secure];
+        if (!env->v7m.secure) {
+            /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S bank */
+            value |= env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK;
+        }
+        return value;
+    }
     case 0x94: /* CONTROL_NS */
         /* We have to handle this here because unprivileged Secure code
          * can read the NS CONTROL register.
@@ -12040,7 +12047,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         if (!env->v7m.secure) {
             return 0;
         }
-        return env->v7m.control[M_REG_NS];
+        return env->v7m.control[M_REG_NS] |
+            (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK);
     }
 
     if (el == 0) {
@@ -12146,9 +12154,13 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
      */
     uint32_t mask = extract32(maskreg, 8, 4);
     uint32_t reg = extract32(maskreg, 0, 8);
+    int cur_el = arm_current_el(env);
 
-    if (arm_current_el(env) == 0 && reg > 7) {
-        /* only xPSR sub-fields may be written by unprivileged */
+    if (cur_el == 0 && reg > 7 && reg != 20) {
+        /*
+         * only xPSR sub-fields and CONTROL.SFPA may be written by
+         * unprivileged code
+         */
         return;
     }
 
@@ -12207,6 +12219,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                 env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
                 env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
             }
+            /*
+             * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 == 0,
+             * RES0 if the FPU is not present, and is stored in the S bank
+             */
+            if (arm_feature(env, ARM_FEATURE_VFP) &&
+                extract32(env->v7m.nsacr, 10, 1)) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
+            }
             return;
         case 0x98: /* SP_NS */
         {
@@ -12309,21 +12330,41 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         env->v7m.faultmask[env->v7m.secure] = val & 1;
         break;
     case 20: /* CONTROL */
-        /* Writing to the SPSEL bit only has an effect if we are in
+        /*
+         * Writing to the SPSEL bit only has an effect if we are in
          * thread mode; other bits can be updated by any privileged code.
          * write_v7m_control_spsel() deals with updating the SPSEL bit in
          * env->v7m.control, so we only need update the others.
          * For v7M, we must just ignore explicit writes to SPSEL in handler
          * mode; for v8M the write is permitted but will have no effect.
+         * All these bits are writes-ignored from non-privileged code,
+         * except for SFPA.
          */
-        if (arm_feature(env, ARM_FEATURE_V8) ||
-            !arm_v7m_is_handler_mode(env)) {
+        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_V8) ||
+                           !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            /*
+             * SFPA is RAZ/WI from NS or if no FPU.
+             * FPCA is RO if NSACR.CP10 == 0, RES0 if the FPU is not present.
+             * Both are stored in the S bank.
+             */
+            if (env->v7m.secure) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_SFPA_MASK;
+            }
+            if (cur_el > 0 &&
+                (env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_SECURITY) ||
+                 extract32(env->v7m.nsacr, 10, 1))) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
+            }
+        }
         break;
     default:
     bad_reg:
-- 
2.20.1


