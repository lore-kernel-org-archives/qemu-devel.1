Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE10C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1A420663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cm0akHXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1A420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAN3-00073H-IP
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKT-00038Q-Gk
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:26 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKR-0006Eq-2Q
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:25 -0400
Received: by mail-pg1-x541.google.com with SMTP id r10so5193161pgv.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sWktVAUx9ulLHoMCqPkS2j+iHzQ8DGPuikmGe+LrZUk=;
 b=Cm0akHXBJ44Xf4i0soK9E5rV+vLa3l1KWkBctdFf7kBUJ//m1QQ4AXHqDQO1h6uu9j
 UlRhlrcnfnjlxwkXv9EaKsjDFcLddrVZNOs2e5iXYdJHACrZGOYnWDu7IO9ObTGRlUHx
 3f/UCqRYdjKg/DeM8Cz1/rRQvH+aDd/7lrAHb7TrgoeJRUDb4IAAsQfW8pETdZuFmJFc
 7B4FiZ/pyLBvCmcclK2NhdtKkEtTAHbje2+3aCCcpHG3DQtfK047Wx4ngfPZS1CR7f+m
 qPN4D/TfeKGbs7/b1YQPZTNDOm6YgZBz7L+hK+qkxVLy9khFV1hXhwJ/ZF01xk/oRgdp
 VKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sWktVAUx9ulLHoMCqPkS2j+iHzQ8DGPuikmGe+LrZUk=;
 b=Ko536QNTtXf3xHaYYO4OT4ABAODEauKRk8P8QQH7NbKWhRV1vWBbJ6aOOxIeHSzNQC
 tjzagO82+g4C1oQ5zzq9Y1nBykQMFyD8PjNofeF+JDFkWig2xPpIvpqOGL73g8RiD+02
 4RS7/EdOtZuNPVYmkTJ7+JZhemd7f5fjToy4ZD3nZJA0QzVxpsTmqhtofmghPTQECoEI
 rTFa7lhAir/lJd6uaIXZixsR4dKAgtV/Ec4GK84qn7833Ccckzd5/FAqwZiktve6/vQM
 fW4Gc2vzL0scAnOJAEW2zskv9JYUHFuhgJPmwa7x70EzO/ZGpvjZmuvIwnCI0YvsBc+y
 5HHA==
X-Gm-Message-State: AOAM530dQ/1eamBKcQveCuV9sPZkH6UbRziNyslu+VcHOfLNAzRYn4O7
 cJq9Fu7P66kTaobWEhBdRg+pdjryIiVhWg==
X-Google-Smtp-Source: ABdhPJw6NNyAAxg8yXcqELcQCSJELqsEUQ6IY7mcABXzUhCqBZwx3eHJ+AI+M6NK9u1nOnOvR7LWbg==
X-Received: by 2002:a62:7a0b:: with SMTP id v11mr4662621pfc.111.1590164121017; 
 Fri, 22 May 2020 09:15:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:20 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/19] accel/tcg: Fixed tsan warnings related to parallel_cpus
Date: Fri, 22 May 2020 12:07:47 -0400
Message-Id: <20200522160755.886-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed several tsan warnings. e.g.

WARNING: ThreadSanitizer: data race (pid=35425)
  Read of size 1 at 0x557cd83aee28 by thread T7:
    #0 curr_cflags include/exec/exec-all.h:460:13 (qemu-system-aarch64+0x4b7f27)
    #1 cpu_exec accel/tcg/cpu-exec.c:730:26 (qemu-system-aarch64+0x4b7f27)
    #2 tcg_cpu_exec cpus.c:1415:11 (qemu-system-aarch64+0x45b9b6)
    #3 qemu_tcg_cpu_thread_fn cpus.c:1723:17 (qemu-system-aarch64+0x45b9b6)
    #4 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xd431e0)

  Previous write of size 1 at 0x557cd83aee28 by thread T6:
    #0 cpu_exec_step_atomic accel/tcg/cpu-exec.c:254:23 (qemu-system-aarch64+0x4b6caa)
    #1 qemu_tcg_cpu_thread_fn cpus.c:1741:17 (qemu-system-aarch64+0x45baca)
    #2 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xd431e0)

  Location is global 'parallel_cpus' of size 1 at 0x557cd83aee28 (qemu-system-aarch64+0x000001fb3e28)

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c    | 4 ++--
 cpus.c                  | 2 +-
 include/exec/exec-all.h | 2 +-
 linux-user/syscall.c    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d95c4848a4..4cbdef1373 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -250,7 +250,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         }
 
         /* Since we got here, we know that parallel_cpus must be true.  */
-        parallel_cpus = false;
+        atomic_set(&parallel_cpus, false);
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
@@ -278,7 +278,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
      * the execution.
      */
     g_assert(cpu_in_exclusive_context(cpu));
-    parallel_cpus = true;
+    atomic_set(&parallel_cpus, true);
     end_exclusive();
 }
 
diff --git a/cpus.c b/cpus.c
index af44027549..c5d04486a8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1966,7 +1966,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
 
         if (qemu_tcg_mttcg_enabled()) {
             /* create a thread per vCPU with TCG (MTTCG) */
-            parallel_cpus = true;
+            atomic_set(&parallel_cpus, true);
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3cf88272df..3f2c0290e1 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -496,7 +496,7 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
 /* current cflags for hashing/comparison */
 static inline uint32_t curr_cflags(void)
 {
-    return (parallel_cpus ? CF_PARALLEL : 0)
+    return (atomic_read(&parallel_cpus) ? CF_PARALLEL : 0)
          | (use_icount ? CF_USE_ICOUNT : 0);
 }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..8e39c09c5d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6022,8 +6022,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         /* If this is our first additional thread, we need to ensure we
          * generate code for parallel execution and flush old translations.
          */
-        if (!parallel_cpus) {
-            parallel_cpus = true;
+        if (!atomic_read(&parallel_cpus)) {
+            atomic_set(&parallel_cpus, true);
             tb_flush(cpu);
         }
 
-- 
2.17.1


