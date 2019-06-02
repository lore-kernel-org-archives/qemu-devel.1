Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDBAC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 20:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4AD2793B
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 20:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="mSd9TL1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4AD2793B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXWvz-0002Fe-RC
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 16:18:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1hXWvB-0001iS-5J
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 16:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1hXWv9-00068u-Tn
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 16:17:37 -0400
Received: from smtp48.i.mail.ru ([94.100.177.108]:56354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1hXWv9-00067a-Aq
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 16:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
	bh=JJC3y5FgvvbzIXcCDu3j94Y1erdK3NlWW/tiF8L6Oi4=; 
	b=mSd9TL1M6A38vVBi6nGczgUPdD/PGSyzTgg7SvX7OeefhCJCDWVM9XUrKY81jxCyqfVbfVJnVO4Icla4pBKJtZHy+NAnITdykgNjalzBcSdEZg19Vg9uwTZDPjk/INTb8UgCBYSYf2OmuRV6V9kHvMX55+ge3rkdMT5fwUv5zAA=;
Received: by smtp48.i.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
	id 1hXWv4-0001PM-Jx; Sun, 02 Jun 2019 23:17:31 +0300
To: qemu-devel@nongnu.org
Date: Sun,  2 Jun 2019 23:17:09 +0300
Message-Id: <20190602201709.11901-1-jusual@mail.ru>
X-Mailer: git-send-email 2.17.1
Authentication-Results: smtp48.i.mail.ru; auth=pass smtp.auth=jusual@mail.ru
	smtp.mailfrom=jusual@mail.ru
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31F9672AF9B3B928BC0910B9CD103F8184182AE88D8AAE8D318A3B75102AD07AABE
X-7FA49CB5: 0D63561A33F958A5DF53127363732015EA709D4FA80CC134FCB00143F2C94C828941B15DA834481FA18204E546F3947C25D43C09D2508269F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B6D77D8F98F67F34EA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22497C48477FF724415E3AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE7436E4CC186B5AB2DB3661434B16C20AC93541453170D46FCAAAE862A0553A39223F8577A6DFFEA7C29113EBC45E7010B072AAC739A9836F6EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD9B131C21E5171FED3C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 42ECD68FB001EF95CFF07A00C0DCB66EA366D5AA146F84BACBA5A4425A1ADE1CAED14ECBD12AF47CBCD5BA2C93075E1EC77752E0C033A69E882C431543FD75E20226C39053983FF03453F38A29522196
X-Mras: OK
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 94.100.177.108
Subject: [Qemu-devel] [PATCH] block/linux-aio: Drop unused BlockAIOCB
 submission method
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
From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Julia Suvorova <jusual@mail.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Callback-based laio_submit() and laio_cancel() were left after
rewriting Linux AIO backend to coroutines in hope that they would be
used in other code that could bypass coroutines. They can be safely
removed because they have not been used since that time.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 block/linux-aio.c       | 72 ++++++-----------------------------------
 include/block/raw-aio.h |  3 --
 2 files changed, 10 insertions(+), 65 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index d4b61fb251..27100c2fd1 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -30,7 +30,6 @@
 #define MAX_EVENTS 128
 
 struct qemu_laiocb {
-    BlockAIOCB common;
     Coroutine *co;
     LinuxAioState *ctx;
     struct iocb iocb;
@@ -72,7 +71,7 @@ static inline ssize_t io_event_ret(struct io_event *ev)
 }
 
 /*
- * Completes an AIO request (calls the callback and frees the ACB).
+ * Completes an AIO request.
  */
 static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
 {
@@ -94,18 +93,15 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
     }
 
     laiocb->ret = ret;
-    if (laiocb->co) {
-        /* If the coroutine is already entered it must be in ioq_submit() and
-         * will notice laio->ret has been filled in when it eventually runs
-         * later.  Coroutines cannot be entered recursively so avoid doing
-         * that!
-         */
-        if (!qemu_coroutine_entered(laiocb->co)) {
-            aio_co_wake(laiocb->co);
-        }
-    } else {
-        laiocb->common.cb(laiocb->common.opaque, ret);
-        qemu_aio_unref(laiocb);
+
+    /*
+     * If the coroutine is already entered it must be in ioq_submit() and
+     * will notice laio->ret has been filled in when it eventually runs
+     * later.  Coroutines cannot be entered recursively so avoid doing
+     * that!
+     */
+    if (!qemu_coroutine_entered(laiocb->co)) {
+        aio_co_wake(laiocb->co);
     }
 }
 
@@ -273,30 +269,6 @@ static bool qemu_laio_poll_cb(void *opaque)
     return true;
 }
 
-static void laio_cancel(BlockAIOCB *blockacb)
-{
-    struct qemu_laiocb *laiocb = (struct qemu_laiocb *)blockacb;
-    struct io_event event;
-    int ret;
-
-    if (laiocb->ret != -EINPROGRESS) {
-        return;
-    }
-    ret = io_cancel(laiocb->ctx->ctx, &laiocb->iocb, &event);
-    laiocb->ret = -ECANCELED;
-    if (ret != 0) {
-        /* iocb is not cancelled, cb will be called by the event loop later */
-        return;
-    }
-
-    laiocb->common.cb(laiocb->common.opaque, laiocb->ret);
-}
-
-static const AIOCBInfo laio_aiocb_info = {
-    .aiocb_size         = sizeof(struct qemu_laiocb),
-    .cancel_async       = laio_cancel,
-};
-
 static void ioq_init(LaioQueue *io_q)
 {
     QSIMPLEQ_INIT(&io_q->pending);
@@ -431,30 +403,6 @@ int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
     return laiocb.ret;
 }
 
-BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque, int type)
-{
-    struct qemu_laiocb *laiocb;
-    off_t offset = sector_num * BDRV_SECTOR_SIZE;
-    int ret;
-
-    laiocb = qemu_aio_get(&laio_aiocb_info, bs, cb, opaque);
-    laiocb->nbytes = nb_sectors * BDRV_SECTOR_SIZE;
-    laiocb->ctx = s;
-    laiocb->ret = -EINPROGRESS;
-    laiocb->is_read = (type == QEMU_AIO_READ);
-    laiocb->qiov = qiov;
-
-    ret = laio_do_submit(fd, laiocb, offset, type);
-    if (ret < 0) {
-        qemu_aio_unref(laiocb);
-        return NULL;
-    }
-
-    return &laiocb->common;
-}
-
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context)
 {
     aio_set_event_notifier(old_context, &s->e, false, NULL, NULL);
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index ba223dd1f1..0cb7cc74a2 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -50,9 +50,6 @@ LinuxAioState *laio_init(Error **errp);
 void laio_cleanup(LinuxAioState *s);
 int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
                                 uint64_t offset, QEMUIOVector *qiov, int type);
-BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque, int type);
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context);
 void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
-- 
2.17.1


