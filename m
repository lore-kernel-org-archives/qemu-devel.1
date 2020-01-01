Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC14C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695EC2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695EC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imcaw-0006pV-Ej
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 06:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1imcaK-0006Pl-4W
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1imcaI-0003YN-BQ
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:54:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:38128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1imcaI-0003PK-1h
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:54:42 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 38872745712;
 Wed,  1 Jan 2020 12:54:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 99A96745953; Wed,  1 Jan 2020 12:54:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9765E745702;
 Wed,  1 Jan 2020 12:54:37 +0100 (CET)
Date: Wed, 1 Jan 2020 12:54:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 66/86] ppc:ppc440_bamboo/sam460ex: drop RAM size fixup
In-Reply-To: <1577797450-88458-67-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001011235410.5612@zero.eik.bme.hu>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-67-git-send-email-imammedo@redhat.com>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Dec 2019, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> include/hw/ppc/ppc4xx.h |  9 ++++-----
> hw/ppc/ppc440_bamboo.c  | 11 ++++-------
> hw/ppc/ppc4xx_devs.c    | 26 ++++++++++++++++----------
> hw/ppc/sam460ex.c       |  5 ++---
> 4 files changed, 26 insertions(+), 25 deletions(-)
>
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 7d82259..1a28127 100644
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
> +void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> +                         MemoryRegion ram_memories[],
> +                         hwaddr ram_bases[], hwaddr ram_sizes[],
> +                         const ram_addr_t sdram_bank_sizes[]);

With this change this function does not adjust ram size any more so it may 
need to be renamed, e.g. ppc4xx_sdram_banks or something else.

A better patch title may be

ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup

(or without curly braces at your preference).

This is inconvenient for the user because it worked whatever number 
they've given but now they have to do the math. So it suggests that what 
you're replacing this with may not support all the existing use cases. If 
that can't be fixed to allow checking and changing ram size (maybe via a 
callback in board code similar to above adjust function returning adjusted 
size) it may be OK to drop this convenience for the sake of cleaning up 
code elsewhere.

Regards,
BALATON Zoltan

> void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>                         MemoryRegion ram_memories[],
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 4d95c0f..66dee89 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -162,7 +162,6 @@ static void main_cpu_reset(void *opaque)
>
> static void bamboo_init(MachineState *machine)
> {
> -    ram_addr_t ram_size = machine->ram_size;
>     const char *kernel_filename = machine->kernel_filename;
>     const char *kernel_cmdline = machine->kernel_cmdline;
>     const char *initrd_filename = machine->initrd_filename;
> @@ -207,10 +206,8 @@ static void bamboo_init(MachineState *machine)
>     /* SDRAM controller */
>     memset(ram_bases, 0, sizeof(ram_bases));
>     memset(ram_sizes, 0, sizeof(ram_sizes));
> -    ram_size = ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
> -                                   ram_memories,
> -                                   ram_bases, ram_sizes,
> -                                   ppc440ep_sdram_bank_sizes);
> +    ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> +                        ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
>     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
>     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
>                       ram_bases, ram_sizes, 1);
> @@ -272,7 +269,7 @@ static void bamboo_init(MachineState *machine)
>     /* Load initrd. */
>     if (initrd_filename) {
>         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
> -                                          ram_size - RAMDISK_ADDR);
> +                                          machine->ram_size - RAMDISK_ADDR);
>
>         if (initrd_size < 0) {
>             error_report("could not load ram disk '%s' at %x",
> @@ -283,7 +280,7 @@ static void bamboo_init(MachineState *machine)
>
>     /* If we're loading a kernel directly, we must load the device tree too. */
>     if (kernel_filename) {
> -        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
> +        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK_ADDR,
>                                     initrd_size, kernel_cmdline) < 0) {
>             error_report("couldn't load device tree");
>             exit(1);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index c2e5013..54af296 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -673,11 +673,10 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>  * The 4xx SDRAM controller supports a small number of banks, and each bank
>  * must be one of a small set of sizes. The number of banks and the supported
>  * sizes varies by SoC. */
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[])
> +void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> +                         MemoryRegion ram_memories[],
> +                         hwaddr ram_bases[], hwaddr ram_sizes[],
> +                         const ram_addr_t sdram_bank_sizes[])
> {
>     MemoryRegion *ram = g_malloc0(sizeof(*ram));
>     ram_addr_t size_left = ram_size;
> @@ -699,10 +698,19 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>         }
>     }
>
> -    ram_size -= size_left;
>     if (size_left) {
> -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> -                     " controller limits", ram_size / MiB);
> +        char *s = g_strdup("");
> +        for (i = 0; sdram_bank_sizes[i]; i++) {
> +            char *t = g_strdup_printf("%s%" PRIi64 "%s", s, sdram_bank_sizes[i],
> +                                      sdram_bank_sizes[i + 1] ? " ," : "");
> +            g_free(s);
> +            s = t;
> +        }
> +        error_report("Invalid RAM size, unable to fit all RAM into RAM banks"
> +                     " (unassigned RAM: %" PRIi64 ")",  size_left);
> +        error_report("Supported: %d banks and sizes/bank: %s", nr_banks, s);
> +        g_free(s);
> +        exit(EXIT_FAILURE);
>     }
>
>     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
> @@ -725,8 +733,6 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>             }
>         }
>     }
> -
> -    return ram_size;
> }
>
> /*****************************************************************************/
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 437e214..f592816 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
>     /* SDRAM controller */
>     /* put all RAM on first bank because board has one slot
>      * and firmware only checks that */
> -    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
> -                                   ram_memories, ram_bases, ram_sizes,
> -                                   ppc460ex_sdram_bank_sizes);
> +    ppc4xx_sdram_adjust(machine->ram_size, 1, ram_memories, ram_bases,
> +                        ram_sizes, ppc460ex_sdram_bank_sizes);
>
>     /* FIXME: does 460EX have ECC interrupts? */
>     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
>

