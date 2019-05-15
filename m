Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D5C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B8820881
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B8820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQq1Y-0001R9-MU
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 05:16:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQq0a-000129-2E
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQq0Z-0006Wg-2B
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:15:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQq0W-0006Pf-GC; Wed, 15 May 2019 05:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBD3F8552E;
	Wed, 15 May 2019 09:15:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13BD910021B2;
	Wed, 15 May 2019 09:15:24 +0000 (UTC)
Date: Wed, 15 May 2019 11:15:22 +0200
From: Andrew Jones <drjones@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190515091522.xomdryr24oc7qki5@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513123656.6iu7ebu7zucn5mxt@kamzik.brq.redhat.com>
	<e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
	<20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
	<1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 15 May 2019 09:15:27 +0000 (UTC)
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

On Tue, May 14, 2019 at 06:03:09PM +0200, Andrea Bolognani wrote:
> I thought about it a bit more and perhaps the simplified design is
> better after all.
> 
> Whatever the interface looks like on the QEMU side, we're going to
> want to offer libvirt users two options for configuring vector
> lengths: listing all desired vector lengths explicitly (basically
> sev-vl-map but more verbose and readable) and providing just the
> biggest desired vector length (like in sev-max-vq).
> 
> In the latter case, we'll want to expand the user-provided value
> into an explicit list anyway in order to guarantee guest ABI
> stability, and doing so when a single bitmap has been obtained via
> QMP seems like it would be more manageable.
> 
> Sorry for the flip-flop, but after all isn't this exactly what
> upstream design discussion is supposed to be all about? :)

Yup, no problem. I'm actually liking the idea of the single map plus
flags. We won't need two implementations (QEMU and libvirt), we'll
only need one (libvirt). The QEMU QMP side will only need to state
what should be implemented using the flags. Also, as we already
agreed, we need TCG and KVM flags anyway, so we're already in flag
land.

> 
> [...]
> > > If the size of the bitmap on the KVM side is 512 bits, why don't we
> > > just make it that size on the QEMU side too from the start?
> > 
> > I'd still only want to input 64-bits on the command line, otherwise
> > we get into inputting arrays, which isn't easy. KVM's interface is
> > meant for expansion, but it won't be using most of those bits for
> > quite some time either.
> 
> I'm probably missing something entirely obvious, but couldn't you
> just have a single, possibly fairly massive (up to 128 hex digits if
> I'm not mistaken) value on the command line and just work with that
> one, no arrays necessary?
>

We could, and I like the idea. It just hadn't crossed my mind due to
implementation tunnel vision.

Thanks,
drew

