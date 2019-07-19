Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0871AC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D544B2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D544B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTBe-0005Dy-Ii
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTB9-0003TV-JK
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTB7-0003Vv-8F
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTB4-0003TV-Ii; Fri, 19 Jul 2019 09:44:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBC793084295;
 Fri, 19 Jul 2019 13:44:01 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA1BD608A4;
 Fri, 19 Jul 2019 13:44:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:37 +0200
Message-Id: <20190719134345.23526-6-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 19 Jul 2019 13:44:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/13] block: Make bdrv_parent_drained_[^_]*()
 static
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

These functions are not used outside of block/io.c, there is no reason
why they should be globally available.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 18 ------------------
 block/io.c            |  8 ++++----
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index bff3317696..a81645e8a3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -600,15 +600,6 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeom=
etry *geo);
 void bdrv_io_plug(BlockDriverState *bs);
 void bdrv_io_unplug(BlockDriverState *bs);
=20
-/**
- * bdrv_parent_drained_begin:
- *
- * Begin a quiesced section of all users of @bs. This is part of
- * bdrv_drained_begin.
- */
-void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
-                               bool ignore_bds_parents);
-
 /**
  * bdrv_parent_drained_begin_single:
  *
@@ -624,15 +615,6 @@ void bdrv_parent_drained_begin_single(BdrvChild *c, =
bool poll);
  */
 void bdrv_parent_drained_end_single(BdrvChild *c);
=20
-/**
- * bdrv_parent_drained_end:
- *
- * End a quiesced section of all users of @bs. This is part of
- * bdrv_drained_end.
- */
-void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
-                             bool ignore_bds_parents);
-
 /**
  * bdrv_drain_poll:
  *
diff --git a/block/io.c b/block/io.c
index c42e18b068..b0b33174d3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,8 +42,8 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)=
;
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
=20
-void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
-                               bool ignore_bds_parents)
+static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *i=
gnore,
+                                      bool ignore_bds_parents)
 {
     BdrvChild *c, *next;
=20
@@ -64,8 +64,8 @@ void bdrv_parent_drained_end_single(BdrvChild *c)
     }
 }
=20
-void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
-                             bool ignore_bds_parents)
+static void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ign=
ore,
+                                    bool ignore_bds_parents)
 {
     BdrvChild *c, *next;
=20
--=20
2.20.1


