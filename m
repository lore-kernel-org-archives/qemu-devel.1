Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46830C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FA321835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qaen6Ape"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FA321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuccy-0001of-6s
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8Z-0001kt-0Q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8T-0004m8-Ld
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8T-0004l7-F8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApT5BT2mKzRrzAbpX4Exs746b6yxibyVuMKUi+Ixzd0=;
 b=Qaen6ApeHO8T5+EA2lU+KEIksJ1gHWXeEPS1QF8xwluX6gSnIs6t2zi08mavy+3veiOq2U
 CB2fqi8g1gFUWrd/T8/LfMmeLXIx0ErnlnQDT6LcOwF2lqPMjxCAUsxuLcoAUZ/OGonclJ
 ifgDwhYjgsuwyaF2CI6anirK1qAz1Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-2KbURWGkMVOAOWCGjDEQTw-1; Thu, 23 Jan 2020 06:58:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1776CDB60
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:58:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 646931CB;
 Thu, 23 Jan 2020 11:58:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 006/111] virtiofsd: Trim down imported files
Date: Thu, 23 Jan 2020 11:56:56 +0000
Message-Id: <20200123115841.138849-7-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2KbURWGkMVOAOWCGjDEQTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's a lot of the original fuse code we don't need; trim them down.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
with additional trimming by:
Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/buffer.c              |  71 +--
 tools/virtiofsd/fuse.h                |  46 --
 tools/virtiofsd/fuse_common.h         |  32 --
 tools/virtiofsd/fuse_i.h              |  41 --
 tools/virtiofsd/fuse_log.h            |   8 -
 tools/virtiofsd/fuse_lowlevel.c       | 675 +-------------------------
 tools/virtiofsd/fuse_lowlevel.h       |  28 --
 tools/virtiofsd/fuse_opt.h            |   8 -
 tools/virtiofsd/helper.c              | 143 ------
 tools/virtiofsd/passthrough_helpers.h |  26 -
 tools/virtiofsd/passthrough_ll.c      |   1 -
 11 files changed, 8 insertions(+), 1071 deletions(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 5ab9b87455..aefb7dbf15 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -157,73 +157,6 @@ static ssize_t fuse_buf_fd_to_fd(const struct fuse_buf=
 *dst, size_t dst_off,
 =09return copied;
 }
=20
-#ifdef HAVE_SPLICE
-static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst_off,
-=09=09=09       const struct fuse_buf *src, size_t src_off,
-=09=09=09       size_t len, enum fuse_buf_copy_flags flags)
-{
-=09int splice_flags =3D 0;
-=09off_t *srcpos =3D NULL;
-=09off_t *dstpos =3D NULL;
-=09off_t srcpos_val;
-=09off_t dstpos_val;
-=09ssize_t res;
-=09size_t copied =3D 0;
-
-=09if (flags & FUSE_BUF_SPLICE_MOVE)
-=09=09splice_flags |=3D SPLICE_F_MOVE;
-=09if (flags & FUSE_BUF_SPLICE_NONBLOCK)
-=09=09splice_flags |=3D SPLICE_F_NONBLOCK;
-
-=09if (src->flags & FUSE_BUF_FD_SEEK) {
-=09=09srcpos_val =3D src->pos + src_off;
-=09=09srcpos =3D &srcpos_val;
-=09}
-=09if (dst->flags & FUSE_BUF_FD_SEEK) {
-=09=09dstpos_val =3D dst->pos + dst_off;
-=09=09dstpos =3D &dstpos_val;
-=09}
-
-=09while (len) {
-=09=09res =3D splice(src->fd, srcpos, dst->fd, dstpos, len,
-=09=09=09     splice_flags);
-=09=09if (res =3D=3D -1) {
-=09=09=09if (copied)
-=09=09=09=09break;
-
-=09=09=09if (errno !=3D EINVAL || (flags & FUSE_BUF_FORCE_SPLICE))
-=09=09=09=09return -errno;
-
-=09=09=09/* Maybe splice is not supported for this combination */
-=09=09=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off,
-=09=09=09=09=09=09 len);
-=09=09}
-=09=09if (res =3D=3D 0)
-=09=09=09break;
-
-=09=09copied +=3D res;
-=09=09if (!(src->flags & FUSE_BUF_FD_RETRY) &&
-=09=09    !(dst->flags & FUSE_BUF_FD_RETRY)) {
-=09=09=09break;
-=09=09}
-
-=09=09len -=3D res;
-=09}
-
-=09return copied;
-}
-#else
-static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst_off,
-=09=09=09       const struct fuse_buf *src, size_t src_off,
-=09=09=09       size_t len, enum fuse_buf_copy_flags flags)
-{
-=09(void) flags;
-
-=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
-}
-#endif
-
-
 static ssize_t fuse_buf_copy_one(const struct fuse_buf *dst, size_t dst_of=
f,
 =09=09=09=09 const struct fuse_buf *src, size_t src_off,
 =09=09=09=09 size_t len, enum fuse_buf_copy_flags flags)
@@ -247,10 +180,8 @@ static ssize_t fuse_buf_copy_one(const struct fuse_buf=
 *dst, size_t dst_off,
 =09=09return fuse_buf_write(dst, dst_off, src, src_off, len);
 =09} else if (!dst_is_fd) {
 =09=09return fuse_buf_read(dst, dst_off, src, src_off, len);
-=09} else if (flags & FUSE_BUF_NO_SPLICE) {
-=09=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
 =09} else {
-=09=09return fuse_buf_splice(dst, dst_off, src, src_off, len, flags);
+=09=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
 =09}
 }
=20
diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h
index 883f6e59fb..3202fba6bb 100644
--- a/tools/virtiofsd/fuse.h
+++ b/tools/virtiofsd/fuse.h
@@ -25,10 +25,6 @@
 #include <sys/statvfs.h>
 #include <sys/uio.h>
=20
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /* ----------------------------------------------------------- *
  * Basic FUSE API=09=09=09=09=09       *
  * ----------------------------------------------------------- */
@@ -978,44 +974,6 @@ int fuse_loop(struct fuse *f);
  */
 void fuse_exit(struct fuse *f);
=20
-/**
- * FUSE event loop with multiple threads
- *
- * Requests from the kernel are processed, and the appropriate
- * operations are called.  Request are processed in parallel by
- * distributing them between multiple threads.
- *
- * For a description of the return value and the conditions when the
- * event loop exits, refer to the documentation of
- * fuse_session_loop().
- *
- * Note: using fuse_loop() instead of fuse_loop_mt() means you are running=
 in
- * single-threaded mode, and that you will not have to worry about reentra=
ncy,
- * though you will have to worry about recursive lookups. In single-thread=
ed
- * mode, FUSE will wait for one callback to return before calling another.
- *
- * Enabling multiple threads, by using fuse_loop_mt(), will cause FUSE to =
make
- * multiple simultaneous calls into the various callback functions given b=
y your
- * fuse_operations record.
- *
- * If you are using multiple threads, you can enjoy all the parallel execu=
tion
- * and interactive response benefits of threads, and you get to enjoy all =
the
- * benefits of race conditions and locking bugs, too. Ensure that any code=
 used
- * in the callback function of fuse_operations is also thread-safe.
- *
- * @param f the FUSE handle
- * @param config loop configuration
- * @return see fuse_session_loop()
- *
- * See also: fuse_loop()
- */
-#if FUSE_USE_VERSION < 32
-int fuse_loop_mt_31(struct fuse *f, int clone_fd);
-#define fuse_loop_mt(f, clone_fd) fuse_loop_mt_31(f, clone_fd)
-#else
-int fuse_loop_mt(struct fuse *f, struct fuse_loop_config *config);
-#endif
-
 /**
  * Get the current context
  *
@@ -1268,8 +1226,4 @@ struct fuse_session *fuse_get_session(struct fuse *f)=
;
  */
 int fuse_open_channel(const char *mountpoint, const char *options);
