Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED7AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBF02495A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7/CuETI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBF02495A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2Wz-0006yE-W6
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Ko-0000Qh-5F
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kh-0000PZ-El
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKvUyWgy6b6PvsF7ZmRM30cDr61HDcC2VNX4IfLQ29Q=;
 b=G7/CuETIYwRdBfCsr2k7zsvKPyh0lzXl4priWmj/ksvRpYAeIGimHUZA2N4wHU404IX1dj
 qzFXbfbLs28/SPj5mERO9esxGgzzluA8oFttNMZu0nmOUJ4imiB7oJUzWiz8Ui+3eZWISl
 wDzGrX1JFaicyYYE9RHEgVX6KoVfkVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-nxK4d-6BOMCWIdBhEgN-Kg-1; Fri, 08 May 2020 08:42:22 -0400
X-MC-Unique: nxK4d-6BOMCWIdBhEgN-Kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0FB19057A1;
 Fri,  8 May 2020 12:42:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB5A19167;
 Fri,  8 May 2020 12:42:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/30] block: Drop unused .bdrv_has_zero_init_truncate
Date: Fri,  8 May 2020 14:41:35 +0200
Message-Id: <20200508124135.252565-31-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Eric Blake <eblake@redhat.com>

Now that there are no clients of bdrv_has_zero_init_truncate, none of
the drivers need to worry about providing it.

What's more, this eliminates a source of some confusion: a literal
reading of the documentation as written in ceaca56f and implemented in
commit 1dcaf527 claims that a driver which returns 0 for
bdrv_has_zero_init_truncate() must not return 1 for
bdrv_has_zero_init(); this condition was violated for parallels, qcow,
and sometimes for vdi, although in practice it did not matter since
those drivers also lacked .bdrv_co_truncate.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200428202905.770727-10-eblake@redhat.com>
Acked-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  1 -
 include/block/block_int.h |  7 -------
 block.c                   | 21 ---------------------
 block/file-posix.c        |  1 -
 block/file-win32.c        |  1 -
 block/nfs.c               |  1 -
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 block/raw-format.c        |  6 ------
 block/rbd.c               |  1 -
 block/sheepdog.c          |  3 ---
 block/ssh.c               |  1 -
 12 files changed, 45 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8b62429aa4..4de8d8f8a6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -430,7 +430,6 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int=
64_t bytes);
 int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
