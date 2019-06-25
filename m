Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C33C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5932133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQI26Y1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5932133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflej-0005oU-BG
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hflLB-0001YM-6E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hflL9-0007LC-Uv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hflL9-0007Kk-Ol
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id n2so8951277pgp.11
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ofGWpnUEWAExuocXnmIhVSIOoE3czShQOTCROPMCBNM=;
 b=RQI26Y1fYrBV56JWRn9SgFTyYLjxXZkvzk9i/VVABomRKOuWpBJOfjeXfFtpYBm+V1
 SGI5EMOmeUitTY18HzhHG1IBGIPa6za+jaTTCZgD2XWcjq/jJEsZFdfp6aD7izvEx7/8
 4zht9/vlizTzC66TYVVB/Feh3TA9hPnz1NGGxWlBfCZABu3XW83HsHxmyehPHYmw9NXG
 1NOGN1g0ATjcK01yz+bkw9/Ozn4WgvW5zgL2TCPb3xmz6woasu5b6S/IA/5kavZtc7Ke
 AOGiVlMCFrISFufXJbNTyuOq+jG8LPhpDoTXbpWO3eAqkEHxeSEC1c10W+i528kacFYw
 kgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ofGWpnUEWAExuocXnmIhVSIOoE3czShQOTCROPMCBNM=;
 b=bVPpZSc5KJ05qV7m+f3ICOMdc4BzQI2YVMzpdK8dVbCEuSqcP+QUOEhk7aWfsTKmZE
 uD39OGIcanqWaLG1jBJWrD3cXhmOCwkEzCe+Qje9GHY5P+9yo9N4DpDFMprLfC2UNepe
 1ibDVrJ4RkwR7PulTbGzjBdg+B4DV8XLGYQOEAhtnEG7YZqK0xrIxOlOVUwDlLp+e/f1
 lLa9vNVuvnfguZv2da21Fkp58eMIlKAXJLLEq/iNdCD1axjVSTrTrMJXKzsTgXZuM/4M
 55yyoA+ClTYNtVtjZRAMtzwAK4sILkIgW35SaNi8Jo+kfvsyW/TTnysQkS/8PMnjw5DU
 Ewkg==
X-Gm-Message-State: APjAAAW8yiUtZ6bwf6cTmivgTs9T/VwSFw1g4Gkb4GxOJzJmFHu9KztY
 brxawOLSlWaDYZ8fMuhrIpw=
X-Google-Smtp-Source: APXvYqwDK59X+Zav/YyOOBWudB2TX0oJ3agMoRsqx7CoF4iIUl8MoLHCPQVMrOSpznCoMo75JdXlyQ==
X-Received: by 2002:a17:90b:8d2:: with SMTP id
 ds18mr32704877pjb.132.1561468706920; 
 Tue, 25 Jun 2019 06:18:26 -0700 (PDT)
Received: from VM_64_241_centos.localdomain ([129.226.57.92])
 by smtp.gmail.com with ESMTPSA id f186sm15675814pfb.5.2019.06.25.06.18.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 06:18:26 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Tue, 25 Jun 2019 21:18:17 +0800
Message-Id: <1561468699-9819-2-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 1/3] migration: fix migrate_cancel leads
 live_migration thread endless loop
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we 'migrate_cancel' a multifd migration, live_migration thread may
go into endless loop in multifd_send_pages functions.

Reproduce steps:

(qemu) migrate_set_capability multifd on
(qemu) migrate -d url
(qemu) [wait a while]
(qemu) migrate_cancel

Then may get live_migration 100% cpu usage in following stack:

pthread_mutex_lock
qemu_mutex_lock_impl
multifd_send_pages
multifd_queue_page
ram_save_multifd_page
ram_save_target_page
ram_save_host_page
ram_find_and_save_block
ram_find_and_save_block
ram_save_iterate
qemu_savevm_state_iterate
migration_iteration_run
migration_thread
qemu_thread_start
start_thread
clone

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 908517fc2b..f8908286c2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -920,7 +920,7 @@ struct {
  * false.
  */
 
-static void multifd_send_pages(void)
+static int multifd_send_pages(void)
 {
     int i;
     static int next_channel;
@@ -933,6 +933,11 @@ static void multifd_send_pages(void)
         p = &multifd_send_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            error_report("%s: channel %d has already quit!", __func__, i);
+            qemu_mutex_unlock(&p->mutex);
+            return -1;
+        }
         if (!p->pending_job) {
             p->pending_job++;
             next_channel = (i + 1) % migrate_multifd_channels();
@@ -951,9 +956,11 @@ static void multifd_send_pages(void)
     ram_counters.transferred += transferred;;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
+
+    return 1;
 }
 
-static void multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages = multifd_send_state->pages;
 
@@ -968,15 +975,19 @@ static void multifd_queue_page(RAMBlock *block, ram_addr_t offset)
         pages->used++;
 
         if (pages->used < pages->allocated) {
-            return;
+            return 1;
         }
     }
 
-    multifd_send_pages();
+    if (multifd_send_pages() < 0) {
+        return -1;
+    }
 
     if (pages->block != block) {
-        multifd_queue_page(block, offset);
+        return  multifd_queue_page(block, offset);
     }
+
+    return 1;
 }
 
 static void multifd_send_terminate_threads(Error *err)
@@ -1049,7 +1060,10 @@ static void multifd_send_sync_main(void)
         return;
     }
     if (multifd_send_state->pages->used) {
-        multifd_send_pages();
+        if (multifd_send_pages() < 0) {
+            error_report("%s: multifd_send_pages fail", __func__);
+            return;
+        }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1058,6 +1072,12 @@ static void multifd_send_sync_main(void)
 
         qemu_mutex_lock(&p->mutex);
 
+        if (p->quit) {
+            error_report("%s: channel %d has already quit", __func__, i);
+            qemu_mutex_unlock(&p->mutex);
+            return;
+        }
+
         p->packet_num = multifd_send_state->packet_num++;
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
@@ -2000,7 +2020,9 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
                                  ram_addr_t offset)
 {
-    multifd_queue_page(block, offset);
+    if (multifd_queue_page(block, offset) < 0) {
+        return -1;
+    }
     ram_counters.normal++;
 
     return 1;
-- 
2.17.2 (Apple Git-113)


