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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B0FC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7373D20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4hB713K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7373D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZm2-0003Fq-8A
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlA-0000Ej-EQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZl6-00061y-M8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZl6-00060z-Ax
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:32 -0400
Received: by mail-pf1-x443.google.com with SMTP id 19so10044751pfa.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bkbcfMa3cs5wedeyDlK30E/C95joM5HSJIHKNt/oeFo=;
 b=Y4hB713KWVVAVKMAShTkhu1YgNe2c9qCKl8WjsfCawJgIs6OeF9Tpo8yl39fmiLUcF
 jQYURiuATPUbnaOUG1pAnE+fzv5NlSMdkHGN1LGyw4QFigdNoXizSDTo476XF63LvneQ
 rfhM/sfYQtyH7Sqh/brRiiD/RZ8yiXhYXOzt0DE8uWnQBN9KBsky37zGRBDtOcIPREOt
 ulTwMT3DVqjTQhytiQEfMzttAjyYic4vg76v1UQpYl2APVIukWsMXBAiYza8O49H/AF6
 XZm1cUCR6wAtfjFKJikIANhIiuQBnnfN3Nekq2577h0FYzCMkVVRRta9fIJElRi8kJ4g
 xPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bkbcfMa3cs5wedeyDlK30E/C95joM5HSJIHKNt/oeFo=;
 b=Z7TfScHp8+Y++ptGq6fsihahGeNzjmCvaWl9b0SL86e4B0sXNwrIWgrQlAqI7q0s7T
 sX7lBuPXjzCP7mWbTYyDsahYMQ2dvkj4EaO1YPKmMcNXsoMwClfEpJH8sWNMmFxmAxy+
 uoQwRxb62r2gqj6kXa3/5XiJPwonKPALOArtMcTYST4LdcA0r5KMayNhzkWgGD8t4fHR
 5KeB9itv8xzg1nWK6VNnNZd2Ssqn19MlfHSUVucO1FyYgK8fI0GnlpuCeT8cDVoyFH7v
 9dCN+A9pLhFsSEswHikKdJSxsdASUT+nmjXMwCUOcEER3DXXVS+tkbpB3wg0+FEU4fXx
 TcLw==
X-Gm-Message-State: APjAAAXeRvHIPOsRLeFqlNOhy4rzARmcBElSXy3Z4Bn6bsXuEU4+lWGY
 sB+VeKK6bwmgx5wcco5WdCMFPrt4
X-Google-Smtp-Source: APXvYqwtu+Dxr/UD7BO9eOV9iaUtKlPMcFrLnV7f+z2pSNgKMZQb3VYU1fv9KsCYtdt/xCCJ1iiljA==
X-Received: by 2002:a17:90a:bf02:: with SMTP id
 c2mr40896986pjs.73.1563330810068; 
 Tue, 16 Jul 2019 19:33:30 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:29 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:00 +0800
Message-Id: <20190717023310.197246-2-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v14 01/11] qemu_thread: make
 qemu_thread_create() take Error ** argument
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

qemu_thread_create() abort()s on error. Not nice. Give it a return
value and an Error ** argument, so it can return success/failure.

Considering qemu_thread_create() is quite widely used in qemu, split
this into two steps: this patch passes the &error_abort to
qemu_thread_create() everywhere, and the next 10 patches will improve
on &error_abort for callers who need.  To differentiate callers who
need the improvement, temporarily add the "TODO:" comment for them.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 cpus.c                        | 23 +++++++++++++++--------
 dump/dump.c                   |  3 ++-
 hw/misc/edu.c                 |  4 +++-
 hw/ppc/spapr_hcall.c          |  4 +++-
 hw/rdma/rdma_backend.c        |  3 ++-
 hw/usb/ccid-card-emulated.c   |  5 +++--
 include/qemu/thread.h         |  6 +++---
 io/task.c                     |  3 ++-
 iothread.c                    |  3 ++-
 migration/migration.c         | 11 ++++++++---
 migration/postcopy-ram.c      |  4 +++-
 migration/ram.c               | 12 ++++++++----
 migration/savevm.c            |  3 ++-
 tests/atomic64-bench.c        |  3 ++-
 tests/atomic_add-bench.c      |  3 ++-
 tests/iothread.c              |  2 +-
 tests/qht-bench.c             |  3 ++-
 tests/rcutorture.c            |  3 ++-
 tests/test-aio.c              |  2 +-
 tests/test-char.c             |  6 +++---
 tests/test-rcu-list.c         |  3 ++-
 tests/test-util-filemonitor.c |  2 +-
 ui/cocoa.m                    |  2 +-
 ui/vnc-jobs.c                 |  6 ++++--
 util/compatfd.c               |  6 ++++--
 util/oslib-posix.c            |  3 ++-
 util/qemu-thread-posix.c      | 30 +++++++++++++++++++++++-------
 util/qemu-thread-win32.c      | 13 ++++++++++---
 util/rcu.c                    |  3 ++-
 util/thread-pool.c            |  4 +++-
 30 files changed, 121 insertions(+), 57 deletions(-)

