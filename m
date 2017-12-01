Received: from eggs.gnu.org ([2001:4830:134:3::10]:54936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKoJR-0005BB-DO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKoJM-0003Wk-Qe
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKnzU-00087z-Uh
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:16:41 -0500
Date: Fri, 1 Dec 2017 12:27:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171201042734.GA2712@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-2-david@gibson.dropbear.id.au>
	<20171130061721.GB22901@xz-mi>
	<20171201000250.GB30161@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171201000250.GB30161@umbus.fritz.box>
Subject: Re: [Qemu-devel] [for-2.12 1/7] pci: Rename root bus initialization
 functions for clarity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 01, 2017 at 11:02:50AM +1100, David Gibson wrote:
> On Thu, Nov 30, 2017 at 02:17:21PM +0800, Peter Xu wrote:
> > On Wed, Nov 29, 2017 at 07:46:22PM +1100, David Gibson wrote:
> > > pci_bus_init(), pci_bus_new_inplace(), pci_bus_new() and pci_register_bus()
> > > are misleadingly named.  They're not used for initializing *any* PCI bus,
> > > but only for a root PCI bus.
> > > 
> > > Non-root buses - i.e. ones under a logical PCI to PCI bridge - are instead
> > > created with a direct qbus_create_inplace() (see pci_bridge_initfn()).
> > > 
> > > This patch renames the functions to make it clear they're only used for
> > > a root bus.
> > > 
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> > An optional nit: would it be nice to name the new functions as:
> > pci_bus_root_*()?  Say, I would prefer pci_bus_root_new() than
> > pci_root_bus_new() since root bus is still a specific type of bus.
> 
> Hrm,.  *_bus_root_* reads very strangely to me, I find it less clear
> than ..._root_bus_...

Sure.  I'm also fine to keep it the old way.  Thanks,

-- 
Peter Xu
