Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF78C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4175A20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4175A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSebS-0007cH-5t
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:29:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSeab-0007Ij-9r
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSeaa-0006b2-9L
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSeaX-0006T5-PT; Mon, 20 May 2019 05:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34664307D85A;
	Mon, 20 May 2019 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C47B17594;
	Mon, 20 May 2019 09:27:39 +0000 (UTC)
Date: Mon, 20 May 2019 11:27:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190520092737.GA5699@localhost.localdomain>
References: <20190514201926.10407-1-jsnow@redhat.com>
	<72986b5d-0772-abfb-2c99-97470e8fd3da@virtuozzo.com>
	<ab26708f-9199-32da-29ac-3202ba2df0d5@redhat.com>
	<f68e1472-26be-aa15-b2e2-f96029c9ce97@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68e1472-26be-aa15-b2e2-f96029c9ce97@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 20 May 2019 09:27:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] migration/dirty-bitmaps:
 change bitmap enumeration method
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	aihua liang <aliang@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Juan Quintela <quintela@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.05.2019 um 12:22 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 16.05.2019 22:03, John Snow wrote:
> > On 5/16/19 6:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> >> But, on the other, hand, if we have implicitly-filtered node on target, we were doing wrong thing anyway,
> >> as dirty_bitmap_load_header don't skip implicit nodes.
> >>
> >>> +    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
> >>
> >> As I understand, difference with bdrv_next_node is that we don't skip unnamed nodes [...]
> >>
> > 
> > The difference is that we iterate over states that aren't roots of
> > trees; so not just unnamed nodes but rather intermediate nodes as well
> > as nodes not attached to a storage device.
> > 
> > bdrv_next says: `Iterates over all top-level BlockDriverStates, i.e.
> > BDSs that are owned by the monitor or attached to a BlockBackend`
> > 
> > So this loop is going to iterate over *everything*, not just top-level
> > nodes. This lets me skip the tree-crawling loop that didn't work quite
> > right.
> 
> I meant not bdrv_next but bdrv_next_node, which iterates through graph nodes..
> What is real difference between graph_bdrv_states and all_bdrv_states ?

I don't think there is any relevant difference any more since commit
15489c769b9 ('block: auto-generated node-names'). We can only see a
difference if a BDS was created, but never opened. This means either
that we are still in the process of opening an image or that we have a
bug somewhere.

Maybe we should remove graph_bdrv_states and replace all of its uses
with the more obviously correct all_bdrv_states (if we are sure that
all users aren't called between creating and opening a BDS).

> Node is inserted to graph_bdrv_states in bdrv_assign_node_name(), and to
> all_bdrv_states in bdrv_new().
> 
> Three calls to bdrv_new:
> 
> bdrv_new_open_driver, calls bdrv_new and then bdrv_open_driver, which calls bdrv_assign_node_name,
> and if it fails new created node is released.
> 
> bdrv_open_inherit
>     bdrv_new
>     ..
>     bdrv_open_common
>        bdrv_open_driver
>            bdrv_assign_node_name
> 
> 
> iscsi_co_create_opts
>     bdrv_new
> 
>     ... hmm.. looks like it a kind of temporary unnamed bs
> 
> So, now, I'm not sure. Possibly we'd better use bdrv_next_node().

I wonder if the iscsi one can't be replaced with bdrv_new_open_driver().
Manually building a half-opened BDS like it does currently looks
suspicious.

> Kevin introduced all_bdrv_states in 0f12264e7a4145 , to use in drain instead of
> bdrv_next... But I don't understand, why he didn't use graph_bdrv_states and
> corresponding bdrv_next_node(), which is only skips some temporary or under-constuction
> nodes..

I probably just didn't realise that graph_bdrv_states exists and is
effectively the same. I knew that all_bdrv_states contains what I want,
so I just wanted to access that.

But if anonymous BDSes did actually still exist, drain would want to
wait for those as well, so it's the more natural choice anyway.

Kevin

