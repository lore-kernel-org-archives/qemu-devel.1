Received: from eggs.gnu.org ([2001:4830:134:3::10]:52988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fabMR-000299-CL
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fabMM-00046l-Fr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:33:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:14313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fabMM-00046V-5w
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:33:50 -0400
Message-ID: <1530686022.22880.56.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 04 Jul 2018 14:33:42 +0800
In-Reply-To: <6ef13b94-7aa1-78c2-95ca-8fec04510454@redhat.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
	<ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
	<1530607697.22880.46.camel@linux.intel.com>
	<b7c410af-ebc0-537c-84c4-588842fec111@redhat.com>
	<6ef13b94-7aa1-78c2-95ca-8fec04510454@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, wei.w.wang@intel.com

On Tue, 2018-07-03 at 15:38 +0200, Paolo Bonzini wrote:
> On 03/07/2018 13:07, Robert Hoo wrote:
> >>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
> >>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
> >> +    FEATURE_WORDS_NUM_CPUID,
> >> +    FEATURE_WORDS_FIRST_MSR = FEATURE_WORDS_NUM_CPUID,
> >> +    FEAT_MSR_ARCH_CAPABILITIES = FEATURE_WORDS_FIRST_MSR,
> >>      FEATURE_WORDS,
> >> };
> >>
> >> #define FEATURE_WORDS_NUM_MSRS (FEATURE_WORDS - \
> >>                                 FEATURE_WORDS_FIRST_MSR)
> >>
> >> Then the existing loops that use FeatureWordInfo can go up to
> >> FEATURE_WORDS_NUM_CPUID.
> > Emm... Understand your point now. It is a little risky, all references
> > to FEATURE_WORDS need to be updated carefully.
> > OK, let me try to think in this way.
> > Perhaps, I'll need to define a new 'struct FeautureWordMsrInfo' to
> > describe feature words from MSR, in parallel to current FeatureWordInfo
> > (or better rename it to FeatureWordCpuidInfo).
> 
> Yes, probably.  The plan seems fine.
> 

> > And, if I implemented ARCH_CAPABILITIES-bits features in
FeatureWord,
> > then no necessity of having it in kvm_msr_entries, right?
> 
Hi Paolo, would you confirm this? I mean your previous patch "KVM: VMX:
support MSR_IA32_ARCH_CAPABILITIES as a feature MSR" is not necessary
now?

> Paolo
