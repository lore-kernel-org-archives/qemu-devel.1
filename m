Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99471C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADA12084F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADA12084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQD0C-0007Yd-6k
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:36:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQCvg-0004YT-BR
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQCvd-0006DM-Qr
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:31:52 -0400
Received: from foss.arm.com ([217.140.101.70]:56126)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQCvK-0005zt-4f; Mon, 13 May 2019 11:31:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0D9341;
	Mon, 13 May 2019 08:31:20 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3B93F71E;
	Mon, 13 May 2019 08:31:19 -0700 (PDT)
Date: Mon, 13 May 2019 16:31:16 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190513153116.GL28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
	<20190513135501.ztggqdac57qbpuft@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513135501.ztggqdac57qbpuft@kamzik.brq.redhat.com>
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

On Mon, May 13, 2019 at 02:55:01PM +0100, Andrew Jones wrote:
> On Mon, May 13, 2019 at 01:31:11PM +0100, Dave Martin wrote:
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
> > 
> > Out of interest, why do all this swabbing?  It seems expensive.
> >
> 
> QEMU keeps its 128-bit and larger words in the same order (least
> significant word first) for both host endian types. We need to
> do word swapping every time we set/get them to/from KVM.

I'm not sure whether this is appropriate here, though it depends on
what QEMU does with the data.

Something non-obvious to be aware of:

As exposed through the signal frame and the KVM ABI, the memory
representation of an SVE reg is invariant with respect to the
endianness.

IIUC, the byte order seen for a V-reg in KVM_REG_ARM_CORE and for
the equivalent Z-reg in KVM_REG_ARM64_SVE would be the opposite of each
other on BE, but the same on LE.

This is a feature of the archtiecture: a V-reg can be stored as a single
value, but Z-regs are in general too big to be treated as a single
value: they are always treated as a sequence of elements, and the
largest element size supported is 64 bits, not 128.  IIUC, there is no
direct native way to store with 128-bit swabbing: some explicit data
processing operation would also be needed to swap adjacent 64-bit
elements in the vector around the store/load.

This is not specified in the ABI documentation -- I should address that.

If this is infeasible for KVM to work with, we could perhaps change it,
but I'm not too keen on that at this stage.  KVM_REG_ARM64_SVE_VLS
has a similar behaviour: it's a vector of 64-bit possibly-swabbed words,
not a single possibly-swabbed 512-bit word.


Looking at the kernel, I may have screwed up in places where the
two representations interact, like fpsimd_to_sve().  I should take a
look at that...  This doesn't affect the KVM ABI though.

Cheers
---Dave