=20
-#ifdef __cplusplus
-}
-#endif
-
 #endif /* FUSE_H_ */
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 2d686b2ac4..bf8f8cc865 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -28,10 +28,6 @@
 #define FUSE_MAKE_VERSION(maj, min)  ((maj) * 10 + (min))
 #define FUSE_VERSION FUSE_MAKE_VERSION(FUSE_MAJOR_VERSION, FUSE_MINOR_VERS=
ION)
=20
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /**
  * Information about an open file.
  *
@@ -100,30 +96,6 @@ struct fuse_file_info {
 =09uint32_t poll_events;
 };
=20
-/**
- * Configuration parameters passed to fuse_session_loop_mt() and
- * fuse_loop_mt().
- */
-struct fuse_loop_config {
-=09/**
-=09 * whether to use separate device fds for each thread
-=09 * (may increase performance)
-=09 */
-=09int clone_fd;
-
-=09/**
-=09 * The maximum number of available worker threads before they
-=09 * start to get deleted when they become idle. If not
-=09 * specified, the default is 10.
-=09 *
-=09 * Adjusting this has performance implications; a very small number
-=09 * of threads in the pool will cause a lot of thread creation and
-=09 * deletion overhead and performance may suffer. When set to 0, a new
-=09 * thread will be created to service every operation.
-=09 */
-=09unsigned int max_idle_threads;
-};
-
 /*************************************************************************=
*
  * Capability bits for 'fuse_conn_info.capable' and 'fuse_conn_info.want' =
*
  *************************************************************************=
*/
@@ -802,10 +774,6 @@ void fuse_remove_signal_handlers(struct fuse_session *=
se);
 #  error only API version 30 or greater is supported
 #endif
=20
-#ifdef __cplusplus
-}
-#endif
-
=20
 /*
  * This interface uses 64 bit off_t.
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index d38b630ac5..b39522e3ca 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -9,8 +9,6 @@
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
-struct mount_opts;
-
 struct fuse_req {
 =09struct fuse_session *se;
 =09uint64_t unique;
@@ -45,7 +43,6 @@ struct fuse_session {
 =09char *mountpoint;
 =09volatile int exited;
 =09int fd;
-=09struct mount_opts *mo;
 =09int debug;
 =09int deny_others;
 =09struct fuse_lowlevel_ops op;
@@ -58,7 +55,6 @@ struct fuse_session {
 =09struct fuse_req interrupts;
 =09pthread_mutex_t lock;
 =09int got_destroy;
-=09pthread_key_t pipe_key;
 =09int broken_splice_nonblock;
 =09uint64_t notify_ctr;
 =09struct fuse_notify_req notify_list;
@@ -87,53 +83,16 @@ struct fuse_module {
 =09int ctr;
 };
=20
-/* ----------------------------------------------------------- *
- * Channel interface (when using -o clone_fd)=09=09       *
- * ----------------------------------------------------------- */
-
-/**
- * Obtain counted reference to the channel
- *
- * @param ch the channel
- * @return the channel
- */
-struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
-
-/**
- * Drop counted reference to a channel
- *
- * @param ch the channel
- */
-void fuse_chan_put(struct fuse_chan *ch);
-
-struct mount_opts *parse_mount_opts(struct fuse_args *args);
-void destroy_mount_opts(struct mount_opts *mo);
-void fuse_mount_version(void);
-unsigned get_max_read(struct mount_opts *o);
-void fuse_kern_unmount(const char *mountpoint, int fd);
-int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
-
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *io=
v,
 =09=09=09       int count);
 void fuse_free_req(fuse_req_t req);
=20
-void cuse_lowlevel_init(fuse_req_t req, fuse_ino_t nodeide, const void *in=
arg);
-
-int fuse_start_thread(pthread_t *thread_id, void *(*func)(void *), void *a=
rg);
-
-int fuse_session_receive_buf_int(struct fuse_session *se, struct fuse_buf =
*buf,
-=09=09=09=09 struct fuse_chan *ch);
 void fuse_session_process_buf_int(struct fuse_session *se,
 =09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch);
=20
-struct fuse *fuse_new_31(struct fuse_args *args, const struct fuse_operati=
ons *op,
-=09=09      size_t op_size, void *private_data);
-int fuse_loop_mt_32(struct fuse *f, struct fuse_loop_config *config);
-int fuse_session_loop_mt_32(struct fuse_session *se, struct fuse_loop_conf=
ig *config);
=20
 #define FUSE_MAX_MAX_PAGES 256
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
=20
 /* room needed in buffer to accommodate header */
 #define FUSE_BUFFER_HEADER_SIZE 0x1000
-
diff --git a/tools/virtiofsd/fuse_log.h b/tools/virtiofsd/fuse_log.h
index 5e112e0f53..0af700da6b 100644
--- a/tools/virtiofsd/fuse_log.h
+++ b/tools/virtiofsd/fuse_log.h
@@ -16,10 +16,6 @@
=20
 #include <stdarg.h>
=20
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /**
  * Log severity level
  *
@@ -75,8 +71,4 @@ void fuse_set_log_func(fuse_log_func_t func);
  */
 void fuse_log(enum fuse_log_level level, const char *fmt, ...);
=20
-#ifdef __cplusplus
-}
-#endif
-
 #endif /* FUSE_LOG_H_ */
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index f2d7038e34..e6fa247924 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -16,7 +16,6 @@
 #include "fuse_kernel.h"
 #include "fuse_opt.h"
 #include "fuse_misc.h"
-#include "mount_util.h"
=20
 #include <stdio.h>
 #include <stdlib.h>
@@ -28,12 +27,6 @@
 #include <assert.h>
 #include <sys/file.h>
=20
-#ifndef F_LINUX_SPECIFIC_BASE
-#define F_LINUX_SPECIFIC_BASE       1024
-#endif
-#ifndef F_SETPIPE_SZ
-#define F_SETPIPE_SZ=09(F_LINUX_SPECIFIC_BASE + 7)
-#endif
=20
=20
 #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
@@ -137,7 +130,6 @@ void fuse_free_req(fuse_req_t req)
 =09req->u.ni.data =3D NULL;
 =09list_del_req(req);
 =09ctr =3D --req->ctr;
-=09fuse_chan_put(req->ch);
 =09req->ch =3D NULL;
 =09pthread_mutex_unlock(&se->lock);
 =09if (!ctr)
@@ -184,19 +176,7 @@ static int fuse_send_msg(struct fuse_session *se, stru=
ct fuse_chan *ch,
 =09=09}
 =09}
=20
-=09ssize_t res =3D writev(ch ? ch->fd : se->fd,
-=09=09=09     iov, count);
-=09int err =3D errno;
-
-=09if (res =3D=3D -1) {
-=09=09assert(se !=3D NULL);
-
-=09=09/* ENOENT means the operation was interrupted */
-=09=09if (!fuse_session_exited(se) && err !=3D ENOENT)
-=09=09=09perror("fuse: writing device");
-=09=09return -err;
-=09}
-
+=09abort(); /* virtio should have taken it before here */
 =09return 0;
 }
