Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9184C2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKRR8s3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9184C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhqt-0002wS-DE
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdI-0004FT-HM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdF-0006Ag-Iy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdF-0006Aa-Fs
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgz78ERMZkfkSADB5MVI/243cZq6gMfCJk8de9TTCYg=;
 b=WKRR8s3VFqYA7yDMUg2kfv+LkiA1NqsSa9i7pb5JiAoWR5hddeuf1ry5v47khNs7KEnXei
 sAmVFAtaUl5DH8RH+MC516pOCSzrYaFEfEwKuREmiN0sbXFWCWaBE42O5zV+Tc/QbRf2QW
 AdLlsUhqotWwvZprFFj0Le4g47r/FQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-qgNXgRoNOVSn5rbmK_PkgQ-1; Thu, 23 Jan 2020 11:46:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952581080889
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:46:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6014928D13;
 Thu, 23 Jan 2020 16:46:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 010/108] virtiofsd: Remove unused enum fuse_buf_copy_flags
Date: Thu, 23 Jan 2020 16:44:52 +0000
Message-Id: <20200123164630.91498-11-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qgNXgRoNOVSn5rbmK_PkgQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/buffer.c         |  7 +++--
 tools/virtiofsd/fuse_common.h    | 46 +-------------------------------
 tools/virtiofsd/fuse_lowlevel.c  | 13 ++++-----
 tools/virtiofsd/fuse_lowlevel.h  | 35 ++----------------------
 tools/virtiofsd/passthrough_ll.c |  4 +--
 5 files changed, 13 insertions(+), 92 deletions(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 5df946c82c..4d507f3302 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -171,7 +171,7 @@ static ssize_t fuse_buf_fd_to_fd(const struct fuse_buf =
*dst, size_t dst_off,
=20
 static ssize_t fuse_buf_copy_one(const struct fuse_buf *dst, size_t dst_of=
f,
                                  const struct fuse_buf *src, size_t src_of=
f,
-                                 size_t len, enum fuse_buf_copy_flags flag=
s)
+                                 size_t len)
 {
     int src_is_fd =3D src->flags & FUSE_BUF_IS_FD;
     int dst_is_fd =3D dst->flags & FUSE_BUF_IS_FD;
@@ -224,8 +224,7 @@ static int fuse_bufvec_advance(struct fuse_bufvec *bufv=
, size_t len)
     return 1;
 }
=20
-ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct fuse_bufvec *srcv,
-                      enum fuse_buf_copy_flags flags)
+ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct fuse_bufvec *srcv)
 {
     size_t copied =3D 0;
=20
@@ -249,7 +248,7 @@ ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct =
fuse_bufvec *srcv,
         dst_len =3D dst->size - dstv->off;
         len =3D min_size(src_len, dst_len);
=20
-        res =3D fuse_buf_copy_one(dst, dstv->off, src, srcv->off, len, fla=
gs);
+        res =3D fuse_buf_copy_one(dst, dstv->off, src, srcv->off, len);
         if (res < 0) {
             if (!copied) {
                 return res;
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index bd9bf861f0..0cb33acc2f 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -604,48 +604,6 @@ enum fuse_buf_flags {
     FUSE_BUF_FD_RETRY =3D (1 << 3),
 };
=20
-/**
- * Buffer copy flags
- */
-enum fuse_buf_copy_flags {
-    /**
-     * Don't use splice(2)
-     *
-     * Always fall back to using read and write instead of
-     * splice(2) to copy data from one file descriptor to another.
-     *
-     * If this flag is not set, then only fall back if splice is
-     * unavailable.
-     */
-    FUSE_BUF_NO_SPLICE =3D (1 << 1),
-
-    /**
-     * Force splice
-     *
-     * Always use splice(2) to copy data from one file descriptor
-     * to another.  If splice is not available, return -EINVAL.
-     */
-    FUSE_BUF_FORCE_SPLICE =3D (1 << 2),
-
-    /**
-     * Try to move data with splice.
-     *
-     * If splice is used, try to move pages from the source to the
-     * destination instead of copying.  See documentation of
-     * SPLICE_F_MOVE in splice(2) man page.
-     */
-    FUSE_BUF_SPLICE_MOVE =3D (1 << 3),
-
-    /**
-     * Don't block on the pipe when copying data with splice
-     *
-     * Makes the operations on the pipe non-blocking (if the pipe
-     * is full or empty).  See SPLICE_F_NONBLOCK in the splice(2)
-     * man page.
-     */
-    FUSE_BUF_SPLICE_NONBLOCK =3D (1 << 4),
-};
-
 /**
  * Single data buffer
  *
@@ -741,11 +699,9 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv);
  *
  * @param dst destination buffer vector
  * @param src source buffer vector
- * @param flags flags controlling the copy
  * @return actual number of bytes copied or -errno on error
  */
-ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src,
-                      enum fuse_buf_copy_flags flags);
+ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src);
=20
 /*
  * Signal handling
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index eb0ec49d38..3da80de233 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -490,16 +490,14 @@ static int fuse_send_data_iov_fallback(struct fuse_se=
ssion *se,
=20
 static int fuse_send_data_iov(struct fuse_session *se, struct fuse_chan *c=
h,
                               struct iovec *iov, int iov_count,
-                              struct fuse_bufvec *buf, unsigned int flags)
+                              struct fuse_bufvec *buf)
 {
     size_t len =3D fuse_buf_size(buf);
-    (void)flags;
=20
     return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len);
 }
=20
-int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
-                    enum fuse_buf_copy_flags flags)
+int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv)
 {
     struct iovec iov[2];
     struct fuse_out_header out;
@@ -511,7 +509,7 @@ int fuse_reply_data(fuse_req_t req, struct fuse_bufvec =
*bufv,
     out.unique =3D req->unique;
     out.error =3D 0;
=20
-    res =3D fuse_send_data_iov(req->se, req->ch, iov, 1, bufv, flags);
+    res =3D fuse_send_data_iov(req->se, req->ch, iov, 1, bufv);
     if (res <=3D 0) {
         fuse_free_req(req);
         return res;
@@ -1969,8 +1967,7 @@ int fuse_lowlevel_notify_delete(struct fuse_session *=
se, fuse_ino_t parent,
 }
=20
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
-                               off_t offset, struct fuse_bufvec *bufv,
-                               enum fuse_buf_copy_flags flags)
+                               off_t offset, struct fuse_bufvec *bufv)
 {
     struct fuse_out_header out;
     struct fuse_notify_store_out outarg;
@@ -1999,7 +1996,7 @@ int fuse_lowlevel_notify_store(struct fuse_session *s=
e, fuse_ino_t ino,
     iov[1].iov_base =3D &outarg;
     iov[1].iov_len =3D sizeof(outarg);
=20
-    res =3D fuse_send_data_iov(se, NULL, iov, 2, bufv, flags);
+    res =3D fuse_send_data_iov(se, NULL, iov, 2, bufv);
     if (res > 0) {
         res =3D -res;
     }
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 12a84b460f..2fa225d40b 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1363,33 +1363,6 @@ int fuse_reply_buf(fuse_req_t req, const char *buf, =
size_t size);
 /**
  * Reply with data copied/moved from buffer(s)
  *
- * Zero copy data transfer ("splicing") will be used under
- * the following circumstances:
- *
- * 1. FUSE_CAP_SPLICE_WRITE is set in fuse_conn_info.want, and
- * 2. the kernel supports splicing from the fuse device
- *    (FUSE_CAP_SPLICE_WRITE is set in fuse_conn_info.capable), and
- * 3. *flags* does not contain FUSE_BUF_NO_SPLICE
- * 4. The amount of data that is provided in file-descriptor backed
- *    buffers (i.e., buffers for which bufv[n].flags =3D=3D FUSE_BUF_FD)
- *    is at least twice the page size.
- *
- * In order for SPLICE_F_MOVE to be used, the following additional
- * conditions have to be fulfilled:
- *
- * 1. FUSE_CAP_SPLICE_MOVE is set in fuse_conn_info.want, and
- * 2. the kernel supports it (i.e, FUSE_CAP_SPLICE_MOVE is set in
-      fuse_conn_info.capable), and
- * 3. *flags* contains FUSE_BUF_SPLICE_MOVE
- *
- * Note that, if splice is used, the data is actually spliced twice:
- * once into a temporary pipe (to prepend header data), and then again
- * into the kernel. If some of the provided buffers are memory-backed,
- * the data in them is copied in step one and spliced in step two.
- *
- * The FUSE_BUF_SPLICE_FORCE_SPLICE and FUSE_BUF_SPLICE_NONBLOCK flags
- * are silently ignored.
- *
  * Possible requests:
  *   read, readdir, getxattr, listxattr
  *
@@ -1400,11 +1373,9 @@ int fuse_reply_buf(fuse_req_t req, const char *buf, =
size_t size);
  *
  * @param req request handle
  * @param bufv buffer vector
- * @param flags flags controlling the copy
  * @return zero for success, -errno for failure to send reply
  */
-int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
-                    enum fuse_buf_copy_flags flags);
+int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv);
=20
 /**
  * Reply with data vector
@@ -1705,12 +1676,10 @@ int fuse_lowlevel_notify_delete(struct fuse_session=
 *se, fuse_ino_t parent,
  * @param ino the inode number
  * @param offset the starting offset into the file to store to
  * @param bufv buffer vector
- * @param flags flags controlling the copy
  * @return zero for success, -errno for failure
  */
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
-                               off_t offset, struct fuse_bufvec *bufv,
-                               enum fuse_buf_copy_flags flags);
+                               off_t offset, struct fuse_bufvec *bufv);
=20
 /*
  * Utility functions
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 9377718d9d..126a56ccbd 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -931,7 +931,7 @@ static void lo_read(fuse_req_t req, fuse_ino_t ino, siz=
e_t size, off_t offset,
     buf.buf[0].fd =3D fi->fh;
     buf.buf[0].pos =3D offset;
=20
-    fuse_reply_data(req, &buf, FUSE_BUF_SPLICE_MOVE);
+    fuse_reply_data(req, &buf);
 }
=20
 static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
@@ -952,7 +952,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino=
,
                  out_buf.buf[0].size, (unsigned long)off);
     }
=20
-    res =3D fuse_buf_copy(&out_buf, in_buf, 0);
+    res =3D fuse_buf_copy(&out_buf, in_buf);
     if (res < 0) {
         fuse_reply_err(req, -res);
     } else {
--=20
2.24.1


