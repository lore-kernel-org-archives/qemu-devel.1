Received: from eggs.gnu.org ([2001:4830:134:3::10]:48245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHo1b-00072v-ON
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHo1X-0005ud-N3
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:46:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:1213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHo1X-0005u8-Dd
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:46:55 -0400
Date: Wed, 31 Oct 2018 11:46:10 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181031104610.GC4267@caravaggio>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-10-sameo@linux.intel.com>
	<ec47ae4b-5dce-9b21-0126-04f302b701eb@redhat.com>
	<6df32467-fe8f-8821-aa20-cf8e1a7dab29@redhat.com>
	<20181030145715.GC5291@caravaggio.home>
	<16d95ea4-12a7-7372-9d4a-218108f9f2db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d95ea4-12a7-7372-9d4a-218108f9f2db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/19] hw: acpi: Export and generalize
 the PCI host AML API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Rob Bradford <robert.bradford@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Philippe,

On Tue, Oct 30, 2018 at 07:04:15PM +0100, Philippe Mathieu-Daudé wrote:
> > > > > +void acpi_get_pci_holes(Range *hole, Range *hole64)
> > > 
> > > ... and this function neither, it should stay in hw/i386/acpi-build.c, thus
> > > you don't need to modify the prototype and can call
> > > acpi_get_pci_host(x86_machine_paths) directly.
> > > 
> > So the idea for those routines is that they're not x86 specific. As a
> > matter of fact, they will eventually get called from architecture
> > agnostic code like e.g. hw/acpi/reduced.c. So I don't think they should
> > live under hw/i386/
> 
> But PCI_HOST_PROP_PCI_HOLE_START is only defined in "hw/i386/pc.h"... This
> file is no more arch agnostic.
> 
> I can understand/accept a acpi_get_pci_holes() function, but the ranges
> shouldn't be i386 based.
Agreed, and your reviews thankfully highlighted that part.
Neither acpi_get_pci_host nor acpi_get_pci_holes should be arch specific
and I'll fix that.

Cheers,
Samuel.
