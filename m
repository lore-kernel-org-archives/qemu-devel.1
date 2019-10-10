Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB92C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302812067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302812067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYYF-00022c-TU
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIYKu-0002ED-FT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIYKq-0002xj-L3
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31688
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIYKq-0002wl-Cs
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9AD7QmA131674
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vj2pmx0wm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:22 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 10 Oct 2019 14:18:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Oct 2019 14:18:15 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9ADIEUm40960074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 13:18:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5B7AA4054;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC673A405B;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from bahia.tls.ibm.com (bahia.tls.ibm.com [9.101.4.41])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 734A422006B;
 Thu, 10 Oct 2019 15:18:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 5/8] 9p: Added virtfs option 'multidevs=remap|forbid|warn'
Date: Thu, 10 Oct 2019 15:18:06 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010131809.1284004-1-groug@kaod.org>
References: <20191010131809.1284004-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101013-4275-0000-0000-00000370E0E5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101013-4276-0000-0000-00003883E89A
Message-Id: <20191010131809.1284004-6-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-10_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antonios Motakis <antonios.motakis@huawei.com>

'warn' (default): Only log an error message (once) on host if more than one
device is shared by same export, except of that just ignore this config
error though. This is the default behaviour for not breaking existing
installations implying that they really know what they are doing.

'forbid': Like 'warn', but except of just logging an error this
also denies access of guest to additional devices.

'remap': Allows to share more than one device per export by remapping
inodes from host to guest appropriately. To support multiple devices on the
9p share, and avoid qid path collisions we take the device id as input to
generate a unique QID path. The lowest 48 bits of the path will be set
equal to the file inode, and the top bits will be uniquely assigned based
on the top 16 bits of the inode and the device id.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Rebased to https://github.com/gkurz/qemu/commits/9p-next
       (SHA1 7fc4c49e91).
     - Added virtfs option 'multidevs', original patch simply did the inode
       remapping without being asked.
     - Updated hash calls to new xxhash API.
     - Updated docs for new option 'multidevs'.
     - Fixed v9fs_do_readdir() not having remapped inodes.
     - Log error message when running out of prefixes in
       qid_path_prefixmap().
     - Fixed definition of QPATH_INO_MASK.
     - Wrapped qpp_table initialization to dedicated qpp_table_init()
       function.
     - Dropped unnecessary parantheses in qpp_lookup_func().
     - Dropped unnecessary g_malloc0() result checks. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
