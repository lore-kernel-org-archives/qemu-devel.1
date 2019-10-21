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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E04DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DE7205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ/kjKaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DE7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39799 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWXh-00049H-2Z
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMWWa-0003J5-CO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMWWY-0004Qf-7h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:11:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iMWWY-0004QG-0z; Mon, 21 Oct 2019 08:10:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id 89so10716210oth.13;
 Mon, 21 Oct 2019 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=TuSY7A6bMBH5Mw87vlCzZrCqjRgHURD+w68j5QBdXxE=;
 b=rQ/kjKaD7riNVg6YrgsZWiZbc8wuh7gyRJkGbSJoF5rsYHT00KTdKcT/i0O6sgeGLu
 Reway40kXQvUHYzfxs3hi7OEs5vNFzDQKQHxg0R3+LXd6I+ceR211QBrRyRJF+rPG/08
 woqYCxJCBlU//G3ueaGb1GIEUy167EP3ZqqARg9HKzKpqmPsoySEzHfFC9uNfCOUNREY
 AEf6O4ZM2mD6bQ4gPkrQ6gaUvlIKjzyZPpVdCO/S8St12AylClP6sFberJKN7vd4sD2s
 gnGVSODTN5vdWNTULhjJCb33vViAfc2CaaPHFaTVk+z5TF1xx/86npEjdzlLtq0CtoU0
 zjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=TuSY7A6bMBH5Mw87vlCzZrCqjRgHURD+w68j5QBdXxE=;
 b=UDYMUH5EWQmE0ySam4drj1ftGLC7BMLRqOqnrplQSRf1tSyeDTboDTBkE6hcNdsJLd
 hTtwtdWXqPeuaueLfWW33T0zgZakHhcmtdoAEU7JnE6htXqlJDzWb7LxKExuJ+ptkfem
 vKthMur9BkV/tvVDnjSZOFfDmMU+x68og+1t1s0y00ljCYmY+oc/n9kEQ3S/V101kBxo
 RDUmOvUw0Ic/fycmF/t4vXG9t/CewVTtf48bam1O6fvDgWmEy0+P8QjwU46flGsRWpcm
 16JT3W2+OHlYbz6uJnwJAi1+Ap3X9oMDZ7CKRXZs8R8CiJD4Ubc8S7DQjQeEZyu3x74O
 JFZw==
X-Gm-Message-State: APjAAAUU6Ufxmxh0ghOwQo8Dq50aO2eb/Pas4D6BoLBa0lME8P07fHPj
 KWGd69l/LruU3aleSOUVWPx6DkjvtRBiJMgJV24=
X-Google-Smtp-Source: APXvYqxQ4QviYGmekjk8XAFkvyl5x50A+ldBRrmfkjIcJpdr8MZrkcNcAWFxOA39Ic9qINqtkcVClUoenWOm9ryBk8E=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr181719oth.306.1571659857170; 
 Mon, 21 Oct 2019 05:10:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 21 Oct 2019 05:10:56
 -0700 (PDT)
In-Reply-To: <3780f13b-8c03-fd96-47e3-1e1da3ecde2a@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-19-philmd@redhat.com>
 <CAL1e-=ivk8phw5SOd=a6SO8RJ4E=9kN8hN0tocQYcb7AEKeyEA@mail.gmail.com>
 <698bde03-02a9-be5e-2aff-4e8d50508222@redhat.com>
 <CAL1e-=jtavWvWaajrdTmapFgLfXXhfH8nuWCxY-z8+oMGsOAGA@mail.gmail.com>
 <d92fc466-9327-04ef-22b9-857d4f18b976@redhat.com>
 <CAL1e-=gbwabWNm1GyzG2K4Y+7dseUMpsj8+cpzNgJ5NT1P+SLQ@mail.gmail.com>
 <3780f13b-8c03-fd96-47e3-1e1da3ecde2a@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 21 Oct 2019 14:10:56 +0200
Message-ID: <CAL1e-=h1PPE6crWXVTbr_shpZUGbq6g=O8gefCmi5AFT5KkBLA@mail.gmail.com>
Subject: Re: [PATCH 18/21] hw/mips: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007e9a4405956a934d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

