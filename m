Received: from eggs.gnu.org ([2001:4830:134:3::10]:46967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRddv-0004RR-NT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRddr-0008WS-O6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:43:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRddr-0008W8-He
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:43:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so22732920wrx.9
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:43:07 -0800 (PST)
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332395124.541746.2870681084595831920.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52cb7076-b475-b09c-84e3-edfb03ee60c0@redhat.com>
Date: Tue, 27 Nov 2018 14:43:04 +0100
MIME-Version: 1.0
In-Reply-To: <154332395124.541746.2870681084595831920.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 27/11/18 14:05, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
