Received: from eggs.gnu.org ([2001:4830:134:3::10]:34540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLQ7-0003D8-1O
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLQ5-0003Gc-SO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:50:55 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65d567a0-d712-979f-6559-30bbffa80e20@amsat.org>
Date: Tue, 6 Mar 2018 19:50:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180306203103.25563-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/19] uninorth: move uninorth definitions
 into uninorth.h
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
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/uninorth.c         | 22 +------------------
>  include/hw/pci-host/uninorth.h | 49 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 21 deletions(-)
>  create mode 100644 include/hw/pci-host/uninorth.h
> 
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 1d4d3f5705..600d675573 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -26,31 +26,11 @@
>  #include "hw/ppc/mac.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci-host/uninorth.h"
>  #include "trace.h"
>  
>  static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };
>  
> -#define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
> -#define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
> -#define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-pcihost"
> -#define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
> -
> -#define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
> -#define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
> -#define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE)
> -#define U3_AGP_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
> -
> -typedef struct UNINState {
> -    PCIHostState parent_obj;
> -
> -    MemoryRegion pci_mmio;
> -    MemoryRegion pci_hole;
> -} UNINState;
> -
>  static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      return (irq_num + (pci_dev->devfn >> 3)) & 3;
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
> new file mode 100644
> index 0000000000..9364c14bdd
> --- /dev/null
> +++ b/include/hw/pci-host/uninorth.h
> @@ -0,0 +1,49 @@
> +/*
> + * QEMU Uninorth PCI host (for all Mac99 and newer machines)
> + *
> + * Copyright (c) 2006 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef UNINORTH_H
> +#define UNINORTH_H

missing:

#include "hw/hw.h"

with it:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
> +#define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
> +#define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
> +#define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-pcihost"
> +#define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
> +
> +#define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
> +#define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
> +#define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE)
> +#define U3_AGP_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
> +
> +typedef struct UNINState {
> +    PCIHostState parent_obj;
> +
> +    MemoryRegion pci_mmio;
> +    MemoryRegion pci_hole;
> +} UNINState;
> +
> +#endif /* UNINORTH_H */
> 
