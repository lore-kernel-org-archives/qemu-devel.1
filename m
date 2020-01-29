Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE6C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAC5206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6Z2/Uh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxWF-00044v-EH
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCm-0004bs-R4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCl-0000VP-KJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:08 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCl-0000Se-4v
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:07 -0500
Received: by mail-pj1-x1044.google.com with SMTP id f2so1873201pjq.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6zsJ+64yBL0aQurnYOJJKrMClJ7E0x3WeYfXxBCipH4=;
 b=R6Z2/Uh3qyJqgN5G1GXEY5OXmd8y/Kc8MJmNuPZ6fnbrOQicJ4e9LPiOa9ZnBLOsuO
 Z84TuIs26ZkCmp3ExsYNSEb1Hf33oSM9aKF6n92l10sdHCqIf+58c0QTBf1t2HLtqwXe
 L4dvASdYeoQiTBteNKMb8SsQMOuBWYs3i3z9lJ88adCbZ1oF/5yyuYrqHySd8gfpTkBJ
 mJGeMzu7km1Qr21nYf8IeMOBA/Y65PjyKUgTAqjqyDJHY7yLSORyV0XawI4xbduwSbzb
 B1Nkdbio5FtMQe2dqwoKCbF+NCRl8oH07VVpzXaIBmZSqIBtDPCqzdyLDMqIe5rwx0eN
 0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6zsJ+64yBL0aQurnYOJJKrMClJ7E0x3WeYfXxBCipH4=;
 b=Kkg9aW1ydbs/x5fKUFw6DAPTB3BLHp+rtUXv6emAHhJpf2eGceda5m/YCDkR6am9NF
 wILcZqUjAxyb/QSAIS2K9Ode1GzO3dUCvlA73NONxRC/+Iz54XpbtBwiTZC+9zkCOuW3
 AcYZN20Sn1+WdH4roaiHYbsemwQ+x/0oyw5PVooHHe/E18wrJ6qG2CQ04OFOYgIpDcPI
 934l1kw+HS8Bs/p6vTrLtABIqrt4qAOK/Rq16+CPShcKKQDlEq7lPD92bRFCUj3g+IcZ
 yu9aWOngBDR0/BCpirAdUdQLUAjUm2FsIrBEM0mKdWPHMX7zbvkyRkJePCpdG4B5clyq
 ttLg==
X-Gm-Message-State: APjAAAXPSuCOLcsN+2svpCnRKjnRkeqYj/YdZj54YyHxoInmdwMz56Ev
 rWj36dbgLNzpn0ktAJTvmiz7SxNq3pU=
X-Google-Smtp-Source: APXvYqyrPx3oTfb42A9UUE45BO6bLXABZgJ/UYtASHZmJOhA2FgYVWQWNHEEC7JgyJy8Ed7uF9a6ZQ==
X-Received: by 2002:a17:90b:30c9:: with SMTP id
 hi9mr1481025pjb.81.1580342225758; 
 Wed, 29 Jan 2020 15:57:05 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:57:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 39/41] target/arm: Pass more cpu state to arm_excp_unmasked
Date: Wed, 29 Jan 2020 15:56:12 -0800
Message-Id: <20200129235614.29829-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid redundant computation of cpu state by passing it in
from the caller, which has already computed it for itself.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 114833bdba..d9cf625073 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -411,14 +411,13 @@ static void arm_cpu_reset(CPUState *s)
 }
 
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
-                                     unsigned int target_el)
+                                     unsigned int target_el,
+                                     unsigned int cur_el, bool secure,
+                                     uint64_t hcr_el2)
 {
     CPUARMState *env = cs->env_ptr;
-    unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
     bool pstate_unmasked;
     int8_t unmasked = 0;
-    uint64_t hcr_el2;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -429,8 +428,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         return false;
     }
 
-    hcr_el2 = arm_hcr_el2_eff(env);
-
     switch (excp_idx) {
     case EXCP_FIQ:
         pstate_unmasked = !(env->daif & PSTATE_F);
@@ -535,6 +532,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     CPUARMState *env = cs->env_ptr;
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint32_t target_el;
     uint32_t excp_idx;
     bool ret = false;
@@ -542,7 +540,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
@@ -552,7 +551,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         excp_idx = EXCP_IRQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
@@ -562,7 +562,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_VIRQ) {
         excp_idx = EXCP_VIRQ;
         target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
@@ -572,7 +573,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_VFIQ) {
         excp_idx = EXCP_VFIQ;
         target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
-- 
2.20.1


