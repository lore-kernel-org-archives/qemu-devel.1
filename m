Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0813CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8082F206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvIFRd03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8082F206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVig-0006AA-Hq
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMVa4-0006JG-3q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMVa2-0006Sw-1b
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:10:31 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iMVa1-0006Ri-RR; Mon, 21 Oct 2019 07:10:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id w6so10634284oie.11;
 Mon, 21 Oct 2019 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=KPD4PToOkGHtHt9KFXbFTI5K/N8HBlEFaxJhkrndnl8=;
 b=bvIFRd03nc/3wzMEeHDWU4HTjNz0POMy+4ESNwZ8RL5hjUm3lQJtAO/wdfUBnabSST
 Y9Mnr9jjA8Cn3y/UPeww0tY/CI9zpeyPUMwboupOCrulqXnwUlKA4V630QugV7BRPqO3
 nUvui4Ck/6v/865KvCn+O62KCWvNf+MhPWYITXNrtEu7gCQtSWnrEOdOuxbD2sKlPF5q
 HpvO+92knlH4OcJEhKvd1ZzhAM856HqzXlppdMdknexswJmx4Npylg8dDZD8mXH3AVjH
 Gs1U0IOgZLvIpuaeztUlzOmX6rhFUUyE6v+xa/HOr0QmKYaJNXNgtubnm9Qm0nlRVBWb
 iT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=KPD4PToOkGHtHt9KFXbFTI5K/N8HBlEFaxJhkrndnl8=;
 b=I7WGvvBTCoQZoD+awfLtfU5RYfyZUbCC25VHKl10N6vAZnen041vdUNlhlIUki6gtM
 tf1za3ldOwlCKeNkX1PTVMIWnOjze2bm8RfpLzO6DidAqq9sKxasNQ475l1Vf96Bc+Uw
 swer9pk/PVD6e1rPh545KgxYmhrI2XHgfCDIIRsFfwFupaXz8ityJku6x8Ur/1tmP5bR
 5BqNlEefd53YJU7Ed8ex7FJlNVgbpBvMssgmZJDAj5UMm+8qWxbVcFI639WZYz6hBOY+
 7PaCfQwjLuMb7z/Ew/pm7Q6C7mZ7qhA2qISgcmMghCXlt598R0zjmLAVc9UwXEZZy2+q
 AHLQ==
X-Gm-Message-State: APjAAAX3v2Rwv4yJdjOpzg2h/hwT+IfvBJsW6aLgTxHG7A8WjSh3uaEj
 JvG1B+dPI6l+Uo3+MryREfE+Y82F1xG/AlVtowE=
X-Google-Smtp-Source: APXvYqwT6Daf8dhYIm5eIPJpicpDsipcaQ7I20dALFhsBeMLjm/OUeHTRjmbnDkzM2pRF29pQJ5+iIvWQO0flsH3RbI=
X-Received: by 2002:aca:62d5:: with SMTP id
 w204mr18742250oib.136.1571656228848; 
 Mon, 21 Oct 2019 04:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 21 Oct 2019 04:10:28
 -0700 (PDT)
In-Reply-To: <d92fc466-9327-04ef-22b9-857d4f18b976@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-19-philmd@redhat.com>
 <CAL1e-=ivk8phw5SOd=a6SO8RJ4E=9kN8hN0tocQYcb7AEKeyEA@mail.gmail.com>
 <698bde03-02a9-be5e-2aff-4e8d50508222@redhat.com>
 <CAL1e-=jtavWvWaajrdTmapFgLfXXhfH8nuWCxY-z8+oMGsOAGA@mail.gmail.com>
 <d92fc466-9327-04ef-22b9-857d4f18b976@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 21 Oct 2019 13:10:28 +0200
