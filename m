Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD164C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F96A2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViYLTYa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F96A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZzP-00017u-KH
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZiy-0002el-Tk
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38307
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZit-0002DS-FX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IY1nwyUB3Dxvw7aUEwYfXa/HPrFcprtFEHyyJ2kjRkw=;
 b=ViYLTYa5PkytDpdzxrO8PVA0dzxRhapMGkLNXuWxT6DzlnwXgZEdlHZ6JRXplibk7kbJp7
 NMAqINVK7uhvbjBkA/Vi8hTgEWgamK+6/HqzPyuSOOUjrup0cnlxJI69caASV7bN2GjEe2
 pp3F38AFiGlvZcqaKxYcnIdXUZAoP1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-3rEVrcSnNdOxEwPkNWm58A-1; Fri, 15 May 2020 08:45:50 -0400
X-MC-Unique: 3rEVrcSnNdOxEwPkNWm58A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 433978005AD;
 Fri, 15 May 2020 12:45:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24DF72E166;
 Fri, 15 May 2020 12:45:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/51] block: Rename BdrvChildRole to BdrvChildClass
Date: Fri, 15 May 2020 14:44:45 +0200
Message-Id: <20200515124521.335403-16-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This structure nearly only contains parent callbacks for child state
changes.  It cannot really reflect a child's role, because different
roles may overlap (as we will see when real roles are introduced), and
because parents can have custom callbacks even when the child fulfills a
standard role.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200513110544.176672-4-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h       |   6 +-
 include/block/block_int.h   |  22 +++---
 block.c                     | 142 ++++++++++++++++++------------------
 block/backup-top.c          |   8 +-
 block/blkdebug.c            |   4 +-
 block/blklogwrites.c        |   8 +-
 block/block-backend.c       |   6 +-
 block/commit.c              |   2 +-
 block/copy-on-read.c        |   2 +-
 block/io.c                  |  22 +++---
 block/mirror.c              |   2 +-
 block/quorum.c              |   2 +-
 block/replication.c         |   2 +-
 block/vvfat.c               |   6 +-
 blockjob.c                  |   2 +-
 tests/test-bdrv-drain.c     |  36 ++++-----
 tests/test-bdrv-graph-mod.c |   2 +-
 17 files changed, 141 insertions(+), 133 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8f3eb70df4..bc42e507bb 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -13,7 +13,7 @@
 /* block.c */
 typedef struct BlockDriver BlockDriver;
 typedef struct BdrvChild BdrvChild;
