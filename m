Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1AC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4286F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4286F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgq5l-0003Cn-Ec
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgq3Y-0000w4-80
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgq3W-0003rW-UN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgq3Q-0003pa-Om; Fri, 28 Jun 2019 08:32:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6762C19DCB;
 Fri, 28 Jun 2019 12:32:34 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A70991A927;
 Fri, 28 Jun 2019 12:32:29 +0000 (UTC)
Date: Fri, 28 Jun 2019 14:32:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190628123228.GJ5179@dhcp-200-226.str.redhat.com>
References: <d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
 <20181213122039.GC5427@linux.fritz.box>
 <f2fcbcc2-5e0f-053d-f4c7-fe0f5f6092f0@virtuozzo.com>
 <20190313160412.GF5167@linux.fritz.box>
 <101bbf98-0456-5022-e117-fd6f693a8786@virtuozzo.com>
 <20190409100142.GC6610@localhost.localdomain>
 <20190621091656.GA9744@localhost.localdomain>
 <d2ad5561-1806-d885-350a-b43dd0fe4339@virtuozzo.com>
 <ce694324-a2fd-2f03-351a-e54bc05973f1@virtuozzo.com>
 <08004ed8-73ba-1f36-ff46-ba29aba02c66@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08004ed8-73ba-1f36-ff46-ba29aba02c66@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 28 Jun 2019 12:32:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.06.2019 um 10:46 hat Denis Plotnikov geschrieben:
> On 24.06.2019 12:46, Denis Plotnikov wrote:
> > On 21.06.2019 12:59, Vladimir Sementsov-Ogievskiy wrote:
> >> 21.06.2019 12:16, Kevin Wolf wrote:
> >>> Am 09.04.2019 um 12:01 hat Kevin Wolf geschrieben:
> >>>> Am 02.04.2019 um 10:35 hat Denis Plotnikov geschrieben:
> >>>>> On 13.03.2019 19:04, Kevin Wolf wrote:
> >>>>>> Am 14.12.2018 um 12:54 hat Denis Plotnikov geschrieben:
> >>>>>>> On 13.12.2018 15:20, Kevin Wolf wrote:
> >>>>>>>> Am 13.12.2018 um 12:07 hat Denis Plotnikov geschrieben:
> >>>>>>>>> Sounds it should be so, but it doesn't work that way and that's why:
> >>>>>>>>> when doing mirror we may resume postponed coroutines too early when the
> >>>>>>>>> underlying bs is protected from writing at and thus we encounter the
> >>>>>>>>> assert on a write request execution at bdrv_co_write_req_prepare when
> >>>>>>>>> resuming the postponed coroutines.
> >>>>>>>>>
> >>>>>>>>> The thing is that the bs is protected for writing before execution of
> >>>>>>>>> bdrv_replace_node at mirror_exit_common and bdrv_replace_node calls
> >>>>>>>>> bdrv_replace_child_noperm which, in turn, calls child->role->drained_end
> >>>>>>>>> where one of the callbacks is blk_root_drained_end which check
> >>>>>>>>> if(--blk->quiesce_counter == 0) and runs the postponed requests
> >>>>>>>>> (coroutines) if the coundition is true.
> >>>>>>>>
> >>>>>>>> Hm, so something is messed up with the drain sections in the mirror
> >>>>>>>> driver. We have:
> >>>>>>>>
> >>>>>>>>          bdrv_drained_begin(target_bs);
> >>>>>>>>          bdrv_replace_node(to_replace, target_bs, &local_err);
> >>>>>>>>          bdrv_drained_end(target_bs);
> >>>>>>>>
> >>>>>>>> Obviously, the intention was to keep the BlockBackend drained during
> >>>>>>>> bdrv_replace_node(). So how could blk->quiesce_counter ever get to 0
> >>>>>>>> inside bdrv_replace_node() when target_bs is drained?
> >>>>>>>>
> >>>>>>>> Looking at bdrv_replace_child_noperm(), it seems that the function has
> >>>>>>>> a bug: Even if old_bs and new_bs are both drained, the quiesce_counter
> >>>>>>>> for the parent reaches 0 for a moment because we call .drained_end for
> >>>>>>>> the old child first and .drained_begin for the new one later.
> >>>>>>>>
> >>>>>>>> So it seems the fix would be to reverse the order and first call
> >>>>>>>> .drained_begin for the new child and then .drained_end for the old
> >>>>>>>> child. Sounds like a good new testcase for tests/test-bdrv-drain.c, too.
> >>>>>>> Yes, it's true, but it's not enough...
> >>>>>>
> >>>>>> Did you ever implement the changes suggested so far, so that we could
> >>>>>> continue from there? Or should I try and come up with something myself?
> >>>>>
> >>>>> Sorry for the late reply...
> >>>>> Yes, I did ...
> >>>>
> >>>> If there are more question or problems, can you post the patches in
> >>>> their current shape (as an RFC) or a git URL so I can play with it a
> >>>> bit? If you could include a failing test case, too, that would be ideal.
> >>>
> >>> Denis? Please?
> >>>
> >>> We really should get this fixed and I would be willing to lend a hand,
> >>> but if you keep your patches secret, I can't really do so and would have
> >>> to duplicate your work.
> >>>
> >>> Also, please see my old answer from April below for the last problem you
> >>> had with implementing the correct approach.
> >>>
> >>> Kevin
> > 
> > Hi Kevin,
> > I'm sorry for not replying for so long. Please, give me some time (a day
> > or two) so I could refresh everything and send the current state of the
> > patches as well as the test case checking the issue
> 
> Hi Kevin,
> The current state of the patches is available at 
> https://github.com/denis-plotnikov/qemu/tree/postponed-request

Are you sure you pushed the correct version?

I don't see any of the things we discussed above in this branch, i.e.
using blk_root_drained_begin/end, fixing bdrv_replace_child_noperm(),
fixing the drain calls in mirror etc.

> I didn't manage to create an automatic reproducer but one of the patches 
> contains a step-by-step description of how to reproduce the problem.

Ok, I'll try whether I can reproduce this.

Kevin

