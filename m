Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED62C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5494F20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5494F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqYb-0002ki-IF
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcqSM-00068S-SM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcqSL-0004B0-Lf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:09:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hcqSF-00044I-HS; Mon, 17 Jun 2019 08:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F28D030872F6;
 Mon, 17 Jun 2019 12:09:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 800175B2D5;
 Mon, 17 Jun 2019 12:09:30 +0000 (UTC)
Date: Mon, 17 Jun 2019 14:09:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190617120929.GF7397@linux.fritz.box>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
 <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 17 Jun 2019 12:09:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] block: blk_co_pcache
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.06.2019 um 13:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 06.06.2019 17:07, Vladimir Sementsov-Ogievskiy wrote:
> > 06.06.2019 16:55, Eric Blake wrote:
> >> On 6/6/19 8:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> >>> Hi all!
> >>>
> >>> Here is small new io API: blk_co_pcache, which does copy-on-read without
> >>> extra buffer for read data. This means that only parts that needs COR
> >>> will be actually read and only corresponding buffers allocated, no more.
> >>>
> >>> This allows to improve a bit block-stream and NBD_CMD_CACHE
> >>
> >> I'd really like to see qemu-io gain access to calling this command, so
> >> that we can add iotests coverage of this new feature. Note that the
> >> in-development libnbd
> >> (https://github.com/libguestfs/libnbd/commits/master) is also usable as
> >> an NBD client that can drive NBD_CMD_CACHE, although it's still new
> >> enough that we probably don't want to rely on it being available yet.
> >>
> > 
> > Hmm, don't you think that blk_co_pcache sends NBD_CMD_CACHE if called on nbd driver?
> > I didn't implement it. But may be I should..
> > 
> > May aim was only to avoid extra allocation and unnecessary reads. But if we implement
> > full-featured io request, what should it do?
> > 
> > On qcow2 with backing it should pull data from backing to top, like in copy-on-read.
> > And for nbd it will send NBD_CMD_CACHE?
> > These semantics seems different, but why not?
> > 
> 
> Any opinions here? Should I resend or could we use it as a first step,
> not touching external API but improving things a little bit?

I'm not opposed to making only a first step now. The interface seems to
make sense to me; the only thing that I don't really like is the naming
both of the operation (blk_co_pcache) and of the flag (BDRV_REQ_CACHE)
because to me, "cache" doesn't mean "read, but ignore the result".

The operation only results in something being cached if the block graph
is configured to cache things. And indeed, the most importatn use case
for the flag is not populating a cache, but triggering copy-on-read. So
I think calling this operation "cache" is misleading.

Now, I don't have very good ideas for better names either. I guess
BDRV_REQ_NO_DATA could work, though it's not perfect. (Also, not sure if
a blk_co_preadv_no_read wrapper is even needed when you can just call
blk_co_preadv with the right flag.)

I'm open for good naming ideas.

Kevin