=20
@@ -480,10 +460,6 @@ static int fuse_send_data_iov_fallback(struct fuse_ses=
sion *se,
 =09=09=09=09       struct fuse_bufvec *buf,
 =09=09=09=09       size_t len)
 {
-=09struct fuse_bufvec mem_buf =3D FUSE_BUFVEC_INIT(len);
-=09void *mbuf;
-=09int res;
-
 =09/* Optimize common case */
 =09if (buf->count =3D=3D 1 && buf->idx =3D=3D 0 && buf->off =3D=3D 0 &&
 =09    !(buf->buf[0].flags & FUSE_BUF_IS_FD)) {
@@ -496,350 +472,10 @@ static int fuse_send_data_iov_fallback(struct fuse_s=
ession *se,
 =09=09return fuse_send_msg(se, ch, iov, iov_count);
 =09}
=20
-=09res =3D posix_memalign(&mbuf, pagesize, len);
-=09if (res !=3D 0)
-=09=09return res;
-
-=09mem_buf.buf[0].mem =3D mbuf;
-=09res =3D fuse_buf_copy(&mem_buf, buf, 0);
-=09if (res < 0) {
-=09=09free(mbuf);
-=09=09return -res;
-=09}
-=09len =3D res;
-
-=09iov[iov_count].iov_base =3D mbuf;
-=09iov[iov_count].iov_len =3D len;
-=09iov_count++;
-=09res =3D fuse_send_msg(se, ch, iov, iov_count);
-=09free(mbuf);
-
-=09return res;
-}
-
-struct fuse_ll_pipe {
-=09size_t size;
-=09int can_grow;
-=09int pipe[2];
-};
-
-static void fuse_ll_pipe_free(struct fuse_ll_pipe *llp)
-{
-=09close(llp->pipe[0]);
-=09close(llp->pipe[1]);
-=09free(llp);
-}
-
-#ifdef HAVE_SPLICE
-#if !defined(HAVE_PIPE2) || !defined(O_CLOEXEC)
-static int fuse_pipe(int fds[2])
-{
-=09int rv =3D pipe(fds);
-
-=09if (rv =3D=3D -1)
-=09=09return rv;
-
-=09if (fcntl(fds[0], F_SETFL, O_NONBLOCK) =3D=3D -1 ||
-=09    fcntl(fds[1], F_SETFL, O_NONBLOCK) =3D=3D -1 ||
-=09    fcntl(fds[0], F_SETFD, FD_CLOEXEC) =3D=3D -1 ||
-=09    fcntl(fds[1], F_SETFD, FD_CLOEXEC) =3D=3D -1) {
-=09=09close(fds[0]);
-=09=09close(fds[1]);
-=09=09rv =3D -1;
-=09}
-=09return rv;
-}
-#else
-static int fuse_pipe(int fds[2])
-{
-=09return pipe2(fds, O_CLOEXEC | O_NONBLOCK);
-}
-#endif
-
-static struct fuse_ll_pipe *fuse_ll_get_pipe(struct fuse_session *se)
-{
-=09struct fuse_ll_pipe *llp =3D pthread_getspecific(se->pipe_key);
-=09if (llp =3D=3D NULL) {
-=09=09int res;
-
-=09=09llp =3D malloc(sizeof(struct fuse_ll_pipe));
-=09=09if (llp =3D=3D NULL)
-=09=09=09return NULL;
-
-=09=09res =3D fuse_pipe(llp->pipe);
-=09=09if (res =3D=3D -1) {
-=09=09=09free(llp);
-=09=09=09return NULL;
-=09=09}
-
-=09=09/*
-=09=09 *the default size is 16 pages on linux
-=09=09 */
-=09=09llp->size =3D pagesize * 16;
-=09=09llp->can_grow =3D 1;
-
-=09=09pthread_setspecific(se->pipe_key, llp);
-=09}
-
-=09return llp;
-}
-#endif
-
-static void fuse_ll_clear_pipe(struct fuse_session *se)
-{
-=09struct fuse_ll_pipe *llp =3D pthread_getspecific(se->pipe_key);
-=09if (llp) {
-=09=09pthread_setspecific(se->pipe_key, NULL);
-=09=09fuse_ll_pipe_free(llp);
-=09}
-}
-
-#if defined(HAVE_SPLICE) && defined(HAVE_VMSPLICE)
-static int read_back(int fd, char *buf, size_t len)
-{
-=09int res;
-
-=09res =3D read(fd, buf, len);
-=09if (res =3D=3D -1) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: internal error: failed to read back fr=
om pipe: %s\n", strerror(errno));
-=09=09return -EIO;
-=09}
-=09if (res !=3D len) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: internal error: short read back from p=
ipe: %i from %zi\n", res, len);
-=09=09return -EIO;
-=09}
+=09abort(); /* Will have taken vhost path */
 =09return 0;
 }
