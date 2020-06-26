Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B3920885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B3920885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowtv-0006PD-4S
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jowLa-0000kq-HD; Fri, 26 Jun 2020 17:57:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:58514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jowLX-0004Iu-Gx; Fri, 26 Jun 2020 17:57:21 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 992427475FA;
 Fri, 26 Jun 2020 23:57:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6F53974633D; Fri, 26 Jun 2020 23:57:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6E059746335;
 Fri, 26 Jun 2020 23:57:16 +0200 (CEST)
Date: Fri, 26 Jun 2020 23:57:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 01/11] mac_oldworld: Allow loading binary ROM image
In-Reply-To: <38a2c38b-4f2b-2306-1a10-ec111364c1a4@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006262354340.64843@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <6db700da7c07c6337682c73faa91c2444a4aa97a.1592315226.git.balaton@eik.bme.hu>
 <38a2c38b-4f2b-2306-1a10-ec111364c1a4@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:57:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020, Mark Cave-Ayland wrote:
> On 16/06/2020 14:47, BALATON Zoltan wrote:
>> The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
>> the rom region and fall back to loading a binary image with -bios if
>> loading ELF image failed. This allows testing emulation with a ROM
>> image from real hardware as well as using an ELF OpenBIOS image.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v4: use load address from ELF to check if ROM is too big
>>
>>  hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index f8c204ead7..baf3da6f90 100644
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -59,6 +59,8 @@
>>  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>>
>>  #define GRACKLE_BASE 0xfec00000
>> +#define PROM_BASE 0xffc00000
>> +#define PROM_SIZE (4 * MiB)
>>
>>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>                              Error **errp)
>> @@ -99,6 +101,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>      SysBusDevice *s;
>>      DeviceState *dev, *pic_dev;
>>      BusState *adb_bus;
>> +    uint64_t bios_addr;
>>      int bios_size;
>>      unsigned int smp_cpus = machine->smp.cpus;
>>      uint16_t ppc_boot_device;
>> @@ -127,24 +130,32 @@ static void ppc_heathrow_init(MachineState *machine)
>>
>>      memory_region_add_subregion(sysmem, 0, machine->ram);
>>
>> -    /* allocate and load BIOS */
>> -    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
>> +    /* allocate and load firmware ROM */
>> +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
>>                             &error_fatal);
>> +    memory_region_add_subregion(sysmem, PROM_BASE, bios);
>>
>> -    if (bios_name == NULL)
>> +    if (!bios_name) {
>>          bios_name = PROM_FILENAME;
>> +    }
>>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> -    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
>> -
>> -    /* Load OpenBIOS (ELF) */
>>      if (filename) {
>> -        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL, NULL,
>> -                             1, PPC_ELF_MACHINE, 0, 0);
>> +        /* Load OpenBIOS (ELF) */
>> +        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
>> +                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>> +        if (bios_size <= 0) {
>> +            /* or load binary ROM image */
>> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
>> +            bios_addr = PROM_BASE;
>> +        } else {
>> +            /* load_elf sets high 32 bits for some reason, strip those */
>> +            bios_addr &= 0xffffffffULL;
>
> This is certainly the approach I suggested, but this seems wrong - otherwise
> load_elf() would be broken for quite a few use cases.
>
>> +        }
>>          g_free(filename);
>>      } else {
>>          bios_size = -1;
>>      }
>> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
>> +    if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
>>          error_report("could not load PowerPC bios '%s'", bios_name);
>>          exit(1);
>>      }
>
> (goes and looks)
>
> This is similar to how the SPARC32 loader works and it seems fine there:
> https://git.qemu.org/?p=qemu.git;a=blob;f=hw/sparc/sun4m.c;h=ee52b5cbbcd22284384225c80ad50cdbd1415743;hb=HEAD#l721.
> Looks like you might have the wrong addr parameter here?

I don't get this. Can you explain more please what is wrong and what's the 
proposed solution?

Regards,
BALATON Zoltan

