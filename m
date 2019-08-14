Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F0EC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFAA2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFAA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqEI-0000lI-DN
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxqBz-0006Io-JU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxqBy-0007R8-9q
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:39970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxqBv-0007Nw-Lj; Wed, 14 Aug 2019 06:07:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxqBt-00066c-2J; Wed, 14 Aug 2019 13:07:37 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 13:07:35 +0300
Message-Id: <20190814100735.24234-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190814100735.24234-1-vsementsov@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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

To get rid of implicit filters related workarounds in future let's
deprecate them now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-deprecated.texi      |  7 +++++++
 qapi/block-core.json      |  6 ++++--
 include/block/block_int.h | 10 +++++++++-
 blockdev.c                | 10 ++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2753fafd0b..8222440148 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -183,6 +183,13 @@ the 'wait' field, which is only applicable to sockets in server mode
 
 Use blockdev-mirror and blockdev-backup instead.
 
+@subsection implicit filters (since 4.2)
+
+Mirror and commit jobs inserts filters, which becomes implicit if user
+omitted filter-node-name parameter. So omitting it is deprecated, set it
+always. Note, that drive-mirror don't have this parameter, so it will
+create implicit filter anyway, but drive-mirror is deprecated itself too.
+
 @section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4e35526634..0505ac9d8b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1596,7 +1596,8 @@
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the commit job inserts into the graph
 #                    above @top. If this option is not given, a node name is
-#                    autogenerated. (Since: 2.9)
+#                    autogenerated. Omitting this option is deprecated, it will
+#                    be required in future. (Since: 2.9)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state after it has
 #                 finished its work, waiting for @block-job-finalize before
@@ -2249,7 +2250,8 @@
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the mirror job inserts into the graph
 #                    above @device. If this option is not given, a node name is
-#                    autogenerated. (Since: 2.9)
+#                    autogenerated. Omitting this option is deprecated, it will
+#                    be required in future. (Since: 2.9)
 #
 # @copy-mode: when to copy data to the destination; defaults to 'background'
 #             (Since: 3.0)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..624da0b4a2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -762,7 +762,15 @@ struct BlockDriverState {
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
     bool force_share; /* if true, always allow all shared permissions */
-    bool implicit;  /* if true, this filter node was automatically inserted */
+
+    /*
+     * @implicit field is deprecated, don't set it to true for new filters.
+     * If true, this filter node was automatically inserted and user don't
+     * know about it and unprepared for any effects of it. So, implicit
+     * filters are workarounded and skipped in many places of the block
+     * layer code.
+     */
+    bool implicit;
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
diff --git a/blockdev.c b/blockdev.c
index 36e9368e01..b3cfaccce1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3292,6 +3292,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
     int job_flags = JOB_DEFAULT;
 
+    if (!has_filter_node_name) {
+        warn_report("Omitting filter-node-name parameter is deprecated, it "
+                    "will be required in future");
+    }
+
     if (!has_speed) {
         speed = 0;
     }
@@ -3990,6 +3995,11 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     Error *local_err = NULL;
     int ret;
 
+    if (!has_filter_node_name) {
+        warn_report("Omitting filter-node-name parameter is deprecated, it "
+                    "will be required in future");
+    }
+
     bs = qmp_get_root_bs(device, errp);
     if (!bs) {
         return;
-- 
2.18.0


