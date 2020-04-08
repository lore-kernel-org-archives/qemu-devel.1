Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B9C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEEE20747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEEE20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM8tt-0005J2-8f
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 07:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jM8tH-0004pY-Pk
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jM8tG-0007hR-Je
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:29:07 -0400
Received: from charlie.dont.surf ([128.199.63.193]:35624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jM8tD-0007fy-Sr; Wed, 08 Apr 2020 07:29:04 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 38EEABF5E2;
 Wed,  8 Apr 2020 11:29:02 +0000 (UTC)
Date: Wed, 8 Apr 2020 13:28:58 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 14/42] nvme: add missing mandatory features
Message-ID: <20200408112858.ui44sg7s6zbqydix@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-15-its@irrelevant.dk>
 <e589c8897067d387cae4b03dece27c60fa33041c.camel@redhat.com>
 <20200331054145.wh6olabpkzuw4iwb@apples.localdomain>
 <aa001f8b11a30b374e796694d743efb675e5dc25.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa001f8b11a30b374e796694d743efb675e5dc25.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mar 31 12:39, Maxim Levitsky wrote:
> On Tue, 2020-03-31 at 07:41 +0200, Klaus Birkelund Jensen wrote:
> > On Mar 25 12:41, Maxim Levitsky wrote:
> > > BTW the user of the device doesn't have to have 1:1 mapping between qid and msi interrupt index,
> > > in fact when MSI is not used, all the queues will map to the same vector, which will be interrupt 0
> > > from point of view of the device IMHO.
> > > So it kind of makes sense IMHO to have num_irqs or something, even if it technically equals to number of queues.
> > > 
> > 
> > Yeah, but the device will still *support* the N IVs, so they can still
> > be configured even though they will not be used. So I don't think we
> > need to introduce an additional parameter?
> 
> Yes and no.
> I wasn't thinking to add a new parameter for number of supporter interrupt vectors,
> but just to have an internal variable to represent it so that we could support in future
> case where these are not equal.
> 
> Also from point of view of validating the users of this virtual nvme drive, I think it kind
> of makes sense to allow having less supported IRQ vectors than IO queues, so to check
> how userspace copes with it. It is valid after all to have same interrupt vector shared between
> multiple queues.
> 

I see that this could be useful for testing, but I think we can defer
that to a later patch. Would you be okay with that for now?

> In fact in theory (but that would complicate the implementation greatly) we should even support
> case when number of submission queues is not equal to number of completion queues. Yes nobody does in real hardware,
> and at least Linux nvme driver hard assumes 1:1 SQ/CQ mapping but still.
> 

It is not the hardware that decides this and I believe that there
definitely are applications that chooses to associate multiple SQs with
a single CQ. The CQ is an attribute of the SQ and the IV of the CQ is
also specified in the create command. I believe this is already
supported.

> My nvme-mdev doesn't make this assumpiton (and neither any assumptions on interrupt vector counts) 
> and allows the user to have any SQ/CQ mapping as far as the spec allows
> (but it does hardcode maximum number of SQ/CQ supported)
> 
> BTW, I haven't looked at that but we should check that the virtual nvme drive can cope with using legacy
> interrupt (that is MSI disabled) - nvme-mdev does support this and was tested with it.
> 

Yes, this is definitely not very well tested.

If you insist on all of the above being implemented, then I will do it,
but I would rather defer this to later patches as this series is already
pretty large ;)

