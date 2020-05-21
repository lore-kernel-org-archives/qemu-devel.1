Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F21D20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uew8HBlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F21D20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbon0-00014W-GD
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJR-00051r-Be
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:53 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJP-0006zh-BC
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:53 -0400
Received: by mail-qk1-x742.google.com with SMTP id b6so7816050qkh.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xi82Dss/1dzX4RRWOX+gmxTFQne7MTM9AwBHg22gc90=;
 b=uew8HBlHDGKl7AHSLrM6zhF2B2VIbz40qRDe2F8phBk3GmkTTJCRJL9m79oi6yt1b1
 8UXDL07aXRWPRUdhDQJTV99CpolE7sCPlZY6w4lHdgKMTS8a6q9iDCIdotFbq3No++kh
 oHGEEA3H1rhrnbSP04fG0aJkVvpJalEnVBgAGYoN4QAbhGnrDYvVi+rx0sClfAyyUzLc
 PntO5yUXKv0a2O5WOd4EIftxr5SgTqazxjlZfbYwijWrMECVqmZ53Z2hbSOSA4bVYgUg
 6PZ4VZ/bXbDp0zY7PwdywTfM4+sz4Gfjgi3oBNxNm2yLUadiZD46hQXffXyt4ehWUWSO
 b8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xi82Dss/1dzX4RRWOX+gmxTFQne7MTM9AwBHg22gc90=;
 b=PLRlbeEUOVmSgpwZ/PYxQbw2ER7x6QV6zKeZ+o5xjJPitXXG7gx0bBZEV/JtmYwu5W
 G4c8+D0Z3iMf/2iFkmPms4GHLXYH9c2CF940b6xWFaD8cGCASSELaa8z7AoI50tUw8hn
 zXi6vNFyFXc0JL4OoJJgTh/UBh0qpkPrCC46ocZboShTKQDE64iRfsGkqlbDgMsYQ2FZ
 uQO3HGrZbnsh695QrhjDLdXYBxkqmYzJVYGWq/axu13qjqAFWuBm7EEhI2kpgkiv4ezk
 ACKJKeqceY8pXBQlISUc1qIitLpmy5SiTeu5Oo28IobaTyBViATnGTKyc3PjILX9z4Pv
 U81g==
X-Gm-Message-State: AOAM532s3cMXcDo8wzWilRlVYsgUa3/YHLPnB93om/OLX7djp8iHJRYM
 ej1ogmo1l58OdHbUGgTFP7pqVWXnTJJLGw==
X-Google-Smtp-Source: ABdhPJxuEwmZS2kChHZwKmgHZMT1JfjgNoY4ynoETgUcKz/b+EAu9p1u0wGrNZSwp0ZZbwk/j4ifRQ==
X-Received: by 2002:a05:620a:14ac:: with SMTP id
 x12mr10393538qkj.262.1590079489618; 
 Thu, 21 May 2020 09:44:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:48 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 71/74] cpu: protect CPU state with cpu->lock instead of the
 BQL
Date: Thu, 21 May 2020 12:40:08 -0400
Message-Id: <20200521164011.638-72-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Use the per-CPU locks to protect the CPUs' state, instead of
using the BQL. These locks are uncontended (they are mostly
acquired by the corresponding vCPU thread), so acquiring them
is cheaper than acquiring the BQL, which particularly in
MTTCG can be contended at high core counts.

In this conversion we drop qemu_cpu_cond and qemu_pause_cond,
and use cpu->cond instead.

In qom/cpu.c we can finally remove the ugliness that
results from having to hold both the BQL and the CPU lock;
now we just have to grab the CPU lock.

Removed g_assert(qemu_mutex_iothread_locked())
from qemu_tcg_rr_all_cpu_threads_idle().  There is an existing
case where we call qemu_tcg_rr_all_cpu_threads_idle() without
the BQL held.

