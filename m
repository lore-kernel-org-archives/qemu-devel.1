Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gQ7xs-0007cs-Qu
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gQ7ti-0007tB-8P
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:37:15 -0500
Date: Fri, 23 Nov 2018 10:36:27 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181123093627.GH4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-6-sameo@linux.intel.com>
	<20181108151623.4de26ecb@redhat.com>
	<20181121144211.GE4426@caravaggio>
	<20181122172652.6b02aef6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122172652.6b02aef6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/24] hw: acpi: Implement XSDT support
 for RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Nov 22, 2018 at 05:26:52PM +0100, Igor Mammedov wrote:
> On Wed, 21 Nov 2018 15:42:11 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > Hi Igor,
> > 
> > On Thu, Nov 08, 2018 at 03:16:23PM +0100, Igor Mammedov wrote:
> > > On Mon,  5 Nov 2018 02:40:28 +0100
> > > Samuel Ortiz <sameo@linux.intel.com> wrote:
> > >   
> > > > XSDT is the 64-bit version of the legacy ACPI RSDT (Root System
> > > > Description Table). RSDT only allow for 32-bit addressses and have thus
> > > > been deprecated. Since ACPI version 2.0, RSDPs should point at XSDTs and
> > > > no longer RSDTs, although RSDTs are still supported for backward
> > > > compatibility.
> > > > 
> > > > Since version 2.0, RSDPs should add an extended checksum, a complete table
> > > > length and a version field to the table.  
> > > 
> > > This patch re-implements what arm/virt board already does
> > > and fixes checksum bug in the later and at the same time
> > > without a user (within the patch).
> > > 
> > > I'd suggest redo it a way similar to FADT refactoring
> > >   patch 1: fix checksum bug in virt/arm
> > >   patch 2: update reference tables in test
> > >   patch 3: introduce AcpiRsdpData similar to commit 937d1b587
> > >              (both arm and x86) wich stores all data in hos byte order
> > >   patch 4: convert arm's impl. to build_append_int_noprefix() API (commit 5d7a334f7)
> > >
> > >            ... move out to aml-build.c
> > >   patch 5: reuse generalized arm's build_rsdp() for x86, dropping x86 specific one
> > >       amending it to generate rev1 variant defined by revision in AcpiRsdpData
> > >       (commit dd1b2037a)  
> > I agree patches #1, #2 and #5 make sense. 3 and 4 as well, but here
> > you're asking about something that's out of scope of the current serie.
> /me guilty of that, but I have excuses for doing so:
>   * that's the only way to get rid of legacy approach given limited resources.
>     So task goes to whomever touches old code. /others and me included/
>     I'd be glad if someone would volunteer and do clean ups but in absence
>     of such, the victim is interested party.
>   * contributor to ACPI part learns how to use preferred approach,
>     makes code more robust and clear as it's not possible to make
>     endianness mistakes, very simple to review and notice mistakes
>     as end result practically matches row by row a table described in spec.
I understand and agree with that. And to be clear: I'm happy to
contribute and work on that. But I'm also lucky to have an employer
that can afford to let me spend as much time as needed to do this kind
of refactoring/modernizing work. I just want to point out that other
potential newcomers to the project may not have that luxury.
I wonder (I sincerely do, I'm not making any assumptions) how much code
is left unmerged because the original submitter did not have the time or
budget to polish it up to the expected level.

Cheers,
Samuel.
