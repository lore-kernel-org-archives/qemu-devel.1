Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E5C282E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D43B21738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D43B21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwZT-0005Rc-48
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:38:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hIwYA-0004mh-1H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hIwY8-00061O-DY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:37:33 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:45518
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hIwY7-0005wA-85
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:37:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 6EA158139B;
	Tue, 23 Apr 2019 16:37:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHJh2a0xvmzf; Tue, 23 Apr 2019 16:37:27 +0200 (CEST)
Received: from localhost.localdomain
	(apoitiers-155-1-191-106.w109-220.abo.wanadoo.fr [109.220.154.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 0B2C681396;
	Tue, 23 Apr 2019 16:37:27 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
	<e16760fd-1dc5-1be5-8a47-91f5c2a883ec@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <6e5c75d7-bade-fb33-d21c-5548c4f16414@adacore.com>
Date: Tue, 23 Apr 2019 16:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e16760fd-1dc5-1be5-8a47-91f5c2a883ec@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH V1 1/3] leon3: add a little bootloader
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423143725.Vrf9PHLl0bXoAbodTJfF19xMQLI8TSzFdmTiGk5ZJ3Q@z>

Hi Philippe,

Le 4/23/19 =C3=A0 4:20 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> Hi Frederic,
>=20
> On 4/19/19 12:18 PM, KONRAD Frederic wrote:
>> This adds a little bootloader to the leon3_machine when a ram image is
>> given through the kernel parameter and no bios are provided:
>>    * The UART transmiter is enabled.
>>    * The TIMER is initialized.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   hw/sparc/leon3.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-------
>>   1 file changed, 70 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
>> index 774639a..2c6f486 100644
>> --- a/hw/sparc/leon3.c
>> +++ b/hw/sparc/leon3.c
>> @@ -1,7 +1,7 @@
>>   /*
>>    * QEMU Leon3 System Emulator
>>    *
>> - * Copyright (c) 2010-2011 AdaCore
>> + * Copyright (c) 2010-2019 AdaCore
>>    *
>>    * Permission is hereby granted, free of charge, to any person obtai=
ning a copy
>>    * of this software and associated documentation files (the "Softwar=
e"), to deal
>> @@ -44,6 +44,8 @@
>>   #define CPU_CLK (40 * 1000 * 1000)
>>  =20
>>   #define PROM_FILENAME        "u-boot.bin"
>> +#define LEON3_PROM_OFFSET    (0x00000000)
>> +#define LEON3_RAM_OFFSET     (0x40000000)
>=20
> I'd have split this patch in 2, first add/use these definitions, then
> the bootloader code, but that's OK.

I hesitated but finally I choose to do it like that since all the other O=
FFSET
comes in the second patch.

>=20
>>  =20
>>   #define MAX_PILS 16
>>  =20
>> @@ -53,6 +55,55 @@ typedef struct ResetData {
>>       target_ulong sp;            /* initial stack pointer */
>>   } ResetData;
>>  =20
>> +static uint32_t *gen_write_to_addr(uint32_t *code, hwaddr addr, uint3=
2_t val)
>=20
> Can you rename that gen_store_u32()?
> If you prefer gen_write_to_addr() that's fine.
>=20
>> +{
>> +    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
>> +    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
>> +    stl_p(code++, 0x03000000 +
>> +      extract32(addr, 10, 22));
>> +                               /* sethi %hi(addr), %g1        */
>> +    stl_p(code++, 0x82106000 +
>> +      extract32(addr, 0, 10));
>> +                               /* or %g1, addr, %g1           */
>> +    stl_p(code++, 0x05000000 +
>> +      extract32(val, 10, 22));
>> +                               /* sethi %hi(val), %g2         */
>> +    stl_p(code++, 0x8410a000 +
>> +      extract32(val, 0, 10));
>> +                               /* or %g2, val, %g2            */
>> +    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
>> +
>> +    return code;
>> +}
>> +
>> +/*
>> + * When loading a kernel in RAM the machine is expected to be in a di=
fferent
>> + * state (eg: initialized by the bootloader). This little code reprod=
uces
>> + * this behavior.
>> + */
>> +static void write_bootloader(CPUSPARCState *env, uint8_t *base,
>> +                             hwaddr kernel_addr)
>> +{
>> +    uint32_t *p =3D (uint32_t *) base;
>> +
>> +    /* Initialize the UARTs                                */
>> +    p =3D gen_write_to_addr(p, 0x80000108, 3);
>=20
> Can you add comments?
> Here are the notes I took while reviewing, they might be enough:
>=20
> // *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE;
>=20
>> +
>> +    /* Initialize the TIMER 0                              */
>> +    p =3D gen_write_to_addr(p, 0x80000304, 39);
>=20
> // *GPTIMER_SCALER_RELOAD =3D 40 - 1;
>=20
>> +    p =3D gen_write_to_addr(p, 0x80000314, 0xFFFFFFFE);
>=20
> // *GPTIMER0_COUNTER_RELOAD =3D 0xFFFE;
>=20
>> +    p =3D gen_write_to_addr(p, 0x80000318, 3);
>=20
> // *GPTIMER0_CONFIG =3D GPTIMER_ENABLE | GPTIMER_RESTART;
>=20
>> +
>> +    /* JUMP to the entry point                             */
>> +    stl_p(p++, 0x82100000); /* mov %g0, %g1                */
>> +    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
>> +                            /* sethi %hi(kernel_addr), %g1 */
>> +    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
>> +                            /* or kernel_addr, %g1 */
>> +    stl_p(p++, 0x81c04000); /* jmp  %g1 */
>> +    stl_p(p++, 0x01000000); /* nop */
>> +}
>=20
> Thanks for adding write_bootloader(), I really appreciate your effort.

