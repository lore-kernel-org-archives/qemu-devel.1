Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFFEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EF42186A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TF8X0jiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EF42186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfGl-0007pK-Qi
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDT-0002eg-Sr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:29 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDO-0008Pk-Cr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:27 -0400
Received: by mail-qt1-x842.google.com with SMTP id k22so2751469qtm.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZYteIUkqExuWadWFdiCSlI10s1/zCIoztEZoLySpuAc=;
 b=TF8X0jiQLJdX49wvJNWN2EsKmh/+c0yHko7XgtzikAtgnaI0Y4mrYSZxsWOEAUdyWG
 jq6/qkzab3HtMsOqgl31+2qgEeD+TEhQ4MSIVRo7i/JlEs6g1/FIktPLPJqw2LWR55Sx
 /MKWheQmtNhLbxe43ti56Me9dvxauU56jaPQ8/j+G2XlMGc7llAM1m9SpPWi+ST+fcMd
 wuWdLJ9qRjgqZ8tehLZ8CeuHHgr02kT4P+MpgbiAr3ZPB0ANwhKasF4s+wd0CifsXBIA
 wnXSyVrC8+2GP1e506rLR+QaAAPUA2eE1gBwDI+DzAZlwzt3J8JmdfeKGPF2eNOn6aPM
 LpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZYteIUkqExuWadWFdiCSlI10s1/zCIoztEZoLySpuAc=;
 b=Diw5btKJujA5Vv7YvYixVPfTfqVG54b0tRgQabKZStONKapie6rMvWyyotNIie1GT3
 SgQC2dJ2gPin7Gw1pCl/wYzOLrbLRkpS6bUPdIIaei+kPPpuVoxLSkRhmo1q673AA2fA
 kwP6uVA7lV3y6FcWFHxOM0u3QLEFK8gaerUixEl8iU9DSs+knyIctJtnyDIfAQwYBypf
 TrhGKDL5TIzgIc/mPrHrYvrxdwOeMaoI5w8y1/S7TPJU9UYZYa5suThuh4nIGFRMww3w
 b7/6sVcz+WTGKeBA+osx7yH9KBSHPkwykuBikg/Hmjx+MMrIjuPGd5yshxtMUpbIlBSv
 /QBw==
X-Gm-Message-State: AOAM533ukJ1ssuCol39qEo3etRsjEZnkRw9/yKmIgBMZdjha51ac6wtR
 cwhl+cO8QR/XejtOsjYzf61vPOIyaiaebw==
X-Google-Smtp-Source: ABdhPJwKNZlTuHv3C0fd2aFWR3+Sk8y+ypqyE0OxIFFkv3MU6MipIpr1UjAtxHspmxpYi5AUcJ5I9w==
X-Received: by 2002:ac8:6f5c:: with SMTP id n28mr1097058qtv.269.1592427797718; 
 Wed, 17 Jun 2020 14:03:17 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:17 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 02/73] cpu: introduce cpu_mutex_lock/unlock
Date: Wed, 17 Jun 2020 17:01:20 -0400
Message-Id: <20200617210231.4393-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

The few direct users of &cpu->lock will be converted soon.

The per-thread bitmap introduced here might seem unnecessary,
since a bool could just do. However, once we complete the
conversion to per-vCPU locks, we will need to cover the use
case where all vCPUs are locked by the same thread, which
explains why the bitmap is introduced here.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Add assert in smp_parse. Make cpu_mutex_lock stub empty]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus.c                | 45 +++++++++++++++++++++++++++++++++++++++++--
 hw/core/machine.c     |  1 +
 include/hw/core/cpu.h | 36 ++++++++++++++++++++++++++++++++++
 stubs/Makefile.objs   |  1 +
 stubs/cpu-lock.c      | 20 +++++++++++++++++++
 5 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 stubs/cpu-lock.c

