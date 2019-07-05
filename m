Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F62C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B58B20659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B58B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjX7V-0007Dh-FX
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58338)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWm2-0007ut-Ge
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWlz-0007ii-HR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWlt-0007dX-QW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5215F3082B4D;
 Fri,  5 Jul 2019 22:33:31 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D26F37999;
 Fri,  5 Jul 2019 22:33:30 +0000 (UTC)
Date: Fri, 5 Jul 2019 19:33:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190705223329.GL5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-7-git-send-email-pbonzini@redhat.com>
 <20190705212249.GG5198@habkost.net>
 <6262c798-fc94-5100-8836-e3cbea306282@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6262c798-fc94-5100-8836-e3cbea306282@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 05 Jul 2019 22:33:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/7] target/i386: add VMX features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 06, 2019 at 12:12:49AM +0200, Paolo Bonzini wrote:
> On 05/07/19 23:22, Eduardo Habkost wrote:
> >> +    switch (index) {
> >> +    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> >> +        default1 = 0x00000016;
> >> +        break;
> >> +    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
> >> +        default1 = 0x0401e172;
> >> +        break;
> >> +    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
> >> +        default1 = 0x000011ff;
> >> +        break;
> >> +    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
> >> +        default1 = 0x00036dff;
> >> +        break;
> >> +    case MSR_IA32_VMX_PROCBASED_CTLS2:
> >> +        default1 = 0;
> >> +        break;
> > How do you plan to implement backwards compatibility if these
> > defaults ever change?  Shouldn't these values be part of the CPU
> > model definitions so we can update them in the future?
> 
> These are not defaults, they are "default-1 bits": if a feature is
> disabled, these bits are 1 in both halves of the MSR rather than zero.
> The set of default-1 bits is documented and is not going to change in
> the future.
> 
> Some default-1 bits *could* however become features in the future, and
> four of these already have features associated to them:
> vmx-cr3-load-noexit, vmx-cr3-store-noexit, vmx-exit-nosave-debugctl,
> vmx-entry-noload-debugctl.  You can see that they have "no" in their
> name because the feature is about the ability to "do less" rather than
> "do more".

Understood.  Thanks!

> 
> >> +    uint64_t kvm_vmx_basic =
> >> +        kvm_arch_get_supported_msr_feature(kvm_state,
> >> +                                           MSR_IA32_VMX_BASIC);
> >> +    uint64_t kvm_vmx_misc =
> >> +        kvm_arch_get_supported_msr_feature(kvm_state,
> >> +                                           MSR_IA32_VMX_MISC);
> >> +    uint64_t kvm_vmx_ept_vpid =
> >> +        kvm_arch_get_supported_msr_feature(kvm_state,
> >> +                                           MSR_IA32_VMX_EPT_VPID_CAP);
> > 
> > If the MSR value we're exposing to the guest depends on
> > kvm_arch_get_supported_msr_feature(), how will we ensure this
> > will be safe for live migration?
> 
> Because KVM guarantees that this part of the guest ABI will never
> change.  These values do not come from the host values of the MSRs, they
> are fixed by KVM.  More details below.
> 
> > If we really need to tweak the MSR values based on the host for
> > some reason (which is not clear to me yet), why don't we update
> > env->features[...] at x86_cpu_expand_features() to reflect what
> > the guest is really seeing?
> > 
> > 
> >> +    /*
> >> +     * Bits 0-30, 32-44 and 50-53 come from the host.  KVM should
> >> +     * not change them for backwards compatibility.
> > 
> > Backwards compatibility with what?
> > 
> > Don't we want the MSR values to depend solely on the QEMU command
> > line in the future?
> 
> These bits are: VMCS revision, VMCS size and VMCS memory type.  QEMU
> cannot know them, as they depend on the internal implementation details
> of KVM.
> 
> Now that KVM supports nested virt live migration they cannot change
> anymore---otherwise KVM would break KVM live migration compatibility.
> However, theoretically in the future KVM could add some capability
> (which userspace would have to manually enable) and when the capability
> is enabled the values can change.

Oh, that's the info I was missing.  I always expected
kvm_arch_get_supported_*() to be subject to change (depending on
KVM and hardware capabilities), and not be part of guest ABI.

Now, if KVM is going to to implement the guest ABI guarantee at
KVM_GET_MSRS, that's OK.  Is this going to be obvious to people
touching KVM_GET_MSRS in the future?

What if we do want the guest ABI to change in the future?  How do
you expect QEMU to ask KVM to enable the new guest ABI?  How do
you expect the user to ask QEMU to enable the new guest ABI?


> 
> > +    /*
> > +     * Same for bits 0-4 and 25-27.  Bits 16-24 (CR3 target count) can
> > +     * change in the future but are always zero for now, clear them to be
> > +     * future proof.  Bits 32-63 in theory could change, though KVM does
> > +     * not support dual-monitor treatment and probably never will; mask
> > +     * them out as well.
> > +     */
> 
> The reasoning is more or less the same here.  These bits are part of the
> guest ABI (preemption timer scaling, CR3 target count, MSR count, MSEG
> revision).  Right now bits 0-4 are 5 and the others are 0; in the future:
> 
> - KVM cannot change bits 0-4 and 32-63 them without breaking guest ABI
> (the values must match between what you read and what you set)
> 
> - KVM could change bits 16-24, but it always allows writing a value that
> is _smaller_ than the one you read.  So I'm zeroing those, ensuring no
> future ABI changes.
> 
> - KVM could in theory change bits 25-27: here it also allows writing a
> value that is smaller than the one you read, so guest ABI is preserved.
>  Such a change is very unlikely, all Intel silicon has always had 0
> here.  But I can change the code to zero these three bits just like bits
> 16-24.

The complex rules above make me a bit nervous.  Can we at least
make QEMU validate the values returned by
kvm_arch_get_supported_msr_feature() to catch ABI-breaking
mistakes in the future?

-- 
Eduardo

