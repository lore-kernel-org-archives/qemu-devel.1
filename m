Received: from eggs.gnu.org ([2001:4830:134:3::10]:53622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEsYv-00081c-NJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEsYs-0008Ae-Er
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:01:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:24089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEsYr-00089Y-M5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:01:14 -0400
Date: Tue, 23 Oct 2018 11:00:18 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181023090018.GA8387@caravaggio>
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<20181022172616-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022172616-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 00/27] ACPI hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 22, 2018 at 05:28:54PM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 22, 2018 at 08:36:30PM +0200, Samuel Ortiz wrote:
> > This patch set implements support for the ACPI hardware-reduced
> > specification.
> > 
> > The changes are coming from the NEMU [1] project where we're defining
> > a new x86 machine type: i386/virt. This is an EFI only, ACPI
> > hardware-reduced platform and as such we had to implement support
> > for the latter.
> > 
> > As a preliminary for adding hardware-reduced support to QEMU, we did
> > some ACPI code reorganization with the following goals:
> > 
> > * Share as much as possible of the current ACPI build APIs between
> >   legacy and hardware-reduced ACPI.
> > * Share the ACPI build code across machine types and architectures and
> >   remove the typical PC machine type dependency.
> >   Eventually we hope to see arm/virt also re-use much of that code.
> > 
> > The rest of the patchset adds the hardware-reduced support on top of
> > this code reorganization. Here again, the implementation is machine
> > type, platform and architecture independent.
> > 
> > [1] https://github.com/intel/nemu
> 
> 
> Thanks for the patch!
> I'm traveling so won't be able to review until next week.
No problem. I'm assuming you'll be attending the KVM Forum, Rob Bradford
and myself will be there as well.


> I wonder whether the code can be refactored slightly differently:
> instead of common code calling out to platform specific one,
> have platform code call out to generic one.
> That would avoid indicectiin but I'm not sure at what cost
> in complexity.
I may be misunderstanding your point, so forgive me if that's the case.
But the code refactoring actually lead to both of the code paths you're
describing. The generic code calls into platform specific hooks for
potentially calling custom ACPI tables, but the platform code also uses
the now shared generic code.

> Still that's a generic question as I have not looked at the
> patches in depth.
Looking forward to getting your review.

Cheers,
Samuel.
