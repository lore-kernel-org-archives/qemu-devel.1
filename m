Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79954CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7ED20684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7ED20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVte-0004PJ-Re
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMVrt-0002cA-OJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMVrr-0003XF-4r
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMVrq-0003WR-Ss
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:28:55 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 802EB85536
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 11:28:53 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f4so7106815wrj.12
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OgiB5TfMg4bzzxEaQjuoES0Iavr8ZNMReSonWz0Vk4Y=;
 b=pb0ny0hRbngvwpKdnlwoF6iJaGtEMa/RorLtGD8vLPGRsohPHYxaChiLsi6Kt8a0Sl
 3UPgJyFYhXjBnO8uGJNm6mvubLsuktxAxDV1u6UcCDYYhuuNkgk+6TjI8sZCtmwNwoUX
 lvHqd5DqHUkmfiEaeoBjXIseNlSmXd5Cs6YwvHDcGRp0Vj3dokDkO1j+MBK2ZaKJTBU/
 Nr4OeEgGBGhbkve+vmOUExbLfydv4o99nQiqtkwIz2ct12oNqIhO0y9xCWHwGmObNRMp
 qtsqpw4wO32LabREaRCAzGk8A1XOu9OieH04TNGujg4cR05RRx4GP9u0YfEwn1UlPAaq
 Mj9A==
X-Gm-Message-State: APjAAAXZioF8b+cfvhH0Ps4Gmtt4OTmrnie0jsH/BCY0tGZj5kQEtD4s
 itSUKQHn9pfRnoDiniSygtdLGv/+j8/iVLT224dHbM90g2DQZ9wiaba7voWq+FTBk+HaoJcUzXC
 V3iGquGdVfUb7Fug=
X-Received: by 2002:a1c:99cd:: with SMTP id
 b196mr18902824wme.105.1571657332188; 
 Mon, 21 Oct 2019 04:28:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwboFtjsMHFxgPZuxiwbU8EdBVYZo2nwtg6gl7n5JYb/ZQKD/9qgcgS67u5Zsjn6RAcvLB+gg==
X-Received: by 2002:a1c:99cd:: with SMTP id
 b196mr18902763wme.105.1571657331913; 
 Mon, 21 Oct 2019 04:28:51 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id e3sm13442899wme.39.2019.10.21.04.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 04:28:51 -0700 (PDT)
Subject: Re: [PATCH 18/21] hw/mips: Let the machine be the owner of the system
 memory
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-19-philmd@redhat.com>
 <CAL1e-=ivk8phw5SOd=a6SO8RJ4E=9kN8hN0tocQYcb7AEKeyEA@mail.gmail.com>
 <698bde03-02a9-be5e-2aff-4e8d50508222@redhat.com>
 <CAL1e-=jtavWvWaajrdTmapFgLfXXhfH8nuWCxY-z8+oMGsOAGA@mail.gmail.com>
 <d92fc466-9327-04ef-22b9-857d4f18b976@redhat.com>
 <CAL1e-=gbwabWNm1GyzG2K4Y+7dseUMpsj8+cpzNgJ5NT1P+SLQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3780f13b-8c03-fd96-47e3-1e1da3ecde2a@redhat.com>
Date: Mon, 21 Oct 2019 13:28:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gbwabWNm1GyzG2K4Y+7dseUMpsj8+cpzNgJ5NT1P+SLQ@mail.gmail.com>
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

On 10/21/19 1:10 PM, Aleksandar Markovic wrote:
> On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     On 10/21/19 12:56 PM, Aleksandar Markovic wrote:
>=20
>=20
>=20
>         On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9
>         <philmd@redhat.com <mailto:philmd@redhat.com>
>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote:
>=20
>          =C2=A0 =C2=A0 Hi Aleksandar,
>=20
>          =C2=A0 =C2=A0 On 10/21/19 8:25 AM, Aleksandar Markovic wrote:
>=20
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Monday, October 21, 2019, Phili=
ppe Mathieu-Daud=C3=A9
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 <philmd@redhat.com <mailto:philmd@=
redhat.com>
>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 <mailto:philmd@redhat.com <mailto:=
philmd@redhat.com>
>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>>> wrote:
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 Signed-off-by:=
 Philippe Mathieu-Daud=C3=A9
>         <philmd@redhat.com <mailto:philmd@redhat.com>
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 <mailto:philmd@redhat.com <mailto:=
philmd@redhat.com>>
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 <mailto:philmd=
@redhat.com
>         <mailto:philmd@redhat.com> <mailto:philmd@redhat.com
>         <mailto:philmd@redhat.com>>>>
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 ---
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0hw=
/mips/boston.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0hw=
/mips/mips_fulong2e.c | 3 ++-
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0hw=
/mips/mips_jazz.c=C2=A0 =C2=A0 =C2=A0| 2 +-
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0hw=
/mips/mips_malta.c=C2=A0 =C2=A0 | 2 +-
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0hw=
/mips/mips_mipssim.c=C2=A0 | 2 +-
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0hw=
/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 | 3 ++-
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A06 =
files changed, 8 insertions(+), 6 deletions(-)
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 Philippe, can this patch be applie=
d independently (on other
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 patches of this series)?
>=20
>=20
>          =C2=A0 =C2=A0 Unfortunately not because patch #9 changed the p=
rototype of
>          =C2=A0 =C2=A0 memory_region_allocate_system_memory() so this p=
atch alone
>          =C2=A0 =C2=A0 won't build.
>=20
>          =C2=A0 =C2=A0 I rather expect this series goes as a whole via =
the
>         machine-next
>          =C2=A0 =C2=A0 tree.
>=20
>          =C2=A0 =C2=A0 Do you mind giving your Acked-by tag to this pat=
ch?
>=20
>=20
>         I can't, sorry, for MIPS target, we don't accept patches with
>         empty commit messages.
>=20
>=20
>     I see, I'v been wondering what to do, if simply repeating the patch
>     subject or the cover, but since the series applies to all targets,
>     this seems overkill. I think I'll simply repeat the subject then.
>=20
>=20
> Can't you at least add a sentence on why is this needed, or what is=20
> achieved?

