Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A95D20768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A95D20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMtw-0004Xp-GB
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqMsw-0003vZ-H7; Tue, 30 Jun 2020 16:29:42 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqMss-0000PM-NA; Tue, 30 Jun 2020 16:29:42 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 8533EBF676;
 Tue, 30 Jun 2020 20:29:33 +0000 (UTC)
Date: Tue, 30 Jun 2020 22:29:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
Message-ID: <20200630202754.bleks4kxagaflg7y@apples.localdomain>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630125932.GA553472@localhost.localdomain>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 16:29:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 30 12:59, Niklas Cassel wrote:
> On Tue, Jun 30, 2020 at 12:01:29PM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Hi all,
> 
> Hello Klaus,
> 

Hi Niklas,

> > 
> >   * the controller uses timers to autonomously finish zones (wrt. FRL)
> 
> AFAICT, Dmitry's patches does this as well.
> 

Hmm, yeah. Something is going on at least. It's not really clear to me
why it works or what is happening with that admin completion queue
timer, but I'll dig through it.

> > 
> > I've been on paternity leave for a month, so I havn't been around to
> > review Dmitry's patches, but I have started that process now. I would
> > also be happy to work with Dmitry & Friends on merging our versions to
> > get the best of both worlds if it makes sense.
> > 
> > This series and all preparatory patch sets (the ones I've been posting
> > yesterday and today) are available on my GitHub[2]. Unfortunately
> > Patchew got screwed up in the middle of me sending patches and it never
> > picked up v2 of "hw/block/nvme: support multiple namespaces" because it
> > was getting late and I made a mistake with the CC's. So my posted series
> > don't apply according to Patchew, but they actually do if you follow the
> > Based-on's (... or just grab [2]).
> > 
> > 
> >   [1]: Message-Id: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
> >   [2]: https://github.com/birkelund/qemu/tree/for-master/nvme
> > 
> > 
> > Based-on: <20200630043122.1307043-1-its@irrelevant.dk>
> > ("[PATCH 0/3] hw/block/nvme: bump to v1.4")
> 
> Is this the only patch series that this series depends on?
> 
> In the beginning of the cover letter, you mentioned
> "NVMe v1.4 mandatory support", "SGLs", "multiple namespaces",
> and "and mostly just overall clean up".
> 

No, its a string of series that all has a Based-on tag (that is, "[PATCH
0/3] hw/block/nvme: bump to v1.4" has another Based-on tag that points
to the dependency of that). The point was to have patchew nicely apply
everything, but it broke midway...

As Philippe pointed out, all of the patch sets are integrated in the
GitHub tree, applied to QEMU master.

> 
> I think that you have done a great job getting the NVMe
> driver out of a frankenstate, and made it compliant with
> a proper spec (NVMe 1.4).
> 
> I'm also a big fan of the refactoring so that the driver
> handles more than one namespace, and the new bus model.
> 

Well, thanks! :)

> I know that you first sent your
> "nvme: support NVMe v1.3d, SGLs and multiple namespaces"
> patch series July, last year.
> 
> Looking at your outstanding patch series on patchwork:
> https://patchwork.kernel.org/project/qemu-devel/list/?submitter=188679
> 
> (Feel free to correct me if I have misunderstood anything.)
> 
> I see that these are related to your patch series from July last year:
> hw/block/nvme: bump to v1.3
> hw/block/nvme: support scatter gather lists
> hw/block/nvme: support multiple namespaces
> hw/block/nvme: bump to v1.4
> 

Yeah this stuff has been around for a while so the history on patchwork
is a mess.

> 
> This patch series seems minor and could probably be merged immediately:
> hw/block/nvme: handle transient dma errors
> 

Sure, but it's nicer in combination with the previous series
("hw/block/nvme: AIO and address mapping refactoring"). What I /can/ do
is rip out "hw/block/nvme: allow multiple aios per command" as that
patch might require more time for reviews. The rest of that series are
clean ups and a couple of bug fixes.

> 
> This patch series looks a bit weird:
> hw/block/nvme: AIO and address mapping refactoring
> 
> Since it looks like a V1 post, and was first posted yesterday.
> However, 2 out of the 17 patches in are Acked-by: Keith.
> (Perhaps some of your previously posted patches was put inside
> this new patch series?)
> 

Yes that and reviewers requested a lot of separation, so basically the
patch set ballooned.

> 
> This patch series:
> hw/block/nvme: namespace types and zoned namespaces
> 
> Which was first posted today. Up until earlier today, we haven't seen
> any patches from you related to ZNS (only overall NVMe cleanups).
> Dmitry's ZNS patches have been on the list since 2020-06-16.
> 

Yeah, as I mentioned in my cover letter, I was on leave, so I wasn't
around for the big ZNS release day either. But, honestly, I think this
is irrelevant - code should be merged based on technical reasons (not
technicalities).

> 
> Just a friendly suggestion, how about:
> 
> 1) We get your
> 
> hw/block/nvme: bump to v1.3
> hw/block/nvme: support scatter gather lists
> hw/block/nvme: support multiple namespaces
> hw/block/nvme: bump to v1.4
> 
> patch series merged.
> 

Blowing my own horn here, but yeah, it seems like everyone would like to
see this merged.

> 2) We get Dmitry's patch series merged.
> 
> Shared 4:th) If there is any feature that you miss in Dmitry's patch series,
> perhaps you could send patches to add what you are missing.
>

Looks like the two version are pretty much on par in terms of features.

> Shared 4:th) Your other patch series:
> hw/block/nvme: AIO and address mapping refactoring could get merged.
> 

As stated above I think its only a single commit ("hw/block/nvme: allow
multiple aios per command") that is controversial in that series.

> 
> Please don't take this suggestion the wrong way, I'm simply trying
> to come up with a way to move forward from here.
> 

Absolutely - I totally get that you want to move forward with Dmitry's
series, but I'd like to finish my review before committing to anything.


Cheers,
Klaus