=20
-static int grow_pipe_to_max(int pipefd)
-{
-=09int max;
-=09int res;
-=09int maxfd;
-=09char buf[32];
-
-=09maxfd =3D open("/proc/sys/fs/pipe-max-size", O_RDONLY);
-=09if (maxfd < 0)
-=09=09return -errno;
-
-=09res =3D read(maxfd, buf, sizeof(buf) - 1);
-=09if (res < 0) {
-=09=09int saved_errno;
-
-=09=09saved_errno =3D errno;
-=09=09close(maxfd);
-=09=09return -saved_errno;
-=09}
-=09close(maxfd);
-=09buf[res] =3D '\0';
-
-=09max =3D atoi(buf);
-=09res =3D fcntl(pipefd, F_SETPIPE_SZ, max);
-=09if (res < 0)
-=09=09return -errno;
-=09return max;
-}
-
-static int fuse_send_data_iov(struct fuse_session *se, struct fuse_chan *c=
h,
-=09=09=09       struct iovec *iov, int iov_count,
-=09=09=09       struct fuse_bufvec *buf, unsigned int flags)
-{
-=09int res;
-=09size_t len =3D fuse_buf_size(buf);
-=09struct fuse_out_header *out =3D iov[0].iov_base;
-=09struct fuse_ll_pipe *llp;
-=09int splice_flags;
-=09size_t pipesize;
-=09size_t total_fd_size;
-=09size_t idx;
-=09size_t headerlen;
-=09struct fuse_bufvec pipe_buf =3D FUSE_BUFVEC_INIT(len);
-
-=09if (se->broken_splice_nonblock)
-=09=09goto fallback;
-
-=09if (flags & FUSE_BUF_NO_SPLICE)
-=09=09goto fallback;
-
-=09total_fd_size =3D 0;
-=09for (idx =3D buf->idx; idx < buf->count; idx++) {
-=09=09if (buf->buf[idx].flags & FUSE_BUF_IS_FD) {
-=09=09=09total_fd_size =3D buf->buf[idx].size;
-=09=09=09if (idx =3D=3D buf->idx)
-=09=09=09=09total_fd_size -=3D buf->off;
-=09=09}
-=09}
-=09if (total_fd_size < 2 * pagesize)
-=09=09goto fallback;
-
-=09if (se->conn.proto_minor < 14 ||
-=09    !(se->conn.want & FUSE_CAP_SPLICE_WRITE))
-=09=09goto fallback;
-
-=09llp =3D fuse_ll_get_pipe(se);
-=09if (llp =3D=3D NULL)
-=09=09goto fallback;
-
-
-=09headerlen =3D iov_length(iov, iov_count);
-
-=09out->len =3D headerlen + len;
-
-=09/*
-=09 * Heuristic for the required pipe size, does not work if the
-=09 * source contains less than page size fragments
-=09 */
-=09pipesize =3D pagesize * (iov_count + buf->count + 1) + out->len;
-
-=09if (llp->size < pipesize) {
-=09=09if (llp->can_grow) {
-=09=09=09res =3D fcntl(llp->pipe[0], F_SETPIPE_SZ, pipesize);
-=09=09=09if (res =3D=3D -1) {
-=09=09=09=09res =3D grow_pipe_to_max(llp->pipe[0]);
-=09=09=09=09if (res > 0)
-=09=09=09=09=09llp->size =3D res;
-=09=09=09=09llp->can_grow =3D 0;
-=09=09=09=09goto fallback;
-=09=09=09}
-=09=09=09llp->size =3D res;
-=09=09}
-=09=09if (llp->size < pipesize)
-=09=09=09goto fallback;
-=09}
-
-
-=09res =3D vmsplice(llp->pipe[1], iov, iov_count, SPLICE_F_NONBLOCK);
-=09if (res =3D=3D -1)
-=09=09goto fallback;
-
-=09if (res !=3D headerlen) {
-=09=09res =3D -EIO;
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: short vmsplice to pipe: %u/%zu\n", res=
,
-=09=09=09headerlen);
-=09=09goto clear_pipe;
-=09}
-
-=09pipe_buf.buf[0].flags =3D FUSE_BUF_IS_FD;
-=09pipe_buf.buf[0].fd =3D llp->pipe[1];
-
-=09res =3D fuse_buf_copy(&pipe_buf, buf,
-=09=09=09    FUSE_BUF_FORCE_SPLICE | FUSE_BUF_SPLICE_NONBLOCK);
-=09if (res < 0) {
-=09=09if (res =3D=3D -EAGAIN || res =3D=3D -EINVAL) {
-=09=09=09/*
-=09=09=09 * Should only get EAGAIN on kernels with
-=09=09=09 * broken SPLICE_F_NONBLOCK support (<=3D
-=09=09=09 * 2.6.35) where this error or a short read is
-=09=09=09 * returned even if the pipe itself is not
-=09=09=09 * full
-=09=09=09 *
-=09=09=09 * EINVAL might mean that splice can't handle
-=09=09=09 * this combination of input and output.
-=09=09=09 */
-=09=09=09if (res =3D=3D -EAGAIN)
-=09=09=09=09se->broken_splice_nonblock =3D 1;
-
-=09=09=09pthread_setspecific(se->pipe_key, NULL);
-=09=09=09fuse_ll_pipe_free(llp);
-=09=09=09goto fallback;
-=09=09}
-=09=09res =3D -res;
-=09=09goto clear_pipe;
-=09}
-
-=09if (res !=3D 0 && res < len) {
-=09=09struct fuse_bufvec mem_buf =3D FUSE_BUFVEC_INIT(len);
-=09=09void *mbuf;
-=09=09size_t now_len =3D res;
-=09=09/*
-=09=09 * For regular files a short count is either
-=09=09 *  1) due to EOF, or
-=09=09 *  2) because of broken SPLICE_F_NONBLOCK (see above)
-=09=09 *
-=09=09 * For other inputs it's possible that we overflowed
-=09=09 * the pipe because of small buffer fragments.
-=09=09 */
-
-=09=09res =3D posix_memalign(&mbuf, pagesize, len);
-=09=09if (res !=3D 0)
-=09=09=09goto clear_pipe;
-
-=09=09mem_buf.buf[0].mem =3D mbuf;
-=09=09mem_buf.off =3D now_len;
-=09=09res =3D fuse_buf_copy(&mem_buf, buf, 0);
-=09=09if (res > 0) {
-=09=09=09char *tmpbuf;
-=09=09=09size_t extra_len =3D res;
-=09=09=09/*
-=09=09=09 * Trickiest case: got more data.  Need to get
-=09=09=09 * back the data from the pipe and then fall
-=09=09=09 * back to regular write.
-=09=09=09 */
-=09=09=09tmpbuf =3D malloc(headerlen);
-=09=09=09if (tmpbuf =3D=3D NULL) {
-=09=09=09=09free(mbuf);
-=09=09=09=09res =3D ENOMEM;
-=09=09=09=09goto clear_pipe;
-=09=09=09}
-=09=09=09res =3D read_back(llp->pipe[0], tmpbuf, headerlen);
-=09=09=09free(tmpbuf);
-=09=09=09if (res !=3D 0) {
-=09=09=09=09free(mbuf);
-=09=09=09=09goto clear_pipe;
-=09=09=09}
-=09=09=09res =3D read_back(llp->pipe[0], mbuf, now_len);
-=09=09=09if (res !=3D 0) {
-=09=09=09=09free(mbuf);
-=09=09=09=09goto clear_pipe;
-=09=09=09}
-=09=09=09len =3D now_len + extra_len;
-=09=09=09iov[iov_count].iov_base =3D mbuf;
-=09=09=09iov[iov_count].iov_len =3D len;
-=09=09=09iov_count++;
-=09=09=09res =3D fuse_send_msg(se, ch, iov, iov_count);
-=09=09=09free(mbuf);
-=09=09=09return res;
-=09=09}
-=09=09free(mbuf);
-=09=09res =3D now_len;
-=09}
-=09len =3D res;
-=09out->len =3D headerlen + len;
-
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09"   unique: %llu, success, outsize: %i (splice)\n",
-=09=09=09(unsigned long long) out->unique, out->len);
-=09}
-
-=09splice_flags =3D 0;
-=09if ((flags & FUSE_BUF_SPLICE_MOVE) &&
-=09    (se->conn.want & FUSE_CAP_SPLICE_MOVE))
-=09=09splice_flags |=3D SPLICE_F_MOVE;
-
-=09res =3D splice(llp->pipe[0], NULL, ch ? ch->fd : se->fd,
-=09=09     NULL, out->len, splice_flags);
-=09if (res =3D=3D -1) {
-=09=09res =3D -errno;
-=09=09perror("fuse: splice from pipe");
-=09=09goto clear_pipe;
-=09}
-=09if (res !=3D out->len) {
-=09=09res =3D -EIO;
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: short splice from pipe: %u/%u\n",
-=09=09=09res, out->len);
-=09=09goto clear_pipe;
-=09}
-=09return 0;
-
-clear_pipe:
-=09fuse_ll_clear_pipe(se);
-=09return res;
-
-fallback:
-=09return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len);
-}
-#else
 static int fuse_send_data_iov(struct fuse_session *se, struct fuse_chan *c=
h,
 =09=09=09       struct iovec *iov, int iov_count,
 =09=09=09       struct fuse_bufvec *buf, unsigned int flags)
@@ -849,7 +485,6 @@ static int fuse_send_data_iov(struct fuse_session *se, =
struct fuse_chan *ch,
=20
 =09return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len);
 }
-#endif
=20
 int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
 =09=09    enum fuse_buf_copy_flags flags)
@@ -1408,16 +1043,11 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg,
 =09if (bufv.buf[0].size < arg->size) {
 =09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\n"=
);
 =09=09fuse_reply_err(req, EIO);
