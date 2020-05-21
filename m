Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5630F2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYOcTp/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5630F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboKs-0007c9-DI
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI3-0001p5-Af
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:27 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI2-0006V5-2H
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:26 -0400
Received: by mail-qt1-x844.google.com with SMTP id i68so6005551qtb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gOAJ9vmaNi5fhkFh/LZcc0lHcqZy9RW0PLEEr1p6jHs=;
 b=jYOcTp/ysJNDBzbDlyACVOmNRDGTCVjvL82LZgV0iG4BZR+6Uh+yzSJBhnNR88Q65a
 3u009ARfPOiYF+VbBnFPXEoR2p3HwamfqM4p7ao8G8E0FxZ7QR8Nm/4GrXUfHM15fUX7
 XBFbtWu+jaX9WR9ol1atYmM5M+Uj8llNs4h4h6nsKn+fY68dEz/SAas1yUwU6QvVAz3N
 GVg91Rmn7+sHYH5wUllg+gRYmF/2/LN+c+1rp/fyo3nE4uKeKQj6cE5U8VdMr4spCtD9
 QKdkEGjTfKKIoJ3GlAZgCL5329Zz0/J9tIe50Ew+0hWzmTlaBbcpv9hCy73ogJ7UstNA
 eMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gOAJ9vmaNi5fhkFh/LZcc0lHcqZy9RW0PLEEr1p6jHs=;
 b=LHqlmVABwXrwkCGKlidmEDowhd9TDqc/2WGmK0ODYP+oCoRMoSfLB0ZIBtcDADg696
 dKAM1Lv0CrHd2ptAvfqf/SqfxMTVCAczDrh78elqgcdt10CIFbGMt3RLPJ4zt6XfcFQn
 CT0Tfhh34/FXtL3pq+W10KSVnWCvmSkJYe7hoTBY0cVoV9FOtJwiScunUGQ2M6HBtIiB
 91uB+ImvfRvhBJe1ie8ZyvGLKbzC1A1qzrpwgdGyGt+34R8I5Q6jgZnlqJWRL8ypUtWl
 2PyIq69LPS7LGZddOc4+/F8VcLZx0Q8dNIWfvfTtD4oKdkI+lpjdh5IqeakO4KYLsWwj
 HteA==
X-Gm-Message-State: AOAM533Z9Ou7u9t14B3MpkhV0VTOWDxWaF9ExUp41HGF8yN6VhAX1APn
 AKvs+4Mcg/oD3mfFOtxZ5GyxTN2bG5PzOA==
X-Google-Smtp-Source: ABdhPJz0W4zovLCjhFN+KHaSOwfK6qeHA5PySSBtOBrOY5BgAyQAjZHGsgC/ypXXieUTSwaBRo7N/g==
X-Received: by 2002:ac8:393a:: with SMTP id s55mr11521271qtb.48.1590079403681; 
 Thu, 21 May 2020 09:43:23 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:23 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 07/74] cpu: make per-CPU locks an alias of the BQL in TCG
 rr mode
Date: Thu, 21 May 2020 12:39:04 -0400
Message-Id: <20200521164011.638-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
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

Before we can switch from the BQL to per-CPU locks in
the CPU loop, we have to accommodate the fact that TCG
rr mode (i.e. !MTTCG) cannot work with separate per-vCPU
locks. That would lead to deadlock since we need a single
lock/condvar pair on which to wait for events that affect
any vCPU, e.g. in qemu_tcg_rr_wait_io_event.

At the same time, we are moving towards an interface where
the BQL and CPU locks are independent, and the only requirement
is that the locking order is respected, i.e. the BQL is
acquired first if both locks have to be held at the same time.

In this patch we make the BQL a recursive lock under the hood.
This allows us to (1) keep the BQL and CPU locks interfaces
separate, and (2) use a single lock for all vCPUs in TCG rr mode.

Note that the BQL's API (qemu_mutex_lock/unlock_iothread) remains
non-recursive.

Added cpu_mutex_destroy, and call from cpu_common_finalize,
to avoid destroying qemu_global_mutex, when cpu mutex is destroyed.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Fixed destroy issue, added cpu_mutex_destroy.]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         |   2 +-
 cpus.c                | 101 ++++++++++++++++++++++++++++++++++++++----
 hw/core/cpu.c         |   5 ++-
 include/hw/core/cpu.h |   8 +++-
 stubs/cpu-lock.c      |   7 +++
 5 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index e2f609c8e2..d418eb5aef 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -161,7 +161,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-        qemu_cond_wait(&cpu->cond, &cpu->lock);
+        qemu_cond_wait(&cpu->cond, cpu->lock);
         current_cpu = self_cpu;
     }
     cpu_mutex_unlock(cpu);
