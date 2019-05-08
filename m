Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E2C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D6B216B7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D6B216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOP1A-0003EY-2C
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:02:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOOz5-0001b4-9C
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOOz2-0003F2-GZ
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:59:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOOz1-0003Dc-LT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:59:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so3948904wmc.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 08:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qClTAP+EMFRRs8ZpTVp/OFCONj50vJaAMwbPwHi8syQ=;
	b=rVLgcI3kBnRF7A8KrlDu3MGLB7MhgcBwaJulhMqA5k7cIiRXmVg2VSnKL9BZ+LPyge
	dOtoRjp5/ElIuTOsoUC06YWFBsaC8zvanvUdCMX/PvpDjR+12wPcNfSKwi6FkJcFvi25
	F6d+oGSgLeBy1poCES1kdwlTk3yJXyL+1a1bhu0iFtGZGGzr6luAswpa1U4jdtJnvl7M
	RzhDSVLdMk9cCkOQhJ3CRrooEq+e3QTWgZBJNPOpkLTiwmTSAtJZC7EuaKqEugW49KHb
	gbtMzxj98Pn6iAUryqYOiq7PPvJudGjbyVg5a9TVn0utkumxQvNc4Ruw2y8Y1FgHbwUm
	Q6lg==
X-Gm-Message-State: APjAAAXD7uTeOxc914gQj5dfDcpMFSqbMITAbJBQ3nErqANS1SmRKQKf
	CXn5+Y2FgtugIfmTG+X+rywfUQ==
X-Google-Smtp-Source: APXvYqykrijWd+yffYf7VjlA2/VwvdvAGWpahRb7x8ARM5jiG+IuV05oUr3ZsnaydE84bJrqgQR3Gg==
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr3566982wmu.112.1557331189182; 
	Wed, 08 May 2019 08:59:49 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	v192sm3251096wme.24.2019.05.08.08.59.48
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 08:59:48 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-10-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a60014fd-9a8b-c38f-973d-2caf9db45e30@redhat.com>
Date: Wed, 8 May 2019 17:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-10-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v10 09/13] hw/rx: RX Target hardware
 definition
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

"v10"... I'm a bit late at reviewing this, sorry.

On 5/8/19 4:56 PM, Yoshinori Sato wrote:
> rx62n - RX62N cpu.

cpu -> MCU (or SoC)

> rxqemu - QEMU virtual target.

You declare it with MACHINE_TYPE_NAME("rx-qemu"), please use one or
another to be consistent. Why not name it "virt"?

> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx.h    |   7 ++
>  include/hw/rx/rx62n.h |  54 ++++++++++++
>  hw/rx/rx62n.c         | 240 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/rx/rxqemu.c        | 100 +++++++++++++++++++++
>  hw/rx/Kconfig         |   2 +
>  hw/rx/Makefile.objs   |   1 +
>  6 files changed, 404 insertions(+)
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/rx/rxqemu.c
>  create mode 100644 hw/rx/Kconfig
>  create mode 100644 hw/rx/Makefile.objs
> 
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

Do you really need that file?

