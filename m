Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14360C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69A92082C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0Tta1dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69A92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvso-0004zE-5b
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvot-0007fL-Sv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvos-0000c6-Ab
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvos-0000aU-2Q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so334765wms.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LNjb5yrrFswq3SqrrRYoa3Pq5hhZDJpEtuJq5Ac2UUo=;
 b=L0Tta1ddmSY+YQEB2MqxK8JDGmEjkUT+lARjCwnec/e7kSpPb8JhVY9XrFna+9ianz
 9h5BRAhjTZTp6FJasiQZrZODumkKIAAivhk8JgKzUEU33Pq3SuDjYPj3MpsI70n2RZV7
 tuUr4B5dJ/O2KqvAfWBD2K/P29Mn+mrLXz9sHWQfOzaRPkpVZD1I1miyaWRFaJC3o2Fq
 kebY3F/ZSZ3utPOEKiBMOaJlO4yTNB+Zwbeyd8/AsX3CPAZhqruXnZsY+0Np5Bf9WvlJ
 ABj9524FDxLe1tujOqKKnoBo2vL+GO1lqb03m05FbMTNq42OYyiBAeRzbN9LiDp+okn9
 KfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LNjb5yrrFswq3SqrrRYoa3Pq5hhZDJpEtuJq5Ac2UUo=;
 b=soOyx+JROkiLO6RdXa9D8tSCIuv09EdalesoqQ4huVjDz79NynBtSb1zwiK7C0cI2n
 mC4j7QR/upNdE29/26SDcaptCGxtoD/+pHtb9sn0r1lrKGNIDKt69NKbLnrQ/hT2n+z7
 1uYJF+cS/BGD/7pfyknseB+kcbKVFEUuGlkTAT6rcq1tIpzfuAZ8a/+M4R0B7f/S6C6J
 ZJl8yeFmt5QarkRoVGZPYK3/cqccTBakl/1ZA3n41WtDj+3fIbhzD00G3KQ2UKheiTTV
 q0he+nraqxZW+tNDCnNV5Oo4faJ7XUIdy5zjmZ3te7b6H70ZP091RrvLMH9BD3a4Cwqx
 xdqg==
X-Gm-Message-State: APjAAAVfcXSJkp3VE0PDUVek9TqsVlWc1cFvO0e4LbEMZY+DsXj6ZWsD
 Wqyc7PaEtnIDAJ6L68SVcqCgNw==
X-Google-Smtp-Source: APXvYqxVh+nNJymVMzwFh/XQlm1nY2yzrn3jjAjlxqEbxrh7DYegQhlLCvcKBojw3sma7qtgI0yIEA==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr18733039wme.56.1560794001023; 
 Mon, 17 Jun 2019 10:53:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:12 +0100
Message-Id: <20190617175317.27557-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175317.27557-1-peter.maydell@linaro.org>
References: <20190617175317.27557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 1/6] target/arm: NS BusFault on vector table
 fetch escalates to NS HardFault
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

In the M-profile architecture, when we do a vector table fetch and it
fails, we need to report a HardFault.  Whether this is a Secure HF or
a NonSecure HF depends on several things.  If AIRCR.BFHFNMINS is 0
then HF is always Secure, because there is no NonSecure HardFault.
Otherwise, the answer depends on whether the 'underlying exception'
(MemManage, BusFault, SecureFault) targets Secure or NonSecure.  (In
the pseudocode, this is handled in the Vector() function: the final
exc.isSecure is calculated by looking at the exc.isSecure from the
exception returned from the memory access, not the isSecure input
argument.)

We weren't doing this correctly, because we were looking at
the target security domain of the exception we were trying to
load the vector table entry for. This produces errors of two kinds:
 * a load from the NS vector table which hits the "NS access
   to S memory" SecureFault should end up as a Secure HardFault,
   but we were raising an NS HardFault
 * a load from the S vector table which causes a BusFault
   should raise an NS HardFault if BFHFNMINS == 1 (because
   in that case all BusFaults are NonSecure), but we were raising
   a Secure HardFault

Correct the logic.

We also fix a comment error where we claimed that we might
be escalating MemManage to HardFault, and forgot about SecureFault.
(Vector loads can never hit MPU access faults, because they're
always aligned and always use the default address map.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index df4276f5f6c..375249d3c72 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8225,7 +8225,11 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
         if (sattrs.ns) {
             attrs.secure = false;
         } else if (!targets_secure) {
-            /* NS access to S memory */
+            /*
+             * NS access to S memory: the underlying exception which we escalate
+             * to HardFault is SecureFault, which always targets Secure.
+             */
+            exc_secure = true;
             goto load_fail;
         }
     }
@@ -8233,21 +8237,31 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
     vector_entry = address_space_ldl(arm_addressspace(cs, attrs), addr,
                                      attrs, &result);
     if (result != MEMTX_OK) {
+        /*
+         * Underlying exception is BusFault: its target security state
+         * depends on BFHFNMINS.
+         */
+        exc_secure = !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
         goto load_fail;
     }
     *pvec = vector_entry;
     return true;
 
 load_fail:
-    /* All vector table fetch fails are reported as HardFault, with
+    /*
+     * All vector table fetch fails are reported as HardFault, with
      * HFSR.VECTTBL and .FORCED set. (FORCED is set because
-     * technically the underlying exception is a MemManage or BusFault
+     * technically the underlying exception is a SecureFault or BusFault
      * that is escalated to HardFault.) This is a terminal exception,
      * so we will either take the HardFault immediately or else enter
      * lockup (the latter case is handled in armv7m_nvic_set_pending_derived()).
+     * The HardFault is Secure if BFHFNMINS is 0 (meaning that all HFs are
+     * secure); otherwise it targets the same security state as the
+     * underlying exception.
      */
-    exc_secure = targets_secure ||
-        !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
+    if (!(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+        exc_secure = false;
+    }
     env->v7m.hfsr |= R_V7M_HFSR_VECTTBL_MASK | R_V7M_HFSR_FORCED_MASK;
     armv7m_nvic_set_pending_derived(env->nvic, ARMV7M_EXCP_HARD, exc_secure);
     return false;
-- 
2.20.1


