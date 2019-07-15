Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7122C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB96E20868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB96E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2Dy-0000F0-Du
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.rutland@arm.com>) id 1hn2Dm-0008Br-NP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.rutland@arm.com>) id 1hn2Dl-0005sc-Cp
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:44:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49940)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mark.rutland@arm.com>)
 id 1hn2Di-0005r2-UH; Mon, 15 Jul 2019 10:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D3C28;
 Mon, 15 Jul 2019 07:44:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 714D23F59C;
 Mon, 15 Jul 2019 07:44:48 -0700 (PDT)
Date: Mon, 15 Jul 2019 15:44:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: James Morse <james.morse@arm.com>
Message-ID: <20190715144446.GK56232@lakrids.cambridge.arm.com>
References: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
 <20190715134059.GJ2790@e103592.cambridge.arm.com>
 <20190715134848.GI56232@lakrids.cambridge.arm.com>
 <4daefb19-6c15-f82c-31e9-1ae035d45bd5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4daefb19-6c15-f82c-31e9-1ae035d45bd5@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [RFC] Add virtual SDEI support in qemu
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, qemu-arm@nongnu.org,
 Guoheyi <guoheyi@huawei.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 03:26:39PM +0100, James Morse wrote:
> On 15/07/2019 14:48, Mark Rutland wrote:
> > On Mon, Jul 15, 2019 at 02:41:00PM +0100, Dave Martin wrote:
> >> One option (suggested to me by James Morse) would be to allow userspace
> >> to disable in the in-kernel PSCI implementation and provide its own
> >> PSCI to the guest via SMC -- in which case userspace that wants to
> >> implement SDEI would have to implement PSCI as well.
> > 
> > I think this would be the best approach, since it puts userspace in
> > charge of everything.
> > 
> > However, this interacts poorly with FW-based mitigations that we
> > implement in hyp. I suspect we'd probably need a mechanism to delegate
> > that responsibility back to the kernel, and figure out if that has any
> > interaction with thigns that got punted to userspace...
> 
> This has come up before:
> https://lore.kernel.org/r/59C139D0.3040507@arm.com
> 
> I agree Qemu should opt-in to this, it needs to be a feature that is enabled.
> 
> I had an early version of something like this for testing SDEI before
> there was firmware available. The review feedback from Christoffer was
> that it should include HVC and SMC, their immediates, and shouldn't be
> tied to SMC-CC ranges.
> 
> I think this should be a catch-all as Heyi describes to deliver
> 'unhandled SMC/HVC' to user-space as hypercall exits. We should
> include the immediate in the struct.
> 
> We can allow Qemu to disable the in-kernel PSCI implementation, which
> would let it be done in user-space via this catch-all mechanism. (PSCI
> in user-space has come up on another thread recently). The in-kernel
> PSCI needs to be default-on for backwards compatibility.
> 
> As Mark points out, the piece that's left is the 'arch workaround'
> stuff. We always need to handle these in the kernel. I don't think
> these should be routed-back, they should be un-obtainable by
> user-space.

Sure; I meant that those should be handled in the kernel rather than
going to host userspace and back.

I was suggesting was that userspace would opt into taking ownership of
all HVC calls, then explicitly opt-in to the kernel handling specific
(sets of) calls.

There are probably issues with that, but I suspect defining "all
undandled calls" will be problematic otherwise.

Thanks,
Mark.