--0000000000007e9a4405956a934d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> On 10/21/19 1:10 PM, Aleksandar Markovic wrote:
>
>> On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     On 10/21/19 12:56 PM, Aleksandar Markovic wrote:
>>
>>
>>
>>         On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9
>>         <philmd@redhat.com <mailto:philmd@redhat.com>
>>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote:
>>
>>              Hi Aleksandar,
>>
>>              On 10/21/19 8:25 AM, Aleksandar Markovic wrote:
>>
>>
>>
>>                  On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=
=A9
>>                  <philmd@redhat.com <mailto:philmd@redhat.com>
>>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>
>>                  <mailto:philmd@redhat.com <mailto:philmd@redhat.com>
>>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>>> wrote:
>>
>>                       Signed-off-by: Philippe Mathieu-Daud=C3=A9
>>         <philmd@redhat.com <mailto:philmd@redhat.com>
>>                  <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>
>>                       <mailto:philmd@redhat.com
>>         <mailto:philmd@redhat.com> <mailto:philmd@redhat.com
>>         <mailto:philmd@redhat.com>>>>
>>                       ---
>>                         hw/mips/boston.c        | 2 +-
>>                         hw/mips/mips_fulong2e.c | 3 ++-
>>                         hw/mips/mips_jazz.c     | 2 +-
>>                         hw/mips/mips_malta.c    | 2 +-
>>                         hw/mips/mips_mipssim.c  | 2 +-
>>                         hw/mips/mips_r4k.c      | 3 ++-
>>                         6 files changed, 8 insertions(+), 6 deletions(-)
>>
>>
>>                  Philippe, can this patch be applied independently (on
>> other
>>                  patches of this series)?
>>
>>
>>              Unfortunately not because patch #9 changed the prototype of
>>              memory_region_allocate_system_memory() so this patch alone
>>              won't build.
>>
>>              I rather expect this series goes as a whole via the
>>         machine-next
>>              tree.
>>
>>              Do you mind giving your Acked-by tag to this patch?
>>
>>
>>         I can't, sorry, for MIPS target, we don't accept patches with
>>         empty commit messages.
>>
>>
>>     I see, I'v been wondering what to do, if simply repeating the patch
>>     subject or the cover, but since the series applies to all targets,
>>     this seems overkill. I think I'll simply repeat the subject then.
>>
>>
>> Can't you at least add a sentence on why is this needed, or what is
>> achieved?
>>
>
> You are alright, I'll do.



Cool, I'd appreciate it very much.

A.




