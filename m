Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38018C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DB82086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="K6QrNhvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DB82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgEv6-0004PO-5k
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <91b9f8920735847e6c0e84ab6dc2c689aed13cc7@lizzy.crudebyte.com>)
 id 1hgEpz-0001gU-HB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <91b9f8920735847e6c0e84ab6dc2c689aed13cc7@lizzy.crudebyte.com>)
 id 1hgEpx-0003yW-MG
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:48:15 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <91b9f8920735847e6c0e84ab6dc2c689aed13cc7@lizzy.crudebyte.com>)
 id 1hgEpx-0003P7-BH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDmz6Bza9y8m5TNLYcExNFbmvDU09CBEV35VY6at+FU=; b=K6QrNhvD97j8VfeGGzqDSrH5e
 0tjKKUOsdWzZp9qiAhFhRIonX0rouz2nB0hZMEvwREG+XTapmg37OKL+84a5FpexPWdKp/O2ORc6Y
 +3cqs5R8SiDFbUnCCj+B9sjHmXrpvRtad1yabyhsBouWfCpcSxCUrZRFJ51siWe6+Ize/UoBsmAT5
 CPCsDdBUGNEYh4QqxDTHbuPhKj9tU7nt9oTL5Kx1JU4fa3oH6FycpiSCt1st3Ioa50KjOTkUole85
 7KFFweL7GpqwNkx+dL+j0J9664lpc9EpcM5waOj/o6wGM9+QeaFRr+dcnRZyrRpbQtiDoGLYG65gJ
 i3IA0gRiA==;
Message-Id: <91b9f8920735847e6c0e84ab6dc2c689aed13cc7.1561575449.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1561575449.git.qemu_oss@crudebyte.com>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 20:42:13 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v4 3/5] 9p: Added virtfs option "remap_inodes"
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To support multiple devices on the 9p share, and avoid
qid path collisions we take the device id as input
to generate a unique QID path. The lowest 48 bits of
the path will be set equal to the file inode, and the
top bits will be uniquely assigned based on the top
16 bits of the inode and the device id.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h      |   1 +
 fsdev/qemu-fsdev-opts.c |   7 +++-
 fsdev/qemu-fsdev.c      |   6 +++
 hw/9pfs/9p.c            | 105 ++++++++++++++++++++++++++++++++++++++++++------
 hw/9pfs/9p.h            |  12 ++++++
 qemu-options.hx         |  17 +++++++-
 vl.c                    |   3 ++
 7 files changed, 135 insertions(+), 16 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index c757c8099f..6c1663c252 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -59,6 +59,7 @@ typedef struct ExtendedOps {
 #define V9FS_RDONLY                 0x00000040
 #define V9FS_PROXY_SOCK_FD          0x00000080
 #define V9FS_PROXY_SOCK_NAME        0x00000100
+#define V9FS_REMAP_INODES           0x00000200
 
 #define V9FS_SEC_MASK               0x0000003C
 
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 7c31ffffaf..64a8052266 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -31,7 +31,9 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "readonly",
             .type = QEMU_OPT_BOOL,
-
+        }, {
+            .name = "remap_inodes",
+            .type = QEMU_OPT_BOOL,
         }, {
             .name = "socket",
             .type = QEMU_OPT_STRING,
@@ -76,6 +78,9 @@ static QemuOptsList qemu_virtfs_opts = {
             .name = "readonly",
             .type = QEMU_OPT_BOOL,
         }, {
+            .name = "remap_inodes",
+            .type = QEMU_OPT_BOOL,
+        }, {
             .name = "socket",
             .type = QEMU_OPT_STRING,
         }, {
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 077a8c4e2b..b6fa9799be 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -121,6 +121,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     const char *fsdev_id = qemu_opts_id(opts);
     const char *fsdriver = qemu_opt_get(opts, "fsdriver");
     const char *writeout = qemu_opt_get(opts, "writeout");
+    bool remap_inodes = qemu_opt_get_bool(opts, "remap_inodes", 0);
     bool ro = qemu_opt_get_bool(opts, "readonly", 0);
 
     if (!fsdev_id) {
@@ -161,6 +162,11 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     } else {
         fsle->fse.export_flags &= ~V9FS_RDONLY;
     }
+    if (remap_inodes) {
+        fsle->fse.export_flags |= V9FS_REMAP_INODES;
+    } else {
+        fsle->fse.export_flags &= ~V9FS_REMAP_INODES;
+    }
 
     if (fsle->fse.ops->parse_opts) {
         if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cbaa212625..7ccc68a829 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
+#include "qemu/xxhash.h"
 
 int open_fd_hw;
 int total_open_fd;
@@ -571,24 +572,96 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
-/* This is the algorithm from ufs in spfs */
+
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
+    qht_iter(ht, qpp_table_remove, NULL);
+    qht_destroy(ht);
+}
+
+/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
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
+                                uint64_t *path)
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
-    size_t size;
+    int err;
 
-    if (pdu->s->dev_id == 0) {
-        pdu->s->dev_id = stbuf->st_dev;
-    } else if (pdu->s->dev_id != stbuf->st_dev) {
-        error_report_once(
-            "9p: Multiple devices detected in same VirtFS export. "
-            "You must use a separate export for each device."
-        );
-        return -ENOSYS;
+    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
+        /* map inode+device to qid path (fast path) */
+        err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+        if (err) {
+            return err;
+        }
+    } else {
+        if (pdu->s->dev_id == 0) {
+            pdu->s->dev_id = stbuf->st_dev;
+        } else if (pdu->s->dev_id != stbuf->st_dev) {
+            error_report_once(
+                "9p: Multiple devices detected in same VirtFS export. "
+                "You must either use a separate export for each device "
+                "shared from host or enable virtfs option 'remap_inodes'."
+            );
+            return -ENOSYS;
+        }
+        size_t size;
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
@@ -3676,6 +3749,10 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->dev_id = 0;
 
+    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
+    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
+    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
@@ -3689,6 +3766,7 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
+        qpp_table_destroy(&s->qpp_table);
         v9fs_path_free(&path);
     }
     return rc;
@@ -3701,6 +3779,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
+    qpp_table_destroy(&s->qpp_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5e316178d5..0200e04176 100644
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
 
+#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
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
index 0d8beb4afd..e7ea136da1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1334,7 +1334,7 @@ ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
+    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode][,remap_inodes]\n"
     "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
     "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
     "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
@@ -1342,7 +1342,7 @@ DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
 
 STEXI
 
-@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}]
+@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}][,remap_inodes]
 @itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
 @itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
 @itemx -virtfs synth,mount_tag=@var{mount_tag}
