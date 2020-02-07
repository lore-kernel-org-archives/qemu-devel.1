Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BAFC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5498B214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqfJSZXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5498B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j051j-0004i2-DO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iH-0001Qi-Pd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iG-0003U5-E5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:33 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iG-0003Ts-79
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:32 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so2910944wrl.13
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oIsEar5AYXxYyDE1KHxbOapxJEQ61+KtlpwUsOgsDqo=;
 b=RqfJSZXnBSECDwW35xvoRWK1QHAeOM7ce4cBI6rPTEys9KfIai5b4ssiPKp9dvBu6n
 MQ3xjB6WR8lol4/FTnYqjIOrXrt6/J6l7N9KLbACMMIld+wzT7foB8oYkXPpg52Etx2I
 v6wRPUXNGvGJKwhex+s4V+XF7wcxBpxO2oGvGDnYqtrPtE/jRYITmoPWEqgINlFZyuir
 7GEqtd68MjxgF8sEc+VQF7M4YNcmwCiEMspL5Gr71v3Lw60idjOTifND81oiERx4oeCs
 S7kXBTU5jxTRcTWmTb3DK4jgdYgZt+eymJKWp+G2Cf+QXTwFCLciZbsp+bNBh5yotxSG
 pp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oIsEar5AYXxYyDE1KHxbOapxJEQ61+KtlpwUsOgsDqo=;
 b=Iov5vTWpbTEhUMrDy84DX23SxokcxK9X+iyKFuSCJ7iY/Dua+KGdgecBVpUZaulN6u
 Bc+tmGdlfSSAdFRnnbZj6Z+Os8q1sHwM91IW+gS4Mwb2qT/OhiRTx9TgFLFys3UJbzUX
 hlR13BtPygb5/L+MSf3C5vTGtOLXDERTxYnwErqYSypTte6i6oQD5P4imyhFaC8RcNN2
 nHcIbN2qInoHEn2reQPL4yOERha3ux+Gmy/0cjICJISTtj+P1F1chb+gQb+DP1Blj4AV
 glZZm2Zyl5oI0uQ8XUWYpFXqygWuY3Pip0rWaGvAy4kljA3jII1jwvrkSHHz+HnsyiJR
 5Mpw==
X-Gm-Message-State: APjAAAXJ9oogNrI3nQFsmnRJeToUETkZ3+iy6H+UkfI7tTDbNNG5Wyjd
 X3P3p97C4wWxFhim2fZ8VphP8CT9WVE=
X-Google-Smtp-Source: APXvYqwTi5IsGwIDk24iIKjWKbT3Bg1cU5VoudhXtIuueppgfQgvFXzO5lelc64zwoQyWTNWXiaEwQ==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr5141208wro.104.1581086070970; 
 Fri, 07 Feb 2020 06:34:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/48] target/arm: Raise only one interrupt in
 arm_cpu_exec_interrupt
Date: Fri,  7 Feb 2020 14:33:37 +0000
Message-Id: <20200207143343.30322-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

The fall through organization of this function meant that we
would raise an interrupt, then might overwrite that with another.
Since interrupt prioritization is IMPLEMENTATION DEFINED, we
can recognize these in any order we choose.

Unify the code to raise the interrupt in a block at the end.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-42-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4ffc09909db..b0762a76c4b 100644
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


