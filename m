Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9759CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE3120873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE3120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbcX-0006jB-7U
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMbZi-0003My-KL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMbZh-0007zf-0M
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMbZg-0007ys-OB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:34:32 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F643C057F2E
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:34:31 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 7so7727824wrl.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7lse3x6VVCkZ89VC6I/ZT2DFeIUQ17kfqYdXAgVb6M4=;
 b=caKh3YWimCdc8WZqREnF5TnsMQveDWPhMXdWLJIgU4MG/37+gRWv9b4IPG6LR5PoJX
 5Wi/Jg60nBrdnrmQrRNat5YiDqLvAXzAIBgtD7xDWhOcn/4l0y6RudboZSTSBcMCSw/t
 EOfbduTjwYRdCikegolF9S+jJBKIvJUcXwSHAahL5DoSteomJbv3je3TDfymxlTAh3E2
 occduwaiLUKvmQSjCfWanyK3wtQ1QYV1yj9rt+p1TVhxH2P63A7MKZZiUXnuw6quKebu
 f14GTx4ayHcKP7EeooxMrOxEQg4cn6XGtnvOKT43dKSwH0D+xQT9ZDB4tgNp99ZIag65
 FQWQ==
X-Gm-Message-State: APjAAAVHRThK9isv6aGFRPrfKLLrS7M04XGX05DRdbZaxOrAx0VeLmyu
 g/jMrUE4YkWa2C4WdI00xaZ4DB3AcZL+AczNVR/sLmvZt/WyB18ZUFnSJ5oFSmlRH9AhTEJZyVX
 EWqkkU87BXlcS+Kk=
X-Received: by 2002:adf:e446:: with SMTP id t6mr1290758wrm.7.1571679269880;
 Mon, 21 Oct 2019 10:34:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7dvWoJp9Q4tKiypvhN4TViEm0eaHK816K9xSl175nZslmMzpz0oTLORXpjWLtWCeaCVs0RQ==
X-Received: by 2002:adf:e446:: with SMTP id t6mr1290703wrm.7.1571679269629;
 Mon, 21 Oct 2019 10:34:29 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p12sm2168306wrt.7.2019.10.21.10.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:34:28 -0700 (PDT)
Subject: Re: [PATCH 08/21] hw/alpha/dp264: Create the RAM in the board
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-9-philmd@redhat.com>
 <708cda0d-4e05-4f15-5131-288567e91a4d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d46d1607-eec1-814d-1a02-2100429e198f@redhat.com>
Date: Mon, 21 Oct 2019 19:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <708cda0d-4e05-4f15-5131-288567e91a4d@linaro.org>
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 7:27 PM, Richard Henderson wrote:
> On 10/20/19 3:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> @@ -73,8 +74,16 @@ static void clipper_init(MachineState *machine)
>>       cpus[0]->env.trap_arg1 =3D 0;
>>       cpus[0]->env.trap_arg2 =3D smp_cpus;
>>  =20
>> +    /*
>> +     * Main memory region, 0x00.0000.0000.  Real hardware supports 32=
GB,
>> +     * but the address space hole reserved at this point is 8TB.
>> +     */
>> +    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
>> +                                         ram_size);
>> +    memory_region_add_subregion(get_system_memory(), 0, &ram_region);
>=20
> The thing that I don't like about this is that ...
>=20
>> @@ -849,12 +848,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus =
**isa_bus,
>>  =20
>>       *p_rtc_irq =3D qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
>>  =20
>> -    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32=
GB,
>> -       but the address space hole reserved at this point is 8TB.  */
>> -    memory_region_allocate_system_memory(&s->ram_region, NULL, "ram",
>> -                                         ram_size);
>> -    memory_region_add_subregion(addr_space, 0, &s->ram_region);
>> -
>>       /* TIGbus, 0x801.0000.0000, 1GB.  */
>>       /* ??? The TIGbus is used for delivering interrupts, and access =
to
>>          the flash ROM.  I'm not sure that we need to implement it at =
all.  */
>=20
> ... previously, it was clear that Typhoon owns the entire address space=
 layout.
>   With this moved to dp264.c, the "address space hole" comment is out o=
f context
> and makes no sense.
>=20
> Would it be too weird to pass in a MemoryRegion* to typhoon_init and le=
ave the
> memory_region_add_subregion() call where it is?

Yes, this will also better match the hardware.
I have a WiP series that first QOM'ify the CY82C693UB southbridge then=20
the Typhoon northbridge and pass the DRAM MemoryRegion* as a link, so in=20
the non-QOM form your suggestion is the same. I'll do your change.

