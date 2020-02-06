Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F595206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBhsYNB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F595206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfAt-00043n-Dp
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoj-0003VZ-Rf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoh-0000Hj-SV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:29 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoe-00005K-7Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:26 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so6578533wrt.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oFO7A+GHodLVViilFHrVVzMQZ82rOVrK9HIlLR/jPA8=;
 b=HBhsYNB1AJII2Hz4xrt7POvRF4wtsX5M37/+F9kYd9lihZkmQEtMVYMN8LG53XHUfW
 Q4PpdpY0TBbv07UPrJGBvz5O4Eqg99hkD9u7GuIs4HOFEiKlFlZR2DGjV+B/T/ogUbhv
 d29KKEOeMTrBJZ7GUppQjg5L6oLokiozBhJiwoWLq77td7w7cT8rNwGt7zJ7r3epS2jx
 UOgAKLa6aucSSR+dotx+4Mx+S9NFmcJb9QkMXHUl0nsf4jmVL2kIRB0iKNr2bogdWUW0
 MXCVnWwuoFk02n9EKwztN0ourZSJc/yF4qNfBsOeZ9UQiSRemA30hztbiip7VPCwlS1V
 SY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oFO7A+GHodLVViilFHrVVzMQZ82rOVrK9HIlLR/jPA8=;
 b=ViQyXznUdH9GhgobnVVM+3zolUdL9shJRVj2bGiktsPrycT0dOl5/NPR7O7qoNrUlT
 0eDYmTHcQ1XmqPXDbTjbzEbacqJM6nILszh8wlzvfebfwItIgvds6Q3Vts3UfezLlFYs
 QUF5X1QJ3fXv3q1Wto43ZJpvR0d3QyTX9dh7iTyRnQMHrTSp2i19faItBRkTKVkoAmzR
 ey4CgNdds4K5GknC8/VFm04i0qJMrmmhZJHCUhMMWi7/1a/2JPgEVe5Bcl12h5V/2xOw
 BFzAN/W8dWwkxv5lS6F9DpWrYUL3SvWBMnU0AGjaVN7LfZvEWdGrQ5c8XtglgpJXbg+4
 c3gw==
X-Gm-Message-State: APjAAAXYW4wferOMJ+Fjr15aM+20RlIGN788yGD6bUYFx9SKcLGTKbox
 H77yRJOcKT+nXXpXHvk26m5fJXvpfGft7A==
X-Google-Smtp-Source: APXvYqxjcrnpVueDXD72vrvudfWfUJq3/lZnhheCOF47uoWc6FG29jxPd31GaWAlCXHGSS07eWlhog==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr3354310wrv.77.1580986522929; 
 Thu, 06 Feb 2020 02:55:22 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 39/41] target/arm: Pass more cpu state to arm_excp_unmasked
Date: Thu,  6 Feb 2020 10:54:46 +0000
Message-Id: <20200206105448.4726-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid redundant computation of cpu state by passing it in
from the caller, which has already computed it for itself.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b81ed44bd2..fcee0a2dd4 100644
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


