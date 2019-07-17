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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3DC76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1045F20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDCAcrvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1045F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZmd-000681-Qq
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlZ-0001wh-Nd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlX-0006OI-Rw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlX-0006NB-JZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:59 -0400
Received: by mail-pf1-x443.google.com with SMTP id g2so10055865pfq.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WaJvV1QSsXcUg2IhvinOwCmvPU+3lsp5AGmaZZULkrU=;
 b=PDCAcrvrC6ZHRXYQAG+7vzqR0yyX6Cu5XsBp8K2BdVbNzy+Ug6gyuQLFbhGhEgqw0u
 JE7UooivmL6qqqKq1ps7ZBUwpC2Zt7CbJ2b/3NTnf+WMla+X5DF+gB2KWkz9WmdnHRVw
 Bn2Qjr1exFYOs+GRK4kjLPr4HtrrkvwgFZs1xwQSXEfNdbY5PWRPnVc7j+XBKIUs5XhZ
 ts89Hyj1VkzvjjZajTgg9Pq7kleY+9SKajI7OQNKxjsuKuW81TDqd1inFvmhSmjT+UXt
 MeGGk/hE7zJL5tN1s2QEHQwRBUc8482babFK9dBQCI8PzETH1d500tZDfOUFUYzUsDJK
 Qcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WaJvV1QSsXcUg2IhvinOwCmvPU+3lsp5AGmaZZULkrU=;
 b=dG1jUgcHykPaaT4Ly4N4IkDOYacioSM4LblMRFDX5/4Y/fFCWG5M/5D1t1l1rMmAAX
 +2ARgq26E0PPExl7mTmkbHTnW5akindlHvrVfwqZwXflxANDEycUCV/hXtTGtGsMUm3W
 qHRsgLiQNyglJHV+EDpZO4E+CrJKzXR/ac28q5xFtsZkaD7KOv2XRqhHqvExc+9VNDF6
 gstgAq0h93S10mUm79GHQEq2VAhvIj7DkFBXApd30l786vppp+F8wSPvqco+0Z1YhJR9
 MJNZvTnB0Z1ropCyRT29SPhbfnzelCJFF9b1azliApSDAEQopkujMLIh7b1OCusoSYHL
 XcfQ==
X-Gm-Message-State: APjAAAXMJ168Wk+fELb97gMTjHG7qRChQMOWfy+vhNllXpzp1CqJXGzq
 693PKZJjmyE4YLX5qPPs2WUJjguj
X-Google-Smtp-Source: APXvYqwNbc1WcTErV8qEYZUi2IUq2XvW5SXBZs5pcdoj8oOTeaMzQYmixeqEZ4k+1Y5mzlVvuKcqJg==
X-Received: by 2002:a63:755e:: with SMTP id f30mr38021112pgn.246.1563330838273; 
 Tue, 16 Jul 2019 19:33:58 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:57 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:08 +0800
Message-Id: <20190717023310.197246-10-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v14 09/11] qemu_thread: supplement error
 handling for migration
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
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Fei Li <fli@suse.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Update qemu_thread_create()'s callers by
- setting an error on qemu_thread_create() failure for callers that
  set an error on failure;
- reporting the error and returning failure for callers that return
  an error code on failure;
- reporting the error and setting some state for callers that just
  report errors and choose not to continue on.

Besides, make compress_threads_save_cleanup() cope with partially
initialized comp_param[i] to adapt to the new qemu_thread_create()
failure case.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Peter Xu <peterx@redhat.com>"
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c    | 35 ++++++++++++++++--------
 migration/postcopy-ram.c | 16 ++++++++---
 migration/ram.c          | 70 +++++++++++++++++++++++++++++++-----------------
 migration/savevm.c       | 12 ++++++---
 4 files changed, 89 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1786afb63d..ab46ee65be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -483,10 +483,13 @@ static void process_incoming_migration_co(void *opaque)
             goto fail;
         }
 
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-                           colo_process_incoming_thread, mis,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
+                               colo_process_incoming_thread, mis,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            error_reportf_err(local_err, "failed to create "
+                              "colo_process_incoming_thread: ");
+            goto fail;
+        }
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -2485,6 +2488,7 @@ out:
 static int open_return_path_on_source(MigrationState *ms,
                                       bool create_thread)
 {
+    Error *local_err = NULL;
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2498,10 +2502,15 @@ static int open_return_path_on_source(MigrationState *ms,
         return 0;
     }
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+                           source_return_path_thread, ms,
+                           QEMU_THREAD_JOINABLE, &local_err) < 0) {
+        error_reportf_err(local_err,
+                          "failed to create source_return_path_thread: ");
+        qemu_fclose(ms->rp_state.from_dst_file);
+        ms->rp_state.from_dst_file = NULL;
+        return -1;
+     }
 
     trace_open_return_path_on_source_continue();
 