[groug: - Moved "multidevs" parsing to the local backend.
        - Added hint to invalid multidevs option error.
	- Turn "remap" into "x-remap". ]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h      |   5 ++
 fsdev/qemu-fsdev-opts.c |   7 +-
 fsdev/qemu-fsdev.c      |   1 +
 hw/9pfs/9p-local.c      |  21 +++++
 hw/9pfs/9p.c            | 188 +++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h            |  12 +++
 qemu-options.hx         |  26 +++++-
 vl.c                    |   7 +-
 8 files changed, 242 insertions(+), 25 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index c757c8099f54..f2f7772c86d5 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -59,6 +59,11 @@ typedef struct ExtendedOps {
 #define V9FS_RDONLY                 0x00000040
 #define V9FS_PROXY_SOCK_FD          0x00000080
 #define V9FS_PROXY_SOCK_NAME        0x00000100
+/*
+ * multidevs option (either one of the two applies exclusively)
+ */
+#define V9FS_REMAP_INODES           0x00000200
+#define V9FS_FORBID_MULTIDEVS       0x00000400
 
 #define V9FS_SEC_MASK               0x0000003C
 
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 7c31ffffafb5..07a18c6e48d3 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -31,7 +31,9 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "readonly",
             .type = QEMU_OPT_BOOL,
-
+        }, {
+            .name = "multidevs",
+            .type = QEMU_OPT_STRING,
         }, {
             .name = "socket",
             .type = QEMU_OPT_STRING,
@@ -75,6 +77,9 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "readonly",
             .type = QEMU_OPT_BOOL,
+        }, {
+            .name = "multidevs",
+            .type = QEMU_OPT_STRING,
         }, {
             .name = "socket",
             .type = QEMU_OPT_STRING,
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 077a8c4e2bca..a9e069c0c78d 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -58,6 +58,7 @@ static FsDriverTable FsDrivers[] = {
             "writeout",
             "fmode",
             "dmode",
+            "multidevs",
             "throttling.bps-total",
             "throttling.bps-read",
             "throttling.bps-write",
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5c7f4cd9c7b0..4708c0bd896f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1483,6 +1483,7 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
+    const char *multidevs = qemu_opt_get(opts, "multidevs");
     Error *local_err = NULL;
 
     if (!sec_model) {
@@ -1506,6 +1507,26 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
         return -1;
     }
 
+    if (multidevs) {
+        if (!strcmp(multidevs, "remap")) {
+            fse->export_flags &= ~V9FS_FORBID_MULTIDEVS;
+            fse->export_flags |= V9FS_REMAP_INODES;
+        } else if (!strcmp(multidevs, "forbid")) {
+            fse->export_flags &= ~V9FS_REMAP_INODES;
+            fse->export_flags |= V9FS_FORBID_MULTIDEVS;
+        } else if (!strcmp(multidevs, "warn")) {
+            fse->export_flags &= ~V9FS_FORBID_MULTIDEVS;
+            fse->export_flags &= ~V9FS_REMAP_INODES;
+        } else {
+            error_setg(&local_err, "invalid multidevs property '%s'",
+                       multidevs);
+            error_append_hint(&local_err, "Valid options are: multidevs="
+                              "[remap|forbid|warn]\n");
+            error_propagate(errp, local_err);
+            return -1;
+        }
+    }
+
     if (!path) {
         error_setg(errp, "path property not set");
         return -1;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 5a895ae0bbfe..8eb89c5c7d3f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
+#include "qemu/xxhash.h"
 
 int open_fd_hw;
 int total_open_fd;
@@ -572,23 +573,117 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
-/* This is the algorithm from ufs in spfs */
+/* creative abuse of tb_hash_func7, which is based on xxhash */
+static uint32_t qpp_hash(QppEntry e)
+{
+    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
+}
+
+static bool qpp_lookup_func(const void *obj, const void *userp)
+{
+    const QppEntry *e1 = obj, *e2 = userp;
+    return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
+}
+
+static void qpp_table_remove(void *p, uint32_t h, void *up)
+{
+    g_free(p);
+}
+
+static void qpp_table_destroy(struct qht *ht)
+{
+    if (!ht || !ht->map) {
+        return;
+    }
+    qht_iter(ht, qpp_table_remove, NULL);
+    qht_destroy(ht);
+}
+
+static void qpp_table_init(struct qht *ht)
+{
+    qht_init(ht, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
+}
+
+/*
+ * stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
+ * to a unique QID path (64 bits). To avoid having to map and keep track
+ * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
+ * the device id to the 16 highest bits of the QID path. The 48 lowest bits
+ * of the QID path equal to the lowest bits of the inode number.
+ *
+ * This takes advantage of the fact that inode number are usually not
+ * random but allocated sequentially, so we have fewer items to keep
+ * track of.
+ */
+static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
+                              uint64_t *path)
+{
+    QppEntry lookup = {
+        .dev = stbuf->st_dev,
+        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
+    }, *val;
+    uint32_t hash = qpp_hash(lookup);
+
+    val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
+
+    if (!val) {
+        if (pdu->s->qp_prefix_next == 0) {
+            /* we ran out of prefixes */
+            error_report_once(
+                "9p: No more prefixes available for remapping inodes from "
+                "host to guest."
+            );
+            return -ENFILE;
+        }
+
+        val = g_malloc0(sizeof(QppEntry));
+        *val = lookup;
+
+        /* new unique inode prefix and device combo */
+        val->qp_prefix = pdu->s->qp_prefix_next++;
+        qht_insert(&pdu->s->qpp_table, val, hash, NULL);
+    }
+
+    *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+    return 0;
+}
+
 static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
 {
+    int err;
     size_t size;
 
-    if (pdu->s->dev_id != stbuf->st_dev) {
-        warn_report_once(
-            "9p: Multiple devices detected in same VirtFS export, "
-            "which might lead to file ID collisions and severe "
-            "misbehaviours on guest! You should use a separate "
-            "export for each device shared from host."
-        );
+    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
+        /* map inode+device to qid path (fast path) */
+        err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+        if (err) {
+            return err;
+        }
+    } else {
+        if (pdu->s->dev_id != stbuf->st_dev) {
+            if (pdu->s->ctx.export_flags & V9FS_FORBID_MULTIDEVS) {
+                error_report_once(
+                    "9p: Multiple devices detected in same VirtFS export. "
+                    "Access of guest to additional devices is (partly) "
+                    "denied due to virtfs option 'multidevs=forbid' being "
+                    "effective."
+                );
+                return -ENODEV;
+            } else {
+                warn_report_once(
+                    "9p: Multiple devices detected in same VirtFS export, "
+                    "which might lead to file ID collisions and severe "
+                    "misbehaviours on guest! You should either use a "
+                    "separate export for each device shared from host or "
+                    "use virtfs option 'multidevs=remap'!"
+                );
+            }
+        }
+        memset(&qidp->path, 0, sizeof(qidp->path));
+        size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
+        memcpy(&qidp->path, &stbuf->st_ino, size);
     }
 
-    memset(&qidp->path, 0, sizeof(qidp->path));
-    size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
-    memcpy(&qidp->path, &stbuf->st_ino, size);
     qidp->version = stbuf->st_mtime ^ (stbuf->st_size << 8);
     qidp->type = 0;
     if (S_ISDIR(stbuf->st_mode)) {
@@ -618,6 +713,30 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     return 0;
 }
 
+static int coroutine_fn dirent_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
+                                      struct dirent *dent, V9fsQID *qidp)
+{
+    struct stat stbuf;
+    V9fsPath path;
+    int err;
+
+    v9fs_path_init(&path);
+
+    err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
+    if (err < 0) {
+        goto out;
+    }
+    err = v9fs_co_lstat(pdu, &path, &stbuf);
+    if (err < 0) {
+        goto out;
+    }
+    err = stat_to_qid(pdu, &stbuf, qidp);
+
+out:
+    v9fs_path_free(&path);
+    return err;
+}
+
 V9fsPDU *pdu_alloc(V9fsState *s)
 {
     V9fsPDU *pdu = NULL;
@@ -1966,16 +2085,39 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
             v9fs_string_free(&name);
             return count;
         }
-        /*
-         * Fill up just the path field of qid because the client uses
-         * only that. To fill the entire qid structure we will have
-         * to stat each dirent found, which is expensive
-         */
-        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
-        memcpy(&qid.path, &dent->d_ino, size);
-        /* Fill the other fields with dummy values */
-        qid.type = 0;
-        qid.version = 0;
+
+        if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
+            /*
+             * dirent_to_qid() implies expensive stat call for each entry,
+             * we must do that here though since inode remapping requires
+             * the device id, which in turn might be different for
+             * different entries; we cannot make any assumption to avoid
+             * that here.
+             */
+            err = dirent_to_qid(pdu, fidp, dent, &qid);
+            if (err < 0) {
+                v9fs_readdir_unlock(&fidp->fs.dir);
+                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
+                v9fs_string_free(&name);
+                return err;
+            }
+        } else {
+            /*
+             * Fill up just the path field of qid because the client uses
+             * only that. To fill the entire qid structure we will have
+             * to stat each dirent found, which is expensive. For the
+             * latter reason we don't call dirent_to_qid() here. Only drawback
+             * is that no multi-device export detection of stat_to_qid()
+             * would be done and provided as error to the user here. But
+             * user would get that error anyway when accessing those
+             * files/dirs through other ways.
+             */
+            size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
+            memcpy(&qid.path, &dent->d_ino, size);
+            /* Fill the other fields with dummy values */
+            qid.type = 0;
+            qid.version = 0;
+        }
 
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "Qqbs",
@@ -3676,6 +3818,9 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->dev_id = stat.st_dev;
 
+    qpp_table_init(&s->qpp_table);
+    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
@@ -3697,6 +3842,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
         fsdev_throttle_cleanup(s->ctx.fst);
     }
     g_free(s->tag);
+    qpp_table_destroy(&s->qpp_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5e316178d579..7262fe80aa02 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -8,6 +8,7 @@
 #include "fsdev/9p-iov-marshal.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/qht.h"
 
 enum {
     P9_TLERROR = 6,
@@ -235,6 +236,15 @@ struct V9fsFidState
     V9fsFidState *rclm_lst;
 };
 
+#define QPATH_INO_MASK        ((1ULL << 48) - 1)
+
+/* QID path prefix entry, see stat_to_qid */
+typedef struct {
+    dev_t dev;
+    uint16_t ino_prefix;
+    uint16_t qp_prefix;
+} QppEntry;
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -257,6 +267,8 @@ struct V9fsState
     V9fsConf fsconf;
     V9fsQID root_qid;
     dev_t dev_id;
+    struct qht qpp_table;
+    uint16_t qp_prefix_next;
 };
 
 /* 9p2000.L open flags */
diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac509..793d70ff9388 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1339,7 +1339,7 @@ ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
+    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode][,multidevs=remap|forbid|warn]\n"
     "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
     "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
     "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
