Received: from eggs.gnu.org ([2001:4830:134:3::10]:40327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPwot-0004Wf-J4
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPwoq-0004gj-DU
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fPwoq-0004g8-6c
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:15:12 -0400
Date: Mon, 4 Jun 2018 18:15:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180604211509.GA7451@localhost.localdomain>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<20180604202205.GH5867@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

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

OK.  I was queueing them on x86-next, but I'm going drop them by
now.


> 
> > I prefer to add new CPUID flag names only after the flag name is
> > already agreed upon on the kernel side.
> 
> Of course. I will respin once that discussion has calmed down.

Thanks!

BTW, it looks like the patch on LKML[1] will make bit 26 appear
on /proc/cpuinfo as "amd_ssb_no", is that correct?  If that's the
case, I'd prefer to make the QEMU flag to match the name used by
Linux, and be called "amd-ssb-no" (which sounds weird to me, but
at least it will be consistent with /proc/cpuinfo).

[1] https://patchwork.kernel.org/patch/10443689/

-- 
Eduardo