-=09=09goto out;
+=09=09return;
 =09}
 =09bufv.buf[0].size =3D arg->size;
=20
 =09se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
-
-out:
-=09/* Need to reset the pipe if ->write_buf() didn't consume all data */
-=09if ((ibuf->flags & FUSE_BUF_IS_FD) && bufv.idx < bufv.count)
-=09=09fuse_ll_clear_pipe(se);
 }
=20
 static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
@@ -2038,17 +1668,6 @@ static void do_init(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09return;
 =09}
=20
-=09unsigned max_read_mo =3D get_max_read(se->mo);
-=09if (se->conn.max_read !=3D max_read_mo) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: error: init() and fuse_session_new() "
-=09=09=09"requested different maximum read size (%u vs %u)\n",
-=09=09=09se->conn.max_read, max_read_mo);
-=09=09fuse_reply_err(req, EPROTO);
-=09=09se->error =3D -EPROTO;
-=09=09fuse_session_exit(se);
-=09=09return;
-=09}
-
 =09if (se->conn.max_write < bufsize - FUSE_BUFFER_HEADER_SIZE) {
 =09=09se->bufsize =3D se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
 =09}
@@ -2364,8 +1983,6 @@ static void fuse_ll_retrieve_reply(struct fuse_notify=
_req *nreq,
 =09}
 out:
 =09free(rreq);
-=09if ((ibuf->flags & FUSE_BUF_IS_FD) && bufv.idx < bufv.count)
-=09=09fuse_ll_clear_pipe(se);
 }
=20
 int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
@@ -2496,7 +2113,6 @@ static struct {
 =09[FUSE_RENAME2]     =3D { do_rename2,      "RENAME2"    },
 =09[FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE" },
 =09[FUSE_LSEEK]=09   =3D { do_lseek,       "LSEEK"=09     },
-=09[CUSE_INIT]=09   =3D { cuse_lowlevel_init, "CUSE_INIT"   },
 };
=20
 #define FUSE_MAXOP (sizeof(fuse_ll_ops) / sizeof(fuse_ll_ops[0]))
@@ -2509,21 +2125,6 @@ static const char *opname(enum fuse_opcode opcode)
 =09=09return fuse_ll_ops[opcode].name;
 }
