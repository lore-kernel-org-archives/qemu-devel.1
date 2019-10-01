Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3BFC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA5221A4A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv6rqUR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA5221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45789 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLz2-000718-5H
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlR-0001kT-Pt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlQ-0005dg-F7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:41 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlQ-0005d5-9i
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:40 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so10094319pgv.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zWndXgEDq38ZD9+tzMggT4V1IKonosDqt8xl6lDbLwc=;
 b=Rv6rqUR2U5m+Q68C4U02FebkcUVqJvtdRBd3tY1NCPDSUBtvID3T7cs2mv4jwui7fF
 mpee7zecLtAy6SHSlEVqgJmEzNQiJmgvQ7XYn7qyKY+ze+BJ5gC+M3GLdE2JGPkPgu4O
 d4WNUAq/Ou7qj1gTZf8cnA9Gp6flf6wXM/XSAlFvjZfc/4G/LtEpsVfBp1xgUn9d044h
 rQV2nU4TSK7bTEo/4Guwh+Ih9Jtz5aMqiOaN+bZJn+VMl2VjzUXa6n/BtF0wFf+gKZTh
 UiwjqSd1fE0FKcuMPc87RaOiuG2fuSS/hAPioyXCmoaoWNoqjOBtqGtxbitovdIeqSFd
 LL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zWndXgEDq38ZD9+tzMggT4V1IKonosDqt8xl6lDbLwc=;
 b=LVexExqHcVQuoAS7zpd+g8PtH9MrUHkmlbQYmZ5jk+ZaMd6FcEtwfqOjrmQ7AB14ci
 QN0SB7zRKfGWRSlMzGnjoRSEGyB3onR+OqhBlHrFHH2RGQO+LdvrI2R09RLCvwEFOMVC
 7M3KpPnTW4UuqOTElZ7USGHsVDkcpaO3vS0BtWTwFkxgL1OzjOBkflz8Onsb6v/YIrRR
 WRzWmsjhaVaNR45Fohb+E4KN5vQJrprN39cZOxjPlIoCQEhpWsEtIesV4V+mod03Wghl
 F6OuaOJNToS/jB5mMeWRZFuZcsfgyTWrCir7I8ncmMTfjnYyKu1kr+TJ16NfnH+yhnYq
 Tqtw==
X-Gm-Message-State: APjAAAWCVqp1Blb3jiu8ODQ6fi3x3ASbHRGDQslJO4KC9rJRfwmNoJwn
 yZYrLLwumzBuvoTXQHnX2SAs3g2cItE=
X-Google-Smtp-Source: APXvYqx41FG48UQUibuw6rT8m/NNzDs22WvRfzOEJkfnd1Mv8WNToSMW5+emhnqcOqWLJDG/VmxqOw==
X-Received: by 2002:a65:6786:: with SMTP id e6mr31821960pgr.257.1569950198473; 
 Tue, 01 Oct 2019 10:16:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/18] target/s390x: Remove ilen argument from
 trigger_pgm_exception
Date: Tue,  1 Oct 2019 10:16:13 -0700
Message-Id: <20191001171614.8405-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All but one caller passes ILEN_UNWIND, which is not stored.
For the one use case in s390_cpu_tlb_fill, set int_pgm_ilen
directly, simply to avoid the assert within do_program_interrupt.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    | 2 +-
 target/s390x/excp_helper.c | 7 ++++---
 target/s390x/interrupt.c   | 7 ++-----
 target/s390x/mmu_helper.c  | 2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c993c3ef40..d37816104d 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -317,7 +317,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 
 
 /* interrupt.c */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index c252e9a7d8..e70c20d363 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -42,7 +42,7 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ILEN_UNWIND);
+    trigger_pgm_exception(env, code);
     cpu_loop_exit(cs);
 }
 
@@ -96,7 +96,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     S390CPU *cpu = S390_CPU(cs);
 
-    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_UNWIND);
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING);
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.  */
     cpu->env.__excp_addr = address;
@@ -186,7 +186,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
      * and so unwinding will not occur.  However, ILEN is also undefined
      * for that case -- we choose to set ILEN = 2.
      */
-    trigger_pgm_exception(env, excp, 2);
+    env->int_pgm_ilen = 2;
+    trigger_pgm_exception(env, excp);
     cpu_loop_exit_restore(cs, retaddr);
 }
 
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 2b71e03914..4cdbbc8849 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -22,16 +22,13 @@
 #endif
 
 /* Ensure to exit the TB after this call! */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
 {
     CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = code;
-    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
-    if (ilen != ILEN_UNWIND) {
-        env->int_pgm_ilen = ilen;
-    }
+    /* env->int_pgm_ilen is already set, or will be set during unwinding */
 }
 
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 09c74f17dd..90b81335f9 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
         if (type != PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
         }
-        trigger_pgm_exception(env, type, ILEN_UNWIND);
+        trigger_pgm_exception(env, type);
     }
 }
 
-- 
2.17.1


