Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62649C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6032173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuBl5Uf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifReZ-0007H5-Fh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV0-00056W-DR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUy-00017h-Mf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUy-00017Q-IS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0xAdjq2e+a/cILJ9BkLoKQQ2JHkI7xsE4C186Truls=;
 b=BuBl5Uf4BrbTmgKSLwA3J1Ex4zjAK8DrteBKlSx/IgSLQueR5E9DT4ZPXBVOfEU4zsBBxK
 hSNsSzZzZIn6nsSSEbEvafKJdIXKSBJL4CFXfRaxGDoyYf1onjtZI7l5UF4CQ039QTNyQs
 umQ9xL80dFt4K7l7HJj1sNMuIIUDzQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-xda751tJPZiVWZQ02BVwFg-1; Thu, 12 Dec 2019 11:39:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5B07800EB5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C986F60BE1;
 Thu, 12 Dec 2019 16:39:26 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 009/104] virtiofsd: remove unused notify reply support
Date: Thu, 12 Dec 2019 16:37:29 +0000
Message-Id: <20191212163904.159893-10-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xda751tJPZiVWZQ02BVwFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Notify reply support is unused by virtiofsd.  The code would need to be
updated to validate input buffer sizes.  Remove this unused code since
changes to it are untestable.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 147 +-------------------------------
 tools/virtiofsd/fuse_lowlevel.h |  47 ----------
 2 files changed, 1 insertion(+), 193 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 20037eef67..0d7b2c3dc9 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -32,12 +32,6 @@
 #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
