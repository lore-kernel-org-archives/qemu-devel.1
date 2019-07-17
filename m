Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3990DC76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1C820818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiDbxstR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1C820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZlf-0001sL-Pc
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlC-0000Ny-OA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlA-00064U-Ds
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:38 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZl9-00063D-V6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so10037427pfp.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=D3obKT9rDhuzehgM7xHWUXMcx1FQLCDksitZUAA5kp0=;
 b=GiDbxstRs9s4CCyYamukJMdvF3AYM/XLXMVMTN2I1ajhvc8cMFhzrSl5rkNhxciDC6
 x4/LepKTj39QK4KCNEbkwfp58ex7dHMM9YJnz00Q7kEPFV2FDwXt60O1uqHkyjRLegAY
 kE81q0pNUGp3tU0Z31/isbmz0IKrNBMWQImGRzFLi6LKGyGa/CxlBNhgJNvBKqagUclp
 ZIRMp4G8DZBwVNWQpHP6h13w3uka2z8VsmGXth1rjkk2XwW+MbkqskhLs4YHl0cZpgtB
 O/TL9agQnup4Zszl/V1VpU6xVaot8oFPRmsr8GFHsHP9TYySsz4xziOv5eGJ2uYvhdQs
 lr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=D3obKT9rDhuzehgM7xHWUXMcx1FQLCDksitZUAA5kp0=;
 b=oz2TmwAppni8PQXUGH1/5qpx8w9EE67x04DR8bT2mgoSN5FmCXVLnjRACvVJ1dcaMP
 n1N4Fi27sxZfnwQgsg9rGQQs6BjS42QELdYwCDXveM1gLb4gX1MOgPfssR4BX5Ebridu
 OIB9ymvkdIpMvm0f+AWVeS2u82FOZp4RL/L1G7mhVBM/fRMox/45o/dtMzOY5na9OHsR
 p1uEDeDsHvj9jOnTFHRRCwmfb/Jb2Y6sBuf4T/XYDZc+EihU9UXSAowt6ZBODmv+PfhR
 sOiRs8T0qKB+SmW8zTJfF4a2KgBKDfvdTt9RwiHVIwypws+aipy3rYPz9tXNrjL3W5Tz
 ZO0g==
X-Gm-Message-State: APjAAAUH0f2XwJ86EcgxXvgz1YjFBSMhfnccMxRe1I/NhV+3jRCgTE9T
 9JfUBL6NWoBd8gt6LiDJbrRGmojL
X-Google-Smtp-Source: APXvYqxrGLuHBAjvQARzj9PtArdh4d8WRklyHssrkbQjJmOyvEm5z+2xymrNWElPaT5GBMD68wQSAA==
X-Received: by 2002:a17:90a:a489:: with SMTP id
 z9mr39098560pjp.24.1563330813540; 
 Tue, 16 Jul 2019 19:33:33 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:32 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:01 +0800
Message-Id: <20190717023310.197246-3-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v14 02/11] qemu_thread: supplement error
 handling for qemu_X_start_vcpu
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

The callers of qemu_init_vcpu() already passed the **errp to handle
errors. In view of this, add a new Error parameter to qemu_init_vcpu()
and all qemu_X_start_vcpu() functions called by qemu_init_vcpu() to
propagate the error and let the further callers check it.

