Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E96C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB4521744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejUkGPvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB4521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6X4c-0007X9-4C
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6X3K-0006Ee-TF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6X3I-0003gL-Hg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:02:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52528
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6X3I-0003fZ-DK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582624976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBpD5HELVrnT83p7rH4Td+NVu0K9yUaZ4qXIwkLmVJ0=;
 b=ejUkGPvCmyOqx+uL/mwo5/wUfprLmqHHdM/0OJNlZveY5+ESEjyhWA7uftlDE+9NKu6R49
 oJeXmMUGvl3z68g+Q9QdWwpHXwGKFp/dNUX8t9LMEQ5gpdtaxbB7765erlIvYA6N/+ThnD
 L88JCbRL3y21wR+NXvVKP+tDsXnsHcs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-YnOL47OQNF20nUnU2XvZlw-1; Tue, 25 Feb 2020 05:02:54 -0500
X-MC-Unique: YnOL47OQNF20nUnU2XvZlw-1
Received: by mail-wr1-f72.google.com with SMTP id u8so7056788wrp.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 02:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X74lUNhApL5VU/X3sG8KsCy0ws8LJAAil4qPz+6k63c=;
 b=b+4BwypDW4nSWdMPamMwbVrzeLGbtXhlFNnNx7j9aoL3l4rlrBek7Xu9L3odesDL24
 gYcjibAZFQ8pGU0TDSZSgEeGQGahH7RwNqCgwhhT5rs58aRWHYVF/Bf21HQAic3w6yXN
 iyLeqbnCpX74dmnqOfgfmJ4lP4+qqO1LwniVI5Dw0B2QfQ9yADvUbJBqXqasVM0v2E9k
 +HtDi3kwwzQkgmgbrsZPi+mhdbcu9EoKPkr/WOWfyYQ1z7hacdBO0H7LxLTiwb8IQYNa
 dGtm6YABZij37DMLYtaB8VNdfyLhXcDyOeYTN29ao3D81IoMVSh7d8VhaIsmptEBSFYP
 OlSw==
X-Gm-Message-State: APjAAAUkhxlD91mD13YqxwSBzw5Gh0iZl8tuITbQBkji+01T2jnh5Vfy
 ygLLdenJb3LWy6Pms3xzt64fN8r1SgxHgqWRPh+QrhIV/DUJdRMN2LHl/uJH4dr+UPqtPpMfzuD
 VEIc/wnT+NOFar7I=
X-Received: by 2002:a5d:4651:: with SMTP id j17mr73329788wrs.237.1582624972879; 
 Tue, 25 Feb 2020 02:02:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1NBJBSeZ455pTytE+aGLajrBMkKGWcjtJGJOjMO9lQdQyUHNYKx2WEFyFUVfKWFatex+6bA==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr73329702wrs.237.1582624972386; 
 Tue, 25 Feb 2020 02:02:52 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q12sm7900812wrg.71.2020.02.25.02.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 02:02:51 -0800 (PST)
Subject: Re: [PATCH v2 05/32] hw/arm: Use memory_region_init_rom() with
 read-only regions
To: Alistair Francis <alistair23@gmail.com>
References: <20200224204828.23167-1-philmd@redhat.com>
 <20200224204828.23167-6-philmd@redhat.com>
 <CAKmqyKPcWkN4fhu+kmU8d+wsPLt_4BJB74Tao-P7nJpBQa1jZA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62f0a8f5-82ff-e543-964a-a8759169e01f@redhat.com>
Date: Tue, 25 Feb 2020 11:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPcWkN4fhu+kmU8d+wsPLt_4BJB74Tao-P7nJpBQa1jZA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Qemu-block <qemu-block@nongnu.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 10:20 PM, Alistair Francis wrote:
> On Mon, Feb 24, 2020 at 12:51 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> This commit was produced with the Coccinelle script
>> scripts/coccinelle/memory-region-housekeeping.cocci.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> This looks good for the ROM regions, for the flash regions this
> doesn't change the current functionality but I'm not sure it's any
> clearer.

Less code makes easier review.

These regions behave as ROM on the bus, any write to the address space=20
is illegal (they are programmable via I/O registers in another address=20
space).

>=20
> Either way though:
>=20
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks, do you want me to improve the commit description?

