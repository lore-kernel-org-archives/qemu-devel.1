Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62098C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0FD21655
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0FD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKXK-00084U-98
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1heKWZ-0007cO-Oe
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1heKWX-0001jQ-NS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:28:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:22046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1heKWV-0001gG-S5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:28:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jun 2019 07:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,400,1557212400"; d="scan'208";a="160981182"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2019 07:28:11 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 22:27:39 +0800
Message-Id: <20190621142739.23703-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change. Add default case to fix warning.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.c | 8 +++++++-
 migration/migration.h | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2865ae3fa9..0fd2364961 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -946,6 +946,8 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
         break;
+    default:
+        return;
     }
     info->status = s->state;
 }
@@ -1054,6 +1056,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
         info->has_status = true;
         fill_destination_postcopy_migration_info(info);
         break;
+    default:
+        return;
     }
     info->status = mis->state;
 }
@@ -1446,7 +1450,7 @@ void qmp_migrate_start_postcopy(Error **errp)
 
 /* shared migration helpers */
 
-void migrate_set_state(int *state, int old_state, int new_state)
+void migrate_set_state(MigrationStatus *state, int old_state, int new_state)
 {
     assert(new_state < MIGRATION_STATUS__MAX);
     if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
@@ -1683,6 +1687,8 @@ bool migration_is_idle(void)
         return false;
     case MIGRATION_STATUS__MAX:
         g_assert_not_reached();
+    default:
+        g_assert_not_reached();
     }
 
     return false;
diff --git a/migration/migration.h b/migration/migration.h
index 5e8f09c6db..418ee00053 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -65,7 +65,7 @@ struct MigrationIncomingState {
 
     QEMUBH *bh;
 
-    int state;
+    MigrationStatus state;
 
     bool have_colo_incoming_thread;
     QemuThread colo_incoming_thread;
@@ -151,7 +151,7 @@ struct MigrationState
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
 
-    int state;
+    MigrationStatus state;
 
     /* State related to return path */
     struct {
@@ -234,7 +234,7 @@ struct MigrationState
     bool decompress_error_check;
 };
 
-void migrate_set_state(int *state, int old_state, int new_state);
+void migrate_set_state(MigrationStatus *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
-- 
2.19.1


