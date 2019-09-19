Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F7C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A5721929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A5721929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAvHz-00016S-Sn
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 08:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAvGm-0008Q9-4b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAvGk-0002xe-Mv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:10:43 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54758)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAvGk-0002wM-BN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:10:42 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id BB86C54006B;
 Thu, 19 Sep 2019 15:10:39 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>
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
 <20190919112702.GC10163@localhost.localdomain>
In-Reply-To: <20190919112702.GC10163@localhost.localdomain>
Date: Thu, 19 Sep 2019 15:10:43 +0300
Message-ID: <001a01d56ee3$4354a530$c9fdef90$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVu3TCh99HaQPpZRl+PLQNFGURpMgABc84g
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
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

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 19.09.2019 um 11:05 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > >
> > > > > However, global -snapshot is just a convenient shortcut for specifying
> > > > > snapshot=on for all -drive arguments. So if -snapshot is incompatible
> > > > > with replay, shouldn't manually marking all drives as snapshot=on be
> > > > > incompatible as well?
> > > > >
> > > > > Maybe you're really interested in some specific drive not having
> > > > > snapshot=on? But then it might be better to check that specific drive
> > > > > instad of forbidding just the shortcut for setting it.
> > > >
> > > > -snapshot adds the flag for top-level drive, making driver operations
> > > > dependent on temporary file structure.
> > > >
> > > > Moving this overlay beneath blkreplay driver makes drive operations
> > > > deterministic for the top-level device.
> > >
> > > So the real requirement is that blkreplay is the top-level node of any
> > > guest device, right? And only because of this, you can't use -snapshot
> > > (or snapshot=on on the blkreplay driver).
> > >
> > > If we instead check e.g. in blk_insert_bs() or blk_attach_dev() that in
> > > record/replay mode, the root node of the BlockBackend is blkreplay,
> > > wouldn't we catch many more incorrect setups?
> >
> > That sounds interesting.
> > Will it help to check that every backend is connected to blkreplay?
> 
> Yes, it would return an error when you try to attach a non-blkreplay
> node to a BlockBackend (and every guest device uses a BlockBackend).
> 
> Note that this restriction would currently make block jobs unavailable
> on non-blkreplay nodes as they also use BlockBackends internally (though
> this is going to change in the long run). I believe this restriction is
> harmless and the typical replay use case doesn't involve any block jobs,
> but if you do think it's a problem, blk_attach_dev() would be the place
> that affects only devices.
> 
> > How then this check has to be done?
> 
> Only compile-tested, but maybe something like below?
> 
> Kevin
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 0422acdf1c..9fa72bea51 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -955,6 +955,7 @@ static inline BlockDriverState *backing_bs(BlockDriverState *bs)
>  extern BlockDriver bdrv_file;
>  extern BlockDriver bdrv_raw;
>  extern BlockDriver bdrv_qcow2;
> +extern BlockDriver bdrv_blkreplay;
> 
>  int coroutine_fn bdrv_co_preadv(BdrvChild *child,
>      int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
> diff --git a/block/blkreplay.c b/block/blkreplay.c
> index 2b7931b940..16a4f1df6a 100644
> --- a/block/blkreplay.c
> +++ b/block/blkreplay.c
> @@ -126,7 +126,7 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
>      return ret;
>  }
> 
> -static BlockDriver bdrv_blkreplay = {
> +BlockDriver bdrv_blkreplay = {
>      .format_name            = "blkreplay",
>      .instance_size          = 0,
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 1c605d5444..c57d3d9fdf 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -17,6 +17,7 @@
>  #include "block/throttle-groups.h"
>  #include "hw/qdev-core.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/replay.h"
>  #include "sysemu/runstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-block.h"
> @@ -808,6 +809,12 @@ void blk_remove_bs(BlockBackend *blk)
>  int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
>  {
>      ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
> +
> +    if (replay_mode != REPLAY_MODE_NONE && bs->drv != &bdrv_blkreplay) {
> +        error_setg(errp, "Root node must be blkreplay");
> +        return -ENOTSUP;
> +    }

I guess this is opposite direction - bs->drv is bdrv_file.
And we should check its parent.

> +
>      bdrv_ref(bs);
>      blk->root = bdrv_root_attach_child(bs, "root", &child_root, blk->ctx,
>                                         blk->perm, blk->shared_perm, blk, errp);

Pavel Dovgalyuk


