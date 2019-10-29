Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E29FCA9EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95CD20862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95CD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaZu-0005YG-V5
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTv-0000HS-6c
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTt-00041K-Fw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTt-0003z7-0x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:53 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 248567FD40
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:52 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id q54so503967qtk.15
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P7yTYFL9G7PZYQXSGt4rFXL9UlSnTV39mJFKFmnsoxE=;
 b=P3EnhC5BZ20e1nlgkTSWQv7faNbg5ypUqgT6iqfIiTGJtA29JSETXwDtv/fkqFmU6a
 Q/m4nTG3Kolx+ryVF9oTY8KIsO0eVUMUD55Bd2sVDhkA5gBjQrnEA1Mt2e4iec1ln97e
 eGV+sWtWyl7EBRbMYFwXJMjyv3229NL8gL/KMYQCHL4dSoTlTIFh959bO0NF8uDAW5Wu
 EpR7GYePnBZTIU5moN+46DW9N4S6M+37pGY3TmBRTro6sFzvG2lTbdz44JuE8ESLedZU
 3a5XpHJvJ7fvQv21ORB/6OpE/mFaaxydgU649/0Fu3vLRYqk0a1qNf7EnQhe3Wx5LSBp
 LT/g==
X-Gm-Message-State: APjAAAV8NVro5N72SDs1jByajG1iDPYMF1Z8Y57SV/SXVic1v3Qhf2JL
 QULR0FYUgi14pOmH6W6l3MAbxGs6bU/vmekarpsBperJi1eZoPnEDTJemV0XgCTIWyoKxZ9jmkU
 laIeyLUBbNxccomw=
X-Received: by 2002:a37:4253:: with SMTP id p80mr24523877qka.194.1572390051060; 
 Tue, 29 Oct 2019 16:00:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5h7n8le/u3jjONjK2J5L1GkHuqiYzqSUrJx9VfI3qRxV3mMxtjPO941oV1INq5Pll5h++Ow==
X-Received: by 2002:a37:4253:: with SMTP id p80mr24523844qka.194.1572390050706; 
 Tue, 29 Oct 2019 16:00:50 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id s123sm373860qke.31.2019.10.29.16.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:49 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] migration: add new migration state wait-unplug
Message-ID: <20191029225932.14585-9-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This patch adds a new migration state called wait-unplug.  It is entered
after the SETUP state if failover devices are present. It will transition
into ACTIVE once all devices were succesfully unplugged from the guest.

So if a guest doesn't respond or takes long to honor the unplug request
the user will see the migration state 'wait-unplug'.

In the migration thread we query failover devices if they're are still
pending the guest unplug. When all are unplugged the migration
continues. If one device won't unplug migration will stay in wait_unplug
state.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191029114905.6856-9-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/vmstate.h |  2 ++
 migration/migration.c       | 21 +++++++++++++++++++++
 migration/migration.h       |  3 +++
 migration/savevm.c          | 31 +++++++++++++++++++++++++++++++
 migration/savevm.h          |  2 ++
 qapi/migration.json         |  5 ++++-
 6 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index b9ee563aa4..ac4f46a67d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -186,6 +186,8 @@ struct VMStateDescription {
     int (*pre_save)(void *opaque);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
+    bool (*dev_unplug_pending)(void *opaque);
+
     const VMStateField *fields;
     const VMStateDescription **subsections;
 };
diff --git a/migration/migration.c b/migration/migration.c
index 4133ed2684..354ad072fa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -52,6 +52,7 @@
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "net/announce.h"
+#include "qemu/queue.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
@@ -819,6 +820,7 @@ bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_WAIT_UNPLUG:
         return true;
 
     default:
@@ -954,6 +956,9 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
         break;
+    case MIGRATION_STATUS_WAIT_UNPLUG:
+        info->has_status = true;
+        break;
     }
     info->status = s->state;
 }
@@ -1694,6 +1699,7 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_COLO:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_WAIT_UNPLUG:
         return false;
     case MIGRATION_STATUS__MAX:
         g_assert_not_reached();
@@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)
 
     qemu_savevm_state_setup(s->to_dst_file);
 
+    if (qemu_savevm_nr_failover_devices()) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_WAIT_UNPLUG);
+
+        while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
+               qemu_savevm_state_guest_unplug_pending()) {
+            qemu_sem_timedwait(&s->wait_unplug_sem, 250);
+        }
+
+        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
+                MIGRATION_STATUS_ACTIVE);
+    }
+
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
@@ -3511,6 +3530,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
@@ -3556,6 +3576,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rate_limit_sem, 0);
+    qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
 }
 
diff --git a/migration/migration.h b/migration/migration.h
index 4f2fe193dc..79b3dda146 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -206,6 +206,9 @@ struct MigrationState
     /* Flag set once the migration thread called bdrv_inactivate_all */
     bool block_inactive;
 
+    /* Migration is waiting for guest to unplug device */
+    QemuSemaphore wait_unplug_sem;
+
     /* Migration is paused due to pause-before-switchover */
     QemuSemaphore pause_sem;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 8d95e261f6..966a9c3bdb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1113,6 +1113,37 @@ void qemu_savevm_state_header(QEMUFile *f)
     }
 }
 
+int qemu_savevm_nr_failover_devices(void)
+{
+    SaveStateEntry *se;
+    int n = 0;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (se->vmsd && se->vmsd->dev_unplug_pending) {
+            n++;
+        }
+    }
+
+    return n;
+}
+
+bool qemu_savevm_state_guest_unplug_pending(void)
+{
+    SaveStateEntry *se;
+    int n = 0;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
+            continue;
+        }
+        if (se->vmsd->dev_unplug_pending(se->opaque)) {
+            n++;
+        }
+    }
+
+    return n > 0;
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
diff --git a/migration/savevm.h b/migration/savevm.h
index 51a4b9caa8..c42b9c80ee 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,6 +31,8 @@
 
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
+int qemu_savevm_nr_failover_devices(void);
+bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
diff --git a/qapi/migration.json b/qapi/migration.json
index e9e7a97c03..b7348d0c8b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -133,6 +133,9 @@
 # @device: During device serialisation when pause-before-switchover is enabled
 #        (since 2.11)
 #
+# @wait-unplug: wait for device unplug request by guest OS to be completed.
+#               (since 4.2)
+#
 # Since: 2.3
 #
 ##
@@ -140,7 +143,7 @@
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
             'postcopy-recover', 'completed', 'failed', 'colo',
-            'pre-switchover', 'device' ] }
+            'pre-switchover', 'device', 'wait-unplug' ] }
 
 ##
 # @MigrationInfo:
-- 
MST


