Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2521C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770C523697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770C523697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59Dg-00043B-2S
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yZ-00022j-BT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58yX-0006AC-Um
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yV-00065m-0e; Tue, 03 Sep 2019 09:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AFCF3086213;
 Tue,  3 Sep 2019 13:35:58 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7EA75DAAF;
 Tue,  3 Sep 2019 13:35:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:38 +0200
Message-Id: <20190903133553.6500-2-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 13:35:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 01/16] qemu-io: add pattern file for write
 command
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

The patch allows to provide a pattern file for write
command. There was no similar ability before.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-id: 20190820164616.4072-1-dplotnikov@virtuozzo.com
Reviewed-by: Eric Blake <eblake@redhat.com>
[mreitz: Keep optstring in alphabetical order]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 6 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 8904733961..d46fa166d3 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -350,6 +350,79 @@ static void qemu_io_free(void *p)
     qemu_vfree(p);
 }
=20
+/*
+ * qemu_io_alloc_from_file()
+ *
+ * Allocates the buffer and populates it with the content of the given f=
ile
+ * up to @len bytes. If the file length is less than @len, then the buff=
er
+ * is populated with the file content cyclically.
+ *
+ * @blk - the block backend where the buffer content is going to be writ=
ten to
+ * @len - the buffer length
+ * @file_name - the file to read the content from
+ *
+ * Returns: the buffer pointer on success
+ *          NULL on error
+ */
+static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
+                                     const char *file_name)
+{
+    char *buf, *buf_origin;
+    FILE *f =3D fopen(file_name, "r");
+    int pattern_len;
+
+    if (!f) {
+        perror(file_name);
+        return NULL;
+    }
+
+    if (qemuio_misalign) {
+        len +=3D MISALIGN_OFFSET;
+    }
+
+    buf_origin =3D buf =3D blk_blockalign(blk, len);
+
+    if (qemuio_misalign) {
+        buf_origin +=3D MISALIGN_OFFSET;
+        buf +=3D MISALIGN_OFFSET;
+        len -=3D MISALIGN_OFFSET;
+    }
+
+    pattern_len =3D fread(buf_origin, 1, len, f);
+
+    if (ferror(f)) {
+        perror(file_name);
+        goto error;
+    }
+
+    if (pattern_len =3D=3D 0) {
+        fprintf(stderr, "%s: file is empty\n", file_name);
+        goto error;
+    }
+
+    fclose(f);
+
+    if (len > pattern_len) {
+        len -=3D pattern_len;
+        buf +=3D pattern_len;
+
+        while (len > 0) {
+            size_t len_to_copy =3D MIN(pattern_len, len);
+
+            memcpy(buf, buf_origin, len_to_copy);
+
+            len -=3D len_to_copy;
+            buf +=3D len_to_copy;
+        }
+    }
+
+    return buf_origin;
+
+error:
+    qemu_io_free(buf_origin);
+    return NULL;
+}
+
 static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
 {
     uint64_t i;
@@ -948,6 +1021,7 @@ static void write_help(void)
 " -n, -- with -z, don't allow slow fallback\n"
 " -p, -- ignored for backwards compatibility\n"
 " -P, -- use different pattern to fill file\n"
+" -s, -- use a pattern file to fill the write buffer\n"
 " -C, -- report statistics in a machine parsable format\n"
 " -q, -- quiet mode, do not show I/O statistics\n"
 " -u, -- with -z, allow unmapping\n"
@@ -964,7 +1038,7 @@ static const cmdinfo_t write_cmd =3D {
     .perm       =3D BLK_PERM_WRITE,
     .argmin     =3D 2,
     .argmax     =3D -1,
-    .args       =3D "[-bcCfnquz] [-P pattern] off len",
+    .args       =3D "[-bcCfnquz] [-P pattern | -s source_file] off len",
     .oneline    =3D "writes a number of bytes at a specified offset",
     .help       =3D write_help,
 };
@@ -973,7 +1047,7 @@ static int write_f(BlockBackend *blk, int argc, char=
 **argv)
 {
     struct timespec t1, t2;
     bool Cflag =3D false, qflag =3D false, bflag =3D false;
-    bool Pflag =3D false, zflag =3D false, cflag =3D false;
+    bool Pflag =3D false, zflag =3D false, cflag =3D false, sflag =3D fa=
lse;
     int flags =3D 0;
     int c, cnt, ret;
     char *buf =3D NULL;
@@ -982,8 +1056,9 @@ static int write_f(BlockBackend *blk, int argc, char=
 **argv)
     /* Some compilers get confused and warn if this is not initialized. =
 */
     int64_t total =3D 0;
     int pattern =3D 0xcd;
+    const char *file_name =3D NULL;
=20
-    while ((c =3D getopt(argc, argv, "bcCfnpP:quz")) !=3D -1) {
+    while ((c =3D getopt(argc, argv, "bcCfnpP:qs:uz")) !=3D -1) {
         switch (c) {
         case 'b':
             bflag =3D true;
@@ -1013,6 +1088,10 @@ static int write_f(BlockBackend *blk, int argc, ch=
ar **argv)
         case 'q':
             qflag =3D true;
             break;
+        case 's':
+            sflag =3D true;
+            file_name =3D optarg;
+            break;
         case 'u':
             flags |=3D BDRV_REQ_MAY_UNMAP;
             break;
@@ -1050,8 +1129,9 @@ static int write_f(BlockBackend *blk, int argc, cha=
r **argv)
         return -EINVAL;
     }
=20
-    if (zflag && Pflag) {
-        printf("-z and -P cannot be specified at the same time\n");
+    if (zflag + Pflag + sflag > 1) {
+        printf("Only one of -z, -P, and -s "
+               "can be specified at the same time\n");
         return -EINVAL;
     }
=20
@@ -1087,7 +1167,14 @@ static int write_f(BlockBackend *blk, int argc, ch=
ar **argv)
     }
=20
     if (!zflag) {
-        buf =3D qemu_io_alloc(blk, count, pattern);
+        if (sflag) {
+            buf =3D qemu_io_alloc_from_file(blk, count, file_name);
+            if (!buf) {
+                return -EINVAL;
+            }
+        } else {
+            buf =3D qemu_io_alloc(blk, count, pattern);
+        }
     }
=20
     clock_gettime(CLOCK_MONOTONIC, &t1);
--=20
2.21.0