-typedef struct BdrvChildRole BdrvChildRole;
+typedef struct BdrvChildClass BdrvChildClass;
 
 typedef struct BlockDriverInfo {
     /* in bytes, 0 if irrelevant */
@@ -296,7 +296,7 @@ int bdrv_parse_discard_flags(const char *mode, int *flags);
 BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
                            BlockDriverState* parent,
-                           const BdrvChildRole *child_role,
+                           const BdrvChildClass *child_class,
                            bool allow_none, Error **errp);
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
@@ -541,7 +541,7 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role,
+                             const BdrvChildClass *child_class,
                              Error **errp);
 
 bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1c24df53fd..9a78b981e4 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -556,14 +556,14 @@ struct BlockDriver {
      * the parents in @parent_perm and @parent_shared.
      *
      * If @c is NULL, return the permissions for attaching a new child for the
-     * given @role.
+     * given @child_class.
      *
      * If @reopen_queue is non-NULL, don't return the currently needed
      * permissions, but those that will be needed after applying the
      * @reopen_queue.
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildRole *role,
+                             const BdrvChildClass *child_class,
                              BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
@@ -665,7 +665,7 @@ typedef struct BdrvAioNotifier {
     QLIST_ENTRY(BdrvAioNotifier) list;
 } BdrvAioNotifier;
 
-struct BdrvChildRole {
+struct BdrvChildClass {
     /* If true, bdrv_replace_node() doesn't change the node this BdrvChild
      * points to. */
     bool stay_at_node;
@@ -738,14 +738,14 @@ struct BdrvChildRole {
     void (*set_aio_ctx)(BdrvChild *child, AioContext *ctx, GSList **ignore);
 };
 
-extern const BdrvChildRole child_file;
-extern const BdrvChildRole child_format;
-extern const BdrvChildRole child_backing;
+extern const BdrvChildClass child_file;
+extern const BdrvChildClass child_format;
+extern const BdrvChildClass child_backing;
 
 struct BdrvChild {
     BlockDriverState *bs;
     char *name;
-    const BdrvChildRole *role;
+    const BdrvChildClass *klass;
     void *opaque;
 
     /**
@@ -772,7 +772,7 @@ struct BdrvChild {
 
     /*
      * How many times the parent of this child has been drained
-     * (through role->drained_*).
+     * (through klass->drained_*).
      * Usually, this is equal to bs->quiesce_counter (potentially
      * reduced by bdrv_drain_all_count).  It may differ while the
      * child is entering or leaving a drained section.
@@ -1232,7 +1232,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
-                                  const BdrvChildRole *child_role,
+                                  const BdrvChildClass *child_class,
                                   AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp);
@@ -1263,7 +1263,7 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
  * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESIZE to
  * all children */
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
@@ -1273,7 +1273,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
  * requires WRITE | RESIZE for read-write images, always requires
  * CONSISTENT_READ and doesn't share WRITE. */
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
diff --git a/block.c b/block.c
index c6a5c144b7..0ce9b61c97 100644
--- a/block.c
+++ b/block.c
@@ -76,7 +76,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            const char *reference,
                                            QDict *options, int flags,
                                            BlockDriverState *parent,
-                                           const BdrvChildRole *child_role,
+                                           const BdrvChildClass *child_class,
                                            Error **errp);
 
 /* If non-zero, use only whitelisted block drivers */
@@ -1183,7 +1183,7 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
     *child_flags = flags;
 }
 
-const BdrvChildRole child_file = {
+const BdrvChildClass child_file = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_options,
@@ -1211,7 +1211,7 @@ static void bdrv_inherited_fmt_options(int *child_flags, QDict *child_options,
     *child_flags &= ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
 }
 
-const BdrvChildRole child_format = {
+const BdrvChildClass child_format = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_fmt_options,
@@ -1335,7 +1335,7 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
     return ret;
 }
 
-const BdrvChildRole child_backing = {
+const BdrvChildClass child_backing = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
     .attach          = bdrv_backing_attach,
@@ -1953,13 +1953,13 @@ bool bdrv_is_writable(BlockDriverState *bs)
 }
 
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
-                            BdrvChild *c, const BdrvChildRole *role,
+                            BdrvChild *c, const BdrvChildClass *child_class,
                             BlockReopenQueue *reopen_queue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
-    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
+    bs->drv->bdrv_child_perm(bs, c, child_class, reopen_queue,
                              parent_perm, parent_shared,
                              nperm, nshared);
     /* TODO Take force_share from reopen_queue */
@@ -2053,7 +2053,7 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
         uint64_t cur_perm, cur_shared;
         bool child_tighten_restr;
 
-        bdrv_child_perm(bs, c->bs, c, c->role, q,
+        bdrv_child_perm(bs, c->bs, c, c->klass, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret = bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_children,
@@ -2120,7 +2120,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->klass, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -2145,8 +2145,8 @@ void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
 
 static char *bdrv_child_user_desc(BdrvChild *c)
 {
-    if (c->role->get_parent_desc) {
-        return c->role->get_parent_desc(c);
+    if (c->klass->get_parent_desc) {
+        return c->klass->get_parent_desc(c);
     }
 
     return g_strdup("another user");
@@ -2348,14 +2348,14 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp)
     uint64_t perms, shared;
 
     bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
-    bdrv_child_perm(bs, c->bs, c, c->role, NULL, parent_perms, parent_shared,
+    bdrv_child_perm(bs, c->bs, c, c->klass, NULL, parent_perms, parent_shared,
                     &perms, &shared);
 
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
 
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
@@ -2365,21 +2365,21 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
 }
 
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
-    bool backing = (role == &child_backing);
-    assert(role == &child_backing || role == &child_file);
+    bool backing = (child_class == &child_backing);
+    assert(child_class == &child_backing || child_class == &child_file);
 
     if (!backing) {
         int flags = bdrv_reopen_get_flags(reopen_queue, bs);
 
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
-                                  &perm, &shared);
+        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+                                  perm, shared, &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
         if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
@@ -2456,7 +2456,7 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
      * If the new child node is drained but the old one was not, flush
      * all outstanding requests to the old child node.
      */
-    while (drain_saldo > 0 && child->role->drained_begin) {
+    while (drain_saldo > 0 && child->klass->drained_begin) {
         bdrv_parent_drained_begin_single(child, true);
         drain_saldo--;
     }
@@ -2465,8 +2465,8 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
         /* Detach first so that the recursive drain sections coming from @child
          * are already gone and we only end the drain sections that came from
          * elsewhere. */
-        if (child->role->detach) {
-            child->role->detach(child);
+        if (child->klass->detach) {
+            child->klass->detach(child);
         }
         QLIST_REMOVE(child, next_parent);
     }
@@ -2488,8 +2488,8 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
         /* Attach only after starting new drained sections, so that recursive
          * drain sections coming from @child don't get an extra .drained_begin
          * callback. */
-        if (child->role->attach) {
-            child->role->attach(child);
+        if (child->klass->attach) {
+            child->klass->attach(child);
         }
     }
 
@@ -2497,7 +2497,7 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
      * If the old child node was drained but the new one is not, allow
      * requests to come in only after the new node has been attached.
      */
-    while (drain_saldo < 0 && child->role->drained_end) {
+    while (drain_saldo < 0 && child->klass->drained_end) {
         bdrv_parent_drained_end_single(child);
         drain_saldo++;
     }
@@ -2570,7 +2570,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
  */
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
-                                  const BdrvChildRole *child_role,
+                                  const BdrvChildClass *child_class,
                                   AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp)
@@ -2591,7 +2591,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     *child = (BdrvChild) {
         .bs             = NULL,
         .name           = g_strdup(child_name),
-        .role           = child_role,
+        .klass          = child_class,
         .perm           = perm,
         .shared_perm    = shared_perm,
         .opaque         = opaque,
@@ -2602,15 +2602,15 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
      * try moving the parent into the AioContext of child_bs instead. */
     if (bdrv_get_aio_context(child_bs) != ctx) {
         ret = bdrv_try_set_aio_context(child_bs, ctx, &local_err);
-        if (ret < 0 && child_role->can_set_aio_ctx) {
+        if (ret < 0 && child_class->can_set_aio_ctx) {
             GSList *ignore = g_slist_prepend(NULL, child);
             ctx = bdrv_get_aio_context(child_bs);
-            if (child_role->can_set_aio_ctx(child, ctx, &ignore, NULL)) {
+            if (child_class->can_set_aio_ctx(child, ctx, &ignore, NULL)) {
                 error_free(local_err);
                 ret = 0;
                 g_slist_free(ignore);
                 ignore = g_slist_prepend(NULL, child);
-                child_role->set_aio_ctx(child, ctx, &ignore);
+                child_class->set_aio_ctx(child, ctx, &ignore);
             }
             g_slist_free(ignore);
         }
@@ -2643,7 +2643,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role,
+                             const BdrvChildClass *child_class,
                              Error **errp)
 {
     BdrvChild *child;
@@ -2652,10 +2652,10 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
 
     assert(parent_bs->drv);
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, NULL,
                     perm, shared_perm, &perm, &shared_perm);
 
-    child = bdrv_root_attach_child(child_bs, child_name, child_role,
+    child = bdrv_root_attach_child(child_bs, child_name, child_class,
                                    bdrv_get_aio_context(parent_bs),
                                    perm, shared_perm, parent_bs, errp);
     if (child == NULL) {
@@ -2728,8 +2728,8 @@ static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
 {
     BdrvChild *c;
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->change_media) {
-            c->role->change_media(c, load);
+        if (c->klass->change_media) {
+            c->klass->change_media(c, load);
         }
     }
 }
@@ -2905,7 +2905,7 @@ free_exit:
 
 static BlockDriverState *
 bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
-                   BlockDriverState *parent, const BdrvChildRole *child_role,
+                   BlockDriverState *parent, const BdrvChildClass *child_class,
                    bool allow_none, Error **errp)
 {
     BlockDriverState *bs = NULL;
@@ -2913,7 +2913,7 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
     char *bdref_key_dot;
     const char *reference;
 
-    assert(child_role != NULL);
+    assert(child_class != NULL);
 
     bdref_key_dot = g_strdup_printf("%s.", bdref_key);
     qdict_extract_subqdict(options, &image_options, bdref_key_dot);
@@ -2937,7 +2937,7 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
     }
 
     bs = bdrv_open_inherit(filename, reference, image_options, 0,
-                           parent, child_role, errp);
+                           parent, child_class, errp);
     if (!bs) {
         goto done;
     }
@@ -2964,22 +2964,24 @@ done:
 BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
                            BlockDriverState *parent,
-                           const BdrvChildRole *child_role,
+                           const BdrvChildClass *child_class,
                            bool allow_none, Error **errp)
 {
     BlockDriverState *bs;
 
-    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_role,
+    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_class,
                             allow_none, errp);
     if (bs == NULL) {
         return NULL;
     }
 
-    return bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
+    return bdrv_attach_child(parent, bs, bdref_key, child_class, errp);
 }
 
-/* TODO Future callers may need to specify parent/child_role in order for
- * option inheritance to work. Existing callers use it for the root node. */
+/*
+ * TODO Future callers may need to specify parent/child_class in order for
+ * option inheritance to work. Existing callers use it for the root node.
+ */
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 {
     BlockDriverState *bs = NULL;
@@ -3107,7 +3109,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            const char *reference,
                                            QDict *options, int flags,
                                            BlockDriverState *parent,
-                                           const BdrvChildRole *child_role,
+                                           const BdrvChildClass *child_class,
                                            Error **errp)
 {
     int ret;
@@ -3121,8 +3123,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     QDict *snapshot_options = NULL;
     int snapshot_flags = 0;
 
-    assert(!child_role || !flags);
-    assert(!child_role == !parent);
+    assert(!child_class || !flags);
+    assert(!child_class == !parent);
 
     if (reference) {
         bool options_non_empty = options ? qdict_size(options) : false;
@@ -3158,10 +3160,10 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 
     bs->explicit_options = qdict_clone_shallow(options);
 
-    if (child_role) {
+    if (child_class) {
         bs->inherits_from = parent;
-        child_role->inherit_options(&flags, options,
-                                    parent->open_flags, parent->options);
+        child_class->inherit_options(&flags, options,
+                                     parent->open_flags, parent->options);
     }
 
     ret = bdrv_fill_options(&options, filename, &flags, &local_err);
@@ -3472,7 +3474,7 @@ static bool bdrv_recurse_has_child(BlockDriverState *bs,
 static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                                  BlockDriverState *bs,
                                                  QDict *options,
-                                                 const BdrvChildRole *role,
+                                                 const BdrvChildClass *klass,
                                                  QDict *parent_options,
                                                  int parent_flags,
                                                  bool keep_old_opts)
@@ -3528,7 +3530,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     /* Inherit from parent node */
     if (parent_options) {
         flags = 0;
-        role->inherit_options(&flags, options, parent_flags, parent_options);
+        klass->inherit_options(&flags, options, parent_flags, parent_options);
     } else {
         flags = bdrv_get_flags(bs);
     }
@@ -3619,7 +3621,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         }
 
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
-                                child->role, options, flags, child_keep_old);
+                                child->klass, options, flags, child_keep_old);
     }
 
     return bs_queue;
@@ -3799,7 +3801,7 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, BlockDriverState *bs,
         } else {
             uint64_t nperm, nshared;
 
-            bdrv_child_perm(parent->state.bs, bs, c, c->role, q,
+            bdrv_child_perm(parent->state.bs, bs, c, c->klass, q,
                             parent->state.perm, parent->state.shared_perm,
                             &nperm, &nshared);
 
@@ -4305,7 +4307,7 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     GHashTable *found;
     bool ret;
 
-    if (c->role->stay_at_node) {
+    if (c->klass->stay_at_node) {
         return false;
     }
 
@@ -4776,9 +4778,9 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         }
 
         /* If so, update the backing file path in the image file */
-        if (c->role->update_filename) {
-            ret = c->role->update_filename(c, base, backing_file_str,
-                                           &local_err);
+        if (c->klass->update_filename) {
+            ret = c->klass->update_filename(c, base, backing_file_str,
+                                            &local_err);
             if (ret < 0) {
                 bdrv_abort_perm_update(base);
                 error_report_err(local_err);
@@ -5226,8 +5228,8 @@ const char *bdrv_get_parent_name(const BlockDriverState *bs)
 
     /* If multiple parents have a name, just pick the first one. */
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->get_name) {
-            name = c->role->get_name(c);
+        if (c->klass->get_name) {
+            name = c->klass->get_name(c);
             if (name && *name) {
                 return name;
             }
@@ -5586,8 +5588,8 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     }
 
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-        if (parent->role->activate) {
-            parent->role->activate(parent, &local_err);
+        if (parent->klass->activate) {
+            parent->klass->activate(parent, &local_err);
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
@@ -5655,7 +5657,7 @@ static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
     BdrvChild *parent;
 
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-        if (parent->role->parent_is_bds) {
+        if (parent->klass->parent_is_bds) {
             BlockDriverState *parent_bs = parent->opaque;
             if (!only_active || !(parent_bs->open_flags & BDRV_O_INACTIVE)) {
                 return true;
@@ -5694,8 +5696,8 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs)
     }
 
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-        if (parent->role->inactivate) {
-            ret = parent->role->inactivate(parent);
+        if (parent->klass->inactivate) {
+            ret = parent->klass->inactivate(parent);
             if (ret < 0) {
                 return ret;
             }
@@ -6195,9 +6197,9 @@ void bdrv_set_aio_context_ignore(BlockDriverState *bs,
         if (g_slist_find(*ignore, child)) {
             continue;
         }
-        assert(child->role->set_aio_ctx);
+        assert(child->klass->set_aio_ctx);
         *ignore = g_slist_prepend(*ignore, child);
-        child->role->set_aio_ctx(child, new_context, ignore);
+        child->klass->set_aio_ctx(child, new_context, ignore);
     }
 
     bdrv_detach_aio_context(bs);
@@ -6237,15 +6239,17 @@ static bool bdrv_parent_can_set_aio_context(BdrvChild *c, AioContext *ctx,
     }
     *ignore = g_slist_prepend(*ignore, c);
 
-    /* A BdrvChildRole that doesn't handle AioContext changes cannot
-     * tolerate any AioContext changes */
-    if (!c->role->can_set_aio_ctx) {
+    /*
+     * A BdrvChildClass that doesn't handle AioContext changes cannot
+     * tolerate any AioContext changes
+     */
+    if (!c->klass->can_set_aio_ctx) {
         char *user = bdrv_child_user_desc(c);
         error_setg(errp, "Changing iothreads is not supported by %s", user);
         g_free(user);
         return false;
     }
-    if (!c->role->can_set_aio_ctx(c, ctx, ignore, errp)) {
+    if (!c->klass->can_set_aio_ctx(c, ctx, ignore, errp)) {
         assert(!errp || *errp);
         return false;
     }
@@ -6631,7 +6635,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         drv->bdrv_gather_child_options(bs, opts, backing_overridden);
     } else {
         QLIST_FOREACH(child, &bs->children, next) {
-            if (child->role == &child_backing && !backing_overridden) {
+            if (child->klass == &child_backing && !backing_overridden) {
                 /* We can skip the backing BDS if it has not been overridden */
                 continue;
             }
diff --git a/block/backup-top.c b/block/backup-top.c
index 79b268e6dc..282845a410 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -122,7 +122,7 @@ static void backup_top_refresh_filename(BlockDriverState *bs)
 }
 
 static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                  const BdrvChildRole *role,
+                                  const BdrvChildClass *child_class,
                                   BlockReopenQueue *reopen_queue,
                                   uint64_t perm, uint64_t shared,
                                   uint64_t *nperm, uint64_t *nshared)
@@ -142,7 +142,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
         return;
     }
 
-    if (role == &child_file) {
+    if (child_class == &child_file) {
         /*
          * Target child
          *
@@ -155,8 +155,8 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
         *nperm = BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
-                                  nperm, nshared);
+        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+                                  perm, shared, nperm, nshared);
 
         if (perm & BLK_PERM_WRITE) {
             *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index af44aa973f..f369d54ee4 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -993,14 +993,14 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
 }
 
 static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                const BdrvChildRole *role,
+                                const BdrvChildClass *child_class,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
                                 uint64_t *nperm, uint64_t *nshared)
 {
     BDRVBlkdebugState *s = bs->opaque;
 
-    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
+    bdrv_filter_default_perms(bs, c, child_class, reopen_queue, perm, shared,
                               nperm, nshared);
 
     *nperm |= s->take_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 04d8b33607..f3b3259d8d 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -282,7 +282,7 @@ static int64_t blk_log_writes_getlength(BlockDriverState *bs)
 }
 
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                      const BdrvChildRole *role,
+                                      const BdrvChildClass *child_class,
                                       BlockReopenQueue *ro_q,
                                       uint64_t perm, uint64_t shrd,
                                       uint64_t *nperm, uint64_t *nshrd)
@@ -294,9 +294,11 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
     }
 
     if (!strcmp(c->name, "log")) {
-        bdrv_format_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
+        bdrv_format_default_perms(bs, c, child_class, ro_q, perm, shrd, nperm,
+                                  nshrd);
     } else {
-        bdrv_filter_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
+        bdrv_filter_default_perms(bs, c, child_class, ro_q, perm, shrd, nperm,
+                                  nshrd);
     }
 }
 
diff --git a/block/block-backend.c b/block/block-backend.c
index 47bd56244d..c0af79147a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -297,7 +297,7 @@ static void blk_root_detach(BdrvChild *child)
     }
 }
 
-static const BdrvChildRole child_root = {
+static const BdrvChildClass child_root = {
     .inherit_options    = blk_root_inherit_options,
 
     .change_media       = blk_root_change_media,
@@ -716,7 +716,7 @@ static BlockBackend *bdrv_first_blk(BlockDriverState *bs)
 {
     BdrvChild *child;
     QLIST_FOREACH(child, &bs->parents, next_parent) {
-        if (child->role == &child_root) {
+        if (child->klass == &child_root) {
             return child->opaque;
         }
     }
@@ -740,7 +740,7 @@ bool bdrv_is_root_node(BlockDriverState *bs)
     BdrvChild *c;
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role != &child_root) {
+        if (c->klass != &child_root) {
             return false;
         }
     }
diff --git a/block/commit.c b/block/commit.c
index b0a8a793cd..834eeae412 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -223,7 +223,7 @@ static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 }
 
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildRole *role,
+                                       const BdrvChildClass *child_class,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 242d3ff055..7504ca6ffc 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -51,7 +51,7 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
 #define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
 
 static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
-                           const BdrvChildRole *role,
+                           const BdrvChildClass *child_class,
                            BlockReopenQueue *reopen_queue,
                            uint64_t perm, uint64_t shared,
                            uint64_t *nperm, uint64_t *nshared)
diff --git a/block/io.c b/block/io.c
index 7d30e61edc..121ce17a49 100644
--- a/block/io.c
+++ b/block/io.c
@@ -50,7 +50,7 @@ static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
     BdrvChild *c, *next;
 
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c == ignore || (ignore_bds_parents && c->role->parent_is_bds)) {
+        if (c == ignore || (ignore_bds_parents && c->klass->parent_is_bds)) {
             continue;
         }
         bdrv_parent_drained_begin_single(c, false);
@@ -62,8 +62,8 @@ static void bdrv_parent_drained_end_single_no_poll(BdrvChild *c,
 {
     assert(c->parent_quiesce_counter > 0);
     c->parent_quiesce_counter--;
-    if (c->role->drained_end) {
-        c->role->drained_end(c, drained_end_counter);
+    if (c->klass->drained_end) {
+        c->klass->drained_end(c, drained_end_counter);
     }
 }
 
@@ -81,7 +81,7 @@ static void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
     BdrvChild *c;
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c == ignore || (ignore_bds_parents && c->role->parent_is_bds)) {
+        if (c == ignore || (ignore_bds_parents && c->klass->parent_is_bds)) {
             continue;
         }
         bdrv_parent_drained_end_single_no_poll(c, drained_end_counter);
@@ -90,8 +90,8 @@ static void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
 
 static bool bdrv_parent_drained_poll_single(BdrvChild *c)
 {
-    if (c->role->drained_poll) {
-        return c->role->drained_poll(c);
+    if (c->klass->drained_poll) {
+        return c->klass->drained_poll(c);
     }
     return false;
 }
@@ -103,7 +103,7 @@ static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
     bool busy = false;
 
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c == ignore || (ignore_bds_parents && c->role->parent_is_bds)) {
+        if (c == ignore || (ignore_bds_parents && c->klass->parent_is_bds)) {
             continue;
         }
         busy |= bdrv_parent_drained_poll_single(c);
@@ -115,8 +115,8 @@ static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
 void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll)
 {
     c->parent_quiesce_counter++;
-    if (c->role->drained_begin) {
-        c->role->drained_begin(c);
+    if (c->klass->drained_begin) {
+        c->klass->drained_begin(c);
     }
     if (poll) {
         BDRV_POLL_WHILE(c->bs, bdrv_parent_drained_poll_single(c));
@@ -3326,8 +3326,8 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
 {
     BdrvChild *c;
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->resize) {
-            c->role->resize(c);
+        if (c->klass->resize) {
+            c->klass->resize(c);
         }
     }
 }
diff --git a/block/mirror.c b/block/mirror.c
index 55e992670a..d6598463d5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1492,7 +1492,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 }
 
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildRole *role,
+                                       const BdrvChildClass *child_class,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56bd93..a0824c300d 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1151,7 +1151,7 @@ static char *quorum_dirname(BlockDriverState *bs, Error **errp)
 }
 
 static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
-                              const BdrvChildRole *role,
+                              const BdrvChildClass *child_class,
                               BlockReopenQueue *reopen_queue,
                               uint64_t perm, uint64_t shared,
                               uint64_t *nperm, uint64_t *nshared)
diff --git a/block/replication.c b/block/replication.c
index 9a9f36e524..af428c5b66 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -163,7 +163,7 @@ static void replication_close(BlockDriverState *bs)
 }
 
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                   const BdrvChildRole *role,
+                                   const BdrvChildClass *child_class,
                                    BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
                                    uint64_t *nperm, uint64_t *nshared)
diff --git a/block/vvfat.c b/block/vvfat.c
index 34c121c07a..f845d9b485 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3136,7 +3136,7 @@ static void vvfat_qcow_options(int *child_flags, QDict *child_options,
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
 }
 
-static const BdrvChildRole child_vvfat_qcow = {
+static const BdrvChildClass child_vvfat_qcow = {
     .parent_is_bds      = true,
     .inherit_options    = vvfat_qcow_options,
 };
@@ -3210,14 +3210,14 @@ err:
 }
 
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildRole *role,
+                             const BdrvChildClass *child_class,
                              BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
                              uint64_t *nperm, uint64_t *nshared)
 {
     BDRVVVFATState *s = bs->opaque;
 
-    assert(c == s->qcow || role == &child_backing);
+    assert(c == s->qcow || child_class == &child_backing);
 
     if (c == s->qcow) {
         /* This is a private node, nobody should try to attach to it */
diff --git a/blockjob.c b/blockjob.c
index 2affa1844d..be38c8c550 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -163,7 +163,7 @@ static void child_job_set_aio_ctx(BdrvChild *c, AioContext *ctx,
     job->job.aio_context = ctx;
 }
 
-static const BdrvChildRole child_job = {
+static const BdrvChildClass child_job = {
     .get_parent_desc    = child_job_get_parent_desc,
     .drained_begin      = child_job_drained_begin,
     .drained_poll       = child_job_drained_poll,
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fa0e6a648b..9d683a6c11 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -86,18 +86,20 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
 }
 
 static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                 const BdrvChildRole *role,
+                                 const BdrvChildClass *child_class,
                                  BlockReopenQueue *reopen_queue,
                                  uint64_t perm, uint64_t shared,
                                  uint64_t *nperm, uint64_t *nshared)
 {
-    /* bdrv_format_default_perms() accepts only these two, so disguise
-     * detach_by_driver_cb_role as one of them. */
-    if (role != &child_file && role != &child_backing) {
-        role = &child_file;
+    /*
+     * bdrv_format_default_perms() accepts only these two, so disguise
+     * detach_by_driver_cb_parent as one of them.
+     */
+    if (child_class != &child_file && child_class != &child_backing) {
+        child_class = &child_file;
     }
 
-    bdrv_format_default_perms(bs, c, role, reopen_queue, perm, shared,
+    bdrv_format_default_perms(bs, c, child_class, reopen_queue, perm, shared,
                               nperm, nshared);
 }
 
@@ -1332,7 +1334,7 @@ static void detach_by_driver_cb_drained_begin(BdrvChild *child)
     child_file.drained_begin(child);
 }
 
-static BdrvChildRole detach_by_driver_cb_role;
+static BdrvChildClass detach_by_driver_cb_class;
 
 /*
  * Initial graph:
@@ -1349,7 +1351,7 @@ static BdrvChildRole detach_by_driver_cb_role;
  *
  * by_parent_cb == false: Test that bdrv_drain_invoke() doesn't poll
  *
- *     PA's BdrvChildRole has a .drained_begin callback that schedules a BH
+ *     PA's BdrvChildClass has a .drained_begin callback that schedules a BH
  *     that does the same graph change. If bdrv_drain_invoke() calls it, the
  *     state is messed up, but if it is only polled in the single
  *     BDRV_POLL_WHILE() at the end of the drain, this should work fine.
@@ -1364,8 +1366,8 @@ static void test_detach_indirect(bool by_parent_cb)
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
     if (!by_parent_cb) {
-        detach_by_driver_cb_role = child_file;
-        detach_by_driver_cb_role.drained_begin =
+        detach_by_driver_cb_class = child_file;
+        detach_by_driver_cb_class.drained_begin =
             detach_by_driver_cb_drained_begin;
     }
 
@@ -1399,7 +1401,7 @@ static void test_detach_indirect(bool by_parent_cb)
 
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
-                      by_parent_cb ? &child_file : &detach_by_driver_cb_role,
+                      by_parent_cb ? &child_file : &detach_by_driver_cb_class,
                       &error_abort);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
@@ -1735,7 +1737,7 @@ static int drop_intermediate_poll_update_filename(BdrvChild *child,
 /**
  * Test a poll in the midst of bdrv_drop_intermediate().
  *
- * bdrv_drop_intermediate() calls BdrvChildRole.update_filename(),
+ * bdrv_drop_intermediate() calls BdrvChildClass.update_filename(),
  * which can yield or poll.  This may lead to graph changes, unless
  * the whole subtree in question is drained.
  *
@@ -1772,7 +1774,7 @@ static int drop_intermediate_poll_update_filename(BdrvChild *child,
  *
  * The solution is for bdrv_drop_intermediate() to drain top's
  * subtree.  This prevents graph changes from happening just because
- * BdrvChildRole.update_filename() yields or polls.  Thus, the block
+ * BdrvChildClass.update_filename() yields or polls.  Thus, the block
  * job is paused during that drained section and must finish before or
  * after.
  *
@@ -1780,7 +1782,7 @@ static int drop_intermediate_poll_update_filename(BdrvChild *child,
  */
 static void test_drop_intermediate_poll(void)
 {
-    static BdrvChildRole chain_child_role;
+    static BdrvChildClass chain_child_class;
     BlockDriverState *chain[3];
     TestSimpleBlockJob *job;
     BlockDriverState *job_node;
@@ -1788,8 +1790,8 @@ static void test_drop_intermediate_poll(void)
     int i;
     int ret;
 
-    chain_child_role = child_backing;
-    chain_child_role.update_filename = drop_intermediate_poll_update_filename;
+    chain_child_class = child_backing;
+    chain_child_class.update_filename = drop_intermediate_poll_update_filename;
 
     for (i = 0; i < 3; i++) {
         char name[32];
@@ -1810,7 +1812,7 @@ static void test_drop_intermediate_poll(void)
         if (i) {
             /* Takes the reference to chain[i - 1] */
             chain[i]->backing = bdrv_attach_child(chain[i], chain[i - 1],
-                                                  "chain", &chain_child_role,
+                                                  "chain", &chain_child_class,
                                                   &error_abort);
         }
     }
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index a007754d9e..fef42cb294 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -30,7 +30,7 @@ static BlockDriver bdrv_pass_through = {
 };
 
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
-                                         const BdrvChildRole *role,
+                                         const BdrvChildClass *child_class,
                                          BlockReopenQueue *reopen_queue,
                                          uint64_t perm, uint64_t shared,
                                          uint64_t *nperm, uint64_t *nshared)
-- 
2.25.4