@@ -1347,7 +1347,7 @@ DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
 
 STEXI
 
-@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}]
+@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}][,multidevs=@var{multidevs}]
 @itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
 @itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
 @itemx -virtfs synth,mount_tag=@var{mount_tag}
@@ -1403,6 +1403,28 @@ Specifies the default mode for newly created directories on the host. Works
 only with security models "mapped-xattr" and "mapped-file".
 @item mount_tag=@var{mount_tag}
 Specifies the tag name to be used by the guest to mount this export point.
+@item multidevs=@var{multidevs}
+Specifies how to deal with multiple devices being shared with a 9p export.
+Supported behaviours are either "remap", "forbid" or "warn". The latter is
+the default behaviour on which virtfs 9p expects only one device to be
+shared with the same export, and if more than one device is shared and
+accessed via the same 9p export then only a warning message is logged
+(once) by qemu on host side. In order to avoid file ID collisions on guest
+you should either create a separate virtfs export for each device to be
+shared with guests (recommended way) or you might use "remap" instead which
+allows you to share multiple devices with only one export instead, which is
+achieved by remapping the original inode numbers from host to guest in a
+way that would prevent such collisions. Remapping inodes in such use cases
+is required because the original device IDs from host are never passed and
+exposed on guest. Instead all files of an export shared with virtfs always
+share the same device id on guest. So two files with identical inode
+numbers but from actually different devices on host would otherwise cause a
+file ID collision and hence potential misbehaviours on guest. "forbid" on
+the other hand assumes like "warn" that only one device is shared by the
+same export, however it will not only log a warning message but also
+deny access to additional devices on guest. Note though that "forbid" does
+currently not block all possible file access operations (e.g. readdir()
+would still return entries from other devices).
 @end table
 ETEXI
 
diff --git a/vl.c b/vl.c
index 002bf4919e1e..0a295e5d77d6 100644
--- a/vl.c
+++ b/vl.c
@@ -3335,7 +3335,8 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_virtfs: {
                 QemuOpts *fsdev;
                 QemuOpts *device;
-                const char *writeout, *sock_fd, *socket, *path, *security_model;
+                const char *writeout, *sock_fd, *socket, *path, *security_model,
+                           *multidevs;
 
                 olist = qemu_find_opts("virtfs");
                 if (!olist) {
@@ -3395,6 +3396,10 @@ int main(int argc, char **argv, char **envp)
                 qemu_opt_set_bool(fsdev, "readonly",
                                   qemu_opt_get_bool(opts, "readonly", 0),
                                   &error_abort);
+                multidevs = qemu_opt_get(opts, "multidevs");
+                if (multidevs) {
+                    qemu_opt_set(fsdev, "multidevs", multidevs, &error_abort);
+                }
                 device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
                                           &error_abort);
                 qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-- 
2.21.0