=20
-static int fuse_ll_copy_from_pipe(struct fuse_bufvec *dst,
-=09=09=09=09  struct fuse_bufvec *src)
-{
-=09ssize_t res =3D fuse_buf_copy(dst, src, 0);
-=09if (res < 0) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: %s\n", strerror(-res))=
;
-=09=09return res;
-=09}
-=09if ((size_t)res < fuse_buf_size(dst)) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: short read\n");
-=09=09return -1;
-=09}
-=09return 0;
-}
-
 void fuse_session_process_buf(struct fuse_session *se,
 =09=09=09      const struct fuse_buf *buf)
 {
@@ -2533,36 +2134,12 @@ void fuse_session_process_buf(struct fuse_session *=
se,
 void fuse_session_process_buf_int(struct fuse_session *se,
 =09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch)
 {
-=09const size_t write_header_size =3D sizeof(struct fuse_in_header) +
-=09=09sizeof(struct fuse_write_in);
-=09struct fuse_bufvec bufv =3D { .buf[0] =3D *buf, .count =3D 1 };
-=09struct fuse_bufvec tmpbuf =3D FUSE_BUFVEC_INIT(write_header_size);
 =09struct fuse_in_header *in;
 =09const void *inarg;
 =09struct fuse_req *req;
-=09void *mbuf =3D NULL;
 =09int err;
-=09int res;
-
-=09if (buf->flags & FUSE_BUF_IS_FD) {
-=09=09if (buf->size < tmpbuf.buf[0].size)
-=09=09=09tmpbuf.buf[0].size =3D buf->size;
=20
-=09=09mbuf =3D malloc(tmpbuf.buf[0].size);
-=09=09if (mbuf =3D=3D NULL) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate header\n");
-=09=09=09goto clear_pipe;
-=09=09}
-=09=09tmpbuf.buf[0].mem =3D mbuf;
-
-=09=09res =3D fuse_ll_copy_from_pipe(&tmpbuf, &bufv);
-=09=09if (res < 0)
-=09=09=09goto clear_pipe;
-
-=09=09in =3D mbuf;
-=09} else {
-=09=09in =3D buf->mem;
-=09}
+=09in =3D buf->mem;
=20
 =09if (se->debug) {
 =09=09fuse_log(FUSE_LOG_DEBUG,
@@ -2584,14 +2161,14 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
 =09=09};
=20
 =09=09fuse_send_msg(se, ch, &iov, 1);
-=09=09goto clear_pipe;
+=09=09return;
 =09}
=20
 =09req->unique =3D in->unique;
 =09req->ctx.uid =3D in->uid;
 =09req->ctx.gid =3D in->gid;
 =09req->ctx.pid =3D in->pid;
-=09req->ch =3D ch ? fuse_chan_get(ch) : NULL;
+=09req->ch =3D ch;
=20
 =09err =3D EIO;
 =09if (!se->got_init) {
@@ -2627,28 +2204,6 @@ void fuse_session_process_buf_int(struct fuse_sessio=
n *se,
 =09=09=09fuse_reply_err(intr, EAGAIN);
 =09}
=20
-=09if ((buf->flags & FUSE_BUF_IS_FD) && write_header_size < buf->size &&
-=09    (in->opcode !=3D FUSE_WRITE || !se->op.write_buf) &&
-=09    in->opcode !=3D FUSE_NOTIFY_REPLY) {
-=09=09void *newmbuf;
-
-=09=09err =3D ENOMEM;
-=09=09newmbuf =3D realloc(mbuf, buf->size);
-=09=09if (newmbuf =3D=3D NULL)
-=09=09=09goto reply_err;
-=09=09mbuf =3D newmbuf;
-
-=09=09tmpbuf =3D FUSE_BUFVEC_INIT(buf->size - write_header_size);
-=09=09tmpbuf.buf[0].mem =3D (char *)mbuf + write_header_size;
-
-=09=09res =3D fuse_ll_copy_from_pipe(&tmpbuf, &bufv);
-=09=09err =3D -res;
-=09=09if (res < 0)
-=09=09=09goto reply_err;
-
-=09=09in =3D mbuf;
-=09}
-
 =09inarg =3D (void *) &in[1];
 =09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
 =09=09do_write_buf(req, in->nodeid, inarg, buf);
@@ -2657,16 +2212,10 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
 =09else
 =09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
=20
-out_free:
-=09free(mbuf);
 =09return;
=20
 reply_err:
 =09fuse_reply_err(req, err);
-clear_pipe:
-=09if (buf->flags & FUSE_BUF_IS_FD)
-=09=09fuse_ll_clear_pipe(se);
-=09goto out_free;
 }
=20
 #define LL_OPTION(n,o,v) \
@@ -2684,7 +2233,6 @@ void fuse_lowlevel_version(void)
 {
 =09printf("using FUSE kernel interface version %i.%i\n",
 =09       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
-=09fuse_mount_version();
 }
=20
 void fuse_lowlevel_help(void)
@@ -2692,204 +2240,29 @@ void fuse_lowlevel_help(void)
 =09/* These are not all options, but the ones that are
 =09   potentially of interest to an end-user */
 =09printf(
-"    -o allow_other         allow access by all users\n"
 "    -o allow_root          allow access by root\n"
-"    -o auto_unmount        auto unmount on process termination\n");
+);
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
 {
-=09struct fuse_ll_pipe *llp;
-
 =09if (se->got_init && !se->got_destroy) {
 =09=09if (se->op.destroy)
 =09=09=09se->op.destroy(se->userdata);
 =09}
-=09llp =3D pthread_getspecific(se->pipe_key);
-=09if (llp !=3D NULL)
-=09=09fuse_ll_pipe_free(llp);
-=09pthread_key_delete(se->pipe_key);
 =09pthread_mutex_destroy(&se->lock);
 =09free(se->cuse_data);
 =09if (se->fd !=3D -1)
 =09=09close(se->fd);
-=09destroy_mount_opts(se->mo);
 =09free(se);
 }
=20
=20
-static void fuse_ll_pipe_destructor(void *data)
-{
-=09struct fuse_ll_pipe *llp =3D data;
-=09fuse_ll_pipe_free(llp);
-}
-
-int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf=
)
-{
-=09return fuse_session_receive_buf_int(se, buf, NULL);
-}
-
-int fuse_session_receive_buf_int(struct fuse_session *se, struct fuse_buf =
*buf,
-=09=09=09=09 struct fuse_chan *ch)
-{
-=09int err;
-=09ssize_t res;
-#ifdef HAVE_SPLICE
-=09size_t bufsize =3D se->bufsize;
-=09struct fuse_ll_pipe *llp;
-=09struct fuse_buf tmpbuf;
-
-=09if (se->conn.proto_minor < 14 || !(se->conn.want & FUSE_CAP_SPLICE_READ=
))
-=09=09goto fallback;
-
-=09llp =3D fuse_ll_get_pipe(se);
-=09if (llp =3D=3D NULL)
-=09=09goto fallback;
-
-=09if (llp->size < bufsize) {
-=09=09if (llp->can_grow) {
-=09=09=09res =3D fcntl(llp->pipe[0], F_SETPIPE_SZ, bufsize);
-=09=09=09if (res =3D=3D -1) {
-=09=09=09=09llp->can_grow =3D 0;
-=09=09=09=09res =3D grow_pipe_to_max(llp->pipe[0]);
-=09=09=09=09if (res > 0)
-=09=09=09=09=09llp->size =3D res;
-=09=09=09=09goto fallback;
-=09=09=09}
-=09=09=09llp->size =3D res;
-=09=09}
-=09=09if (llp->size < bufsize)
-=09=09=09goto fallback;
-=09}
-
-=09res =3D splice(ch ? ch->fd : se->fd,
-=09=09     NULL, llp->pipe[1], NULL, bufsize, 0);
-=09err =3D errno;
-
-=09if (fuse_session_exited(se))
-=09=09return 0;
-
-=09if (res =3D=3D -1) {
-=09=09if (err =3D=3D ENODEV) {
-=09=09=09/* Filesystem was unmounted, or connection was aborted
-=09=09=09   via /sys/fs/fuse/connections */
-=09=09=09fuse_session_exit(se);
-=09=09=09return 0;
-=09=09}
-=09=09if (err !=3D EINTR && err !=3D EAGAIN)
-=09=09=09perror("fuse: splice from device");
-=09=09return -err;
-=09}
-
-=09if (res < sizeof(struct fuse_in_header)) {
-=09=09fuse_log(FUSE_LOG_ERR, "short splice from fuse device\n");
-=09=09return -EIO;
-=09}
-
-=09tmpbuf =3D (struct fuse_buf) {
-=09=09.size =3D res,
-=09=09.flags =3D FUSE_BUF_IS_FD,
-=09=09.fd =3D llp->pipe[0],
-=09};
-
-=09/*
-=09 * Don't bother with zero copy for small requests.
-=09 * fuse_loop_mt() needs to check for FORGET so this more than
-=09 * just an optimization.
-=09 */
-=09if (res < sizeof(struct fuse_in_header) +
-=09    sizeof(struct fuse_write_in) + pagesize) {
-=09=09struct fuse_bufvec src =3D { .buf[0] =3D tmpbuf, .count =3D 1 };
-=09=09struct fuse_bufvec dst =3D { .count =3D 1 };
-
-=09=09if (!buf->mem) {
-=09=09=09buf->mem =3D malloc(se->bufsize);
-=09=09=09if (!buf->mem) {
-=09=09=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09=09=09"fuse: failed to allocate read buffer\n");
-=09=09=09=09return -ENOMEM;
-=09=09=09}
-=09=09}
-=09=09buf->size =3D se->bufsize;
-=09=09buf->flags =3D 0;
-=09=09dst.buf[0] =3D *buf;
-
-=09=09res =3D fuse_buf_copy(&dst, &src, 0);
-=09=09if (res < 0) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: %s\n",
-=09=09=09=09strerror(-res));
-=09=09=09fuse_ll_clear_pipe(se);
-=09=09=09return res;
-=09=09}
-=09=09if (res < tmpbuf.size) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: short read\n");
-=09=09=09fuse_ll_clear_pipe(se);
-=09=09=09return -EIO;
-=09=09}
-=09=09assert(res =3D=3D tmpbuf.size);
-
-=09} else {
-=09=09/* Don't overwrite buf->mem, as that would cause a leak */
-=09=09buf->fd =3D tmpbuf.fd;
-=09=09buf->flags =3D tmpbuf.flags;
-=09}
-=09buf->size =3D tmpbuf.size;
-
-=09return res;
-
-fallback:
-#endif
-=09if (!buf->mem) {
-=09=09buf->mem =3D malloc(se->bufsize);
-=09=09if (!buf->mem) {
-=09=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09=09"fuse: failed to allocate read buffer\n");
-=09=09=09return -ENOMEM;
-=09=09}
-=09}
-
-restart:
-=09res =3D read(ch ? ch->fd : se->fd, buf->mem, se->bufsize);
-=09err =3D errno;
-
-=09if (fuse_session_exited(se))
-=09=09return 0;
-=09if (res =3D=3D -1) {
-=09=09/* ENOENT means the operation was interrupted, it's safe
-=09=09   to restart */
-=09=09if (err =3D=3D ENOENT)
-=09=09=09goto restart;
-
-=09=09if (err =3D=3D ENODEV) {
-=09=09=09/* Filesystem was unmounted, or connection was aborted
-=09=09=09   via /sys/fs/fuse/connections */
-=09=09=09fuse_session_exit(se);
-=09=09=09return 0;
-=09=09}
-=09=09/* Errors occurring during normal operation: EINTR (read
-=09=09   interrupted), EAGAIN (nonblocking I/O), ENODEV (filesystem
-=09=09   umounted) */
-=09=09if (err !=3D EINTR && err !=3D EAGAIN)
-=09=09=09perror("fuse: reading device");
-=09=09return -err;
-=09}
-=09if ((size_t) res < sizeof(struct fuse_in_header)) {
-=09=09fuse_log(FUSE_LOG_ERR, "short read on fuse device\n");
-=09=09return -EIO;
-=09}
-
-=09buf->size =3D res;
-
-=09return res;
-}
-
 struct fuse_session *fuse_session_new(struct fuse_args *args,
 =09=09=09=09      const struct fuse_lowlevel_ops *op,
 =09=09=09=09      size_t op_size, void *userdata)
 {
-=09int err;
 =09struct fuse_session *se;
-=09struct mount_opts *mo;
=20
 =09if (sizeof(struct fuse_lowlevel_ops) < op_size) {
 =09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: library too old, some operati=
ons may not work\n");
@@ -2913,20 +2286,6 @@ struct fuse_session *fuse_session_new(struct fuse_ar=
gs *args,
 =09/* Parse options */
 =09if(fuse_opt_parse(args, se, fuse_ll_opts, NULL) =3D=3D -1)
 =09=09goto out2;
-=09if(se->deny_others) {
-=09=09/* Allowing access only by root is done by instructing
-=09=09 * kernel to allow access by everyone, and then restricting
-=09=09 * access to root and mountpoint owner in libfuse.
-=09=09 */
-=09=09// We may be adding the option a second time, but
-=09=09// that doesn't hurt.
-=09=09if(fuse_opt_add_arg(args, "-oallow_other") =3D=3D -1)
-=09=09=09goto out2;
-=09}
-=09mo =3D parse_mount_opts(args);
-=09if (mo =3D=3D NULL)
-=09=09goto out3;
-
 =09if(args->argc =3D=3D 1 &&
 =09   args->argv[0][0] =3D=3D '-') {
 =09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: argv[0] looks like an option,=
 but "
@@ -2940,9 +2299,6 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
 =09=09goto out4;
 =09}
=20
-=09if (se->debug)
-=09=09fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE_VERSI=
ON);
-
 =09se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() +
 =09=09FUSE_BUFFER_HEADER_SIZE;
=20
@@ -2952,26 +2308,14 @@ struct fuse_session *fuse_session_new(struct fuse_a=
rgs *args,
 =09se->notify_ctr =3D 1;
 =09fuse_mutex_init(&se->lock);
=20
-=09err =3D pthread_key_create(&se->pipe_key, fuse_ll_pipe_destructor);
-=09if (err) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to create thread specific key: =
%s\n",
-=09=09=09strerror(err));
-=09=09goto out5;
-=09}
-
 =09memcpy(&se->op, op, op_size);
 =09se->owner =3D getuid();
 =09se->userdata =3D userdata;
=20
-=09se->mo =3D mo;
 =09return se;
=20
-out5:
-=09pthread_mutex_destroy(&se->lock);
 out4:
 =09fuse_opt_free_args(args);
-out3:
-=09free(mo);
 out2:
 =09free(se);
 out1:
@@ -3035,11 +2379,6 @@ int fuse_session_fd(struct fuse_session *se)
=20
 void fuse_session_unmount(struct fuse_session *se)
 {
-=09if (se->mountpoint !=3D NULL) {
-=09=09fuse_kern_unmount(se->mountpoint, se->fd);
-=09=09free(se->mountpoint);
-=09=09se->mountpoint =3D NULL;
-=09}
 }
=20
 #ifdef linux
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 18c6363f07..6b1adfcfd1 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -31,10 +31,6 @@
 #include <sys/statvfs.h>
 #include <sys/uio.h>
=20
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /* ----------------------------------------------------------- *
  * Miscellaneous definitions=09=09=09=09       *
  * ----------------------------------------------------------- */
@@ -1863,14 +1859,12 @@ void fuse_cmdline_help(void);
  * ----------------------------------------------------------- */
=20
 struct fuse_cmdline_opts {
-=09int singlethread;
 =09int foreground;
 =09int debug;
 =09int nodefault_subtype;
 =09char *mountpoint;
 =09int show_version;
 =09int show_help;
-=09int clone_fd;
 =09unsigned int max_idle_threads;
 };
=20
@@ -1961,24 +1955,6 @@ int fuse_session_mount(struct fuse_session *se, cons=
t char *mountpoint);
  */
 int fuse_session_loop(struct fuse_session *se);
=20
-/**
- * Enter a multi-threaded event loop.
- *
- * For a description of the return value and the conditions when the
- * event loop exits, refer to the documentation of
- * fuse_session_loop().
- *
- * @param se the session
- * @param config session loop configuration=20
- * @return see fuse_session_loop()
- */
-#if FUSE_USE_VERSION < 32
-int fuse_session_loop_mt_31(struct fuse_session *se, int clone_fd);
-#define fuse_session_loop_mt(se, clone_fd) fuse_session_loop_mt_31(se, clo=
ne_fd)
-#else
-int fuse_session_loop_mt(struct fuse_session *se, struct fuse_loop_config =
*config);
-#endif
-
 /**
  * Flag a session as terminated.
  *
@@ -2082,8 +2058,4 @@ void fuse_session_process_buf(struct fuse_session *se=
,
  */
 int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf=
);
=20
-#ifdef __cplusplus
-}
-#endif
-
 #endif /* FUSE_LOWLEVEL_H_ */
