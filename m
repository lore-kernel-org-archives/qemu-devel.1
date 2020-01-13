Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46940C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DF22080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WU3iSyKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DF22080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvrk-0005th-69
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 04:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iqvqn-0004c1-0Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iqvqk-0007ew-BG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:17:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41473
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iqvqk-0007dM-6T
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578907049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nkxZyjo/r1r+q+f4kN9ehKbynwVOi5iO5Yegd9/S3o=;
 b=WU3iSyKuVxFMhmPjXxhECmYYZyz7IRRkhG72/3ImPUijQsj6puNw2YSidjVeSNTio+TMyy
 ywE8GLg7o3VnJG1AVqgalZqIKS32xaHcAyUifzrNNGmlcwOJwSYWwRmldhXyuA+90hRpPQ
 fDE+UH7IT8q8ZN1NF9yXXIjXeCpLNmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-35q5hMbxOlGbt_LxBfPlhg-1; Mon, 13 Jan 2020 04:17:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45CC107ACC7;
 Mon, 13 Jan 2020 09:17:19 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 706205D9CA;
 Mon, 13 Jan 2020 09:17:16 +0000 (UTC)
Date: Mon, 13 Jan 2020 10:17:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v28 17/22] hw/rx: RX Target hardware definition
Message-ID: <20200113101714.2ae82a0c@redhat.com>
In-Reply-To: <20200112124913.94959-18-ysato@users.sourceforge.jp>
References: <20200112124913.94959-1-ysato@users.sourceforge.jp>
 <20200112124913.94959-18-ysato@users.sourceforge.jp>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 35q5hMbxOlGbt_LxBfPlhg-1
X-Mimecast-Spam-Score: 0
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
Cc: philmd@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 12 Jan 2020 21:49:08 +0900
Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

