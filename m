Received: from eggs.gnu.org ([2001:4830:134:3::10]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gRdw2-0003oy-8V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gRdvw-00053j-9c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:01:54 -0500
Date: Tue, 27 Nov 2018 15:01:22 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181127140122.GE20151@toto>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332395124.541746.2870681084595831920.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154332395124.541746.2870681084595831920.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/9] ppc440_bamboo: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, Nov 27, 2018 at 02:05:51PM +0100, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  hw/ppc/ppc440_bamboo.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index f5720f979e42..b8aa55d52669 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -169,8 +169,7 @@ static void bamboo_init(MachineState *machine)
>      unsigned int pci_irq_nrs[4] = { 28, 27, 26, 25 };
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *isa = g_new(MemoryRegion, 1);
> -    MemoryRegion *ram_memories
> -        = g_malloc(PPC440EP_SDRAM_NR_BANKS * sizeof(*ram_memories));
> +    MemoryRegion *ram_memories = g_new(MemoryRegion, PPC440EP_SDRAM_NR_BANKS);
>      hwaddr ram_bases[PPC440EP_SDRAM_NR_BANKS];
>      hwaddr ram_sizes[PPC440EP_SDRAM_NR_BANKS];
>      qemu_irq *pic;
> @@ -200,7 +199,7 @@ static void bamboo_init(MachineState *machine)
>      ppc_dcr_init(env, NULL, NULL);
>  
>      /* interrupt controller */
> -    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
>      pic = ppcuic_init(env, irqs, 0x0C0, 0, 1);
> 
