Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895BF21929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895BF21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAucs-0003xW-8o
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAuaj-0001Pu-1I
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAuah-0002bl-OJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iAuah-0002bP-Go
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E42F10CC1E6;
 Thu, 19 Sep 2019 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.116.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 549E660872;
 Thu, 19 Sep 2019 11:27:04 +0000 (UTC)
Date: Thu, 19 Sep 2019 13:27:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <20190919112702.GC10163@localhost.localdomain>
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
 <156872148244.1757.2888672921697745021.stgit@pasha-Precision-3630-Tower>
 <20190918091831.GD5207@localhost.localdomain>
 <001201d56e02$9d88b5f0$d89a21d0$@ru>
 <20190918093305.GF5207@localhost.localdomain>
 <001401d56e04$b93c02a0$2bb407e0$@ru>
 <20190918094436.GG5207@localhost.localdomain>
 <001501d56e06$bbd7aa30$3386fe90$@ru>
 <20190919085302.GA10163@localhost.localdomain>
 <001901d56ec9$620ae260$2620a720$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901d56ec9$620ae260$2620a720$@ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 11:27:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [for-4.2 PATCH 3/6] replay: update docs for
 record/replay with block devices
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, quintela@redhat.com,
 ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.09.2019 um 11:05 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > >
> > > > However, global -snapshot is just a convenient shortcut for specifying
> > > > snapshot=on for all -drive arguments. So if -snapshot is incompatible
> > > > with replay, shouldn't manually marking all drives as snapshot=on be
> > > > incompatible as well?
> > > >
> > > > Maybe you're really interested in some specific drive not having
> > > > snapshot=on? But then it might be better to check that specific drive
> > > > instad of forbidding just the shortcut for setting it.
> > >
> > > -snapshot adds the flag for top-level drive, making driver operations
> > > dependent on temporary file structure.
> > >
> > > Moving this overlay beneath blkreplay driver makes drive operations
> > > deterministic for the top-level device.
> > 
> > So the real requirement is that blkreplay is the top-level node of any
> > guest device, right? And only because of this, you can't use -snapshot
> > (or snapshot=on on the blkreplay driver).
> > 
> > If we instead check e.g. in blk_insert_bs() or blk_attach_dev() that in
> > record/replay mode, the root node of the BlockBackend is blkreplay,
> > wouldn't we catch many more incorrect setups?
> 
> That sounds interesting.
> Will it help to check that every backend is connected to blkreplay?

Yes, it would return an error when you try to attach a non-blkreplay
node to a BlockBackend (and every guest device uses a BlockBackend).

Note that this restriction would currently make block jobs unavailable
on non-blkreplay nodes as they also use BlockBackends internally (though
this is going to change in the long run). I believe this restriction is
harmless and the typical replay use case doesn't involve any block jobs,
but if you do think it's a problem, blk_attach_dev() would be the place
that affects only devices.

> How then this check has to be done?

Only compile-tested, but maybe something like below?

Kevin

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..9fa72bea51 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -955,6 +955,7 @@ static inline BlockDriverState *backing_bs(BlockDriverState *bs)
 extern BlockDriver bdrv_file;
 extern BlockDriver bdrv_raw;
 extern BlockDriver bdrv_qcow2;
+extern BlockDriver bdrv_blkreplay;
 
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 2b7931b940..16a4f1df6a 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -126,7 +126,7 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
     return ret;
 }
 
-static BlockDriver bdrv_blkreplay = {
+BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
     .instance_size          = 0,
 
diff --git a/block/block-backend.c b/block/block-backend.c
index 1c605d5444..c57d3d9fdf 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -17,6 +17,7 @@
 #include "block/throttle-groups.h"
 #include "hw/qdev-core.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
@@ -808,6 +809,12 @@ void blk_remove_bs(BlockBackend *blk)
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
+
+    if (replay_mode != REPLAY_MODE_NONE && bs->drv != &bdrv_blkreplay) {
+        error_setg(errp, "Root node must be blkreplay");
+        return -ENOTSUP;
+    }
+
     bdrv_ref(bs);
     blk->root = bdrv_root_attach_child(bs, "root", &child_root, blk->ctx,
                                        blk->perm, blk->shared_perm, blk, errp);

