Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D56C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520C82173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520C82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngME-0005Cq-Ez
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hngM4-0004mg-Mb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hngM3-0006kp-HH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hngLy-0006is-Ah; Wed, 17 Jul 2019 05:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49495C057EC0;
 Wed, 17 Jul 2019 09:36:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47DA85C257;
 Wed, 17 Jul 2019 09:35:56 +0000 (UTC)
Date: Wed, 17 Jul 2019 11:35:53 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190717093553.r5uomcocbtqkofkl@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-11-drjones@redhat.com>
 <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 17 Jul 2019 09:36:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 05:22:34PM +0200, Richard Henderson wrote:
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > +/*
> > + * If ARM_MAX_VQ is increased to be greater than 16, then we can no
> > + * longer hard code slices to 1 in kvm_arch_put/get_sve().
> > + */
> > +QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> 
> This seems easy to fix, or simply drop the slices entirely for now, as
> otherwise they are a teeny bit confusing.

I can do that, but as I replied down thread, I sort of like it this way
for documentation purposes. Anyway, I don't have a strong opinion here,
so I'm happy to make reviewers happy :-)

> 
> It's a shame that these slices exist at all.  It seems like the kernel could
> use the negotiated max sve size to grab the data all at once.
> 
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
> 
> ... and this (unified w/ reg + size parameters?) to a function because ...
> 
> > +        reg.addr = (uintptr_t)&env->vfp.pregs[FFR_PRED_NUM].p[0];
> > +        reg.id = KVM_REG_ARM64_SVE_FFR(i);
> > +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> 
> ... you forgot to apply the bswap here.

Ah, thanks for catching this. I'll fix it for v3, possibly with the
factoring, as you suggest.

> 
> Likewise for the other direction.
> 
> 
> r~
> 
> 
> PS: It's also tempting to drop the ifdefs and, since we know the host supports
> sve instructions, and that the host supports sve_max_vq, do the reformatting as
> 
>     uint64_t scratch[ARM_MAX_VQ * 2];
>     asm("whilelo  p0.d, xzr, %2\n\t"
>         "ld1d     z0.d, p0/z [%1]\n\t"
>         "str      z0, [%0]"
>         : "=Q"(scratch)
>         : "Q"(*aa64_vfp_qreg(env, n)),
>           "r"(cpu->sve_max_vq)
>         : "p0", "v0");

This is nice, but as we don't have any other asm's in this file, I'm
inclined to leave it with the loops/swaps until we can use a builtin,
as you suggest below.

> 
> PPS: Ideally, this would be further cleaned up with acle builtins, but those
> are still under development for GCC.
> 

Thanks,
drew