@@ -3346,9 +3355,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
+                           QEMU_THREAD_JOINABLE, &error_in) < 0) {
+        error_reportf_err(error_in, "failed to create migration_thread: ");
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 135e9cd746..d82136962d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1095,6 +1095,8 @@ retry:
 
 int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 {
+    Error *local_err = NULL;
+
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
     if (mis->userfault_fd == -1) {
@@ -1121,10 +1123,16 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     }
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&mis->fault_thread, "postcopy/fault",
+                           postcopy_ram_fault_thread, mis,
+                           QEMU_THREAD_JOINABLE, &local_err) < 0) {
+        error_reportf_err(local_err,
+                          "failed to create postcopy_ram_fault_thread: ");
+        close(mis->userfault_event_fd);
+        close(mis->userfault_fd);
+        qemu_sem_destroy(&mis->fault_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index 0f677f2d27..16f59ad057 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -504,6 +504,14 @@ static void compress_threads_save_cleanup(void)
 
     thread_count = migrate_compress_threads();
     for (i = 0; i < thread_count; i++) {
+        qemu_mutex_lock(&comp_param[i].mutex);
+        comp_param[i].quit = true;
+        qemu_cond_signal(&comp_param[i].cond);
+        qemu_mutex_unlock(&comp_param[i].mutex);
+
+        qemu_mutex_destroy(&comp_param[i].mutex);
+        qemu_cond_destroy(&comp_param[i].cond);
+
         /*
          * we use it as a indicator which shows if the thread is
          * properly init'd or not
@@ -511,15 +519,7 @@ static void compress_threads_save_cleanup(void)
         if (!comp_param[i].file) {
             break;
         }
-
-        qemu_mutex_lock(&comp_param[i].mutex);
-        comp_param[i].quit = true;
-        qemu_cond_signal(&comp_param[i].cond);
-        qemu_mutex_unlock(&comp_param[i].mutex);
-
         qemu_thread_join(compress_threads + i);
-        qemu_mutex_destroy(&comp_param[i].mutex);
-        qemu_cond_destroy(&comp_param[i].cond);
         deflateEnd(&comp_param[i].stream);
         g_free(comp_param[i].originbuf);
         qemu_fclose(comp_param[i].file);
@@ -536,6 +536,7 @@ static void compress_threads_save_cleanup(void)
 static int compress_threads_save_setup(void)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -546,6 +547,9 @@ static int compress_threads_save_setup(void)
     qemu_cond_init(&comp_done_cond);
     qemu_mutex_init(&comp_done_lock);
     for (i = 0; i < thread_count; i++) {
+        qemu_mutex_init(&comp_param[i].mutex);
+        qemu_cond_init(&comp_param[i].cond);
+        comp_param[i].quit = false;
         comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
         if (!comp_param[i].originbuf) {
             goto exit;
@@ -562,13 +566,16 @@ static int compress_threads_save_setup(void)
          */
         comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
         comp_param[i].done = true;
-        comp_param[i].quit = false;
-        qemu_mutex_init(&comp_param[i].mutex);
-        qemu_cond_init(&comp_param[i].cond);
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(compress_threads + i, "compress",
+                               do_data_compress, comp_param + i,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            error_reportf_err(local_err, "failed to create do_data_compress: ");
+            deflateEnd(&comp_param[i].stream);
+            g_free(comp_param[i].originbuf);
+            qemu_fclose(comp_param[i].file);
+            comp_param[i].file = NULL;
+            goto exit;
+        }
     }
     return 0;
 
@@ -1168,9 +1175,14 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            migrate_set_error(migrate_get_current(), local_err);
+            error_reportf_err(local_err,
+                              "failed to create multifd_send_thread: ");
+            multifd_save_cleanup();
+            return;
+        }
     }
 }
 
@@ -1449,9 +1461,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->num_packets = 1;
 
     p->running = true;
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                           QEMU_THREAD_JOINABLE, &local_err) < 0) {
+        multifd_recv_terminate_threads(local_err);
+        error_propagate_prepend(errp, local_err,
+                                "failed to create multifd_recv_thread: ");
+        return false;
+    }
     atomic_inc(&multifd_recv_state->count);
     return atomic_read(&multifd_recv_state->count) ==
            migrate_multifd_channels();
@@ -3873,6 +3889,7 @@ static void compress_threads_load_cleanup(void)
 static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -3894,10 +3911,13 @@ static int compress_threads_load_setup(QEMUFile *f)
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].done = true;
         decomp_param[i].quit = false;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(decompress_threads + i, "decompress",
+                               do_data_decompress, decomp_param + i,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            error_reportf_err(local_err,
+                              "failed to create do_data_decompress: ");
+            goto exit;
+        }
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index c792dee8aa..d75d078946 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1826,10 +1826,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&mis->listen_thread, "postcopy/listen",
-                       postcopy_ram_listen_thread, NULL,
-                       QEMU_THREAD_DETACHED, &error_abort);
+    if (qemu_thread_create(&mis->listen_thread, "postcopy/listen",
+                           postcopy_ram_listen_thread, NULL,
+                           QEMU_THREAD_DETACHED, &local_err) < 0) {
+        error_reportf_err(local_err,
+                          "failed to create postcopy_ram_listen_thread: ");
+        qemu_sem_destroy(&mis->listen_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
 
-- 
2.11.0


