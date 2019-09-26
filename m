Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305B2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69B421D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWIXiiPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXHX-0005Cv-07
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcL-0002pj-Vt
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcK-0004u3-CB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcK-0004tc-79
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id v27so1820847pgk.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UQnfTCEnnIKKltvdbz7D/30XUobqe+yYKsVnosX+zfQ=;
 b=PWIXiiPBIOpJcCFllmzuD0SDAl9KlayLjCziHUGt+QVFFoDwoxV5h6wPGQHKi/5PRH
 InM8sMI+d7VTXQ/krwu5I8oU4WiNEHzZ4WrNLeAE5GfvB/fzsTEW3ajNY28rzYzazIW9
 QyIpRWIJf7VGsBFwgqo1SDJlRys8swruRNCtS2pm8yYLZh3UTxAkDC4g9MK+/9Mc/v6Q
 ASu2/YWHu45VdyvY+9dnr1GY6j0PaNLjEh3Gc8Rg5UrJp13ZJ2Rk85H9jvsH3MINWS02
 eaFirR9oVneG9mb767BB5+VgfNpoxy+0ZyZkFpQESneeAbSUieJMLOnRwg/pbUNl0t2i
 eFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UQnfTCEnnIKKltvdbz7D/30XUobqe+yYKsVnosX+zfQ=;
 b=TqAmjlx/t/xMacGMfwLYtjcoIIJr9k21zqttoeZZIdTQkXb9DSeogugltvoYe0s/YQ
 ILVpcMniTfH7+NUgVY5jxsL7ixvcxumJw0EqK7ojsM5QnCTj0ric3UlqsFCurPC5A328
 qu2LV0U1KSJvtLAYf8ItGk4U/8gzWXA0VNUncMzC3CiNXupYnAEg+amh/lUMq4qcPY3u
 eVisK7rMyDSWP3a2M0ZsByaGrWRx661xk1vlVkE/DRhAPFus+VZqQzydpWQNc3eoCXm9
 6lwbHxxk1VKAVWuyHT+joj/isYMQwf8t8Bi1PGMsAEIEgQE8sz2sKweS3HdEULFF0+C5
 JwpA==
X-Gm-Message-State: APjAAAUNNBn0zho80za0m2/wX0hqFXJe6FlMaq9LCYKDPJpoBNmfpt+0
 3lUWMtdVBskomcWVQ5rT9Z5YMpMmGpQ=
X-Google-Smtp-Source: APXvYqwdnyooJF6rlmRQgQhoNTiBqWMmpw8FSO3TFCWJMXHroWhG97TqOQb7vTgoGal4h59249fjmQ==
X-Received: by 2002:a17:90a:310:: with SMTP id
 16mr4580718pje.100.1569515202853; 
 Thu, 26 Sep 2019 09:26:42 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/18] target/s390x: Remove ilen argument from
 trigger_pgm_exception
Date: Thu, 26 Sep 2019 09:26:15 -0700
Message-Id: <20190926162615.31168-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All but one caller passes ILEN_UNWIND, which is not stored.
For the one use case in s390_cpu_tlb_fill, set int_pgm_ilen
directly, simply to avoid the assert within do_program_interrupt.

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
index e6c3139c57..ba02d33e86 100644
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