diff --git a/tools/virtiofsd/fuse_opt.h b/tools/virtiofsd/fuse_opt.h
index d8573e74fd..69102555be 100644
--- a/tools/virtiofsd/fuse_opt.h
+++ b/tools/virtiofsd/fuse_opt.h
@@ -14,10 +14,6 @@
  * This file defines the option parsing interface of FUSE
  */
=20
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /**
  * Option description
  *
@@ -264,8 +260,4 @@ void fuse_opt_free_args(struct fuse_args *args);
  */
 int fuse_opt_match(const struct fuse_opt opts[], const char *opt);
=20
-#ifdef __cplusplus
-}
-#endif
-
 #endif /* FUSE_OPT_H_ */
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 64ff7ad6d5..5a2e64c6d0 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -41,14 +41,10 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
 =09FUSE_OPT_KEY("-d",=09=09FUSE_OPT_KEY_KEEP),
 =09FUSE_OPT_KEY("debug",=09=09FUSE_OPT_KEY_KEEP),
 =09FUSE_HELPER_OPT("-f",=09=09foreground),
-=09FUSE_HELPER_OPT("-s",=09=09singlethread),
 =09FUSE_HELPER_OPT("fsname=3D",=09nodefault_subtype),
 =09FUSE_OPT_KEY("fsname=3D",=09=09FUSE_OPT_KEY_KEEP),
-#ifndef __FreeBSD__
 =09FUSE_HELPER_OPT("subtype=3D",=09nodefault_subtype),
 =09FUSE_OPT_KEY("subtype=3D",=09FUSE_OPT_KEY_KEEP),
-#endif
-=09FUSE_HELPER_OPT("clone_fd",=09clone_fd),
 =09FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
 =09FUSE_OPT_END
 };
@@ -132,9 +128,6 @@ void fuse_cmdline_help(void)
 =09       "    -V   --version         print version\n"
 =09       "    -d   -o debug          enable debug output (implies -f)\n"
 =09       "    -f                     foreground operation\n"
-=09       "    -s                     disable multi-threaded operation\n"
-=09       "    -o clone_fd            use separate fuse device fd for each=
 thread\n"
-=09       "                           (may improve performance)\n"
 =09       "    -o max_idle_threads    the maximum number of idle worker th=
reads\n"
 =09       "                           allowed (default: 10)\n");
 }
@@ -171,34 +164,6 @@ static int fuse_helper_opt_proc(void *data, const char=
 *arg, int key,
 =09}
 }
