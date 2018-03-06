Received: from eggs.gnu.org ([2001:4830:134:3::10]:34390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLP8-0002Yd-KC
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLP7-0002XH-Ng
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:49:54 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9b0ee6b-f982-d5f8-6322-7860466af84d@amsat.org>
Date: Tue, 6 Mar 2018 19:49:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180306203103.25563-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/19] uninorth: trivial style fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 03/06/2018 05:30 PM, Mark Cave-Ayland wrote:
> This makes sure we keep patchew/checkpatch happy during the remainder of this
> patchset.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/uninorth.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 66991da975..710818e355 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -272,7 +272,6 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
>      UNINState *d;
>  
>      /* Uninorth AGP bus */
> -
>      dev = qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
> @@ -302,16 +301,23 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
>  
>  static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
>  {
> -    d->config[0x0C] = 0x08; // cache_line_size
> -    d->config[0x0D] = 0x10; // latency_timer
> -    d->config[0x34] = 0x00; // capabilities_pointer
> +    /* cache_line_size */
> +    d->config[0x0C] = 0x08;
> +    /* latency_timer */
> +    d->config[0x0D] = 0x10;
> +    /* capabilities_pointer */
> +    d->config[0x34] = 0x00;
>  }
>  
>  static void unin_agp_pci_host_realize(PCIDevice *d, Error **errp)
>  {
> -    d->config[0x0C] = 0x08; // cache_line_size
> -    d->config[0x0D] = 0x10; // latency_timer
> -    //    d->config[0x34] = 0x80; // capabilities_pointer
> +    /* cache_line_size */
> +    d->config[0x0C] = 0x08;
> +    /* latency_timer */
> +    d->config[0x0D] = 0x10;
> +    /* capabilities_pointer
> +    d->config[0x34] = 0x80; */
> +
>      /*
>       * Set kMacRISCPCIAddressSelect (0x48) register to indicate PCI
>       * memory space with base 0x80000000, size 0x10000000 for Apple's
> @@ -333,9 +339,12 @@ static void u3_agp_pci_host_realize(PCIDevice *d, Error **errp)
>  
>  static void unin_internal_pci_host_realize(PCIDevice *d, Error **errp)
>  {
> -    d->config[0x0C] = 0x08; // cache_line_size
> -    d->config[0x0D] = 0x10; // latency_timer
> -    d->config[0x34] = 0x00; // capabilities_pointer
> +    /* cache_line_size */
> +    d->config[0x0C] = 0x08;
> +    /* latency_timer */
> +    d->config[0x0D] = 0x10;
> +    /* capabilities_pointer */
> +    d->config[0x34] = 0x00;
>  }
>  
>  static void unin_main_pci_host_class_init(ObjectClass *klass, void *data)
> 