-int bdrv_has_zero_init_truncate(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92335f33c7..df6d0273d6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -449,16 +449,9 @@ struct BlockDriver {
     /*
      * Returns 1 if newly created images are guaranteed to contain only
      * zeros, 0 otherwise.
-     * Must return 0 if .bdrv_has_zero_init_truncate() returns 0.
      */
     int (*bdrv_has_zero_init)(BlockDriverState *bs);
=20
-    /*
-     * Returns 1 if new areas added by growing the image with
-     * PREALLOC_MODE_OFF contain only zeros, 0 otherwise.
-     */
-    int (*bdrv_has_zero_init_truncate)(BlockDriverState *bs);
-
     /* Remove fd handlers, timers, and other event loop callbacks so the e=
vent
      * loop is no longer in use.  Called with no in-flight requests and in
      * depth-first traversal order with parents before child nodes.
diff --git a/block.c b/block.c
index cf5c19b1db..0653ccb913 100644
--- a/block.c
+++ b/block.c
@@ -5284,27 +5284,6 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     return 0;
 }
=20
-int bdrv_has_zero_init_truncate(BlockDriverState *bs)
-{
-    if (!bs->drv) {
-        return 0;
-    }
-
-    if (bs->backing) {
-        /* Depends on the backing image length, but better safe than sorry=
 */
-        return 0;
-    }
-    if (bs->drv->bdrv_has_zero_init_truncate) {
-        return bs->drv->bdrv_has_zero_init_truncate(bs);
-    }
-    if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init_truncate(bs->file->bs);
-    }
-
-    /* safe default */
-    return 0;
-}
-
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
 {
     BlockDriverInfo bdi;
diff --git a/block/file-posix.c b/block/file-posix.c
index 05e094be29..3ab8f5a0fa 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3100,7 +3100,6 @@ BlockDriver bdrv_file =3D {
     .bdrv_co_create =3D raw_co_create,
     .bdrv_co_create_opts =3D raw_co_create_opts,
     .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status =3D raw_co_block_status,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes =3D raw_co_pwrite_zeroes,
diff --git a/block/file-win32.c b/block/file-win32.c
index fa569685d8..221aaf713e 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -641,7 +641,6 @@ BlockDriver bdrv_file =3D {
     .bdrv_close         =3D raw_close,
     .bdrv_co_create_opts =3D raw_co_create_opts,
     .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
=20
     .bdrv_aio_preadv    =3D raw_aio_preadv,
     .bdrv_aio_pwritev   =3D raw_aio_pwritev,
diff --git a/block/nfs.c b/block/nfs.c
index 76daa7c9f6..b1718d125a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -872,7 +872,6 @@ static BlockDriver bdrv_nfs =3D {
     .create_opts                    =3D &nfs_create_opts,
=20
     .bdrv_has_zero_init             =3D nfs_has_zero_init,
-    .bdrv_has_zero_init_truncate    =3D nfs_has_zero_init,
     .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
     .bdrv_co_truncate               =3D nfs_file_co_truncate,
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 11903fb547..1ad95ff048 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5621,7 +5621,6 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_co_create_opts  =3D qcow2_co_create_opts,
     .bdrv_co_create       =3D qcow2_co_create,
     .bdrv_has_zero_init   =3D qcow2_has_zero_init,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status =3D qcow2_co_block_status,
=20
     .bdrv_co_preadv_part    =3D qcow2_co_preadv_part,
diff --git a/block/qed.c b/block/qed.c
index fb609cfba1..5da9726518 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1675,7 +1675,6 @@ static BlockDriver bdrv_qed =3D {
     .bdrv_co_create           =3D bdrv_qed_co_create,
     .bdrv_co_create_opts      =3D bdrv_qed_co_create_opts,
     .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status     =3D bdrv_qed_co_block_status,
     .bdrv_co_readv            =3D bdrv_qed_co_readv,
     .bdrv_co_writev           =3D bdrv_qed_co_writev,
diff --git a/block/raw-format.c b/block/raw-format.c
index 351f2d91c6..9108e43696 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -414,11 +414,6 @@ static int raw_has_zero_init(BlockDriverState *bs)
     return bdrv_has_zero_init(bs->file->bs);
 }
=20
-static int raw_has_zero_init_truncate(BlockDriverState *bs)
-{
-    return bdrv_has_zero_init_truncate(bs->file->bs);
-}
-
 static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
                                            const char *filename,
                                            QemuOpts *opts,
@@ -582,7 +577,6 @@ BlockDriver bdrv_raw =3D {
     .bdrv_co_ioctl        =3D &raw_co_ioctl,
     .create_opts          =3D &raw_create_opts,
     .bdrv_has_zero_init   =3D &raw_has_zero_init,
-    .bdrv_has_zero_init_truncate =3D &raw_has_zero_init_truncate,
     .strong_runtime_opts  =3D raw_strong_runtime_opts,
     .mutable_opts         =3D mutable_opts,
 };
diff --git a/block/rbd.c b/block/rbd.c
index 331c45adb2..617553b022 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1313,7 +1313,6 @@ static BlockDriver bdrv_rbd =3D {
     .bdrv_co_create         =3D qemu_rbd_co_create,
     .bdrv_co_create_opts    =3D qemu_rbd_co_create_opts,
     .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_get_info          =3D qemu_rbd_getinfo,
     .create_opts            =3D &qemu_rbd_create_opts,
     .bdrv_getlength         =3D qemu_rbd_getlength,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 739e6dee30..27a30d17f4 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3226,7 +3226,6 @@ static BlockDriver bdrv_sheepdog =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
@@ -3265,7 +3264,6 @@ static BlockDriver bdrv_sheepdog_tcp =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
@@ -3304,7 +3302,6 @@ static BlockDriver bdrv_sheepdog_unix =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
diff --git a/block/ssh.c b/block/ssh.c
index f9e08a4900..098dbe03c1 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1397,7 +1397,6 @@ static BlockDriver bdrv_ssh =3D {
     .bdrv_co_create_opts          =3D ssh_co_create_opts,
     .bdrv_close                   =3D ssh_close,
     .bdrv_has_zero_init           =3D ssh_has_zero_init,
-    .bdrv_has_zero_init_truncate  =3D ssh_has_zero_init,
     .bdrv_co_readv                =3D ssh_co_readv,
     .bdrv_co_writev               =3D ssh_co_writev,
     .bdrv_getlength               =3D ssh_getlength,
--=20
2.25.3


