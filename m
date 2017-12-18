Received: from eggs.gnu.org ([2001:4830:134:3::10]:34451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eQvOv-0002NA-0L
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eQvOu-0006ro-6s
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:24:13 -0500
Date: Mon, 18 Dec 2017 11:23:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171218132354.GB31737@localhost.localdomain>
References: <20171212053649.1109-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212053649.1109-1-ybettan@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4] pci: removed the is_express field since
 a uniform interface was inserted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.com>, "open list:nvme" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Dmitry Fleytman <dmitry@daynix.com>, Paul Burton <paul.burton@mips.com>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

On Tue, Dec 12, 2017 at 07:36:49AM +0200, Yoni Bettan wrote:
>         * according to Eduardo Habkost's commit
>           fd3b02c8896d597dd8b9e053dec579cf0386aee1
> 
>         * since all PCIEs now implement INTERFACE_PCIE_DEVICE we
>           don't need this field anymore
> 
>         * Devices that where only INTERFACE_PCIE_DEVICE (is_express == 1)
>           or
>           devices that where only INTERFACE_CONVENTIONAL_PCI_DEVICE (is_express == 0)
>           where not affected by the change
> 
>           The only devices that were affected are those that are hybrid and also
>           had (is_express == 1) - therefor only:
>             - hw/vfio/pci.c
>             - hw/usb/hcd-xhci.c

Oops, we now have xen-pt too.  See:

  From: Simon Gaiser <hw42@ipsumj.de>
  Date: Sat, 28 Oct 2017 04:53:15 +0200
  Message-Id: <20171028025315.13500-1-hw42@ipsumj.de>
  Subject: [PATCH] xen/pt: Set is_express to avoid out-of-bounds write

Which was included in a pull request sent on last Thursday.

> 
>           For both I made sure that QEMU_PCI_CAP_EXPRESS is on
> 
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
[...]

-- 
Eduardo