diff --git a/cpus.c b/cpus.c
index 3c011ec452..ca271411a4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -92,6 +92,44 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/*
+ * Note: we index the bitmap with cpu->cpu_index + 1 so that the logic
+ * also works during early CPU initialization, when cpu->cpu_index is set to
+ * UNASSIGNED_CPU_INDEX == -1.
+ */
+static __thread DECLARE_BITMAP(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
+
+bool no_cpu_mutex_locked(void)
+{
+    return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
+}
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
+/* coverity gets confused by the indirect function call */
+#ifdef __COVERITY__
+    qemu_mutex_lock_impl(&cpu->lock, file, line);
+#else
+    QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
+
+    g_assert(!cpu_mutex_locked(cpu));
+    set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+    f(&cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
+{
+    g_assert(cpu_mutex_locked(cpu));
+    qemu_mutex_unlock_impl(&cpu->lock, file, line);
+    clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+}
+
+bool cpu_mutex_locked(const CPUState *cpu)
+{
+    return test_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+}
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -101,9 +139,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
-    qemu_mutex_lock(&cpu->lock);
+    cpu_mutex_lock(cpu);
     ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    qemu_mutex_unlock(&cpu->lock);
+    cpu_mutex_unlock(cpu);
     return ret;
 }
 
@@ -1865,6 +1903,9 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 {
     QemuMutexLockFunc bql_lock = atomic_read(&qemu_bql_mutex_lock_func);
 
+    /* enforce locking order */
+    g_assert(no_cpu_mutex_locked());
+
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
     iothread_locked = true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1d80ab0e1d..74edd3c86d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -769,6 +769,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.threads = threads;
         ms->smp.sockets = sockets;
     }
+    assert(ms->smp.max_cpus <= CPU_LOCK_BITMAP_SIZE);
 
     if (ms->smp.cpus > 1) {
         Error *blocker = NULL;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index afc8081ca8..4d4006f1fb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -457,6 +457,39 @@ extern CPUTailQ cpus;
 
 extern __thread CPUState *current_cpu;
 
+/**
+ * cpu_mutex_lock - lock a CPU's mutex
+ * @cpu: the CPU whose mutex is to be locked
+ *
+ * To avoid deadlock, a CPU's mutex must be acquired after the BQL.
+ */
+#define cpu_mutex_lock(cpu)                             \
+    cpu_mutex_lock_impl(cpu, __FILE__, __LINE__)
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line);
+
+/**
+ * cpu_mutex_unlock - unlock a CPU's mutex
+ * @cpu: the CPU whose mutex is to be unlocked
+ */
+#define cpu_mutex_unlock(cpu)                           \
+    cpu_mutex_unlock_impl(cpu, __FILE__, __LINE__)
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line);
+
+/**
+ * cpu_mutex_locked - check whether a CPU's mutex is locked
+ * @cpu: the CPU of interest
+ *
+ * Returns true if the calling thread is currently holding the CPU's mutex.
+ */
+bool cpu_mutex_locked(const CPUState *cpu);
+
+/**
+ * no_cpu_mutex_locked - check whether any CPU mutex is held
+ *
+ * Returns true if the calling thread is not holding any CPU mutex.
+ */
+bool no_cpu_mutex_locked(void);
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
@@ -1184,4 +1217,7 @@ extern const VMStateDescription vmstate_cpu_common;
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
 
+/* XXX: is this really the max number of CPUs? */
+#define CPU_LOCK_BITMAP_SIZE 2048
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 28e48171d1..becf8f6986 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,6 +1,7 @@
 stub-obj-y += blk-commit-all.o
 stub-obj-y += cpu-get-clock.o
 stub-obj-y += cpu-get-icount.o
+stub-obj-y += cpu-lock.o
 stub-obj-y += dump.o
 stub-obj-y += error-printf.o
 stub-obj-y += fdset.o
diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
new file mode 100644
index 0000000000..1981a00fb3
--- /dev/null
+++ b/stubs/cpu-lock.c
@@ -0,0 +1,20 @@
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
+}
+
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
+{
+}
+
+bool cpu_mutex_locked(const CPUState *cpu)
+{
+    return true;
+}
+
+bool no_cpu_mutex_locked(void)
+{
+    return true;
+}
-- 
2.17.1


