Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE4FCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539ED214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539ED214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTAB-00069K-GR
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMT9N-0005Wf-2e
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMT9L-0007XI-RK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMT9L-0007Wo-J8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:34:47 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72F60C054C52
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:34:46 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id s17so1198329wrp.17
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TCn+Qdz00SV7XMFoUhfjz0N726xchFWUp1tXh0p0n0Q=;
 b=Y6bxxO1xCSEzunXKd09UGsew0GU4ouKwczmSu3+vT/vfVIXm3HlNBYKG82HVfdjpsU
 OjL5q/jOgvL9kcVSGtnPURk/6idbOJbv6Q0fLOE94ATnXEVAGcM12lKQU1MQDH9byaYr
 r5KrbM4HnI7hqOTSv9Xts8BB+sQGTn8kGqrb5WjSLWfo3J+DYAA3TrDVSBBozM/uTJaF
 rflKFQo94bYiKy9dQNRF3mO6x3VmWjQdW2ER/pgghOcgYxSJm+K6rXRSrXeWbSd0wJ+M
 pNZGLA81e4FFcb5qhQrG4vU27he8BsMEfqaByoT3fEyhSMvAyOmV4zcanrVh/hYNW7mZ
 GbNw==
X-Gm-Message-State: APjAAAWm/AaQBEiu+MhOcnTJMEWrFSRflBZSbzqnh7UvRmCQOml6E0HG
 8G+6JTsP5ET3P/OXhKOI1KrjwybrBQiuWmAa9AkoiEAdDN0bReD4Iy0O0yVaVNINSMGiCXSSMUw
 AxCmzu7zz5u4aqO4=
X-Received: by 2002:a05:600c:21c8:: with SMTP id
 x8mr16839648wmj.123.1571646885086; 
 Mon, 21 Oct 2019 01:34:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw81gplkeWzcy+uHOpRKzKgROW67o6ELb5nVOEl3L/JAzZK9u0xgCv/l5ekZMHqIou5GwNIeg==
X-Received: by 2002:a05:600c:21c8:: with SMTP id
 x8mr16839621wmj.123.1571646884843; 
 Mon, 21 Oct 2019 01:34:44 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id y3sm24539770wro.36.2019.10.21.01.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:34:44 -0700 (PDT)
Subject: Re: [PATCH 18/21] hw/mips: Let the machine be the owner of the system
 memory
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-19-philmd@redhat.com>
 <CAL1e-=ivk8phw5SOd=a6SO8RJ4E=9kN8hN0tocQYcb7AEKeyEA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <698bde03-02a9-be5e-2aff-4e8d50508222@redhat.com>
Date: Mon, 21 Oct 2019 10:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ivk8phw5SOd=a6SO8RJ4E=9kN8hN0tocQYcb7AEKeyEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paul Burton <pburton@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Fabien Chouteau <chouteau@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 10/21/19 8:25 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/mips/boston.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-
>      =C2=A0hw/mips/mips_fulong2e.c | 3 ++-
>      =C2=A0hw/mips/mips_jazz.c=C2=A0 =C2=A0 =C2=A0| 2 +-
>      =C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 | 2 +-
>      =C2=A0hw/mips/mips_mipssim.c=C2=A0 | 2 +-
>      =C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 | 3 ++-
>      =C2=A06 files changed, 8 insertions(+), 6 deletions(-)
>=20
>=20
> Philippe, can this patch be applied independently (on other patches of=20
> this series)?

Unfortunately not because patch #9 changed the prototype of
memory_region_allocate_system_memory() so this patch alone
won't build.

I rather expect this series goes as a whole via the machine-next
tree.

Do you mind giving your Acked-by tag to this patch?

Thanks,

Phil.

