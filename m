Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9725C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FB52083B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FB52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzUJ-0003qh-Hf
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39854)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlzT4-00077K-1b
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlzT1-0004ZY-Sy
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlzSz-0004UJ-DR; Fri, 12 Jul 2019 13:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7D26307845E;
 Fri, 12 Jul 2019 17:36:16 +0000 (UTC)
Received: from localhost (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 514035D71C;
 Fri, 12 Jul 2019 17:36:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 19:35:59 +0200
Message-Id: <20190712173600.14554-7-mreitz@redhat.com>
In-Reply-To: <20190712173600.14554-1-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 12 Jul 2019 17:36:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/7] iscsi: Drop iscsi_co_create_opts()
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
 block/iscsi.c | 56 ---------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 267f160bf6..0e5729d335 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2157,58 +2157,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDri=
verState *bs, int64_t offset,
     return 0;
 }
=20
-static int coroutine_fn iscsi_co_create_opts(const char *filename, QemuO=
pts *opts,
-                                             Error **errp)
-{
-    int ret =3D 0;
-    int64_t total_size =3D 0;
-    BlockDriverState *bs;
-    IscsiLun *iscsilun =3D NULL;
-    QDict *bs_options;
-    Error *local_err =3D NULL;
-
-    bs =3D bdrv_new();
-
-    /* Read out options */
-    total_size =3D DIV_ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SI=
ZE, 0),
-                              BDRV_SECTOR_SIZE);
-    bs->opaque =3D g_new0(struct IscsiLun, 1);
-    iscsilun =3D bs->opaque;
-
-    bs_options =3D qdict_new();
-    iscsi_parse_filename(filename, bs_options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret =3D -EINVAL;
-    } else {
-        ret =3D iscsi_open(bs, bs_options, 0, NULL);
-    }
-    qobject_unref(bs_options);
-
-    if (ret !=3D 0) {
-        goto out;
-    }
-    iscsi_detach_aio_context(bs);
-    if (iscsilun->type !=3D TYPE_DISK) {
-        ret =3D -ENODEV;
-        goto out;
-    }
-    if (bs->total_sectors < total_size) {
-        ret =3D -ENOSPC;
-        goto out;
-    }
-
-    ret =3D 0;
-out:
-    if (iscsilun->iscsi !=3D NULL) {
-        iscsi_destroy_context(iscsilun->iscsi);
-    }
-    g_free(bs->opaque);
-    bs->opaque =3D NULL;
-    bdrv_unref(bs);
-    return ret;
-}
-
 static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun =3D bs->opaque;
@@ -2479,8 +2427,6 @@ static BlockDriver bdrv_iscsi =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
-    .bdrv_co_create_opts    =3D iscsi_co_create_opts,
-    .create_opts            =3D &iscsi_create_opts,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache =3D iscsi_co_invalidate_cache,
@@ -2518,8 +2464,6 @@ static BlockDriver bdrv_iser =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
-    .bdrv_co_create_opts    =3D iscsi_co_create_opts,
-    .create_opts            =3D &iscsi_create_opts,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache  =3D iscsi_co_invalidate_cache,
--=20
2.21.0


