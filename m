Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A987FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76030206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZjWEjhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76030206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUek-0001KN-Ij
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1htUeB-0000uD-Hr
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1htUeA-0002ik-9j
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:18:51 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1htUeA-0002iM-3T
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:18:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id l21so35842125pgm.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=kQu6m9ey+QzJckmUlXYBq5skDhJZphPeYRk2B18xjGk=;
 b=bZjWEjhQvjabaCgLNI/4Z5Ghe//PI+tuxw27IYG0oNiSLc1JVOeXzKbOqtWwCQhB/5
 fVKqKTyGxxD8jchhavW/OYdIdjW8tS7pVc2kvRKEYM7psdGhGpHAmTuxNpuOqDdBMhD9
 3PQNh/DOIRbqZdGAcSABdXgtAj/8fx2HjXp3b6opI6pbJeygMXzqNNMZ1osQqCsxv96O
 vj+YLZpOOtG2/v9eoek7kHPA2mNMjXlVmUq1EMDCG1B3ITFjMdv9WYlWzAX+erL5DHAg
 Q6bSO1vSgP48krkTW17Ttm571lI7RbW/zIln+erLVDjaqYdrrqIKs9rSwN+21OfET/qp
 hiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kQu6m9ey+QzJckmUlXYBq5skDhJZphPeYRk2B18xjGk=;
 b=a8jW6aqNSaiznpmEZoxjKuQSEG1sKGGwZ/XqXUt0d016QlGNREYtpUdP8NbFfXHwiz
 aDSNQRUKqR4L3D7xWLwqTlGqocDtUUAMeepkBW7jJE3WGHppjs3/N4mmpWh8t/HVVxn0
 kARRR7Zil1epeLvIuhBNo0An8tckC92YDlPEWC7GbiRVUcDIDwjY51kHwVc91KiDiTmx
 NpzJ1TBK3/f3qz6tRI80H6HFWuNL2Iy1E0oDDAmx7aFb5Y5HOuvcmTDNBYNcIFQ3221D
 LlNtIYDMD/YYXF5ewRIgLL9Qg3SZL7xTxdU0u1xr7htJznD90jKkE9CXw9aDiz7HwXc/
 QL9Q==
X-Gm-Message-State: APjAAAVQmwtoUCpymajYGeKuynzReaCx9tRKzPMe/yC/4qieGGKhXbZ0
 UaAGPJtRVg1GVgHlxerHEZg=
X-Google-Smtp-Source: APXvYqzTmmSBGiVxKEDubXi5F0z/qB+BZw7FyH88Htv+yThl0BwBdHs0O2BwH0e4dY4cjrBON2t3ng==
X-Received: by 2002:a65:4103:: with SMTP id w3mr104954718pgp.1.1564741129014; 
 Fri, 02 Aug 2019 03:18:49 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id d8sm68625412pgh.45.2019.08.02.03.18.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 03:18:48 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Fri,  2 Aug 2019 18:18:41 +0800
Message-Id: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3] migration: always initial ram_counters for
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
v2->v3:
- fix the bug of update_iteration_initial_status function prototype

v1->v2:
- Add interface update_iteration_initial_status to update statistic fields
  at the same time to avoid info mismatch lead wrong calculation result.

 migration/migration.c | 25 +++++++++++++++++++------
 migration/savevm.c    |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..bea9b1d796 100644
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
 
+static void update_iteration_initial_status(MigrationState *s)
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


