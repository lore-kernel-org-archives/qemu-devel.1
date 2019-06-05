Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C21C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD28C2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD28C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36921 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQMB-0002jZ-3T
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:29:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hYQLH-0002M7-K1
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hYQLG-0005Ih-HT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hYQL9-0004tt-8V; Wed, 05 Jun 2019 03:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F6D230C0DDD;
	Wed,  5 Jun 2019 07:27:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 722B95DF4C;
	Wed,  5 Jun 2019 07:27:38 +0000 (UTC)
Date: Wed, 5 Jun 2019 09:27:35 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190605072735.tqgiprnilbacjppd@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-5-drjones@redhat.com>
	<7c0c0ef2-6ab4-fdf9-9507-d1f460bfbd51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c0c0ef2-6ab4-fdf9-9507-d1f460bfbd51@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 05 Jun 2019 07:27:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/13] target/arm/kvm: Move the get/put of
 fpsimd registers out
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, abologna@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 09:15:49AM +0200, Auger Eric wrote:
> Hi Drew,
> 
> On 5/12/19 10:36 AM, Andrew Jones wrote:
> > Move the getting/putting of the fpsimd registers out of
> > kvm_arch_get/put_registers() into their own helper functions
> > to prepare for alternatively getting/putting SVE registers.
> > 
> > No functional change.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/kvm64.c | 148 +++++++++++++++++++++++++++------------------
> >  1 file changed, 88 insertions(+), 60 deletions(-)
> > 
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index ba232b27a6d3..61947f3716e1 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -706,13 +706,53 @@ int kvm_arm_cpreg_level(uint64_t regidx)
> >  #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
> >                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
> >  
> > +static int kvm_arch_put_fpsimd(CPUState *cs)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +    struct kvm_one_reg reg;
> > +    uint32_t fpr;
> > +    int i, ret;
> > +
> > +    for (i = 0; i < 32; i++) {
> > +        uint64_t *q = aa64_vfp_qreg(env, i);
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +        uint64_t fp_val[2] = { q[1], q[0] };
> > +        reg.addr = (uintptr_t)fp_val;
> > +#else
> > +        reg.addr = (uintptr_t)q;
> > +#endif
> > +        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> > +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    reg.addr = (uintptr_t)(&fpr);
> > +    fpr = vfp_get_fpsr(env);
> > +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> > +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    reg.addr = (uintptr_t)(&fpr);
> I don't think you need this assignment

You're right, and they weren't in the original code, but I added them
in order to be sure that the register get/set blocks were complete
units. It's one thing to factor stuff like that out of a loop, but
here we had two almost independent blocks so it looked a bit odd.

[...]

> 
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>

Thanks,
drew 

