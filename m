Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B84BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C60720739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C60720739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js8iM-0005Uo-Hs
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 13:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1js8ha-0004qi-EY; Sun, 05 Jul 2020 13:45:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1js8hY-0005ZQ-CO; Sun, 05 Jul 2020 13:45:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DA31074633D;
 Sun,  5 Jul 2020 19:45:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 535CD746307; Sun,  5 Jul 2020 19:45:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5105674594E;
 Sun,  5 Jul 2020 19:45:06 +0200 (CEST)
Date: Sun, 5 Jul 2020 19:45:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 1/8] mac_oldworld: Allow loading binary ROM image
In-Reply-To: <20200705073128.GB6626@umbus.fritz.box>
Message-ID: <alpine.BSF.2.22.395.2007051942330.43363@zero.eik.bme.hu>
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <c69a791c7cad1246f3f34b3993dee4f549b75aa2.1593456926.git.balaton@eik.bme.hu>
 <ad28ac08-160d-0bde-7856-483308d164cb@ilande.co.uk>
 <alpine.BSF.2.22.395.2006302249091.46417@zero.eik.bme.hu>
 <20200705073128.GB6626@umbus.fritz.box>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020, David Gibson wrote:
> On Tue, Jun 30, 2020 at 11:45:42PM +0200, BALATON Zoltan wrote:
>> On Tue, 30 Jun 2020, Mark Cave-Ayland wrote:
>>> On 29/06/2020 19:55, BALATON Zoltan wrote:
>>>> The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
>>>> the rom region and fall back to loading a binary image with -bios if
>>>> loading ELF image failed. This allows testing emulation with a ROM
>>>> image from real hardware as well as using an ELF OpenBIOS image.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> v4: use load address from ELF to check if ROM is too big
>>>>
>>>>  hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
>>>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>>>> index f8c204ead7..baf3da6f90 100644
>>>> --- a/hw/ppc/mac_oldworld.c
>>>> +++ b/hw/ppc/mac_oldworld.c
>>>> @@ -59,6 +59,8 @@
>>>>  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>>>>
>>>>  #define GRACKLE_BASE 0xfec00000
>>>> +#define PROM_BASE 0xffc00000
>>>> +#define PROM_SIZE (4 * MiB)
>>>>
>>>>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>>>                              Error **errp)
>>>> @@ -99,6 +101,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>>>      SysBusDevice *s;
>>>>      DeviceState *dev, *pic_dev;
>>>>      BusState *adb_bus;
>>>> +    uint64_t bios_addr;
>>>>      int bios_size;
>>>>      unsigned int smp_cpus = machine->smp.cpus;
>>>>      uint16_t ppc_boot_device;
>>>> @@ -127,24 +130,32 @@ static void ppc_heathrow_init(MachineState *machine)
>>>>
>>>>      memory_region_add_subregion(sysmem, 0, machine->ram);
>>>>
>>>> -    /* allocate and load BIOS */
>>>> -    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
>>>> +    /* allocate and load firmware ROM */
>>>> +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
>>>>                             &error_fatal);
>>>> +    memory_region_add_subregion(sysmem, PROM_BASE, bios);
>>>>
>>>> -    if (bios_name == NULL)
>>>> +    if (!bios_name) {
>>>>          bios_name = PROM_FILENAME;
>>>> +    }
>>>>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>>> -    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
>>>> -
>>>> -    /* Load OpenBIOS (ELF) */
>>>>      if (filename) {
>>>> -        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL, NULL,
>>>> -                             1, PPC_ELF_MACHINE, 0, 0);
>>>> +        /* Load OpenBIOS (ELF) */
>>>> +        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
>>>> +                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>>>> +        if (bios_size <= 0) {
>>>> +            /* or load binary ROM image */
>>>> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
>>>> +            bios_addr = PROM_BASE;
>>>> +        } else {
>>>> +            /* load_elf sets high 32 bits for some reason, strip those */
>>>> +            bios_addr &= 0xffffffffULL;
>>>
>>> Repeating my earlier comment from v5: something is wrong here if you need to manually
>>> strip the high bits. If you compare with SPARC32 which uses the same approach, there
>>> is no such strip required - have a look there to try and figure out what's going on here.
>>
>> OK, the problem here is this:
>>
>> $ gdb qemu-system-ppc
>> (gdb) b mac_oldworld.c:146
>> Breakpoint 1 at 0x416770: file hw/ppc/mac_oldworld.c, line 146.
>> (gdb) r
>> Thread 1 "qemu-system-ppc" hit Breakpoint 1, ppc_heathrow_init (machine=0x555556863800) at hw/ppc/mac_oldworld.c:146
>> 146	    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> (gdb) n
>> 147	    if (filename) {
>> 149	        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
>> 151	        if (bios_size <= 0) {
>> (gdb) p bios_size
>> $1 = 755500
>> (gdb) p/x bios_addr
>> $2 = 0xfffffffffff00000
>>
>> this happens within load_elf that I don't feel like wanting to debug but
>> causes problem when we use it to calculate bios size later here:
>
> I think the problem is here, in include/hw/elf_ops.h:
>
>    if (lowaddr)
>        *lowaddr = (uint64_t)(elf_sword)low;
>
> "low" is a u64, but for a 32-bit ELF file, which is what I'm guessing
> you're dealing with here, elf_sword is an int32_t.  So the first cast
> truncates the high bits, but makes it a signed value, so the second
> cast sign extends, resulting in those high bits.

Thanks for finding this, this looks like a likely reason.

> Sign extending rather than zero-extending seems a dubious choice here,
> so I wonder if that should be (elf_word) instead of (elf_sword).  But
> maybe there's some weird other case where we do want the sign
> extension here.

Looks like most callers which get this value don't even use it, I've 
submitted a patch to clean that up. Of the remaining callers at least 
hppa does similar truncating but uses a cast instead of explicit masking. 
I'll update my mac patches to do the same.

Regards,
BALATON Zoltan

>> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
>> +    if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
>>
>> unless we strip it down to expected 32 bits. This could be some unwanted
>> size extension or whatnot but I don't have time to dig deeper.
>>
>> Now lets see what sun4m does:
>>
>> $ gdb qemu-system-sparc
>> (gdb) b sun4m.c:721
>> Breakpoint 1 at 0x1fc0e6: file hw/sparc/sun4m.c, line 721.
>> (gdb) r
>> Thread 1 "qemu-system-spa" hit Breakpoint 1, prom_init (addr=1879048192, bios_name=0x555555b3c60d "openbios-sparc32") at hw/sparc/sun4m.c:721
>> 721	    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> (gdb) p/x addr
>> $1 = 0x70000000
>> (gdb) n
>> 722	    if (filename) {
>> 723	        ret = load_elf(filename, NULL,
>> 726	        if (ret < 0 || ret > PROM_SIZE_MAX) {
>> (gdb) p ret
>> $2 = 847872
>> (gdb) p/x addr
>> $3 = 0x70000000
>>
>> Hmm, does not happen here, the difference is that this calls load_elf with
>> addr already initialised so maybe load_elf only sets low 32 bits? By the
>> way, sun4m does not use the returned addr so even if it was wrong it would
>> not be noticed,
>>
>> Maybe initialising addr before calling load_elf in mac_oldworld,c could fix
>> this so we can get rid of the fix up? Unfortunately not:
>>
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -98,7 +98,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>      SysBusDevice *s;
>>      DeviceState *dev, *pic_dev;
>>      BusState *adb_bus;
>> -    uint64_t bios_addr;
>> +    uint64_t bios_addr = 0;
>>      int bios_size;
>>      unsigned int smp_cpus = machine->smp.cpus;
>>      uint16_t ppc_boot_device;
>>
>> $ gdb qemu-system-ppc
>> [...]
>> Thread 1 "qemu-system-ppc" hit Breakpoint 1, ppc_heathrow_init (machine=0x555556863800) at hw/ppc/mac_oldworld.c:146
>> 146	    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> (gdb) p bios_addr
>> $1 = 0
>> (gdb) n
>> 147	    if (filename) {
>> 149	        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
>> 151	        if (bios_size <= 0) {
>> (gdb) p/x bios_addr
>> $2 = 0xfffffffffff00000
>>
>> Could this be something about openbios-ppc? I don't know. I give up
>> investigating further at this point and let someone else find out.
>> Any ideas?
>>
>> Regards,
>> BALATON Zoltan
>>
>
>