No problem. Thanks YOU for the review.

>=20
> With the comments:

Will add the comments in the V2.

Regards,
Fred

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> +
>>   static void main_cpu_reset(void *opaque)
>>   {
>>       ResetData *s   =3D (ResetData *)opaque;
>> @@ -131,11 +182,12 @@ static void leon3_generic_hw_init(MachineState *=
machine)
>>       /* Reset data */
>>       reset_info        =3D g_malloc0(sizeof(ResetData));
>>       reset_info->cpu   =3D cpu;
>> -    reset_info->sp    =3D 0x40000000 + ram_size;
>> +    reset_info->sp    =3D LEON3_RAM_OFFSET + ram_size;
>>       qemu_register_reset(main_cpu_reset, reset_info);
>>  =20
>>       /* Allocate IRQ manager */
>> -    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS, &leon3_s=
et_pil_in);
>> +    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS,
>> +                       &leon3_set_pil_in);
>>  =20
>>       env->qemu_irq_ack =3D leon3_irq_manager;
>>  =20
>> @@ -148,13 +200,13 @@ static void leon3_generic_hw_init(MachineState *=
machine)
>>       }
>>  =20
>>       memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram=
_size);
>> -    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
>> +    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, =
ram);
>>  =20
>>       /* Allocate BIOS */
>>       prom_size =3D 8 * MiB;
>>       memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &err=
or_fatal);
>>       memory_region_set_readonly(prom, true);
>> -    memory_region_add_subregion(address_space_mem, 0x00000000, prom);
>> +    memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET,=
 prom);
>>  =20
>>       /* Load boot prom */
>>       if (bios_name =3D=3D NULL) {
>> @@ -174,7 +226,7 @@ static void leon3_generic_hw_init(MachineState *ma=
chine)
>>       }
>>  =20
>>       if (bios_size > 0) {
>> -        ret =3D load_image_targphys(filename, 0x00000000, bios_size);
>> +        ret =3D load_image_targphys(filename, LEON3_PROM_OFFSET, bios=
_size);
>>           if (ret < 0 || ret > prom_size) {
>>               error_report("could not load prom '%s'", filename);
>>               exit(1);
>> @@ -198,10 +250,18 @@ static void leon3_generic_hw_init(MachineState *=
machine)
>>               exit(1);
>>           }
>>           if (bios_size <=3D 0) {
>> -            /* If there is no bios/monitor, start the application.  *=
/
>> -            env->pc =3D entry;
>> -            env->npc =3D entry + 4;
>> -            reset_info->entry =3D entry;
>> +            /*
>> +             * If there is no bios/monitor just start the application=
 but put
>> +             * the machine in an initialized state through a little
>> +             * bootloader.
>> +             */
>> +            uint8_t *bootloader_entry;
>> +
>> +            bootloader_entry =3D memory_region_get_ram_ptr(prom);
>> +            write_bootloader(env, bootloader_entry, entry);
>> +            env->pc =3D LEON3_PROM_OFFSET;
>> +            env->npc =3D LEON3_PROM_OFFSET + 4;
>> +            reset_info->entry =3D LEON3_PROM_OFFSET;
>>           }
>>       }
>>  =20
>>

