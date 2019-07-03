Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71AAC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FDE21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2XjhLfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FDE21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihwE-0002I5-Kv
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZX-0002p4-Sz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZT-0007EN-OH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hihZT-0006wJ-Gw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id u18so3432216wru.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ovqcHq6dsGzX/8beQxDdY0vSbGoLnH7AOUmxQcUlSms=;
 b=S2XjhLfSLHaLbB6KoVWUmWxTCSLVAZfvdVBC2zPoO6aO/5mMhuZF1XXJDl1FswHvf/
 nKa2bCFG+A2NDIa0Qg5aOAlNbpyVDvF+1nQg0tguiRRF0NzTQFBJCtqCOumJN0UTSZ1K
 y/vrdzEYq53Xlr32sIm0R3V1XAKwoGa09Hg18xurZOFBCH43QVIV+9ZrfnzNE/aStKwK
 dmz59rCzAPW0MEb7cGnHcT60i5VmYMi4F6IjAENTY3WJq8r5Q1gCSgJl0EGpyc3NhKTe
 pNvA5l1woBhSdVC+ZKiZTI4mREsvC29Ar6ZF7WpB0b5ZWf61+//8XJqmvxSUazHcUpTc
 CL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ovqcHq6dsGzX/8beQxDdY0vSbGoLnH7AOUmxQcUlSms=;
 b=iMCbVWJErm04jMxn83Ns3vgtGoHRy4tvjlHADNp4poJlz5gb/9jbvtzehk/+yC3Hub
 LaSUaVOLhB4mP9dCaDcbLCbTob13vEccjji6luUYWr7WaiRr1SY5ypqb26oyHjYTjV/U
 nKGbwxv1HNm4ArEFVenGtvWAMB7OjV2MoBldfGpylGEDvdE0MRQShCYP1Rm+XBWH28cO
 5+QzeXJysK/YENMkN5EJXOS+Z8t320p/BJdRV/InPFlHmCO+7SzrfrF69f/tDmw4T7KD
 yXVYUNkwccQ8SwCSZTolectj6+waKwZCMiD4nNTe8LXJvbdriwEAco6Uo2aOscZrJR9y
 lZaQ==
X-Gm-Message-State: APjAAAUqHirCYtXpae1W9lOMwmlo/Yfx1QXCkRut6pr02xEeU0B+UJ5G
 71fhLQn78pJrFaLNnKfZeGIXgQ==
X-Google-Smtp-Source: APXvYqwNaDVV4WrWNCVdriCDmCNRcvS9ztCsEBDd6SC7NA28O7FEKO0uY+NmRvPGIdwR1U29nXqPhA==
X-Received: by 2002:a5d:4609:: with SMTP id t9mr268861wrq.85.1562169167506;
 Wed, 03 Jul 2019 08:52:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p140sm1806472wme.31.2019.07.03.08.52.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 08:52:45 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A17A71FF91;
 Wed,  3 Jul 2019 16:52:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 16:52:44 +0100
Message-Id: <20190703155244.28166-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703155244.28166-1-alex.bennee@linaro.org>
References: <20190703155244.28166-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v1 4/4] target/arm: remove run time semihosting
 checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking and use a common EXCP_SEMIHOST for
semihosting operations we can make helper code a lot simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 84 +++++++++------------------------------------
 1 file changed, 17 insertions(+), 67 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ad29dc4072..5c1f741380 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10364,83 +10364,33 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                   new_el, env->pc, pstate_read(env));
 }
 
-static inline bool check_for_semihosting(CPUState *cs)
+/*
+ * Check whether this exception is a semihosting call; if so
+ * then handle it and return true; otherwise return false.
+ *
+ * All the permission and validity checks are done at translate time.
+ */
+static inline bool handle_semihosting(CPUState *cs)
 {
-    /* Check whether this exception is a semihosting call; if so
-     * then handle it and return true; otherwise return false.
-     */
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
-    if (is_a64(env)) {
-        if (cs->exception_index == EXCP_SEMIHOST) {
-            /* This is always the 64-bit semihosting exception.
-             * The "is this usermode" and "is semihosting enabled"
-             * checks have been done at translate time.
-             */
+    if (cs->exception_index == EXCP_SEMIHOST) {
+        if (is_a64(env)) {
             qemu_log_mask(CPU_LOG_INT,
                           "...handling as semihosting call 0x%" PRIx64 "\n",
                           env->xregs[0]);
             env->xregs[0] = do_arm_semihosting(env);
-            return true;
-        }
-        return false;
-    } else {
-        uint32_t imm;
-
-        /* Only intercept calls from privileged modes, to provide some
-         * semblance of security.
-         */
-        if (cs->exception_index != EXCP_SEMIHOST &&
-            (!semihosting_enabled() ||
-             ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_USR))) {
-            return false;
-        }
-
-        switch (cs->exception_index) {
-        case EXCP_SEMIHOST:
-            /* This is always a semihosting call; the "is this usermode"
-             * and "is semihosting enabled" checks have been done at
-             * translate time.
-             */
-            break;
-        case EXCP_SWI:
-            /* Check for semihosting interrupt.  */
-            if (env->thumb) {
-                imm = arm_lduw_code(env, env->regs[15] - 2, arm_sctlr_b(env))
-                    & 0xff;
-                if (imm == 0xab) {
-                    break;
-                }
-            } else {
-                imm = arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_b(env))
-                    & 0xffffff;
-                if (imm == 0x123456) {
-                    break;
-                }
-            }
-            return false;
-        case EXCP_BKPT:
-            /* See if this is a semihosting syscall.  */
-            if (env->thumb) {
-                imm = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env))
-                    & 0xff;
-                if (imm == 0xab) {
-                    env->regs[15] += 2;
-                    break;
-                }
-            }
-            return false;
-        default:
-            return false;
+        } else {
+            qemu_log_mask(CPU_LOG_INT,
+                          "...handling as semihosting call 0x%x\n",
+                          env->regs[0]);
+            env->regs[0] = do_arm_semihosting(env);
         }
-
-        qemu_log_mask(CPU_LOG_INT,
-                      "...handling as semihosting call 0x%x\n",
-                      env->regs[0]);
-        env->regs[0] = do_arm_semihosting(env);
         return true;
     }
+
+    return false;
 }
 
 /* Handle a CPU exception for A and R profile CPUs.
@@ -10476,7 +10426,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
      * code that caused the exception, not the target exception level,
      * so must be handled here.
      */
-    if (check_for_semihosting(cs)) {
+    if (handle_semihosting(cs)) {
         return;
     }
 
-- 
2.20.1


