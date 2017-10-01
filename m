Received: from eggs.gnu.org ([2001:4830:134:3::10]:39494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTIV-0007JP-D5
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTIR-0001cM-ST
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:43:59 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTIR-0001bz-MV
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:43:55 -0400
Received: by mail-qk0-x242.google.com with SMTP id q8so1972414qkl.5
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:43:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<6c7e6a1bed5381cf59c9e7bfb20d241dd3e29f39.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c401a09-fe34-2fb0-a174-c75b38b11b07@amsat.org>
Date: Sat, 30 Sep 2017 22:43:51 -0300
MIME-Version: 1.0
In-Reply-To: <6c7e6a1bed5381cf59c9e7bfb20d241dd3e29f39.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 31/47] hw/pci*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, alistair23@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:16 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/pci-host/bonito.c |  6 +++---
>   hw/pci/pci.c         | 10 +++++-----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 1767d2af61..48fef86c05 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -38,7 +38,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/pci/pci.h"
>   #include "hw/i386/pc.h"
> @@ -449,8 +449,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque, hwaddr addr)
>       regno = (cfgaddr & BONITO_PCICONF_REG_MASK) >> BONITO_PCICONF_REG_OFFSET;
>   
>       if (idsel == 0) {
> -        fprintf(stderr, "error in bonito pci config address " TARGET_FMT_plx
> -            ",pcimap_cfg=%x\n", addr, s->regs[BONITO_PCIMAP_CFG]);
> +        error_report("error in bonito pci config address " TARGET_FMT_plx
> +            ",pcimap_cfg=%x", addr, s->regs[BONITO_PCIMAP_CFG]);
>           exit(1);
>       }
>       pciaddr = PCI_ADDR(pci_bus_num(phb->bus), devno, funno, regno);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88eba..1c8395d319 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -515,7 +515,7 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
>       for (i = 0; i < PCI_NUM_PINS; ++i) {
>           irq_state[i] = qemu_get_be32(f);
>           if (irq_state[i] != 0x1 && irq_state[i] != 0) {
> -            fprintf(stderr, "irq state %d: must be 0 or 1.\n",
> +            error_report("irq state %d: must be 0 or 1.",

Maybe drop the trailing dot?

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>                       irq_state[i]);
>               return -EINVAL;
>           }
> @@ -678,7 +678,7 @@ static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
>       unsigned slot;
>   
>       if (!root) {
> -        fprintf(stderr, "No primary PCI bus\n");
> +        error_report("No primary PCI bus");
>           return NULL;
>       }
>   
> @@ -694,7 +694,7 @@ static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
>       }
>   
>       if (dom != 0) {
> -        fprintf(stderr, "No support for non-zero PCI domains\n");
> +        error_report("No support for non-zero PCI domains");
>           return NULL;
>       }
>   
> @@ -1118,8 +1118,8 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
>       assert(region_num >= 0);
>       assert(region_num < PCI_NUM_REGIONS);
>       if (size & (size-1)) {
> -        fprintf(stderr, "ERROR: PCI region size must be pow2 "
> -                    "type=0x%x, size=0x%"FMT_PCIBUS"\n", type, size);
> +        error_report("ERROR: PCI region size must be pow2 "
> +                    "type=0x%x, size=0x%"FMT_PCIBUS"", type, size);
>           exit(1);
>       }
>   
> 
