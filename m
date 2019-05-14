Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10C0205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10C0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa77-0007ir-UE
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:17:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hQZtq-0005n7-Te
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hQZtp-0001Jk-RI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:03:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>)
	id 1hQZtn-0001Hs-98; Tue, 14 May 2019 12:03:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2CAE81E0F;
	Tue, 14 May 2019 16:03:13 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E7912B9E4;
	Tue, 14 May 2019 16:03:10 +0000 (UTC)
Message-ID: <1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Date: Tue, 14 May 2019 18:03:09 +0200
In-Reply-To: <20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513123656.6iu7ebu7zucn5mxt@kamzik.brq.redhat.com>
	<e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
	<20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 14 May 2019 16:03:22 +0000 (UTC)
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

On Tue, 2019-05-14 at 14:53 +0200, Andrew Jones wrote:
> On Tue, May 14, 2019 at 02:29:51PM +0200, Andrea Bolognani wrote:
> > Since we expect management applications to use QMP to discover what
> > vector lengths are supported and then provide an explicit map, I
> > think it's fair to say that the ability to specify a single maximum
> > vector length is going to be exclusively used as a convenience for
> > command line users.
> > 
> > In that light, I think it would be reasonable for the usage to look
> > along the lines of
> > 
> >   -cpu host,sve-vl-map=0xd # machine-friendly variant
> >   -cpu max,sve-vl-max=512  # user-friendly variant
> 
> We already have sve-max-vq, so I'm not sure we want to rename it.

Oh, I didn't realize that was the case. And of course it already
takes a number of quadwords as argument, I suppose? That's pretty
unfortunate :(

Perhaps we could consider deprecating it in favor of a user-friendly
variant that's actually suitable for regular humans, like the one I
suggest above?

[...]
> > > Dave points out
> > > we may want to reduce the list to a single set and then add flags
> > > to indicate what can be done with it in order to derive other sets.
> > > What do you think about that?
> > 
> > So right now all that can be done is truncating the list by removing
> > an arbitrary number of elements from the end, right? Eg. if you have
> > [ 1, 2, 4 ] you can use either that or [ 1, 2 ] or [ 1 ]. But in the
> > future you might also be able to mask single elements in the middle
> > of the list, thus enabling things like [ 1, 4 ].
> > 
> > That doesn't sound very complicated to support in libvirt, though I
> > have to say that I'm not a big fan of this proposal because as far as
> > I can see it basically means implementing the very same logic twice,
> > once in QEMU and then once more in libvirt.
> 
> So if big tables of bits aren't a problem for QMP queries, then I'll
> just leave the design as it is.

I thought about it a bit more and perhaps the simplified design is
better after all.

Whatever the interface looks like on the QEMU side, we're going to
want to offer libvirt users two options for configuring vector
lengths: listing all desired vector lengths explicitly (basically
sev-vl-map but more verbose and readable) and providing just the
biggest desired vector length (like in sev-max-vq).

In the latter case, we'll want to expand the user-provided value
into an explicit list anyway in order to guarantee guest ABI
stability, and doing so when a single bitmap has been obtained via
QMP seems like it would be more manageable.

Sorry for the flip-flop, but after all isn't this exactly what
upstream design discussion is supposed to be all about? :)

[...]
> > If the size of the bitmap on the KVM side is 512 bits, why don't we
> > just make it that size on the QEMU side too from the start?
> 
> I'd still only want to input 64-bits on the command line, otherwise
> we get into inputting arrays, which isn't easy. KVM's interface is
> meant for expansion, but it won't be using most of those bits for
> quite some time either.

I'm probably missing something entirely obvious, but couldn't you
just have a single, possibly fairly massive (up to 128 hex digits if
I'm not mistaken) value on the command line and just work with that
one, no arrays necessary?

-- 
Andrea Bolognani / Red Hat / Virtualization


