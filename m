Received: from eggs.gnu.org ([2001:4830:134:3::10]:47781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fdXke-0003qz-IZ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fdXkZ-0004SK-OE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:19:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:44405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fdXkZ-0004LW-DY
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:18:59 -0400
Message-ID: <1531387131.78672.1.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu, 12 Jul 2018 17:18:51 +0800
In-Reply-To: <20180703110007.GL7451@localhost.localdomain>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-3-git-send-email-robert.hu@linux.intel.com>
	<20180628182820.GE914@localhost.localdomain>
	<1530603313.22880.36.camel@linux.intel.com>
	<20180703110007.GL7451@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] i386: Add CPUID bit and feature
 words for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Tue, 2018-07-03 at 08:00 -0300, Eduardo Habkost wrote:
> On Tue, Jul 03, 2018 at 03:35:13PM +0800, Robert Hoo wrote:
> > On Thu, 2018-06-28 at 15:28 -0300, Eduardo Habkost wrote:
> > > On Wed, Jun 27, 2018 at 07:27:21PM +0800, Robert Hoo wrote:
> > > > Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
> > > > SPEC_CTRL.
> > > > 
> > > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > 
> > > Based on kernel commit 1eaafe91, it looks like we must always set
> > > IA32_ARCH_CAPABILITIES.RSBA[bit 2] unless we're really sure the
> > > VM will not be migrated to a vulnerable processor.
> > > 
> > > Considering this, I'd like to make "+arch-capabilities" set
> > > IA32_ARCH_CAPABILITIES.RSBA by default, unless RSBA is explicitly
> > > disabled by management software.
> > > 
> > Agree. But this seems beyond Icelake CPU model scope. How about I think
> > about this carefully and compose another patch (set) for this?
> 
> This plan makes sense to me, as I don't want to make this
> decision block IceLake from being in QEMU 3.0.
> 
> However, enabling CPUID_7_0_EDX_ARCH_CAPABILITIES in IceLake but
> setting the MSR to 0 seems pointless.
> 
> I think we should add IceLake without
> CPUID_7_0_EDX_ARCH_CAPABILITIES first, and later (after deciding
> on a reasonable default value for MSR_IA32_ARCH_CAPABILITIES),
> enable the CPUID bit on IceLake (hopefully in time for QEMU 3.0).
> 
> 
> > And you'd like to set  IA32_ARCH_CAPABILITIES.RSBA by default in qemu or
> > kvm layer?
> 
> Probably we need to make this decision in QEMU.  If KVM set RSBA
> automatically on .get_msr_feature(), QEMU won't be able to
> differentiate a host with RSBA set from a host with RSBA unset.
> 
What's the default value for MSR IA32_ARCH_CAPABILITIES? is it clear
now?
