Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D10C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3538D206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3538D206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTvJ-0005nx-HM
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkTuH-0005Kf-4z; Sun, 14 Jun 2020 10:46:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:47954)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkTuE-0000M5-9c; Sun, 14 Jun 2020 10:46:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BFB89746331;
 Sun, 14 Jun 2020 16:46:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9618F746307; Sun, 14 Jun 2020 16:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 94A727456F8;
 Sun, 14 Jun 2020 16:46:33 +0200 (CEST)
Date: Sun, 14 Jun 2020 16:46:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 1/5] mac_oldworld: Allow loading binary ROM image
In-Reply-To: <ef46b912-aa47-09bc-3362-a9dea0c82523@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006141623190.56690@zero.eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <4a304a01a87fc8154023bc8f48e22811d7cfcaf0.1592055375.git.balaton@eik.bme.hu>
 <ef46b912-aa47-09bc-3362-a9dea0c82523@ilande.co.uk>
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 14 Jun 2020, Mark Cave-Ayland wrote:
> On 13/06/2020 14:36, BALATON Zoltan wrote:
>
>> The G3 beige machine has a 4MB firmware ROM. Fix the size of the rom
>> region and allow loading a binary image with -bios. This makes it
>> possible to test emulation with a ROM image from real hardware.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/mac_oldworld.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index 0b4c1c6373..3812adc441 100644
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
>> @@ -127,24 +129,28 @@ static void ppc_heathrow_init(MachineState *machine)
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
>> +        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL,
>> +                             NULL, 1, PPC_ELF_MACHINE, 0, 0);
>> +        if (bios_size <= 0) {
>> +            /* or load binary ROM image */
>> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
>> +        }
>>          g_free(filename);
>>      } else {
>>          bios_size = -1;
>>      }
>> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
>> +    if (bios_size < 0 || bios_size > PROM_SIZE) {
>>          error_report("could not load PowerPC bios '%s'", bios_name);
>>          exit(1);
>>      }
>
> I think the logic could be improved a bit here: load_elf() can return the physical
> address from the ELF, so it would make sense to use that as the address for
> load_image_targphys() if present, and otherwise fall back to loading at 0xffc00000.

I don't get this. No need to do it that way because load_elf already loads 
the image at address specified in ELF file (I guess because it still works 
with OpenBIOS after this patch) so don't have to call load_image_targphys 
for that case. The above tries load_elf and only if it did not succeed 
calls load_image_targphys to load a binary image to fill the ROM. I don't 
see how this logic could be simpler.

Maybe we need the load address from the ELF to check if an ELF would 
overflow the region as in elf_addr + bios_size > PROM_ADDR + PROM_SIZE but 
I'm not sure. Any suggestion?

> It may also make sense to split PROM_ADDR to PROM_ADDR_OLDWORLD and
> PROM_ADDR_NEWWORLD (and similar for BIOS_SIZE) to allow these values to be adjusted
> separately for each machine.

BIOS_SIZE is not used in this board after this patch any more so that's 
basically PROM_SIZE_NEWWORLD now which can be defined in mac_newworld and 
removed from mac.h. Then we have separate PROM_SIZE for each board. I've 
also defined PROM_ADDR here in mac_oldworld and similar define can be 
added to mac_newworld if needed. These should not be in mac.h I think as 
these are board specific. I regard the previous BIOS_* values specific to 
OpenBIOS not to boards so now that boards can use other ROMs not just 
OpenBIOS BIOS_SIZE may not be needed, what we need is the size of the ROM 
chip on board instead.

Regards,
BALATON Zoltan