Besides, make qemu_init_vcpu() return a Boolean value to let its
callers know whether it succeeds.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
ppc parts:
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 accel/tcg/user-exec-stub.c      |  3 +-
 cpus.c                          | 74 +++++++++++++++++++++++------------------
 include/qom/cpu.h               |  2 +-
 target/alpha/cpu.c              |  4 ++-
 target/arm/cpu.c                |  4 ++-
 target/cris/cpu.c               |  4 ++-
 target/hppa/cpu.c               |  4 ++-
 target/i386/cpu.c               |  4 ++-
 target/lm32/cpu.c               |  4 ++-
 target/m68k/cpu.c               |  4 ++-
 target/microblaze/cpu.c         |  4 ++-
 target/mips/cpu.c               |  4 ++-
 target/moxie/cpu.c              |  4 ++-
 target/nios2/cpu.c              |  4 ++-
 target/openrisc/cpu.c           |  4 ++-
 target/ppc/translate_init.inc.c |  4 ++-
 target/riscv/cpu.c              |  4 ++-
 target/s390x/cpu.c              |  4 ++-
 target/sh4/cpu.c                |  4 ++-
 target/sparc/cpu.c              |  4 ++-
 target/tilegx/cpu.c             |  4 ++-
 target/tricore/cpu.c            |  4 ++-
 target/unicore32/cpu.c          |  4 ++-
 target/xtensa/cpu.c             |  4 ++-
 24 files changed, 108 insertions(+), 55 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4bf00b8496..215bd9eead 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -9,8 +9,9 @@ void cpu_resume(CPUState *cpu)
 {
 }
 
-void qemu_init_vcpu(CPUState *cpu)
+bool qemu_init_vcpu(CPUState *cpu, Error **errp)
 {
+    return true;
 }
 
 /* User mode emulation does not support record/replay yet.  */
diff --git a/cpus.c b/cpus.c
index 28a241a936..c913bdc29e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1941,7 +1941,7 @@ void cpu_remove_sync(CPUState *cpu)
 /* For temporary buffers for forming a name */
 #define VCPU_THREAD_NAME_SIZE 16
 
-static void qemu_tcg_init_vcpu(CPUState *cpu)
+static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
@@ -1971,17 +1971,20 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
-            /* TODO: let the callers handle the error instead of abort() here */
-            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
+            if (qemu_thread_create(cpu->thread, thread_name,
+                                   qemu_tcg_cpu_thread_fn, cpu,
+                                   QEMU_THREAD_JOINABLE, errp) < 0) {
+                return;
+            }
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
-            /* TODO: let the callers handle the error instead of abort() here */
-            qemu_thread_create(cpu->thread, thread_name,
-                               qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
+            if (qemu_thread_create(cpu->thread, thread_name,
+                                   qemu_tcg_rr_cpu_thread_fn, cpu,
+                                   QEMU_THREAD_JOINABLE, errp) < 0) {
+                return;
+            }
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -1999,7 +2002,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     }
 }
 
-static void qemu_hax_start_vcpu(CPUState *cpu)
+static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2009,15 +2012,16 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE, errp) < 0) {
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
 }
 
-static void qemu_kvm_start_vcpu(CPUState *cpu)
+static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2026,12 +2030,11 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+                       cpu, QEMU_THREAD_JOINABLE, errp);
 }
 
-static void qemu_hvf_start_vcpu(CPUState *cpu)
+static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2045,12 +2048,11 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+                       cpu, QEMU_THREAD_JOINABLE, errp);
 }
 
-static void qemu_whpx_start_vcpu(CPUState *cpu)
+static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2059,15 +2061,16 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE, errp) < 0) {
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
 }
 
-static void qemu_dummy_start_vcpu(CPUState *cpu)
+static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2076,12 +2079,11 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+                       cpu, QEMU_THREAD_JOINABLE, errp);
 }
 
