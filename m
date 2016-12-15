Received: from eggs.gnu.org ([2001:4830:134:3::10]:48879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cHe3q-0003Sd-34
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 16:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cHe3l-0001S4-AS
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 16:59:34 -0500
Message-ID: <1481839150.15937.4.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 15 Dec 2016 15:59:10 -0600
In-Reply-To: <7c5450f6-2688-d643-d020-2dcb92e8e52a@redhat.com>
References: <1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
	<491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
	<20161214024616.GE32647@umbus>
	<7c5450f6-2688-d643-d020-2dcb92e8e52a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr_pci: Create
 PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Andrea Bolognani <abologna@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcel Apfelbaum <mapfelba@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 2016-12-14 at 20:26 +0200, Marcel Apfelbaum wrote:
> > > The Root complex includes the PCI bus, some configuration
> > > registers if
> > > needed, provides access to the configuration space, translates
> > > relevant CPU
> > > reads/writes to PCI(e) transactions...
> > 
> > Do those configuration registers appear within PCI space, or
> > outside
> > it (e.g. raw MMIO or PIO registers)?
> > 
> 
> Root Complexes use MMIO to expose the PCI configuration space,
> they call it ECAM (enhanced configuration access mechanism) or
> MMConfig.

Not all of them do. There are plenty of PCIe RCs out there that
do config space using different mechanisms such as the good old
indirect address/data method, such as ours. IE. Even in real "bare
metal" powernv, where the root port is visible to Linux, we still
go through firmware for config space to get through to those
registers (among other things).

My PHB3 implementation (not upstream yet and a bit bitrotted by now)
exposed PCIe that way including extended config space and that was
working fine.

Cheers,
Ben.
