Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1495EC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB3520828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB3520828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSLC-0006JT-4W
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Dave.Martin@arm.com>) id 1hgSBE-00082e-2B
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1hgSAt-0007U0-NZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:03 -0400
Received: from foss.arm.com ([217.140.110.172]:50328)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1hgSAA-0006qx-Pf; Thu, 27 Jun 2019 07:01:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E6A2B;
 Thu, 27 Jun 2019 04:01:57 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9B3C3F718;
 Thu, 27 Jun 2019 04:01:55 -0700 (PDT)
Date: Thu, 27 Jun 2019 12:01:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190627110153.GE2790@e103592.cambridge.arm.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-13-drjones@redhat.com>
 <40326319-4f1a-019e-1cb7-840a011ed8b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40326319-4f1a-019e-1cb7-840a011ed8b4@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [PATCH v2 12/14] target/arm/kvm: scratch vcpu:
 Preserve input kvm_vcpu_init features
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 08:30:57AM +0100, Auger Eric wrote:
> Hi Drew,
> 
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
> > parameter. Rather than just using it as an output parameter to
> > pass back the preferred target, use it also as an input parameter,
> > allowing a caller to pass a selected target if they wish and to
> > also pass cpu features. If the caller doesn't want to select a
> > target they can pass -1 for the target which indicates they want
> > to use the preferred target and have it passed back like before.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/kvm.c   | 20 +++++++++++++++-----
> >  target/arm/kvm32.c |  6 +++++-
> >  target/arm/kvm64.c |  6 +++++-
> >  3 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 60645a196d3d..66c0c198604a 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -64,7 +64,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
> >                                        int *fdarray,
> >                                        struct kvm_vcpu_init *init)
> >  {
> > -    int ret, kvmfd = -1, vmfd = -1, cpufd = -1;
> > +    int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> >  
> >      kvmfd = qemu_open("/dev/kvm", O_RDWR);
> >      if (kvmfd < 0) {
> > @@ -84,7 +84,14 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
> >          goto finish;
> >      }
> >  
> > -    ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, init);
> > +    if (init->target == -1) {
> > +        struct kvm_vcpu_init preferred;
> > +
> > +        ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
> > +        if (!ret) {
> > +            init->target = preferred.target;
> wouldn't it be safe to copy the whole struct. Kernel code says:
>         /*
>          * For now, we don't return any features.
>          * In future, we might use features to return target
>          * specific features available for the preferred
>          * target type.
>          */

Marc or Christoffer should preferably comment on this.

I think the spirit of the ABI is that can use the whole return of
KVM_ARM_PREFERRED_TARGET as a reasonable template for KVM_VCPU_INIT
without it blowing up in your face.

I initially tried to report SVE as available through this route,
but we decided against it precisely because userspace might be doing
the above.

[...]

Cheers
---Dave

