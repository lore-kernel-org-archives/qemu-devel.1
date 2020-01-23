Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB4DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222E724125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isPLmGLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222E724125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuc2N-0006Db-9X
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8X-0001hv-46
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8V-0004nn-LM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8V-0004nV-Gw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAFTnJHC/SGksZeqr6y3mNjfvS+Vyi9jHQDEwDo7RCg=;
 b=isPLmGLlFkAQR3sR/BjulkF0UAcD82X08ndcTdJuGWahhfKkMYoDIienQTz3yNE3u6v08+
 VVZ8kq8JSOb6Lox9A2vgR58LUVrknNnJqODbjouXEwPGms4EK6iagMW2K16OR+cxW+zUgC
 7+Nf/DBQmdsv74ONdt0AdhL+Ciq5v5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-2Gydy6jVNqe1zZL0sOj0eQ-1; Thu, 23 Jan 2020 06:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7CA618A6EC4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:58:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3531CB;
 Thu, 23 Jan 2020 11:58:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 008/111] virtiofsd: remove mountpoint dummy argument
Date: Thu, 23 Jan 2020 11:56:58 +0000
Message-Id: <20200123115841.138849-9-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2Gydy6jVNqe1zZL0sOj0eQ-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Classic FUSE file system daemons take a mountpoint argument but
virtiofsd exposes a vhost-user UNIX domain socket instead.  The
mountpoint argument is not used by virtiofsd but the user is still
required to pass a dummy argument on the command-line.

Remove the mountpoint argument to clean up the command-line.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c  |  2 +-
 tools/virtiofsd/fuse_lowlevel.h  |  4 +---
 tools/virtiofsd/helper.c         | 20 +++-----------------
 tools/virtiofsd/passthrough_ll.c | 12 ++----------
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 5c9cb52f2a..2f32c68161 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2455,7 +2455,7 @@ out1:
     return NULL;
 }
=20
-int fuse_session_mount(struct fuse_session *se, const char *mountpoint)
+int fuse_session_mount(struct fuse_session *se)
 {
     int fd;
=20
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index adb9054bb1..8d8909b35d 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1863,7 +1863,6 @@ struct fuse_cmdline_opts {
     int foreground;
     int debug;
     int nodefault_subtype;
-    char *mountpoint;
     int show_version;
     int show_help;
     unsigned int max_idle_threads;
@@ -1924,12 +1923,11 @@ struct fuse_session *fuse_session_new(struct fuse_a=
rgs *args,
 /**
  * Mount a FUSE file system.
  *
- * @param mountpoint the mount point path
  * @param se session object
  *
  * @return 0 on success, -1 on failure.
  **/
-int fuse_session_mount(struct fuse_session *se, const char *mountpoint);
+int fuse_session_mount(struct fuse_session *se);
=20
 /**
  * Enter a single threaded, blocking event loop.
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 5711dd2660..5e6f2051a7 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -140,27 +140,13 @@ void fuse_cmdline_help(void)
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
                                 struct fuse_args *outargs)
 {
+    (void)data;
     (void)outargs;
-    struct fuse_cmdline_opts *opts =3D data;
=20
     switch (key) {
     case FUSE_OPT_KEY_NONOPT:
-        if (!opts->mountpoint) {
-            if (fuse_mnt_parse_fuse_fd(arg) !=3D -1) {
-                return fuse_opt_add_opt(&opts->mountpoint, arg);
-            }
-
-            char mountpoint[PATH_MAX] =3D "";
-            if (realpath(arg, mountpoint) =3D=3D NULL) {
-                fuse_log(FUSE_LOG_ERR, "fuse: bad mount point `%s': %s\n",=
 arg,
-                         strerror(errno));
-                return -1;
-            }
-            return fuse_opt_add_opt(&opts->mountpoint, mountpoint);
-        } else {
-            fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
-            return -1;
-        }
+        fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
+        return -1;
=20
     default:
         /* Pass through unknown options */
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index c5850ef803..9377718d9d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1297,7 +1297,7 @@ int main(int argc, char *argv[])
         return 1;
     }
     if (opts.show_help) {
-        printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
+        printf("usage: %s [options]\n\n", argv[0]);
         fuse_cmdline_help();
         fuse_lowlevel_help();
         ret =3D 0;
@@ -1308,13 +1308,6 @@ int main(int argc, char *argv[])
         goto err_out1;
     }
=20
-    if (opts.mountpoint =3D=3D NULL) {
-        printf("usage: %s [options] <mountpoint>\n", argv[0]);
-        printf("       %s --help\n", argv[0]);
-        ret =3D 1;
-        goto err_out1;
-    }
-
     if (fuse_opt_parse(&args, &lo, lo_opts, NULL) =3D=3D -1) {
         return 1;
     }
@@ -1374,7 +1367,7 @@ int main(int argc, char *argv[])
         goto err_out2;
     }
=20
-    if (fuse_session_mount(se, opts.mountpoint) !=3D 0) {
+    if (fuse_session_mount(se) !=3D 0) {
         goto err_out3;
     }
=20
@@ -1393,7 +1386,6 @@ err_out3:
 err_out2:
     fuse_session_destroy(se);
 err_out1:
-    free(opts.mountpoint);
     fuse_opt_free_args(&args);
=20
     if (lo.root.fd >=3D 0) {
--=20
2.24.1


