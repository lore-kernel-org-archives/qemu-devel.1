Received: from eggs.gnu.org ([2001:4830:134:3::10]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUrew-0000Ql-IR
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUres-0008Or-CS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:17:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gUres-0008OU-4G
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:17:30 -0500
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394082769.28192.14712045129466115638.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a050ab6c-7eff-4e40-e0e4-0683ecc27981@redhat.com>
Date: Thu, 6 Dec 2018 12:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <154394082769.28192.14712045129466115638.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 7/9] vfio/pci: Remove PCIe Link
 Status emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>

Hi
On 12/4/18 5:27 PM, Alex Williamson wrote:
> Now that the downstream port will virtually negotiate itself to the
> link status of the downstream devie, we can remove this emulation.
s/devie/device
> It's not clear that it was every terribly useful anyway.
> 
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

> ---
>  hw/vfio/pci.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 74f9a46b4be0..c0cb1ec28908 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1901,12 +1901,6 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                             QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
>              vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
>          }
> -
> -        /* Mark the Link Status bits as emulated to allow virtual negotiation */
> -        vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA,
> -                               pci_get_word(vdev->pdev.config + pos +
> -                                            PCI_EXP_LNKSTA),
> -                               PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>      }
>  
>      /*
> 
> 