> rx62n - RX62N cpu.
> rx-virt - RX QEMU virtual target.
>=20
> v23 changes.
> Add missing includes.
>=20
> v21 changes.
> rx_load_image move to rx-virt.c
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
> Message-Id: <20190616142836.10614-17-ysato@users.sourceforge.jp>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190607091116.49044-9-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use TYPE_RX62N_CPU, use #define for RX62N_NR_TMR/CMT/SCI,
>  renamed CPU -> MCU, device -> microcontroller]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v19: Fixed typo (Peter Maydell)
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx.h    |   7 ++
>  include/hw/rx/rx62n.h |  91 ++++++++++++++++
>  hw/rx/rx-virt.c       | 127 ++++++++++++++++++++++
>  hw/rx/rx62n.c         | 239 ++++++++++++++++++++++++++++++++++++++++++
>  hw/rx/Kconfig         |  14 +++
>  hw/rx/Makefile.objs   |   2 +
>  6 files changed, 480 insertions(+)
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 hw/rx/rx-virt.c
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/rx/Kconfig
>  create mode 100644 hw/rx/Makefile.objs
>=20
> diff --git a/include/hw/rx/rx.h b/include/hw/rx/rx.h
> new file mode 100644
> index 0000000000..ff5924b81f
> --- /dev/null
> +++ b/include/hw/rx/rx.h
> @@ -0,0 +1,7 @@
> +#ifndef QEMU_RX_H
> +#define QEMU_RX_H
> +/* Definitions for RX board emulation.  */
> +
> +#include "target/rx/cpu-qom.h"
> +
> +#endif
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> new file mode 100644
> index 0000000000..97ea8ddb8e
> --- /dev/null
> +++ b/include/hw/rx/rx62n.h
> @@ -0,0 +1,91 @@
> +/*
> + * RX62N MCU Object
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RX_RX62N_H
> +#define HW_RX_RX62N_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/intc/rx_icu.h"
> +#include "hw/timer/renesas_tmr.h"
> +#include "hw/timer/renesas_cmt.h"
> +#include "hw/char/renesas_sci.h"
> +#include "target/rx/cpu.h"
> +#include "qemu/units.h"
> +
> +#define TYPE_RX62N "rx62n"
> +#define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
> +
> +#define RX62N_NR_TMR    2
> +#define RX62N_NR_CMT    2
> +#define RX62N_NR_SCI    6
> +
> +typedef struct RX62NState {
> +    SysBusDevice parent_obj;
> +
> +    RXCPU cpu;
> +    RXICUState icu;
> +    RTMRState tmr[RX62N_NR_TMR];
> +    RCMTState cmt[RX62N_NR_CMT];
> +    RSCIState sci[RX62N_NR_SCI];
> +
> +    MemoryRegion *sysmem;
> +    bool kernel;
> +
> +    MemoryRegion iram;
> +    MemoryRegion iomem1;
> +    MemoryRegion d_flash;
> +    MemoryRegion iomem2;
> +    MemoryRegion iomem3;
> +    MemoryRegion c_flash;
> +    qemu_irq irq[NR_IRQS];
> +} RX62NState;
> +
> +/*
> + * RX62N Peripheral Address
> + * See users manual section 5
> + */
> +#define RX62N_ICUBASE 0x00087000
> +#define RX62N_TMRBASE 0x00088200
> +#define RX62N_CMTBASE 0x00088000
> +#define RX62N_SCIBASE 0x00088240
> +
> +/*
> + * RX62N Peripheral IRQ
> + * See users manual section 11
> + */
> +#define RX62N_TMR_IRQBASE 174
> +#define RX62N_CMT_IRQBASE 28
> +#define RX62N_SCI_IRQBASE 214
> +
> +/*
> + * RX62N Internal Memory
> + * It is the value of R5F562N8.
> + * Please change the size for R5F562N7.
> + */
> +#define RX62N_IRAM_BASE 0x00000000
> +#define RX62N_IRAM_SIZE (96 * KiB)
> +#define RX62N_DFLASH_BASE 0x00100000
> +#define RX62N_DFLASH_SIZE (32 * KiB)
> +#define RX62N_CFLASH_BASE 0xfff80000
> +#define RX62N_CFLASH_SIZE (512 * KiB)
> +
> +#define RX62N_PCLK (48 * 1000 * 1000)
> +#endif
> diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> new file mode 100644
> index 0000000000..4cfe2e3123
> --- /dev/null
> +++ b/hw/rx/rx-virt.c
> @@ -0,0 +1,127 @@
> +/*
> + * RX QEMU virtual platform
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/loader.h"
> +#include "hw/rx/rx62n.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/device_tree.h"
> +#include "hw/boards.h"
> +
> +/* Same address of GDB integrated simulator */
> +#define SDRAM_BASE 0x01000000
> +
> +static void rx_load_image(RXCPU *cpu, const char *filename,
> +                          uint32_t start, uint32_t size)
> +{
> +    static uint32_t extable[32];
> +    long kernel_size;
> +    int i;
> +
> +    kernel_size =3D load_image_targphys(filename, start, size);
> +    if (kernel_size < 0) {
> +        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
> +        exit(1);
> +    }
> +    cpu->env.pc =3D start;
> +
> +    /* setup exception trap trampoline */
> +    /* linux kernel only works little-endian mode */
> +    for (i =3D 0; i < ARRAY_SIZE(extable); i++) {
> +        extable[i] =3D cpu_to_le32(0x10 + i * 4);
> +    }
> +    rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
> +}
> +
> +static void rxvirt_init(MachineState *machine)
> +{
> +    RX62NState *s =3D g_new(RX62NState, 1);
> +    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
> +    const char *kernel_filename =3D machine->kernel_filename;
> +    const char *dtb_filename =3D machine->dtb;
> +    void *dtb =3D NULL;
> +    int dtb_size;

this board doesn't really care about what RAM size user specified
with -m, but since we don't have any generic way to describe that
just add a check here in case user provided -m and it doesn't
match expected size, like

      if (machine->ram_size !=3D 16 * MiB)
          error_report (invalid ram size, must be ...)
          exit(ERROR_FATAL)
      }