=20
-/* Under FreeBSD, there is no subtype option so this
-   function actually sets the fsname */
-static int add_default_subtype(const char *progname, struct fuse_args *arg=
s)
-{
-=09int res;
-=09char *subtype_opt;
-
-=09const char *basename =3D strrchr(progname, '/');
-=09if (basename =3D=3D NULL)
-=09=09basename =3D progname;
-=09else if (basename[1] !=3D '\0')
-=09=09basename++;
-
-=09subtype_opt =3D (char *) malloc(strlen(basename) + 64);
-=09if (subtype_opt =3D=3D NULL) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: memory allocation failed\n");
-=09=09return -1;
-=09}
-#ifdef __FreeBSD__
-=09sprintf(subtype_opt, "-ofsname=3D%s", basename);
-#else
-=09sprintf(subtype_opt, "-osubtype=3D%s", basename);
-#endif
-=09res =3D fuse_opt_add_arg(args, subtype_opt);
-=09free(subtype_opt);
-=09return res;
-}
-
 int fuse_parse_cmdline(struct fuse_args *args,
 =09=09       struct fuse_cmdline_opts *opts)
 {
@@ -210,14 +175,6 @@ int fuse_parse_cmdline(struct fuse_args *args,
 =09=09=09   fuse_helper_opt_proc) =3D=3D -1)
 =09=09return -1;
=20
-=09/* *Linux*: if neither -o subtype nor -o fsname are specified,
-=09   set subtype to program's basename.
-=09   *FreeBSD*: if fsname is not specified, set to program's
-=09   basename. */
-=09if (!opts->nodefault_subtype)
-=09=09if (add_default_subtype(args->argv[0], args) =3D=3D -1)
-=09=09=09return -1;
-
 =09return 0;
 }
=20
@@ -276,88 +233,6 @@ int fuse_daemonize(int foreground)
 =09return 0;
 }
=20
-int fuse_main_real(int argc, char *argv[], const struct fuse_operations *o=
p,
-=09=09   size_t op_size, void *user_data)
-{
-=09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
-=09struct fuse *fuse;
-=09struct fuse_cmdline_opts opts;
-=09int res;
-
-=09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
-=09=09return 1;
-
-=09if (opts.show_version) {
-=09=09printf("FUSE library version %s\n", PACKAGE_VERSION);
-=09=09fuse_lowlevel_version();
-=09=09res =3D 0;
-=09=09goto out1;
-=09}
-
-=09if (opts.show_help) {
-=09=09if(args.argv[0][0] !=3D '\0')
-=09=09=09printf("usage: %s [options] <mountpoint>\n\n",
-=09=09=09       args.argv[0]);
-=09=09printf("FUSE options:\n");
-=09=09fuse_cmdline_help();
-=09=09fuse_lib_help(&args);
-=09=09res =3D 0;
-=09=09goto out1;
-=09}
-
-=09if (!opts.show_help &&
-=09    !opts.mountpoint) {
-=09=09fuse_log(FUSE_LOG_ERR, "error: no mountpoint specified\n");
-=09=09res =3D 2;
-=09=09goto out1;
-=09}
-
-
-=09fuse =3D fuse_new_31(&args, op, op_size, user_data);
-=09if (fuse =3D=3D NULL) {
-=09=09res =3D 3;
-=09=09goto out1;
-=09}
-
-=09if (fuse_mount(fuse,opts.mountpoint) !=3D 0) {
-=09=09res =3D 4;
-=09=09goto out2;
-=09}
-
-=09if (fuse_daemonize(opts.foreground) !=3D 0) {
-=09=09res =3D 5;
-=09=09goto out3;
-=09}
-
-=09struct fuse_session *se =3D fuse_get_session(fuse);
-=09if (fuse_set_signal_handlers(se) !=3D 0) {
-=09=09res =3D 6;
-=09=09goto out3;
-=09}
-
-=09if (opts.singlethread)
-=09=09res =3D fuse_loop(fuse);
-=09else {
-=09=09struct fuse_loop_config loop_config;
-=09=09loop_config.clone_fd =3D opts.clone_fd;
-=09=09loop_config.max_idle_threads =3D opts.max_idle_threads;
-=09=09res =3D fuse_loop_mt_32(fuse, &loop_config);
-=09}
-=09if (res)
-=09=09res =3D 7;
-
-=09fuse_remove_signal_handlers(se);
-out3:
-=09fuse_unmount(fuse);
-out2:
-=09fuse_destroy(fuse);
-out1:
-=09free(opts.mountpoint);
-=09fuse_opt_free_args(&args);
-=09return res;
-}
-
-
 void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
 =09=09=09       struct fuse_conn_info *conn)
 {
@@ -420,21 +295,3 @@ struct fuse_conn_info_opts* fuse_parse_conn_info_opts(=
struct fuse_args *args)
 =09}
 =09return opts;
 }
-
-int fuse_open_channel(const char *mountpoint, const char* options)
-{
-=09struct mount_opts *opts =3D NULL;
-=09int fd =3D -1;
-=09const char *argv[] =3D { "", "-o", options };
-=09int argc =3D sizeof(argv) / sizeof(argv[0]);
-=09struct fuse_args args =3D FUSE_ARGS_INIT(argc, (char**) argv);
-
-=09opts =3D parse_mount_opts(&args);
-=09if (opts =3D=3D NULL)
-=09=09return -1;
-
-=09fd =3D fuse_kern_mount(mountpoint, opts);
-=09destroy_mount_opts(opts);
-
-=09return fd;
-}
diff --git a/tools/virtiofsd/passthrough_helpers.h b/tools/virtiofsd/passth=
rough_helpers.h
index 6b77c33600..7c5f561fbc 100644
--- a/tools/virtiofsd/passthrough_helpers.h
+++ b/tools/virtiofsd/passthrough_helpers.h
@@ -42,32 +42,6 @@ static int mknod_wrapper(int dirfd, const char *path, co=
nst char *link,
 =09=09res =3D symlinkat(link, dirfd, path);
 =09} else if (S_ISFIFO(mode)) {
 =09=09res =3D mkfifoat(dirfd, path, mode);
-#ifdef __FreeBSD__
-=09} else if (S_ISSOCK(mode)) {
-=09=09struct sockaddr_un su;
-=09=09int fd;
-
-=09=09if (strlen(path) >=3D sizeof(su.sun_path)) {
-=09=09=09errno =3D ENAMETOOLONG;
-=09=09=09return -1;
-=09=09}
-=09=09fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
-=09=09if (fd >=3D 0) {
-=09=09=09/*
-=09=09=09 * We must bind the socket to the underlying file
-=09=09=09 * system to create the socket file, even though
-=09=09=09 * we'll never listen on this socket.
-=09=09=09 */
-=09=09=09su.sun_family =3D AF_UNIX;
-=09=09=09strncpy(su.sun_path, path, sizeof(su.sun_path));
-=09=09=09res =3D bindat(dirfd, fd, (struct sockaddr*)&su,
-=09=09=09=09sizeof(su));
-=09=09=09if (res =3D=3D 0)
-=09=09=09=09close(fd);
-=09=09} else {
-=09=09=09res =3D -1;
-=09=09}
-#endif
 =09} else {
 =09=09res =3D mknodat(dirfd, path, mode, rdev);
 =09}
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e1a605691a..e5f7115bc1 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1240,7 +1240,6 @@ int main(int argc, char *argv[])
 =09=09ret =3D 0;
 =09=09goto err_out1;
 =09} else if (opts.show_version) {
-=09=09printf("FUSE library version %s\n", fuse_pkgversion());
 =09=09fuse_lowlevel_version();
 =09=09ret =3D 0;
 =09=09goto err_out1;
--=20
2.24.1