> +
> +#endif
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> new file mode 100644
> index 0000000000..8c15399ce0
> --- /dev/null
> +++ b/include/hw/rx/rx62n.h
> @@ -0,0 +1,54 @@
> +/*
> + * RX62N Object

"RX62N MCU"

> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RX_RX62N_H
> +#define HW_RX_RX62N_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/rx/rx.h"
> +#include "hw/intc/rx_icu.h"
> +#include "hw/timer/renesas_tmr.h"
> +#include "hw/timer/renesas_cmt.h"
> +#include "hw/char/renesas_sci.h"
> +
> +#define TYPE_RX62N "rx62n"
> +#define TYPE_RX62N_CPU RX_CPU_TYPE_NAME(TYPE_RX62N)
> +#define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
> +
> +typedef struct RX62NState {
> +    SysBusDevice parent_obj;
> +
> +    RXCPU *cpu;
> +    RXICUState *icu;
> +    RTMRState *tmr[2];
> +    RCMTState *cmt[2];
> +    RSCIState *sci[6];

Again too late, so I'm OK with this patch using the QDEV API, but I'd
recommend using the SysBus API for new design (Peter, do you confirm?).
You can reserve space for the full object in the container, rather than
using pointer to allocated objects.

I.E. the could would be:

       RSCIState sci[6];

and later you initialize it with:

       object_initialize_child(OBJECT(s), "sci0", &s->sci[0], ...

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
> +    qemu_irq irq[256];
> +} RX62NState;
> +
> +#endif
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> new file mode 100644
> index 0000000000..1dca5dd84c
> --- /dev/null
> +++ b/hw/rx/rx62n.c
> @@ -0,0 +1,240 @@
> +/*
> + * RX62N device
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/rx/rx62n.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/address-spaces.h"
> +
> +/*
> + * IRQ -> IPR mapping table
> + * 0x00 - 0x91: IPR no (IPR00 to IPR91)
> + * 0xff: IPR not assigned
> + * See "11.3.1 Interrupt Vector Table" in hardware manual.
> + */

#define IRQ_COUNT 256

