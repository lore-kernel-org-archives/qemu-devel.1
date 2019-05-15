Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD23C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55C02084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55C02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQtKU-0000fc-L4
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:48:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQtJY-0000IL-F1
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQtJX-0004hz-GM
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:47:20 -0400
Received: from foss.arm.com ([217.140.101.70]:40576)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQtJV-0004d2-7f; Wed, 15 May 2019 08:47:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9914D374;
	Wed, 15 May 2019 05:47:15 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBC03F71E;
	Wed, 15 May 2019 05:47:13 -0700 (PDT)
Date: Wed, 15 May 2019 13:47:11 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190515124711.GS28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513123656.6iu7ebu7zucn5mxt@kamzik.brq.redhat.com>
	<e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
	<20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
	<1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
	<1cd94ba6-2bfa-645e-1034-dd05e8a77000@linaro.org>
	<a24b6d34b99835ea38b021896a57c7af8bf4747c.camel@redhat.com>
	<20190515111420.GR28398@e103592.cambridge.arm.com>
	<6ab7415d80419a7d9ac832b9194bf2d944696cd9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab7415d80419a7d9ac832b9194bf2d944696cd9.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	Andrew Jones <drjones@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 12:28:20PM +0100, Andrea Bolognani wrote:
> On Wed, 2019-05-15 at 12:14 +0100, Dave Martin wrote:
> > On Wed, May 15, 2019 at 09:03:58AM +0100, Andrea Bolognani wrote:
> > > On Tue, 2019-05-14 at 13:14 -0700, Richard Henderson wrote:
> > > > Why is =4 less user-friendly than =512?
> > > > 
> > > > I don't actually see "total bits in vector" as more user-friendly than "number
> > > > of quadwords" when it comes to non-powers-of-2 like =7 vs =896 or =13 vs =1664.
> > > 
> > > I would wager most people are intimately familiar with bits, bytes
> > > and multiples due to having to work with them daily. Quadwords, not
> > > so much.
> > 
> > Generally I tend to agree.  For kvmtool I leaned torward quadwords
> > purely because
> > 
> > 	16,32,48,64,80,96,112,128,144,160,176,192,208
> > 
> > is a big pain to type compared with
> > 
> > 	1,2,3,4,5,6,7,8,9,10,11,12,13
> > 
> > Even though I prefer to specify vector lengths in bytes everywhere else
> > in the Linux user API (precisely to avoid the confusion you object to).
> > 
> > This isn't finalised yet for kvmtool -- I need to rework the patches
> > and may not include it at all initially: kvmtool doesn't support
> > migration, which is the main usecase for being able to specify an exact
> > set of vector lengths AFAICT.
> > 
> > Since this is otherwise only useful for migration, experimentation or
> > machine-driven configuration, a bitmask
> > 
> > 	0x1fff
> > 
> > as some have suggested may well be a pragmatic alternative for kvmtool.
> 
> Just to be clear, I have suggested using bits (or bytes or megabytes
> depending on the exact value) only for the command-line-user-oriented
> sve-vl-max option, which would take a single value.
> 
> For interoperation with the management layer, on the other hand,
> using a bitmap is perfectly fine, and whether the values encoded
> within are expressed in quadwords or whatever other format is largely
> irrelevant, so long as it it's properly documented of course.

Seems fair.

Cheers
---Dave

