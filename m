Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19E1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9184E2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3/we0bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9184E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboKf-0007Kr-NP
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHx-0001cv-Gb
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:21 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHv-0006TF-6E
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:21 -0400
Received: by mail-qt1-x844.google.com with SMTP id m44so5980524qtm.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XkuJ6MkZisGtrqNcI/WmjmrJib8LTmp/yxFiG3GQPeA=;
 b=q3/we0bWpMx2wZYtvNo7PDfKbGGLd1MU7T2yd8K3VQCepk6ILUxIUVlKeYd2TKHYva
 DbwPOgaKDfpYeqFy87uJ8NBd4ZgWHpIdY/rxr86qceO5fF/VDPKhTwiNOkQja8pToIJR
 LKRaH+xnVRWTbkKVo0auD2RtPpg6ieznb3DND5XPHt3B5VVyG7orv749L3IbxCqMeN70
 LyddUZe5/Kdlwx6zjb06cj0xynwcGt2M4rIzRbk21X6zTM5bd1AvROjJU/9TC0C1HAhm
 YK75CqBOoyNlZ7/T9SK6StIPnjh+st4UVAoQVseT7REkwtVe2V7s/whfWdHqIJP0CgDI
 u2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XkuJ6MkZisGtrqNcI/WmjmrJib8LTmp/yxFiG3GQPeA=;
 b=TFAgyS112mauIQPte9gKJCT+FtYnmALU290UWrg2EzXtdRlJVI+J4cHhSQQKPLNiUq
 mWeVKijaOWK1t98HcNvQnU5Yqu7rwkka5modmxARGSb85XVtKKO5oEt16YDqkFEf/keG
 oX80YcXYQFH/Zc2vuBSpghI0M0Jy6pCKhFzzVFHqUgfRgSkroEsOCmNmhWZPbhy0Oh0x
 xSBIJff1Q/h4syiWcb9vW9ZKztsrSLRVaZkveS6bVUQT1RVvcObhqm5vvQN+hoEmV4QS
 wpWcwDOxdwiLDbdJhBMIGcDRMtnenH/DCe/Opr07lzj5YbkWd1R02jP1FpE5WFoVuk1F
 LN4w==
X-Gm-Message-State: AOAM5314x4TDST4nTLTkYQ4bFK4l9bdXSWWRB79TWTHYc+RYI0c1Y/uq
 4U+BmmVSYkhaTzLnsD9FqZCFYgG+f28HBA==
X-Google-Smtp-Source: ABdhPJzVzUwKTxuOR8q6Lhlfvb+TG02ayREFkvuJz6uDhW3g1IOY0w5Zc+M3uyDgyOvXFljDSG1zYg==
X-Received: by 2002:ac8:4f4e:: with SMTP id i14mr11835684qtw.167.1590079397651; 
 Thu, 21 May 2020 09:43:17 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:17 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 03/74] cpu: introduce cpu_mutex_lock/unlock
Date: Thu, 21 May 2020 12:39:00 -0400
Message-Id: <20200521164011.638-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
index 77a2d7b7cf..c2da430221 100644
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
 
@@ -1845,6 +1883,9 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 {
     QemuMutexLockFunc bql_lock = atomic_read(&qemu_bql_mutex_lock_func);
 
+    /* enforce locking order */
+    g_assert(no_cpu_mutex_locked());
+
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
     iothread_locked = true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b18b1..03a9081f55 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -763,6 +763,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.threads = threads;
         ms->smp.sockets = sockets;
     }
+    assert(ms->smp.max_cpus <= CPU_LOCK_BITMAP_SIZE);
 
     if (ms->smp.cpus > 1) {
         Error *blocker = NULL;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 873bf23a39..2912d9a7c1 100644
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
@@ -1179,4 +1212,7 @@ extern const VMStateDescription vmstate_cpu_common;
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
 
+/* XXX: is this really the max number of CPUs? */
+#define CPU_LOCK_BITMAP_SIZE 2048
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed..d2dd6c94cc 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -5,6 +5,7 @@ stub-obj-y += blockdev-close-all-bdrv-states.o
 stub-obj-y += clock-warp.o
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


