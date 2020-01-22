Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF37C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9E324672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/weWfz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuBpX-000050-Kg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuBoZ-0007kb-83
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuBoW-0003o9-RK
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:56:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuBoW-0003nV-Kv
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579683399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tg8Az34uYLRZtnO/ClpEFJOF9AeXHGCJE5GHyT54Fy0=;
 b=J/weWfz9CIB1T/0t+nP4RlHaRz/oN9D3hx+xOzI7jmQWDSHakUh3DjSftFUA2KxTvZnC9N
 SBY8h/3lACKYrGZr+1M6RRG5n6ZUCFbPNykEzkdSJam0EvV8Dz8eO/Kq6yCxdCjPMixuHr
 g5/arkJ9YISlOrVOVFGW/yH/hJTybMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-9UIhlGoHO-i2Q5QYebKdaA-1; Wed, 22 Jan 2020 03:56:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAB981882CD3;
 Wed, 22 Jan 2020 08:56:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 530B919C69;
 Wed, 22 Jan 2020 08:56:32 +0000 (UTC)
Date: Wed, 22 Jan 2020 09:56:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 64/82] ppc/{ppc440_bamboo,sam460ex}: drop RAM size fixup
Message-ID: <20200122095630.1891cab1@redhat.com>
In-Reply-To: <alpine.BSF.2.21.99999.352.2001211900240.27287@zero.eik.bme.hu>
References: <20200121092640.22ea1f4b@redhat.com>
 <1579624904-47593-1-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001211900240.27287@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9UIhlGoHO-i2Q5QYebKdaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Tue, 21 Jan 2020 20:31:48 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Tue, 21 Jan 2020, Igor Mammedov wrote:
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
> >  * print possible valid ram size id not all RAM was distributed
> >  * initialize ram_bases/ram_bases at the same time we are checking
> >    that user supplied RAM would fit available banks and drop nested
> >    loop that were duplicating the same calculations.
> >  * coincidentally fix crash when -m is less than minimal bank size
> > v3:
> >  * s/ppc4xx_sdram_prep/ppc4xx_sdram_banks/
> >      (BALATON Zoltan <balaton@eik.bme.hu>)
> >  * fix subject line in commit message
> > v3.1
> >  * add lost 'break' statement in 'j' loop
> >
> > CC: balaton@eik.bme.hu
> > CC: david@gibson.dropbear.id.au
> > CC: qemu-ppc@nongnu.org
> > ---
> > include/hw/ppc/ppc4xx.h |  9 ++++----
> > hw/ppc/ppc440_bamboo.c  | 11 ++++------
> > hw/ppc/ppc4xx_devs.c    | 57 ++++++++++++++++++++++++++-----------------------
> > hw/ppc/sam460ex.c       |  5 ++---
> > 4 files changed, 40 insertions(+), 42 deletions(-)
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
> 
> 
> Is ram_size still valid here or should this be machine->ram_size as well?
it is, as there is global ram_size which is equal to machine->ram_size.
As for this line I can s/ram_size/machine->ram_size/ on respin
if you'd like to.

Cleaning up global ram_size and machine->ram_size should be another series.
When all patches from this series get merged it should be easier to remove
global ram_size variable altogether and maybe machine->ram_size as well.



> 
> 
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
> > index c2e5013..5a3bb80 100644
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
> > @@ -690,7 +690,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
> >             bank_size = sdram_bank_sizes[j];
> >             if (bank_size <= size_left) {  
> 
> Does this blow up if values in sdram_bank_sizes are not sorted from big to 
> small? If so this should be noted in the comment above.

would something like this work for you?

diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 1db7e41..153ce42 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -668,7 +668,8 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
 
 /* Split RAM between SDRAM banks.
  *
- * sdram_bank_sizes[] must be 0-terminated.
+ * sdram_bank_sizes[] must be sorted by sizes[i] > sizes[i+1] rule
+ * and must be 0-terminated.
  *
  * The 4xx SDRAM controller supports a small number of banks, and each bank
  * must be one of a small set of sizes. The number of banks and the supported

> 
> > +                ram_bases[i] = base;
> > +                ram_sizes[i] = bank_size;
> > +                base += bank_size;
> >                 size_left -= bank_size;
> > +                last_bank = i;
> > +                break;  
> 
> I'm not sure how it is supposed to work. (I never knew as this is not my 
> code but was there before.) AFAIU the idea was to use as many available 
> bank sizes first on one ram_base before moving on to the next. This does 
> not seem to do that and will go to the next ram after populating the first 
> bank if I understood correctly. But the original code was also not going 
> through with that and in the second loop only used the first bank selected 
> so that does not make much sense.
> 
> The problem here is that e.g. sam460ex has only one RAM slot so its 
> firmware does not bother checking any other slot (even if the SoC could 
> handle 4 slots) so unless we put everything (possibly with different 
> banks) in the first RAM slot it won't work. The other constraint is the 
> SoC's memory controller that encodes ram_base and ram_size in a single 
> register and only allows certain sizes.
> 
> What happens if we try to set 1.5GB or 768MB? I think SPD could represent 
> that using different bank sizes even if uncommon (I wrote 
> spd_data_generate() in hw/i2c/smbus_eeprom.c but that was a long ago and 
> forgot about it since) but probably the ppc440 SDRAM controller does not 
> have values for this size so not sure if it would work. Currently this 
> functions lets 1.5G and 768M through and that much RAM is allocated but 
> only 1G or 512M will be mapped.
> 
> I guess the situation is not worse after your changes with not allocating 
> unmapped RAM, the machine still gets the same amount (only annoying users 
> about it).
Probably it's like you're saying (current logic tries to put as much as RAM
into slot as possible and then move to the next slot).

But then rewriting RAM distribution logic is certainly out of scope of
this series. And probably should be done by some one who knows how this
specific hw is supposed to work.

> 
> Regards,
> BALATON Zoltan
> 
> >             }
> >         }
> >         if (!size_left) {
> > @@ -699,34 +704,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
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


