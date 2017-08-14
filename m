Received: from eggs.gnu.org ([2001:4830:134:3::10]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=392c10cbc=anthony.perard@citrix.com>)
	id 1dhGmb-0005r8-CB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=392c10cbc=anthony.perard@citrix.com>)
	id 1dhGmY-0007Yw-Oi
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:55:57 -0400
Received: from smtp.citrix.com ([66.165.176.89]:17879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=392c10cbc=anthony.perard@citrix.com>)
	id 1dhGmY-0007Xl-Ij
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:55:54 -0400
Date: Mon, 14 Aug 2017 15:55:50 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170814145550.GA1475@perard.uk.xensource.com>
References: <20170811151138.29405-1-anthony.perard@citrix.com>
	<20170811151138.29405-2-anthony.perard@citrix.com>
	<20170811201006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170811201006-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] hw/acpi: Call
 acpi_set_pci_info when no ACPI tables needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Aug 11, 2017 at 08:18:28PM +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 11, 2017 at 04:11:37PM +0100, Anthony PERARD wrote:
> > To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
> > set, but this was done only when ACPI tables are built which is not
> > needed for a Xen guest. The need for the property starts with commit
> > "pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
> > (f0c9d64a68b776374ec4732424a3e27753ce37b6).
> > 
> > Set pci info before checking for the needs to build ACPI tables.
> > 
> > Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> > Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> I am worried that Xen will come to depend on specific
> assignment of bsel which isn't guaranteed. Thoughts on
> how to avoid that?

Is it possible to have a different BSEL than 0 with PIIX ?
Also, I don't known if having more than on PCI bus is going to work on
Xen, there is nothing in our ACPI tables beyond _SB.PCI0, and nothing to
use a different BSEL.

> > 
> > ---
> > In this patch rather than always calling acpi_set_pci_info() when
> > acpi_setup() is called, we could check first for acpi_enabled? (which is
> > true for Xen.)
> 
> Yes, please change it like this. Also, please add
> a comment explainging what it does.

Will do.

-- 
Anthony PERARD
