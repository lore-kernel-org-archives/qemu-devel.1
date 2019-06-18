Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC8C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A939920861
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A939920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9QL-0003gL-Uy
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hd9PC-0002jH-B7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hd9PA-0008VV-CI
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hd9P4-0008Rw-R9; Tue, 18 Jun 2019 04:23:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DDF9356CA;
 Tue, 18 Jun 2019 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B03F17AC0;
 Tue, 18 Jun 2019 08:23:30 +0000 (UTC)
Date: Tue, 18 Jun 2019 10:23:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190618082329.GD4296@localhost.localdomain>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
 <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
 <20190617120929.GF7397@linux.fritz.box>
 <cbec5fee-8c57-f929-28b0-e68e1992c757@redhat.com>
 <20190617132053.GI7397@linux.fritz.box>
 <25f4917f-8480-069f-4958-aa4a89113cdb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f4917f-8480-069f-4958-aa4a89113cdb@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 18 Jun 2019 08:23:37 +0000 (UTC)
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

Am 18.06.2019 um 09:38 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 17.06.2019 16:20, Kevin Wolf wrote:
> > Am 17.06.2019 um 15:09 hat Eric Blake geschrieben:
> >> On 6/17/19 7:09 AM, Kevin Wolf wrote:
> >>
> >>>>>
> >>>>> Hmm, don't you think that blk_co_pcache sends NBD_CMD_CACHE if called on nbd driver?
> >>>>> I didn't implement it. But may be I should..
> >>>>>
> >>>>> May aim was only to avoid extra allocation and unnecessary reads. But if we implement
> >>>>> full-featured io request, what should it do?
> >>>>>
> >>>>> On qcow2 with backing it should pull data from backing to top, like in copy-on-read.
> >>>>> And for nbd it will send NBD_CMD_CACHE?
> >>>>> These semantics seems different, but why not?
> >>>>>
> >>>>
> >>>> Any opinions here? Should I resend or could we use it as a first step,
> >>>> not touching external API but improving things a little bit?
> >>>
> >>> I'm not opposed to making only a first step now. The interface seems to
> >>> make sense to me; the only thing that I don't really like is the naming
> >>> both of the operation (blk_co_pcache) and of the flag (BDRV_REQ_CACHE)
> >>> because to me, "cache" doesn't mean "read, but ignore the result".
> >>>
> >>> The operation only results in something being cached if the block graph
> >>> is configured to cache things. And indeed, the most importatn use case
> >>> for the flag is not populating a cache, but triggering copy-on-read. So
> >>> I think calling this operation "cache" is misleading.
> >>>
> >>> Now, I don't have very good ideas for better names either. I guess
> >>> BDRV_REQ_NO_DATA could work, though it's not perfect. (Also, not sure if
> >>> a blk_co_preadv_no_read wrapper is even needed when you can just call
> >>> blk_co_preadv with the right flag.)
> >>>
> >>> I'm open for good naming ideas.
> >>
> >> Would 'prefetch' be a more useful name? The name NBD_CMD_CACHE was
> >> chosen in the NBD project, but we are not stuck to that name if we think
> >> something better makes more sense.
> > 
> > Whether 'prefetch' is entirely accurate really depends on the graph
> > configuration, too. But at least it gives me the right idea of "read
> > something, but don't return it yet", so yes, I think that would work for
> > me.
> 
> Do you mean BDRV_REQ_PREFETCH + blk_co_pprefetch, or only the flag?
> Hmm, doubled 'p' in blk_co_pprefetch looks strange, bit it should be
> here for consistency with other requests..

I think I would only do the flag because the wrapper is so trivial, but
this is a matter of taste. The kind of thing that is decided by whoever
writes the patch.

Kevin

