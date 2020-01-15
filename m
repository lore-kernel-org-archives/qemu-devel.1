Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A85C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D3F2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D3F2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqJX-0006Bn-Lc
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 16:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1irqIa-0004zN-Rk
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1irqIY-0000Ld-FE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:34:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:23544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1irqIY-0000EU-4A; Wed, 15 Jan 2020 16:33:58 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5306C7475F9;
 Wed, 15 Jan 2020 22:33:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9B75274594E; Wed, 15 Jan 2020 22:33:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 996A97456F8;
 Wed, 15 Jan 2020 22:33:46 +0100 (CET)
Date: Wed, 15 Jan 2020 22:33:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
In-Reply-To: <1579100861-73692-67-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-67-git-send-email-imammedo@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Subject line is still wrong, it's sam460ex not sam460x. Also you change 
ppc:whatever to ppc/whatever here but left : as path separator in all 
other patches. This is not consistent with other commits where the tag in 
the title is usually a path of the changed part or in this case could be 
ppc/ arm/ etc. Colon as path separator looks weird so I think this change 
should be done for all patches to match other commits not just this one,

On Wed, 15 Jan 2020, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported or sometimes
> crash like this:
>  %QEMU -M bamboo -m 1
>    exec.c:1926: find_ram_offset: Assertion `size != 0' failed.
>    Aborted (core dumped)
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
> That also fixes crash issue, since wrongly calculated size
> isn't used to allocate RAM
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>  * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
>     (BALATON Zoltan <balaton@eik.bme.hu>)

Thanks but prep is not a good name in PPC context as one of the arch 
standards is also called that (PowerPC Reference Platform or PReP) so 
using that here is ambiguous. Better spell it out or call it something 
else (such as ppc4xx_sdram_banks).

>  * print possible valid ram size id not all RAM was distributed
>  * initialize ram_bases/ram_bases at the same time we are checking
>    that user supplied RAM would fit available banks and drop nested
>    loop that were duplicating the same calculations.
>  * coincidentally fix crash when -m is less than minimal bank size
>
> CC: balaton@eik.bme.hu
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
> include/hw/ppc/ppc4xx.h |  9 ++++----
> hw/ppc/ppc440_bamboo.c  | 11 ++++------
> hw/ppc/ppc4xx_devs.c    | 56 +++++++++++++++++++++++++------------------------
> hw/ppc/sam460ex.c       |  5 ++---
> 4 files changed, 39 insertions(+), 42 deletions(-)
>
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 7d82259..103c875 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -42,11 +42,10 @@ enum {
> qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
>                        uint32_t dcr_base, int has_ssr, int has_vr);
>
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[]);
> +void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
> +                       MemoryRegion ram_memories[],
> +                       hwaddr ram_bases[], hwaddr ram_sizes[],
> +                       const ram_addr_t sdram_bank_sizes[]);
>
> void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>                         MemoryRegion ram_memories[],
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index b782641..c162598 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -158,7 +158,6 @@ static void main_cpu_reset(void *opaque)
>
> static void bamboo_init(MachineState *machine)
> {
> -    ram_addr_t ram_size = machine->ram_size;
>     const char *kernel_filename = machine->kernel_filename;
>     const char *kernel_cmdline = machine->kernel_cmdline;
>     const char *initrd_filename = machine->initrd_filename;
> @@ -203,10 +202,8 @@ static void bamboo_init(MachineState *machine)
>     /* SDRAM controller */
>     memset(ram_bases, 0, sizeof(ram_bases));
>     memset(ram_sizes, 0, sizeof(ram_sizes));
> -    ram_size = ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
> -                                   ram_memories,
> -                                   ram_bases, ram_sizes,
> -                                   ppc440ep_sdram_bank_sizes);
> +    ppc4xx_sdram_prep(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> +                      ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
>     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
>     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
>                       ram_bases, ram_sizes, 1);
> @@ -268,7 +265,7 @@ static void bamboo_init(MachineState *machine)
>     /* Load initrd. */
>     if (initrd_filename) {
>         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
> -                                          ram_size - RAMDISK_ADDR);
> +                                          machine->ram_size - RAMDISK_ADDR);
>
>         if (initrd_size < 0) {
>             error_report("could not load ram disk '%s' at %x",
> @@ -279,7 +276,7 @@ static void bamboo_init(MachineState *machine)
>
>     /* If we're loading a kernel directly, we must load the device tree too. */
>     if (kernel_filename) {
> -        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
> +        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK_ADDR,
>                                     initrd_size, kernel_cmdline) < 0) {
>             error_report("couldn't load device tree");
>             exit(1);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index c2e5013..92d33a4 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -673,16 +673,16 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>  * The 4xx SDRAM controller supports a small number of banks, and each bank
>  * must be one of a small set of sizes. The number of banks and the supported
>  * sizes varies by SoC. */
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[])
> +void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
> +                       MemoryRegion ram_memories[],
> +                       hwaddr ram_bases[], hwaddr ram_sizes[],
> +                       const ram_addr_t sdram_bank_sizes[])
> {
>     MemoryRegion *ram = g_malloc0(sizeof(*ram));
>     ram_addr_t size_left = ram_size;
>     ram_addr_t base = 0;
>     ram_addr_t bank_size;
> +    int last_bank = 0;
>     int i;
>     int j;
>
> @@ -690,7 +690,11 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
>             bank_size = sdram_bank_sizes[j];
>             if (bank_size <= size_left) {
> +                ram_bases[i] = base;
> +                ram_sizes[i] = bank_size;
> +                base += bank_size;
>                 size_left -= bank_size;
> +                last_bank = i;
>             }
>         }
>         if (!size_left) {
> @@ -699,34 +703,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>         }
>     }
>
> -    ram_size -= size_left;
>     if (size_left) {
> -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> -                     " controller limits", ram_size / MiB);
> +        ram_addr_t used_size = ram_size - size_left;
> +        GString *s = g_string_new(NULL);
> +
> +        for (i = 0; sdram_bank_sizes[i]; i++) {
> +            g_string_append_printf(s, "%" PRIi64 "%s",
> +                                   sdram_bank_sizes[i] / MiB,
> +                                   sdram_bank_sizes[i + 1] ? " ," : "");
> +        }
> +        error_report("Max %d banks of %s MB DIMM/bank supported",
> +            nr_banks, s->str);
> +        error_report("Possible valid RAM size: %" PRIi64,
> +            used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
> +
> +        g_string_free(s, true);
> +        exit(EXIT_FAILURE);

This is certainly better than to just bail out and let the user wonder 
what would work but I've not yet given up to keep current functionality 
(also for other boards where this series would drop it). If you don't like 
a generic callback then how about letting the board optionally specify in 
the machine class next to default_ram_size some constraints such as 
min_ram_size, max_ram_size and an array of valid_ram_sizes (like 
ppc460ex_sdram_bank_sizes[]) that the generic code doing the allocation 
could check and clamp sizes to the nearest valid one emitting a warning 
and only bail out if constraints are not given. This would cover most 
cases expect the e500 where it has an alignment without max so 
representing it as a list of valid values is probably not practical (could 
also have ram_alignment but then a generic callback may be simpler). Would 
that way work for you?

Regards,
BALATON Zoltan

>     }
>
>     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
>
> -    size_left = ram_size;
> -    for (i = 0; i < nr_banks && size_left; i++) {
> -        for (j = 0; sdram_bank_sizes[j] != 0; j++) {
> -            bank_size = sdram_bank_sizes[j];
> -
> -            if (bank_size <= size_left) {
> -                char name[32];
> -                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> -                memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> -                                         base, bank_size);
> -                ram_bases[i] = base;
> -                ram_sizes[i] = bank_size;
> -                base += bank_size;
> -                size_left -= bank_size;
> -                break;
> -            }
> -        }
> +    for (i = 0; i <= last_bank; i++) {
> +        char name[32];
> +        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> +        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> +                                 ram_bases[i], ram_sizes[i]);
>     }
> -
> -    return ram_size;
> }
>
> /*****************************************************************************/
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 437e214..ec7ac1f 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
>     /* SDRAM controller */
>     /* put all RAM on first bank because board has one slot
>      * and firmware only checks that */
> -    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
> -                                   ram_memories, ram_bases, ram_sizes,
> -                                   ppc460ex_sdram_bank_sizes);
> +    ppc4xx_sdram_prep(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
> +                      ppc460ex_sdram_bank_sizes);
>
>     /* FIXME: does 460EX have ECC interrupts? */
>     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
>

