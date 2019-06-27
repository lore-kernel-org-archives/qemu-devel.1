Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3937C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02AA2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02AA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSXx-0003qo-2C
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Dave.Martin@arm.com>) id 1hgS8R-0005eE-II
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1hgS86-0003Pl-Pc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:00:11 -0400
Received: from foss.arm.com ([217.140.110.172]:50278)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1hgS7Z-000303-J3; Thu, 27 Jun 2019 06:59:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2722D2B;
 Thu, 27 Jun 2019 03:59:15 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6BF93F718;
 Thu, 27 Jun 2019 03:59:13 -0700 (PDT)
Date: Thu, 27 Jun 2019 11:59:11 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190627105911.GD2790@e103592.cambridge.arm.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-11-drjones@redhat.com>
 <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
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

On Wed, Jun 26, 2019 at 04:22:34PM +0100, Richard Henderson wrote:
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > +/*
> > + * If ARM_MAX_VQ is increased to be greater than 16, then we can no
> > + * longer hard code slices to 1 in kvm_arch_put/get_sve().
> > + */
> > +QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> 
> This seems easy to fix, or simply drop the slices entirely for now, as
> otherwise they are a teeny bit confusing.
> 
> It's a shame that these slices exist at all.  It seems like the kernel could
> use the negotiated max sve size to grab the data all at once.

The aim here was to be forwards compatible while fitting within the
existing ABI.

The ABI doesn't allow variable-sized registers, and if the vq can
someday grow above 16 then the individual registers could become pretty
big.

Inside the kernel, we took the view that if that ever happens, it's
sufficiently far out that we can skip implementing the support today,
providing that the ABI can accommodate the change.

For qemu, if you don't actually care what's in the regs, you could just
enumerate then using KVM_GET_REG_LIST instead of manufacturing the IDs
by hand.  That way, you don't have to care what slices exist.  For
save/restore/migrate purposes, the regs are just data, so that's
probably enough.

Debug, and exchanging vector registers between the guest and, say, and
SMC trapped to userspace, would still need to examine specific regs.
I don't know what QEMU does in this area though.

> > +        for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
> > +            uint64_t *q = aa64_vfp_qreg(env, n);
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +            uint64_t d[ARM_MAX_VQ * 2];
> > +            int j;
> > +            for (j = 0; j < cpu->sve_max_vq * 2; j++) {
> > +                d[j] = bswap64(q[j]);
> > +            }
> > +            reg.addr = (uintptr_t)d;
> > +#else
> > +            reg.addr = (uintptr_t)q;
> > +#endif
> > +            reg.id = KVM_REG_ARM64_SVE_ZREG(n, i);
> > +            ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> 
> It might be worth splitting this...
> 
> > +        for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; n++) {
> > +            uint64_t *q = &env->vfp.pregs[n].p[0];
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +            uint64_t d[ARM_MAX_VQ * 2 / 8];
> > +            int j;
> > +            for (j = 0; j < cpu->sve_max_vq * 2 / 8; j++) {
> > +                d[j] = bswap64(q[j]);
> > +            }
> > +            reg.addr = (uintptr_t)d;
> > +#else
> > +            reg.addr = (uintptr_t)q;
> > +#endif
> > +            reg.id = KVM_REG_ARM64_SVE_PREG(n, i);
> > +            ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);

It's for QEMU to choose, but does it actually matter what byteorder you
store a Z-reg or P-reg in?  Maybe the byteswap isn't really needed.

I don't know how this works when migrating from a little-endian to a
big-endian host or vice-versa (or if that is even supported...)

[...]

Cheers
---Dave

