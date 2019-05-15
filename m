Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC7BC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FE021783
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FE021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQrj7-0000fk-PT
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:05:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQrda-0005Nc-GT
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQrdZ-0007Kq-DH
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQrdZ-0007Gx-54
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 622E519D003;
	Wed, 15 May 2019 10:59:52 +0000 (UTC)
Received: from work-vm (ovpn-117-193.ams2.redhat.com [10.36.117.193])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 959C95D737;
	Wed, 15 May 2019 10:59:46 +0000 (UTC)
Date: Wed, 15 May 2019 11:59:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190515105943.GF2668@work-vm>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<87woit40wy.fsf@dusky.pond.sub.org>
	<20190515081520.nazchdnludojzfqe@kamzik.brq.redhat.com>
	<20190515105352.GP28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515105352.GP28398@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 15 May 2019 10:59:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	Andrew Jones <drjones@redhat.com>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dave Martin (Dave.Martin@arm.com) wrote:
> On Wed, May 15, 2019 at 09:15:20AM +0100, Andrew Jones wrote:
> > On Tue, May 14, 2019 at 03:32:13PM +0200, Markus Armbruster wrote:
> > > Syntax that can support such growth would be nice.
> > > 
> > > To grow a single unsigned number, we can make it wider (but we don't
> > > have infrastructure for numbers wider than 64 bits), or we can add more
> > > numbers (but under what name?).
> > > 
> > > Dotted keys syntax could grow more easily, but it's rather awkward.
> > > 
> > > Looking more closely at your "[PATCH 11/13] target/arm/cpu64: max cpu:
> > > Introduce sve-vls-map"... your syntax reflects your data structure:
> > > property "sve-vls-map" is of type uint64_t, and interpreted as bit set.
> > > This data type would have to grow, too.
> > > 
> > > We could make widen the integer property (but we don't have
> > > infrastructure for integer properties wider than 64 bits), or we can
> > > turn it into an array of integers (compatibility?), or we can add more
> > > properties to hold the additional integers (yet another silly way to
> > > represent a list/array of integers).
> > > 
> > > I'm not asking you to complicate things just to future-proof this.  Just
> > > pause and think whether you can pick a data type that's similarly
> > > convenient now, and easier to grow.
> > > 
> > > Then pick an external syntax for this data type.  You may have to pick a
> > > reasonable compromise between ease of implementation and ease of use.
> > 
> > Widening the integer property sounds good to me. I just hadn't thought of
> > it (implementation tunnel vision affecting my user interface design).
> > Andrea also mentioned that as a possibility in a reply to the series. I
> > think we can leave the property as a uint64_t right now and then, when/if
> > it needs to expand past 64 bits we can change the property to a string
> > and start parsing arbitrarily large integers from it. The internal state,
> > 'uint64_t sve_vls_map' can easily be changed to a 'uint64_t sve_vls_map[]'
> > at that point too. How's that sound?
> 
> Having an arbitrary-width integer should work.
> 
> It will suck a bit for the common case of sparse vector length support
> 
> 	0x8000000000000000800000008000808b
> 
> (= [ 1, 2, 4, 8, 16, 32, 64, 128 ] quadwords)

You could allow _'s as a readability feature just to allow you to see
boundaries.

	0x8000_0000_0000_0000_8000_0000_8000_808b

(Some might suggest IPv6 address syntax but I could never read that).

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

