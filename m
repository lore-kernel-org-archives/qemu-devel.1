Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32619C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF3F20651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bMyrqjgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3F20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaxc-0004ye-59
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:22:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hMawO-00044w-Mz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hMawM-0005xm-Pa
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:21:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:37683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hMawM-0005uu-EB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jUQkwYPzvO0YHreR8rdXZHsHcIOqrnpekeHGYLcIjTs=;
	b=bMyrqjgUtSfY5nH6KjZFCKNdu4
	ypaCMttF2qM8FT7jmDvTiTZhvzXKMSaS6g7Z6OybmG1FM3Ll8Rw9nUF8H+V8coWQSncBj6vXOLgj7
	046KhjoMYMeXBOOhT9hkWQ9EueA8oZqHpluHiG5eP0FDJ4sSk6rg5VrRAPlFG2ZU0UYBsRN4ro8/O
	oO4vJLlfX/OP2mG8xBsmeuJdoVB5tXhnk9hFuAuiw4c89XzpsuKAZdhzrfCuCcIssXpklwVBskvbe
	z6jiZhGW2C6KFXDkzTgB8dkBE0u8vnlg0kgMmV7WpvhUNe6H845o+W12CTWgM5ITQLIVfVoc4fxXu
	eGSNKbqp3FDmdxRSyPGK5G8+bBCWgA/4uZEoe3d4CE8Xvou2HSA+VaIiY+eKIjbmmNUEXPEdVg29e
	fTNohd15cdh+bJ6smRSFUtUSkqC0z404+SIDHDF2WhyTxubInJHt/QUnlK/wM1IWLnV4IPEa7jwDm
	MSm9rxtXqZvQWTfN2STBmPIk3qsYxMkESJu6UYCePWGqe4qPKYkbX+iWjrpT+3RccfQe+A4OeS62d
	5s0/N65E9WYrAqisoAESJbIlOiyIaWT9NbqX1x0xtAj6p4J674sSxzuB3vYuaM3p/N9bEVp/u510O
	JamOEr2pkwXDiMICS0ludhnkwNp5zAJR8NADSk2gM=;
To: qemu-devel@nongnu.org
Date: Fri, 03 May 2019 18:21:36 +0200
Message-ID: <4098708.SsLUBcHhAu@silver>
In-Reply-To: <cover.1556896526.git.qemu_oss@crudebyte.com>
References: <cover.1556896526.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam_score: -0.0
X-Spam_score_int: 0
X-Spam_bar: /
X-Spam_report: Spam detection software,
	running on the system "kylie.crudebyte.com", 
	has NOT identified this incoming email as spam.  The original
	message has been attached to this so you can view it or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview: This first patch here is an updated version of
	Antonios Motakis' original 4-patch set, merged to one patch:
	https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02283.html
	* Updated to latest git master, specifically to new qht interface. 
	Content analysis details:   (-0.0 points, 5.0 required)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	-0.0 NO_RELAYS Informational: message was not relayed via SMTP
	0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
	blocked.  See
	http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
	for more information. [URIs: gnu.org]
	-0.0 NO_RECEIVED Informational: message has no Received headers
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: [Qemu-devel] [PATCH v2 1/4] 9p: mitigates most QID path collisions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503162136.QQx2l3Q_F-ZQ3CaROO1-yr9HtJbQmsng3pJBnDZu5aM@z>

This first patch here is an updated version of Antonios Motakis'
original 4-patch set, merged to one patch:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02283.html

* Updated to latest git master, specifically to new qht interface.

* Merged the original 4 patches to this single patch.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/9p-marshal.h |   4 +-
 hw/9pfs/9p.c       | 200 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h       |  21 ++++++
 3 files changed, 204 insertions(+), 21 deletions(-)

diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
index c8823d878f..d1ad3645c4 100644
--- a/fsdev/9p-marshal.h
+++ b/fsdev/9p-marshal.h
@@ -10,8 +10,8 @@ typedef struct V9fsString
 typedef struct V9fsQID
 {
     int8_t type;
-    int32_t version;
-    int64_t path;
+    uint32_t version;
+    uint64_t path;
 } V9fsQID;
 
 typedef struct V9fsStat
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 55821343e5..b9bbdcbaee 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
+#include "qemu/xxhash.h"
 
 int open_fd_hw;
 int total_open_fd;
