Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB3ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E1721835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkvgoGSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E1721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLBA6-0006Kq-5C
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs6-0001Eh-4l
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs0-0000up-FV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAru-0000tS-QG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id d22so1556809pll.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v4LDoKiCDj8UEOXKdxGeWLogI6gqriKirwE9ruJcfe0=;
 b=kkvgoGShiDYFdnVG69AeK6rYe+drgSTZVX8QhFqP9Bp90hOTywYxJ6GoZxFnuFCd8u
 t9GHqpK6jtFaHAfOQHeG35azMcz5T5DIrTBXnnBreWyDuW02x4Lykz7Ke4/BoYahZt54
 iKBWSC+72w+uxFwV9H8vqmMqq/SS+wR2png+abaID3KD8AkMK8ZURPBu3oIZC6FTBw0T
 /rIv2avFBe8jDa7Wa59f/ucyIhsRBQDjh0Sdr9Bp/ojSQPyagxsj3Y97A7SEaOBvzmnz
 2g8K7wpc1zqRwRK9zxVzA1dHbA9388EHYWORDBMZWNkL1+vXoJVuhaA6IvmrE2If3rZ9
 m+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v4LDoKiCDj8UEOXKdxGeWLogI6gqriKirwE9ruJcfe0=;
 b=gowRkH4Xcls7w5XnsAvuaxwFCEKM8nHSbSyFk1vQNh210wFfRusosiJZrJ+8SESV/i
 d5kch++W8/jpWtDytC/GEe1sGa9rt5lJMZ7+j2xcZSq2MDIDbiO3a7zwmvXPnTZitfJf
 9+RffSKE4wuLJmoOs7/iFQpthQ37D7VFMFHr6o4mohUi+r0Kk2Jhn4pxh6gl9e4d1kJy
 7h5hXhtci/Tb8cRpzdPWd9Mj7moUxZIOqDIeXDTiAEmDRLoxfcYAg3x3Xw4lnooe8noq
 GdE48MmB5iqSKB5JwT5ttButtlwNY0hOPNtq7nNSZ0WBwNQdlOAFU8vro0ssJHuiJC1N
 Sczg==
X-Gm-Message-State: APjAAAWxzkDPfGb6hhv2mTIeXelVfJYgZiWJjyE1AQAaubX7V+A9RCll
 jYmpje5Ph8UAfxx+GZjnaiWMjMiyIZQ=
X-Google-Smtp-Source: APXvYqxFCeY/tUIroNCz+/JHoLW2e18i1UL4NQ6hGq7yqLg2Ml/+vzSEXAvEsublLdBAhugCZhodIA==
X-Received: by 2002:a17:902:820f:: with SMTP id
 x15mr5640663pln.288.1571338285472; 
 Thu, 17 Oct 2019 11:51:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 10/20] target/arm: Simplify set of PSTATE_SS in
 cpu_get_tb_cpu_state
Date: Thu, 17 Oct 2019 11:51:00 -0700
Message-Id: <20191017185110.539-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hoist the variable load for PSTATE into the existing test vs is_a64.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2a62cf19a..398e5f5d6d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11197,7 +11197,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags;
+    uint32_t flags, pstate_for_ss;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11205,6 +11205,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+        pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
 
@@ -11257,9 +11258,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
+        pstate_for_ss = env->uncached_cpsr;
     }
 
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+    /*
+     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
      *     0            x       Inactive (the TB flag for SS is always 0)
@@ -11267,16 +11270,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
      */
-    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)) {
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        }
+    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE) &&
+        (pstate_for_ss & PSTATE_SS)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
     }
 
     *pflags = flags;
-- 
2.17.1


