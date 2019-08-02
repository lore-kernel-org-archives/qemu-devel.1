Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068FF2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3opLxES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068FF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTWp-0004rh-AG
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1htTWG-00049J-Rt
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1htTWF-0003ak-IQ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:06:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1htTWF-0003aO-Ce
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:06:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id u14so35720745pfn.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HjaiaePE62sPbbhP/TIjCkGtxZeFziWMl3+zzS8KihA=;
 b=G3opLxESJ2r8fRXj0+ULvc6QGlVw0cEn9q33Y3yQVWpcYEke7SDFRWJU9kK7m2GI3E
 R1XIv2Zbcv4FknKwYQkP2JdZ0DgxKX7BUA8cUaE0Bnmx3l2PJ30NggkvVRoeX3pT5Jrf
 3zyMt4w51qHBaVTvIg0bTsCyGtP6aGyHFI25Y4IrUMMnHLKhZ3HTFGv61cJN2L3/H2U/
 CyJvTvLDgUPQhep06p3rDqNPQ89L6HgKADJAdY9zZj/YFjslFBCIyUmkqTUSY9iFWp/5
 cjSkUOo2uvIEVdxMy8ItzlZcz2iP9rEv/xcE2hw4rA0WMQemNnlDQH6EL2icS1P16AaY
 wdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HjaiaePE62sPbbhP/TIjCkGtxZeFziWMl3+zzS8KihA=;
 b=bGGOU9mpf139eNl/E9ySpjTbfVAMCNrWVDg5guCo+mboHxUwQLprv7S/QDrWdhgm3r
 ZKd6KS5W1+wyk+nOZ+NddjfVxgjjyU6QG8VoFe3c8RUExEVsc9t5vQTaINckf9AeNBEH
 rIsLIdJ9v/ZxEYB79fipbSTAKc3GDZCe/x9Rcu+7ITV+fDAShcKjviEGp6glu7BiWuCk
 DKoEqSWTd/tzM+2QpzmKsLgow591klbiGgDb/5Aeoteb4j6N8Ju8RTHlLSJC5Mb0Ygrx
 F0Dq4NtE7g3gn7rPFJ1R1OoSkNH6EoogENvCZkzmweTl9EtLtSfvmRssve3mk2dKO6kz
 bZhQ==
X-Gm-Message-State: APjAAAV5BCdlmcsJyCtvjLYJQsGmUEjoaDJGePdi5krzP2SfsJpsE0vQ
 oSna9s+mevR1MBaPy6DURhQ=
X-Google-Smtp-Source: APXvYqxAc8Fqv4TIMvXcNE182ht2UgF4ITSxJN5dKHaUZ7nA65pY+5TtKVvyQjtlxlAdAHBuNxfuOQ==
X-Received: by 2002:a63:ff20:: with SMTP id
 k32mr123738479pgi.445.1564736793596; 
 Fri, 02 Aug 2019 02:06:33 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id l124sm74813252pgl.54.2019.08.02.02.06.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 02:06:32 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Fri,  2 Aug 2019 17:06:26 +0800
Message-Id: <1564736786-26495-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2] migration: always initial ram_counters for
 a new migration
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
Cc: richardw.yang@linux.intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

This patch fix a multifd migration bug in migration speed calculation, this
problem can be reproduced as follows:
1. start a vm and give a heavy memory write stress to prevent the vm be
   successfully migrated to destination
2. begin a migration with multifd
3. migrate for a long time [actually, this can be measured by transferred bytes]
4. migrate cancel
5. begin a new migration with multifd, the migration will directly run into
   migration_completion phase

Reason as follows:

Migration update bandwidth and s->threshold_size in function
migration_update_counters after BUFFER_DELAY time:

    current_bytes = migration_total_bytes(s);
    transferred = current_bytes - s->iteration_initial_bytes;
    time_spent = current_time - s->iteration_start_time;
    bandwidth = (double)transferred / time_spent;
    s->threshold_size = bandwidth * s->parameters.downtime_limit;

In multifd migration, migration_total_bytes function return
qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
s->iteration_initial_bytes will be initialized to 0 at every new migration,
but ram_counters is a global variable, and history migration data will be
accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
pending_size >= s->threshold_size become false in migration_iteration_run
after the first migration_update_counters.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
---
v1->v2:
- Add interface update_iteration_initial_status to update statistic fields
  at the same time to avoid info mismatch lead wrong calculation result.

 migration/migration.c | 25 +++++++++++++++++++------
 migration/savevm.c    |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..5db62ef9c8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1908,6 +1908,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     }
 
     migrate_init(s);
+    /*
+     * set ram_counters memory to zero for a
+     * new migration
+     */
+    memset(&ram_counters, 0, sizeof(ram_counters));
 
     return true;
 }
@@ -3025,6 +3030,17 @@ static void migration_calculate_complete(MigrationState *s)
     }
 }
 
+static update_iteration_initial_status(MigrationState *s)
+{
+    /*
+     * Update these three fields at the same time to avoid mismatch info lead
+     * wrong speed calculation.
+     */
+    s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    s->iteration_initial_bytes = migration_total_bytes(s);
+    s->iteration_initial_pages = ram_get_total_transferred_pages();
+}
+
 static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
@@ -3060,9 +3076,7 @@ static void migration_update_counters(MigrationState *s,
 
     qemu_file_reset_rate_limit(s->to_dst_file);
 
-    s->iteration_start_time = current_time;
-    s->iteration_initial_bytes = current_bytes;
-    s->iteration_initial_pages = ram_get_total_transferred_pages();
+    update_iteration_initial_status(s);
 
     trace_migrate_transferred(transferred, time_spent,
                               bandwidth, s->threshold_size);
@@ -3186,7 +3200,7 @@ static void *migration_thread(void *opaque)
     rcu_register_thread();
 
     object_ref(OBJECT(s));
-    s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    update_iteration_initial_status(s);
 
     qemu_savevm_state_header(s->to_dst_file);
 
@@ -3251,8 +3265,7 @@ static void *migration_thread(void *opaque)
              * the local variables. This is important to avoid
              * breaking transferred_bytes and bandwidth calculation
              */
-            s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-            s->iteration_initial_bytes = 0;
+            update_iteration_initial_status(s);
         }
 
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..480c511b19 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1424,6 +1424,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 
     migrate_init(ms);
+    memset(&ram_counters, 0, sizeof(ram_counters));
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.17.2 (Apple Git-113)


