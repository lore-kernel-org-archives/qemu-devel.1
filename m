Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CBD2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CBD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbMT-0008HC-GN
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMbKf-0006kz-14
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMbKd-0001hr-T3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:19:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMbKb-0001fz-O2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:18:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C74344BD7
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:18:55 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k2so7648196wrn.7
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h75/ng50FSR/T8wvfc6IKPX40001NghQ17j+Osu46yc=;
 b=Hga0tZ2posLrM1ayhp74h95sHri2FdV4NhSCKZonFFOYKq85J4JqzqoWAi+ZXh0Cai
 aEWc9ksswJMlTya1XkdMii2jLSN8/RQqYXOo5a0eDmmSteQYeJXQeWbXtfSl+K7oMLCB
 tg0EC733vkCedRN5wWs7DSx8FN++2c/MZMrk2KoEpUaw3Ct3drbatAGDbdjj1V56oLkA
 UsL8GHAjY7hw9/Fpq2EGHYiyGkEwnUWyA1KtVGUwESshgC0xgz61TdqjyNAipfYsYOgb
 uUrhqAZ2NVPqLJ3RkfQG1/qU6+NaaFM2HlQA3gN9gm3g5HtC5DrZ0QlBGKVMGxecGg1Z
 JCoQ==
X-Gm-Message-State: APjAAAUJg7I53YAxOOfmd2IdiySjH7jTO+knMTDvx00zPJk/9qABjekY
 96J8zeviFwbFCy4QGASA0NYqq9mP4UWz4QJxNALazcTbHojrob2vVcCHlwpLAEXbttVbxX/UqlM
 5oQj2WgCB0wFVC0Q=
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr18920842wmj.160.1571678333845; 
 Mon, 21 Oct 2019 10:18:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxgpXFuOl73Ja2wwh1ahr452X/JitmeHEH/ZPZMwNfeVuZzzy91clkn/4O/hm/sOwcSgM7Hqg==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr18920788wmj.160.1571678333546; 
 Mon, 21 Oct 2019 10:18:53 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id d202sm9196251wmd.47.2019.10.21.10.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:18:52 -0700 (PDT)
Subject: Re: [PATCH 04/21] hw/arm/omap2: Create the RAM in the board
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-5-philmd@redhat.com>
 <ee89a853-46c7-e306-1e49-cd75136428c8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9a35ec0-e713-54fd-eb5c-64ae0363a2d2@redhat.com>
Date: Mon, 21 Oct 2019 19:18:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ee89a853-46c7-e306-1e49-cd75136428c8@linaro.org>
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

On 10/21/19 6:59 PM, Richard Henderson wrote:
> On 10/20/19 3:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>   static void n8x0_init(MachineState *machine,
>>                         struct arm_boot_info *binfo, int model)
>>   {
>> -    MemoryRegion *sysmem =3D get_system_memory();
>> +    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
>>       struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
>> -    int sdram_size =3D binfo->ram_size;
>> +    uint64_t sdram_size =3D binfo->ram_size;
>>  =20
>> -    s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_typ=
e);
>> +    memory_region_allocate_system_memory(sdram, NULL, "omap2.dram",
>> +                                         sdram_size);
>> +    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, s=
dram);
>> +
>> +    s->mpu =3D omap2420_mpu_init(sdram, machine->cpu_type);
>=20
> Any reason not to put the MemoryRegion in to the n800_s structure?

Ah yes, better to keep it in n800_s in case we ever QOM'ify this SoC.
I'll do.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks :)

