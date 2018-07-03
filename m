Received: from eggs.gnu.org ([2001:4830:134:3::10]:51844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1faGz2-0006bh-0n
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1faGyz-0003YF-F8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:48:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:28554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1faGyy-0003Xr-Uo
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:48:21 -0400
Message-ID: <1530607697.22880.46.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Tue, 03 Jul 2018 16:48:17 +0800
In-Reply-To: <ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
	<ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, rth@twiddle.net, wei.w.wang@intel.com

On Thu, 2018-06-28 at 16:20 +0200, Paolo Bonzini wrote:
> On 28/06/2018 11:25, Robert Hoo wrote:
> >>> +    uint64_t pred_cmd;
> >>> +    uint64_t arch_capabilities;
> >> What's the purpose of those CPUX86State fields, if the migration
> >> sections were removed in v2?
> >>
> > Thanks Eduardo. Going to clean up in v3. Any more comments, regarding
> > other patches?
> 
> Yes - something like arch_capabilities must stay, as it will be filled
> in with "CPUID-like" feature bits that are actually visible to the guest
> via the MSR.
> 
> However, I suggest adding it to the FeatureWord enum, since everything
> that handles FeatureWord applies to this new kind of MSR as well.
> Currently FeatureWord is only for CPUID leaves, but it doesn't have to
> be like that.
> 
I think this will be changing struct FeatureWordInfo, which is designed
for cpuid enumerations. You must not want to do that. May I know more
details about your thought?

And, if I implemented ARCH_CAPABILITIES-bits features in FeatureWord,
then no necessity of having it in kvm_msr_entries, right?
> Paolo
