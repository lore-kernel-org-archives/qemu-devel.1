Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D92C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058FD20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLtVk9Fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058FD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYLN-0007zF-5f
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJw-0005xv-Rv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJv-0001LV-95
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:40 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJv-0001LG-4Q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:39 -0400
Received: by mail-qt1-x841.google.com with SMTP id a5so6512831qtw.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3hREnc0W2bwPSyTBH3eADGzgCMYeIoOKwLln3BCuEfI=;
 b=vLtVk9Fr4EjzAz5O9uxawwiQhIfYLsJNgTGeuriHcPeMQB69fnZPRLPQhVyDBhSpJz
 Y5JQKRQwv13H2lw0tG/YKcu07k2nUKrlfSpdTGvwEFDnDQiAY494J53lEN1c7DYZvCnM
 6UL3NP+yUDdFTZ90oPQv24u5oiCL/RFUs1BScZ/Dy1WPYgynyJwWavYOqjR89VHZuPaA
 Le9NIbH4yYAl2exSbjk2tnC2rmxIOHsiSbsowvOaxhzPsRZxWu3PWqVaMTF8ksE3vEss
 0Eb4Onn0/yO1NhXOWVWcH4CAPN0Ip8rk+vlaupV7Y1L5FVo1/0pQdqVbYltzGzneDKaO
 /8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3hREnc0W2bwPSyTBH3eADGzgCMYeIoOKwLln3BCuEfI=;
 b=p6ZvST2qYltSMJ6+E/V8IVHMbtVscFL08W+e7MESKuNP9ZZ6hkvULbYKFZqcNw7htc
 /ZrS0W6HmckSC0hrKxqLQB7Tbhh+hKZ0X0vvwuqDfMJqrtOUPO8W8OjKa56g6X6g/7aV
 8+JwKZZggYJ+MLbnyYWQflKjaEmMcMTsvKm9QmYK1bj9pBkZIOcyzT6gSAqqEckI9dh8
 X0uvLTuiU09lg1Bz5SOm7sXoU6Rj7mhLnINF04eOnA5NObX1mecNZhKAcTl5PjnATHIr
 3pyQK8C4wRprwE+vwl+zi8jZcjo/ozkOgJEgEFgDbVRYlQ3sClffdDmFC7sdz3GKoJs9
 nvEg==
X-Gm-Message-State: ANhLgQ1nccNx8Pl2Oa/Pb00mq9E7gWQAZ3k2oZv73wSvtQ+MO1IhrD6s
 4ihhFwmZGtm/l3mYVvbDXvyTD8zy1gaqqA==
X-Google-Smtp-Source: ADFU+vvfYlknMD12TI+6gT8txq8TKgskWtMlJoIvJeZPpjo9TNMGFdMrUWM6IV5E0DdUXFhpN10feg==
X-Received: by 2002:ac8:2f88:: with SMTP id l8mr10238328qta.139.1585251457982; 
 Thu, 26 Mar 2020 12:37:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/74] cpu: make qemu_work_cond per-cpu
Date: Thu, 26 Mar 2020 15:30:46 -0400
Message-Id: <20200326193156.4322-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This eliminates the need to use the BQL to queue CPU work.

While at it, give the per-cpu field a generic name ("cond") since
it will soon be used for more than just queueing CPU work.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 72 ++++++++++++++++++++++++++++++++++---------
 cpus.c                |  2 +-
 hw/core/cpu.c         |  1 +
 include/hw/core/cpu.h |  6 ++--
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index f75cae23d9..9031c31005 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -26,7 +26,6 @@
 static QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
 static QemuCond exclusive_resume;
-static QemuCond qemu_work_cond;
 
 /* >= 1 if a thread is inside start_exclusive/end_exclusive.  Written
  * under qemu_cpu_list_lock, read with atomic operations.
@@ -42,7 +41,6 @@ void qemu_init_cpu_list(void)
     qemu_mutex_init(&qemu_cpu_list_lock);
     qemu_cond_init(&exclusive_cond);
     qemu_cond_init(&exclusive_resume);
-    qemu_cond_init(&qemu_work_cond);
 }
 
 void cpu_list_lock(void)
@@ -105,23 +103,37 @@ struct qemu_work_item {
     bool free, exclusive, done;
 };
 
-static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
+/* Called with the CPU's lock held */
+static void queue_work_on_cpu_locked(CPUState *cpu, struct qemu_work_item *wi)
 {
-    qemu_mutex_lock(&cpu->lock);
     QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
-    qemu_mutex_unlock(&cpu->lock);
 
     qemu_cpu_kick(cpu);
 }
 
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
-                   QemuMutex *mutex)
+static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
+{
+    cpu_mutex_lock(cpu);
+    queue_work_on_cpu_locked(cpu, wi);
+    cpu_mutex_unlock(cpu);
+}
+
+void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item wi;
+    bool has_bql = qemu_mutex_iothread_locked();
+
+    g_assert(no_cpu_mutex_locked());
 
     if (qemu_cpu_is_self(cpu)) {
-        func(cpu, data);
+        if (has_bql) {
+            func(cpu, data);
+        } else {
+            qemu_mutex_lock_iothread();
+            func(cpu, data);
+            qemu_mutex_unlock_iothread();
+        }
         return;
     }
 
