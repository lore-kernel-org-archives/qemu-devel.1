Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75FC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578C72053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Ql2Aar1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578C72053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfR4-0007Ib-Jg
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:21:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34253)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<590216e2666653bac21d950aaba98f87d0a53324@lizzy.crudebyte.com>)
	id 1hNfPq-0006mg-OW
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<590216e2666653bac21d950aaba98f87d0a53324@lizzy.crudebyte.com>)
	id 1hNfPo-0002ta-C4
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:20:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<590216e2666653bac21d950aaba98f87d0a53324@lizzy.crudebyte.com>)
	id 1hNfPn-000262-Rf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=lizzy;
	h=Subject:Date:Cc:To:From:References:In-Reply-To:
	Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IbJdVIu8RzDoTvXRe7+GhXID0oPIdnJi/EX/8VEhaeE=;
	b=Ql2Aar1mw/qIXoxvaRQo4gGt3
	dW5I87EGR+tiPB4H7wiUCL4qVYbxlNfMQHsA2D3MLXdDPvDlHM2ADRgIBNs9nvp2WWRIaYUNNe/7d
	zwPR0tkGXMpxwy5tD23qQg2uXe95TFwfUoReg+qU00dAYrAInsT6LQCsIZIfId4lnXDzI47pn0mnc
	Vzja7AXM9szxm6xDqURs9S+HjsCASimB2EstfHmQ3JXahyPSKA3MwYRHNsonZIoA3axxzLEiKoOcm
	tiNv/Xob71rxUtsvPDedkN7OcMoBw1NKRMr5guDVoxik7FfEdEUVTDAYR0wAiyVajY7/dfmvBqNK0
	Sn3e37JLw==;
Message-Id: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1557093245.git.qemu_oss@crudebyte.com>
References: <cover.1557093245.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Sun, 5 May 2019 23:41:05 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v3 5/5] 9p: adds virtfs 'vii' device parameter
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

This patch adds an optional qemu device parameter "vii" (very important
inode[s]), which accepts a colon separated list of pathes relative below
the 9p export root, which shall be given the smallest inode suffix (and
hence largest possible inode namespace on guest) according to the given
order. That way host admins do have a way to fine tune the automatic inode
remapping algorithm of 9pfs.

Example: consider a file server running on guest with 9p export root /vm/fs
on host and the mass storage file system being mounted on host on
/vm/fs/var/shares and further consider some very frequently accessed temp
file system being mounted as /vm/fs/tmp on host, then host admin could give
the mass storage file system the highest inode namespace and the temp file
system the 2nd highest inode namespace with qemu virtfs argument:

    vii=/var/shares:/tmp

The root file system (/vm/fs on host, / on guest) would then hence get the
3rd highest inode namespace on guest automatically (since not mentioned in
vii list).

For completeness I will also send a (6th) patch against libvirt which
allows to conigure this feature via libvirt/virsh xml config instead.

Additionally this patch addresses:

  * Removes unnecessary header includes in 9p.c
    (that I used for debugging).

  * Fixes a compiler error of previous patch in 9p.c if macro
    QPP_TABLE_PERSISTENCY_LIMIT was enabled and latest git master head
    version used.

This patch probably needs some cleanup. But I will wait for your coarse
feedback before doing anything else. For instance the device property that
I added in virtio-9p-device.c is actually not used ATM. My initial
assumption was this to be used by the qemu options visitors automatically
for command line arguments, then I noticed that these properties are rather
intended for passing parameters from guest instead. I am unresolved though
whether this parameter shall be configurable from guest or not, so I have
not finished that yet. Then the user manual changes need to be finished and
obviously you might have a better idea for an argument name than "vii" ;-)

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h         |   1 +
 fsdev/qemu-fsdev-opts.c    |   6 ++
 fsdev/qemu-fsdev.c         |   3 +
 hw/9pfs/9p.c               | 138 +++++++++++++++++++++++++++++++--------------
 hw/9pfs/9p.h               |   6 ++
 hw/9pfs/virtio-9p-device.c |   1 +
 qemu-options.hx            |   5 +-
 vl.c                       |   9 ++-
 8 files changed, 124 insertions(+), 45 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 3fa062b39f..2645faa113 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -77,6 +77,7 @@ typedef struct FsDriverEntry {
     FsThrottle fst;
     mode_t fmode;
     mode_t dmode;
+    char *vii;
 } FsDriverEntry;
 
 struct FsContext {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 7c31ffffaf..5ae02887a5 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -44,6 +44,9 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "vii",
+            .type = QEMU_OPT_STRING,
         },
 
         THROTTLE_OPTS,