Message-ID: <CAL1e-=gbwabWNm1GyzG2K4Y+7dseUMpsj8+cpzNgJ5NT1P+SLQ@mail.gmail.com>
Subject: Re: [PATCH 18/21] hw/mips: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003ac816059569bb09"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ac816059569bb09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> On 10/21/19 12:56 PM, Aleksandar Markovic wrote:
>
>>
>>
>> On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     Hi Aleksandar,
>>
>>     On 10/21/19 8:25 AM, Aleksandar Markovic wrote:
>>
>>
>>
>>         On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9
>>         <philmd@redhat.com <mailto:philmd@redhat.com>
>>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote:
>>
>>              Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om
>>         <mailto:philmd@redhat.com>
>>              <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>>
>>              ---
>>                hw/mips/boston.c        | 2 +-
>>                hw/mips/mips_fulong2e.c | 3 ++-
>>                hw/mips/mips_jazz.c     | 2 +-
>>                hw/mips/mips_malta.c    | 2 +-
>>                hw/mips/mips_mipssim.c  | 2 +-
>>                hw/mips/mips_r4k.c      | 3 ++-
>>                6 files changed, 8 insertions(+), 6 deletions(-)
>>
>>
>>         Philippe, can this patch be applied independently (on other
>>         patches of this series)?
>>
>>
>>     Unfortunately not because patch #9 changed the prototype of
>>     memory_region_allocate_system_memory() so this patch alone
>>     won't build.
>>
>>     I rather expect this series goes as a whole via the machine-next
>>     tree.
>>
>>     Do you mind giving your Acked-by tag to this patch?
>>
>>
>> I can't, sorry, for MIPS target, we don't accept patches with empty
>> commit messages.
>>
>
> I see, I'v been wondering what to do, if simply repeating the patch
> subject or the cover, but since the series applies to all targets, this
> seems overkill. I think I'll simply repeat the subject then.
>
>
Can't you at least add a sentence on why is this needed, or what is
achieved?

Thanks,

A.