Also changed qemu_cond_wait() to qemu_cond_timed_wait()
in qemu_tcg_rr_cpu_thread_fn() to fix issue where we might
miss the broadcast wakeup.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Adjusted assert and changed to use timed_wait]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus.c                | 288 +++++++++++++++++++++++++++++++-----------
 hw/core/cpu.c         |  29 +----
 include/hw/core/cpu.h |  20 +--
 3 files changed, 232 insertions(+), 105 deletions(-)

diff --git a/cpus.c b/cpus.c
index bcba0552bf..1dbb2fb3f9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -200,24 +200,30 @@ void cpu_mutex_destroy(CPUState *cpu)
     }
 }
 
-bool cpu_is_stopped(CPUState *cpu)
+/* Called with the CPU's lock held */
+static bool cpu_is_stopped_locked(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
 }
 
-static inline bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_is_stopped(CPUState *cpu)
 {
-    bool ret;
+    if (!cpu_mutex_locked(cpu)) {
+        bool ret;
 
-    cpu_mutex_lock(cpu);
-    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    cpu_mutex_unlock(cpu);
-    return ret;
+        cpu_mutex_lock(cpu);
+        ret = cpu_is_stopped_locked(cpu);
+        cpu_mutex_unlock(cpu);
+        return ret;
+    }
+    return cpu_is_stopped_locked(cpu);
 }
 
 static bool cpu_thread_is_idle(CPUState *cpu)
 {
-    if (cpu->stop || !cpu_work_list_empty(cpu)) {
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu->stop || !QSIMPLEQ_EMPTY(&cpu->work_list)) {
         return false;
     }
     if (cpu_is_stopped(cpu)) {
@@ -235,9 +241,16 @@ static bool qemu_tcg_rr_all_cpu_threads_idle(void)
     CPUState *cpu;
 
     g_assert(qemu_is_tcg_rr());
+    g_assert(no_cpu_mutex_locked());
 
     CPU_FOREACH(cpu) {
-        if (!cpu_thread_is_idle(cpu)) {
+        bool is_idle;
+
+        cpu_mutex_lock(cpu);
+        is_idle = cpu_thread_is_idle(cpu);
+        cpu_mutex_unlock(cpu);
+
+        if (!is_idle) {
             return false;
         }
     }
@@ -730,6 +743,8 @@ void qemu_start_warp_timer(void)
 
 static void qemu_account_warp_timer(void)
 {
+    g_assert(qemu_mutex_iothread_locked());
+
     if (!use_icount || !icount_sleep) {
         return;
     }
@@ -1066,6 +1081,7 @@ static void kick_tcg_thread(void *opaque)
 static void start_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
         tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                            kick_tcg_thread, NULL);
@@ -1078,6 +1094,7 @@ static void start_tcg_kick_timer(void)
 static void stop_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
         timer_del(tcg_kick_vcpu_timer);
     }
@@ -1179,6 +1196,8 @@ int vm_shutdown(void)
 
 static bool cpu_can_run(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     if (cpu->stop) {
         return false;
     }
@@ -1251,16 +1270,9 @@ static void qemu_init_sigbus(void)
 
 static QemuThread io_thread;
 
-/* cpu creation */
-static QemuCond qemu_cpu_cond;
-/* system init */
-static QemuCond qemu_pause_cond;
-
 void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
-    qemu_cond_init(&qemu_cpu_cond);
-    qemu_cond_init(&qemu_pause_cond);
     qemu_mutex_init(&qemu_global_mutex);
 
     qemu_thread_get_self(&io_thread);
@@ -1278,39 +1290,60 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
+static void qemu_cpu_stop_locked(CPUState *cpu, bool exit)
 {
+    g_assert(cpu_mutex_locked(cpu));
     g_assert(qemu_cpu_is_self(cpu));
     cpu->stop = false;
     cpu->stopped = true;
     if (exit) {
         cpu_exit(cpu);
     }
-    qemu_cond_broadcast(&qemu_pause_cond);
+    qemu_cond_broadcast(&cpu->cond);
+}
+
+static void qemu_cpu_stop(CPUState *cpu, bool exit)
+{
+    cpu_mutex_lock(cpu);
+    qemu_cpu_stop_locked(cpu, exit);
+    cpu_mutex_unlock(cpu);
 }
 
 static void qemu_wait_io_event_common(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
+        qemu_cpu_stop_locked(cpu, false);
     }
+    /*
+     * unlock+lock cpu_mutex, so that other vCPUs have a chance to grab the
+     * lock and queue some work for this vCPU.
+     */
+    cpu_mutex_unlock(cpu);
     process_queued_cpu_work(cpu);
+    cpu_mutex_lock(cpu);
 }
 
 static void qemu_tcg_rr_wait_io_event(void)
 {
     CPUState *cpu;
 
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(no_cpu_mutex_locked());
+
     while (qemu_tcg_rr_all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(first_cpu->halt_cond, first_cpu->lock);
     }
 
     start_tcg_kick_timer();
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         qemu_wait_io_event_common(cpu);
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -1318,12 +1351,15 @@ static void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
+    g_assert(cpu_mutex_locked(cpu));
+    g_assert(!qemu_mutex_iothread_locked());
+
     while (cpu_thread_is_idle(cpu)) {
         if (!slept) {
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(cpu->halt_cond, cpu->lock);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
@@ -1346,6 +1382,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1358,15 +1395,21 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     }
 
     kvm_init_cpu_signals(cpu);
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = kvm_cpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1374,10 +1417,16 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     qemu_kvm_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1394,7 +1443,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1405,11 +1454,11 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
-        qemu_mutex_unlock_iothread();
+        cpu_mutex_unlock(cpu);
         do {
             int sig;
             r = sigwait(&waitset, &sig);
@@ -1418,11 +1467,11 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
             perror("sigwait");
             exit(1);
         }
-        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug);
 
-    qemu_mutex_unlock_iothread();
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 #endif
@@ -1462,6 +1511,8 @@ static int64_t tcg_get_icount_limit(void)
 static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
+    g_assert(qemu_mutex_iothread_locked());
+
     if (use_icount) {
         int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                                       QEMU_TIMER_ATTR_ALL);
@@ -1542,12 +1593,15 @@ static void deal_with_unplugged_cpus(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (cpu->unplug && !cpu_can_run(cpu)) {
             qemu_tcg_destroy_vcpu(cpu);
             cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
+            qemu_cond_signal(&cpu->cond);
+            cpu_mutex_unlock(cpu);
             break;
         }
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -1568,25 +1622,45 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
+    /*
+     * We call cpu_mutex_lock/unlock just to please the assertions in common
+     * code, since here cpu->lock is an alias to the BQL.
+     */
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
-
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
     cpu->can_do_io = 1;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
+    cpu_mutex_lock(first_cpu);
     while (first_cpu->stopped) {
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        /*
+         * a timedwait is needed since this gets kicked off
+         * by a cond_broadcast, and it is possible
+         * to not be woken up by the broadcast if we are
+         * not waiting when the broadcast is sent.
+         */
+        qemu_cond_timedwait(first_cpu->halt_cond,
+                            first_cpu->lock,
+                            100);
+        cpu_mutex_unlock(first_cpu);
 
         /* process any pending work */
         CPU_FOREACH(cpu) {
             current_cpu = cpu;
+            cpu_mutex_lock(cpu);
             qemu_wait_io_event_common(cpu);
+            cpu_mutex_unlock(cpu);
         }
+
+        cpu_mutex_lock(first_cpu);
     }
+    cpu_mutex_unlock(first_cpu);
 
     start_tcg_kick_timer();
 
@@ -1613,7 +1687,12 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+        while (cpu) {
+            cpu_mutex_lock(cpu);
+            if (!QSIMPLEQ_EMPTY(&cpu->work_list) || cpu->exit_request) {
+                cpu_mutex_unlock(cpu);
+                break;
+            }
 
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu = cpu;
@@ -1624,6 +1703,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             if (cpu_can_run(cpu)) {
                 int r;
 
+                cpu_mutex_unlock(cpu);
                 qemu_mutex_unlock_iothread();
                 prepare_icount_for_run(cpu);
 
@@ -1631,11 +1711,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 
                 process_icount_data(cpu);
                 qemu_mutex_lock_iothread();
+                cpu_mutex_lock(cpu);
 
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
+                    cpu_mutex_unlock(cpu);
                     break;
                 } else if (r == EXCP_ATOMIC) {
+                    cpu_mutex_unlock(cpu);
                     qemu_mutex_unlock_iothread();
                     cpu_exec_step_atomic(cpu);
                     qemu_mutex_lock_iothread();
@@ -1645,11 +1728,15 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                 if (cpu->unplug) {
                     cpu = CPU_NEXT(cpu);
                 }
+                cpu_mutex_unlock(current_cpu);
                 break;
             }
 
+            cpu_mutex_unlock(cpu);
             cpu = CPU_NEXT(cpu);
-        } /* while (cpu && !cpu->exit_request).. */
+        } /* for (;;) .. */
+
+        g_assert(no_cpu_mutex_locked());
 
         /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
         atomic_set(&tcg_current_rr_cpu, NULL);
@@ -1681,6 +1768,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1688,12 +1776,18 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = hax_smp_cpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1701,6 +1795,8 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
+
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1718,6 +1814,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1725,15 +1822,21 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hvf_init_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = hvf_vcpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1741,10 +1844,16 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1757,6 +1866,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     current_cpu = cpu;
@@ -1766,29 +1876,41 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
         fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
         exit(1);
     }
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = whpx_vcpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
         while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+            qemu_cond_wait(cpu->halt_cond, cpu->lock);
         }
         qemu_wait_io_event_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     whpx_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1816,14 +1938,14 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
     cpu->can_do_io = 1;
     current_cpu = cpu;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
@@ -1832,9 +1954,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     do {
         if (cpu_can_run(cpu)) {
             int r;
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             r = tcg_cpu_exec(cpu);
-            qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
             switch (r) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
@@ -1850,9 +1972,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
+                cpu_mutex_unlock(cpu);
                 cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
+                cpu_mutex_lock(cpu);
             default:
                 /* Ignore everything else? */
                 break;
@@ -1865,8 +1987,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
     qemu_tcg_destroy_vcpu(cpu);
     cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1973,54 +2095,69 @@ void qemu_cond_wait_iothread(QemuCond *cond)
     qemu_cond_wait(cond, &qemu_global_mutex);
 }
 
-static bool all_vcpus_paused(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (!cpu->stopped) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 void pause_all_vcpus(void)
 {
     CPUState *cpu;
 
+    g_assert(no_cpu_mutex_locked());
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (qemu_cpu_is_self(cpu)) {
             qemu_cpu_stop(cpu, true);
         } else {
             cpu->stop = true;
             qemu_cpu_kick(cpu);
         }
+        cpu_mutex_unlock(cpu);
     }
 
+ drop_locks_and_stop_all_vcpus:
     /* We need to drop the replay_lock so any vCPU threads woken up
      * can finish their replay tasks
      */
     replay_mutex_unlock();
+    qemu_mutex_unlock_iothread();
 
-    while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
-        CPU_FOREACH(cpu) {
+    CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
+        if (!cpu->stopped) {
+            cpu->stop = true;
             qemu_cpu_kick(cpu);
+            qemu_cond_wait(&cpu->cond, cpu->lock);
         }
+        cpu_mutex_unlock(cpu);
     }
 
-    qemu_mutex_unlock_iothread();
     replay_mutex_lock();
     qemu_mutex_lock_iothread();
+
+    /* a CPU might have been hot-plugged while we weren't holding the BQL */
+    CPU_FOREACH(cpu) {
+        bool stopped;
+
+        cpu_mutex_lock(cpu);
+        stopped = cpu->stopped;
+        cpu_mutex_unlock(cpu);
+
+        if (!stopped) {
+            goto drop_locks_and_stop_all_vcpus;
+        }
+    }
 }
 
 void cpu_resume(CPUState *cpu)
 {
-    cpu->stop = false;
-    cpu->stopped = false;
+    if (cpu_mutex_locked(cpu)) {
+        cpu->stop = false;
+        cpu->stopped = false;
+    } else {
+        cpu_mutex_lock(cpu);
+        cpu->stop = false;
+        cpu->stopped = false;
+        cpu_mutex_unlock(cpu);
+    }
     qemu_cpu_kick(cpu);
 }
 
@@ -2040,8 +2177,11 @@ void resume_all_vcpus(void)
 
 void cpu_remove_sync(CPUState *cpu)
 {
+    cpu_mutex_lock(cpu);
     cpu->stop = true;
     cpu->unplug = true;
+    cpu_mutex_unlock(cpu);
+
     qemu_cpu_kick(cpu);
     qemu_mutex_unlock_iothread();
     qemu_thread_join(cpu->thread);
@@ -2225,9 +2365,15 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_dummy_start_vcpu(cpu);
     }
 
+    qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+        qemu_cond_wait(&cpu->cond, cpu->lock);
     }
+    cpu_mutex_unlock(cpu);
+
+    qemu_mutex_lock_iothread();
 }
 
 void cpu_stop_current(void)
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index ee20f8e0ad..2288de90f8 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -95,32 +95,13 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool has_bql = qemu_mutex_iothread_locked();
-    bool has_cpu_lock = cpu_mutex_locked(cpu);
-
-    if (has_bql) {
-        if (has_cpu_lock) {
-            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-        } else {
-            cpu_mutex_lock(cpu);
-            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-            cpu_mutex_unlock(cpu);
-        }
-        return;
-    }
-
-    if (has_cpu_lock) {
-        cpu_mutex_unlock(cpu);
-    }
-    qemu_mutex_lock_iothread();
-    cpu_mutex_lock(cpu);
-    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-    qemu_mutex_unlock_iothread();
-    if (!has_cpu_lock) {
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+    } else {
+        cpu_mutex_lock(cpu);
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
         cpu_mutex_unlock(cpu);
     }
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9766477e62..8478628fdb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -312,10 +312,6 @@ struct qemu_work_item;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
  * @interrupt_request: Indicates a pending interrupt request.
