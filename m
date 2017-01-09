Received: from eggs.gnu.org ([2001:4830:134:3::10]:34149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQPDt-0007IH-E3
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQPDq-0005XG-Dg
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:58:09 -0500
Date: Mon, 9 Jan 2017 03:58:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170109035746-mutt-send-email-mst@kernel.org>
References: <20170106050451.11793-1-david@gibson.dropbear.id.au>
	<53dcb2da-fa15-63b0-5849-325b6edcac83@redhat.com>
	<20170106214052-mutt-send-email-mst@kernel.org>
	<9cc108a2-4e56-e5ed-9ba4-4e0e0faac072@redhat.com>
	<20170108234824.GC12515@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170108234824.GC12515@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC] pxb: Restrict to x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Marcel Apfelbaum <marcel@redhat.com>, ehabkost@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, Jan 09, 2017 at 10:48:24AM +1100, David Gibson wrote:
> On Sun, Jan 08, 2017 at 10:17:12AM +0200, Marcel Apfelbaum wrote:
> > On 01/06/2017 09:41 PM, Michael S. Tsirkin wrote:
> > > On Fri, Jan 06, 2017 at 08:13:11AM +0200, Marcel Apfelbaum wrote:
> > > > On 01/06/2017 07:04 AM, David Gibson wrote:
> > > > > The PCI Expander Bridge (PXB) device is essentially a hack to allow
> > > > > different PCIe devices to be assigned to different NUMA nodes on x86.  Each
> > > > > PXB is sort-of a separate PCI host bridge, except that its config space
> > > > > is shared with the config space of the main PCI host bridge, rather than
> > > > > being independent.
> > > > > 
> > > > 
> > > > Hi David,
> > > > 
> > > > > This is only necessary if the platform doesn't (easily) allow truly
> > > > > independent PCI host bridges.  AFAIK that's just x86.
> > > > > 
> > > > 
> > > > Indeed, it is possible to support independent PCI host bridges on x86 by
> > > > using a separate MMCONFIG space for each one and enable separate PCI domains.
> > > > We simply didn't need this until now, but maybe will be implemented it in the future.
> > > 
> > > In fact I would say that's the cleanest way to do this on q35.
> > 
> > Message received :)
> 
> Just so I'm clear, these last two comments are essentially suggesting
> a follow up cleanup on x86, rather than suggesting a different
> approach for non-PC platforms, yes?
> 
> If there are no objections to my original patch do you want to take it
> through your tree Michael, or should I take it through mine?
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



Go ahead and take it through  yours pls.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