diff --git a/cpus.c b/cpus.c
index 927a00aa90..28a241a936 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1971,15 +1971,17 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
+            /* TODO: let the callers handle the error instead of abort() here */
             qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+            /* TODO: let the callers handle the error instead of abort() here */
             qemu_thread_create(cpu->thread, thread_name,
                                qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -2007,8 +2009,9 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -2023,8 +2026,9 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 }
 
 static void qemu_hvf_start_vcpu(CPUState *cpu)
@@ -2041,8 +2045,9 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 }
 
 static void qemu_whpx_start_vcpu(CPUState *cpu)
@@ -2054,8 +2059,9 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -2070,8 +2076,9 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
+    /* TODO: let the further caller handle the error instead of abort() here */
+    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 }
 
 void qemu_init_vcpu(CPUState *cpu)
diff --git a/dump/dump.c b/dump/dump.c
index c7b2301652..1358e62fb7 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2022,8 +2022,9 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         s->detached = true;
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED);
+                           s, QEMU_THREAD_DETACHED, &error_abort);
     } else {
         /* sync dump */
         dump_process(s, errp);
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 3b6dba2c72..1edc66955a 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -29,6 +29,7 @@
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 
 #define TYPE_PCI_EDU_DEVICE "edu"
@@ -370,8 +371,9 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE);
+                       edu, QEMU_THREAD_JOINABLE, &error_abort);
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6808d4cda8..d64b634526 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -508,8 +508,10 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     pending->shift = shift;
     pending->ret = H_HARDWARE;
 
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
-                       hpt_prepare_thread, pending, QEMU_THREAD_DETACHED);
+                       hpt_prepare_thread, pending,
+                       QEMU_THREAD_DETACHED, &error_abort);
 
     spapr->pending_hpt = pending;
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c39051068d..29f52955d0 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -281,7 +281,8 @@ static void start_comp_thread(RdmaBackendDev *backend_dev)
              ibv_get_device_name(backend_dev->ib_dev));
     backend_dev->comp_thread.run = true;
     qemu_thread_create(&backend_dev->comp_thread.thread, thread_name,
-                       comp_handler_thread, backend_dev, QEMU_THREAD_DETACHED);
+                       comp_handler_thread, backend_dev,
+                       QEMU_THREAD_DETACHED, &error_abort);
 }
 
 void rdma_backend_register_comp_handler(void (*handler)(void *ctx,
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index e20f8ed293..4d95ee07aa 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -545,10 +545,11 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
         goto out2;
     }
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &error_abort);
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &error_abort);
 
     return;
 
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a907c..ec18d8b171 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -152,9 +152,9 @@ void qemu_event_reset(QemuEvent *ev);
 void qemu_event_wait(QemuEvent *ev);
 void qemu_event_destroy(QemuEvent *ev);
 
-void qemu_thread_create(QemuThread *thread, const char *name,
-                        void *(*start_routine)(void *),
-                        void *arg, int mode);
+int qemu_thread_create(QemuThread *thread, const char *name,
+                       void *(*start_routine)(void *),
+                       void *arg, int mode, Error **errp);
 void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
diff --git a/io/task.c b/io/task.c
index 64c4c7126a..1499540cdf 100644
--- a/io/task.c
+++ b/io/task.c
@@ -170,7 +170,8 @@ void qio_task_run_in_thread(QIOTask *task,
                        "io-task-worker",
                        qio_task_thread_worker,
                        task,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED,
+                       &error_abort);
 }
 
 
