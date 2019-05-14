Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D34C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDAC208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDAC208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWxB-0004OY-8x
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:54:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQWwD-00042Q-96
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQWwB-0007js-Tb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQWw7-0007Yl-DY; Tue, 14 May 2019 08:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A254308795B;
	Tue, 14 May 2019 12:53:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.205.198])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 449B910027CD;
	Tue, 14 May 2019 12:53:34 +0000 (UTC)
Date: Tue, 14 May 2019 14:53:29 +0200
From: Andrew Jones <drjones@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513123656.6iu7ebu7zucn5mxt@kamzik.brq.redhat.com>
	<e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 14 May 2019 12:53:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 02:29:51PM +0200, Andrea Bolognani wrote:
> On Mon, 2019-05-13 at 14:36 +0200, Andrew Jones wrote:
> > On Mon, May 13, 2019 at 11:32:46AM +0200, Andrea Bolognani wrote:
> > > On Sun, 2019-05-12 at 10:36 +0200, Andrew Jones wrote:
> > > [...]
> > > >    CPU type | accel | sve-max-vq | sve-vls-map
> > > >    -------------------------------------------
> > > >  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
> > > >  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
> > > >  3)    host | kvm   |  N/A       |  $VLS_MAP
> > > > 
> > > > Where for (1) $MAX_VQ sets the maximum vq and smaller vqs are
> > > > all supported when $VLS_MAP is zero, or when the vqs are selected
> > > > in $VLS_MAP.
> > > 
> > > I'm a bit confused by the nomenclature here. VL clearly stands for
> > > Vector Length, but what does VQ stand for? You seem to be using the
> > > two terms pretty much interchangeably throughout the cover letter.
> > 
> > As Dave pointed out, they're both lengths, but VQ specifically points
> > out that the unit is 'Q'uadwords. We could use VQS instead of VLS,
> > "Vector Lengths" sounds better.
> 
> Alright, it makes sense - once you've managed to figure out what
> exactly a "quadword" is, at least :)
> 
> Since we expect management applications to use QMP to discover what
> vector lengths are supported and then provide an explicit map, I
> think it's fair to say that the ability to specify a single maximum
> vector length is going to be exclusively used as a convenience for
> command line users.
> 
> In that light, I think it would be reasonable for the usage to look
> along the lines of
> 
>   -cpu host,sve-vl-map=0xd # machine-friendly variant
>   -cpu max,sve-vl-max=512  # user-friendly variant

We already have sve-max-vq, so I'm not sure we want to rename it.

> 
> with documentation clearly pointing out that the two options expect
> completely different formats - but that was the case even before,
> so we would have had to document that anyway.
> 
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
> > OK, and then with a flag stating which is when then.
> 
> Correct.
> 
> > Dave points out
> > we may want to reduce the list to a single set and then add flags
> > to indicate what can be done with it in order to derive other sets.
> > What do you think about that?
> 
> So right now all that can be done is truncating the list by removing
> an arbitrary number of elements from the end, right? Eg. if you have
> [ 1, 2, 4 ] you can use either that or [ 1, 2 ] or [ 1 ]. But in the
> future you might also be able to mask single elements in the middle
> of the list, thus enabling things like [ 1, 4 ].
> 
> That doesn't sound very complicated to support in libvirt, though I
> have to say that I'm not a big fan of this proposal because as far as
> I can see it basically means implementing the very same logic twice,
> once in QEMU and then once more in libvirt.

So if big tables of bits aren't a problem for QMP queries, then I'll
just leave the design as it is.

> 
> > > [...]
> > > > And now for what might be a bit more controversial; how we input
> > > > the valid vector set with sve-vls-map. Well, sve-vls-map is a
> > > > 64-bit bitmap, which is admittedly not user friendly and also not
> > > > the same size as KVM's vls bitmap (which is 8 64-bit words). Here's
> > > > the justification:
> > > > 
> > > >  1) We want to use the QEMU command line in order for the information
> > > >     to be migrated without needing to add more VM state.
> > > >  2) It's not easy/pretty to input arrays on the QEMU command line.
> > > >  3) We already need to use the QMP query to get a valid set, which
> > > >     isn't user friendly either, meaning we're already in libvirt
> > > >     territory.
> > > >  4) A 64-bit map (supporting up to 8192-bit vectors) is likely big
> > > >     enough for quite some time (currently KVM and TCG only support
> > > >     2048-bit vectors).
> > > >  5) If user friendliness is needed more than migratability then
> > > >     the 'max' cpu type can be used with the sve-max-vq property.
> > > >  6) It's possible to probe the full valid vector set from the
> > > >     command line by using something like sve-vls-map=0xffff and
> > > >     then, when it fails, the error message will state the correct
> > > >     map, e.g. 0xb.
> > > 
> > > I don't have a problem with having to use a bitmap internally,
> > > though libvirt will clearly want to expose a more approachable
> > > interface to users.
> > > 
> > > However, QMP reporting the information in the current format means
> > > we'd have to build an additional parser on top of the bitmap handling
> > > and conversion routines we'll clearly need to make this work; plus it
> > > just feels weird that the information reported by QMP can't be used
> > > on the command line without going through some tranformation first.
> > > 
> > > Wouldn't it make more sense to both accept and report bitmaps?
> > 
> > If we eventually need more than one word for the bitmap then it'll
> > require parsing and bitmap composition code in libvirt anyway. I
> > was thinking by pointing out each bit separately that we could
> > boundlessly grow the list without having to change anything in
> > libvirt later.
> 
> If the size of the bitmap on the KVM side is 512 bits, why don't we
> just make it that size on the QEMU side too from the start?

I'd still only want to input 64-bits on the command line, otherwise
we get into inputting arrays, which isn't easy. KVM's interface is
meant for expansion, but it won't be using most of those bits for
quite some time either.

Thanks,
drew