> +static const int ipr_table[] = {

static const int ipr_table[IRQ_COUNT] = {

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
> +static const uint32_t levelirq[] = {
> +     16,  21,  32,  44,  47,  48,  51,  64,  65,  66,
> +     67,  68,  69,  70,  71,  72,  73,  74,  75,  76,
> +     77,  78,  79,  90,  91, 170, 171, 172, 173, 214,
> +    217, 218, 221, 222, 225, 226, 229, 234, 237, 238,
> +    241, 246, 249, 250, 253,
> +};
> +
> +static RXICUState *register_icu(RX62NState *s)
> +{
> +    SysBusDevice *icu;
> +    int i;
> +
> +    icu = SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RXICU));
> +    sysbus_mmio_map(icu, 0, 0x00087000);
> +    qdev_prop_set_uint32(DEVICE(icu), "len-ipr-map", 256);

256 -> IRQ_COUNT

> +    for (i = 0; i < 256; i++) {

256 -> IRQ_COUNT

> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "ipr-map[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, ipr_table[i]);
> +    }
> +    qdev_prop_set_uint32(DEVICE(icu), "len-trigger-level", 256);

256 -> IRQ_COUNT

> +    for (i = 0; i < ARRAY_SIZE(levelirq); i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "trigger-level[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, levelirq[i]);
> +    }
> +    for (i = 0; i < 256; i++) {

256 -> IRQ_COUNT

> +        s->irq[i] = qdev_get_gpio_in(DEVICE(icu), i);
> +    }
> +
> +    qdev_init_nofail(DEVICE(icu));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(icu), 0,
> +                       qdev_get_gpio_in(DEVICE(s->cpu), RX_CPU_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(icu), 1,
> +                       qdev_get_gpio_in(DEVICE(s->cpu), RX_CPU_FIR));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(icu), 2, s->irq[SWI]);
> +
> +    return RXICU(icu);
> +}
> +
> +static RTMRState *register_tmr(RX62NState *s, int unit)
> +{
> +    SysBusDevice *tmr;
> +    int i, irqbase;
> +
> +    tmr = SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RENESAS_TMR));
> +    sysbus_mmio_map(tmr, 0, 0x00088200 + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", 48000000);

You might add/use:

#define RX62N_PERIPH_CLOCK_HZ (48 * 1000 * 1000)

enum {
    IRQ_CMT0 = 28,
    IRQ_TMR0 = 174,
    IRQ_SCI0 = 214,
};

#define TMR_IRQ_COUNT 6
#define CMT_IRQ_COUNT 2
#define SCI_IRQ_COUNT 4

> +
> +    qdev_init_nofail(DEVICE(tmr));
> +    irqbase = 174 + 6 * unit;

174 -> IRQ_CMT0

6 -> TMR_IRQ_COUNT

> +    for (i = 0; i < 6; i++) {
> +        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
> +    }
> +
> +    return RTMR(tmr);
> +}
> +
> +static RCMTState *register_cmt(RX62NState *s, int unit)
> +{
> +    SysBusDevice *cmt;
> +    int i, irqbase;
> +
> +    cmt = SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RENESAS_CMT));
> +    sysbus_mmio_map(cmt, 0, 0x00088000 + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", 48000000);
> +
> +    qdev_init_nofail(DEVICE(cmt));
> +    irqbase = 28 + 2 * unit;
> +    for (i = 0; i < 1; i++) {
> +        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
> +    }
> +
> +    return RCMT(cmt);
> +}
> +
> +static RSCIState *register_sci(RX62NState *s, int unit)
> +{
> +    SysBusDevice *sci;
> +    int i, irqbase;
> +
> +    sci = SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RENESAS_SCI));
> +    qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> +    qdev_prop_set_uint64(DEVICE(sci), "input-freq", 48000000);
> +    qdev_init_nofail(DEVICE(sci));
> +    sysbus_mmio_map(sci, 0, 0x00088240 + unit * 0x08);
> +    irqbase = 214 + 4 * unit;
> +    for (i = 0; i < 4; i++) {
> +        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
> +    }
> +
> +    object_property_set_bool(OBJECT(sci), true, "realized", NULL);
> +    return RSCI(sci);
> +}
> +
> +static void rx62n_realize(DeviceState *dev, Error **errp)
> +{
> +    RX62NState *s = RX62N(dev);
> +    Error *err = NULL;
> +
> +    memory_region_init_ram(&s->iram, NULL, "iram", 0x18000, NULL);

0x18000 -> 96 * KiB

> +    memory_region_add_subregion(s->sysmem, 0x00000000, &s->iram);
> +    memory_region_init_rom(&s->d_flash, NULL, "dataflash", 0x8000, NULL);

0x8000 -> 32 * KiB

> +    memory_region_add_subregion(s->sysmem, 0x00100000, &s->d_flash);
> +    memory_region_init_rom(&s->c_flash, NULL, "codeflash", 0x80000, NULL);

0x80000 -> 512 * KiB


> +    memory_region_add_subregion(s->sysmem, 0xfff80000, &s->c_flash);
> +
> +    s->cpu = RXCPU(object_new(TYPE_RXCPU));
> +
> +    if (!s->kernel) {
> +        rom_add_file_fixed(bios_namelevelirq, 0xfff80000, 0);
> +    }
> +
> +    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    s->icu = register_icu(s);
> +    s->cpu->env.ack = qdev_get_gpio_in_named(DEVICE(s->icu), "ack", 0);
> +    s->tmr[0] = register_tmr(s, 0);
> +    s->tmr[1] = register_tmr(s, 1);
> +    s->cmt[0] = register_cmt(s, 0);
> +    s->cmt[1] = register_cmt(s, 1);
> +    s->sci[0] = register_sci(s, 0);
> +}
> +
> +static void rx62n_init(Object *obj)
> +{

You can remove this.

> +}
> +
> +static Property rx62n_properties[] = {
> +    DEFINE_PROP_LINK("memory", RX62NState, sysmem, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rx62n_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = rx62n_realize;
> +    dc->props = rx62n_properties;
> +}
> +
> +static const TypeInfo rx62n_info = {
> +    .name = TYPE_RX62N,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RX62NState),
> +    .instance_init = rx62n_init,
> +    .class_init = rx62n_class_init,
> +};
> +
> +static void rx62n_register_types(void)
> +{
> +    type_register_static(&rx62n_info);
> +}
> +
> +type_init(rx62n_register_types)
> diff --git a/hw/rx/rxqemu.c b/hw/rx/rxqemu.c
> new file mode 100644
> index 0000000000..87cd30b2f1
> --- /dev/null
> +++ b/hw/rx/rxqemu.c
> @@ -0,0 +1,100 @@
> +/*
> + * RX QEMU virtual target
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
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

2 following doesn't seem used:

> +#include "exec/address-spaces.h"
> +#include "exec/cpu-all.h"
> +
> +static void rxqemu_init(MachineState *machine)
> +{
> +    DeviceState *cpu;
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *sdram = g_new(MemoryRegion, 1);
> +    const char *kernel_filename = machine->kernel_filename;
> +    const char *dtb_filename = machine->dtb;
> +    void *dtb = NULL;
> +    int dtb_size;
> +
> +    /* Allocate memory space */
> +    memory_region_init_ram(sdram, NULL, "rxqemu.sdram", 0x01000000,

"rxqemu.sdram" -> "sdram"
0x01000000 -> 16 * MiB

> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, 0x01000000, sdram);
> +
> +    cpu = qdev_create(NULL, TYPE_RX62N);
> +    object_property_set_link(OBJECT(cpu), OBJECT(get_system_memory()),
> +                             "memory", &error_abort);
> +    object_property_set_bool(OBJECT(cpu), kernel_filename != NULL,
> +                             "load-kernel", &error_abort);
> +    /* This will exit with an error if the user passed us a bad cpu_type */
> +    qdev_init_nofail(cpu);
> +
> +    if (kernel_filename) {
> +        rx_load_image(RXCPU(first_cpu), kernel_filename,
> +                      0x01800000, 0x00800000);

0x00800000 -> 8 * MiB

> +    }
> +    if (dtb_filename) {
> +        dtb = load_device_tree(dtb_filename, &dtb_size);
> +        if (dtb == NULL) {
> +            fprintf(stderr, "Couldn't open dtb file %s\n", dtb_filename);
> +            exit(1);
> +        }
> +        if (machine->kernel_cmdline &&
> +            qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
> +                                    machine->kernel_cmdline) < 0) {
> +            fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +            exit(1);
> +        }
> +        rom_add_blob_fixed("dtb", dtb, dtb_size, 0x02000000 - dtb_size);
> +        /* Set dtb address to R1 */
> +        RXCPU(first_cpu)->env.regs[1] = 0x02000000 - dtb_size;
> +    }
> +}
> +
> +static void rxqemu_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RX QEMU Virtual Target";

