Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B89C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DC421019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DC421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKfZ-0002aW-4U
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:23:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKaU-000734-GI
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKaT-00044F-CA
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:18:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKaT-00043W-3q
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:18:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so13627636wrs.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WgjG8i5+LA2TwuCrkX70oV5zkyuOUwJA8CNz2jBTcBQ=;
	b=QY1quWD/HqDTkmCkFQH6FPLOkOcU6wMopWfHtmc3l62r9ae5gv9tJelMkVmJwQ5ALI
	KpshsPNOiESPgviN8eaWGMIs0qICBjbnrkg/N6WbnH0rVthIArmkpUlvH/AvxMqq8mPO
	gE14pDHrcD7uEyOYERSPVZ6ma8HKqPSETo4NqqCnkZFpBVnnyE2RIf2fYy1fk/LRU8Dn
	9iUXwq6/Oh8sMwFG0d/BW8TpkZK7WoTnfg29c3QIIc5yNkwPBvTd9SEr5PjX+BVH9Nur
	1ItFW+GhZyzy0ofZqBCWulMHEjJPXLxQl9DNFCSflVdzJj9BeRlNkCQRjL14u6wxH8iM
	SW8Q==
X-Gm-Message-State: APjAAAXVqhPGGx22sLVzZleNCVwGG3dXMSPMK7xwgt3y7r9JHGElB6JQ
	1pXadqUdH67BYTVGeIA4gYp6QQ==
X-Google-Smtp-Source: APXvYqw+YJWGohvlXty4u+RrSKYVaXWwcE3rXiWm3rW3tfn9HrALxrVdaTC8twmVvz/s+2gHf+Tvfw==
X-Received: by 2002:a5d:420a:: with SMTP id n10mr7441278wrq.325.1557314292008; 
	Wed, 08 May 2019 04:18:12 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	o16sm24343400wro.63.2019.05.08.04.18.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:18:11 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-13-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3eb47444-d64d-ddfe-a9e2-59f54de76f87@redhat.com>
Date: Wed, 8 May 2019 13:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 12/16] hw/microblaze/zynqmp: Let the SoC
 manage the IPI devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
> The Inter Processor Interrupt is a block part of the SoC, not the
> "machine" (See Zynq UltraScale+ Device TRM UG1085, "Platform
> Management Unit", Power Domains and Islands).
> 
> Move the IPI management from the machine to the SoC.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 36 +++++++++++++++------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index eba9945c19b..20e973edf5f 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -68,6 +68,13 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>  
>      sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
>                            TYPE_XLNX_PMU_IO_INTC);
> +
> +    /* Create the IPI device */
> +    for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> +        object_initialize(&s->ipi[i], sizeof(XlnxZynqMPIPI),
> +                          TYPE_XLNX_ZYNQMP_IPI);
> +        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
> +    }
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
> @@ -113,6 +120,15 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->intc), 0,
>                         qdev_get_gpio_in(DEVICE(&s->cpu), MB_CPU_IRQ));
> +
> +    /* Connect the IPI device */
> +    for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> +        object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized",
> +                                 &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi[i]), 0,
> +                           qdev_get_gpio_in(DEVICE(&s->intc), ipi_irq[i]));
> +    }
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
> @@ -145,8 +161,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
>      MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
> -    qemu_irq irq[32];
> -    int i;
>  
>      /* Create the ROM */
>      memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
> @@ -166,24 +180,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>                                &error_abort);
>      object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
>  
> -    for (i = 0; i < 32; i++) {
> -        irq[i] = qdev_get_gpio_in(DEVICE(&pmu->intc), i);
> -    }
> -
> -    /* Create and connect the IPI device */
> -    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_initialize(&pmu->ipi[i], sizeof(XlnxZynqMPIPI),
> -                          TYPE_XLNX_ZYNQMP_IPI);
> -        qdev_set_parent_bus(DEVICE(&pmu->ipi[i]), sysbus_get_default());
> -    }
> -
> -    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_property_set_bool(OBJECT(&pmu->ipi[i]), true, "realized",
> -                                 &error_abort);
> -        sysbus_mmio_map(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, ipi_addr[i]);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, irq[ipi_irq[i]]);
> -    }
> -
>      /* Load the kernel */
>      microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
>                             machine->ram_size,
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

