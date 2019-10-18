Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1FB21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1FB21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLR20-0004I1-3v
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iLR1B-0003TX-IK
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iLR1A-00008w-7Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:06:05 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35982)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iLR1A-00007E-0N
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:06:04 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id CC08854006A;
 Fri, 18 Oct 2019 15:05:59 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>
References: <20190919085302.GA10163@localhost.localdomain>
 <001901d56ec9$620ae260$2620a720$@ru>
 <20190919112702.GC10163@localhost.localdomain>
 <001a01d56ee3$4354a530$c9fdef90$@ru>
 <20190919130005.GF10163@localhost.localdomain>
 <002401d56f84$83900e40$8ab02ac0$@ru>
 <20190920100150.GD5458@localhost.localdomain>
 <001601d57380$002b3f20$0081bd60$@ru>
 <20191010152830.GF7616@localhost.localdomain>
 <002401d57ffa$927ffab0$b77ff010$@ru>
 <20191011091232.GB5158@localhost.localdomain>
In-Reply-To: <20191011091232.GB5158@localhost.localdomain>
Subject: RE: [for-4.2 PATCH 3/6] replay: update docs for record/replay with
 block devices
Date: Fri, 18 Oct 2019 15:06:04 +0300
Message-ID: <003901d585ac$6a9b9d30$3fd2d790$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWAFAsG4DMQIMibSh+u7ACUO6ZLxgFk/tLQ
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
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 11.10.2019 um 08:10 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 25.09.2019 um 11:02 hat Pavel Dovgalyuk geschrieben:
> > > > I started playing with -blockdev: added new blockdev for blkreplay and
> > > > constructed the following command line:
> > > >
> > > > -blockdev driver=file,filename=disk.img,node-name=hd0
> > > > -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr
> > > > -device virtio-blk-device,drive=hd0-rr
> > > >
> > > > However, I get an error: "Could not open 'disk.img': Permission denied"
> > > > Everything works when I use this file in '-drive' parameter.
> > > > What am I doing wrong?
> > >
> > > The reason why I didn't reply immediately is because I don't see
> > > anything wrong in the options you used.
> > >
> > > Just to confirm, do you still get the same error when you use only the
> > > first -blockdev option and no other options at all?
> >
> > Ok, I tried again and got different error, which was caused by incorrect
> > QAPI schema for blkreplay.
> > Now it seems ok, but I still can't boot.
> 
> Hm... Are you actually using a raw image? If not, you need the format
> driver, too, and would end up with something like:
> 
>  -blockdev driver=file,filename=disk.qcow2,node-name=hd0
>  -blockdev driver=qcow2,file=hd0,node-name=hd0-qcow2
>  -blockdev driver=blkreplay,file=hd0-qcow2,node-name=hd0-rr
>  -device virtio-blk-device,drive=hd0-rr
> 
> (The first two can be combined into a single option by using a syntax
> like file.driver=file,file.filename=disk.qcow2, but defining each node
> separately is a bit cleaner.)

Ok, this works.
Now I'm trying to check root of the nodes in blk_insert_bs.
This command line leads to 2 invocations of this function:
1. bs->drv is file
2. bs->drv is blkreplay

How then can we check "snapshot" node attachment?

Pavel Dovgalyuk


