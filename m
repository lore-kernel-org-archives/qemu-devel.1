Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64759C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3580920675
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3580920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34409 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEu6R-00044X-JP
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:12:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEu5a-0003h7-JL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEu5Y-0004Ua-B9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:11:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hEu5V-0004TI-0V; Fri, 12 Apr 2019 07:11:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B1C13087954;
	Fri, 12 Apr 2019 11:11:16 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EBA1E5C207;
	Fri, 12 Apr 2019 11:11:14 +0000 (UTC)
Date: Fri, 12 Apr 2019 13:11:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190412111113.GE4522@linux.fritz.box>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
	<4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
	<20190411141548.GE5694@linux.fritz.box>
	<1391b876-74ed-21f0-c41f-f2fb22d2eae7@virtuozzo.com>
	<20190411164803.GF5694@linux.fritz.box>
	<2558f6fa-03d5-9483-07ff-7ec0a4d37835@virtuozzo.com>
	<0b088cc0-6ea9-297d-6989-2d61e1c25075@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <0b088cc0-6ea9-297d-6989-2d61e1c25075@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 12 Apr 2019 11:11:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
 AioContext switch
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412111113.18Yro9Bo2y1RNljHxFXosvJrxku2ryyLzxdogUKfgtg@z>

Am 11.04.2019 um 19:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.04.2019 20:13, Vladimir Sementsov-Ogievskiy wrote:
> > 11.04.2019 19:48, Kevin Wolf wrote:
> >> Am 11.04.2019 um 16:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> 11.04.2019 17:15, Kevin Wolf wrote:
> >>>> Am 11.04.2019 um 15:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>>> 25.02.2019 18:19, Kevin Wolf wrote:
> >>>>>> bdrv_drain() must not leave connection_co scheduled, so bs->in_flight
> >>>>>> needs to be increased while the coroutine is waiting to be scheduled
> >>>>>> in the new AioContext after nbd_client_attach_aio_context().
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> I have some questions, could you explain, please?
> >>>>>
> >>>>> "bdrv_drain() must not leave connection_co scheduled" - it's because we want to be
> >>>>> sure that connection_co yielded from nbd_read_eof, yes?
> >>>>>
> >>>>> But it is guaranteed by aio_wait_bh_oneshot.. Why do we need additioinally inc/dec
> >>>>> bs->in_flight ?
> >>>>
> >>>> Without incrementing bs->in_flight, nothing would guarantee that
> >>>> aio_poll() is called and the BH is actually executed before bdrv_drain()
> >>>> returns.
> >>>
> >>> Don't follow.. Don't we want exactly this, we want BH to be executed while node is still
> >>> drained, as you write in comment?
> >>
> >> Yes, exactly. But if bs->in_flight == 0, the AIO_WAIT_WHILE() condition
> >> in the drain code could become false, so aio_poll() would not be called
> >> again and drain would return even if the BH is still pending.
> >>
> > 
> > Ah, oops, sorry my English, I read it like "nothing would prevent". Understand now, thanks.
> 
> Or not again.. We will not return to drain code, as we will loop in aio_wait_bh_oneshot,
> which will not return until BH handled

Oh, hm, good point, it's not just aio_bh_schedule_oneshot(), but the
waiting version.

I think I added the aio_wait_bh_oneshot() only later to address a review
comment, so maybe increasing bs->in_flight isn't needed any more now.

But it can't hurt at least...

Kevin

