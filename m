Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152712166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAIEtFIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152712166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfsL-0005NX-9S
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEk-0004OQ-3E
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:46 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:42810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEh-0000ND-7C
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:45 -0400
Received: by mail-qt1-x835.google.com with SMTP id q14so2744834qtr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=km3WZi1TaIpmNQhmf1v8PVX4fpTySmyjj8uA+abKwoo=;
 b=HAIEtFIsWsNy2Ng+eP2vfYLwDDRwem0GOYxVU8SnQNr9aqvT9MAhd2dbeP76mo81wJ
 MxDF7dRV5MIX6iSgoRV+DnsY0DGOvIqG+aUUEfV5+8QcXj7wX3YUOSpxYhSRPjCQZUEJ
 um0sr8OCx3pP5my3tl18cwklpTjM6DdYXwQGqPwIbkzZQwJcdBvOh3oHB3f61SpQ0W+s
 05BQXr/MekCuM50w/BdcSmH3Q8m0shZVjHK5TjCqahO5NwkVo+Kp/hHkwggc2iNX8QEw
 TnI7Dsf0AdFP5RmiavaikcFt4Y568FGqOp1m3f2dDbuY7BVhcfO4EbhoLOseGKbUpLrc
 xhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=km3WZi1TaIpmNQhmf1v8PVX4fpTySmyjj8uA+abKwoo=;
 b=FT9ajWnLa2MvJAkfKaNJuNTlSroRCzw2lUsQPQJGhAy+f6cWNBqBWwZZUcEzcdNxEB
 9DBLLQUFW29Lp6S0cPXgnlmiZO9wGKIy+8Jm49a+VIoGy+jLt0jcVMiY5LjKCED1faX4
 Qa3FvzEcHwMHz5e4ckun+Y9sj5fUiC4mT6soVL5Csrltqjv8TgzSQg6V5bdm/wGA92/z
 bCWt/Ti5BxXzD+87bIWNiS7UrF/olA58O+mlmz1BCh78wGq1aGbBs2nAuAjU9uwT2so6
 5kkm88X5NzK6G+sKXKaF4GGm8QgBGR3X7aMO/mUig2kV6nM12SPG7O88MrIcIObbHrkd
 wMfA==
X-Gm-Message-State: AOAM533BbbNu75NpBS8atvsuXR6Yav80fHT3v+s1GjOfZWBWnEoycPLf
 0osCE2DyNrnWP1W2oNyTqauuoflTFmWgeA==
X-Google-Smtp-Source: ABdhPJxAz8j/ulmeo2NGhiaJz85JJQIk0wNmNvP0BAucR4B1FE0z+wYeAQJnpFoePqe9sx9LQSMe+Q==
X-Received: by 2002:ac8:40dc:: with SMTP id f28mr1095809qtm.63.1592427880932; 
 Wed, 17 Jun 2020 14:04:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:40 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 59/73] accel/tcg: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:17 -0400
Message-Id: <20200617210231.4393-60-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x835.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c      | 15 ++++++++-------
 accel/tcg/tcg-all.c       | 12 +++++++++---
 accel/tcg/translate-all.c |  2 +-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 099dd83ee0..b549a37847 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -431,7 +431,7 @@ static inline bool cpu_handle_halt_locked(CPUState *cpu)
 
     if (cpu_halted(cpu)) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
-        if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
 
@@ -544,16 +544,17 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      */
     atomic_mb_set(&cpu_neg(cpu)->icount_decr.u16.high, 0);
 
-    if (unlikely(atomic_read(&cpu->interrupt_request))) {
+    if (unlikely(cpu_interrupt_request(cpu))) {
         int interrupt_request;
+
         qemu_mutex_lock_iothread();
-        interrupt_request = cpu->interrupt_request;
+        interrupt_request = cpu_interrupt_request(cpu);
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
             interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
         }
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
             qemu_mutex_unlock_iothread();
             return true;
@@ -562,7 +563,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
             cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
             qemu_mutex_unlock_iothread();
@@ -599,10 +600,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
-            interrupt_request = cpu->interrupt_request;
+            interrupt_request = cpu_interrupt_request(cpu);
         }
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
             /* ensure that no TB jump will be modified as
                the program flow was changed */
             *last_tb = NULL;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3b4fda5640..5eda24d87b 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -52,10 +52,16 @@ typedef struct TCGState {
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
     int old_mask;
-    g_assert(qemu_mutex_iothread_locked());
 
-    old_mask = cpu->interrupt_request;
-    cpu->interrupt_request |= mask;
+    if (!cpu_mutex_locked(cpu)) {
+        cpu_mutex_lock(cpu);
+        old_mask = cpu_interrupt_request(cpu);
+        cpu_interrupt_request_or(cpu, mask);
+        cpu_mutex_unlock(cpu);
+    } else {
+        old_mask = cpu_interrupt_request(cpu);
+        cpu_interrupt_request_or(cpu, mask);
+    }
 
     /*
      * If called from iothread context, wake the target cpu in
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c3d37058a1..23007570f6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2409,7 +2409,7 @@ void dump_opcount_info(void)
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
 }
 
-- 
2.17.1