>=20
> Alistair
>=20
>> ---
>>   hw/arm/exynos4210.c | 3 +--
>>   hw/arm/mainstone.c  | 3 +--
>>   hw/arm/omap_sx1.c   | 6 ++----
>>   hw/arm/palm.c       | 3 +--
>>   hw/arm/spitz.c      | 3 +--
>>   hw/arm/stellaris.c  | 3 +--
>>   hw/arm/tosa.c       | 3 +--
>>   7 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
>> index 59a27bdd68..3af6502a5e 100644
>> --- a/hw/arm/exynos4210.c
>> +++ b/hw/arm/exynos4210.c
>> @@ -311,9 +311,8 @@ static void exynos4210_realize(DeviceState *socdev, =
Error **errp)
>>                                   &s->chipid_mem);
>>
>>       /* Internal ROM */
>> -    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
>> +    memory_region_init_rom(&s->irom_mem, NULL, "exynos4210.irom",
>>                              EXYNOS4210_IROM_SIZE, &error_fatal);
>> -    memory_region_set_readonly(&s->irom_mem, true);
>>       memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
>>                                   &s->irom_mem);
>>       /* mirror of iROM */
>> diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
>> index 6e64dfab50..05a806b422 100644
>> --- a/hw/arm/mainstone.c
>> +++ b/hw/arm/mainstone.c
>> @@ -125,9 +125,8 @@ static void mainstone_common_init(MemoryRegion *addr=
ess_space_mem,
>>       /* Setup CPU & memory */
>>       mpu =3D pxa270_init(address_space_mem, mainstone_binfo.ram_size,
>>                         machine->cpu_type);
>> -    memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
>> +    memory_region_init_rom(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
>>                              &error_fatal);
>> -    memory_region_set_readonly(rom, true);
>>       memory_region_add_subregion(address_space_mem, 0, rom);
>>
>>   #ifdef TARGET_WORDS_BIGENDIAN
>> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
>> index be245714db..6c3fd1b271 100644
>> --- a/hw/arm/omap_sx1.c
>> +++ b/hw/arm/omap_sx1.c
>> @@ -126,9 +126,8 @@ static void sx1_init(MachineState *machine, const in=
t version)
>>       mpu =3D omap310_mpu_init(dram, machine->cpu_type);
>>
>>       /* External Flash (EMIFS) */
>> -    memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size=
,
>> +    memory_region_init_rom(flash, NULL, "omap_sx1.flash0-0", flash_size=
,
>>                              &error_fatal);
>> -    memory_region_set_readonly(flash, true);
>>       memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
>>
>>       memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
>> @@ -168,9 +167,8 @@ static void sx1_init(MachineState *machine, const in=
t version)
>>       if ((version =3D=3D 1) &&
>>               (dinfo =3D drive_get(IF_PFLASH, 0, fl_idx)) !=3D NULL) {
>>           MemoryRegion *flash_1 =3D g_new(MemoryRegion, 1);
>> -        memory_region_init_ram(flash_1, NULL, "omap_sx1.flash1-0",
>> +        memory_region_init_rom(flash_1, NULL, "omap_sx1.flash1-0",
>>                                  flash1_size, &error_fatal);
>> -        memory_region_set_readonly(flash_1, true);
>>           memory_region_add_subregion(address_space, OMAP_CS1_BASE, flas=
h_1);
>>
>>           memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
>> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
>> index 72eca8cc55..265d5891a6 100644
>> --- a/hw/arm/palm.c
>> +++ b/hw/arm/palm.c
>> @@ -206,9 +206,8 @@ static void palmte_init(MachineState *machine)
>>       mpu =3D omap310_mpu_init(dram, machine->cpu_type);
>>
>>       /* External Flash (EMIFS) */
>> -    memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
>> +    memory_region_init_rom(flash, NULL, "palmte.flash", flash_size,
>>                              &error_fatal);
>> -    memory_region_set_readonly(flash, true);
>>       memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE, flas=
h);
>>
>>       memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val, "palmte-=
cs0",
>> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
>> index e001088103..1d27399721 100644
>> --- a/hw/arm/spitz.c
>> +++ b/hw/arm/spitz.c
>> @@ -924,8 +924,7 @@ static void spitz_common_init(MachineState *machine,
>>
>>       sl_flash_register(mpu, (model =3D=3D spitz) ? FLASH_128M : FLASH_1=
024M);
>>
>> -    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fa=
tal);
>> -    memory_region_set_readonly(rom, true);
>> +    memory_region_init_rom(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fa=
tal);
>>       memory_region_add_subregion(address_space_mem, 0, rom);
>>
>>       /* Setup peripherals */
>> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
>> index 221a78674e..d136ba1a92 100644
>> --- a/hw/arm/stellaris.c
>> +++ b/hw/arm/stellaris.c
>> @@ -1300,9 +1300,8 @@ static void stellaris_init(MachineState *ms, stell=
aris_board_info *board)
>>       sram_size =3D ((board->dc0 >> 18) + 1) * 1024;
>>
>>       /* Flash programming is done via the SCU, so pretend it is ROM.  *=
/
>> -    memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
>> +    memory_region_init_rom(flash, NULL, "stellaris.flash", flash_size,
>>                              &error_fatal);
>> -    memory_region_set_readonly(flash, true);
>>       memory_region_add_subregion(system_memory, 0, flash);
>>
>>       memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
>> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
>> index 4d95a1f3e2..5dee2d76c6 100644
>> --- a/hw/arm/tosa.c
>> +++ b/hw/arm/tosa.c
>> @@ -226,8 +226,7 @@ static void tosa_init(MachineState *machine)
>>
>>       mpu =3D pxa255_init(address_space_mem, tosa_binfo.ram_size);
>>
>> -    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fata=
l);
>> -    memory_region_set_readonly(rom, true);
>> +    memory_region_init_rom(rom, NULL, "tosa.rom", TOSA_ROM, &error_fata=
l);
>>       memory_region_add_subregion(address_space_mem, 0, rom);
>>
>>       tmio =3D tc6393xb_init(address_space_mem, 0x10000000,
>> --
>> 2.21.1
>>
>>
>=20


