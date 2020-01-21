Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1775F2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sf5nK2wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1775F2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itosp-0005cv-Ac
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1itos9-00055s-02
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1itos5-00032y-H0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:26:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1itos5-00032r-Cw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579595208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M7Z/P5Qh0yN94EZ/GJ2F73xVmq+KAm4RbZwOpP7jm5o=;
 b=Sf5nK2wyP2rZl6EkTkfjGqUK+S4HB7qswiqaRixpgZYVHax9w3OzfUbxKgHYK8ihxUFSfh
 /OquFq4/XdF7QWIBnNYflGJaAnEL3s+D6Gr4PcLrxpgl+omFVEaNMXguorlZHodyqvMnFB
 708C02c5omzaAc0+ODKK93ehX/tvD28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-LoAlbKh0PGmPZF3DywkAzw-1; Tue, 21 Jan 2020 03:26:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A5310054E3;
 Tue, 21 Jan 2020 08:26:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48AE61CB;
 Tue, 21 Jan 2020 08:26:42 +0000 (UTC)
Date: Tue, 21 Jan 2020 09:26:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 64/84] ppc/{ppc440_bamboo,sam460ex}: drop RAM size fixup
Message-ID: <20200121092640.22ea1f4b@redhat.com>
In-Reply-To: <alpine.BSF.2.21.99999.352.2001201742400.65990@zero.eik.bme.hu>
References: <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
 <1579533242-175074-1-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001201742400.65990@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LoAlbKh0PGmPZF3DywkAzw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Mon, 20 Jan 2020 18:02:57 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Mon, 20 Jan 2020, Igor Mammedov wrote:
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
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > v2:
> >  * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
> >     (BALATON Zoltan <balaton@eik.bme.hu>)
> >  * print possible valid ram size id not all RAM was distributed
> >  * initialize ram_bases/ram_bases at the same time we are checking
> >    that user supplied RAM would fit available banks and drop nested
> >    loop that were duplicating the same calculations.
> >  * coincidentally fix crash when -m is less than minimal bank size
> > v3:
> >  * s/ppc4xx_sdram_prep/ppc4xx_sdram_banks/
> >      (BALATON Zoltan <balaton@eik.bme.hu>)
> >  * fix subject line in commit message
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
> > index 7d82259..b8c8f32 100644
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
> > +void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> > +                        MemoryRegion ram_memories[],
> > +                        hwaddr ram_bases[], hwaddr ram_sizes[],
> > +                        const ram_addr_t sdram_bank_sizes[]);
> >
> > void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
> >                         MemoryRegion ram_memories[],
> > diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> > index b782641..577f7c2 100644
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
> > +    ppc4xx_sdram_banks(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> > +                       ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
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
> > index c2e5013..de2c87b 100644
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
> > +void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> > +                        MemoryRegion ram_memories[],
> > +                        hwaddr ram_bases[], hwaddr ram_sizes[],
> > +                        const ram_addr_t sdram_bank_sizes[])
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

should be:
                     + break;

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
> 
> Looking at it once again I'm not sure the above change (and moving the 
> remaining part of the loop in subsequent patch) is really identical. 
> There's a break; in the original second for j loop which the first one's 
> missing so does this still select same bank sizes and wouldn't it create 
> more alias regions than it should after these patches? I have to admit I 
> haven't tried to understand this function because it did what I needed for 
> sam460ex so I don't know if it has any preexisting bugs.

It's my bug, thanks for spotting it.
When I combined loops, I should have moved 'reak statement as well
to make sure back first matched bank size would be processed and
the rest were ignored.

Testing shows that adding missing "break" in the j loop fixes issue
and RAM is distributed like in the original code.
 
> It also appears to rely not only on sdram_bank_sizes[] being 0 terminated 
> but on values being reverse sorted so that should also be mentioned in the 
> comment before the function.
> 
> Regards,
> BALATON Zoltan
> 
> > -
> > -    return ram_size;
> > }
> >
> > /*****************************************************************************/
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index 437e214..949acba 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
> >     /* SDRAM controller */
> >     /* put all RAM on first bank because board has one slot
> >      * and firmware only checks that */
> > -    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
> > -                                   ram_memories, ram_bases, ram_sizes,
> > -                                   ppc460ex_sdram_bank_sizes);
> > +    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
> > +                       ppc460ex_sdram_bank_sizes);
> >
> >     /* FIXME: does 460EX have ECC interrupts? */
> >     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
> >  
> 


