Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1141C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8628C20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqqrjjgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8628C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04wp-0007Qp-Kr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iF-0001KL-Dc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iE-0003Sw-22
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iD-0003SQ-RD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so2812601wmc.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1LTG4U/f+N60k+wJCqnLvXrcq4ScJA4RfGQ/AElRkTQ=;
 b=JqqrjjgK6O+mbuYyngaA1pKoC9OSKx0bLaZ7oUPUtqn1vJ0pOXLvXDPPuBCpM234le
 3lMeUg41xC+wZhq1yF8pefRihJLEn69ZY4CsYCiVVfmfzA+Hxu5353hvB79DKd9F46im
 2k3pnhSoWXQbDgW8+jYg9qMC5GgCdydIuIoqJ2MBAgHj0Jnzuhvc5aPicgaHwetcJKF1
 78/MxhBexWlL7T65AO3YZxIA9EOzUi8XMPNd/dcWU1Ac2fjMSFZLhkT014W4F5rGLDJN
 WBEY0ECQZUYehGrbbOp2tpSlQKOttA/2HeJB4Q3Ha2q/lz2VOgF6pHKrguGaZqD7/n+/
 zaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1LTG4U/f+N60k+wJCqnLvXrcq4ScJA4RfGQ/AElRkTQ=;
 b=M+OlFUXBU9tjLRcyP06Ygkf8qbBY7FCd/UDFsACXpYG8ce08EpxzmtxGK/30Ojdj7F
 ALI6ojHBM2+yiKpkRMd3zEncNz2o8nhYczjb14FfCkCdPErz7AEDQigYMt+VGF1Re//K
 zTRlAFvivWl1rO/zGpRxmcsVpqOaF6g8ahYp2A++D4ZzLxSvGyhltQXoFQ4ee9NwWiXC
 Nai0+bYuIDfsr9rVOmWbeg77go45V+kMnV2Q2UlLLyHUeuffvHSpRBAa3iGDVHqDt/T4
 LrV6rVe9p0/ZSasXjTlUtEp7S44AZycPb+OWD/L07BTP8gJitGaTdZjWz5oPFR4i2t4z
 Ab2A==
X-Gm-Message-State: APjAAAVAwzBY+i+7ouLar6sL+d5sDhqGrSPbpJvbnslE0XSlCObKC0Dq
 QMcj/V9QFG41tJKoGuUewCsUbgGdleA=
X-Google-Smtp-Source: APXvYqxcL7W2DokFq6yhc2FgHLLQEokgfg1neXm3g1DPKuYtbz6kgWHsUpJsH4cF7N7CIY4OBVW8Tw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4648893wmc.36.1581086068624; 
 Fri, 07 Feb 2020 06:34:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/48] target/arm: Pass more cpu state to arm_excp_unmasked
Date: Fri,  7 Feb 2020 14:33:35 +0000
Message-Id: <20200207143343.30322-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Avoid redundant computation of cpu state by passing it in
from the caller, which has already computed it for itself.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-40-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b81ed44bd2b..fcee0a2dd45 100644
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