diff --git a/iothread.c b/iothread.c
index 7130be58e3..2d5a5bfe6c 100644
--- a/iothread.c
+++ b/iothread.c
@@ -198,8 +198,9 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
     g_free(thread_name);
     g_free(name);
 
diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..1786afb63d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -483,8 +483,10 @@ static void process_incoming_migration_co(void *opaque)
             goto fail;
         }
 
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-             colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
+                           colo_process_incoming_thread, mis,
+                           QEMU_THREAD_JOINABLE, &error_abort);
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -2496,8 +2498,10 @@ static int open_return_path_on_source(MigrationState *ms,
         return 0;
     }
 
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
+                       source_return_path_thread, ms,
+                       QEMU_THREAD_JOINABLE, &error_abort);
 
     trace_open_return_path_on_source_continue();
 
@@ -3342,8 +3346,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9faacacc9e..135e9cd746 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1121,8 +1121,10 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     }
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis, QEMU_THREAD_JOINABLE);
+                       postcopy_ram_fault_thread, mis,
+                       QEMU_THREAD_JOINABLE, &error_abort);
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index 2b0774c2bf..0f677f2d27 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -565,9 +565,10 @@ static int compress_threads_save_setup(void)
         comp_param[i].quit = false;
         qemu_mutex_init(&comp_param[i].mutex);
         qemu_cond_init(&comp_param[i].cond);
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(compress_threads + i, "compress",
                            do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
     return 0;
 
@@ -1167,8 +1168,9 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
 }
 
@@ -1447,8 +1449,9 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->num_packets = 1;
 
     p->running = true;
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     atomic_inc(&multifd_recv_state->count);
     return atomic_read(&multifd_recv_state->count) ==
            migrate_multifd_channels();
@@ -3891,9 +3894,10 @@ static int compress_threads_load_setup(QEMUFile *f)
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].done = true;
         decomp_param[i].quit = false;
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(decompress_threads + i, "decompress",
                            do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..c792dee8aa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1826,9 +1826,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
                        postcopy_ram_listen_thread, NULL,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &error_abort);
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
 
diff --git a/tests/atomic64-bench.c b/tests/atomic64-bench.c
index 121a8c14f4..08ec753582 100644
--- a/tests/atomic64-bench.c
+++ b/tests/atomic64-bench.c
@@ -8,6 +8,7 @@
 #include "qemu/thread.h"
 #include "qemu/host-utils.h"
 #include "qemu/processor.h"
