Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3007EC47420
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D576321527
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgdtKo4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576321527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhSH-0004Je-Ss
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ5-0002Pw-3i
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ3-0001O7-72
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e17so3522156wru.12
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4l0KodklduhKlx54LMAJs5VWrUciVPXI+FEJ8wv1X/w=;
 b=HgdtKo4USm8oUhwzHZJvdI9aTrD3E6hFXaG85E5Tr5OMgKOPByABLaEzFgRlESpH8y
 Vd26jhEouqHhLVMtz6656371WhX+731tx3INHdWyZOHPYn/CZNWhOBH5qS+k7ICvX/nD
 gjeaRMlielsxneyBJ7eL/mtceQvcfSUOXhqJcwZSVNNgk05amCaNx37wv41tm5vtKZ2/
 kh4Ol95G74reuh2aJ3j0og/EZufBdfPYAmLrMcFt6iOG9BZPAFV5GMe2PQ8XYTKH1mNC
 rJ/osQdNV0kNhUqnroyRYm2Wtv7OMfMZ1f+Ke9mK011Mzh0J4efgbLSOYHApzQaMD7xf
 QS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4l0KodklduhKlx54LMAJs5VWrUciVPXI+FEJ8wv1X/w=;
 b=LifQy8L9uM01wKwfM+5YcVuzSPyN7czs270eojtZesbVLwEf7WxMkybpfK5LsEfjp/
 nImvH7v3BPIp1uvBbq1GBbXiWH9v6M6lHAKyTpUFnHaRw2SSBoqETXdalVohkhAV+v0y
 KridPZLzbAyjXK0lhhnQC//iNgG8jizExM78Bc0hRZXR/76DhliPmvwudRGqY47RNNfD
 Qo0VrVdDi59nKkzh5Cd3xT+BwcVuEZFALfGVHThKdDdNDy6nqC8BDWZTxU8XYrzl97sI
 a4atcYHLdZ467SvHfgioZXkX7k2s9B7P0TcTaY7LZ6wyGEnDoR84z8YICYiBbtcOo1IQ
 hEjw==
X-Gm-Message-State: AOAM532u06DYwLWucRvSL15pUaaZVAVgtiXOLd2GbsO8RE6uKZdFuvnx
 gyI/+QdMXODz1Gt3zHZph4WSrIjhy8E=
X-Google-Smtp-Source: ABdhPJz7r1aj5ZoBtUeY0bvy2CTL+UscQ6VbubwJIILahQdIqpaFmaTg8gPZQhjQfseY5ORQW+3QfA==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr3270193wrn.110.1601969393482; 
 Tue, 06 Oct 2020 00:29:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/37] cpus: extract out whpx-specific code to target/i386/
Date: Tue,  6 Oct 2020 09:29:18 +0200
Message-Id: <20201006072947.487729-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

register a "CpusAccel" interface for WHPX as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS             |  1 +
 softmmu/cpus.c          | 79 ---------------------------------
 target/i386/meson.build |  5 ++-
 target/i386/whpx-all.c  |  3 ++
 target/i386/whpx-cpus.c | 96 +++++++++++++++++++++++++++++++++++++++++
 target/i386/whpx-cpus.h | 17 ++++++++
 6 files changed, 121 insertions(+), 80 deletions(-)
 create mode 100644 target/i386/whpx-cpus.c
 create mode 100644 target/i386/whpx-cpus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc45dfac4..231f854437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -451,6 +451,7 @@ WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
 F: target/i386/whpx-all.c
+F: target/i386/whpx-cpus.c
 F: target/i386/whp-dispatch.h
 F: accel/stubs/whpx-stub.c
 F: include/sysemu/whpx.h
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 900fff827a..067dae12eb 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -34,7 +34,6 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
-#include "sysemu/whpx.h"
 #include "exec/exec-all.h"
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
@@ -178,9 +177,6 @@ void cpu_synchronize_state(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_state) {
         cpus_accel->synchronize_state(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_state(cpu);
-    }
 }
 
 void cpu_synchronize_post_reset(CPUState *cpu)
@@ -188,9 +184,6 @@ void cpu_synchronize_post_reset(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_post_reset) {
         cpus_accel->synchronize_post_reset(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_reset(cpu);
-    }
 }
 
 void cpu_synchronize_post_init(CPUState *cpu)
@@ -198,9 +191,6 @@ void cpu_synchronize_post_init(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_post_init) {
         cpus_accel->synchronize_post_init(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_init(cpu);
-    }
 }
 
 void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -211,9 +201,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (hvf_enabled()) {
         hvf_cpu_synchronize_pre_loadvm(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_pre_loadvm(cpu);
-    }
 }
 
 int64_t cpus_get_virtual_clock(void)
