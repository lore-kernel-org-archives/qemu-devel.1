Received: from eggs.gnu.org ([2001:4830:134:3::10]:41581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-00020Q-SB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qr-0005A7-6f
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52088
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qq-00059E-U5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WCI108433
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:44 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29aeabyxs3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:44 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:43 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:26 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-63-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 62/81] block/nfs: fix naming of runtime opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

From: Peter Lieven <pl@kamp.de>

commit 94d6a7a accidentally left the naming of runtime opts and QAPI
scheme inconsistent. As one consequence passing of parameters in the
URI is broken. Sync the naming of the runtime opts to the QAPI
scheme.

Please note that this is technically backwards incompatible with the 2.8
release, but the 2.8 release is the only version that had the wrong naming.
Furthermore release 2.8 suffered from a NULL pointer dereference during
URI parsing.

Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-id: 1485942829-10756-3-git-send-email-pl@kamp.de
[mreitz: Fixed commit message]
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>

(cherry picked from commit f67409a5bb43ebe74401fa8e187267eb0f139293)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nfs.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index dd376db..31de959 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -358,27 +358,27 @@ static QemuOptsList runtime_opts = {
             .help = "Path of the image on the host",
         },
         {
-            .name = "uid",
+            .name = "user",
             .type = QEMU_OPT_NUMBER,
             .help = "UID value to use when talking to the server",
         },
         {
-            .name = "gid",
+            .name = "group",
             .type = QEMU_OPT_NUMBER,
             .help = "GID value to use when talking to the server",
         },
         {
-            .name = "tcp-syncnt",
+            .name = "tcp-syn-count",
             .type = QEMU_OPT_NUMBER,
             .help = "Number of SYNs to send during the session establish",
         },
         {
-            .name = "readahead",
+            .name = "readahead-size",
             .type = QEMU_OPT_NUMBER,
             .help = "Set the readahead size in bytes",
         },
         {
-            .name = "pagecache",
+            .name = "page-cache-size",
             .type = QEMU_OPT_NUMBER,
             .help = "Set the pagecache size in bytes",
         },
@@ -507,29 +507,29 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
         goto fail;
     }
 
-    if (qemu_opt_get(opts, "uid")) {
-        client->uid = qemu_opt_get_number(opts, "uid", 0);
+    if (qemu_opt_get(opts, "user")) {
+        client->uid = qemu_opt_get_number(opts, "user", 0);
         nfs_set_uid(client->context, client->uid);
     }
 
-    if (qemu_opt_get(opts, "gid")) {
-        client->gid = qemu_opt_get_number(opts, "gid", 0);
+    if (qemu_opt_get(opts, "group")) {
+        client->gid = qemu_opt_get_number(opts, "group", 0);
         nfs_set_gid(client->context, client->gid);
     }
 
-    if (qemu_opt_get(opts, "tcp-syncnt")) {
-        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syncnt", 0);
+    if (qemu_opt_get(opts, "tcp-syn-count")) {
+        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syn-count", 0);
         nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
     }
 
 #ifdef LIBNFS_FEATURE_READAHEAD
-    if (qemu_opt_get(opts, "readahead")) {
+    if (qemu_opt_get(opts, "readahead-size")) {
         if (open_flags & BDRV_O_NOCACHE) {
             error_setg(errp, "Cannot enable NFS readahead "
                              "if cache.direct = on");
             goto fail;
         }
-        client->readahead = qemu_opt_get_number(opts, "readahead", 0);
+        client->readahead = qemu_opt_get_number(opts, "readahead-size", 0);
         if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
             error_report("NFS Warning: Truncating NFS readahead "
                          "size to %d", QEMU_NFS_MAX_READAHEAD_SIZE);
@@ -544,13 +544,13 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
 #endif
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
-    if (qemu_opt_get(opts, "pagecache")) {
+    if (qemu_opt_get(opts, "page-cache-size")) {
         if (open_flags & BDRV_O_NOCACHE) {
             error_setg(errp, "Cannot enable NFS pagecache "
                              "if cache.direct = on");
             goto fail;
         }
-        client->pagecache = qemu_opt_get_number(opts, "pagecache", 0);
+        client->pagecache = qemu_opt_get_number(opts, "page-cache-size", 0);
         if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
             error_report("NFS Warning: Truncating NFS pagecache "
                          "size to %d pages", QEMU_NFS_MAX_PAGECACHE_SIZE);
@@ -803,22 +803,22 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     qdict_put(opts, "path", qstring_from_str(client->path));
 
     if (client->uid) {
-        qdict_put(opts, "uid", qint_from_int(client->uid));
+        qdict_put(opts, "user", qint_from_int(client->uid));
     }
     if (client->gid) {
-        qdict_put(opts, "gid", qint_from_int(client->gid));
+        qdict_put(opts, "group", qint_from_int(client->gid));
     }
     if (client->tcp_syncnt) {
-        qdict_put(opts, "tcp-syncnt",
-                      qint_from_int(client->tcp_syncnt));
+        qdict_put(opts, "tcp-syn-cnt",
+                  qint_from_int(client->tcp_syncnt));
     }
     if (client->readahead) {
-        qdict_put(opts, "readahead",
-                      qint_from_int(client->readahead));
+        qdict_put(opts, "readahead-size",
+                  qint_from_int(client->readahead));
     }
     if (client->pagecache) {
-        qdict_put(opts, "pagecache",
-                      qint_from_int(client->pagecache));
+        qdict_put(opts, "page-cache-size",
+                  qint_from_int(client->pagecache));
     }
     if (client->debug) {
         qdict_put(opts, "debug", qint_from_int(client->debug));
-- 
2.7.4
