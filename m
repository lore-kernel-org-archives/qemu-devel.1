Received: from eggs.gnu.org ([2001:4830:134:3::10]:46847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT2sh-0008FY-DJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT2sd-0001N9-DD
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:19:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT2sd-0001Mb-8a
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:19:55 -0400
Date: Wed, 13 Jun 2018 11:19:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613101949.GL27901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<20180604202205.GH5867@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604202205.GH5867@char.us.oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, rth@twiddle.net

On Mon, Jun 04, 2018 at 04:22:05PM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Jun 04, 2018 at 05:07:01PM -0300, Eduardo Habkost wrote:
> > On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wilk wrote:
> > > AMD future CPUs expose _two_ ways to utilize the Intel equivalant
> > > of the Speculative Store Bypass Disable. The first is via
> > > the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
> > > is via the SPEC_CTRL MSR (0x48). The document titled:
> > > 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> > > 
> > > gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.
> > > 
> > > A copy of this document is available at
> > >       https://bugzilla.kernel.org/show_bug.cgi?id=199889
> > > 
> > > Anyhow, this means that on future AMD CPUs there will be  _two_ ways to
> > > deal with SSBD.
> > 
> > Does anybody know if there are AMD CPUs where virt-ssbd won't
> > work and would require amd-ssbd to mitigate vulnerabilities?
> > 
> > Also, do we have kernel arch/x86/kvm/cpuid.c patches, already?
> 
> Not yet. They are being discussed right now. I figured I would send
> these patches out as a 'Hey, coming at you!', but failed to change
> the title to be 'RFC'.
> 
> > I prefer to add new CPUID flag names only after the flag name is
> > already agreed upon on the kernel side.
> 
> Of course. I will respin once that discussion has calmed down.

Looks like the kernel side has merged now, and we'll need to rename
the 2nd CPU bit from what I see.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
