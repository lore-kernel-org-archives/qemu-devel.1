Received: from eggs.gnu.org ([2001:4830:134:3::10]:54345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxUYu-0002OB-Nv
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxUYq-0002Bc-RU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:52:52 -0400
Message-ID: <1506587465.25626.27.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:31:05 +0200
In-Reply-To: <20170921013548.GB4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org> <20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/21] ppc/xive: add device tree
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On Thu, 2017-09-21 at 11:35 +1000, David Gibson wrote:
> > >> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> > >> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> > >> +
> > >> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
> > >> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> > >> +                     sizeof(eq_sizes)));
> > >> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> > >> +                     sizeof(lisn_ranges)));
> > > 
> > > I note this doesn't have the interrupt-controller or #interrupt-cells
> > > properties.  So what acts as the interrupt parent for all the devices
> > > in the tree with XIVE?
> > 
> > these properties are not in the specs anymore for the interrupt-controller
> > node and I don't think Linux makes use of them (even for XICS). So 
> > it just works fine.
> 
> Um.. what!?  Are you saying that the PAPR XIVE spec completely broke
> how interrupt specifiers have worked in the device tree since forever?
> 
> And I'm pretty sure Linux does make use of them.  Without
> #interrupt-cells, there's no way it can properly interpret the
> interrupts properties in the device nodes.

Linux does make use of them and they are in the spec, but don't confuse
the nodes for the presentation controllers vs the node for the virtual
source controller which is the one that is the root of the interrupt
tree.

Cheers,
Ben.