-#define container_of(ptr, type, member)                    \
-    ({                                                     \
-        const typeof(((type *)0)->member) *__mptr =3D (ptr); \
-        (type *)((char *)__mptr - offsetof(type, member)); \
-    })
-
 struct fuse_pollhandle {
     uint64_t kh;
     struct fuse_session *se;
@@ -1864,52 +1858,6 @@ static void do_destroy(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
     send_reply_ok(req, NULL, 0);
 }
=20
-static void list_del_nreq(struct fuse_notify_req *nreq)
-{
-    struct fuse_notify_req *prev =3D nreq->prev;
-    struct fuse_notify_req *next =3D nreq->next;
-    prev->next =3D next;
-    next->prev =3D prev;
-}
-
-static void list_add_nreq(struct fuse_notify_req *nreq,
-                          struct fuse_notify_req *next)
-{
-    struct fuse_notify_req *prev =3D next->prev;
-    nreq->next =3D next;
-    nreq->prev =3D prev;
-    prev->next =3D nreq;
-    next->prev =3D nreq;
-}
-
-static void list_init_nreq(struct fuse_notify_req *nreq)
-{
-    nreq->next =3D nreq;
-    nreq->prev =3D nreq;
-}
-
-static void do_notify_reply(fuse_req_t req, fuse_ino_t nodeid,
-                            const void *inarg, const struct fuse_buf *buf)
-{
-    struct fuse_session *se =3D req->se;
-    struct fuse_notify_req *nreq;
-    struct fuse_notify_req *head;
-
-    pthread_mutex_lock(&se->lock);
-    head =3D &se->notify_list;
-    for (nreq =3D head->next; nreq !=3D head; nreq =3D nreq->next) {
-        if (nreq->unique =3D=3D req->unique) {
-            list_del_nreq(nreq);
-            break;
-        }
-    }
-    pthread_mutex_unlock(&se->lock);
-
-    if (nreq !=3D head) {
-        nreq->reply(nreq, req, nodeid, inarg, buf);
-    }
-}
-
 static int send_notify_iov(struct fuse_session *se, int notify_code,
                            struct iovec *iov, int count)
 {
@@ -2061,95 +2009,6 @@ int fuse_lowlevel_notify_store(struct fuse_session *=
se, fuse_ino_t ino,
     return res;
 }
=20
-struct fuse_retrieve_req {
-    struct fuse_notify_req nreq;
-    void *cookie;
-};
-
-static void fuse_ll_retrieve_reply(struct fuse_notify_req *nreq, fuse_req_=
t req,
-                                   fuse_ino_t ino, const void *inarg,
-                                   const struct fuse_buf *ibuf)
-{
-    struct fuse_session *se =3D req->se;
-    struct fuse_retrieve_req *rreq =3D
-        container_of(nreq, struct fuse_retrieve_req, nreq);
-    const struct fuse_notify_retrieve_in *arg =3D inarg;
-    struct fuse_bufvec bufv =3D {
-        .buf[0] =3D *ibuf,
-        .count =3D 1,
-    };
-
-    if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
-        bufv.buf[0].mem =3D PARAM(arg);
-    }
-
-    bufv.buf[0].size -=3D
-        sizeof(struct fuse_in_header) + sizeof(struct fuse_notify_retrieve=
_in);
-
-    if (bufv.buf[0].size < arg->size) {
-        fuse_log(FUSE_LOG_ERR, "fuse: retrieve reply: buffer size too smal=
l\n");
-        fuse_reply_none(req);
-        goto out;
-    }
-    bufv.buf[0].size =3D arg->size;
-
-    if (se->op.retrieve_reply) {
-        se->op.retrieve_reply(req, rreq->cookie, ino, arg->offset, &bufv);
-    } else {
-        fuse_reply_none(req);
-    }
-out:
-    free(rreq);
-}
-
-int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
-                                  size_t size, off_t offset, void *cookie)
-{
-    struct fuse_notify_retrieve_out outarg;
-    struct iovec iov[2];
-    struct fuse_retrieve_req *rreq;
-    int err;
-
-    if (!se) {
-        return -EINVAL;
-    }
-
-    if (se->conn.proto_major < 6 || se->conn.proto_minor < 15) {
-        return -ENOSYS;
-    }
-
-    rreq =3D malloc(sizeof(*rreq));
-    if (rreq =3D=3D NULL) {
-        return -ENOMEM;
-    }
-
-    pthread_mutex_lock(&se->lock);
-    rreq->cookie =3D cookie;
-    rreq->nreq.unique =3D se->notify_ctr++;
-    rreq->nreq.reply =3D fuse_ll_retrieve_reply;
-    list_add_nreq(&rreq->nreq, &se->notify_list);
-    pthread_mutex_unlock(&se->lock);
-
-    outarg.notify_unique =3D rreq->nreq.unique;
-    outarg.nodeid =3D ino;
-    outarg.offset =3D offset;
-    outarg.size =3D size;
-    outarg.padding =3D 0;
-
-    iov[1].iov_base =3D &outarg;
-    iov[1].iov_len =3D sizeof(outarg);
-
-    err =3D send_notify_iov(se, FUSE_NOTIFY_RETRIEVE, iov, 2);
-    if (err) {
-        pthread_mutex_lock(&se->lock);
-        list_del_nreq(&rreq->nreq);
-        pthread_mutex_unlock(&se->lock);
-        free(rreq);
-    }
-
-    return err;
-}
-
 void *fuse_req_userdata(fuse_req_t req)
 {
     return req->se->userdata;
@@ -2228,7 +2087,7 @@ static struct {
     [FUSE_POLL] =3D { do_poll, "POLL" },
     [FUSE_FALLOCATE] =3D { do_fallocate, "FALLOCATE" },
     [FUSE_DESTROY] =3D { do_destroy, "DESTROY" },
-    [FUSE_NOTIFY_REPLY] =3D { (void *)1, "NOTIFY_REPLY" },
+    [FUSE_NOTIFY_REPLY] =3D { NULL, "NOTIFY_REPLY" },
     [FUSE_BATCH_FORGET] =3D { do_batch_forget, "BATCH_FORGET" },
     [FUSE_READDIRPLUS] =3D { do_readdirplus, "READDIRPLUS" },
     [FUSE_RENAME2] =3D { do_rename2, "RENAME2" },
@@ -2336,8 +2195,6 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
     inarg =3D (void *)&in[1];
     if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf) {
         do_write_buf(req, in->nodeid, inarg, buf);
-    } else if (in->opcode =3D=3D FUSE_NOTIFY_REPLY) {
-        do_notify_reply(req, in->nodeid, inarg, buf);
     } else {
         fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
     }
@@ -2461,8 +2318,6 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
=20
     list_init_req(&se->list);
     list_init_req(&se->interrupts);
-    list_init_nreq(&se->notify_list);
-    se->notify_ctr =3D 1;
     fuse_mutex_init(&se->lock);
=20
     memcpy(&se->op, op, op_size);
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 17899e012a..79929e5541 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1084,21 +1084,6 @@ struct fuse_lowlevel_ops {
     void (*write_buf)(fuse_req_t req, fuse_ino_t ino, struct fuse_bufvec *=
bufv,
                       off_t off, struct fuse_file_info *fi);
=20
-    /**
-     * Callback function for the retrieve request
-     *
-     * Valid replies:
-     *  fuse_reply_none
-     *
-     * @param req request handle
-     * @param cookie user data supplied to fuse_lowlevel_notify_retrieve()
-     * @param ino the inode number supplied to fuse_lowlevel_notify_retrie=
ve()
-     * @param offset the offset supplied to fuse_lowlevel_notify_retrieve(=
)
-     * @param bufv the buffer containing the returned data
-     */
-    void (*retrieve_reply)(fuse_req_t req, void *cookie, fuse_ino_t ino,
-                           off_t offset, struct fuse_bufvec *bufv);
-
     /**
      * Forget about multiple inodes
      *
@@ -1726,38 +1711,6 @@ int fuse_lowlevel_notify_delete(struct fuse_session =
*se, fuse_ino_t parent,
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
                                off_t offset, struct fuse_bufvec *bufv,
                                enum fuse_buf_copy_flags flags);
-/**
- * Retrieve data from the kernel buffers
- *
- * Retrieve data in the kernel buffers belonging to the given inode.
- * If successful then the retrieve_reply() method will be called with
- * the returned data.
- *
- * Only present pages are returned in the retrieve reply.  Retrieving
- * stops when it finds a non-present page and only data prior to that
- * is returned.
- *
- * If this function returns an error, then the retrieve will not be
- * completed and no reply will be sent.
- *
- * This function doesn't change the dirty state of pages in the kernel
- * buffer.  For dirty pages the write() method will be called
- * regardless of having been retrieved previously.
- *
- * Added in FUSE protocol version 7.15. If the kernel does not support
- * this (or a newer) version, the function will return -ENOSYS and do
- * nothing.
- *
- * @param se the session object
- * @param ino the inode number
- * @param size the number of bytes to retrieve
- * @param offset the starting offset into the file to retrieve from
- * @param cookie user data to supply to the reply callback
- * @return zero for success, -errno for failure
- */
-int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
-                                  size_t size, off_t offset, void *cookie)=
;
-
=20
 /*
  * Utility functions
--=20
2.23.0


