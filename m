Received: from eggs.gnu.org ([2001:4830:134:3::10]:33663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQyTT-0006wl-LY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQyTS-0006tI-PX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:13:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
	<20180607165955.10232-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df3686de-4a58-b1b6-592e-4f95560bbad7@amsat.org>
Date: Thu, 7 Jun 2018 14:13:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180607165955.10232-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] ppc: remove obsolete pci_pmac_init()
 definitions from mac.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 06/07/2018 01:59 PM, Mark Cave-Ayland wrote:
> Commits 7b19318bee and 8ce3f743c7 removed the pci_pmac_init() and
> pci_pmac_u3_init() functions but missed the header prototypes in mac.h. Remove
> them since they are no longer needed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/mac.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 22a7efbed6..dac96317af 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -97,12 +97,6 @@ void macio_init(PCIDevice *dev,
>  /* Grackle PCI */
>  #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
>  
> -/* UniNorth PCI */
> -UNINHostState *pci_pmac_init(qemu_irq *pic,
> -                             MemoryRegion *address_space_mem);
> -UNINHostState *pci_pmac_u3_init(qemu_irq *pic,
> -                                MemoryRegion *address_space_mem);
> -
>  /* Mac NVRAM */
>  #define TYPE_MACIO_NVRAM "macio-nvram"
>  #define MACIO_NVRAM(obj) \
> 
