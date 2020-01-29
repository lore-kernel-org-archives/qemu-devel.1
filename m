Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47672C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6238206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd1HmgEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6238206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxWm-00051V-35
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCo-0004hq-Rq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCn-0000d9-Ox
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:10 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCn-0000aP-Ik
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:09 -0500
Received: by mail-pl1-x643.google.com with SMTP id d9so583902plo.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+IcLBVINlWFp15bwGPClMMXcW2UX7TXl5ScSRzLV8s8=;
 b=Sd1HmgEImCAPDy8h78uIk35Vaxeiaa4KHBkSf4wisaBIjRWQNfgP5fTH2vmu+18vVB
 mAhev6gG4KvT/4LuADmz0oAGLwNHvFmh+Y7TMl/dtJwTYBl3RLE7JTk8i72qS2qtr26h
 8uaCzWLSgjG3d3RJi9xNPPiUsLlkIRueuOpN/3FFSqIJVq4r8X9EMjmA4aN0vNTfmgi+
 C3n6BlBCQOzaiHdCBBXZ9/x+KxrrZqFQHjKyFU41wf23K8J5MoUCiPnCfuSvPgW6UMiu
 Ae1wNnld3tjxT8ZelQ4pEVNMSqUt0gzq3rWORZDvmBiIFXGb6tJnObyjwsalAaF/mePK
 NSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+IcLBVINlWFp15bwGPClMMXcW2UX7TXl5ScSRzLV8s8=;
 b=dtJN1V+GUejL1hKncWWuWAqw9udxlKUwJ5cQaPD0SH8MH7nMDub6xAJ1/D2UiOjgxO
 sDLhukr1/wx6R6KmUN4BL6u71STX22mk4Mwc/g6mqyCFZKpqooQxbUbZpNQqLaUItFGy
 4S402iAnNgydiB+uaMKlEFZsP9xa0PXagtRbI5sUmEXeFyrsreQY27XhI6BMVa9RGHIj
 vbHyLxeVJU/y2B2YQi81uI/84aO8w0fuO36HaTb96qjU1mfoaONxiJRoQuCCgZxo9CK4
 5WowR4i7zuSe7c8LB9Ij8NccGJfeTHD0nUxmJwiBiTPaHSeI54+JGLzuOyl+Nx30kl2J
 Pdmg==
X-Gm-Message-State: APjAAAVF/QWgox6c+U74eTejpOsaYphl2GuG037mmSuZng7GI9WO2y9n
 9pvk2ycGmZSHUvJ8VFA8LUPipCOjLRc=
X-Google-Smtp-Source: APXvYqyY+eM9zx7RyztB5gEglyk5tdQ+U2ei8LZH/cPAc27IztaswG+AeZJKrDslokDk8Xa+ml/ifQ==
X-Received: by 2002:a17:90b:3cc:: with SMTP id
 go12mr2480433pjb.89.1580342228315; 
 Wed, 29 Jan 2020 15:57:08 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:57:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 41/41] target/arm: Raise only one interrupt in
 arm_cpu_exec_interrupt
Date: Wed, 29 Jan 2020 15:56:14 -0800
Message-Id: <20200129235614.29829-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fall through organization of this function meant that we
would raise an interrupt, then might overwrite that with another.
Since interrupt prioritization is IMPLEMENTATION DEFINED, we
can recognize these in any order we choose.

Unify the code to raise the interrupt in a block at the end.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 06d72ac9d6..3ce809306e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -535,17 +535,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint32_t target_el;
     uint32_t excp_idx;
-    bool ret = false;
+
+    /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
 
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
     if (interrupt_request & CPU_INTERRUPT_HARD) {
@@ -553,10 +551,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
     if (interrupt_request & CPU_INTERRUPT_VIRQ) {
@@ -564,10 +559,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         target_el = 1;
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
     if (interrupt_request & CPU_INTERRUPT_VFIQ) {
@@ -575,14 +567,16 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         target_el = 1;
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
+    return false;
 
-    return ret;
+ found:
+    cs->exception_index = excp_idx;
+    env->exception.target_el = target_el;
+    cc->do_interrupt(cs);
+    return true;
 }
 
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-- 
2.20.1


