Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790DDC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B092073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwzLIHep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B092073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPAE-00035F-7E
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1isP9F-0002IM-Fx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1isP9C-00063y-02
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:46:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1isP9B-00063C-QX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579257997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5wwaP9Txo63JhLnMcoYquTE9GGAlLcQ/LbmE2yXTOI=;
 b=DwzLIHeplDa77yjUBeLovBAnZxEDcB5TByM6oRYd7IsH8f6Fc5sf/u43ku6tNsB2hMhXTT
 TQ+epI/gIejakzKkLH5QO/iVJCgoL2Mgb6YgcI+QAuSc/0AE90HH63qwrgqQ6MV7eAEao2
 fHGzipTwNna9mpTt0N74nM6mf7OI/A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-rWE-dVysPFa8OLSdtINN2g-1; Fri, 17 Jan 2020 05:46:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1BCF18B5F72;
 Fri, 17 Jan 2020 10:46:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF36E845AA;
 Fri, 17 Jan 2020 10:46:30 +0000 (UTC)
Date: Fri, 17 Jan 2020 11:46:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
Message-ID: <20200117114629.5b245c83@redhat.com>
In-Reply-To: <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: rWE-dVysPFa8OLSdtINN2g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 22:33:46 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> Subject line is still wrong, it's sam460ex not sam460x. Also you change 
> ppc:whatever to ppc/whatever here but left : as path separator in all 
> other patches. This is not consistent with other commits where the tag in 
> the title is usually a path of the changed part or in this case could be 
> ppc/ arm/ etc. Colon as path separator looks weird so I think this change 
> should be done for all patches to match other commits not just this one,
> 
> On Wed, 15 Jan 2020, Igor Mammedov wrote:
> > If user provided non-sense RAM size, board will complain and
> > continue running with max RAM size supported or sometimes
> > crash like this:
> >  %QEMU -M bamboo -m 1
> >    exec.c:1926: find_ram_offset: Assertion `size != 0' failed.
> >    Aborted (core dumped)
> > Also RAM is going to be allocated by generic code, so it won't be
> > possible for board to fix things up for user.
> >
> > Make it error message and exit to force user fix CLI,
> > instead of accepting non-sense CLI values.
> > That also fixes crash issue, since wrongly calculated size
> > isn't used to allocate RAM
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >  * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
> >     (BALATON Zoltan <balaton@eik.bme.hu>)  
> 
> Thanks but prep is not a good name in PPC context as one of the arch 
> standards is also called that (PowerPC Reference Platform or PReP) so 
> using that here is ambiguous. Better spell it out or call it something 
> else (such as ppc4xx_sdram_banks).
Thanks, I'll change it as suggested

> 
> >  * print possible valid ram size id not all RAM was distributed
> >  * initialize ram_bases/ram_bases at the same time we are checking
> >    that user supplied RAM would fit available banks and drop nested
> >    loop that were duplicating the same calculations.
> >  * coincidentally fix crash when -m is less than minimal bank size
> >
> > CC: balaton@eik.bme.hu
> > CC: david@gibson.dropbear.id.au
> > CC: qemu-ppc@nongnu.org
> > ---
> > include/hw/ppc/ppc4xx.h |  9 ++++----
> > hw/ppc/ppc440_bamboo.c  | 11 ++++------
> > hw/ppc/ppc4xx_devs.c    | 56 +++++++++++++++++++++++++------------------------
> > hw/ppc/sam460ex.c       |  5 ++---
> > 4 files changed, 39 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> > index 7d82259..103c875 100644
> > --- a/include/hw/ppc/ppc4xx.h
> > +++ b/include/hw/ppc/ppc4xx.h
> > @@ -42,11 +42,10 @@ enum {
> > qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
> >                        uint32_t dcr_base, int has_ssr, int has_vr);
> >
> > -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> > -                               MemoryRegion ram_memories[],
> > -                               hwaddr ram_bases[],
> > -                               hwaddr ram_sizes[],
> > -                               const ram_addr_t sdram_bank_sizes[]);
> > +void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
> > +                       MemoryRegion ram_memories[],
> > +                       hwaddr ram_bases[], hwaddr ram_sizes[],
> > +                       const ram_addr_t sdram_bank_sizes[]);
> >
> > void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
> >                         MemoryRegion ram_memories[],
> > diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> > index b782641..c162598 100644
> > --- a/hw/ppc/ppc440_bamboo.c
> > +++ b/hw/ppc/ppc440_bamboo.c
> > @@ -158,7 +158,6 @@ static void main_cpu_reset(void *opaque)
> >
> > static void bamboo_init(MachineState *machine)
> > {
> > -    ram_addr_t ram_size = machine->ram_size;
> >     const char *kernel_filename = machine->kernel_filename;
> >     const char *kernel_cmdline = machine->kernel_cmdline;
> >     const char *initrd_filename = machine->initrd_filename;
> > @@ -203,10 +202,8 @@ static void bamboo_init(MachineState *machine)
> >     /* SDRAM controller */
> >     memset(ram_bases, 0, sizeof(ram_bases));
> >     memset(ram_sizes, 0, sizeof(ram_sizes));
> > -    ram_size = ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
> > -                                   ram_memories,
> > -                                   ram_bases, ram_sizes,
> > -                                   ppc440ep_sdram_bank_sizes);
> > +    ppc4xx_sdram_prep(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> > +                      ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
> >     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
> >     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
> >                       ram_bases, ram_sizes, 1);
> > @@ -268,7 +265,7 @@ static void bamboo_init(MachineState *machine)
> >     /* Load initrd. */
> >     if (initrd_filename) {
> >         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
> > -                                          ram_size - RAMDISK_ADDR);
> > +                                          machine->ram_size - RAMDISK_ADDR);
> >
> >         if (initrd_size < 0) {
> >             error_report("could not load ram disk '%s' at %x",
> > @@ -279,7 +276,7 @@ static void bamboo_init(MachineState *machine)
> >
> >     /* If we're loading a kernel directly, we must load the device tree too. */
> >     if (kernel_filename) {
> > -        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
> > +        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK_ADDR,
> >                                     initrd_size, kernel_cmdline) < 0) {
> >             error_report("couldn't load device tree");
> >             exit(1);
> > diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> > index c2e5013..92d33a4 100644
> > --- a/hw/ppc/ppc4xx_devs.c
> > +++ b/hw/ppc/ppc4xx_devs.c
> > @@ -673,16 +673,16 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
> >  * The 4xx SDRAM controller supports a small number of banks, and each bank
> >  * must be one of a small set of sizes. The number of banks and the supported
> >  * sizes varies by SoC. */
> > -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> > -                               MemoryRegion ram_memories[],
> > -                               hwaddr ram_bases[],
> > -                               hwaddr ram_sizes[],
> > -                               const ram_addr_t sdram_bank_sizes[])
> > +void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
> > +                       MemoryRegion ram_memories[],
> > +                       hwaddr ram_bases[], hwaddr ram_sizes[],
> > +                       const ram_addr_t sdram_bank_sizes[])
> > {
> >     MemoryRegion *ram = g_malloc0(sizeof(*ram));
> >     ram_addr_t size_left = ram_size;
> >     ram_addr_t base = 0;
> >     ram_addr_t bank_size;
> > +    int last_bank = 0;
> >     int i;
> >     int j;
> >
> > @@ -690,7 +690,11 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
> >             bank_size = sdram_bank_sizes[j];
> >             if (bank_size <= size_left) {
> > +                ram_bases[i] = base;
> > +                ram_sizes[i] = bank_size;
> > +                base += bank_size;
> >                 size_left -= bank_size;
> > +                last_bank = i;
> >             }
> >         }
> >         if (!size_left) {
> > @@ -699,34 +703,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >         }
> >     }
> >
> > -    ram_size -= size_left;
> >     if (size_left) {
> > -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> > -                     " controller limits", ram_size / MiB);
> > +        ram_addr_t used_size = ram_size - size_left;
> > +        GString *s = g_string_new(NULL);
> > +
> > +        for (i = 0; sdram_bank_sizes[i]; i++) {
> > +            g_string_append_printf(s, "%" PRIi64 "%s",
> > +                                   sdram_bank_sizes[i] / MiB,
> > +                                   sdram_bank_sizes[i + 1] ? " ," : "");
> > +        }
> > +        error_report("Max %d banks of %s MB DIMM/bank supported",
> > +            nr_banks, s->str);
> > +        error_report("Possible valid RAM size: %" PRIi64,
> > +            used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
> > +
> > +        g_string_free(s, true);
> > +        exit(EXIT_FAILURE);  
> 
> This is certainly better than to just bail out and let the user wonder 
> what would work

v2 basically works the same as original code, except of that 
instead of fixing up ram_size, it ask user to fix CLI to
the same value.

> but I've not yet given up to keep current functionality 
> (also for other boards where this series would drop it). If you don't like 
> a generic callback then how about letting the board optionally specify in 
> the machine class next to default_ram_size some constraints such as 
> min_ram_size, max_ram_size and an array of valid_ram_sizes (like 
> ppc460ex_sdram_bank_sizes[]) that the generic code doing the allocation 
> could check and clamp sizes to the nearest valid one emitting a warning 
> and only bail out if constraints are not given. This would cover most 
> cases expect the e500 where it has an alignment without max so 
> representing it as a list of valid values is probably not practical (could 
> also have ram_alignment but then a generic callback may be simpler). Would 
> that way work for you?

I agree that we need to consolidate ram_size checks,
that would allow to clean up boards that practically do
the mostly the same. In the end it would allow to introspect
supported ram_sizes which would be good for upper layers.

I even started something in that direction but dropped
all of that patches as not directly related to this
series purpose.
Phillipe is also trying to something like this for raspi
board.

As for clamping, I still think that it's not good idea
to accept invalid value and fix it up.
Users should get what they asked for or get a clear error
(it's double true if user is management software as it
won't read any sort of warnings, well not all human users
would head warnings either as far as QEMU continues to run)

Anyways, most maintainers agreed to dropping fixups
and generalizing checks or generalizing fix up for convenience
of users frameworks are out of scope of this series.

Someone can work on these refactorings later on
(assuming someone is enough interested in it)

PS:
If you insist on fixing ram_size up, it would still be possible
to do so locally within board. One can take all RAM that user
provided and then create clamped memory region alias.
It's rather ugly but will do the job without affecting generic
code. (though I wouldn't volunteer to write up such a hack)


> Regards,
> BALATON Zoltan
> 
> >     }
> >
> >     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
> >
> > -    size_left = ram_size;
> > -    for (i = 0; i < nr_banks && size_left; i++) {
> > -        for (j = 0; sdram_bank_sizes[j] != 0; j++) {
> > -            bank_size = sdram_bank_sizes[j];
> > -
> > -            if (bank_size <= size_left) {
> > -                char name[32];
> > -                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> > -                memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> > -                                         base, bank_size);
> > -                ram_bases[i] = base;
> > -                ram_sizes[i] = bank_size;
> > -                base += bank_size;
> > -                size_left -= bank_size;
> > -                break;
> > -            }
> > -        }
> > +    for (i = 0; i <= last_bank; i++) {
> > +        char name[32];
> > +        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> > +        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> > +                                 ram_bases[i], ram_sizes[i]);
> >     }
> > -
> > -    return ram_size;
> > }
> >
> > /*****************************************************************************/
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index 437e214..ec7ac1f 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
> >     /* SDRAM controller */
> >     /* put all RAM on first bank because board has one slot
> >      * and firmware only checks that */
> > -    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
> > -                                   ram_memories, ram_bases, ram_sizes,
> > -                                   ppc460ex_sdram_bank_sizes);
> > +    ppc4xx_sdram_prep(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
> > +                      ppc460ex_sdram_bank_sizes);
> >
> >     /* FIXME: does 460EX have ECC interrupts? */
> >     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
> >  
> 