- * @halted: Nonzero if the CPU is in suspended state.
- * @stop: Indicates a pending stop request.
- * @stopped: Indicates the CPU has been artificially stopped.
- * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
@@ -340,6 +336,10 @@ struct qemu_work_item;
  *        after the BQL.
  * @cond: Condition variable for per-CPU events.
  * @work_list: List of pending asynchronous work.
+ * @halted: Nonzero if the CPU is in suspended state.
+ * @stop: Indicates a pending stop request.
+ * @stopped: Indicates the CPU has been artificially stopped.
+ * @unplug: Indicates a pending CPU unplug request.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
@@ -364,12 +364,7 @@ struct CPUState {
 #endif
     int thread_id;
     bool running, has_waiter;
-    struct QemuCond *halt_cond;
     bool thread_kicked;
-    bool created;
-    bool stop;
-    bool stopped;
-    bool unplug;
     bool crash_occurred;
     bool exit_request;
     bool in_exclusive_context;
@@ -385,7 +380,13 @@ struct CPUState {
     QemuMutex *lock;
     /* fields below protected by @lock */
     QemuCond cond;
+    QemuCond *halt_cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
+    uint32_t halted;
+    bool created;
+    bool stop;
+    bool stopped;
+    bool unplug;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
@@ -431,7 +432,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
 
-- 
2.17.1