"RX Virt Machine"?

> +    mc->init = rxqemu_init;
> +    mc->is_default = 1;
> +    mc->default_cpu_type = TYPE_RXCPU;
> +}
> +
> +static const TypeInfo rxqemu_type = {
> +    .name = MACHINE_TYPE_NAME("rx-qemu"),
> +    .parent = TYPE_MACHINE,
> +    .class_init = rxqemu_class_init,
> +};
> +
> +static void rxqemu_machine_init(void)
> +{
> +    type_register_static(&rxqemu_type);
> +}
> +
> +type_init(rxqemu_machine_init)
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> new file mode 100644
> index 0000000000..4e39638cb5
> --- /dev/null
> +++ b/hw/rx/Kconfig
> @@ -0,0 +1,2 @@
> +config RX
> +       bool

config RENESAS_SCI
    bool
    select SERIAL

config RENESAS_TMR
    bool

config RENESAS_CMT
    bool

config RX62N
    bool
    select RENESAS_SCI
    select RENESAS_TMR
    select RENESAS_CMT

config RX_VIRT
    bool
    select RX62N

> diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs
> new file mode 100644
> index 0000000000..e2edbb527e
> --- /dev/null
> +++ b/hw/rx/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y += rx62n.o rxqemu.o

obj-$(RX62N) += rx62n.o
obj-$(RX_VIRT) += rxqemu.o

Good work!

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

With comment addressed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

