Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5958BC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C59B2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C59B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIr3z-0002yg-RI
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iIqyb-0005a6-6A
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iIqyZ-0006fa-Q7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iIqyZ-0006fR-Ga
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:12:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F02D10C092E;
 Fri, 11 Oct 2019 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40B4A196B2;
 Fri, 11 Oct 2019 09:12:34 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:12:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [for-4.2 PATCH 3/6] replay: update docs for record/replay with
 block devices
Message-ID: <20191011091232.GB5158@localhost.localdomain>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002401d57ffa$927ffab0$b77ff010$@ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 11 Oct 2019 09:12:42 +0000 (UTC)
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

Am 11.10.2019 um 08:10 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 25.09.2019 um 11:02 hat Pavel Dovgalyuk geschrieben:
> > > I started playing with -blockdev: added new blockdev for blkreplay and
> > > constructed the following command line:
> > >
> > > -blockdev driver=file,filename=disk.img,node-name=hd0
> > > -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr
> > > -device virtio-blk-device,drive=hd0-rr
> > >
> > > However, I get an error: "Could not open 'disk.img': Permission denied"
> > > Everything works when I use this file in '-drive' parameter.
> > > What am I doing wrong?
> > 
> > The reason why I didn't reply immediately is because I don't see
> > anything wrong in the options you used.
> > 
> > Just to confirm, do you still get the same error when you use only the
> > first -blockdev option and no other options at all?
> 
> Ok, I tried again and got different error, which was caused by incorrect
> QAPI schema for blkreplay.
> Now it seems ok, but I still can't boot.

Hm... Are you actually using a raw image? If not, you need the format
driver, too, and would end up with something like:

 -blockdev driver=file,filename=disk.qcow2,node-name=hd0
 -blockdev driver=qcow2,file=hd0,node-name=hd0-qcow2
 -blockdev driver=blkreplay,file=hd0-qcow2,node-name=hd0-rr
 -device virtio-blk-device,drive=hd0-rr

(The first two can be combined into a single option by using a syntax
like file.driver=file,file.filename=disk.qcow2, but defining each node
separately is a bit cleaner.)

> > I've now tried out the options you gave, and it does fail for me, but
> > with a different error:
> > 
> >     qemu-system-x86_64: -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr: Invalid
> > parameter 'blkreplay'
> > 
> > This one is because the QAPI schema doesn't know blkreplay and should
> > easily be fixed by adding a blkreplay field to BlockdevOptions.
> 
> Right, I added the following schema:
> 
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2832,8 +2832,8 @@
>  # Since: 2.9
>  ##
>  { 'enum': 'BlockdevDriver',
> -  'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
> -            'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
> +  'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
> +            'cloop', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
>              'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
>              'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
>              'qcow2', 'qed', 'quorum', 'raw', 'rbd',

Please add a '@blkreplay: Since 4.2' note to the comment, too.

> @@ -3446,6 +3446,18 @@
>    'data': { 'test': 'BlockdevRef',
>              'raw': 'BlockdevRef' } }
>  
> +##
> +# @BlockdevOptionsBlkreplay:
> +#
> +# Driver specific block device options for blkreplay.
> +#
> +# @image:     disk image which should be controlled with blkreplay
> +#
> +# Since: 4.2
> +##
> +{ 'struct': 'BlockdevOptionsBlkreplay',
> +  'data': { 'image': 'BlockdevRef' } }
> +
>  ##
>  # @QuorumReadPattern:
>  #
> @@ -3973,6 +3985,7 @@
>        'blkdebug':   'BlockdevOptionsBlkdebug',
>        'blklogwrites':'BlockdevOptionsBlklogwrites',
>        'blkverify':  'BlockdevOptionsBlkverify',
> +      'blkreplay':  'BlockdevOptionsBlkreplay',
>        'bochs':      'BlockdevOptionsGenericFormat',
>        'cloop':      'BlockdevOptionsGenericFormat',
>        'copy-on-read':'BlockdevOptionsGenericFormat',

Otherwise, this looks good to me. Can you turn it into a proper patch?

> > As soft freeze is coming closer, I'm considering taking this series as
> > it is (it's wrong in parts, but the old state is probably even more
> > wrong) and letting you fix up these checks on top. What do you think?
> 
> That sounds reasonable.

Okay, then that's what I will do.

Kevin

