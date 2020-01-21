Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05349C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3422217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT2T8uvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3422217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwZN-0007Ax-OE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1itwYi-0006e6-As
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1itwYf-00026D-SI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:39:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1itwYf-00025t-Ns
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579624757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Mwmb7BtJNDzUahKcdyRnWr+HAupBvyLDcrKAXcj7sc=;
 b=TT2T8uvRSZuFxQJhQ9y0Rai4Af5YX5C1M2xeOFSCqhdG0qp89zRM9il8GqEji54EGQjW6z
 6qs4JbtkMqlg+J7+zABspGo0L9FSI0ng6httOZUx0pZl64Qhy6Qfi0QCbIUv6uCp7QkI7I
 fhhG72DlDxjs1nsvZdymOfkoDCZi5+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-_RuNqAiFMOWg4dpLlUHVvg-1; Tue, 21 Jan 2020 11:39:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24309800D53;
 Tue, 21 Jan 2020 16:39:13 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-20.brq.redhat.com [10.40.204.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1898A5C1C3;
 Tue, 21 Jan 2020 16:39:07 +0000 (UTC)
Date: Tue, 21 Jan 2020 17:39:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v4 02/20] hw/arm: add Xunlong Orange Pi PC machine
Message-ID: <20200121173906.626c700b@Igors-MacBook-Pro>
In-Reply-To: <20200119005102.3847-3-nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-3-nieklinnenbank@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _RuNqAiFMOWg4dpLlUHVvg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, b.galvani@gmail.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 Jan 2020 01:50:44 +0100
Niek Linnenbank <nieklinnenbank@gmail.com> wrote:

> The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> based embedded computer with mainline support in both U-Boot
> and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> 1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> various other I/O. This commit add support for the Xunlong
> Orange Pi PC machine.
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/orangepi.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS          |  1 +
>  hw/arm/Makefile.objs |  2 +-
>  3 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/orangepi.c
>=20
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> new file mode 100644
> index 0000000000..866f5f7cd6
> --- /dev/null
> +++ b/hw/arm/orangepi.c
> @@ -0,0 +1,93 @@
> +/*
> + * Orange Pi emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "exec/address-spaces.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/arm/allwinner-h3.h"
> +#include "sysemu/sysemu.h"
> +
> +static struct arm_boot_info orangepi_binfo =3D {
> +    .nb_cpus =3D AW_H3_NUM_CPUS,
> +};
> +
> +typedef struct OrangePiState {
> +    AwH3State *h3;
> +    MemoryRegion sdram;
> +} OrangePiState;
> +
> +static void orangepi_init(MachineState *machine)
> +{
> +    OrangePiState *s =3D g_new(OrangePiState, 1);
> +
> +    /* BIOS is not supported by this board */
> +    if (bios_name) {
> +        error_report("BIOS not supported for this machine");
> +        exit(1);
> +    }
> +
> +    /* Only allow Cortex-A7 for this board */
> +    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) !=3D 0=
) {
> +        error_report("This board can only be used with cortex-a7 CPU");
> +        exit(1);
> +    }
> +
> +    s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
> +
> +    /* Setup timer properties */
> +    object_property_set_int(OBJECT(s->h3), 32768, "clk0-freq",
> +                            &error_abort);
> +    object_property_set_int(OBJECT(s->h3), 24 * 1000 * 1000, "clk1-freq"=
,
> +                            &error_abort);
> +
> +    /* Mark H3 object realized */
> +    object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abo=
rt);
> +
> +    /* SDRAM */
> +    if (machine->ram_size !=3D 1 * GiB) {
> +        error_report("This machine can only be used with 1GiB of RAM");
> +        exit(1);
> +    }
> +    memory_region_allocate_system_memory(&s->sdram, NULL, "sdram",
> +                                         machine->ram_size);
> +    memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3=
_SDRAM],
> +                                &s->sdram);
> +
> +    orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> +    orangepi_binfo.ram_size =3D machine->ram_size;
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> +}
> +
> +static void orangepi_machine_init(MachineClass *mc)
> +{
> +    mc->desc =3D "Orange Pi PC";
> +    mc->init =3D orangepi_init;
> +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> +    mc->default_cpus =3D AW_H3_NUM_CPUS;
> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> +    mc->default_ram_size =3D 1 * GiB;
> +}
> +
> +DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 225582704d..e99797eec9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -487,6 +487,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/allwinner-h3*
>  F: include/hw/*/allwinner-h3*
> +F: hw/arm/orangepi.c
> =20
>  ARM PrimeCell and CMSDK devices
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index ae577e875f..534a6a119e 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -35,7 +35,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
>  obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
>  obj-$(CONFIG_STRONGARM) +=3D strongarm.o
>  obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o
>  obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
>  obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
>  obj-$(CONFIG_STM32F405_SOC) +=3D stm32f405_soc.o


