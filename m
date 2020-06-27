Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880DBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6042065F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDiO2hJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6042065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpF31-0000C7-MA
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF2L-00089J-On
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:54:45 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF2J-0004TW-Dy
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:54:45 -0400
Received: by mail-ed1-x542.google.com with SMTP id d18so3690666edv.6
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hAl7gucoejb3lhK5tXPG0LZBIYoHHywsRne1j3HB0sM=;
 b=uDiO2hJ/3eqOVVmIEZxh1Y1UqUg5EGn14sdxNU7dUiLIZZSSmO/SuqGN5zCZQTBEZf
 HpkGzT7TfkMflikcsX4+7Irv0sv833mpIajnLaKkdtuB8d1sFEe6YriuX6RFxjl83xsC
 g6GRN/OOTSr+WK4uRcUKE0/uhIBV+bf/p5/+g34/iidGKS/xL9kzMhssJLSHnhP1obpJ
 +rxACq1beUxCpV1mxZz1xN49JMUBq+kf+de+xGqm2JxCgkX8sTKVIGedaNs67dLBsE20
 mSHA+dI4ksGPxiTIXe/aCLB16X4nBkhetSNwdHRWmFZwFAgoBe3TCxwQ9AHmAQLRsItz
 9SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hAl7gucoejb3lhK5tXPG0LZBIYoHHywsRne1j3HB0sM=;
 b=bZ0hsjB2HgI5H45scAGMYm+MgM115PYNNZLngoIRVpD0cJdZQ9zP49AUFIxOo0bkP5
 oDJV9K4vL3kxUK7eHDuLOROOrINXXX2u/0q7gb0liZ9fr4qEycmaOrVdQ1weBN4kToUY
 xnYtWPjcFKhDzJ5xFeubW7P19z435YVgkw+Bd4cKf7v5hozzqoC/XQvTZsce3JD8EPdd
 vNIm/20dgLHPs4ald3DttEeKqYlW1Lu5bY0yy0J362JKEXuxyCMjr55pFS0+pNO4tHvr
 dhVVcgS42mae1oNNG+gfNIcjbi7U4NYeGIwia4K5oAza4P4M25cjFVVnXJXdzG7hJZnR
 S/vg==
X-Gm-Message-State: AOAM531tVdjs5sRbNxVp1Wcc+4RcMLGg5SgVr+0hs/HwFAM1di4ri/Gj
 qYHWJ8E5CCutgs2JbaXGAT4taESoiiXhZEmywEQ=
X-Google-Smtp-Source: ABdhPJwZGdwn9aFAi2KIhsY5ifTwCb2ECwtWSBYCxc4VA+K9gr76xjvKL4JlgJXYcu4K6hWxusg6hxWMkh5S2TUex9g=
X-Received: by 2002:a50:d501:: with SMTP id u1mr9438409edi.159.1593280482067; 
 Sat, 27 Jun 2020 10:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
 <1592995531-32600-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1592995531-32600-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 27 Jun 2020 19:54:31 +0200
Message-ID: <CAL1e-=gfYVhOhjeGSkNS3kXmHZSx3XedPsCd2p6N4bVy8Sv7PQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/4] hw/intc: Add Loongson liointc support
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 12:48 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
>
> Loongson-3 has an integrated liointc (Local I/O interrupt controller).
> It is similar to goldfish interrupt controller, but more powerful (e.g.,
> it can route external interrupt to multi-cores).
>
> Documents about Loongson-3's liointc:
> 1, https://wiki.godson.ac.cn/ip_block:liointc;
> 2, The "I/O=E4=B8=AD=E6=96=AD" section of Loongson-3's user mannual, part=
 1.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Applied to MIPS QUEUE, with some purely cosmetic changes.