You are alright, I'll do.

>=20
> Thanks,
>=20
> A.
>=20
>=20
>         A.
>=20
>=20
>          =C2=A0 =C2=A0 Thanks,
>=20
>          =C2=A0 =C2=A0 Phil.
>=20
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 diff --git a/h=
w/mips/boston.c b/hw/mips/boston.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 index ca7d813a=
52..8445fee0f1 100644
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --- a/hw/mips/=
boston.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +++ b/hw/mips/=
boston.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 @@ -474,7 +474=
,7 @@ static void
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 boston_mach_init(MachineState *mac=
hine)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem,
>         0x18000000,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 flash, 0);
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0ddr =3D g_new(MemoryRegion, 1);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 -=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ddr, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "boston.ddr",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ddr,
>         machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "boston.ddr",
>                                                                =20
>         machine->ram_size);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80000000, ddr, 0);
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 diff --git a/h=
w/mips/mips_fulong2e.c
>         b/hw/mips/mips_fulong2e.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 index cf537dd7=
e6..d5a5cef619 100644
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --- a/hw/mips/=
mips_fulong2e.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +++ b/hw/mips/=
mips_fulong2e.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 @@ -318,7 +318=
,8 @@ static void
>         mips_fulong2e_init(MachineState
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 *machine)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0ram_size =3D 256 * MiB;
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0/* allocate RAM */
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 -=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "fulong2e.ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 ram_size);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram,
>         machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +             =
                         =20
>          =C2=A0"fulong2e.ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_size);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_init_ram(bios, NULL,
>         "fulong2e.bios",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIOS_SIZE,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &error_fatal);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_set_readonly(bios, true);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 diff --git a/h=
w/mips/mips_jazz.c b/hw/mips/mips_jazz.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 index 8d010a0b=
6e..88b125855f 100644
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --- a/hw/mips/=
mips_jazz.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +++ b/hw/mips/=
mips_jazz.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 @@ -188,7 +188=
,7 @@ static void
>         mips_jazz_init(MachineState
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 *machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0cc->do_transaction_failed =3D
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 mips_jazz_do_transaction_failed;
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0/* allocate RAM */
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 -=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "mips_jazz.ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram,
>         machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "mips_jazz.ram",
>                                                                =20
>         machine->ram_size);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_add_subregion(address_space,
>         0, ram);
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 diff --git a/h=
w/mips/mips_malta.c
>         b/hw/mips/mips_malta.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 index 4d9c64b3=
6a..af56a29ccb 100644
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --- a/hw/mips/=
mips_malta.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +++ b/hw/mips/=
mips_malta.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 @@ -1267,7 +12=
67,7 @@ void
>         mips_malta_init(MachineState
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 *machine)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0}
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0/* register RAM at high address where it is
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 undisturbed by IO */
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 -  =20
>         memory_region_allocate_system_memory(ram_high, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 "mips_malta.ra=
m",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +  =20
>         memory_region_allocate_system_memory(ram_high, machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 "mips_malta.ra=
m",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_size)=
;
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_add_subregion(system_memory,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80000000, ram_high);
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 diff --git a/h=
w/mips/mips_mipssim.c
>         b/hw/mips/mips_mipssim.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 index 282bbecb=
24..c1933231e2 100644
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --- a/hw/mips/=
mips_mipssim.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +++ b/hw/mips/=
mips_mipssim.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 @@ -166,7 +166=
,7 @@ mips_mipssim_init(MachineState
>         *machine)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0qemu_register_reset(main_cpu_reset, reset_info);
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0/* Allocate RAM. */
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 -=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "mips_mipssim.ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram,
>         machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 "mips_mipssim.=
ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_size)=
;
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0memory_region_init_ram(bios, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "mips_mipssim.bios", BIOS_SIZE,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &error_fatal);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 diff --git a/h=
w/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 index bc0be265=
44..59f8cacfb6 100644
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --- a/hw/mips/=
mips_r4k.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +++ b/hw/mips/=
mips_r4k.c
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 @@ -203,7 +203=
,8 @@ void
>         mips_r4k_init(MachineState *machine)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " maxi=
mum 256MB", ram_size
>         / MiB);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0exit(1);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 =C2=A0}
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 -=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram, NULL,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "mips_r4k.ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 ram_size);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +=C2=A0 =C2=A0=
 memory_region_allocate_system_memory(ram,
>         machine,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 "mips_r4k.ram",
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_size);
>=20
>                          =20
>          =C2=A0memory_region_add_subregion(address_space_mem, 0, ram);
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --=C2=A0 =C2=A0=
 =C2=A02.21.0
>=20
>=20

