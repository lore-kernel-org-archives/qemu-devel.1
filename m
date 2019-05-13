Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD21C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1231A2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1231A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQC85-0006tR-BJ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 10:40:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQC7B-0006Rh-H8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQC7A-0004OZ-2i
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:39:41 -0400
Received: from foss.arm.com ([217.140.101.70]:54408)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQC75-0004ML-Pu; Mon, 13 May 2019 10:39:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06430341;
	Mon, 13 May 2019 07:39:34 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6073F71E;
	Mon, 13 May 2019 07:39:32 -0700 (PDT)
Date: Mon, 13 May 2019 15:39:30 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190513143929.GK28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513124356.GG28398@e103592.cambridge.arm.com>
	<20190513140726.vpmenrfw4uocmtnc@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513140726.vpmenrfw4uocmtnc@kamzik.brq.redhat.com>
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 03:07:26PM +0100, Andrew Jones wrote:
> On Mon, May 13, 2019 at 01:43:56PM +0100, Dave Martin wrote:
> > On Sun, May 12, 2019 at 09:36:16AM +0100, Andrew Jones wrote:
> > > These are the SVE equivalents to kvm_arch_get/put_fpsimd.
> > > 
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > ---
> > >  target/arm/kvm64.c | 127 +++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 123 insertions(+), 4 deletions(-)
> > 
> > [...]
> > 
> > > +static int kvm_arch_put_sve(CPUState *cs)
> > > +{
> > > +    ARMCPU *cpu = ARM_CPU(cs);
> > > +    CPUARMState *env = &cpu->env;
> > > +    struct kvm_one_reg reg;
> > > +    int n, ret;
> > > +
> > > +    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
> > > +        uint64_t *q = aa64_vfp_qreg(env, n);
> > > +#ifdef HOST_WORDS_BIGENDIAN
> > > +        uint64_t d[ARM_MAX_VQ * 2];
> > > +        int i;
> > > +        for (i = 0; i < cpu->sve_max_vq * 2; i++) {
> > > +            d[i] = q[cpu->sve_max_vq * 2 - 1 - i];
> > > +        }
> > > +        reg.addr = (uintptr_t)d;
> > > +#else
> > > +        reg.addr = (uintptr_t)q;
> > > +#endif
> > > +        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
> > 
> > Will this silently go wrong if more than one slice is required (i.e.,
> > the register size grows beyond 8192 bits?)
> 
> Yeah, I could probably implement the slice loop now and add a
> function that returns 1 (for now) like your vcpu_sve_slices()
> function in KVM. I'll do that for v2.

Or just add a sanity check that the vector length is <= 2048 bits.

Support for larger vectors is untestable for now, since the kernel
doesn't support that and would never expose it.


On that point, could TCG easily be made to expose a larger vector length
to the kernel?  I'd be interested to see what happened.

The kernel should warn and hide the larger vector lengths from KVM,
but I've not been able to test that.

It's only worth trying this out if the hacks to QEMU to enable testing
this were pretty trivial, though.

Cheers
---Dave