+#include "qapi/error.h"
 
 struct thread_info {
     uint64_t r;
@@ -103,7 +104,7 @@ static void create_threads(void)
         info->r = (i + 1) ^ time(NULL);
         info->accesses = 0;
         qemu_thread_create(&threads[i], NULL, thread_func, info,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
 }
 
diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index 5666f6bbff..52071585a9 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -2,6 +2,7 @@
 #include "qemu/thread.h"
 #include "qemu/host-utils.h"
 #include "qemu/processor.h"
+#include "qapi/error.h"
 
 struct thread_info {
     uint64_t r;
@@ -108,7 +109,7 @@ static void create_threads(void)
 
         info->r = (i + 1) ^ time(NULL);
         qemu_thread_create(&threads[i], NULL, thread_func, info,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
 }
 
diff --git a/tests/iothread.c b/tests/iothread.c
index 777d9eea46..f4ad992e61 100644
--- a/tests/iothread.c
+++ b/tests/iothread.c
@@ -73,7 +73,7 @@ IOThread *iothread_new(void)
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
     qemu_thread_create(&iothread->thread, NULL, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
 
     /* Wait for initialization to complete */
     qemu_mutex_lock(&iothread->init_done_lock);
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index e3b512f26f..728c2e06c7 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -10,6 +10,7 @@
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
 #include "qemu/xxhash.h"
+#include "qapi/error.h"
 
 struct thread_stats {
     size_t rd;
@@ -248,7 +249,7 @@ th_create_n(QemuThread **threads, struct thread_info **infos, const char *name,
         prepare_thread_info(&info[i], offset + i);
         info[i].func = func;
         qemu_thread_create(&th[i], name, thread_func, &info[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
 }
 
diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 49311c82ea..0e799ff256 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -64,6 +64,7 @@
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 
 long long n_reads = 0LL;
 long n_updates = 0L;
@@ -90,7 +91,7 @@ static void create_thread(void *(*func)(void *))
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     n_threads++;
 }
 
diff --git a/tests/test-aio.c b/tests/test-aio.c
index 86fb73b3d5..b3ac261724 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -154,7 +154,7 @@ static void test_acquire(void)
 
     qemu_thread_create(&thread, "test_acquire_thread",
                        test_acquire_thread,
-                       &data, QEMU_THREAD_JOINABLE);
+                       &data, QEMU_THREAD_JOINABLE, &error_abort);
 
     /* Block in aio_poll(), let other thread kick us and acquire context */
     aio_context_acquire(ctx);
diff --git a/tests/test-char.c b/tests/test-char.c
index f9440cdcfd..093e26e333 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -793,7 +793,7 @@ static void char_socket_server_test(gconstpointer opaque)
      */
     qemu_thread_create(&thread, "client",
                        char_socket_server_client_thread,
-                       addr, QEMU_THREAD_JOINABLE);
+                       addr, QEMU_THREAD_JOINABLE, &error_abort);
     g_assert(data.event == -1);
 
     if (config->wait_connected) {
@@ -901,7 +901,7 @@ static void char_socket_client_test(gconstpointer opaque)
      */
     qemu_thread_create(&thread, "client",
                        char_socket_client_server_thread,
-                       ioc, QEMU_THREAD_JOINABLE);
+                       ioc, QEMU_THREAD_JOINABLE, &error_abort);
 
     /*
      * Populate the chardev address based on what the server
@@ -994,7 +994,7 @@ static void char_socket_client_test(gconstpointer opaque)
         reconnected = true;
         qemu_thread_create(&thread, "client",
                            char_socket_client_server_thread,
-                           ioc, QEMU_THREAD_JOINABLE);
+                           ioc, QEMU_THREAD_JOINABLE, &error_abort);
         goto reconnect;
     }
 
diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 6f076473e0..399744f03c 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -25,6 +25,7 @@
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
 #include "qemu/rcu_queue.h"
+#include "qapi/error.h"
 
 /*
  * Test variables.
@@ -68,7 +69,7 @@ static void create_thread(void *(*func)(void *))
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     n_threads++;
 }
 
diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 46e781c022..a7a7c1eeeb 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -397,7 +397,7 @@ test_file_monitor_events(void)
     evstopping = 0;
     qemu_thread_create(&th, "event-loop",
                        qemu_file_monitor_test_event_loop, NULL,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
 
     if (local_err) {
         g_printerr("File monitoring not available: %s",
diff --git a/ui/cocoa.m b/ui/cocoa.m
index c2984028c5..d8cf1484d9 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1766,7 +1766,7 @@ int main (int argc, const char * argv[]) {
     qemu_sem_init(&app_started_sem, 0);
 
     qemu_thread_create(&thread, "qemu_main", call_qemu_main,
-                       NULL, QEMU_THREAD_DETACHED);
+                       NULL, QEMU_THREAD_DETACHED, &error_abort);
 
     COCOA_DEBUG("Main thread: waiting for display_init_sem\n");
     qemu_sem_wait(&display_init_sem);
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 929391f85d..5712f1f501 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -31,6 +31,7 @@
 #include "vnc-jobs.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #include "block/aio.h"
 
 /*
@@ -339,7 +340,8 @@ void vnc_start_worker_thread(void)
         return ;
 
     q = vnc_queue_init();
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
-                       QEMU_THREAD_DETACHED);
+    /* TODO: let the further caller handle the error instead of abort() here */
+    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
+                       q, QEMU_THREAD_DETACHED, &error_abort);
     queue = q; /* Set global queue */
 }
diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d14..caad10ae56 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 
 #include <sys/syscall.h>
 
@@ -87,8 +88,9 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     memcpy(&info->mask, mask, sizeof(*mask));
     info->fd = fds[1];
 
-    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat, info,
-                       QEMU_THREAD_DETACHED);
+    /* TODO: let the further caller handle the error instead of abort() here */
+    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
+                       info, QEMU_THREAD_DETACHED, &error_abort);
 
     return fds[0];
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fe0309ce7a..55c1b9c098 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -465,9 +465,10 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
                                     numpages : numpages_per_thread;
         memset_thread[i].hpagesize = hpagesize;
