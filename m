Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eRKyU-0001Ee-E6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eRKyT-0006UM-LS
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:42:38 -0500
Date: Tue, 19 Dec 2017 14:42:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171219164218.GB4836@localhost.localdomain>
References: <20171218152140.17985-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218152140.17985-1-ybettan@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5] pci: removed the is_express field since
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:nvme" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Dmitry Fleytman <dmitry@daynix.com>, Paul Burton <paul.burton@mips.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

On Mon, Dec 18, 2017 at 05:21:40PM +0200, Yoni Bettan wrote:
> according to Eduardo Habkost's commit fd3b02c889 all PCIEs now implement
> INTERFACE_PCIE_DEVICE so we don't need is_express field anymore.
> 
> Devices that implements only INTERFACE_PCIE_DEVICE (is_express == 1)
> or
> devices that implements only INTERFACE_CONVENTIONAL_PCI_DEVICE (is_express == 0)
> where not affected by the change.
> 
> The only devices that were affected are those that are hybrid and also
> had (is_express == 1) - therefor only:
>   - hw/vfio/pci.c
>   - hw/usb/hcd-xhci.c
>   - hw/xen/xen_pt.c
> 
> For those 3 I made sure that QEMU_PCI_CAP_EXPRESS is on in instance_init()
> 
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
