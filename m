Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE5220714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSVbA04h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE5220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYLD-0007Y0-JZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJq-0005mQ-Ua
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJp-0001Is-7q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:34 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:46256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJp-0001Ic-3j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:33 -0400
Received: by mail-qk1-x741.google.com with SMTP id u4so8128772qkj.13
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DCB93cdn2Qb7Y87FHZR+VFQPG5cNVFn4rY2y2Awttv0=;
 b=BSVbA04hoBpnyEpcPrEsizuGHI8Z6FthobjRdk6PUDHAwgkmGAFgvbFf6TtKOyN0x6
 6sJxOG45lUQ49ZKSEGmR2P6DtHE3gqnFbX8kR0Uzb7cmzIgMShpUVzJklXHA58Xht1Bu
 9K4LZ1OFVlE2cx3etGEDEMSouhoalxWpU0Jnp7IfaHhjWaSLBpLPsG+61vUp2aE7uzKh
 Gco4/nH9+M8YE1f0x/JPTzD6pKAjpcYZLNtDDp1DSq0rvue6Z0E6Ze6fNfYVBxeblTvb
 tl4qmRXBCQihaq6+NRltxYIInIzY3IIYF3cKh348CYCUZ1FAbQ09qCMK4RGJGqn+HBLN
 6GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DCB93cdn2Qb7Y87FHZR+VFQPG5cNVFn4rY2y2Awttv0=;
 b=eHX+F8p7sainbncyemNgxpvrUHayf5xJFwFmhaKaOt/Qq3H5o5HMrKl7TfXN79/RED
 92twaAIm7ORb1c5D+BPP9aoaXvPXVhX5BHQrJ71UObq45PEtkUBYv24xKRTppfWox49X
 m9mU/YnZtqsFfLxsv3YR62G5J7TtYO00RosmPdwfaS57KsJSgADuLlvGqd2ops0wHskj
 YCQMsfR576ZRsyMPdgUi4rCdTTeBgL41YXNAb/g7MAFY6BCr4vlgfnn23OydFlVPUfMx
 Cn1fgftLOkaNC9iTJjTvxUVtxx/VWorLVv6VbUELeCsfu8wNpz9kEdoifx6csWGMVpSy
 MZRg==
X-Gm-Message-State: ANhLgQ3R0YPHwvFY21ukqZrE85JcQBTRzR2KAjazewHZP6b8XjkHxVDm
 lROhFJYN/UqI+4j9VTl4oth1O0eVF7LT+w==
X-Google-Smtp-Source: ADFU+vtfp136Tq7UGJS7CkbcJ9ZyNpSeDv2uTdWuIBE1aJPr1YW8vlRO/RZuBxUpeAMA/wrpJUSReg==
X-Received: by 2002:a37:b17:: with SMTP id 23mr10522631qkl.326.1585251452089; 
 Thu, 26 Mar 2020 12:37:32 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 03/74] cpu: introduce cpu_mutex_lock/unlock
Date: Thu, 26 Mar 2020 15:30:45 -0400
Message-Id: <20200326193156.4322-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

The few direct users of &cpu->lock will be converted soon.

The per-thread bitmap introduced here might seem unnecessary,
since a bool could just do. However, once we complete the
conversion to per-vCPU locks, we will need to cover the use
case where all vCPUs are locked by the same thread, which
explains why the bitmap is introduced here.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus.c                | 48 +++++++++++++++++++++++++++++++++++++++++--
 include/hw/core/cpu.h | 33 +++++++++++++++++++++++++++++
 stubs/Makefile.objs   |  1 +
 stubs/cpu-lock.c      | 28 +++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 stubs/cpu-lock.c

diff --git a/cpus.c b/cpus.c
index 71bd2f5d55..633734fb5c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -91,6 +91,47 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/* XXX: is this really the max number of CPUs? */
+#define CPU_LOCK_BITMAP_SIZE 2048
+
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
@@ -100,9 +141,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
-    qemu_mutex_lock(&cpu->lock);
+    cpu_mutex_lock(cpu);
     ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    qemu_mutex_unlock(&cpu->lock);
+    cpu_mutex_unlock(cpu);
     return ret;
 }
 
@@ -1837,6 +1878,9 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 {
     QemuMutexLockFunc bql_lock = atomic_read(&qemu_bql_mutex_lock_func);
 
+    /* enforce locking order */
+    g_assert(no_cpu_mutex_locked());
+
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
     iothread_locked = true;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 0b75fdb093..4521bba7a5 100644
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
index 0000000000..ca2ea8a9c2
--- /dev/null
+++ b/stubs/cpu-lock.c
@@ -0,0 +1,28 @@
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
+/* coverity gets confused by the indirect function call */
+#ifdef __COVERITY__
+    qemu_mutex_lock_impl(&cpu->lock, file, line);
+#else
+    QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
+    f(&cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
+{
+    qemu_mutex_unlock_impl(&cpu->lock, file, line);
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


