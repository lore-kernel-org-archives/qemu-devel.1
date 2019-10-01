Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D7C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB95921783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB95921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFDQw-0005pu-Ux
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 04:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iFDQI-0005RM-Hf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iFDQH-00021S-5Z
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:22:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51130)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iFDQG-000207-Q7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:22:17 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id CC8A054006A;
 Tue,  1 Oct 2019 11:22:12 +0300 (MSK)
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
 <001601d57380$002b3f20$0081bd60$@ru>
In-Reply-To: <001601d57380$002b3f20$0081bd60$@ru>
Subject: RE: [for-4.2 PATCH 3/6] replay: update docs for record/replay with
 block devices
Date: Tue, 1 Oct 2019 11:22:13 +0300
Message-ID: <002801d57831$548dafc0$fda90f40$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVvmnB6TEN7ehgJSlyfueQu1o/pZwD5RGrwASxwtGA=
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin, can you give any hint on using blockdev through the command line?

Pavel Dovgalyuk


> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
> Sent: Wednesday, September 25, 2019 12:03 PM
> To: 'Kevin Wolf'
> Cc: qemu-devel@nongnu.org; peter.maydell@linaro.org; crosthwaite.peter@gmail.com;
> boost.lists@gmail.com; artem.k.pisarenko@gmail.com; quintela@redhat.com;
> ciro.santilli@gmail.com; jasowang@redhat.com; mst@redhat.com; armbru@redhat.com;
> mreitz@redhat.com; maria.klimushenkova@ispras.ru; kraxel@redhat.com; pavel.dovgaluk@ispras.ru;
> thomas.dullien@googlemail.com; pbonzini@redhat.com; alex.bennee@linaro.org;
> dgilbert@redhat.com; rth@twiddle.net
> Subject: RE: [for-4.2 PATCH 3/6] replay: update docs for record/replay with block devices
> 
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 20.09.2019 um 09:25 hat Pavel Dovgalyuk geschrieben:
> > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > Am 19.09.2019 um 14:10 hat Pavel Dovgalyuk geschrieben:
> > > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > > diff --git a/block/block-backend.c b/block/block-backend.c
> > > > > > index 1c605d5444..c57d3d9fdf 100644
> > > > > > --- a/block/block-backend.c
> > > > > > +++ b/block/block-backend.c
> > > > > > @@ -17,6 +17,7 @@
> > > > > >  #include "block/throttle-groups.h"
> > > > > >  #include "hw/qdev-core.h"
> > > > > >  #include "sysemu/blockdev.h"
> > > > > > +#include "sysemu/replay.h"
> > > > > >  #include "sysemu/runstate.h"
> > > > > >  #include "qapi/error.h"
> > > > > >  #include "qapi/qapi-events-block.h"
> > > > > > @@ -808,6 +809,12 @@ void blk_remove_bs(BlockBackend *blk)
> > > > > >  int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
> > > > > >  {
> > > > > >      ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
> > > > > > +
> > > > > > +    if (replay_mode != REPLAY_MODE_NONE && bs->drv != &bdrv_blkreplay) {
> > > > > > +        error_setg(errp, "Root node must be blkreplay");
> > > > > > +        return -ENOTSUP;
> > > > > > +    }
> > > > >
> > > > > I guess this is opposite direction - bs->drv is bdrv_file.
> > > > > And we should check its parent.
> > > >
> > > > If bs->drv is bdrv_file, you want this to fail because only
> > > > bdrv_blkreplay should be able to be attached to devices.
> > >
> > > There was a regular rr invocation (as described in docs).
> > > And bs->drv always was a pointer to bdrv_file: for original image,
> > > and for temporary snapshot.
> >
> > Hm, what was the actual command line you used? I can see that you have a
> > separate -drive for the qcow2 file, so I can see how you get an unused
> > BlockBackend for the qcow2 node, but I don't see how it would be a file
> > node.
> >
> > Anyway, this leaves us two options: Either change the recommended
> > command line to use -blockdev for the qcow2 file so that no BlockBackend
> > is created for it (I think this might be preferable), or restrict the
> > error to when the BlockBackend is used.
> 
> I started playing with -blockdev: added new blockdev for blkreplay and
> constructed the following command line:
> 
> -blockdev driver=file,filename=disk.img,node-name=hd0
> -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr
> -device virtio-blk-device,drive=hd0-rr
> 
> However, I get an error: "Could not open 'disk.img': Permission denied"
> Everything works when I use this file in '-drive' parameter.
> What am I doing wrong?
> 
> Pavel Dovgalyuk
> 



