Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7195CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB24A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB24A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTSY-00062S-NR
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMTRT-0004mz-P3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMTRS-00069I-Hf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMTRS-00068w-A9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:53:30 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 479F12A09A3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:53:29 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f15so3243521wrs.13
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HivAmxqA2j3HXuc//40uMNnGkk+nuXZXKO8fWW22gsk=;
 b=dAw+sU75ufTeBHvAtYeTcibHRcIR/ZlqtueI6TZYxcaM1Fp4tFGz6dItA5qWvsWrc7
 akwuOgrfVLxsz3j+8g03tKXw80YNu7rFXSceqsWJnBqTVI1bL8jnKms0DwLbpnX8vGar
 zq3SjGrpH8B9AdC6Mj5aagk1cj+IyphazwlLsORqTBssGcuVnUMlYODlcShwrBwla3Zg
 3fpRjIihTgi51koXKqNceEqLW6RyFbgpDGqSJ8zGFQYIpyFbldUx5XuGjO6hDIW1Ocyr
 OpfQIjCewimBfxGk+WUxGZJgtZ+elKuSffChdDhb7d9d9Iwh5sVIS+HT+ZocfcHNxuc1
 grhg==
X-Gm-Message-State: APjAAAU6d5hSb/utBHBpRVs1PS7UiifP5+B3AhHxgK8ByjNr3TdQbwR/
 CBYsn97X8wJa/s+lOqXVvtqZaKy3IUHU+VTEh9P4urv4W+8DdOBSeU/17g++lNggQuRIw5DEfHO
 Q/4MLIgo9gO2SlFo=
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr18831641wmj.48.1571648007914; 
 Mon, 21 Oct 2019 01:53:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzeG9luQxsaHA7dDg5sBXih2GttedvPjG+9W/k0TEQA9TyIfKmOPr0dak5XFxPBGA7619J41A==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr18831574wmj.48.1571648007531; 
 Mon, 21 Oct 2019 01:53:27 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm16649919wrt.75.2019.10.21.01.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:53:26 -0700 (PDT)
Subject: Re: [PATCH 08/21] hw/alpha/dp264: Create the RAM in the board
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-9-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f9f9f84-bc62-2612-0f5e-d173c09ecb02@redhat.com>
Date: Mon, 21 Oct 2019 10:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-9-philmd@redhat.com>
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 12:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The SDRAM is incorrectly created in the Tyohoon northbridge ASIC.
> Move its creation in the board code, this will later allow the
> board to have the QOM ownership of the RAM.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> checkpatch complains:
>=20
>   ERROR: spaces required around that '*' (ctx:WxV)
>   #10: FILE: hw/alpha/alpha_sys.h:13:
>   +PCIBus *typhoon_init(ISABus **, qemu_irq *, AlphaCPU *[4],
>                                                         ^
> ---
>   hw/alpha/alpha_sys.h |  2 +-
>   hw/alpha/dp264.c     | 11 ++++++++++-
>   hw/alpha/typhoon.c   |  9 +--------
>   3 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
> index 4e127a6de8..17f97e1bfe 100644
> --- a/hw/alpha/alpha_sys.h
> +++ b/hw/alpha/alpha_sys.h
> @@ -10,7 +10,7 @@
>   #include "hw/i386/pc.h"
>  =20
>  =20
> -PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
> +PCIBus *typhoon_init(ISABus **, qemu_irq *, AlphaCPU *[4],
>                        pci_map_irq_fn);
>  =20
>   /* alpha_pci.c.  */
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 51feee8558..ddc249261c 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -62,6 +62,7 @@ static void clipper_init(MachineState *machine)
>       uint64_t palcode_entry, palcode_low, palcode_high;
>       uint64_t kernel_entry, kernel_low, kernel_high;
>       unsigned int smp_cpus =3D machine->smp.cpus;
> +    MemoryRegion ram_region;

This is incorrect, this variable should be in .heap, not stack.

>  =20
>       /* Create up to 4 cpus.  */
>       memset(cpus, 0, sizeof(cpus));
> @@ -73,8 +74,16 @@ static void clipper_init(MachineState *machine)
>       cpus[0]->env.trap_arg1 =3D 0;
>       cpus[0]->env.trap_arg2 =3D smp_cpus;
>  =20
> +    /*
> +     * Main memory region, 0x00.0000.0000.  Real hardware supports 32G=
B,
> +     * but the address space hole reserved at this point is 8TB.
> +     */
> +    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
> +                                         ram_size);
> +    memory_region_add_subregion(get_system_memory(), 0, &ram_region);
> +
>       /* Init the chipset.  */
> -    pci_bus =3D typhoon_init(ram_size, &isa_bus, &rtc_irq, cpus,
> +    pci_bus =3D typhoon_init(&isa_bus, &rtc_irq, cpus,
>                              clipper_pci_map_irq);
>  =20
>       /* Since we have an SRM-compatible PALcode, use the SRM epoch.  *=
/
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 8489ec335c..12589ef331 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -58,7 +58,6 @@ typedef struct TyphoonState {
>       TyphoonCchip cchip;
>       TyphoonPchip pchip;
>       MemoryRegion dchip_region;
> -    MemoryRegion ram_region;
>   } TyphoonState;
>  =20
>   /* Called when one of DRIR or DIM changes.  */
> @@ -817,7 +816,7 @@ static void typhoon_alarm_timer(void *opaque)
>       cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
>   }
>  =20
> -PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
> +PCIBus *typhoon_init(ISABus **isa_bus,
>                        qemu_irq *p_rtc_irq,
>                        AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
>   {
> @@ -849,12 +848,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus *=
*isa_bus,
>  =20
>       *p_rtc_irq =3D qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
>  =20
> -    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32G=
B,
> -       but the address space hole reserved at this point is 8TB.  */
> -    memory_region_allocate_system_memory(&s->ram_region, NULL, "ram",
> -                                         ram_size);
> -    memory_region_add_subregion(addr_space, 0, &s->ram_region);
> -
>       /* TIGbus, 0x801.0000.0000, 1GB.  */
>       /* ??? The TIGbus is used for delivering interrupts, and access t=
o
>          the flash ROM.  I'm not sure that we need to implement it at a=
ll.  */
>=20