+        /* TODO: let the callers handle the error instead of abort() here */
         qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
                            do_touch_pages, &memset_thread[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
         addr += size_per_thread;
         numpages -= numpages_per_thread;
     }
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 1bf5e65dea..06a9e78ba8 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -15,6 +15,7 @@
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 
 static bool name_threads;
 
@@ -504,9 +505,18 @@ static void *qemu_thread_start(void *args)
     return r;
 }
 
-void qemu_thread_create(QemuThread *thread, const char *name,
-                       void *(*start_routine)(void*),
-                       void *arg, int mode)
+/*
+ * Create a new thread with name @name
+ * The thread executes @start_routine() with argument @arg.
+ * The thread will be created in a detached state if @mode is
+ * QEMU_THREAD_DETACHED, and in a jounable state if it's
+ * QEMU_THREAD_JOINABLE.
+ * On success, return 0.
+ * On failure, store an error through @errp and return negative errno.
+ */
+int qemu_thread_create(QemuThread *thread, const char *name,
+                       void *(*start_routine)(void *),
+                       void *arg, int mode, Error **errp)
 {
     sigset_t set, oldset;
     int err;
@@ -515,7 +525,8 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 
     err = pthread_attr_init(&attr);
     if (err) {
-        error_exit(err, __func__);
+        error_setg(errp, "pthread_attr_init failed");
+        return -err;
     }
 
     if (mode == QEMU_THREAD_DETACHED) {
@@ -538,13 +549,18 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 
     err = pthread_create(&thread->thread, &attr,
                          qemu_thread_start, qemu_thread_args);
-
-    if (err)
-        error_exit(err, __func__);
+    if (err) {
+        error_setg(errp, "pthread_create failed");
+        pthread_attr_destroy(&attr);
+        g_free(qemu_thread_args->name);
+        g_free(qemu_thread_args);
+        return -err;
+    }
 
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 
     pthread_attr_destroy(&attr);
+    return 0;
 }
 
 void qemu_thread_get_self(QemuThread *thread)
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 572f88535d..f2deea5250 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -16,6 +16,7 @@
 #include "qemu/thread.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 #include <process.h>
 
 static bool name_threads;
@@ -384,9 +385,9 @@ void *qemu_thread_join(QemuThread *thread)
     return ret;
 }
 
-void qemu_thread_create(QemuThread *thread, const char *name,
+int qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void *),
-                       void *arg, int mode)
+                       void *arg, int mode, Error **errp)
 {
     HANDLE hThread;
     struct QemuThreadData *data;
@@ -405,10 +406,16 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                       data, 0, &thread->tid);
     if (!hThread) {
-        error_exit(GetLastError(), __func__);
+        if (data->mode != QEMU_THREAD_DETACHED) {
+            DeleteCriticalSection(&data->cs);
+        }
+        error_setg(errp, "failed to create win32_start_routine");
+        g_free(data);
+        return -errno;
     }
     CloseHandle(hThread);
     thread->data = data;
+    return 0;
 }
 
 void qemu_thread_get_self(QemuThread *thread)
diff --git a/util/rcu.c b/util/rcu.c
index 177a675619..ff11837b47 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -31,6 +31,7 @@
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #if defined(CONFIG_MALLOC_TRIM)
 #include <malloc.h>
 #endif
@@ -324,7 +325,7 @@ static void rcu_init_complete(void)
      * must have been quiescent even after forking, just recreate it.
      */
     qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
-                       NULL, QEMU_THREAD_DETACHED);
+                       NULL, QEMU_THREAD_DETACHED, &error_abort);
 
     rcu_register_thread();
 }
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 4ed9b89ab2..9a867776f9 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 
 static void do_spawn_thread(ThreadPool *pool);
 
@@ -131,7 +132,8 @@ static void do_spawn_thread(ThreadPool *pool)
     pool->new_threads--;
     pool->pending_threads++;
 
-    qemu_thread_create(&t, "worker", worker_thread, pool, QEMU_THREAD_DETACHED);
+    qemu_thread_create(&t, "worker", worker_thread, pool,
+                       QEMU_THREAD_DETACHED, &error_abort);
 }
 
 static void spawn_thread_bh_fn(void *opaque)
-- 
2.11.0