>
>
>> Thanks,
>>
>> A.
>>
>>
>>         A.
>>
>>
>>              Thanks,
>>
>>              Phil.
>>
>>
>>
>>                       diff --git a/hw/mips/boston.c b/hw/mips/boston.c
>>                       index ca7d813a52..8445fee0f1 100644
>>                       --- a/hw/mips/boston.c
>>                       +++ b/hw/mips/boston.c
>>                       @@ -474,7 +474,7 @@ static void
>>                  boston_mach_init(MachineState *machine)
>>                             memory_region_add_subregion_overlap(sys_mem,
>>         0x18000000,
>>                       flash, 0);
>>
>>                             ddr =3D g_new(MemoryRegion, 1);
>>                       -    memory_region_allocate_system_memory(ddr,
>> NULL,
>>                  "boston.ddr",
>>                       +    memory_region_allocate_system_memory(ddr,
>>         machine,
>>                  "boston.ddr",
>>
>> machine->ram_size);
>>                             memory_region_add_subregion_overlap(sys_mem,
>>                  0x80000000, ddr, 0);
>>
>>                       diff --git a/hw/mips/mips_fulong2e.c
>>         b/hw/mips/mips_fulong2e.c
>>                       index cf537dd7e6..d5a5cef619 100644
>>                       --- a/hw/mips/mips_fulong2e.c
>>                       +++ b/hw/mips/mips_fulong2e.c
>>                       @@ -318,7 +318,8 @@ static void
>>         mips_fulong2e_init(MachineState
>>                       *machine)
>>                             ram_size =3D 256 * MiB;
>>
>>                             /* allocate RAM */
>>                       -    memory_region_allocate_system_memory(ram,
>> NULL,
>>                  "fulong2e.ram",
>>                       ram_size);
>>                       +    memory_region_allocate_system_memory(ram,
>>         machine,
>>                       +
>>  "fulong2e.ram",
>>                  ram_size);
>>                             memory_region_init_ram(bios, NULL,
>>         "fulong2e.bios",
>>                  BIOS_SIZE,
>>                                                    &error_fatal);
>>                             memory_region_set_readonly(bios, true);
>>                       diff --git a/hw/mips/mips_jazz.c
>> b/hw/mips/mips_jazz.c
>>                       index 8d010a0b6e..88b125855f 100644
>>                       --- a/hw/mips/mips_jazz.c
>>                       +++ b/hw/mips/mips_jazz.c
>>                       @@ -188,7 +188,7 @@ static void
>>         mips_jazz_init(MachineState
>>                  *machine,
>>                             cc->do_transaction_failed =3D
>>                  mips_jazz_do_transaction_failed;
>>
>>                             /* allocate RAM */
>>                       -    memory_region_allocate_system_memory(ram,
>> NULL,
>>                  "mips_jazz.ram",
>>                       +    memory_region_allocate_system_memory(ram,
>>         machine,
>>                  "mips_jazz.ram",
>>
>> machine->ram_size);
>>                             memory_region_add_subregion(address_space,
>>         0, ram);
>>
>>                       diff --git a/hw/mips/mips_malta.c
>>         b/hw/mips/mips_malta.c
>>                       index 4d9c64b36a..af56a29ccb 100644
>>                       --- a/hw/mips/mips_malta.c
>>                       +++ b/hw/mips/mips_malta.c
>>                       @@ -1267,7 +1267,7 @@ void
>>         mips_malta_init(MachineState
>>                  *machine)
>>                             }
>>
>>                             /* register RAM at high address where it is
>>                  undisturbed by IO */
>>                       -           memory_region_allocate_system_memory(r=
am_high,
>> NULL,
>>                       "mips_malta.ram",
>>                       +           memory_region_allocate_system_memory(r=
am_high,
>> machine,
>>                       "mips_malta.ram",
>>
>> ram_size);
>>                             memory_region_add_subregion(system_memory,
>>                  0x80000000, ram_high);
>>
>>                       diff --git a/hw/mips/mips_mipssim.c
>>         b/hw/mips/mips_mipssim.c
>>                       index 282bbecb24..c1933231e2 100644
>>                       --- a/hw/mips/mips_mipssim.c
>>                       +++ b/hw/mips/mips_mipssim.c
>>                       @@ -166,7 +166,7 @@ mips_mipssim_init(MachineState
>>         *machine)
>>                             qemu_register_reset(main_cpu_reset,
>> reset_info);
>>
>>                             /* Allocate RAM. */
>>                       -    memory_region_allocate_system_memory(ram,
>> NULL,
>>                  "mips_mipssim.ram",
>>                       +    memory_region_allocate_system_memory(ram,
>>         machine,
>>                       "mips_mipssim.ram",
>>
>> ram_size);
>>                             memory_region_init_ram(bios, NULL,
>>                  "mips_mipssim.bios", BIOS_SIZE,
>>                                                    &error_fatal);
>>                       diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k=
.c
>>                       index bc0be26544..59f8cacfb6 100644
>>                       --- a/hw/mips/mips_r4k.c
>>                       +++ b/hw/mips/mips_r4k.c
>>                       @@ -203,7 +203,8 @@ void
>>         mips_r4k_init(MachineState *machine)
>>                                              " maximum 256MB", ram_size
>>         / MiB);
>>                                 exit(1);
>>                             }
>>                       -    memory_region_allocate_system_memory(ram,
>> NULL,
>>                  "mips_r4k.ram",
>>                       ram_size);
>>                       +    memory_region_allocate_system_memory(ram,
>>         machine,
>>                  "mips_r4k.ram",
>>                       +                                         ram_size=
);
>>
>>                                     memory_region_add_subregion(address_=
space_mem,
>> 0, ram);
>>
>>                       --     2.21.0
>>
>>
>>

--0000000000007e9a4405956a934d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBNb25kYXksIE9jdG9iZXIgMjEsIDIwMTksIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iPnBoaWxtZEByZWRoYXQu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPk9uIDEwLzIxLzE5IDE6MTAgUE0sIEFsZWtzYW5kYXIgTWFya292aWMgd3JvdGU6
PGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQpPbiBN
b25kYXksIE9jdG9iZXIgMjEsIDIwMTksIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBo
cmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5waGlsbWRAcmVk
aGF0LmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20i
IHRhcmdldD0iX2JsYW5rIj5waGlsbWRAcmVkaGF0LmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8YnI+
DQo8YnI+DQrCoCDCoCBPbiAxMC8yMS8xOSAxMjo1NiBQTSwgQWxla3NhbmRhciBNYXJrb3ZpYyB3
cm90ZTo8YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBPbiBNb25kYXksIE9jdG9i
ZXIgMjEsIDIwMTksIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpPGJyPg0KwqAgwqAgwqAgwqAgJmx0
OzxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxt
ZEByZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDs8YnI+DQrCoCDC
oCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1h
aWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29t
PC9hPiZndDsmZ3Q7Jmd0OyB3cm90ZTo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIEhp
IEFsZWtzYW5kYXIsPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBPbiAxMC8yMS8xOSA4
OjI1IEFNLCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3RlOjxicj4NCjxicj4NCjxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgT24gTW9uZGF5LCBPY3RvYmVyIDIxLCAyMDE5LCBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqTxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgJmx0
OzxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxt
ZEByZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDs8YnI+DQrCoCDC
oCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1h
aWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29t
PC9hPiZndDsmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEBy
ZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDs8YnI+DQrCoCDCoCDC
oCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9h
PiZndDsmZ3Q7Jmd0OyZndDsgd3JvdGU6PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDC
oCDCoCDCoMKgIMKgIFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpPGJyPg0K
wqAgwqAgwqAgwqAgJmx0OzxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpwaGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9h
PiZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5j
b208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnBoaWxtZEByZWRoYXQuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0OyZndDs8YnI+DQrCoCDCoCDCoCDC
oCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86cGhpbG1k
QHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5waGlsbWRAcmVkaGF0LmNvbTwvYT48YnI+DQrC
oCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDsgJmx0O21haWx0bzo8YSBo
cmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5waGlsbWRAcmVk
aGF0LmNvbTwvYT48YnI+DQrCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpw
aGlsbWRAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBoaWxtZEByZWRoYXQuY29tPC9hPiZn
dDsmZ3Q7Jmd0OyZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgLS0t
PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqBody9taXBzL2Jvc3Rv
bi5jwqAgwqAgwqAgwqAgfCAyICstPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgwqBody9taXBzL21pcHNfZnVsb25nMmUuYyB8IDMgKystPGJyPg0KwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqBody9taXBzL21pcHNfamF6ei5jwqAgwqAgwqB8IDIg
Ky08YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoGh3L21pcHMvbWlw
c19tYWx0YS5jwqAgwqAgfCAyICstPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgwqBody9taXBzL21pcHNfbWlwc3NpbS5jwqAgfCAyICstPGJyPg0KwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqBody9taXBzL21pcHNfcjRrLmPCoCDCoCDCoCB8IDMg
KystPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqA2IGZpbGVzIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQo8YnI+DQrC
oCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIFBoaWxpcHBlLCBjYW4gdGhpcyBwYXRjaCBiZSBhcHBs
aWVkIGluZGVwZW5kZW50bHkgKG9uIG90aGVyPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDC
oCBwYXRjaGVzIG9mIHRoaXMgc2VyaWVzKT88YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDC
oMKgIMKgIFVuZm9ydHVuYXRlbHkgbm90IGJlY2F1c2UgcGF0Y2ggIzkgY2hhbmdlZCB0aGUgcHJv
dG90eXBlIG9mPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9jYXRl
X3N5c3RlbV88d2JyPm1lbW9yeSgpIHNvIHRoaXMgcGF0Y2ggYWxvbmU8YnI+DQrCoCDCoCDCoCDC
oCDCoMKgIMKgIHdvbiYjMzk7dCBidWlsZC48YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKg
IEkgcmF0aGVyIGV4cGVjdCB0aGlzIHNlcmllcyBnb2VzIGFzIGEgd2hvbGUgdmlhIHRoZTxicj4N
CsKgIMKgIMKgIMKgIG1hY2hpbmUtbmV4dDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgdHJlZS48
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIERvIHlvdSBtaW5kIGdpdmluZyB5b3VyIEFj
a2VkLWJ5IHRhZyB0byB0aGlzIHBhdGNoPzxicj4NCjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIEkg
Y2FuJiMzOTt0LCBzb3JyeSwgZm9yIE1JUFMgdGFyZ2V0LCB3ZSBkb24mIzM5O3QgYWNjZXB0IHBh
dGNoZXMgd2l0aDxicj4NCsKgIMKgIMKgIMKgIGVtcHR5IGNvbW1pdCBtZXNzYWdlcy48YnI+DQo8
YnI+DQo8YnI+DQrCoCDCoCBJIHNlZSwgSSYjMzk7diBiZWVuIHdvbmRlcmluZyB3aGF0IHRvIGRv
LCBpZiBzaW1wbHkgcmVwZWF0aW5nIHRoZSBwYXRjaDxicj4NCsKgIMKgIHN1YmplY3Qgb3IgdGhl
IGNvdmVyLCBidXQgc2luY2UgdGhlIHNlcmllcyBhcHBsaWVzIHRvIGFsbCB0YXJnZXRzLDxicj4N
CsKgIMKgIHRoaXMgc2VlbXMgb3ZlcmtpbGwuIEkgdGhpbmsgSSYjMzk7bGwgc2ltcGx5IHJlcGVh
dCB0aGUgc3ViamVjdCB0aGVuLjxicj4NCjxicj4NCjxicj4NCkNhbiYjMzk7dCB5b3UgYXQgbGVh
c3QgYWRkIGEgc2VudGVuY2Ugb24gd2h5IGlzIHRoaXMgbmVlZGVkLCBvciB3aGF0IGlzIGFjaGll
dmVkPzxicj4NCjwvYmxvY2txdW90ZT4NCjxicj4NCllvdSBhcmUgYWxyaWdodCwgSSYjMzk7bGwg
ZG8uPC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q29vbCwg
SSYjMzk7ZCBhcHByZWNpYXRlIGl0IHZlcnkgbXVjaC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkEuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KPGJyPg0KPGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQo8YnI+DQpUaGFua3MsPGJyPg0K
PGJyPg0KQS48YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBBLjxicj4NCjxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgwqAgwqAgVGhhbmtzLDxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgwqAg
wqAgUGhpbC48YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKg
IMKgwqAgwqAgZGlmZiAtLWdpdCBhL2h3L21pcHMvYm9zdG9uLmMgYi9ody9taXBzL2Jvc3Rvbi5j
PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIGluZGV4IGNhN2Q4MTNhNTIu
Ljg0NDVmZWUwZjEgMTAwNjQ0PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKg
IC0tLSBhL2h3L21pcHMvYm9zdG9uLmM8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKg
wqAgwqAgKysrIGIvaHcvbWlwcy9ib3N0b24uYzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAg
wqAgwqDCoCDCoCBAQCAtNDc0LDcgKzQ3NCw3IEBAIHN0YXRpYyB2b2lkPGJyPg0KwqAgwqAgwqAg
wqAgwqDCoCDCoCDCoCDCoCBib3N0b25fbWFjaF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8
YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoG1lbW9yeV9y
ZWdpb25fYWRkX3N1YnJlZ2lvbl9vPHdicj52ZXJsYXAoc3lzX21lbSw8YnI+DQrCoCDCoCDCoCDC
oCAweDE4MDAwMDAwLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCBmbGFz
aCwgMCk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAg
wqAgwqBkZHIgPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOzxicj4NCsKgIMKgIMKgIMKgIMKgwqAg
wqAgwqAgwqAgwqDCoCDCoCAtwqAgwqAgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fPHdi
cj5tZW1vcnkoZGRyLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgJnF1b3Q7
Ym9zdG9uLmRkciZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAg
K8KgIMKgIG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtXzx3YnI+bWVtb3J5KGRkciw8YnI+
DQrCoCDCoCDCoCDCoCBtYWNoaW5lLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgJnF1
b3Q7Ym9zdG9uLmRkciZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBtYWNoaW5lLSZndDtyYW1fc2l6ZSk7PGJyPg0KwqAgwqAgwqAg
wqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqBtZW1vcnlfcmVnaW9uX2FkZF9zdWJy
ZWdpb25fbzx3YnI+dmVybGFwKHN5c19tZW0sPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDC
oCAweDgwMDAwMDAwLCBkZHIsIDApOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAg
wqAgwqDCoCDCoCBkaWZmIC0tZ2l0IGEvaHcvbWlwcy9taXBzX2Z1bG9uZzJlLmM8YnI+DQrCoCDC
oCDCoCDCoCBiL2h3L21pcHMvbWlwc19mdWxvbmcyZS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCDCoMKgIMKgIGluZGV4IGNmNTM3ZGQ3ZTYuLmQ1YTVjZWY2MTkgMTAwNjQ0PGJyPg0K
wqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIC0tLSBhL2h3L21pcHMvbWlwc19mdWxv
bmcyZS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgICsrKyBiL2h3L21p
cHMvbWlwc19mdWxvbmcyZS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKg
IEBAIC0zMTgsNyArMzE4LDggQEAgc3RhdGljIHZvaWQ8YnI+DQrCoCDCoCDCoCDCoCBtaXBzX2Z1
bG9uZzJlX2luaXQoTWFjaGluZVN0YXQ8d2JyPmU8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKg
IMKgIMKgwqAgwqAgKm1hY2hpbmUpPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgwqAgwqAgwqByYW1fc2l6ZSA9IDI1NiAqIE1pQjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDC
oCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoC8qIGFsbG9jYXRlIFJBTSAqLzxicj4N
CsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCAtwqAgwqAgbWVtb3J5X3JlZ2lvbl9h
bGxvY2F0ZV9zeXN0ZW1fPHdicj5tZW1vcnkocmFtLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgJnF1b3Q7ZnVsb25nMmUucmFtJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgwqDCoCDCoCByYW1fc2l6ZSk7PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDC
oCDCoCDCoMKgIMKgICvCoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9jYXRlX3N5c3RlbV88d2JyPm1l
bW9yeShyYW0sPGJyPg0KwqAgwqAgwqAgwqAgbWFjaGluZSw8YnI+DQrCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgwqAgwqAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7ZnVsb25nMmUucmFtJnF1
b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgcmFtX3NpemUpOzxicj4NCsKgIMKg
IMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgbWVtb3J5X3JlZ2lvbl9pbml0
X3JhbShiaW9zLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgICZxdW90O2Z1bG9uZzJlLmJpb3MmcXVv
dDssPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCBCSU9TX1NJWkUsPGJyPg0KwqAgwqAg
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmFtcDtlcnJvcl9mYXRhbCk7PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqBtZW1vcnlfcmVnaW9uX3NldF9yZWFkb25seShiaTx3
YnI+b3MsIHRydWUpOzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZm
IC0tZ2l0IGEvaHcvbWlwcy9taXBzX2phenouYyBiL2h3L21pcHMvbWlwc19qYXp6LmM8YnI+DQrC
oCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgaW5kZXggOGQwMTBhMGI2ZS4uODhiMTI1
ODU1ZiAxMDA2NDQ8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgLS0tIGEv
aHcvbWlwcy9taXBzX2phenouYzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDC
oCArKysgYi9ody9taXBzL21pcHNfamF6ei5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDC
oCDCoMKgIMKgIEBAIC0xODgsNyArMTg4LDcgQEAgc3RhdGljIHZvaWQ8YnI+DQrCoCDCoCDCoCDC
oCBtaXBzX2phenpfaW5pdChNYWNoaW5lU3RhdGU8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKg
IMKgICptYWNoaW5lLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKg
IMKgIMKgY2MtJmd0O2RvX3RyYW5zYWN0aW9uX2ZhaWxlZCA9PGJyPg0KwqAgwqAgwqAgwqAgwqDC
oCDCoCDCoCDCoCBtaXBzX2phenpfZG9fdHJhbnNhY3Rpb25fZmFpbGU8d2JyPmQ7PGJyPg0KPGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAvKiBhbGxvY2F0
ZSBSQU0gKi88YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgLcKgIMKgIG1l
bW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtXzx3YnI+bWVtb3J5KHJhbSwgTlVMTCw8YnI+DQrC
oCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgICZxdW90O21pcHNfamF6ei5yYW0mcXVvdDssPGJyPg0K
wqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgICvCoCDCoCBtZW1vcnlfcmVnaW9uX2Fs
bG9jYXRlX3N5c3RlbV88d2JyPm1lbW9yeShyYW0sPGJyPg0KwqAgwqAgwqAgwqAgbWFjaGluZSw8
YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgICZxdW90O21pcHNfamF6ei5yYW0mcXVvdDss
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
bWFjaGluZS0mZ3Q7cmFtX3NpemUpOzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDC
oCDCoCDCoMKgIMKgIMKgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGE8d2JyPmRkcmVzc19z
cGFjZSw8YnI+DQrCoCDCoCDCoCDCoCAwLCByYW0pOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZmIC0tZ2l0IGEvaHcvbWlwcy9taXBzX21hbHRhLmM8YnI+
DQrCoCDCoCDCoCDCoCBiL2h3L21pcHMvbWlwc19tYWx0YS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDC
oCDCoCDCoCDCoCDCoMKgIMKgIGluZGV4IDRkOWM2NGIzNmEuLmFmNTZhMjljY2IgMTAwNjQ0PGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIC0tLSBhL2h3L21pcHMvbWlwc19t
YWx0YS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgICsrKyBiL2h3L21p
cHMvbWlwc19tYWx0YS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIEBA
IC0xMjY3LDcgKzEyNjcsNyBAQCB2b2lkPGJyPg0KwqAgwqAgwqAgwqAgbWlwc19tYWx0YV9pbml0
KE1hY2hpbmVTdGF0ZTxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgKm1hY2hpbmUpPGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqB9PGJyPg0KPGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAvKiByZWdpc3Rl
ciBSQU0gYXQgaGlnaCBhZGRyZXNzIHdoZXJlIGl0IGlzPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCB1bmRpc3R1cmJlZCBieSBJTyAqLzxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAg
wqAgwqDCoCDCoCAtwqAgwqAgwqAgwqAgwqAgwqBtZW1vcnlfcmVnaW9uX2FsbG9jYXRlXzx3YnI+
c3lzdGVtX21lbW9yeShyYW1faGlnaCwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKg
IMKgIMKgwqAgwqAgJnF1b3Q7bWlwc19tYWx0YS5yYW0mcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCDCoMKgIMKgICvCoCDCoCDCoCDCoCDCoCDCoG1lbW9yeV9yZWdpb25fYWxs
b2NhdGVfPHdicj5zeXN0ZW1fbWVtb3J5KHJhbV9oaWdoLCBtYWNoaW5lLDxicj4NCsKgIMKgIMKg
IMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCAmcXVvdDttaXBzX21hbHRhLnJhbSZxdW90Oyw8YnI+
DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYW1fc2l6ZSk7PGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqBtZW1vcnlfcmVn
aW9uX2FkZF9zdWJyZWdpb24oczx3YnI+eXN0ZW1fbWVtb3J5LDxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgMHg4MDAwMDAwMCwgcmFtX2hpZ2gpOzxicj4NCjxicj4NCsKgIMKgIMKgIMKg
IMKgwqAgwqAgwqAgwqAgwqDCoCDCoCBkaWZmIC0tZ2l0IGEvaHcvbWlwcy9taXBzX21pcHNzaW0u
Yzxicj4NCsKgIMKgIMKgIMKgIGIvaHcvbWlwcy9taXBzX21pcHNzaW0uYzxicj4NCsKgIMKgIMKg
IMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCBpbmRleCAyODJiYmVjYjI0Li5jMTkzMzIzMWUyIDEw
MDY0NDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCAtLS0gYS9ody9taXBz
L21pcHNfbWlwc3NpbS5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgICsr
KyBiL2h3L21pcHMvbWlwc19taXBzc2ltLmM8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKg
IMKgwqAgwqAgQEAgLTE2Niw3ICsxNjYsNyBAQCBtaXBzX21pcHNzaW1faW5pdChNYWNoaW5lU3Rh
dGU8YnI+DQrCoCDCoCDCoCDCoCAqbWFjaGluZSk8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKg
IMKgIMKgwqAgwqAgwqDCoCDCoCDCoHFlbXVfcmVnaXN0ZXJfcmVzZXQobWFpbl9jcHVfPHdicj5y
ZXNldCwgcmVzZXRfaW5mbyk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDC
oMKgIMKgIMKgwqAgwqAgwqAvKiBBbGxvY2F0ZSBSQU0uICovPGJyPg0KwqAgwqAgwqAgwqAgwqDC
oCDCoCDCoCDCoCDCoMKgIMKgIC3CoCDCoCBtZW1vcnlfcmVnaW9uX2FsbG9jYXRlX3N5c3RlbV88
d2JyPm1lbW9yeShyYW0sIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCAmcXVv
dDttaXBzX21pcHNzaW0ucmFtJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAg
wqDCoCDCoCArwqAgwqAgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fPHdicj5tZW1vcnko
cmFtLDxicj4NCsKgIMKgIMKgIMKgIG1hY2hpbmUsPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDC
oCDCoCDCoMKgIMKgICZxdW90O21pcHNfbWlwc3NpbS5yYW0mcXVvdDssPGJyPg0KwqAgwqAgwqAg
wqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFtX3NpemUpOzxicj4NCsKgIMKgIMKg
IMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgbWVtb3J5X3JlZ2lvbl9pbml0X3Jh
bShiaW9zLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgJnF1b3Q7bWlwc19t
aXBzc2ltLmJpb3MmcXVvdDssIEJJT1NfU0laRSw8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKg
IMKgIMKgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
YW1wO2Vycm9yX2ZhdGFsKTs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAg
ZGlmZiAtLWdpdCBhL2h3L21pcHMvbWlwc19yNGsuYyBiL2h3L21pcHMvbWlwc19yNGsuYzxicj4N
CsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCBpbmRleCBiYzBiZTI2NTQ0Li41OWY4
Y2FjZmI2IDEwMDY0NDxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCAtLS0g
YS9ody9taXBzL21pcHNfcjRrLmM8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAg
wqAgKysrIGIvaHcvbWlwcy9taXBzX3I0ay5jPGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDC
oCDCoMKgIMKgIEBAIC0yMDMsNyArMjAzLDggQEAgdm9pZDxicj4NCsKgIMKgIMKgIMKgIG1pcHNf
cjRrX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKTxicj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAg
wqAgwqAgwqDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90OyBt
YXhpbXVtIDI1Nk1CJnF1b3Q7LCByYW1fc2l6ZTxicj4NCsKgIMKgIMKgIMKgIC8gTWlCKTs8YnI+
DQrCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoGV4aXQo
MSk7PGJyPg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgwqAgwqAgwqB9PGJy
Pg0KwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoMKgIMKgIC3CoCDCoCBtZW1vcnlfcmVnaW9u
X2FsbG9jYXRlX3N5c3RlbV88d2JyPm1lbW9yeShyYW0sIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCAmcXVvdDttaXBzX3I0ay5yYW0mcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCDCoMKgIMKgIHJhbV9zaXplKTs8YnI+DQrCoCDCoCDCoCDCoCDCoMKgIMKg
IMKgIMKgIMKgwqAgwqAgK8KgIMKgIG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtXzx3YnI+
bWVtb3J5KHJhbSw8YnI+DQrCoCDCoCDCoCDCoCBtYWNoaW5lLDxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgJnF1b3Q7bWlwc19yNGsucmFtJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgwqDCoCDCoCArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYW1fc2l6ZSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoG1lbW9yeV9yZWdp
b25fYWRkX3N1YnJlZ2lvbig8d2JyPmFkZHJlc3Nfc3BhY2VfbWVtLCAwLCByYW0pOzxicj4NCjxi
cj4NCsKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqDCoCDCoCAtLcKgIMKgIMKgMi4yMS4wPGJy
Pg0KPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPg0KPC9ibG9ja3F1b3RlPg0K
--0000000000007e9a4405956a934d--

