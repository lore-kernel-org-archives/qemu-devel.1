Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E23C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DD020665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DD020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzTX-0000IS-Fa
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlzT0-0006tU-Uf
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlzSz-0004VE-Kv
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlzSx-0004RU-4C; Fri, 12 Jul 2019 13:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F95419CBD6;
 Fri, 12 Jul 2019 17:36:14 +0000 (UTC)
Received: from localhost (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E336013B;
 Fri, 12 Jul 2019 17:36:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 19:35:58 +0200
Message-Id: <20190712173600.14554-6-mreitz@redhat.com>
In-Reply-To: <20190712173600.14554-1-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 12 Jul 2019 17:36:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/7] file-posix: Drop hdev_co_create_opts()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generic fallback implementation effectively does the same.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 67 ----------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7ab4..65bd6d3333 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3325,67 +3325,6 @@ static coroutine_fn int hdev_co_pwrite_zeroes(Bloc=
kDriverState *bs,
     return raw_do_pwrite_zeroes(bs, offset, bytes, flags, true);
 }
=20
-static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOp=
ts *opts,
-                                            Error **errp)
-{
-    int fd;
-    int ret =3D 0;
-    struct stat stat_buf;
-    int64_t total_size =3D 0;
-    bool has_prefix;
-
-    /* This function is used by both protocol block drivers and therefor=
e either
-     * of these prefixes may be given.
-     * The return value has to be stored somewhere, otherwise this is an=
 error
-     * due to -Werror=3Dunused-value. */
-    has_prefix =3D
-        strstart(filename, "host_device:", &filename) ||
-        strstart(filename, "host_cdrom:" , &filename);
-
-    (void)has_prefix;
-
-    ret =3D raw_normalize_devicepath(&filename, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /* Read out options */
-    total_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, =
0),
-                          BDRV_SECTOR_SIZE);
-
-    fd =3D qemu_open(filename, O_WRONLY | O_BINARY);
-    if (fd < 0) {
-        ret =3D -errno;
-        error_setg_errno(errp, -ret, "Could not open device");
-        return ret;
-    }
-
-    if (fstat(fd, &stat_buf) < 0) {
-        ret =3D -errno;
-        error_setg_errno(errp, -ret, "Could not stat device");
-    } else if (!S_ISBLK(stat_buf.st_mode) && !S_ISCHR(stat_buf.st_mode))=
 {
-        error_setg(errp,
-                   "The given file is neither a block nor a character de=
vice");
-        ret =3D -ENODEV;
-    } else if (lseek(fd, 0, SEEK_END) < total_size) {
-        error_setg(errp, "Device is too small");
-        ret =3D -ENOSPC;
-    }
-
-    if (!ret && total_size) {
-        uint8_t buf[BDRV_SECTOR_SIZE] =3D { 0 };
-        int64_t zero_size =3D MIN(BDRV_SECTOR_SIZE, total_size);
-        if (lseek(fd, 0, SEEK_SET) =3D=3D -1) {
-            ret =3D -errno;
-        } else {
-            ret =3D qemu_write_full(fd, buf, zero_size);
-            ret =3D ret =3D=3D zero_size ? 0 : -errno;
-        }
-    }
-    qemu_close(fd);
-    return ret;
-}
-
 static BlockDriver bdrv_host_device =3D {
     .format_name        =3D "host_device",
     .protocol_name        =3D "host_device",
@@ -3398,8 +3337,6 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
-    .bdrv_co_create_opts =3D hdev_co_create_opts,
-    .create_opts         =3D &raw_create_opts,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes =3D hdev_co_pwrite_zeroes,
@@ -3525,8 +3462,6 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
-    .bdrv_co_create_opts =3D hdev_co_create_opts,
-    .create_opts         =3D &raw_create_opts,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
=20
@@ -3659,8 +3594,6 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
-    .bdrv_co_create_opts =3D hdev_co_create_opts,
-    .create_opts        =3D &raw_create_opts,
     .mutable_opts       =3D mutable_opts,
=20
     .bdrv_co_preadv         =3D raw_co_preadv,
--=20
2.21.0


