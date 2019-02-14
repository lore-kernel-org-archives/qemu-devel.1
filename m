Received: from eggs.gnu.org ([209.51.188.92]:56845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1guQZv-0001AB-7d
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1guQZt-0006a2-6t
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:38:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1guQZr-0006W7-8k
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:38:00 -0500
Date: Thu, 14 Feb 2019 16:37:55 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190214163755.5e76ae62@w520.home>
In-Reply-To: <20190214051440.59167-1-aik@ozlabs.ru>
References: <20190214051440.59167-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Move NVIDIA vendor id to the
 rest of ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu, 14 Feb 2019 16:14:40 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> sPAPR code will use it too so move it from VFIO to the common code.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> 
> Previous version was RFC, this is is not.

I assume as a stand-alone patch this should go through the PCI branch,
cc'ing maintainers.

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> ---
>  include/hw/pci/pci_ids.h | 2 ++
>  hw/vfio/pci-quirks.c     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index eeb3301..0abe27a 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -271,4 +271,6 @@
>  
>  #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
>  
> +#define PCI_VENDOR_ID_NVIDIA             0x10de
> +
>  #endif
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index eae31c7..40a1200 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -526,8 +526,6 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>   * note it for future reference.
>   */
>  
> -#define PCI_VENDOR_ID_NVIDIA                    0x10de
> -
>  /*
>   * Nvidia has several different methods to get to config space, the
>   * nouveu project has several of these documented here:
