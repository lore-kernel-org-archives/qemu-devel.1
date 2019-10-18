Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E14CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5A9222C6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5A9222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLT5g-0004HB-DN
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iLT3i-00030D-C4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iLT3h-000286-4b
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iLT3g-000260-ST
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:16:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06CA63D966;
 Fri, 18 Oct 2019 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F255C1B5;
 Fri, 18 Oct 2019 14:16:38 +0000 (UTC)
Date: Fri, 18 Oct 2019 16:16:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [for-4.2 PATCH 3/6] replay: update docs for record/replay with
 block devices
Message-ID: <20191018141637.GG6122@localhost.localdomain>
References: <20190919112702.GC10163@localhost.localdomain>
 <001a01d56ee3$4354a530$c9fdef90$@ru>
 <20190919130005.GF10163@localhost.localdomain>
 <002401d56f84$83900e40$8ab02ac0$@ru>
 <20190920100150.GD5458@localhost.localdomain>
 <001601d57380$002b3f20$0081bd60$@ru>
 <20191010152830.GF7616@localhost.localdomain>
 <002401d57ffa$927ffab0$b77ff010$@ru>
 <20191011091232.GB5158@localhost.localdomain>
 <003901d585ac$6a9b9d30$3fd2d790$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003901d585ac$6a9b9d30$3fd2d790$@ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 18 Oct 2019 14:16:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Am 18.10.2019 um 14:06 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 11.10.2019 um 08:10 hat Pavel Dovgalyuk geschrieben:
> > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > Am 25.09.2019 um 11:02 hat Pavel Dovgalyuk geschrieben:
> > > > > I started playing with -blockdev: added new blockdev for blkreplay and
> > > > > constructed the following command line:
> > > > >
> > > > > -blockdev driver=file,filename=disk.img,node-name=hd0
> > > > > -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr
> > > > > -device virtio-blk-device,drive=hd0-rr
> > > > >
> > > > > However, I get an error: "Could not open 'disk.img': Permission denied"
> > > > > Everything works when I use this file in '-drive' parameter.
> > > > > What am I doing wrong?
> > > >
> > > > The reason why I didn't reply immediately is because I don't see
> > > > anything wrong in the options you used.
> > > >
> > > > Just to confirm, do you still get the same error when you use only the
> > > > first -blockdev option and no other options at all?
> > >
> > > Ok, I tried again and got different error, which was caused by incorrect
> > > QAPI schema for blkreplay.
> > > Now it seems ok, but I still can't boot.
> > 
> > Hm... Are you actually using a raw image? If not, you need the format
> > driver, too, and would end up with something like:
> > 
> >  -blockdev driver=file,filename=disk.qcow2,node-name=hd0
> >  -blockdev driver=qcow2,file=hd0,node-name=hd0-qcow2
> >  -blockdev driver=blkreplay,file=hd0-qcow2,node-name=hd0-rr
> >  -device virtio-blk-device,drive=hd0-rr
> > 
> > (The first two can be combined into a single option by using a syntax
> > like file.driver=file,file.filename=disk.qcow2, but defining each node
> > separately is a bit cleaner.)
> 
> Ok, this works.
> Now I'm trying to check root of the nodes in blk_insert_bs.
> This command line leads to 2 invocations of this function:
> 1. bs->drv is file
> 2. bs->drv is blkreplay
> 
> How then can we check "snapshot" node attachment?

Ah, I see what's going on there... :-/

bdrv_open_inherit() creates an internal temporary BlockBackend for image
format probing. And it creates that BlockBackend even when we don't need
to do image probing because we already explicitly selected a driver. It
would be better if it didn't do that.

Kevin