>=20
>=20
>     diff --git a/hw/mips/boston.c b/hw/mips/boston.c
>     index ca7d813a52..8445fee0f1 100644
>     --- a/hw/mips/boston.c
>     +++ b/hw/mips/boston.c
>     @@ -474,7 +474,7 @@ static void boston_mach_init(MachineState *mach=
ine)
>      =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0=
x18000000,
>     flash, 0);
>=20
>      =C2=A0 =C2=A0 =C2=A0ddr =3D g_new(MemoryRegion, 1);
>     -=C2=A0 =C2=A0 memory_region_allocate_system_memory(ddr, NULL, "bos=
ton.ddr",
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(ddr, machine, "=
boston.ddr",
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 machine->ram_size);
>      =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0=
x80000000, ddr, 0);
>=20
>     diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>     index cf537dd7e6..d5a5cef619 100644
>     --- a/hw/mips/mips_fulong2e.c
>     +++ b/hw/mips/mips_fulong2e.c
>     @@ -318,7 +318,8 @@ static void mips_fulong2e_init(MachineState
>     *machine)
>      =C2=A0 =C2=A0 =C2=A0ram_size =3D 256 * MiB;
>=20
>      =C2=A0 =C2=A0 =C2=A0/* allocate RAM */
>     -=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, "ful=
ong2e.ram",
>     ram_size);
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, machine,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0"fulong2e.ram", ram_size);
>      =C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, "fulong2e.b=
ios", BIOS_SIZE,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>      =C2=A0 =C2=A0 =C2=A0memory_region_set_readonly(bios, true);
>     diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
>     index 8d010a0b6e..88b125855f 100644
>     --- a/hw/mips/mips_jazz.c
>     +++ b/hw/mips/mips_jazz.c
>     @@ -188,7 +188,7 @@ static void mips_jazz_init(MachineState *machin=
e,
>      =C2=A0 =C2=A0 =C2=A0cc->do_transaction_failed =3D mips_jazz_do_tra=
nsaction_failed;
>=20
>      =C2=A0 =C2=A0 =C2=A0/* allocate RAM */
>     -=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, "mip=
s_jazz.ram",
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, machine, "=
mips_jazz.ram",
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 machine->ram_size);
>      =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(address_space, 0, =
ram);
>=20
>     diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>     index 4d9c64b36a..af56a29ccb 100644
>     --- a/hw/mips/mips_malta.c
>     +++ b/hw/mips/mips_malta.c
>     @@ -1267,7 +1267,7 @@ void mips_malta_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>      =C2=A0 =C2=A0 =C2=A0/* register RAM at high address where it is un=
disturbed by IO */
>     -=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram_high, NULL,
>     "mips_malta.ram",
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram_high, machi=
ne,
>     "mips_malta.ram",
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ram_size);
>      =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(system_memory, 0x8=
0000000, ram_high);
>=20
>     diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>     index 282bbecb24..c1933231e2 100644
>     --- a/hw/mips/mips_mipssim.c
>     +++ b/hw/mips/mips_mipssim.c
>     @@ -166,7 +166,7 @@ mips_mipssim_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0qemu_register_reset(main_cpu_reset, reset_info=
);
>=20
>      =C2=A0 =C2=A0 =C2=A0/* Allocate RAM. */
>     -=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, "mip=
s_mipssim.ram",
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, machine,
>     "mips_mipssim.ram",
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ram_size);
>      =C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, "mips_mipss=
im.bios", BIOS_SIZE,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>     diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>     index bc0be26544..59f8cacfb6 100644
>     --- a/hw/mips/mips_r4k.c
>     +++ b/hw/mips/mips_r4k.c
>     @@ -203,7 +203,8 @@ void mips_r4k_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 " maximum 256MB", ram_size / MiB);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);
>      =C2=A0 =C2=A0 =C2=A0}
>     -=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, "mip=
s_r4k.ram",
>     ram_size);
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, machine, "=
mips_r4k.ram",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ram_size);
>=20
>      =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(address_space_mem,=
 0, ram);
>=20
>     --=20
>     2.21.0
>=20
>=20

