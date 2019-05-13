Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2671DC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC8D2146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC8D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAeL-0005gz-78
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:05:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQAbW-0003Xj-5d
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQAQ1-0002DW-EN
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:51:02 -0400
Received: from foss.arm.com ([217.140.101.70]:51746)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQAQ0-0002C2-2E; Mon, 13 May 2019 08:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AC4780D;
	Mon, 13 May 2019 05:50:58 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFAF83F6C4;
	Mon, 13 May 2019 05:50:56 -0700 (PDT)
Date: Mon, 13 May 2019 13:50:54 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190513125053.GH28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513111555.GC28398@e103592.cambridge.arm.com>
	<20190513123857.xjgwnkdlizdunlpz@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513123857.xjgwnkdlizdunlpz@kamzik.brq.redhat.com>
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
	"armbru@redhat.com" <armbru@redhat.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	Andrea Bolognani <abologna@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 01:38:57PM +0100, Andrew Jones wrote:
> On Mon, May 13, 2019 at 12:15:56PM +0100, Dave Martin wrote:
> > On Mon, May 13, 2019 at 10:32:46AM +0100, Andrea Bolognani wrote:
> > > On Sun, 2019-05-12 at 10:36 +0200, Andrew Jones wrote:

[...]

> > > > The QMP query returns a list of valid vq lists. For example, if
> > > > a guest can use vqs 1, 2, 3, and 4, then the following list will
> > > > be returned
> > > > 
> > > >  [ [ 1 ], [ 1, 2 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ]
> > > > 
> > > > Another example might be 1, 2, 4, as the architecture states 3
> > > > is optional. In that case the list would be
> > > > 
> > > >  [ [ 1 ], [ 1, 2 ], [ 1, 2, 4 ] ]
> > > 
> > > I think the proposed QMP command is problematic, because it reports
> > > the valid vector lengths for either KVM or TCG based on which
> > > accelerator is currently enabled: it should report all information
> > > at all times instead, similarly to how query-gic-capabilities does
> > > it.
> > 
> > I wonder if this is premature flexibility?
> > 
> > The size of these lists is going to get cumbersome if the architecture
> > is ever extended.  Even today, we might need over 100 items in this
> > (nested) list.  If this is to be presented to the user this will be
> > far from friendly, it could get much worse if the architecutre changes
> > in future to allow larger vectors or more flexible virtualisation.
> > 
> > Could we just have a list of supported vector lengths and a possibly
> > empty list of additional capabilities that describe what kinds of
> > flexibility are allowed?
> > 
> > So, for example, we might support vector lengths of 1, 2, 4 and 8
> > quadwords, with the the ability to clamp the max vector length the
> > guest sees: the kernel ABI guarantees that you can do this, even
> > if you can't disable/enable each individual vector length independently.
> > 
> > So, [ 1, 2, 4, 8 ] seems sufficient to describe this in a forwards
> > compatible way.
> > 
> > Some day, we might report { "independent", [ 1, 2, 4, 8, 16, 32, ... ] }
> > 
> > I'm guessing about the data representation here.
> > 
> 
> I think that could work, and something along those lines even crossed my
> mind. Let's see what libvirt folk say. I'm not overly concerned about
> user friendless here though, as users aren't running QMP commands and
> parsing json by hand too much.

One concern I have is that if the architecture ever supports masking out
vector lengths individually, the size of this description becomes
something like O(2^n) in the maximum vector length, instead of O(n^2).

That could be very painful to deal with...

Cheers
---Dave