@@ -131,13 +143,34 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
     wi.free = false;
     wi.exclusive = false;
 
-    queue_work_on_cpu(cpu, &wi);
+    cpu_mutex_lock(cpu);
+    queue_work_on_cpu_locked(cpu, &wi);
+
+    /*
+     * We are going to sleep on the CPU lock, so release the BQL.
+     *
+     * During the transition to per-CPU locks, we release the BQL _after_
+     * having kicked the destination CPU (from queue_work_on_cpu_locked above).
+     * This makes sure that the enqueued work will be seen by the CPU
+     * after being woken up from the kick, since the CPU sleeps on the BQL.
+     * Once we complete the transition to per-CPU locks, we will release
+     * the BQL earlier in this function.
+     */
+    if (has_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-        qemu_cond_wait(&qemu_work_cond, mutex);
+        qemu_cond_wait(&cpu->cond, &cpu->lock);
         current_cpu = self_cpu;
     }
+    cpu_mutex_unlock(cpu);
+
+    if (has_bql) {
+        qemu_mutex_lock_iothread();
+    }
 }
 
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
@@ -303,6 +336,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
+    bool has_bql = qemu_mutex_iothread_locked();
 
     qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
@@ -320,13 +354,23 @@ void process_queued_cpu_work(CPUState *cpu)
              * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
              * neither CPU can proceed.
              */
-            qemu_mutex_unlock_iothread();
+            if (has_bql) {
+                qemu_mutex_unlock_iothread();
+            }
             start_exclusive();
             wi->func(cpu, wi->data);
             end_exclusive();
-            qemu_mutex_lock_iothread();
+            if (has_bql) {
+                qemu_mutex_lock_iothread();
+            }
         } else {
-            wi->func(cpu, wi->data);
+            if (has_bql) {
+                wi->func(cpu, wi->data);
+            } else {
+                qemu_mutex_lock_iothread();
+                wi->func(cpu, wi->data);
+                qemu_mutex_unlock_iothread();
+            }
         }
         qemu_mutex_lock(&cpu->lock);
         if (wi->free) {
@@ -336,5 +380,5 @@ void process_queued_cpu_work(CPUState *cpu)
         }
     }
     qemu_mutex_unlock(&cpu->lock);
-    qemu_cond_broadcast(&qemu_work_cond);
+    qemu_cond_broadcast(&cpu->cond);
 }
diff --git a/cpus.c b/cpus.c
index 633734fb5c..e1f3327bbc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1191,7 +1191,7 @@ void qemu_init_cpu_loop(void)
 
 void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
-    do_run_on_cpu(cpu, func, data, &qemu_global_mutex);
+    do_run_on_cpu(cpu, func, data);
 }
 
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index bc0416829a..6594323d77 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -368,6 +368,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->lock);
+    qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4521bba7a5..9c3ec715e2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -333,6 +333,7 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @lock: Lock to prevent multiple access to per-CPU fields. Must be acquired
  *        after the BQL.
+ * @cond: Condition variable for per-CPU events.
  * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
@@ -378,6 +379,7 @@ struct CPUState {
 
     QemuMutex lock;
     /* fields below protected by @lock */
+    QemuCond cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
@@ -769,12 +771,10 @@ bool cpu_is_stopped(CPUState *cpu);
  * @cpu: The vCPU to run on.
  * @func: The function to be executed.
  * @data: Data to pass to the function.
- * @mutex: Mutex to release while waiting for @func to run.
  *
  * Used internally in the implementation of run_on_cpu.
  */
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
-                   QemuMutex *mutex);
+void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
 /**
  * run_on_cpu:
-- 
2.17.1


