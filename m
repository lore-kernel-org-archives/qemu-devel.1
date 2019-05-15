Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B4BC04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D062189F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D062189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQrdr-0005Gq-C0
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:00:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQrc5-00048b-9z
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQrXt-00085a-7D
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:54:02 -0400
Received: from foss.arm.com ([217.140.101.70]:37182)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQrXt-00084F-09
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:54:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05FAD80D;
	Wed, 15 May 2019 03:53:59 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13893F703;
	Wed, 15 May 2019 03:53:57 -0700 (PDT)
Date: Wed, 15 May 2019 11:53:55 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190515105352.GP28398@e103592.cambridge.arm.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<87woit40wy.fsf@dusky.pond.sub.org>
	<20190515081520.nazchdnludojzfqe@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515081520.nazchdnludojzfqe@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
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
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	"imammedo@redhat.com" <imammedo@redhat.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 09:15:20AM +0100, Andrew Jones wrote:
> On Tue, May 14, 2019 at 03:32:13PM +0200, Markus Armbruster wrote:
> > Syntax that can support such growth would be nice.
> > 
> > To grow a single unsigned number, we can make it wider (but we don't
> > have infrastructure for numbers wider than 64 bits), or we can add more
> > numbers (but under what name?).
> > 
> > Dotted keys syntax could grow more easily, but it's rather awkward.
> > 
> > Looking more closely at your "[PATCH 11/13] target/arm/cpu64: max cpu:
> > Introduce sve-vls-map"... your syntax reflects your data structure:
> > property "sve-vls-map" is of type uint64_t, and interpreted as bit set.
> > This data type would have to grow, too.
> > 
> > We could make widen the integer property (but we don't have
> > infrastructure for integer properties wider than 64 bits), or we can
> > turn it into an array of integers (compatibility?), or we can add more
> > properties to hold the additional integers (yet another silly way to
> > represent a list/array of integers).
> > 
> > I'm not asking you to complicate things just to future-proof this.  Just
> > pause and think whether you can pick a data type that's similarly
> > convenient now, and easier to grow.
> > 
> > Then pick an external syntax for this data type.  You may have to pick a
> > reasonable compromise between ease of implementation and ease of use.
> 
> Widening the integer property sounds good to me. I just hadn't thought of
> it (implementation tunnel vision affecting my user interface design).
> Andrea also mentioned that as a possibility in a reply to the series. I
> think we can leave the property as a uint64_t right now and then, when/if
> it needs to expand past 64 bits we can change the property to a string
> and start parsing arbitrarily large integers from it. The internal state,
> 'uint64_t sve_vls_map' can easily be changed to a 'uint64_t sve_vls_map[]'
> at that point too. How's that sound?

Having an arbitrary-width integer should work.

It will suck a bit for the common case of sparse vector length support

	0x8000000000000000800000008000808b

(= [ 1, 2, 4, 8, 16, 32, 64, 128 ] quadwords)

Since lengths above 16 quadwords remain theoretical for now though it's
probably OK as a compromise, though.

The most human-compatible approach would be some kind of list
comprehension syntax, but it's hard to justify that adding a whole new
syntax is justified at this point.

[...]

Cheers
---Dave

