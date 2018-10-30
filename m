Received: from eggs.gnu.org ([2001:4830:134:3::10]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHVpt-0001lh-RA
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHVps-0000ih-ON
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:21:41 -0400
Date: Tue, 30 Oct 2018 16:20:41 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181030152041.GD5291@caravaggio.home>
References: <20181029162441.31631-1-sameo@linux.intel.com>
	<874ld4mzlb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ld4mzlb.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/19] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Hi Markus,

On Mon, Oct 29, 2018 at 06:28:48PM +0100, Markus Armbruster wrote:
> You neglected to cc: maintainers.  I'm doing that for you now.
> scripts/get_maintainer.pl can help you finding maintainers.
Sorry about that. I sent a v3 with all maintainers cc'ed.

Cheers,
Samuel.


> Samuel Ortiz <sameo@linux.intel.com> writes:
> 
> > This patch set provides an ACPI code reorganization in preparation for
> > adding hardware-reduced support to QEMU.
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
> > The patches are also available in their own git branch [2].
> >
> > [1] https://github.com/intel/nemu
> > [2] https://github.com/intel/nemu/tree/topic/upstream/acpi
> >
> > v1 -> v2:
> >    * Drop the hardware-reduced implementation for now. Our next patch set
> >      will add hardware-reduced and convert arm/virt to it.
> >    * Implement the ACPI build methods as a QOM Interface Class and convert
> >      the PC machine type to it.
> [...]
> 
