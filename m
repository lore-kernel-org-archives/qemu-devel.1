Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A28C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F3E21582
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt4xqudC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F3E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfGu-000892-0O
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDS-0002dT-2G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:26 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDO-0008Pv-Co
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:25 -0400
Received: by mail-qt1-x841.google.com with SMTP id w9so2761265qtv.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pQeS3ErQJYe6lUMZTvW4HI5IzahbrklWfBxpVQvJbIg=;
 b=Zt4xqudCRQ0OUAqxQ8rsAwSTaiB7Ot9EnCA+XPlHCfM1HpEPiuTaGSlQNU0nM6R9Xk
 zsqX3HrWFtcYLMkGwt1QkSmVLIrKyj3jLzV6YHigqNioDLLu1PIlxhw7KpT7CgIQfxyC
 gvSWI5KSo3ZoZCU3Y6d9+6H33bnrC51Wp004WhWtTQ+/tHxbajTZsk0NemVmPNI+0NLJ
 k1cW6nIIXIHSEBbCWywd8U+Ddz9dMdtShANprE9XMWnEjUijiz0ReLu2s3oh0Cmn5vfY
 MQRHNFPpeVdJQUBsguK3NunKDflIpP0dVdQRwmc++ZxCV65ZXISsPWrIyMLIdXn0SU8L
 LROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pQeS3ErQJYe6lUMZTvW4HI5IzahbrklWfBxpVQvJbIg=;
 b=oif95DmAGlL9BX/bVxXa33TW7vjm4CEz1jL8ZfxyAdjJDaYg0LSDL2v2OSnv4CEvNt
 /4ZPp8YKYufo1dQ/OP7+TDEaRBLDFRmLwpJmnrxa1d4h5Cw06NJh7bkEAmACXORJAmHY
 KzkACe9PMJrtvEkmWDLc3EMHRco836gv8n4y+aiJxTCECD9JlaOqLGHsW54FesJlQEx+
 6qsO8Bq4MCMCLxEvlmzb2enuEZsFNjDb3j4D4mY7QPwpKae+Ucn4jfcBUUVXfUmj63Aq
 U99yKJUj5C8TlZiN/L+9+YDVuChNlir/VdiPXcDKnXrptkkeKjXd6Q3ojVAMhCqDGNDX
 gE6g==
X-Gm-Message-State: AOAM532r3pmvVFL5/Y9Gajhbsfhfh4Wp1BHTyOMPoUfz+DCUweeFTHti
 3OW7knNN3dK949PPkm9vZkrii/1/CVU74g==
X-Google-Smtp-Source: ABdhPJwm4Prd7s/y/OVV2BowxMoBKxWpU3jOeN1DGr3xq9PrniQQLBtETI11mggJBHQtC9Aa+9B4oA==
X-Received: by 2002:ac8:538b:: with SMTP id x11mr1116947qtp.84.1592427799432; 
 Wed, 17 Jun 2020 14:03:19 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:18 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 03/73] cpu: make qemu_work_cond per-cpu
Date: Wed, 17 Jun 2020 17:01:21 -0400
Message-Id: <20200617210231.4393-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
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
index 622430bd33..57d9fc6ea1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -27,7 +27,6 @@
 static QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
 static QemuCond exclusive_resume;
-static QemuCond qemu_work_cond;
 
 /* >= 1 if a thread is inside start_exclusive/end_exclusive.  Written
  * under qemu_cpu_list_lock, read with atomic operations.
@@ -43,7 +42,6 @@ void qemu_init_cpu_list(void)
     qemu_mutex_init(&qemu_cpu_list_lock);
     qemu_cond_init(&exclusive_cond);
     qemu_cond_init(&exclusive_resume);
-    qemu_cond_init(&qemu_work_cond);
 }
 
 void cpu_list_lock(void)
@@ -103,23 +101,37 @@ struct qemu_work_item {
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
 
@@ -129,13 +141,34 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
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
@@ -299,6 +332,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
+    bool has_bql = qemu_mutex_iothread_locked();
 
     qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
@@ -316,13 +350,23 @@ void process_queued_cpu_work(CPUState *cpu)
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
@@ -332,5 +376,5 @@ void process_queued_cpu_work(CPUState *cpu)
         }
     }
     qemu_mutex_unlock(&cpu->lock);
-    qemu_cond_broadcast(&qemu_work_cond);
+    qemu_cond_broadcast(&cpu->cond);
 }
diff --git a/cpus.c b/cpus.c
index ca271411a4..035f41a997 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1216,7 +1216,7 @@ void qemu_init_cpu_loop(void)
 
 void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
-    do_run_on_cpu(cpu, func, data, &qemu_global_mutex);
+    do_run_on_cpu(cpu, func, data);
 }
 
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 1cba5b6e69..07251d83df 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -370,6 +370,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->lock);
+    qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4d4006f1fb..ebff239ad3 100644
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
@@ -774,12 +776,10 @@ bool cpu_is_stopped(CPUState *cpu);
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


