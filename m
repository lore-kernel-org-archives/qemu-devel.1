Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D788C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5431021019
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5431021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQDWr-0006HV-FG
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 12:10:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQDSf-0003S2-Vs
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQDSf-0001tm-0G
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:05:57 -0400
Received: from foss.arm.com ([217.140.101.70]:56928)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQDSc-0001qY-CU; Mon, 13 May 2019 12:05:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322A5341;
	Mon, 13 May 2019 09:05:52 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB16F3F71E;
	Mon, 13 May 2019 09:05:50 -0700 (PDT)
Date: Mon, 13 May 2019 17:05:48 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190513160547.GM28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
	<20190513135501.ztggqdac57qbpuft@kamzik.brq.redhat.com>
	<20190513153116.GL28398@e103592.cambridge.arm.com>
	<CAFEAcA95LbXZOJNUAYuYoVDkM0auj-RGACXPp9Qe9ANp_b3C=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA95LbXZOJNUAYuYoVDkM0auj-RGACXPp9Qe9ANp_b3C=w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add
 kvm_arch_get/put_sve
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
Cc: Andrew Jones <drjones@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 04:40:52PM +0100, Peter Maydell wrote:
> On Mon, 13 May 2019 at 16:31, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Mon, May 13, 2019 at 02:55:01PM +0100, Andrew Jones wrote:
> > > QEMU keeps its 128-bit and larger words in the same order (least
> > > significant word first) for both host endian types. We need to
> > > do word swapping every time we set/get them to/from KVM.
> >
> > I'm not sure whether this is appropriate here, though it depends on
> > what QEMU does with the data.
> 
> The layout is optimised for TCG emulation to be able
> to work with it, I think (rth would have the definite
> reason, though).

So long as we are agreed about the ABI, this is none of my concern :)

> > Something non-obvious to be aware of:
> >
> > As exposed through the signal frame and the KVM ABI, the memory
> > representation of an SVE reg is invariant with respect to the
> > endianness.
> 
> Yes; we handle this conversion as we write out the signal frame:
> https://github.com/qemu/qemu/blob/master/linux-user/aarch64/signal.c#L184

Right.  I hadn't focused consciously on this, since the architecture
does the work for us in the kernel (mostly).

I will check the documentation to make sure the behaviour is clearly
described, anyhow.

Cheers
---Dave