@@ -571,14 +572,135 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
-/* This is the algorithm from ufs in spfs */
-static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
+
+/* creative abuse of qemu_xxhash7, which is based on xxhash */
+static uint32_t qpp_hash(QppEntry e)
 {
-    size_t size;
+    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
+}
+
+static uint32_t qpf_hash(QpfEntry e)
+{
+    return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
+}
+
+static bool qpp_cmp_func(const void *obj, const void *userp)
+{
+    const QppEntry *e1 = obj, *e2 = userp;
+    return (e1->dev == e2->dev) && (e1->ino_prefix == e2->ino_prefix);
+}
+
+static bool qpf_cmp_func(const void *obj, const void *userp)
+{
+    const QpfEntry *e1 = obj, *e2 = userp;
+    return (e1->dev == e2->dev) && (e1->ino == e2->ino);
+}
+
+static void qp_table_remove(void *p, uint32_t h, void *up)
+{
+    g_free(p);
+}
+
+static void qp_table_destroy(struct qht *ht)
+{
+    qht_iter(ht, qp_table_remove, NULL);
+    qht_destroy(ht);
+}
+
+static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
+                            uint64_t *path)
+{
+    QpfEntry lookup = {
+        .dev = stbuf->st_dev,
+        .ino = stbuf->st_ino
+    }, *val;
+    uint32_t hash = qpf_hash(lookup);
+
+    /* most users won't need the fullmap, so init the table lazily */
+    if (!pdu->s->qpf_table.map) {
+        qht_init(&pdu->s->qpf_table, qpf_cmp_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
+    }
+
+    val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
+
+    if (!val) {
+        if (pdu->s->qp_fullpath_next == 0) {
+            /* no more files can be mapped :'( */
+            return -ENFILE;
+        }
+
+        val = g_malloc0(sizeof(QppEntry));
+        if (!val) {
+            return -ENOMEM;
+        }
+        *val = lookup;
+
+        /* new unique inode and device combo */
+        val->path = pdu->s->qp_fullpath_next++;
+        pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
+        qht_insert(&pdu->s->qpf_table, val, hash, NULL);
+    }
+
+    *path = val->path;
+    return 0;
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
+        if (!val) {
+            return -ENOMEM;
+        }
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
+static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
+{
+    int err;
+
+    /* map inode+device to qid path (fast path) */
+    err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+    if (err == -ENFILE) {
+        /* fast path didn't work, fal back to full map */
+        err = qid_path_fullmap(pdu, stbuf, &qidp->path);
+    }
+    if (err) {
+        return err;
+    }
 
-    memset(&qidp->path, 0, sizeof(qidp->path));
-    size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
-    memcpy(&qidp->path, &stbuf->st_ino, size);
     qidp->version = stbuf->st_mtime ^ (stbuf->st_size << 8);
     qidp->type = 0;
     if (S_ISDIR(stbuf->st_mode)) {
@@ -587,6 +709,8 @@ static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
     if (S_ISLNK(stbuf->st_mode)) {
         qidp->type |= P9_QID_TYPE_SYMLINK;
     }
+
+    return 0;
 }
 
 static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
@@ -599,7 +723,10 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     if (err < 0) {
         return err;
     }
-    stat_to_qid(&stbuf, qidp);
+    err = stat_to_qid(pdu, &stbuf, qidp);
+    if (err < 0) {
+        return err;
+    }
     return 0;
 }
 
@@ -830,7 +957,10 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 
     memset(v9stat, 0, sizeof(*v9stat));
 
-    stat_to_qid(stbuf, &v9stat->qid);
+    err = stat_to_qid(pdu, stbuf, &v9stat->qid);
+    if (err < 0) {
+        return err;
+    }
     v9stat->mode = stat_to_v9mode(stbuf);
     v9stat->atime = stbuf->st_atime;
     v9stat->mtime = stbuf->st_mtime;
@@ -891,7 +1021,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 #define P9_STATS_ALL           0x00003fffULL /* Mask for All fields above */
 
 
-static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
+static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
                                 V9fsStatDotl *v9lstat)
 {
     memset(v9lstat, 0, sizeof(*v9lstat));
@@ -913,7 +1043,7 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
     /* Currently we only support BASIC fields in stat */
     v9lstat->st_result_mask = P9_STATS_BASIC;
 
-    stat_to_qid(stbuf, &v9lstat->qid);
+    return stat_to_qid(pdu, stbuf, &v9lstat->qid);
 }
 
 static void print_sg(struct iovec *sg, int cnt)
@@ -1115,7 +1245,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
     uint64_t request_mask;
     V9fsStatDotl v9stat_dotl;
     V9fsPDU *pdu = opaque;
-    V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dq", &fid, &request_mask);
     if (retval < 0) {
@@ -1136,7 +1265,10 @@ static void coroutine_fn v9fs_getattr(void *opaque)
     if (retval < 0) {
         goto out;
     }
-    stat_to_v9stat_dotl(s, &stbuf, &v9stat_dotl);
+    retval = stat_to_v9stat_dotl(pdu, &stbuf, &v9stat_dotl);
+    if (retval < 0) {
+        goto out;
+    }
 
     /*  fill st_gen if requested and supported by underlying fs */
     if (request_mask & P9_STATS_GEN) {
@@ -1381,7 +1513,10 @@ static void coroutine_fn v9fs_walk(void *opaque)
             if (err < 0) {
                 goto out;
             }
-            stat_to_qid(&stbuf, &qid);
+            err = stat_to_qid(pdu, &stbuf, &qid);
+            if (err < 0) {
+                goto out;
+            }
             v9fs_path_copy(&dpath, &path);
         }
         memcpy(&qids[name_idx], &qid, sizeof(qid));
@@ -1483,7 +1618,10 @@ static void coroutine_fn v9fs_open(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     if (S_ISDIR(stbuf.st_mode)) {
         err = v9fs_co_opendir(pdu, fidp);
         if (err < 0) {
@@ -1593,7 +1731,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
         fidp->flags |= FID_NON_RECLAIMABLE;
     }
     iounit =  get_iounit(pdu, &fidp->path);
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
     if (err < 0) {
         goto out;
@@ -2327,7 +2468,10 @@ static void coroutine_fn v9fs_create(void *opaque)
         }
     }
     iounit = get_iounit(pdu, &fidp->path);
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
     if (err < 0) {
         goto out;
@@ -2384,7 +2528,10 @@ static void coroutine_fn v9fs_symlink(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err =  pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3064,7 +3211,10 @@ static void coroutine_fn v9fs_mknod(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3222,7 +3372,10 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3633,6 +3786,11 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
         goto out;
     }
 
+    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
+    qht_init(&s->qpp_table, qpp_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
+    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+    s->qp_fullpath_next = 1;
+
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
@@ -3646,6 +3804,8 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
+        qp_table_destroy(&s->qpp_table);
+        qp_table_destroy(&s->qpf_table);
         v9fs_path_free(&path);
     }
     return rc;
@@ -3658,6 +3818,8 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
+    qp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 8883761b2c..44112ea97f 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -8,6 +8,7 @@
 #include "fsdev/9p-iov-marshal.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/qht.h"
 
 enum {
     P9_TLERROR = 6,
@@ -235,6 +236,22 @@ struct V9fsFidState
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
+/* QID path full entry, as above */
+typedef struct {
+    dev_t dev;
+    ino_t ino;
+    uint64_t path;
+} QpfEntry;
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -256,6 +273,10 @@ struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
+    struct qht qpp_table;
+    struct qht qpf_table;
+    uint16_t qp_prefix_next;
+    uint64_t qp_fullpath_next;
 };
 
 /* 9p2000.L open flags */
-- 
2.11.0



