Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C04C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB5220881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPRu5lP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB5220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCTg-0008DT-Al
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:50:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCS2-0007DG-Pb
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCS1-0000Ow-KL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:49:06 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCS1-0000Nk-CA; Fri, 10 May 2019 16:49:05 -0400
Received: by mail-lf1-x143.google.com with SMTP id j20so5079344lfh.2;
	Fri, 10 May 2019 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=VDkQKWlV6ZTnKcdg6K7qxGSte2YLGr4/JYENnSUzBPA=;
	b=KPRu5lP7MMIe/5/62S9LVetjwaZkeYg5rwi3RJ/PcvUTwUZjom54F78ucLaLa2rRU/
	Zi/f5jqBAf/7zaxLcoA7zgTV06jvOIFg3F1qC3ZGAWJ1io4XbMhDxlITfMB21i92gZ6x
	yG+5hApn36Axu1bGKDKrC+Qh/Oj0SNhWNo/36yvlQyOEcf/NMG9/sFXV/dpEtYkPFwto
	FKeYSjfgOd94z1uja/KGO2t9WCAsgAPhiu3HjmhOVLWOcnFZ7Ev9cofALcDm/9cHUo3D
	OEGF8od/NPT38fuCrWlL52UuETQ+W96lgHgLaHPa57lT/bK3bANcH3PZhmLxlYMp0ezq
	3Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=VDkQKWlV6ZTnKcdg6K7qxGSte2YLGr4/JYENnSUzBPA=;
	b=jjlOeIJjmnCJZz4NIfh37XI/m/Z2+8w7R7XaUPBV2mgpQHiJHIlgQje2xhTRHadgOi
	wI9VF79lVxlexK58kSk7xbpj7MfAccncgCpSZ7B0gyblbdpIcE0N1e5Hn04Cs22ryjGY
	aZxBIIgch+TCo3w6FteKtsgTDSagCMp3jLWrILHctOMu4ZxwCsJ7Lxg0hiSeZh4MQZ+E
	4iaZQIm1GgalsM3sFHrdHeL2i5D+sTrpDNCu4yFG11xYlz3a58qZT7LBa5RAqApCjFS3
	CZbOHf7O7y7PfMWQ7cW7ccigCfXF9lG4jRGh8/YdeM/zn/ydJR6W0tU67I0gUvYkuNZJ
	4KNg==
X-Gm-Message-State: APjAAAUPydQdFWxsIJY3Ne1Rg51rBNpB99RiubtrWX5tbtPKuCtDLcu7
	6uF4wxb/rNQ0PN490jBR2L3g8HbAt1Uw3YmoE3c=
X-Google-Smtp-Source: APXvYqxwWoYAIMGQDmcwAL/ucP7+kNzKTlQvrZ9RFbH17YbxI+CgykI0CO++fDLebU5es/heO3PlLD6BkwLsgO+nmW8=
X-Received: by 2002:ac2:4205:: with SMTP id y5mr6956108lfh.15.1557521344132;
	Fri, 10 May 2019 13:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-13-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-13-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 13:46:55 -0700
Message-ID: <CAKmqyKOKNOuy5s=OXZJwbM9weA0edoFUyGgPDnNWYApOK5gqUw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	"open list:New World" <qemu-ppc@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 9:39 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The Inter Processor Interrupt is a block part of the SoC, not the
> "machine" (See Zynq UltraScale+ Device TRM UG1085, "Platform
> Management Unit", Power Domains and Islands).
>
> Move the IPI management from the machine to the SoC.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 36 +++++++++++++++------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
> index eba9945c19b..20e973edf5f 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -68,6 +68,13 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>
>      sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
>                            TYPE_XLNX_PMU_IO_INTC);
> +
> +    /* Create the IPI device */
> +    for (int i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> +        object_initialize(&s->ipi[i], sizeof(XlnxZynqMPIPI),
> +                          TYPE_XLNX_ZYNQMP_IPI);
> +        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
> +    }
>  }
>
>  static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
> @@ -113,6 +120,15 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState =
*dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_AD=
DR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->intc), 0,
>                         qdev_get_gpio_in(DEVICE(&s->cpu), MB_CPU_IRQ));
> +
> +    /* Connect the IPI device */
> +    for (int i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> +        object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized",
> +                                 &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi[i]), 0,
> +                           qdev_get_gpio_in(DEVICE(&s->intc), ipi_irq[i]=
));
> +    }
>  }
>
>  static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
> @@ -145,8 +161,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machin=
e)
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *pmu_rom =3D g_new(MemoryRegion, 1);
>      MemoryRegion *pmu_ram =3D g_new(MemoryRegion, 1);
> -    qemu_irq irq[32];
> -    int i;
>
>      /* Create the ROM */
>      memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
> @@ -166,24 +180,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machi=
ne)
>                                &error_abort);
>      object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal=
);
>
> -    for (i =3D 0; i < 32; i++) {
> -        irq[i] =3D qdev_get_gpio_in(DEVICE(&pmu->intc), i);
> -    }
> -
> -    /* Create and connect the IPI device */
> -    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_initialize(&pmu->ipi[i], sizeof(XlnxZynqMPIPI),
> -                          TYPE_XLNX_ZYNQMP_IPI);
> -        qdev_set_parent_bus(DEVICE(&pmu->ipi[i]), sysbus_get_default());
> -    }
> -
> -    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_property_set_bool(OBJECT(&pmu->ipi[i]), true, "realized",
> -                                 &error_abort);
> -        sysbus_mmio_map(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, ipi_addr[i]);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, irq[ipi_irq[=
i]]);
> -    }
> -
>      /* Load the kernel */
>      microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
>                             machine->ram_size,
> --
> 2.20.1
>
>

