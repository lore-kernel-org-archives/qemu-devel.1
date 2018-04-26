Received: from eggs.gnu.org ([2001:4830:134:3::10]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fBiY2-0004Pl-Id
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fBiXx-0000R9-F2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:11:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fBiXx-0000Qc-AY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:10:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B87FD87ABE
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 15:10:50 +0000 (UTC)
Date: Thu, 26 Apr 2018 18:10:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180426180955-mutt-send-email-mst@kernel.org>
References: <20180424063857.29246-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424063857.29246-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] allocate pci id for mdpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Tue, Apr 24, 2018 at 08:38:57AM +0200, Gerd Hoffmann wrote:
> mdpy is a sample pci device for vfio-mdev.  Not (yet) merged upstream,
> patch available here:
> 
> https://www.kraxel.org/cgit/linux/commit/?h=vfio-sample-display&id=6fd86cff3d7df38ab89625b16fdd6434b1c18749
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I presume this should be merged together with the
device implementation in qemu, or do you want this
in tree sooner?

> ---
>  docs/specs/pci-ids.txt | 1 +
>  include/hw/pci/pci.h   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
> index bb99a0257e..4d53e5c7d9 100644
> --- a/docs/specs/pci-ids.txt
> +++ b/docs/specs/pci-ids.txt
> @@ -62,6 +62,7 @@ PCI devices (other than virtio):
>  1b36:000a  PCI-PCI bridge (multiseat)
>  1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
>  1b36:000d  PCI xhci usb host adapter
> +1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
>  
>  All these devices are documented in docs/specs.
>  
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a9c3ee5aa2..990d6fcbde 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -101,6 +101,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
>  #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
>  #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
> +#define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
>  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>  
>  #define FMT_PCIBUS                      PRIx64
> -- 
> 2.9.3
