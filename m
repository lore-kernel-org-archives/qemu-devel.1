Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWq-0004jo-OC
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWn-0005QX-HZ
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:36 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWn-0005QK-BB
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:33 -0500
Received: by mail-qk0-x242.google.com with SMTP id w125so29616704qkb.6
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 08:11:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1511703326-25325-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <02fa5b73-6c36-0eab-5414-91446aed2686@amsat.org>
Date: Sun, 26 Nov 2017 12:13:41 -0300
MIME-Version: 1.0
In-Reply-To: <1511703326-25325-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] sun4m: move IOMMU declarations from
 sun4m.h to sun4m_iommu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/26/2017 10:35 AM, Mark Cave-Ayland wrote:
> Also updating the relevant .c files as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c           |    1 +
>  hw/sparc/sun4m.c               |    1 +
>  hw/sparc/sun4m_iommu.c         |    1 +
>  include/hw/sparc/sun4m.h       |   21 -----------------
>  include/hw/sparc/sun4m_iommu.h |   51 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 54 insertions(+), 21 deletions(-)
>  create mode 100644 include/hw/sparc/sun4m_iommu.h
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 01afb75..c04ad79 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -29,6 +29,7 @@
>  #include "hw/hw.h"
>  #include "hw/sparc/sparc32_dma.h"
>  #include "hw/sparc/sun4m.h"
> +#include "hw/sparc/sun4m_iommu.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/dma.h"
>  #include "qapi/error.h"
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 24c2b8a..a3ba92f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -29,6 +29,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
>  #include "hw/sparc/sun4m.h"
> +#include "hw/sparc/sun4m_iommu.h"
>  #include "hw/timer/m48t59.h"
>  #include "hw/sparc/sparc32_dma.h"
>  #include "hw/block/fdc.h"
> diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
> index 72a9af5..311c82d 100644
> --- a/hw/sparc/sun4m_iommu.c
> +++ b/hw/sparc/sun4m_iommu.c
> @@ -24,6 +24,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/sparc/sun4m.h"
> +#include "hw/sparc/sun4m_iommu.h"
>  #include "hw/sysbus.h"
>  #include "exec/address-spaces.h"
>  #include "trace.h"
> diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
> index c557b0d..9e06467 100644
> --- a/include/hw/sparc/sun4m.h
> +++ b/include/hw/sparc/sun4m.h
> @@ -8,27 +8,6 @@
>  
>  /* Devices used by sparc32 system.  */
>  
> -/* iommu.c */
> -#define TYPE_SUN4M_IOMMU "sun4m-iommu"
> -#define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
> -
> -#define TYPE_SUN4M_IOMMU_MEMORY_REGION "sun4m-iommu-memory-region"
> -
> -#define IOMMU_NREGS         (4 * 4096 / 4)
> -
> -typedef struct IOMMUState {
> -    SysBusDevice parent_obj;
> -
> -    AddressSpace iommu_as;
> -    IOMMUMemoryRegion iommu;
> -
> -    MemoryRegion iomem;
> -    uint32_t regs[IOMMU_NREGS];
> -    hwaddr iostart;
> -    qemu_irq irq;
> -    uint32_t version;
> -} IOMMUState;
> -
>  /* sparc32_dma.c */
>  #include "hw/sparc/sparc32_dma.h"
>  
> diff --git a/include/hw/sparc/sun4m_iommu.h b/include/hw/sparc/sun4m_iommu.h
> new file mode 100644
> index 0000000..938937eb
> --- /dev/null
> +++ b/include/hw/sparc/sun4m_iommu.h
> @@ -0,0 +1,51 @@
> +/*
> + * QEMU Sun4m iommu emulation
> + *
> + * Copyright (c) 2003-2005 Fabrice Bellard
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
> +#ifndef SUN4M_IOMMU_H
> +#define SUN4M_IOMMU_H
> +
> +#include "qemu-common.h"
> +#include "hw/sysbus.h"
> +
> +#define IOMMU_NREGS         (4 * 4096 / 4)
> +
> +typedef struct IOMMUState {
> +    SysBusDevice parent_obj;
> +
> +    AddressSpace iommu_as;
> +    IOMMUMemoryRegion iommu;
> +
> +    MemoryRegion iomem;
> +    uint32_t regs[IOMMU_NREGS];
> +    hwaddr iostart;
> +    qemu_irq irq;
> +    uint32_t version;
> +} IOMMUState;
> +
> +#define TYPE_SUN4M_IOMMU "sun4m-iommu"
> +#define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
> +
> +#define TYPE_SUN4M_IOMMU_MEMORY_REGION "sun4m-iommu-memory-region"
> +
> +#endif
> 
