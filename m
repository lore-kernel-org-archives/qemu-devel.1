Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B74C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ECB20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ECB20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijBO-0003pj-Kh
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jij99-0002Ml-VS; Tue, 09 Jun 2020 14:38:51 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jij97-0000K8-9e; Tue, 09 Jun 2020 14:38:51 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id ED4AFBF533;
 Tue,  9 Jun 2020 18:38:44 +0000 (UTC)
Date: Tue, 9 Jun 2020 20:38:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/1] hw/block/nvme: fix assert on invalid irq vector
Message-ID: <20200609183840.e4ja22t27bnizlvc@apples.localdomain>
References: <20200609094508.32412-1-its@irrelevant.dk>
 <b445a413-598f-23a2-f094-8b68c60722f5@redhat.com>
 <20200609114633.yvwtt6swb47l27yd@apples.localdomain>
 <20200609141425.GC11003@linux.fritz.box>
 <48537ee1-ed77-ffe6-66ba-d61838083069@redhat.com>
 <20200609153243.GE11003@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609153243.GE11003@linux.fritz.box>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 14:38:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun  9 17:32, Kevin Wolf wrote:
> Am 09.06.2020 um 16:18 hat Philippe Mathieu-DaudÃ© geschrieben:
> > On 6/9/20 4:14 PM, Kevin Wolf wrote:
> > > Am 09.06.2020 um 13:46 hat Klaus Jensen geschrieben:
> > >> On Jun  9 13:17, Philippe Mathieu-DaudÃÂ© wrote:
> > >>> On 6/9/20 11:45 AM, Klaus Jensen wrote:
> > >>>> From: Klaus Jensen <k.jensen@samsung.com>
> > >>>>
> > >>>> I goofed up with commit c09794fe40e3 ("hw/block/nvme: allow use of any
> > >>>> valid msix vector").
> > >>>
> > >>> Kevin, since your queue isn't merged, can you directly squash the fix?
> > >>
> > >> The commit (c09794fe40e3) can just be dropped without conflicts, but it
> > >> leaves a use of n->params.num_queues in nvme_create_cq() which commit
> > >> cde74bfd4b87 ("hw/block/nvme: add max_ioqpairs device parameter") must
> > >> fix.
> > > 
> > > Hm, so it seems this isn't easy to squash in without conflicts (and I
> > > would have to rewrite the whole commit message), so I think it's better
> > > to just apply the series on top.
> > > 
> > > One problem with the commit message is that it references commit IDs
> > > which aren't stable yet. Maybe it's best if I apply these patches,
> > > manually fix up the commit ID references and then immediately do a pull
> > > request so that they become stable.
> > 
> > This is the friendlier way.
> > 
> > Less friendly way is to drop Klaus's patches and ask him to respin.
> > While this is a valid outcome, if we can avoid it it will save all of us
> > review time.
> 
> If Klaus wants to do that, fine with me. I'm just trying to find the
> easiest solution for all of us.
> 

Sure, I can respin it. I would like to include this series as well
though since I think it's a nice addition.

I'll post a v7 that includes Philippes's return value verification patch
as well as the patches in this series. We should only need a review or
two on those patches then.

