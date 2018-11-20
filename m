Received: from eggs.gnu.org ([2001:4830:134:3::10]:45825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPAkY-00087C-2I
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPAkT-0001ns-Rc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:47 -0500
MIME-Version: 1.0
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-4-aik@ozlabs.ru>
In-Reply-To: <20181113083104.2692-4-aik@ozlabs.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Nov 2018 10:27:05 -0800
Message-ID: <CAKmqyKOOp0Nv7wqL_=s6f_1hep==bicXKofnhYo_puResrjNRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/7] pci: Move NVIDIA vendor id to
 the rest of ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, joserz@linux.ibm.com, Alistair Popple <alistair@popple.id.au>, alex.williamson@redhat.com, sbobroff@linux.ibm.com, pjaroszynski@nvidia.com, "open list:New World" <qemu-ppc@nongnu.org>, lagarcia@br.ibm.com, oohall@gmail.com, arbab@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>

On Tue, Nov 13, 2018 at 12:42 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> sPAPR code will use it too so move it from VFIO to the common code.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/pci/pci_ids.h | 2 ++
>  hw/vfio/pci-quirks.c     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 63acc72..3ed7d10 100644
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
> --
> 2.17.1
>
>
