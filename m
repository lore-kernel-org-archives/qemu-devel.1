Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456FAC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A78220663
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A78220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWCO-0006is-D2
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Dave.Martin@arm.com>) id 1hgW8w-0004uP-6c
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1hgW8n-0006zq-QI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:16:53 -0400
Received: from foss.arm.com ([217.140.110.172]:55118)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1hgW8X-0006f2-J5; Thu, 27 Jun 2019 11:16:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953A6360;
 Thu, 27 Jun 2019 08:16:31 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586983F246;
 Thu, 27 Jun 2019 08:16:30 -0700 (PDT)
Date: Thu, 27 Jun 2019 16:16:28 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190627151628.GI2790@e103592.cambridge.arm.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <ee8ce4a6-09fd-47ab-ef7e-a231df1e9c1b@redhat.com>
 <20190627104638.x4gxsmv7vpww3mra@kamzik.brq.redhat.com>
 <ae98bf94-6826-1f2b-2f2e-a11a3f75cb92@redhat.com>
 <20190627114701.n7tjgmljeribk7to@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627114701.n7tjgmljeribk7to@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/arm/cpu64: max cpu:
 Introduce sve<vl-bits> properties
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 12:47:01PM +0100, Andrew Jones wrote:
> On Thu, Jun 27, 2019 at 01:00:27PM +0200, Auger Eric wrote:
> > Hi,
> > 
> > On 6/27/19 12:46 PM, Andrew Jones wrote:
> > > On Wed, Jun 26, 2019 at 06:56:54PM +0200, Auger Eric wrote:
> > >>> diff --git a/target/arm/helper.c b/target/arm/helper.c
> > >>> index f500ccb6d31b..b7b719dba57f 100644
> > >>> --- a/target/arm/helper.c
> > >>> +++ b/target/arm/helper.c
> > >>> @@ -5324,7 +5324,16 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > >>>  
> > >>>      /* Bits other than [3:0] are RAZ/WI.  */
> > >>>      QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> > >>> -    raw_write(env, ri, value & 0xf);
> > >>> +    value &= 0xf;
> > >>> +
> > >>> +    if (value) {
> > >>> +        /* get next vq that is smaller than or equal to value's vq */
> > >>> +        uint32_t vq = value + 1;
> > >>> +        vq = arm_cpu_vq_map_next_smaller(cpu, vq + 1);
> > >>> +        value = vq - 1;
> > >> spec says:
> > >>
> > >> "if an unsupported vector length is requested in ZCR_ELx, the
> > >> implementation is required to select the largest
> > >> supported vector length that is less than the requested length. This
> > >> does not alter the value of ZCR_ELx.LEN.
> > >> "
> > >>
> > >> So I understand the value written in the reg should not be unmodified.
> > >>
> > > 
> > > Sorry, I can't parse what you're trying to tell me here. Here we have
> > > to write 'value', because that's what the guest is trying to do. As the
> > > spec says in your quote, we have to pick the length the guest wants, or
> > > the next smaller valid one, so that's what the code above does. So are
> > > you just stating that you agree with this hunk of the code?
> > What we are writing into the reg is arm_cpu_vq_map_next_smaller(cpu, vq
> > + 1) -1. Maybe I misunderstand the whole wording but I would have
> > expected the original unmodified value to be written in the reg instead?
> 
> Hmm... So maybe we need more changes to the emulation in order for it to
> have an acting value and a register value? Maybe Richard knows what we
> should do here.

The "effective" value of an individual ZCR_ELx.LEN field is a bit
nonsensical: the effective vector length comes from the minimum
LEN value at any relevant EL (depending on which ELs are implemented,
which security state you're in, VHE controls etc.).

This is tedious to compute, so I'd expect you want to cache it,
recomputing it only when a ZCR_ELx.LEN changes or when you switch to a
different EL.


The architecture says:

"For all purposes other than returning the result of a direct read of
ZCR_EL1 then this field behaves as if it is set to the minimum of the
stored value and the constrained length inherited from more privileged
Exception levels in the current Security state, rounded down to the
nearest implemented vector length."

I think the behaviour of a direct read is implied: the LEN bits yielded
by an MRS should contain exactly what was last written to them via MSR.

Cheers
---Dave