>  hw/intc/Kconfig            |   3 +
>  hw/intc/Makefile.objs      |   1 +
>  hw/intc/loongson_liointc.c | 241 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 hw/intc/loongson_liointc.c
>
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index f562342..2ae1e89 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -64,3 +64,6 @@ config OMPIC
>
>  config RX_ICU
>      bool
> +
> +config LOONGSON_LIOINTC
> +    bool
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index a420263..3ac2b40 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -51,3 +51,4 @@ obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o
>  obj-$(CONFIG_NIOS2) +=3D nios2_iic.o
>  obj-$(CONFIG_OMPIC) +=3D ompic.o
>  obj-$(CONFIG_IBEX) +=3D ibex_plic.o
> +obj-$(CONFIG_LOONGSON_LIOINTC) +=3D loongson_liointc.o
> diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
> new file mode 100644
> index 0000000..e39e39e
> --- /dev/null
> +++ b/hw/intc/loongson_liointc.c
> @@ -0,0 +1,241 @@
> +/*
> + * QEMU Loongson Local I/O interrupt controler.
> + *
> + * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <https://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/module.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +
> +#define D(x)
> +
> +#define NUM_IRQS    32
> +
> +#define NUM_CORES   4
> +#define NUM_IPS     4
> +#define NUM_PARENTS (NUM_CORES * NUM_IPS)
> +#define PARENT_COREx_IPy(x, y)    (NUM_IPS * x + y)
> +
> +#define R_MAPPER_START    0x0
> +#define R_MAPPER_END      0x20
> +#define R_ISR           R_MAPPER_END
> +#define R_IEN           0x24
> +#define R_IEN_SET       0x28
> +#define R_IEN_CLR       0x2c
> +#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)
> +#define R_END           0x64
> +
> +#define TYPE_LOONGSON_LIOINTC "loongson.liointc"
> +#define LOONGSON_LIOINTC(obj) \
> +        OBJECT_CHECK(struct loongson_liointc, (obj), TYPE_LOONGSON_LIOIN=
TC)
> +
> +struct loongson_liointc {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    qemu_irq parent_irq[NUM_PARENTS];
> +
> +    uint8_t mapper[NUM_IRQS]; /* 0:3 for core, 4:7 for IP */
> +    uint32_t isr;
> +    uint32_t ien;
> +    uint32_t per_core_isr[NUM_CORES];
> +
> +    /* state of the interrupt input pins */
> +    uint32_t pin_state;
> +    bool parent_state[NUM_PARENTS];
> +};
> +
> +static void update_irq(struct loongson_liointc *p)
> +{
> +    uint32_t irq, core, ip;
> +    uint32_t per_ip_isr[NUM_IPS] =3D {0};
> +
> +    /* level triggered interrupt */
> +    p->isr =3D p->pin_state;
> +
> +    /* Clear disabled IRQs */
> +    p->isr &=3D p->ien;
> +
> +    /* Clear per_core_isr */
> +    for (core =3D 0; core < NUM_CORES; core++) {
> +        p->per_core_isr[core] =3D 0;
> +    }
> +
> +    /* Update per_core_isr and per_ip_isr */
> +    for (irq =3D 0; irq < NUM_IRQS; irq++) {
> +        if (!(p->isr & (1 << irq))) {
> +            continue;
> +        }
> +
> +        for (core =3D 0; core < NUM_CORES; core++) {
> +            if ((p->mapper[irq] & (1 << core))) {
> +                p->per_core_isr[core] |=3D (1 << irq);
> +            }
> +        }
> +
> +        for (ip =3D 0; ip < NUM_IPS; ip++) {
> +            if ((p->mapper[irq] & (1 << (ip + 4)))) {
> +                per_ip_isr[ip] |=3D (1 << irq);
> +            }
> +        }
> +    }
> +
> +    /* Emit IRQ to parent! */
> +    for (core =3D 0; core < NUM_CORES; core++) {
> +        for (ip =3D 0; ip < NUM_IPS; ip++) {
> +            int parent =3D PARENT_COREx_IPy(core, ip);
> +            if (p->parent_state[parent] !=3D
> +                (!!p->per_core_isr[core] && !!per_ip_isr[ip])) {
> +                p->parent_state[parent] =3D !p->parent_state[parent];
> +                qemu_set_irq(p->parent_irq[parent], p->parent_state[pare=
nt]);
> +            }
> +        }
> +    }
> +}
> +
> +static uint64_t
> +liointc_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    struct loongson_liointc *p =3D opaque;
> +    uint32_t r =3D 0;
> +
> +    /* Mapper is 1 byte */
> +    if (size =3D=3D 1 && addr < R_MAPPER_END) {
> +        r =3D p->mapper[addr];
> +        goto out;
> +    }
> +
> +    /* Rest is 4 byte */
> +    if (size !=3D 4 || (addr % 4)) {
> +        goto out;
> +    }
> +
> +    if (addr >=3D R_PERCORE_ISR(0) &&
> +        addr < R_PERCORE_ISR(NUM_CORES)) {
> +        int core =3D (addr - R_PERCORE_ISR(0)) / 4;
> +        r =3D p->per_core_isr[core];
> +        goto out;
> +    }
> +
> +    switch (addr) {
> +    case R_ISR:
> +        r =3D p->isr;
> +        break;
> +    case R_IEN:
> +        r =3D p->ien;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +out:
> +    D(qemu_log("%s: size=3D%d addr=3D%lx val=3D%x\n", __func__, size, ad=
dr, r));
> +    return r;
> +}
> +
> +static void
> +liointc_write(void *opaque, hwaddr addr,
> +          uint64_t val64, unsigned int size)
> +{
> +    struct loongson_liointc *p =3D opaque;
> +    uint32_t value =3D val64;
> +
> +    D(qemu_log("%s: size=3D%d, addr=3D%lx val=3D%x\n", __func__, size, a=
ddr, value));
> +
> +    /* Mapper is 1 byte */
> +    if (size =3D=3D 1 && addr < R_MAPPER_END) {
> +        p->mapper[addr] =3D value;
> +        goto out;
> +    }
> +
> +    /* Rest is 4 byte */
> +    if (size !=3D 4 || (addr % 4)) {
> +        goto out;
> +    }
> +
> +    if (addr >=3D R_PERCORE_ISR(0) &&
> +        addr < R_PERCORE_ISR(NUM_CORES)) {
> +        int core =3D (addr - R_PERCORE_ISR(0)) / 4;
> +        p->per_core_isr[core] =3D value;
> +        goto out;
> +    }
> +
> +    switch (addr) {
> +    case R_IEN_SET:
> +        p->ien |=3D value;
> +        break;
> +    case R_IEN_CLR:
> +        p->ien &=3D ~value;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +out:
> +    update_irq(p);
> +}
> +
> +static const MemoryRegionOps pic_ops =3D {
> +    .read =3D liointc_read,
> +    .write =3D liointc_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4
> +    }
> +};
> +
> +static void irq_handler(void *opaque, int irq, int level)
> +{
> +    struct loongson_liointc *p =3D opaque;
> +
> +    p->pin_state &=3D ~(1 << irq);
> +    p->pin_state |=3D level << irq;
> +    update_irq(p);
> +}
> +
> +static void loongson_liointc_init(Object *obj)
> +{
> +    struct loongson_liointc *p =3D LOONGSON_LIOINTC(obj);
> +    int i;
> +
> +    qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
> +
> +    for (i =3D 0; i < NUM_PARENTS; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq[i]);
> +    }
> +
> +    memory_region_init_io(&p->mmio, obj, &pic_ops, p,
> +                         "loongson.liointc", R_END);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
> +}
> +
> +static const TypeInfo loongson_liointc_info =3D {
> +    .name          =3D TYPE_LOONGSON_LIOINTC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(struct loongson_liointc),
> +    .instance_init =3D loongson_liointc_init,
> +};
> +
> +static void loongson_liointc_register_types(void)
> +{
> +    type_register_static(&loongson_liointc_info);
> +}
> +
> +type_init(loongson_liointc_register_types)
> --
> 2.7.0
>
>