@@ -445,48 +432,6 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void *qemu_whpx_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-    int r;
-
-    rcu_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-    cpu->thread_id = qemu_get_thread_id();
-    current_cpu = cpu;
-
-    r = whpx_init_vcpu(cpu);
-    if (r < 0) {
-        fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
-        exit(1);
-    }
-
-    /* signal CPU creation */
-    cpu_thread_signal_created(cpu);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    do {
-        if (cpu_can_run(cpu)) {
-            r = whpx_vcpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
-                cpu_handle_guest_debug(cpu);
-            }
-        }
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
-        }
-        qemu_wait_io_event_common(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    whpx_destroy_vcpu(cpu);
-    cpu_thread_signal_destroyed(cpu);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
 void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -501,12 +446,6 @@ void cpus_kick_thread(CPUState *cpu)
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
-#else /* _WIN32 */
-    if (!qemu_cpu_is_self(cpu)) {
-        if (whpx_enabled()) {
-            whpx_vcpu_kick(cpu);
-        }
-    }
 #endif
 }
 
@@ -681,22 +620,6 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
-static void qemu_whpx_start_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
-}
-
 void cpus_register_accel(const CpusAccel *ca)
 {
     assert(ca != NULL);
@@ -726,8 +649,6 @@ void qemu_init_vcpu(CPUState *cpu)
         cpus_accel->create_vcpu_thread(cpu);
     } else if (hvf_enabled()) {
         qemu_hvf_start_vcpu(cpu);
-    } else if (whpx_enabled()) {
-        qemu_whpx_start_vcpu(cpu);
     } else {
         g_assert_not_reached();
     }
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 1db619841c..a1a02f3e99 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -30,7 +30,10 @@ i386_softmmu_ss.add(files(
 ))
 i386_softmmu_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 i386_softmmu_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
-i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files('whpx-all.c'))
+i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files(
+  'whpx-all.c',
+  'whpx-cpus.c',
+))
 i386_softmmu_ss.add(when: 'CONFIG_HAX', if_true: files(
   'hax-all.c',
   'hax-mem.c',
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 2a8fcb68fd..91ee2e59f9 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -24,6 +24,8 @@
 #include "migration/blocker.h"
 #include "whp-dispatch.h"
 
+#include "whpx-cpus.h"
+
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
 
@@ -1650,6 +1652,7 @@ static int whpx_accel_init(MachineState *ms)
     whpx_memory_init();
 
     cpu_interrupt_handler = whpx_handle_interrupt;
+    cpus_register_accel(&whpx_cpus);
 
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
diff --git a/target/i386/whpx-cpus.c b/target/i386/whpx-cpus.c
new file mode 100644
index 0000000000..d9bd5a2d36
--- /dev/null
+++ b/target/i386/whpx-cpus.c
@@ -0,0 +1,96 @@
+/*
+ * QEMU Windows Hypervisor Platform accelerator (WHPX)
+ *
+ * Copyright Microsoft Corp. 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/kvm_int.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu/guest-random.h"
+
+#include "sysemu/whpx.h"
+#include "whpx-cpus.h"
+
+#include <WinHvPlatform.h>
+#include <WinHvEmulation.h>
+
+static void *whpx_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id = qemu_get_thread_id();
+    current_cpu = cpu;
+
+    r = whpx_init_vcpu(cpu);
+    if (r < 0) {
+        fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
+        exit(1);
+    }
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = whpx_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        while (cpu_thread_is_idle(cpu)) {
+            qemu_cond_wait_iothread(cpu->halt_cond);
+        }
+        qemu_wait_io_event_common(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    whpx_destroy_vcpu(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void whpx_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+#ifdef _WIN32
+    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+}
+
+static void whpx_kick_vcpu_thread(CPUState *cpu)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        whpx_vcpu_kick(cpu);
+    }
+}
+
+const CpusAccel whpx_cpus = {
+    .create_vcpu_thread = whpx_start_vcpu_thread,
+    .kick_vcpu_thread = whpx_kick_vcpu_thread,
+
+    .synchronize_post_reset = whpx_cpu_synchronize_post_reset,
+    .synchronize_post_init = whpx_cpu_synchronize_post_init,
+    .synchronize_state = whpx_cpu_synchronize_state,
+    .synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm,
+};
diff --git a/target/i386/whpx-cpus.h b/target/i386/whpx-cpus.h
new file mode 100644
index 0000000000..2393944954
--- /dev/null
+++ b/target/i386/whpx-cpus.h
@@ -0,0 +1,17 @@
+/*
+ * Accelerator CPUS Interface
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef WHPX_CPUS_H
+#define WHPX_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern const CpusAccel whpx_cpus;
+
+#endif /* WHPX_CPUS_H */
-- 
2.26.2