@@ -1398,6 +1398,19 @@ Specifies the default mode for newly created directories on the host. Works
 only with security models "mapped-xattr" and "mapped-file".
 @item mount_tag=@var{mount_tag}
 Specifies the tag name to be used by the guest to mount this export point.
+@item remap_inodes
+By default virtfs 9p supports only one device per export in order to avoid
+file ID collisions on guest which may otherwise happen because the original
+device IDs from host are not passed and exposed on guest. Instead all files
+of an export shared with virtfs do have the same device id on guest. So two
+files with identical inode numbers but from actually different devices on
+host would otherwise cause a file ID collision and hence potential
+misbehaviours on guest. For that reason it is recommended to create a
+separate virtfs export for each device to be shared with guests. However
+you may also enable "remap_inodes" which allows you to share multiple
+devices with only one export instead, which is achieved by remapping the
+original inode numbers from host to guest in a way that would prevent such
+collisions.
 @end table
 ETEXI
 
diff --git a/vl.c b/vl.c
index 99a56b5556..de9d7b846c 100644
--- a/vl.c
+++ b/vl.c
@@ -3457,6 +3457,9 @@ int main(int argc, char **argv, char **envp)
                 qemu_opt_set_bool(fsdev, "readonly",
                                   qemu_opt_get_bool(opts, "readonly", 0),
                                   &error_abort);
+                qemu_opt_set_bool(fsdev, "remap_inodes",
+                                  qemu_opt_get_bool(opts, "remap_inodes", 0),
+                                  &error_abort);
                 device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
                                           &error_abort);
                 qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-- 
2.11.0


