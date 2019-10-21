Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE99CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2019214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2019214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMT7w-0004nr-3A
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMT6y-0004Dg-Da
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMT6x-0006bj-6g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:32:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMT6w-0006bL-VL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:32:19 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63C4A81DF1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:32:17 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id c6so6853493wrp.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22+CB66Y9RaGS1ZyijtNkan4x13wL2aw4SDXEvK9Bb8=;
 b=ktMpk80B5j79o39MABSNDAXXRevgAOQ90U/CiebtN57csz1fDyZABUluOdpmEDhVAC
 OY1eJDYfE925n2sOv5xBn9PKclsibo/ASG3LQ8bsXBDdRiLeRgoalhMN3F4sT1yykhtA
 BiiVfH4kT52DZHy5ezzW14jMEFBcu8uKDSRP2b0Yph2EOctY6RI4syjMvzpIEZVmcFMK
 O/fQZaJH8EGtDfLXzijHU5rK0P+9eLiKJ1dsmxVyd94Q7bOqwGfRRfXuj9L4kPHcVJLI
 vsQxSaBvPi18VH4YPI+g2c6jFRxfYqHU9jFbHwbNzw3S+2sIO3PIMonkTAjq/XsuQ73a
 +yFw==
X-Gm-Message-State: APjAAAWD1GeH8lFX/cOs4bg/22P0e+lTZvCg6BSLXWxjVEv1e0EgUusF
 tYvtqaMSMngA6HHeQs0Y05huQBNS34wfk0O01WiqzmJqcaBRFoigY50XV8XtWKcuf5yW4MYpmNr
 FsqCI38jPSeCGotE=
X-Received: by 2002:a1c:9ecf:: with SMTP id h198mr17766641wme.45.1571646735973; 
 Mon, 21 Oct 2019 01:32:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxiUgMnKvh05tfMegjr0956v//uObdMr3nrXhSJfSfS7i1kWinKYnb312ScQGxagqQwjl1z3g==
X-Received: by 2002:a1c:9ecf:: with SMTP id h198mr17766581wme.45.1571646735627; 
 Mon, 21 Oct 2019 01:32:15 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u68sm17803100wmu.12.2019.10.21.01.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:32:15 -0700 (PDT)
Subject: Re: [PATCH 09/21] hw: Let memory_region_allocate_system_memory take
 MachineState argument
To: Thomas Huth <th.huth@posteo.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-10-philmd@redhat.com>
 <bccd05a8-43e1-e094-3e6c-e7df24cc843f@posteo.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d089a702-a458-eb46-1e66-4eb6abfb2ced@redhat.com>
Date: Mon, 21 Oct 2019 10:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bccd05a8-43e1-e094-3e6c-e7df24cc843f@posteo.de>
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

On 10/21/19 9:27 AM, Thomas Huth wrote:
> On 21/10/2019 00.56, Philippe Mathieu-Daud=C3=A9 wrote:
>> All the codebase calls memory_region_allocate_system_memory() with
>> a NULL 'owner' from the board_init() function.
>=20
> It's a little bit weird that you first changed the owner to NULL in
> patch 7, just to change the type of the parameter here and then change
> the parameter back to the machine afterwards. I think I'd rather squash
> pash 7 (and the follow-up patches like 14) into this one here - it's
> just four files that need to be adapted, so I think that's still fine,
> and finally that's less churn to be reviewed.

I haven't thought of it and like your suggestion :)

>> Let pass a MachineState argument, and enforce the QOM ownership of
>> the system memory.
>=20
> BTW, good idea!

Thanks :)

>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/core/numa.c      | 11 +++++++----
>>   include/hw/boards.h |  6 ++++--
>>   2 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index 038c96d4ab..2e29e4bfe0 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -520,21 +520,24 @@ static void allocate_system_memory_nonnuma(Memor=
yRegion *mr, Object *owner,
>>       vmstate_register_ram_global(mr);
>>   }
>>  =20
>> -void memory_region_allocate_system_memory(MemoryRegion *mr, Object *o=
wner,
>> +void memory_region_allocate_system_memory(MemoryRegion *mr, MachineSt=
ate *ms,
>>                                             const char *name,
>>                                             uint64_t ram_size)
>>   {
>>       uint64_t addr =3D 0;
>>       int i;
>> -    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +
>> +    if (!ms) {
>> +        ms =3D MACHINE(qdev_get_machine());
>> +    }
>>  =20
>>       if (ms->numa_state =3D=3D NULL ||
>>           ms->numa_state->num_nodes =3D=3D 0 || !have_memdevs) {
>> -        allocate_system_memory_nonnuma(mr, owner, name, ram_size);
>> +        allocate_system_memory_nonnuma(mr, OBJECT(ms), name, ram_size=
);
>>           return;
>>       }
>>  =20
>> -    memory_region_init(mr, owner, name, ram_size);
>> +    memory_region_init(mr, OBJECT(ms), name, ram_size);
>>       for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
>>           uint64_t size =3D ms->numa_state->nodes[i].node_mem;
>>           HostMemoryBackend *backend =3D ms->numa_state->nodes[i].node=
_memdev;
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index de45087f34..3b6cb82b6c 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -14,7 +14,7 @@
>>   /**
>>    * memory_region_allocate_system_memory - Allocate a board's main me=
mory
>>    * @mr: the #MemoryRegion to be initialized
>> - * @owner: the object that tracks the region's reference count
>> + * @ms: the #MachineState object that own the system memory
>=20
> s/own/owns/
>=20
>>    * @name: name of the memory region
>>    * @ram_size: size of the region in bytes
>>    *
>> @@ -38,8 +38,10 @@
>>    * Smaller pieces of memory (display RAM, static RAMs, etc) don't ne=
ed
>>    * to be backed via the -mem-path memory backend and can simply
>>    * be created via memory_region_init_ram().
>> + *
>> + * The #MachineState object will track the region's reference count.
>>    */
>> -void memory_region_allocate_system_memory(MemoryRegion *mr, Object *o=
wner,
>> +void memory_region_allocate_system_memory(MemoryRegion *mr, MachineSt=
ate *ms,
>>                                             const char *name,
>>                                             uint64_t ram_size);
>>  =20
>>
>=20
>   Thomas
>=20

