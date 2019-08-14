Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25924C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8C32067D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8C32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqDA-0007ed-1Q
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxqBz-0006If-GR
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxqBy-0007R3-90
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:39976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxqBv-0007Ny-MB; Wed, 14 Aug 2019 06:07:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxqBs-00066c-UZ; Wed, 14 Aug 2019 13:07:37 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 13:07:34 +0300
Message-Id: <20190814100735.24234-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190814100735.24234-1-vsementsov@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/2] qapi: deprecate drive-mirror and
 drive-backup
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, libvir-list@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's hard and not necessary to maintain outdated versions of these
commands.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-deprecated.texi  |  4 ++++
 qapi/block-core.json  |  4 ++++
 qapi/transaction.json |  2 +-
 blockdev.c            | 10 ++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index fff07bb2a3..2753fafd0b 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -179,6 +179,10 @@ and accurate ``query-qmp-schema'' command.
 Character devices creating sockets in client mode should not specify
 the 'wait' field, which is only applicable to sockets in server mode
 
+@subsection drive-mirror, drive-backup and drive-backup transaction action (since 4.2)
+
+Use blockdev-mirror and blockdev-backup instead.
+
 @section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..4e35526634 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1635,6 +1635,8 @@
 ##
 # @drive-backup:
 #
+# Command is deprecated, use blockdev-mirror instead.
+#
 # Start a point-in-time copy of a block device to a new destination.  The
 # status of ongoing drive-backup operations can be checked with
 # query-block-jobs where the BlockJobInfo.type field has the value 'backup'.
@@ -1855,6 +1857,8 @@
 ##
 # @drive-mirror:
 #
+# Command is deprecated, use blockdev-mirror instead.
+#
 # Start mirroring a block device's writes to a new destination. target
 # specifies the target of the new image. If the file exists, or if it
 # is a device, it will be used as the new destination for writes. If
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 95edb78227..a16a9ff8a6 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -53,7 +53,7 @@
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
 # - @blockdev-snapshot-sync: since 1.1
-# - @drive-backup: since 1.6
+# - @drive-backup: deprecated action, since 1.6
 #
 # Since: 1.1
 ##
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..36e9368e01 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1771,6 +1771,9 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     AioContext *aio_context;
     Error *local_err = NULL;
 
+    warn_report("drive-backup transaction action is deprecated and will "
+                "disappear in future. Use blockdev-backup action instead");
+
     assert(common->action->type == TRANSACTION_ACTION_KIND_DRIVE_BACKUP);
     backup = common->action->u.drive_backup.data;
 
@@ -3591,6 +3594,10 @@ void qmp_drive_backup(DriveBackup *arg, Error **errp)
 {
 
     BlockJob *job;
+
+    warn_report("drive-backup command is deprecated and will disappear in "
+                "future. Use blockdev-backup instead");
+
     job = do_drive_backup(arg, NULL, errp);
     if (job) {
         job_start(&job->job);
@@ -3831,6 +3838,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     const char *format = arg->format;
     int ret;
 
+    warn_report("drive-mirror command is deprecated and will disappear in "
+                "future. Use blockdev-mirror instead");
+
     bs = qmp_get_root_bs(arg->device, errp);
     if (!bs) {
         return;
-- 
2.18.0


