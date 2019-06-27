Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBAC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862F92086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862F92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVwp-00051Z-LH
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Dave.Martin@arm.com>) id 1hgVvb-0004Pf-2g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1hgVvU-0002b5-Dl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:03:10 -0400
Received: from foss.arm.com ([217.140.110.172]:54916)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1hgVuz-00021B-UG; Thu, 27 Jun 2019 11:02:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 510E6360;
 Thu, 27 Jun 2019 08:02:28 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA383F246;
 Thu, 27 Jun 2019 08:02:26 -0700 (PDT)
Date: Thu, 27 Jun 2019 16:02:24 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190627150224.GH2790@e103592.cambridge.arm.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-11-drjones@redhat.com>
 <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
 <20190627105911.GD2790@e103592.cambridge.arm.com>
 <3e935f36-1065-b82e-86e0-f3e4cd11f95e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e935f36-1065-b82e-86e0-f3e4cd11f95e@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [PATCH v2 10/14] target/arm/kvm64: Add
 kvm_arch_get/put_sve
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 12:26:06PM +0100, Richard Henderson wrote:
> On 6/27/19 12:59 PM, Dave Martin wrote:
> >> It's a shame that these slices exist at all.  It seems like the kernel could
> >> use the negotiated max sve size to grab the data all at once.
> > 
> > The aim here was to be forwards compatible while fitting within the
> > existing ABI.
> > 
> > The ABI doesn't allow variable-sized registers, and if the vq can
> > someday grow above 16 then the individual registers could become pretty
> > big.
> 
> The ABI doesn't appear to have fixed sized data blocks.  Since that's
> the case, it didn't seem to me that variable sized blocks was so
> different, given that the actual size is constrained by the hardware
> on which we're running.

I'm not sure what you mean here.

For KVM_GET_ONE_REG, the size is determined by the reg size field in
the register ID, so size is deemed to be a fixed property of a
particular register.

Having the register IDs vary according to the vector length seemed a
step too far.

> And if VQ does grow large, then do we really want oodles of syscalls in order
> to transfer the data for each register?  With the 9 bits reserved for this
> field, we could require a maximum of 1024 syscalls to transfer the whole
> register set.

A save/restore requires oodles of syscalls in any case, and for SVE
there is a rapid dropoff of probabilities: VQ < 16 is much likelier than
VQ == 32 is likelier than VQ == 64 etc.

The reg access API has some shortcomings, and we might find at some
point that the whole thing needs redesigning.

I suppose we could have taken the view that the KVM ABI would not even
try to support VQ > 16 in a forwards compatible way.  In the end we
decided to at least have things workable.

Either way, it's entirely reasonable for userspace not to try to support
additional slices for now.  We'll have plenty of time to plan away
across that bridge when we spot it on the horizon...

> > It's for QEMU to choose, but does it actually matter what byteorder you
> > store a Z-reg or P-reg in?  Maybe the byteswap isn't really needed.
> 
> I think the only sensible order for the kernel is that in which LDR/STR itself
> saves the data.  Which is a byte stream.

We have a choice of STRs though.  Anyway, yes, it is the way it is, now.

> Within QEMU, it has so far made sense to keep the data in 64-bit hunks in
> host-endian order.  That's how the AdvSIMD code was written originally, and it
> turned out to be easy enough to continue that for SVE.

Fair enough.  It's entirely up to QEMU to decide -- I just wanted to
check that there was no misunderstanding about this issue in the ABI.

> Which does mean that if we want to pass data to the kernel as the
> aforementioned byte stream that a big-endian host does need to bswap the data
> in 64-bit hunks.
> 
> > I don't know how this works when migrating from a little-endian to a
> > big-endian host or vice-versa (or if that is even supported...)
> 
> The data is stored canonically within the vmsave, so such migrations are
> supposed to work.

Right, I was wondering about that.  Could be fun to test :)

Cheers
---Dave

