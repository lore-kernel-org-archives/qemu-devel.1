Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCCC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 06:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972CA20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 06:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972CA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCHeK-0006Yv-Kq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 02:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iCHdc-00067J-A3
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iCHdb-0005DG-15
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:15:56 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47590)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iCHda-0005CH-Mr
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:15:54 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id DD6265400C4;
 Mon, 23 Sep 2019 09:15:50 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>
References: <20190918093305.GF5207@localhost.localdomain>
 <001401d56e04$b93c02a0$2bb407e0$@ru>
 <20190918094436.GG5207@localhost.localdomain>
 <001501d56e06$bbd7aa30$3386fe90$@ru>
 <20190919085302.GA10163@localhost.localdomain>
 <001901d56ec9$620ae260$2620a720$@ru>
 <20190919112702.GC10163@localhost.localdomain>
 <001a01d56ee3$4354a530$c9fdef90$@ru>
 <20190919130005.GF10163@localhost.localdomain>
 <002401d56f84$83900e40$8ab02ac0$@ru>
 <20190920100150.GD5458@localhost.localdomain>
In-Reply-To: <20190920100150.GD5458@localhost.localdomain>
Subject: RE: [for-4.2 PATCH 3/6] replay: update docs for record/replay with
 block devices
Date: Mon, 23 Sep 2019 09:15:51 +0300
Message-ID: <000d01d571d6$5977a150$0c66e3f0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVvmnB6TEN7ehgJSlyfueQu1o/pZwCOu/0g
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
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
> Am 20.09.2019 um 09:25 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 19.09.2019 um 14:10 hat Pavel Dovgalyuk geschrieben:
> > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > diff --git a/block/block-backend.c b/block/block-backend.c
> > > > > index 1c605d5444..c57d3d9fdf 100644
> > > > > --- a/block/block-backend.c
> > > > > +++ b/block/block-backend.c
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include "block/throttle-groups.h"
> > > > >  #include "hw/qdev-core.h"
> > > > >  #include "sysemu/blockdev.h"
> > > > > +#include "sysemu/replay.h"
> > > > >  #include "sysemu/runstate.h"
> > > > >  #include "qapi/error.h"
> > > > >  #include "qapi/qapi-events-block.h"
> > > > > @@ -808,6 +809,12 @@ void blk_remove_bs(BlockBackend *blk)
> > > > >  int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
> > > > >  {
> > > > >      ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
> > > > > +
> > > > > +    if (replay_mode != REPLAY_MODE_NONE && bs->drv != &bdrv_blkreplay) {
> > > > > +        error_setg(errp, "Root node must be blkreplay");
> > > > > +        return -ENOTSUP;
> > > > > +    }
> > > >
> > > > I guess this is opposite direction - bs->drv is bdrv_file.
> > > > And we should check its parent.
> > >
> > > If bs->drv is bdrv_file, you want this to fail because only
> > > bdrv_blkreplay should be able to be attached to devices.
> >
> > There was a regular rr invocation (as described in docs).
> > And bs->drv always was a pointer to bdrv_file: for original image,
> > and for temporary snapshot.
> 
> Hm, what was the actual command line you used? I can see that you have a
> separate -drive for the qcow2 file, so I can see how you get an unused
> BlockBackend for the qcow2 node, but I don't see how it would be a file
> node.

The command line was almost the same as in docs:

-drive file=disk.img,format=raw,snapshot,id=img-direct \
-drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
-device virtio-blk-device,drive=img-blkreplay \

I've got the following blk_insert_bs invocations:
1. bs=ptr1 bs->drv=&bdrv_file, bs->filename=disk.img
2. bs=ptr2 bs->drv=&bdrv_file, bs->filename=<tmp filename>
3. bs=ptr2 bs->drv=&bdrv_file, bs->filename=<tmp filename>
4. bs=ptr2 bs->drv=&bdrv_file, bs->filename=<tmp filename>
5. bs=ptr3 bs->drv=&bdrv_file, bs->filename=<tmp filename>

> Anyway, this leaves us two options: Either change the recommended
> command line to use -blockdev for the qcow2 file so that no BlockBackend
> is created for it (I think this might be preferable), or restrict the
> error to when the BlockBackend is used.
> 
> The second option would probably have to be done in blk_attach_dev().
> The problem with this is that the only expected error so far is that the
> BlockBackend is already attached to a different device. So if you return
> a new error there, you will have to touch its callers as well to have
> this error correctly passed to the user.

Pavel Dovgalyuk


