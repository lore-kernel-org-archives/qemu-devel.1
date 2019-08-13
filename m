Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A8C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162CD20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162CD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVUu-00012a-AT
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxVUO-0000ao-MJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxVUN-0001dP-EL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxVUK-0001br-Nz; Tue, 13 Aug 2019 08:01:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10C48307D930;
 Tue, 13 Aug 2019 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F007EEA0;
 Tue, 13 Aug 2019 12:01:14 +0000 (UTC)
Date: Tue, 13 Aug 2019 14:01:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190813120112.GH4663@localhost.localdomain>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <7fcab62a-ad7b-4105-7a23-76c46d8cee0f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcab62a-ad7b-4105-7a23-76c46d8cee0f@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 13 Aug 2019 12:01:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.08.2019 um 13:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 13.08.2019 14:04, Kevin Wolf wrote:
> > Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough to
> >> returned file. But is it correct behavior at all? If returned file
> >> itself has a backing file, we may report as totally unallocated and
> >> area which actually has data in bottom backing file.
> >>
> >> So, mirroring of qcow2 under raw-format is broken. Which is illustrated
> >> by following commit with a test. Let's make raw-format behave more
> >> correctly returning BDRV_BLOCK_DATA.
> >>
> >> Suggested-by: Max Reitz <mreitz@redhat.com>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > 
> > After some reading, I think I came to the conclusion that RAW is the
> > correct thing to do. There is indeed a problem, but this patch is trying
> > to fix it in the wrong place.
> > 
> > In the case where the backing file contains some data, and we have a
> > 'raw' node above the qcow2 overlay node, the content of the respective
> > block is not defined by the queried backing file layer, so it is
> > completely correct that bdrv_is_allocated() returns false, like it would
> > if you queried the qcow2 layer directly. If it returned true, we would
> > copy everything, which isn't right either (the test cases should may add
> > the qemu-img map output of the target so this becomes visible).
> > 
> > The problem is that we try to recurse along the backing chain, but we
> > fail to make the step from the raw node to the backing file.
> 
> I'd say, the problem is that we ignore backing chain of non-backing
> child

Yes, exactly. And I know even less about what happens if a child is
neither bs->file nor bs->backing. Imagine a qcow2 image with an external
data file that is a qcow2 image with a backing file itself. :-)

Actually, just having two qcow2 layers nested with bs->file probably
already fails.

> > Note that just extending Max's "deal with filters" is not enough to fix
> > this because raw doesn't actually meet all of the criteria for being a
> > filter in this sense (at least because the 'offset' option can change
> > offsets between raw and its child).
> > 
> > I think this is essentially a result of special-casing backing files
> > everywhere instead of treating them like children like any other.
> 
> But we need to special-case them, as we have interfaces operating on
> backing chain,

I'm not sure yet if this means that these interfaces are wrong, but it
might. But in any case, I think we depend on special-casing in more
places than we should.

> > bdrv_co_block_status_above() probably shouldn't recurse along the
> > backing chain, but along the returned *file pointers, and consider the
> > returned offset in *map.
> 
> So, you mean that in case of unallocated, format layer should return
> it's backing file as file?

Yes, because that's where it's reading the data from.

Hm... Now I wonder what this means for DATA... In theory it would have
to be set for backing files, but that would make it completely useless.
We can distinguish the cases by looking at *file, but how does the
generic block layer know which child should be counted as "allocated"
and which shouldn't?

> Then, maybe bdrv_co_block_status should not recurse at all?

Maybe. I think I need to draw a bit on the whiteboard before I can
really say anything. It would probably be a pretty fundamental change to
the model how block_status works.

Kevin