> +    /* Allocate memory space */
> +    memory_region_init_ram(sdram, NULL, "sdram", 16 * MiB,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, SDRAM_BASE, sdram);
> +
> +    /* Initialize MCU */
> +    object_initialize_child(OBJECT(machine), "mcu", s,
> +                            sizeof(RX62NState), TYPE_RX62N,
> +                            &error_fatal, NULL);
> +    object_property_set_link(OBJECT(s), OBJECT(get_system_memory()),
> +                             "memory", &error_abort);
> +    object_property_set_bool(OBJECT(s), kernel_filename !=3D NULL,
> +                             "load-kernel", &error_abort);
> +    object_property_set_bool(OBJECT(s), true, "realized", &error_abort);
> +
> +    /* Load kernel and dtb */
> +    if (kernel_filename) {
> +        rx_load_image(RXCPU(first_cpu), kernel_filename,
> +                      SDRAM_BASE + 8 * MiB, 8 * MiB);
> +        if (dtb_filename) {
> +            dtb =3D load_device_tree(dtb_filename, &dtb_size);
> +            if (dtb =3D=3D NULL) {
> +                fprintf(stderr, "Couldn't open dtb file %s\n", dtb_filen=
ame);
> +                exit(1);
> +            }
> +            if (machine->kernel_cmdline &&
> +                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
> +                                        machine->kernel_cmdline) < 0) {
> +                fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +                exit(1);
> +            }
> +            rom_add_blob_fixed("dtb", dtb, dtb_size,
> +                               SDRAM_BASE + 16 * MiB - dtb_size);
> +            /* Set dtb address to R1 */
> +            RXCPU(first_cpu)->env.regs[1] =3D 0x02000000 - dtb_size;
> +        }
> +    }
> +}
> +
> +static void rxvirt_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "RX QEMU Virtual Target";
> +    mc->init =3D rxvirt_init;
> +    mc->is_default =3D 1;
> +    mc->default_cpu_type =3D TYPE_RX62N_CPU;
> +}
> +
> +static const TypeInfo rxvirt_type =3D {
> +    .name =3D MACHINE_TYPE_NAME("rx-virt"),
> +    .parent =3D TYPE_MACHINE,
> +    .class_init =3D rxvirt_class_init,
> +};
> +
> +static void rxvirt_machine_init(void)
> +{
> +    type_register_static(&rxvirt_type);
> +}
> +
> +type_init(rxvirt_machine_init)
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> new file mode 100644
> index 0000000000..ac47f2a397
> --- /dev/null
> +++ b/hw/rx/rx62n.c
> @@ -0,0 +1,239 @@
> +/*
> + * RX62N Microcontroller
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/rx/rx62n.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +
> +/*
> + * IRQ -> IPR mapping table
> + * 0x00 - 0x91: IPR no (IPR00 to IPR91)
> + * 0xff: IPR not assigned
> + * See "11.3.1 Interrupt Vector Table" in hardware manual.
> + */
> +static const int ipr_table[NR_IRQS] =3D {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 15 */
> +    0x00, 0xff, 0xff, 0xff, 0xff, 0x01, 0xff, 0x02,
> +    0xff, 0xff, 0xff, 0x03, 0x04, 0x05, 0x06, 0x07, /* 31 */
> +    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +    0x10, 0x11, 0x12, 0x13, 0x14, 0x14, 0x14, 0x14, /* 47 */
> +    0x15, 0x15, 0x15, 0x15, 0xff, 0xff, 0xff, 0xff,
> +    0x18, 0x18, 0x18, 0x18, 0x18, 0x1d, 0x1e, 0x1f, /* 63 */
> +    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
> +    0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 79 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0x3a, 0x3b, 0x3c, 0xff, 0xff, 0xff, /* 95 */
> +    0x40, 0xff, 0x44, 0x45, 0xff, 0xff, 0x48, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 111 */
> +    0xff, 0xff, 0x51, 0x51, 0x51, 0x51, 0x52, 0x52,
> +    0x52, 0x53, 0x53, 0x54, 0x54, 0x55, 0x55, 0x56, /* 127 */
> +    0x56, 0x57, 0x57, 0x57, 0x57, 0x58, 0x59, 0x59,
> +    0x59, 0x59, 0x5a, 0x5b, 0x5b, 0x5b, 0x5c, 0x5c, /* 143 */
> +    0x5c, 0x5c, 0x5d, 0x5d, 0x5d, 0x5e, 0x5e, 0x5f,
> +    0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62, 0x62, /* 159 */
> +    0x62, 0x63, 0x64, 0x64, 0x64, 0x64, 0x65, 0x66,
> +    0x66, 0x66, 0x67, 0x67, 0x67, 0x67, 0x68, 0x68, /* 175 */
> +    0x68, 0x69, 0x69, 0x69, 0x6a, 0x6a, 0x6a, 0x6b,
> +    0x6b, 0x6b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 191 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x70, 0x71,
> +    0x72, 0x73, 0x74, 0x75, 0xff, 0xff, 0xff, 0xff, /* 207 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80, 0x80,
> +    0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x82, 0x82, /* 223 */
> +    0x82, 0x82, 0x83, 0x83, 0x83, 0x83, 0xff, 0xff,
> +    0xff, 0xff, 0x85, 0x85, 0x85, 0x85, 0x86, 0x86, /* 239 */
> +    0x86, 0x86, 0xff, 0xff, 0xff, 0xff, 0x88, 0x89,
> +    0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, /* 255 */
> +};
> +
> +/*
> + * Level triggerd IRQ list
> + * Not listed IRQ is Edge trigger.
> + * See "11.3.1 Interrupt Vector Table" in hardware manual.
> + */
> +static const uint32_t levelirq[] =3D {
> +     16,  21,  32,  44,  47,  48,  51,  64,  65,  66,
> +     67,  68,  69,  70,  71,  72,  73,  74,  75,  76,
> +     77,  78,  79,  90,  91, 170, 171, 172, 173, 214,
> +    217, 218, 221, 222, 225, 226, 229, 234, 237, 238,
> +    241, 246, 249, 250, 253,
> +};
> +
> +static void register_icu(RX62NState *s)
> +{
> +    int i;
> +    SysBusDevice *icu;
> +
> +    object_initialize_child(OBJECT(s), "icu", &s->icu, sizeof(RXICUState=
),
> +                            TYPE_RXICU, &error_abort, NULL);
> +
> +    icu =3D SYS_BUS_DEVICE(&s->icu);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(icu), 0, RX62N_ICUBASE);
> +    qdev_prop_set_uint32(DEVICE(icu), "len-ipr-map", NR_IRQS);
> +    for (i =3D 0; i < NR_IRQS; i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "ipr-map[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, ipr_table[i]);
> +    }
> +    qdev_prop_set_uint32(DEVICE(icu), "len-trigger-level",
> +                         ARRAY_SIZE(levelirq));
> +    for (i =3D 0; i < ARRAY_SIZE(levelirq); i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "trigger-level[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, levelirq[i]);
> +    }
> +
> +    for (i =3D 0; i < NR_IRQS; i++) {
> +        s->irq[i] =3D qdev_get_gpio_in(DEVICE(icu), i);
> +    }
> +
> +    qdev_init_nofail(DEVICE(icu));
> +    sysbus_connect_irq(icu, 0, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_=
IRQ));
> +    sysbus_connect_irq(icu, 1, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_=
FIR));
> +    sysbus_connect_irq(icu, 2, s->irq[SWI]);
> +
> +}
> +
> +static void register_tmr(RX62NState *s, int unit)
> +{
> +    SysBusDevice *tmr;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "tmr[*]", &s->tmr[unit],
> +                            sizeof(RTMRState), TYPE_RENESAS_TMR,
> +                            &error_abort, NULL);
> +
> +    tmr =3D SYS_BUS_DEVICE(&s->tmr[unit]);
> +    sysbus_mmio_map(tmr, 0, RX62N_TMRBASE + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(tmr));
> +    irqbase =3D RX62N_TMR_IRQBASE + TMR_NR_IRQ * unit;
> +    for (i =3D 0; i < TMR_NR_IRQ; i++) {
> +        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void register_cmt(RX62NState *s, int unit)
> +{
> +    SysBusDevice *cmt;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "cmt[*]", &s->cmt[unit],
> +                            sizeof(RCMTState), TYPE_RENESAS_CMT,
> +                            &error_abort, NULL);
> +
> +    cmt =3D SYS_BUS_DEVICE(&s->cmt[unit]);
> +    sysbus_mmio_map(cmt, 0, RX62N_CMTBASE + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(cmt));
> +    irqbase =3D RX62N_CMT_IRQBASE + CMT_NR_IRQ * unit;
> +    for (i =3D 0; i < CMT_NR_IRQ; i++) {
> +        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void register_sci(RX62NState *s, int unit)
> +{
> +    SysBusDevice *sci;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "sci[*]", &s->sci[unit],
> +                            sizeof(RSCIState), TYPE_RENESAS_SCI,
> +                            &error_abort, NULL);
> +
> +    sci =3D SYS_BUS_DEVICE(&s->sci[unit]);
> +    sysbus_mmio_map(sci, 0, RX62N_SCIBASE + unit * 0x08);
> +    qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> +    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(sci));
> +    irqbase =3D RX62N_SCI_IRQBASE + SCI_NR_IRQ * unit;
> +    for (i =3D 0; i < SCI_NR_IRQ; i++) {
> +        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void rx62n_realize(DeviceState *dev, Error **errp)
> +{
> +    RX62NState *s =3D RX62N(dev);
> +
> +    memory_region_init_ram(&s->iram, NULL, "iram", RX62N_IRAM_SIZE, errp=
);
> +    memory_region_add_subregion(s->sysmem, RX62N_IRAM_BASE, &s->iram);
> +    memory_region_init_rom(&s->d_flash, NULL, "dataflash",
> +                           RX62N_DFLASH_SIZE, errp);
> +    memory_region_add_subregion(s->sysmem, RX62N_DFLASH_BASE, &s->d_flas=
h);
> +    memory_region_init_rom(&s->c_flash, NULL, "codeflash",
> +                           RX62N_CFLASH_SIZE, errp);
> +    memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flas=
h);
> +    if (!s->kernel) {
> +        rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
> +    }
> +
> +    /* Initialize CPU */
> +    object_initialize_child(OBJECT(s), "cpu", &s->cpu, sizeof(RXCPU),
> +                            TYPE_RX62N_CPU, errp, NULL);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
> +
> +    register_icu(s);
> +    s->cpu.env.ack =3D qdev_get_gpio_in_named(DEVICE(&s->icu), "ack", 0)=
;
> +    register_tmr(s, 0);
> +    register_tmr(s, 1);
> +    register_cmt(s, 0);
> +    register_cmt(s, 1);
> +    register_sci(s, 0);
> +}
> +
> +static Property rx62n_properties[] =3D {
> +    DEFINE_PROP_LINK("memory", RX62NState, sysmem, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rx62n_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D rx62n_realize;
> +    dc->props =3D rx62n_properties;
> +}
> +
> +static const TypeInfo rx62n_info =3D {
> +    .name =3D TYPE_RX62N,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RX62NState),
> +    .class_init =3D rx62n_class_init,
> +};
> +
> +static void rx62n_register_types(void)
> +{
> +    type_register_static(&rx62n_info);
> +}
> +
> +type_init(rx62n_register_types)
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> new file mode 100644
> index 0000000000..a07490a65e
> --- /dev/null
> +++ b/hw/rx/Kconfig
> @@ -0,0 +1,14 @@
> +config RX
> +    bool
> +
> +config RX62N
> +    bool
> +    select RX
> +    select RX_ICU
> +    select RENESAS_TMR8
> +    select RENESAS_CMT
> +    select RENESAS_SCI
> +
> +config RX_VIRT
> +    bool
> +    select RX62N
> diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs
> new file mode 100644
> index 0000000000..63f8be0e82
> --- /dev/null
> +++ b/hw/rx/Makefile.objs
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_RX62N) +=3D rx62n.o
> +obj-$(CONFIG_RX_VIRT) +=3D rx-virt.o


