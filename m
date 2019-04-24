Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29BBC282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 07:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6985A218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 07:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6985A218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJCPu-00070E-Bi
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 03:34:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hJCNy-0005o8-6W
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hJCBd-0002SX-WC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hJCBd-0002Lk-NM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CAC23098487;
	Wed, 24 Apr 2019 07:19:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-161.ams2.redhat.com [10.36.116.161])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB0D5C28D;
	Wed, 24 Apr 2019 07:19:18 +0000 (UTC)
Date: Wed, 24 Apr 2019 09:19:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190424071917.GA15891@linux.fritz.box>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
	<aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 24 Apr 2019 07:19:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Martin Kletzander <mkletzan@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Richard Jones <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424071917._NmjyiZI57waqkjKgnN9TWQ7W917o_LAU-miHJ0tikk@z>

Am 24.04.2019 um 08:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 23.04.2019 18:08, Kevin Wolf wrote:
> > Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
> >> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
> >>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
> >>>> Hi,
> >>>>
> >>>> I am using qemu-img with nbdkit to transfer a disk image and the update it with
> >>>> extra data from newer snapshots.  The end image cannot be transferred because
> >>>> the snapshots will be created later than the first transfer and we want to save
> >>>> some time up front.  You might think of it as a continuous synchronisation.  It
> >>>> looks something like this:
> >>>>
> >>>> I first transfer the whole image:
> >>>>
> >>>>   qemu-img convert -p $nbd disk.raw
> >>>>
> >>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=nbdkit.sock`
> >>>>
> >>>> Then, after the next snapshot is created, I can update it thanks to the `-n`
> >>>> parameter (the $nbd now points to the newer snapshot with unchanged data looking
> >>>> like holes in the file):
> >>>>
> >>>>   qemu-img convert -p -n $nbd disk.raw
> >>>>
> >>>> This is fast and efficient as it uses block status nbd extension, so it only
> >>>> transfers new data.
> >>>
> >>> This is an implementation detail. Don't rely on it. What you're doing is
> >>> abusing 'qemu-img convert', so problems like what you describe are to be
> >>> expected.
> >>>
> >>>> This can be done over and over again to keep the local
> >>>> `disk.raw` image up to date with the latest remote snapshot.
> >>>>
> >>>> However, when the guest OS zeroes some of the data and it gets written into the
> >>>> snapshot, qemu-img scans for those zeros and does not write them to the
> >>>> destination image.  Checking the output of `qemu-img map --output=json $nbd`
> >>>> shows that the zeroed data is properly marked as `data: true`.
> >>>>
> >>>> Using `-S 0` would write zeros even where the holes are, effectively overwriting
> >>>> the data from the last snapshot even though they should not be changed.
> >>>>
> >>>> Having gone through some workarounds I would like there to be another way.  I
> >>>> know this is far from the typical usage of qemu-img, but is this really the
> >>>> expected behaviour or is this just something nobody really needed before?  If it
> >>>> is the former, would it be possible to have a parameter that would control this
> >>>> behaviour?  If the latter is the case, can that behaviour be changed so that it
> >>>> properly replicates the data when `-n` parameter is used?
> >>>>
> >>>> Basically the only thing we need is to either:
> >>>>
> >>>> 1) write zeros where they actually are or
> >>>>
> >>>> 2) turn off explicit sparsification without requesting dense image (basically
> >>>>     sparsify only the par that is reported as hole on the source) or
> >>>>
> >>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did report data,
> >>>>     but qemu-img found they are all zeros (or source reported HOLE+ZERO which, I
> >>>>     believe, is effectively the same)
> >>>>
> >>>> If you want to try this out, I found the easiest reproducible way is using
> >>>> nbdkit's data plugin, which can simulate whatever source image you like.
> >>>
> >>> I think what you _really_ want is a commit block job. The problem is
> >>> just that you don't have a proper backing file chain, but just a bunch
> >>> of NBD connections.
> >>>
> >>> Can't you get an NBD connection that already provides the condensed form
> >>> of the whole snapshot chain directly at the source? If the NBD server
> >>> was QEMU, this would actually be easier than providing each snapshot
> >>> individually.
> >>>
> >>> If this isn't possible, I think you need to replicate the backing chain
> >>> on the destination instead of converting into the same image again and
> >>> again so that qemu-img knows that it must take existing data of the
> >>> backing file into consideration:
> >>>
> >>>     qemu-img convert -O qcow2 nbd://... base.qcow2
> >>>     qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1.qcow2
> >>>     qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... overlay2.qcow2
> >>>     ...
> 
> Is it safe in general?
> 
> Qemu often consider rounding-up allocated ranges to be safe, or just
> consider unknown area as allocated.  And if this happen, we'll convert
> unallocated hole to allocated zeroes on target, which will break
> backing chain.
> 
> This way would be correct if on source under nbd server we have valid
> backing chain too, so in case of "rounding-up" we'll just read valid
> data from backing. But it is not the case (or sorry, if I
> misunderstood).

As I said, it depends on the NBD server providing the right block
allocation status - and this includes alignment etc. as well.

It's not a very nice solution because NBD doesn't actually do backing
fields, so we're relying on things that the spec doesn't talk about. But
as I understand, we don't have control over the server side, so it's
probably the best we can do under these conditions.

If the NBD server already took the backing chain into consideration, it
would indeed be much more reliable.

Kevin

