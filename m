Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55880CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C9A2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C9A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbSJ-0004G4-9f
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMbRZ-0003Wa-G8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMbRY-0004S0-2M
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMbRX-0004Rm-PW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:26:08 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B88CB83F51
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:26:06 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j14so7362764wrm.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K79IArKLYvUwT0kQsS1BKAuATMqgP22/3r5AFtTT7IM=;
 b=idIY2bOvx9W6xdIzwYCz5qI8AQZQS3M6qhcum2ZTQqzUf1vpwiKWmITxBcmndxv82+
 7X3fuokQcicHFjCdM7VhbmoLOmOWaV8r5CEk4jc8V9BNeTP8jUi9Gpstiq7WX1La+AUY
 LO+zxfdC4pmJyaCG1swJzaOIt4XJMHY0Y7oQAdTUQObvqFR7Qk+XbRPF3RPFUdA40DZW
 qH92rx6tf0GSLW/QLUKyVox91M66o1vWwu3GqixmjwGIQeFNYlKg04+7GQpL2f+jdX9x
 1/YmzZmUhjaDYOIgSYwO7yiYBnuD5gMez808kqGKUQzZ+6hE7tbm6Sx6fVAjyytV1PGA
 6eNA==
X-Gm-Message-State: APjAAAUHfL17kLfMYGRxZDqWUBJVZJLYpm06d3nQlCLzYTPVbAtn4v61
 vPevsnHMhusjyyZLWEZTsvPL+Hj1+g9p+QG3uNbzVXBk8C7Ip1fbJr1JyaefWx05WkbEiXMOtG+
 BxFBi2sPiLb51Dxg=
X-Received: by 2002:adf:ea86:: with SMTP id s6mr19882456wrm.397.1571678765314; 
 Mon, 21 Oct 2019 10:26:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx34l2LzDjZyX0DtcYYtiAyrVC+Hd9t/g+Af9DzknPo1ynzYsx5F896MH5iGqqVL6iwVdP5Qw==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr19882402wrm.397.1571678765015; 
 Mon, 21 Oct 2019 10:26:05 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id t13sm21914746wra.70.2019.10.21.10.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:26:04 -0700 (PDT)
Subject: Re: [PATCH 11/21] hw/alpha: Let the machine be the owner of the
 system memory
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-12-philmd@redhat.com>
 <ed804be1-8516-3dbc-d738-20c2b03e5309@linaro.org>
 <ad652874-452b-2c8e-b80f-b6b8b5b8a751@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c845791-2c46-5fcb-430d-e0ec5d2b2999@redhat.com>
Date: Mon, 21 Oct 2019 19:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ad652874-452b-2c8e-b80f-b6b8b5b8a751@linaro.org>
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

On 10/21/19 7:19 PM, Richard Henderson wrote:
> On 10/21/19 10:14 AM, Richard Henderson wrote:
>> On 10/20/19 3:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   hw/alpha/dp264.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>>> index ddc249261c..5696b1e79b 100644
>>> --- a/hw/alpha/dp264.c
>>> +++ b/hw/alpha/dp264.c
>>> @@ -78,7 +78,7 @@ static void clipper_init(MachineState *machine)
>>>        * Main memory region, 0x00.0000.0000.  Real hardware supports =
32GB,
>>>        * but the address space hole reserved at this point is 8TB.
>>>        */
>>> -    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
>>> +    memory_region_allocate_system_memory(&ram_region, machine, "ram"=
,
>>>                                            ram_size);
>>>       memory_region_add_subregion(get_system_memory(), 0, &ram_region=
);
>>>  =20
>>>
>>
>> I take it this squishes into the squish of patches 7+9?
>=20
> Ah, no, it was the TyphoonState that had owned the ram prior to patch 7=
.

Indeed, I'll squash them and document in the commit description that I=20
dropped Typhoon ownership. I'm not sure what's best here, keep it=20
unassigned until patch #11 (this), or reassign to OBJECT(machine).

New squashed patch is:

-- 8< --
diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 4e127a6de8..17f97e1bfe 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -10,7 +10,7 @@
  #include "hw/i386/pc.h"


-PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
+PCIBus *typhoon_init(ISABus **, qemu_irq *, AlphaCPU *[4],
                       pci_map_irq_fn);

  /* alpha_pci.c.  */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 51feee8558..a93a476531 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -62,6 +62,7 @@ static void clipper_init(MachineState *machine)
      uint64_t palcode_entry, palcode_low, palcode_high;
      uint64_t kernel_entry, kernel_low, kernel_high;
      unsigned int smp_cpus =3D machine->smp.cpus;
+    MemoryRegion *ram =3D g_new(MemoryRegion, 1);

      /* Create up to 4 cpus.  */
      memset(cpus, 0, sizeof(cpus));
@@ -73,8 +74,15 @@ static void clipper_init(MachineState *machine)
      cpus[0]->env.trap_arg1 =3D 0;
      cpus[0]->env.trap_arg2 =3D smp_cpus;

+    /*
+     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
+     * but the address space hole reserved at this point is 8TB.
+     */
+    memory_region_allocate_system_memory(ram, OBJECT(machine), "ram",=20
ram_size);
+    memory_region_add_subregion(get_system_memory(), 0, ram);
+
      /* Init the chipset.  */
-    pci_bus =3D typhoon_init(ram_size, &isa_bus, &rtc_irq, cpus,
+    pci_bus =3D typhoon_init(&isa_bus, &rtc_irq, cpus,
                             clipper_pci_map_irq);

      /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 179e1f7658..12589ef331 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -58,7 +58,6 @@ typedef struct TyphoonState {
      TyphoonCchip cchip;
      TyphoonPchip pchip;
      MemoryRegion dchip_region;
-    MemoryRegion ram_region;
  } TyphoonState;

  /* Called when one of DRIR or DIM changes.  */
@@ -817,7 +816,7 @@ static void typhoon_alarm_timer(void *opaque)
      cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
  }

-PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
+PCIBus *typhoon_init(ISABus **isa_bus,
                       qemu_irq *p_rtc_irq,
                       AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
  {
@@ -849,12 +848,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus=20
**isa_bus,

      *p_rtc_irq =3D qemu_allocate_irq(typhoon_set_timer_irq, s, 0);

-    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
-       but the address space hole reserved at this point is 8TB.  */
-    memory_region_allocate_system_memory(&s->ram_region, OBJECT(s), "ram=
",
-                                         ram_size);
-    memory_region_add_subregion(addr_space, 0, &s->ram_region);
-
      /* TIGbus, 0x801.0000.0000, 1GB.  */
      /* ??? The TIGbus is used for delivering interrupts, and access to
         the flash ROM.  I'm not sure that we need to implement it at=20
all.  */
---