-void qemu_init_vcpu(CPUState *cpu)
+bool qemu_init_vcpu(CPUState *cpu, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
@@ -2089,6 +2091,7 @@ void qemu_init_vcpu(CPUState *cpu)
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
+    Error *local_err = NULL;
 
     if (!cpu->as) {
         /* If the target cpu hasn't set up any address spaces itself,
@@ -2099,22 +2102,29 @@ void qemu_init_vcpu(CPUState *cpu)
     }
 
     if (kvm_enabled()) {
-        qemu_kvm_start_vcpu(cpu);
+        qemu_kvm_start_vcpu(cpu, &local_err);
     } else if (hax_enabled()) {
-        qemu_hax_start_vcpu(cpu);
+        qemu_hax_start_vcpu(cpu, &local_err);
     } else if (hvf_enabled()) {
-        qemu_hvf_start_vcpu(cpu);
+        qemu_hvf_start_vcpu(cpu, &local_err);
     } else if (tcg_enabled()) {
-        qemu_tcg_init_vcpu(cpu);
+        qemu_tcg_init_vcpu(cpu, &local_err);
     } else if (whpx_enabled()) {
-        qemu_whpx_start_vcpu(cpu);
+        qemu_whpx_start_vcpu(cpu, &local_err);
     } else {
-        qemu_dummy_start_vcpu(cpu);
+        qemu_dummy_start_vcpu(cpu, &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return false;
     }
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
     }
+
+    return true;
 }
 
 void cpu_stop_current(void)
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b62..37f2d3dad5 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1021,7 +1021,7 @@ void end_exclusive(void);
  *
  * Initializes a vCPU.
  */
-void qemu_init_vcpu(CPUState *cpu);
+bool qemu_init_vcpu(CPUState *cpu, Error **errp);
 
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b3fd6643e8..84c9b517c8 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -66,7 +66,9 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     acc->parent_realize(dev, errp);
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1959467fdc..8b9c186780 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1610,7 +1610,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 7adfd6caf4..229928ae72 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -135,7 +135,9 @@ static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     ccc->parent_realize(dev, errp);
 }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 71b6aca45d..11837dc4f9 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -99,7 +99,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     acc->parent_realize(dev, errp);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 805ce95247..004910ab93 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5377,7 +5377,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     /*
      * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b35537de62..503b75b32b 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -134,7 +134,9 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cpu_reset(cs);
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     lcc->parent_realize(dev, errp);
 }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e6596de29c..28b28cfb5c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -232,7 +232,9 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     m68k_cpu_init_gdb(cpu);
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0bec54b2f8..610bff082d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -161,7 +161,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     env->pvr.regs[0] = PVR0_USE_EXC_MASK \
                        | PVR0_USE_ICACHE_MASK \
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 39eafafc5c..0b3aeba140 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -145,7 +145,9 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu_mips_realize_env(&cpu->env);
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 48996d0554..bb2df19a08 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -65,7 +65,9 @@ static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index ca9c7a6df5..2b5091071c 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -92,7 +92,9 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     ncc->parent_realize(dev, errp);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f19e482a55..28d448396b 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -83,7 +83,9 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     occ->parent_realize(dev, errp);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 86fc8f2e31..63a75dc115 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9843,7 +9843,9 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
                              pcc->gdb_num_sprs, "power-spr.xml", 0);
 #endif
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        goto unrealize;
+    }
 
     pcc->parent_realize(dev, errp);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20a..24fa555db7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -412,7 +412,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 736a7903e2..98ffd2767c 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -226,7 +226,9 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
 #endif
     s390_cpu_gdb_init(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     /*
      * KVM requires the initial CPU reset ioctl to be executed on the target
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 816d6d7f31..dc67833e3a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -186,7 +186,9 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     scc->parent_realize(dev, errp);
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ee60a5536a..1a584b3404 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -768,7 +768,9 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     scc->parent_realize(dev, errp);
 }
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 69971247f2..750b6fd110 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -93,7 +93,9 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index df807c1d74..1d0853c3f4 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -95,7 +95,9 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
         set_feature(env, TRICORE_FEATURE_13);
     }
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 802e2f1eba..4a3da5f900 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -95,7 +95,9 @@ static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     ucc->parent_realize(dev, errp);
 }
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 76db1741a7..46a15f0df5 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -131,7 +131,9 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cs->gdb_num_regs = xcc->config->gdb_regmap.num_regs;
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     xcc->parent_realize(dev, errp);
 }
-- 
2.11.0