@@ -87,6 +90,9 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "vii",
+            .type = QEMU_OPT_STRING,
         },
 
         { /*End of list */ }
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 54cb36a212..29133b4a15 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -34,6 +34,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     const char *fsdev_id = qemu_opts_id(opts);
     const char *fsdriver = qemu_opt_get(opts, "fsdriver");
     const char *writeout = qemu_opt_get(opts, "writeout");
+    const char *vii      = qemu_opt_get(opts, "vii");
     bool ro = qemu_opt_get_bool(opts, "readonly", 0);
 
     if (!fsdev_id) {
@@ -59,6 +60,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 
     fsle = g_malloc0(sizeof(*fsle));
     fsle->fse.fsdev_id = g_strdup(fsdev_id);
+    fsle->fse.vii = g_strdup(vii);
     fsle->fse.ops = FsDrivers[i].ops;
     if (writeout) {
         if (!strcmp(writeout, "immediate")) {
@@ -74,6 +76,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     if (fsle->fse.ops->parse_opts) {
         if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
             g_free(fsle->fse.fsdev_id);
+            g_free(fsle->fse.vii);
             g_free(fsle);
             return -1;
         }
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 003901a1e0..b4c4c66a3b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -30,10 +30,8 @@
 #if defined(__linux__) /* TODO: This should probably go into osdep.h instead */
 # include <linux/limits.h> /* for XATTR_SIZE_MAX */
 #endif
-#include <sys/types.h>
-#include <unistd.h>
-#include <sys/syscall.h>
 #include <math.h>
+#include "qemu/cutils.h"
 
 /*
  * How many bytes may we store to fs per extended attribute value?
@@ -589,6 +587,8 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
 /* Mirrors all bits of a byte. So e.g. binary 10100000 would become 00000101. */
 static inline uint8_t mirror8bit(uint8_t byte) {
     return (byte * 0x0202020202ULL & 0x010884422010ULL) % 1023;
@@ -606,8 +606,6 @@ static inline uint64_t mirror64bit(uint64_t value) {
            ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
 }
 
-#if P9_VARI_LENGTH_INODE_SUFFIXES
-
 /* Parameter k for the Exponential Golomb algorihm to be used.
  *
  * The smaller this value, the smaller the minimum bit count for the Exp.
@@ -770,7 +768,7 @@ static int v9fs_store_qpd_table(V9fsState *s);
  * generating hash values for the purpose of accessing qpp_table in order
  * get consistent behaviour when accessing qpp_table.
  */
-static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
+static int qid_inode_prefix_hash_bits(V9fsState *s, dev_t dev)
 {
     QpdEntry lookup = {
         .dev = dev
@@ -778,14 +776,14 @@ static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
     uint32_t hash = dev;
     VariLenAffix affix;
 
-    val = qht_lookup(&pdu->s->qpd_table, &lookup, hash);
+    val = qht_lookup(&s->qpd_table, &lookup, hash);
     if (!val) {
         val = g_malloc0(sizeof(QpdEntry));
         *val = lookup;
-        affix = affixForIndex(pdu->s->qp_affix_next);
+        affix = affixForIndex(s->qp_affix_next);
         val->prefix_bits = affix.bits;
-        qht_insert(&pdu->s->qpd_table, val, hash, NULL);
-        pdu->s->qp_ndevices++;
+        qht_insert(&s->qpd_table, val, hash, NULL);
+        s->qp_ndevices++;
 
         /*
          * Store qpd_table as extended attribute(s) to file system.
@@ -794,7 +792,7 @@ static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
          * suspend handler.
          */
         #if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
-        v9fs_store_qpd_table(pdu->s);
+        v9fs_store_qpd_table(s);
         #endif
     }
     return val->prefix_bits;
@@ -817,7 +815,7 @@ static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
  * @see qid_path_prefixmap() for details
  *
  */
-static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
+static int qid_path_fullmap(V9fsState *s, const struct stat *stbuf,
                             uint64_t *path)
 {
     QpfEntry lookup = {
@@ -829,10 +827,10 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
     VariLenAffix affix;
 #endif
 
-    val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
+    val = qht_lookup(&s->qpf_table, &lookup, hash);
 
     if (!val) {
-        if (pdu->s->qp_fullpath_next == 0) {
+        if (s->qp_fullpath_next == 0) {
             /* no more files can be mapped :'( */
             return -ENFILE;
         }
@@ -843,15 +841,15 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
         /* new unique inode and device combo */
 #if P9_VARI_LENGTH_INODE_SUFFIXES
         affix = affixForIndex(
-            1ULL << (sizeof(pdu->s->qp_affix_next) * 8)
+            1ULL << (sizeof(s->qp_affix_next) * 8)
         );
-        val->path = (pdu->s->qp_fullpath_next++ << affix.bits) | affix.value;
-        pdu->s->qp_fullpath_next &= ((1ULL << (64 - affix.bits)) - 1);
+        val->path = (s->qp_fullpath_next++ << affix.bits) | affix.value;
+        s->qp_fullpath_next &= ((1ULL << (64 - affix.bits)) - 1);
 #else
-        val->path = pdu->s->qp_fullpath_next++;
-        pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
+        val->path = s->qp_fullpath_next++;
+        s->qp_fullpath_next &= QPATH_INO_MASK;
 #endif
-        qht_insert(&pdu->s->qpf_table, val, hash, NULL);
+        qht_insert(&s->qpf_table, val, hash, NULL);
     }
 
     *path = val->path;
@@ -914,7 +912,7 @@ static void remove_qp_tables_xattrs(FsContext *ctx) {
 # if P9_VARI_LENGTH_INODE_SUFFIXES
 
 /* Used to convert qpd hash table into continuous stream. */
-static void qpd_table_serialize(struct qht *ht, void *p, uint32_t h, void *up)
+static void qpd_table_serialize(void *p, uint32_t h, void *up)
 {
     const QpdEntry *entry = (const QpdEntry*) p;
     QpdSerialize *ser = (QpdSerialize*) up;
@@ -1540,11 +1538,11 @@ static void v9fs_store_qp_tables(V9fsState *s)
  * suffixes instead. See comment on P9_VARI_LENGTH_INODE_SUFFIXES for
  * details.
  */
-static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
+static int qid_path_prefixmap(V9fsState *s, const struct stat *stbuf,
                                 uint64_t *path)
 {
 #if P9_VARI_LENGTH_INODE_SUFFIXES
-    const int ino_hash_bits = qid_inode_prefix_hash_bits(pdu, stbuf->st_dev);
+    const int ino_hash_bits = qid_inode_prefix_hash_bits(s, stbuf->st_dev);
 #endif
     QppEntry lookup = {
         .dev = stbuf->st_dev,
@@ -1556,10 +1554,10 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
     }, *val;
     uint32_t hash = qpp_hash(lookup);
 
-    val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
+    val = qht_lookup(&s->qpp_table, &lookup, hash);
 
     if (!val) {
-        if (pdu->s->qp_affix_next == 0) {
+        if (s->qp_affix_next == 0) {
             /* we ran out of affixes */
             return -ENFILE;
         }
@@ -1569,12 +1567,12 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
 
         /* new unique inode affix and device combo */
 #if P9_VARI_LENGTH_INODE_SUFFIXES
-        val->qp_affix_index = pdu->s->qp_affix_next++;
+        val->qp_affix_index = s->qp_affix_next++;
         val->qp_affix = affixForIndex(val->qp_affix_index);
 #else
-        val->qp_affix = pdu->s->qp_affix_next++;
+        val->qp_affix = s->qp_affix_next++;
 #endif
-        qht_insert(&pdu->s->qpp_table, val, hash, NULL);
+        qht_insert(&s->qpp_table, val, hash, NULL);
 
         /*
          * Store qpp_table as extended attribute(s) to file system.
@@ -1583,7 +1581,7 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
          * suspend handler.
          */
         #if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
-        v9fs_store_qpp_table(pdu->s);
+        v9fs_store_qpp_table(s);
         #endif
     }
 #if P9_VARI_LENGTH_INODE_SUFFIXES
@@ -1595,15 +1593,15 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
     return 0;
 }
 
-static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
+static int stat_to_qid(V9fsState *s, const struct stat *stbuf, V9fsQID *qidp)
 {
     int err;
 
     /* map inode+device to qid path (fast path) */
-    err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+    err = qid_path_prefixmap(s, stbuf, &qidp->path);
     if (err == -ENFILE) {
         /* fast path didn't work, fall back to full map */
-        err = qid_path_fullmap(pdu, stbuf, &qidp->path);
+        err = qid_path_fullmap(s, stbuf, &qidp->path);
     }
     if (err) {
         return err;
@@ -1621,6 +1619,57 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
     return 0;
 }
 
+/** @brief Handle "vii" device config parameter.
+ *
+ * "vii" (very important inode[s]) is a colon separated list of pathes
+ * passed as optional virtfs command line argument "vii" to qemu, which
+ * shall have precedence in their given order when emitting inode nr
+ * remapping suffixes on guest. So the very first vii path will get the
+ * smallest inode nr prefix (i.e. 1 bit) and hence the largest inode
+ * namespace on guest, the next path in the list will get the next higher
+ * inode prefix (i.e. 3 bit), and so on.
+ *
+ * @see qid_path_prefixmap()
+ */
+static void map_important_inodes(FsDriverEntry *fse, V9fsState *s, V9fsPath *path) {
+#if !P9_VARI_LENGTH_INODE_SUFFIXES
+    error_printf("virtfs-9p: ignoring argument vii='%s': virtfs-9p compiled without variable length inode suffixes", fse->vii);
+#else
+    struct stat stbuf;
+    char *buf, *token;
+    V9fsPath vii;
+    V9fsQID qid;
+
+    if (!fse->vii)
+        return; /* no "vii" command line argument passed to qemu */
+
+    v9fs_path_init(&vii);
+
+    buf = g_strdup(fse->vii);
+    while ((token = qemu_strsep(&buf, ":"))) {
+        if (token[0] != '/') {
+            error_printf("virtfs-9p: ignoring vii path '%s': misses mandatory leading slash", token);
+            continue;
+        }
+        /* token+1 : slash must be ripped off to avoid double slash in
+         * in vii and its subsequent assertion fault in lstat() */
+        if (s->ops->name_to_path(&s->ctx, path, token+1, &vii) < 0) {
+            error_printf("virtfs-9p: ignoring vii path '%s': error converting name to path: %s",
+                         token, strerror(errno));
+            continue;
+        }
+        if (s->ops->lstat(&s->ctx, &vii, &stbuf) < 0) {
+            error_printf("virtfs-9p: ignoring vii path '%s': lstat failed", token);
+            goto next;
+        }
+        stat_to_qid(s, &stbuf, &qid);
+    next:
+        v9fs_path_free(&vii);
+    }
+    g_free(buf);
+#endif
+}
+
 static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
                                    V9fsQID *qidp)
 {
@@ -1631,7 +1680,7 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     if (err < 0) {
         return err;
     }
-    err = stat_to_qid(pdu, &stbuf, qidp);
+    err = stat_to_qid(pdu->s, &stbuf, qidp);
     if (err < 0) {
         return err;
     }
@@ -1865,7 +1914,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 
     memset(v9stat, 0, sizeof(*v9stat));
 
-    err = stat_to_qid(pdu, stbuf, &v9stat->qid);
+    err = stat_to_qid(pdu->s, stbuf, &v9stat->qid);
     if (err < 0) {
         return err;
     }
@@ -1951,7 +2000,7 @@ static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
     /* Currently we only support BASIC fields in stat */
     v9lstat->st_result_mask = P9_STATS_BASIC;
 
-    return stat_to_qid(pdu, stbuf, &v9lstat->qid);
+    return stat_to_qid(pdu->s, stbuf, &v9lstat->qid);
 }
 
 static void print_sg(struct iovec *sg, int cnt)
@@ -2416,7 +2465,7 @@ static void coroutine_fn v9fs_walk(void *opaque)
             if (err < 0) {
                 goto out;
             }
-            err = stat_to_qid(pdu, &stbuf, &qid);
+            err = stat_to_qid(pdu->s, &stbuf, &qid);
             if (err < 0) {
                 goto out;
             }
@@ -2521,7 +2570,7 @@ static void coroutine_fn v9fs_open(void *opaque)
     if (err < 0) {
         goto out;
     }
-    err = stat_to_qid(pdu, &stbuf, &qid);
+    err = stat_to_qid(pdu->s, &stbuf, &qid);
     if (err < 0) {
         goto out;
     }
@@ -2634,7 +2683,7 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
         fidp->flags |= FID_NON_RECLAIMABLE;
     }
     iounit =  get_iounit(pdu, &fidp->path);
-    err = stat_to_qid(pdu, &stbuf, &qid);
+    err = stat_to_qid(pdu->s, &stbuf, &qid);
     if (err < 0) {
         goto out;
     }
@@ -3371,7 +3420,7 @@ static void coroutine_fn v9fs_create(void *opaque)
         }
     }
     iounit = get_iounit(pdu, &fidp->path);
-    err = stat_to_qid(pdu, &stbuf, &qid);
+    err = stat_to_qid(pdu->s, &stbuf, &qid);
     if (err < 0) {
         goto out;
     }
@@ -3431,7 +3480,7 @@ static void coroutine_fn v9fs_symlink(void *opaque)
     if (err < 0) {
         goto out;
     }
-    err = stat_to_qid(pdu, &stbuf, &qid);
+    err = stat_to_qid(pdu->s, &stbuf, &qid);
     if (err < 0) {
         goto out;
     }
@@ -4114,7 +4163,7 @@ static void coroutine_fn v9fs_mknod(void *opaque)
     if (err < 0) {
         goto out;
     }
-    err = stat_to_qid(pdu, &stbuf, &qid);
+    err = stat_to_qid(pdu->s, &stbuf, &qid);
     if (err < 0) {
         goto out;
     }
@@ -4275,7 +4324,7 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
     if (err < 0) {
         goto out;
     }
-    err = stat_to_qid(pdu, &stbuf, &qid);
+    err = stat_to_qid(pdu->s, &stbuf, &qid);
     if (err < 0) {
         goto out;
     }
@@ -4701,8 +4750,13 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 #endif
     s->qp_affix_next = 1; /* reserve 0 to detect overflow */
     s->qp_fullpath_next = 1;
+
+    /* handle "very important inodes" */
+    map_important_inodes(fse, s, &path);
+
     /* try to load and restore previous qpd_table and qpp_table */
 #if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+    /*TODO: call will be ignored ATM if virfs "vii" argument was passed as well */
     v9fs_load_qp_tables(s);
 #endif
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 78c29fb916..d78e7eff49 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -168,6 +168,12 @@ typedef struct V9fsConf
     /* tag name for the device */
     char *tag;
     char *fsdev_id;
+    /*
+     * very important inodes: colon separated list of pathes (relative to
+     * export root) which should be preferred for getting a larger inode
+     * namespace on guest
+     */
+    char *viis;
 } V9fsConf;
 
 /* 9p2000.L xattr flags (matches Linux values) */
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 775e8ff766..cdbe157274 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -232,6 +232,7 @@ static const VMStateDescription vmstate_virtio_9p = {
 static Property virtio_9p_properties[] = {
     DEFINE_PROP_STRING("mount_tag", V9fsVirtioState, state.fsconf.tag),
     DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
+    DEFINE_PROP_STRING("vii", V9fsVirtioState, state.fsconf.viis),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..4fd56f367e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1306,12 +1306,13 @@ ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=[mapped-xattr|mapped-file|passthrough|none]\n"
-    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n",
+    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode]\n"
+    "        [,dmode=dmode][,vii=vii-path]\n",
     QEMU_ARCH_ALL)
 
 STEXI
 
-@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
+@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}][,vii=@var{vii-path}]
 @findex -virtfs
 
 The general form of a Virtual File system pass-through options are:
diff --git a/vl.c b/vl.c
index c696ad2a13..55d3f079dd 100644
--- a/vl.c
+++ b/vl.c
@@ -3447,7 +3447,8 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_virtfs: {
                 QemuOpts *fsdev;
                 QemuOpts *device;
-                const char *writeout, *sock_fd, *socket, *path, *security_model;
+                const char *writeout, *sock_fd, *socket, *path, *security_model,
+                           *vii;
 
                 olist = qemu_find_opts("virtfs");
                 if (!olist) {
@@ -3503,6 +3504,10 @@ int main(int argc, char **argv, char **envp)
                 if (sock_fd) {
                     qemu_opt_set(fsdev, "sock_fd", sock_fd, &error_abort);
                 }
+                vii = qemu_opt_get(opts, "vii");
+                if (vii) {
+                    qemu_opt_set(fsdev, "vii", vii, &error_abort);
+                }
 
                 qemu_opt_set_bool(fsdev, "readonly",
                                   qemu_opt_get_bool(opts, "readonly", 0),
@@ -3514,6 +3519,8 @@ int main(int argc, char **argv, char **envp)
                              qemu_opts_id(fsdev), &error_abort);
                 qemu_opt_set(device, "mount_tag",
                              qemu_opt_get(opts, "mount_tag"), &error_abort);
+                qemu_opt_set(device, "vii",
+                             qemu_opt_get(opts, "vii"), &error_abort);
                 break;
             }
             case QEMU_OPTION_virtfs_synth: {
-- 
2.11.0