>
>> A.
>>
>>
>>     Thanks,
>>
>>     Phil.
>>
>>
>>
>>              diff --git a/hw/mips/boston.c b/hw/mips/boston.c
>>              index ca7d813a52..8445fee0f1 100644
>>              --- a/hw/mips/boston.c
>>              +++ b/hw/mips/boston.c
>>              @@ -474,7 +474,7 @@ static void
>>         boston_mach_init(MachineState *machine)
>>                    memory_region_add_subregion_overlap(sys_mem,
>> 0x18000000,
>>              flash, 0);
>>
>>                    ddr =3D g_new(MemoryRegion, 1);
>>              -    memory_region_allocate_system_memory(ddr, NULL,
>>         "boston.ddr",
>>              +    memory_region_allocate_system_memory(ddr, machine,
>>         "boston.ddr",
>>
>> machine->ram_size);
>>                    memory_region_add_subregion_overlap(sys_mem,
>>         0x80000000, ddr, 0);
>>
>>              diff --git a/hw/mips/mips_fulong2e.c
>> b/hw/mips/mips_fulong2e.c
>>              index cf537dd7e6..d5a5cef619 100644
>>              --- a/hw/mips/mips_fulong2e.c
>>              +++ b/hw/mips/mips_fulong2e.c
>>              @@ -318,7 +318,8 @@ static void
>> mips_fulong2e_init(MachineState
>>              *machine)
>>                    ram_size =3D 256 * MiB;
>>
>>                    /* allocate RAM */
>>              -    memory_region_allocate_system_memory(ram, NULL,
>>         "fulong2e.ram",
>>              ram_size);
>>              +    memory_region_allocate_system_memory(ram, machine,
>>              +                                         "fulong2e.ram",
>>         ram_size);
>>                    memory_region_init_ram(bios, NULL, "fulong2e.bios",
>>         BIOS_SIZE,
>>                                           &error_fatal);
>>                    memory_region_set_readonly(bios, true);
>>              diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
>>              index 8d010a0b6e..88b125855f 100644
>>              --- a/hw/mips/mips_jazz.c
>>              +++ b/hw/mips/mips_jazz.c
>>              @@ -188,7 +188,7 @@ static void mips_jazz_init(MachineState
>>         *machine,
>>                    cc->do_transaction_failed =3D
>>         mips_jazz_do_transaction_failed;
>>
>>                    /* allocate RAM */
>>              -    memory_region_allocate_system_memory(ram, NULL,
>>         "mips_jazz.ram",
>>              +    memory_region_allocate_system_memory(ram, machine,
>>         "mips_jazz.ram",
>>
>> machine->ram_size);
>>                    memory_region_add_subregion(address_space, 0, ram);
>>
>>              diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>              index 4d9c64b36a..af56a29ccb 100644
>>              --- a/hw/mips/mips_malta.c
>>              +++ b/hw/mips/mips_malta.c
>>              @@ -1267,7 +1267,7 @@ void mips_malta_init(MachineState
>>         *machine)
>>                    }
>>
>>                    /* register RAM at high address where it is
>>         undisturbed by IO */
>>              -    memory_region_allocate_system_memory(ram_high, NULL,
>>              "mips_malta.ram",
>>              +    memory_region_allocate_system_memory(ram_high, machine=
,
>>              "mips_malta.ram",
>>                                                         ram_size);
>>                    memory_region_add_subregion(system_memory,
>>         0x80000000, ram_high);
>>
>>              diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.=
c
>>              index 282bbecb24..c1933231e2 100644
>>              --- a/hw/mips/mips_mipssim.c
>>              +++ b/hw/mips/mips_mipssim.c
>>              @@ -166,7 +166,7 @@ mips_mipssim_init(MachineState *machine=
)
>>                    qemu_register_reset(main_cpu_reset, reset_info);
>>
>>                    /* Allocate RAM. */
>>              -    memory_region_allocate_system_memory(ram, NULL,
>>         "mips_mipssim.ram",
>>              +    memory_region_allocate_system_memory(ram, machine,
>>              "mips_mipssim.ram",
>>                                                         ram_size);
>>                    memory_region_init_ram(bios, NULL,
>>         "mips_mipssim.bios", BIOS_SIZE,
>>                                           &error_fatal);
>>              diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>>              index bc0be26544..59f8cacfb6 100644
>>              --- a/hw/mips/mips_r4k.c
>>              +++ b/hw/mips/mips_r4k.c
>>              @@ -203,7 +203,8 @@ void mips_r4k_init(MachineState *machin=
e)
>>                                     " maximum 256MB", ram_size / MiB);
>>                        exit(1);
>>                    }
>>              -    memory_region_allocate_system_memory(ram, NULL,
>>         "mips_r4k.ram",
>>              ram_size);
>>              +    memory_region_allocate_system_memory(ram, machine,
>>         "mips_r4k.ram",
>>              +                                         ram_size);
>>
>>                    memory_region_add_subregion(address_space_mem, 0,
>> ram);
>>
>>              --     2.21.0
>>
>>
>>

--0000000000003ac816059569bb09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBNb25kYXksIE9jdG9iZXIgMjEsIDIwMTksIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iPnBoaWxtZEByZWRoYXQu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPk9uIDEwLzIxLzE5IDEyOjU2IFBNLCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3Rl
Ojxicj4NCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KPGJy
Pg0KPGJyPg0KT24gTW9uZGF5LCBPY3RvYmVyIDIxLCAyMDE5LCBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFu
ayI+cGhpbG1kQHJlZGhhdC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnBoaWxt
ZEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0OyZn
dDsgd3JvdGU6PGJyPg0KPGJyPg0KwqAgwqAgSGkgQWxla3NhbmRhciw8YnI+DQo8YnI+DQrCoCDC
oCBPbiAxMC8yMS8xOSA4OjI1IEFNLCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3RlOjxicj4NCjxi
cj4NCjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIE9uIE1vbmRheSwgT2N0b2JlciAyMSwgMjAxOSwg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k8YnI+DQrCoCDCoCDCoCDCoCAmbHQ7PGEgaHJlZj0ibWFp
bHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208
L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJnZXQ9
Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0Ozxicj4NCsKgIMKgIMKgIMKgICZsdDtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+
cGhpbG1kQHJlZGhhdC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnBoaWxtZEBy
ZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0OyZndDsm
Z3Q7IHdyb3RlOjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgU2lnbmVkLW9mZi1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgJmx0OzxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPjxicj4NCsKgIMKgIMKg
IMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJnZXQ9
Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgwqAg
wqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iIHRhcmdldD0i
X2JsYW5rIj5waGlsbWRAcmVkaGF0LmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
cGhpbG1kQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5waGlsbWRAcmVkaGF0LmNvbTwvYT4m
Z3Q7Jmd0OyZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIC0tLTxicj4NCsKgIMKgIMKgIMKg
IMKgwqAgwqAgwqDCoGh3L21pcHMvYm9zdG9uLmPCoCDCoCDCoCDCoCB8IDIgKy08YnI+DQrCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgwqBody9taXBzL21pcHNfZnVsb25nMmUuYyB8IDMgKystPGJyPg0K
wqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgaHcvbWlwcy9taXBzX2phenouY8KgIMKgIMKgfCAyICst
PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgaHcvbWlwcy9taXBzX21hbHRhLmPCoCDCoCB8
IDIgKy08YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqBody9taXBzL21pcHNfbWlwc3NpbS5j
wqAgfCAyICstPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgaHcvbWlwcy9taXBzX3I0ay5j
wqAgwqAgwqAgfCAzICsrLTxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoDYgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCjxicj4NCsKg
IMKgIMKgIMKgIFBoaWxpcHBlLCBjYW4gdGhpcyBwYXRjaCBiZSBhcHBsaWVkIGluZGVwZW5kZW50
bHkgKG9uIG90aGVyPGJyPg0KwqAgwqAgwqAgwqAgcGF0Y2hlcyBvZiB0aGlzIHNlcmllcyk/PGJy
Pg0KPGJyPg0KPGJyPg0KwqAgwqAgVW5mb3J0dW5hdGVseSBub3QgYmVjYXVzZSBwYXRjaCAjOSBj
aGFuZ2VkIHRoZSBwcm90b3R5cGUgb2Y8YnI+DQrCoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9jYXRl
X3N5c3RlbV88d2JyPm1lbW9yeSgpIHNvIHRoaXMgcGF0Y2ggYWxvbmU8YnI+DQrCoCDCoCB3b24m
IzM5O3QgYnVpbGQuPGJyPg0KPGJyPg0KwqAgwqAgSSByYXRoZXIgZXhwZWN0IHRoaXMgc2VyaWVz
IGdvZXMgYXMgYSB3aG9sZSB2aWEgdGhlIG1hY2hpbmUtbmV4dDxicj4NCsKgIMKgIHRyZWUuPGJy
Pg0KPGJyPg0KwqAgwqAgRG8geW91IG1pbmQgZ2l2aW5nIHlvdXIgQWNrZWQtYnkgdGFnIHRvIHRo
aXMgcGF0Y2g/PGJyPg0KPGJyPg0KPGJyPg0KSSBjYW4mIzM5O3QsIHNvcnJ5LCBmb3IgTUlQUyB0
YXJnZXQsIHdlIGRvbiYjMzk7dCBhY2NlcHQgcGF0Y2hlcyB3aXRoIGVtcHR5IGNvbW1pdCBtZXNz
YWdlcy48YnI+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+DQpJIHNlZSwgSSYjMzk7diBiZWVuIHdvbmRl
cmluZyB3aGF0IHRvIGRvLCBpZiBzaW1wbHkgcmVwZWF0aW5nIHRoZSBwYXRjaCBzdWJqZWN0IG9y
IHRoZSBjb3ZlciwgYnV0IHNpbmNlIHRoZSBzZXJpZXMgYXBwbGllcyB0byBhbGwgdGFyZ2V0cywg
dGhpcyBzZWVtcyBvdmVya2lsbC4gSSB0aGluayBJJiMzOTtsbCBzaW1wbHkgcmVwZWF0IHRoZSBz
dWJqZWN0IHRoZW4uPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkNh
biYjMzk7dCB5b3UgYXQgbGVhc3QgYWRkIGEgc2VudGVuY2Ugb24gd2h5IGlzIHRoaXMgbmVlZGVk
LCBvciB3aGF0IGlzIGFjaGlldmVkPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQo8YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCkEuPGJyPg0KPGJy
Pg0KPGJyPg0KwqAgwqAgVGhhbmtzLDxicj4NCjxicj4NCsKgIMKgIFBoaWwuPGJyPg0KPGJyPg0K
PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZmIC0tZ2l0IGEvaHcvbWlwcy9ib3N0
b24uYyBiL2h3L21pcHMvYm9zdG9uLmM8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIGluZGV4IGNh
N2Q4MTNhNTIuLjg0NDVmZWUwZjEgMTAwNjQ0PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCAtLS0g
YS9ody9taXBzL2Jvc3Rvbi5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCArKysgYi9ody9taXBz
L2Jvc3Rvbi5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBAQCAtNDc0LDcgKzQ3NCw3IEBAIHN0
YXRpYyB2b2lkPGJyPg0KwqAgwqAgwqAgwqAgYm9zdG9uX21hY2hfaW5pdChNYWNoaW5lU3RhdGUg
Km1hY2hpbmUpPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgbWVtb3J5X3JlZ2lv
bl9hZGRfc3VicmVnaW9uX288d2JyPnZlcmxhcChzeXNfbWVtLCAweDE4MDAwMDAwLDxicj4NCsKg
IMKgIMKgIMKgIMKgwqAgwqAgZmxhc2gsIDApOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgwqAg
wqAgwqDCoCDCoCDCoGRkciA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7PGJyPg0KwqAgwqAgwqAg
wqAgwqDCoCDCoCAtwqAgwqAgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fPHdicj5tZW1v
cnkoZGRyLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgICZxdW90O2Jvc3Rvbi5kZHImcXVvdDssPGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCArwqAgwqAgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0
ZW1fPHdicj5tZW1vcnkoZGRyLCBtYWNoaW5lLDxicj4NCsKgIMKgIMKgIMKgICZxdW90O2Jvc3Rv
bi5kZHImcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1hY2hpbmUtJmd0
O3JhbV9zaXplKTs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqBtZW1vcnlfcmVn
aW9uX2FkZF9zdWJyZWdpb25fbzx3YnI+dmVybGFwKHN5c19tZW0sPGJyPg0KwqAgwqAgwqAgwqAg
MHg4MDAwMDAwMCwgZGRyLCAwKTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIGRpZmYg
LS1naXQgYS9ody9taXBzL21pcHNfZnVsb25nMmUuYyBiL2h3L21pcHMvbWlwc19mdWxvbmcyZS5j
PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBpbmRleCBjZjUzN2RkN2U2Li5kNWE1Y2VmNjE5IDEw
MDY0NDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgLS0tIGEvaHcvbWlwcy9taXBzX2Z1bG9uZzJl
LmM8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgICsrKyBiL2h3L21pcHMvbWlwc19mdWxvbmcyZS5j
PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBAQCAtMzE4LDcgKzMxOCw4IEBAIHN0YXRpYyB2b2lk
IG1pcHNfZnVsb25nMmVfaW5pdChNYWNoaW5lU3RhdDx3YnI+ZTxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgKm1hY2hpbmUpPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgcmFtX3Np
emUgPSAyNTYgKiBNaUI7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKg
LyogYWxsb2NhdGUgUkFNICovPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCAtwqAgwqAgbWVtb3J5
X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fPHdicj5tZW1vcnkocmFtLCBOVUxMLDxicj4NCsKgIMKg
IMKgIMKgICZxdW90O2Z1bG9uZzJlLnJhbSZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKg
IHJhbV9zaXplKTs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgICvCoCDCoCBtZW1vcnlfcmVnaW9u
X2FsbG9jYXRlX3N5c3RlbV88d2JyPm1lbW9yeShyYW0sIG1hY2hpbmUsPGJyPg0KwqAgwqAgwqAg
wqAgwqDCoCDCoCArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtmdWxvbmcyZS5yYW0mcXVvdDssPGJyPg0KwqAgwqAgwqAg
wqAgcmFtX3NpemUpOzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoG1lbW9yeV9y
ZWdpb25faW5pdF9yYW0oYmlvcywgTlVMTCwgJnF1b3Q7ZnVsb25nMmUuYmlvcyZxdW90Oyw8YnI+
DQrCoCDCoCDCoCDCoCBCSU9TX1NJWkUsPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7ZXJyb3JfZmF0YWwpOzxi
cj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoG1lbW9yeV9yZWdpb25fc2V0X3JlYWRv
bmx5KGJpPHdicj5vcywgdHJ1ZSk7PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZmIC0tZ2l0
IGEvaHcvbWlwcy9taXBzX2phenouYyBiL2h3L21pcHMvbWlwc19qYXp6LmM8YnI+DQrCoCDCoCDC
oCDCoCDCoMKgIMKgIGluZGV4IDhkMDEwYTBiNmUuLjg4YjEyNTg1NWYgMTAwNjQ0PGJyPg0KwqAg
wqAgwqAgwqAgwqDCoCDCoCAtLS0gYS9ody9taXBzL21pcHNfamF6ei5jPGJyPg0KwqAgwqAgwqAg
wqAgwqDCoCDCoCArKysgYi9ody9taXBzL21pcHNfamF6ei5jPGJyPg0KwqAgwqAgwqAgwqAgwqDC
oCDCoCBAQCAtMTg4LDcgKzE4OCw3IEBAIHN0YXRpYyB2b2lkIG1pcHNfamF6el9pbml0KE1hY2hp
bmVTdGF0ZTxicj4NCsKgIMKgIMKgIMKgICptYWNoaW5lLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAg
wqAgwqDCoCDCoCDCoGNjLSZndDtkb190cmFuc2FjdGlvbl9mYWlsZWQgPTxicj4NCsKgIMKgIMKg
IMKgIG1pcHNfamF6el9kb190cmFuc2FjdGlvbl9mYWlsZTx3YnI+ZDs8YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAvKiBhbGxvY2F0ZSBSQU0gKi88YnI+DQrCoCDCoCDC
oCDCoCDCoMKgIMKgIC3CoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9jYXRlX3N5c3RlbV88d2JyPm1l
bW9yeShyYW0sIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgJnF1b3Q7bWlwc19qYXp6LnJhbSZxdW90
Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgICvCoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9jYXRl
X3N5c3RlbV88d2JyPm1lbW9yeShyYW0sIG1hY2hpbmUsPGJyPg0KwqAgwqAgwqAgwqAgJnF1b3Q7
bWlwc19qYXp6LnJhbSZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWFj
aGluZS0mZ3Q7cmFtX3NpemUpOzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoG1l
bW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihhPHdicj5kZHJlc3Nfc3BhY2UsIDAsIHJhbSk7PGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZmIC0tZ2l0IGEvaHcvbWlwcy9taXBzX21h
bHRhLmMgYi9ody9taXBzL21pcHNfbWFsdGEuYzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgaW5k
ZXggNGQ5YzY0YjM2YS4uYWY1NmEyOWNjYiAxMDA2NDQ8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKg
IC0tLSBhL2h3L21pcHMvbWlwc19tYWx0YS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCArKysg
Yi9ody9taXBzL21pcHNfbWFsdGEuYzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgQEAgLTEyNjcs
NyArMTI2Nyw3IEBAIHZvaWQgbWlwc19tYWx0YV9pbml0KE1hY2hpbmVTdGF0ZTxicj4NCsKgIMKg
IMKgIMKgICptYWNoaW5lKTxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoH08YnI+
DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAvKiByZWdpc3RlciBSQU0gYXQg
aGlnaCBhZGRyZXNzIHdoZXJlIGl0IGlzPGJyPg0KwqAgwqAgwqAgwqAgdW5kaXN0dXJiZWQgYnkg
SU8gKi88YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIC3CoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9j
YXRlX3N5c3RlbV88d2JyPm1lbW9yeShyYW1faGlnaCwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDC
oMKgIMKgICZxdW90O21pcHNfbWFsdGEucmFtJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgwqAg
wqAgK8KgIMKgIG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtXzx3YnI+bWVtb3J5KHJhbV9o
aWdoLCBtYWNoaW5lLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgJnF1b3Q7bWlwc19tYWx0YS5y
YW0mcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhbV9zaXplKTs8YnI+
DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24oczx3YnI+eXN0ZW1fbWVtb3J5LDxicj4NCsKgIMKgIMKgIMKgIDB4ODAwMDAwMDAsIHJhbV9o
aWdoKTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIGRpZmYgLS1naXQgYS9ody9taXBz
L21pcHNfbWlwc3NpbS5jIGIvaHcvbWlwcy9taXBzX21pcHNzaW0uYzxicj4NCsKgIMKgIMKgIMKg
IMKgwqAgwqAgaW5kZXggMjgyYmJlY2IyNC4uYzE5MzMyMzFlMiAxMDA2NDQ8YnI+DQrCoCDCoCDC
oCDCoCDCoMKgIMKgIC0tLSBhL2h3L21pcHMvbWlwc19taXBzc2ltLmM8YnI+DQrCoCDCoCDCoCDC
oCDCoMKgIMKgICsrKyBiL2h3L21pcHMvbWlwc19taXBzc2ltLmM8YnI+DQrCoCDCoCDCoCDCoCDC
oMKgIMKgIEBAIC0xNjYsNyArMTY2LDcgQEAgbWlwc19taXBzc2ltX2luaXQoTWFjaGluZVN0YXRl
ICptYWNoaW5lKTxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoHFlbXVfcmVnaXN0
ZXJfcmVzZXQobWFpbl9jcHVfPHdicj5yZXNldCwgcmVzZXRfaW5mbyk7PGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgLyogQWxsb2NhdGUgUkFNLiAqLzxicj4NCsKgIMKg
IMKgIMKgIMKgwqAgwqAgLcKgIMKgIG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtXzx3YnI+
bWVtb3J5KHJhbSwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCAmcXVvdDttaXBzX21pcHNzaW0ucmFt
JnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgK8KgIMKgIG1lbW9yeV9yZWdpb25fYWxs
b2NhdGVfc3lzdGVtXzx3YnI+bWVtb3J5KHJhbSwgbWFjaGluZSw8YnI+DQrCoCDCoCDCoCDCoCDC
oMKgIMKgICZxdW90O21pcHNfbWlwc3NpbS5yYW0mcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqDC
oCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHJhbV9zaXplKTs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAg
wqBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKGJpb3MsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgJnF1
b3Q7bWlwc19taXBzc2ltLmJpb3MmcXVvdDssIEJJT1NfU0laRSw8YnI+DQrCoCDCoCDCoCDCoCDC
oMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtl
cnJvcl9mYXRhbCk7PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZmIC0tZ2l0IGEvaHcvbWlw
cy9taXBzX3I0ay5jIGIvaHcvbWlwcy9taXBzX3I0ay5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDC
oCBpbmRleCBiYzBiZTI2NTQ0Li41OWY4Y2FjZmI2IDEwMDY0NDxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgLS0tIGEvaHcvbWlwcy9taXBzX3I0ay5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCAr
KysgYi9ody9taXBzL21pcHNfcjRrLmM8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIEBAIC0yMDMs
NyArMjAzLDggQEAgdm9pZCBtaXBzX3I0a19pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+
DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JnF1b3Q7IG1heGltdW0gMjU2TUImcXVvdDssIHJhbV9zaXplIC8gTWlCKTs8YnI+DQrCoCDCoCDC
oCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAgwqAgwqBleGl0KDEpOzxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIC3CoCDCoCBtZW1vcnlf
cmVnaW9uX2FsbG9jYXRlX3N5c3RlbV88d2JyPm1lbW9yeShyYW0sIE5VTEwsPGJyPg0KwqAgwqAg
wqAgwqAgJnF1b3Q7bWlwc19yNGsucmFtJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAg
cmFtX3NpemUpOzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgK8KgIMKgIG1lbW9yeV9yZWdpb25f
YWxsb2NhdGVfc3lzdGVtXzx3YnI+bWVtb3J5KHJhbSwgbWFjaGluZSw8YnI+DQrCoCDCoCDCoCDC
oCAmcXVvdDttaXBzX3I0ay5yYW0mcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByYW1fc2l6ZSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgbWVt
b3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGE8d2JyPmRkcmVzc19zcGFjZV9tZW0sIDAsIHJhbSk7
PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCAtLcKgIMKgIMKgMi4yMS4wPGJyPg0KPGJy
Pg0KPGJyPg0KPC9ibG9ja3F1b3RlPg0KPC9ibG9ja3F1b3RlPg0K
--0000000000003ac816059569bb09--