diff --git a/cpus.c b/cpus.c
index 935fff6e4e..9cc5f4767e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -92,6 +92,12 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+static inline bool qemu_is_tcg_rr(void)
+{
+    /* in `make check-qtest', "use_icount && !tcg_enabled()" might be true */
+    return use_icount || (tcg_enabled() && !qemu_tcg_mttcg_enabled());
+}
+
 /*
  * Note: we index the bitmap with cpu->cpu_index + 1 so that the logic
  * also works during early CPU initialization, when cpu->cpu_index is set to
@@ -104,25 +110,75 @@ bool no_cpu_mutex_locked(void)
     return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
 }
 
-void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+static __thread bool iothread_locked;
+/*
+ * In TCG rr mode, we make the BQL a recursive mutex, so that we can use it for
+ * all vCPUs while keeping the interface as if the locks were per-CPU.
+ *
+ * The fact that the BQL is implemented recursively is invisible to BQL users;
+ * the mutex API we export (qemu_mutex_lock_iothread() etc.) is non-recursive.
+ *
+ * Locking order: the BQL is always acquired before CPU locks.
+ */
+static __thread int iothread_lock_count;
+
+static void rr_cpu_mutex_lock(void)
 {
-/* coverity gets confused by the indirect function call */
+    if (iothread_lock_count++ == 0) {
+        /*
+         * Circumvent qemu_mutex_lock_iothread()'s state keeping by
+         * acquiring the BQL directly.
+         */
+        qemu_mutex_lock(&qemu_global_mutex);
+    }
+}
+
+static void rr_cpu_mutex_unlock(void)
+{
+    g_assert(iothread_lock_count > 0);
+    if (--iothread_lock_count == 0) {
+        /*
+         * Circumvent qemu_mutex_unlock_iothread()'s state keeping by
+         * releasing the BQL directly.
+         */
+        qemu_mutex_unlock(&qemu_global_mutex);
+    }
+}
+
+static void do_cpu_mutex_lock(CPUState *cpu, const char *file, int line)
+{
+    /* coverity gets confused by the indirect function call */
 #ifdef __COVERITY__
-    qemu_mutex_lock_impl(&cpu->lock, file, line);
+    qemu_mutex_lock_impl(cpu->lock, file, line);
 #else
     QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
 
+    f(cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
     g_assert(!cpu_mutex_locked(cpu));
     set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
-    f(&cpu->lock, file, line);
-#endif
+
+    if (qemu_is_tcg_rr()) {
+        rr_cpu_mutex_lock();
+    } else {
+        do_cpu_mutex_lock(cpu, file, line);
+    }
 }
 
 void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
 {
     g_assert(cpu_mutex_locked(cpu));
-    qemu_mutex_unlock_impl(&cpu->lock, file, line);
     clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+
+    if (qemu_is_tcg_rr()) {
+        rr_cpu_mutex_unlock();
+        return;
+    }
+    qemu_mutex_unlock_impl(cpu->lock, file, line);
 }
 
 bool cpu_mutex_locked(const CPUState *cpu)
@@ -130,6 +186,20 @@ bool cpu_mutex_locked(const CPUState *cpu)
     return test_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
 }
 
+void cpu_mutex_destroy(CPUState *cpu)
+{
+    /*
+     * In TCG RR, cpu->lock is the BQL under the hood. In all other modes,
+     * cpu->lock is a standalone per-CPU lock.
+     */
+    if (qemu_is_tcg_rr()) {
+        cpu->lock = NULL;
+    } else {
+        qemu_mutex_destroy(cpu->lock);
+        g_free(cpu->lock);
+    }
+}
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -1863,8 +1933,6 @@ bool qemu_in_vcpu_thread(void)
     return current_cpu && qemu_cpu_is_self(current_cpu);
 }
 
-static __thread bool iothread_locked = false;
-
 bool qemu_mutex_iothread_locked(void)
 {
     return iothread_locked;
@@ -1883,6 +1951,8 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
+    g_assert(iothread_lock_count == 0);
+    iothread_lock_count++;
     iothread_locked = true;
 }
 
@@ -1890,7 +1960,10 @@ void qemu_mutex_unlock_iothread(void)
 {
     g_assert(qemu_mutex_iothread_locked());
     iothread_locked = false;
-    qemu_mutex_unlock(&qemu_global_mutex);
+    g_assert(iothread_lock_count > 0);
+    if (--iothread_lock_count == 0) {
+        qemu_mutex_unlock(&qemu_global_mutex);
+    }
 }
 
 void qemu_cond_wait_iothread(QemuCond *cond)
@@ -2126,6 +2199,16 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
+    /*
+     * In TCG RR, cpu->lock is the BQL under the hood. In all other modes,
+     * cpu->lock is a standalone per-CPU lock.
+     */
+    if (qemu_is_tcg_rr()) {
+        qemu_mutex_destroy(cpu->lock);
+        g_free(cpu->lock);
+        cpu->lock = &qemu_global_mutex;
+    }
+
     if (kvm_enabled()) {
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 9b9d4296f9..620feed3e9 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -367,7 +367,8 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->lock);
+    cpu->lock = g_new(QemuMutex, 1);
+    qemu_mutex_init(cpu->lock);
     qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
@@ -380,7 +381,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
-    qemu_mutex_destroy(&cpu->lock);
+    cpu_mutex_destroy(cpu);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fe79777502..2959ed1b49 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -377,7 +377,7 @@ struct CPUState {
     uint64_t random_seed;
     sigjmp_buf jmp_env;
 
-    QemuMutex lock;
+    QemuMutex *lock;
     /* fields below protected by @lock */
     QemuCond cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
@@ -485,6 +485,12 @@ void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line);
  */
 bool cpu_mutex_locked(const CPUState *cpu);
 
+/**
+ * cpu_mutex_destroy - Handle how to destroy this CPU's mutex
+ * @cpu: the CPU whose mutex to destroy
+ */
+void cpu_mutex_destroy(CPUState *cpu);
+
 /**
  * no_cpu_mutex_locked - check whether any CPU mutex is held
  *
diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
index 1981a00fb3..97a81f447d 100644
--- a/stubs/cpu-lock.c
+++ b/stubs/cpu-lock.c
@@ -18,3 +18,10 @@ bool no_cpu_mutex_locked(void)
 {
     return true;
 }
+
+void cpu_mutex_destroy(CPUState *cpu)
+{
+    qemu_mutex_destroy(cpu->lock);
+    g_free(cpu->lock);
+    cpu->lock = NULL;
+}
-- 
2.17.1


