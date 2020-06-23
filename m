Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7037620720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrztGmDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7037620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjVt-0005vJ-KT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjV8-0005U4-1z
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:02:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjV5-0004TN-FL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:02:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so3098840wmj.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qnKqxTySUvW5/ztJtms9xMVFwmOd57XB6HESgYxF758=;
 b=PrztGmDDyf/CoMAFfArw0rmfNfqa9bQWMffPBYVCMwCyNivvdsSBXUWYdo/a/EVKcZ
 YTPBxMfyifT+D4F20NDKHYMC3aaEQCdLaIz3fLdZi7B9WEKm9Uto18/LfgDs0e7OM3yD
 MkERGvkrCHvtX5boJwyB2zqh2SsKZj7JU7Zicxf3mcDW0XtnnunYCPkzqVEspoA6fBQ3
 BzXFH3RtanVdMgre0UFn1NcCRyPcd0BFvbHsj+uEZ6bNcUhsm36zcg1pmBjxVVu2ONj3
 i67Q16iwwVoIY1329jaTCl9xIql1EsVDbxfprpiLB4MYyjTeqkF3Za2Eb0GUs1Ln6itg
 3hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qnKqxTySUvW5/ztJtms9xMVFwmOd57XB6HESgYxF758=;
 b=pjJCItHS4AXCh9CuimBSUxnXQNdMpgjYXPPlZJK9qS0UcGsPEm8yTMOe7Y/NXbnUUw
 JfjmrAZ+yU2DBvcW60jJujIOeHa6SS9r0GWD65c/dSoyh1Pe/R74a8p7CawWpvgr9cM1
 U0zwzvHFKaYpGL7ByfR/CpKnZrKGmVrLfDO6v0Tl5ljv6GVWRMBh0sblY31m6lghK2SI
 TWZpWE7i7EnNOYpzYcd4ozzFSKgGU2RS24xGGQ6E0V92OQ6VyvodLDSkYHv4+5VuAYNT
 UsBw+XmxOm7IHFz7X9Y/5jUF88E/MVOzLKKVaiOfgToGV3L5gekdnLdtS6l48npMMa+T
 majg==
X-Gm-Message-State: AOAM533dIN/JPPIzQxb2shCT/eIaszCeOmF76k4nnAgDrVaMdEVE20jU
 RmZ/LUBrIgSD/xLBMQUHZ5e1UfrQErF2bmavRDY=
X-Google-Smtp-Source: ABdhPJzItaLi5er8jOIaIvPDxh5VjHTyAv/HmeDbhz8PXcJuX2SbADVFwVdI3NOgWpQ8/V8wY08OoB8/5fLgoPLBlsI=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr26182974wmb.168.1592920929987; 
 Tue, 23 Jun 2020 07:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Tue, 23 Jun 2020 07:02:08
 -0700 (PDT)
In-Reply-To: <1592914438-30317-3-git-send-email-chenhc@lemote.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 23 Jun 2020 16:02:08 +0200
Message-ID: <CAHiYmc5v+pzjP_wUZ5msL-tDdH0tOYKbzSaFcgKaKXXx1k7T0g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 2/4] hw/intc: Add Loongson liointc support
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002fef1e05a8c0ce83"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002fef1e05a8c0ce83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020., Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> Loongson-3 has an integrated liointc (Local I/O interrupt controller).
> It is similar to goldfish interrupt controller, but more powerful (e.g.,
> it can route external interrupt to multi-cores).
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/intc/Kconfig            |   3 +
>  hw/intc/Makefile.objs      |   1 +
>  hw/intc/loongson_liointc.c | 246 ++++++++++++++++++++++++++++++
> +++++++++++++++
>  3 files changed, 250 insertions(+)
>  create mode 100644 hw/intc/loongson_liointc.c
>
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index a189d6f..264d82d 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -61,3 +61,6 @@ config S390_FLIC_KVM
>
>  config OMPIC
>      bool
> +
> +config LOONGSON_LIOINTC
> +    bool
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index a61e672..9a26fbe 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -50,3 +50,4 @@ obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o
>  obj-$(CONFIG_NIOS2) +=3D nios2_iic.o
>  obj-$(CONFIG_OMPIC) +=3D ompic.o
>  obj-$(CONFIG_IBEX) +=3D ibex_plic.o
> +obj-$(CONFIG_LOONGSON_LIOINTC) +=3D loongson_liointc.o
> diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
> new file mode 100644
> index 0000000..d4c1b48
> --- /dev/null
> +++ b/hw/intc/loongson_liointc.c
> @@ -0,0 +1,246 @@
> +/*
> + * QEMU Loongson Local I/O interrupt controler.
> + *
> + * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S
> IN
> + * THE SOFTWARE.
> + */


Wrong license preamble. I though we already reached the deal on using
standard QEMU for MIPS license preanble.


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
> +#define LOONGSON_LIOINTC(obj) OBJECT_CHECK(struct loongson_liointc,
> (obj), TYPE_LOONGSON_LIOINTC)
> +
> +struct loongson_liointc
> +{
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
> +           if (p->parent_state[parent] !=3D
> +                (!!p->per_core_isr[core] && !!per_ip_isr[ip])) {
> +                p->parent_state[parent] =3D !p->parent_state[parent];
> +                qemu_set_irq(p->parent_irq[parent],
> p->parent_state[parent]);
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
ddr,
> value));
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

--0000000000002fef1e05a8c0ce83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020.,=
 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail=
.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Loongson-3 has an integrated lioi=
ntc (Local I/O interrupt controller).<br>
It is similar to goldfish interrupt controller, but more powerful (e.g.,<br=
>
it can route external interrupt to multi-cores).<br>
<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">j=
iaxun.yang@flygoat.com</a>&gt;<br>
---<br>
=C2=A0hw/intc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +<br>
=C2=A0hw/intc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/intc/loongson_liointc.c | 246 ++++++++++++++++++++++++++++++<wbr>+=
++++++++++++++<br>
=C2=A03 files changed, 250 insertions(+)<br>
=C2=A0create mode 100644 hw/intc/loongson_liointc.c<br>
<br>
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig<br>
index a189d6f..264d82d 100644<br>
--- a/hw/intc/Kconfig<br>
+++ b/hw/intc/Kconfig<br>
@@ -61,3 +61,6 @@ config S390_FLIC_KVM<br>
<br>
=C2=A0config OMPIC<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
+<br>
+config LOONGSON_LIOINTC<br>
+=C2=A0 =C2=A0 bool<br>
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs<br>
index a61e672..9a26fbe 100644<br>
--- a/hw/intc/Makefile.objs<br>
+++ b/hw/intc/Makefile.objs<br>
@@ -50,3 +50,4 @@ obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o<br>
=C2=A0obj-$(CONFIG_NIOS2) +=3D nios2_iic.o<br>
=C2=A0obj-$(CONFIG_OMPIC) +=3D ompic.o<br>
=C2=A0obj-$(CONFIG_IBEX) +=3D ibex_plic.o<br>
+obj-$(CONFIG_LOONGSON_<wbr>LIOINTC) +=3D loongson_liointc.o<br>
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c<br>
new file mode 100644<br>
index 0000000..d4c1b48<br>
--- /dev/null<br>
+++ b/hw/intc/loongson_liointc.c<br>
@@ -0,0 +1,246 @@<br>
+/*<br>
+ * QEMU Loongson Local I/O interrupt controler.<br>
+ *<br>
+ * Copyright (c) 2020 Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoa=
t.com">jiaxun.yang@flygoat.com</a>&gt;<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */</blockquote><div><br></div><div>Wrong license preamble. I though we al=
ready reached the deal on using standard QEMU for MIPS license preanble.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+<br>
+#define D(x)<br>
+<br>
+#define NUM_IRQS=C2=A0 =C2=A0 32<br>
+<br>
+#define NUM_CORES=C2=A0 =C2=A04<br>
+#define NUM_IPS=C2=A0 =C2=A0 =C2=A04<br>
+#define NUM_PARENTS (NUM_CORES * NUM_IPS)<br>
+#define PARENT_COREx_IPy(x, y)=C2=A0 =C2=A0 (NUM_IPS * x + y)<br>
+<br>
+#define R_MAPPER_START=C2=A0 =C2=A0 0x0<br>
+#define R_MAPPER_END=C2=A0 =C2=A0 =C2=A0 0x20<br>
+#define R_ISR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R_MAPPER_END<br>
+#define R_IEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x24<br>
+#define R_IEN_SET=C2=A0 =C2=A0 =C2=A0 =C2=A00x28<br>
+#define R_IEN_CLR=C2=A0 =C2=A0 =C2=A0 =C2=A00x2c<br>
+#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)<br>
+#define R_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x64<br>
+<br>
+#define TYPE_LOONGSON_LIOINTC &quot;loongson.liointc&quot;<br>
+#define LOONGSON_LIOINTC(obj) OBJECT_CHECK(struct loongson_liointc, (obj),=
 TYPE_LOONGSON_LIOINTC)<br>
+<br>
+struct loongson_liointc<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 MemoryRegion mmio;<br>
+=C2=A0 =C2=A0 qemu_irq parent_irq[NUM_PARENTS];<br>
+<br>
+=C2=A0 =C2=A0 uint8_t mapper[NUM_IRQS]; /* 0:3 for core, 4:7 for IP */<br>
+=C2=A0 =C2=A0 uint32_t isr;<br>
+=C2=A0 =C2=A0 uint32_t ien;<br>
+=C2=A0 =C2=A0 uint32_t per_core_isr[NUM_CORES];<br>
+<br>
+=C2=A0 =C2=A0 /* state of the interrupt input pins */<br>
+=C2=A0 =C2=A0 uint32_t pin_state;<br>
+=C2=A0 =C2=A0 bool parent_state[NUM_PARENTS];<br>
+};<br>
+<br>
+static void update_irq(struct loongson_liointc *p)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t irq, core, ip;<br>
+=C2=A0 =C2=A0 uint32_t per_ip_isr[NUM_IPS] =3D {0};<br>
+<br>
+=C2=A0 =C2=A0 /* level triggered interrupt */<br>
+=C2=A0 =C2=A0 p-&gt;isr =3D p-&gt;pin_state;<br>
+<br>
+=C2=A0 =C2=A0 /* Clear disabled IRQs */<br>
+=C2=A0 =C2=A0 p-&gt;isr &amp;=3D p-&gt;ien;<br>
+<br>
+=C2=A0 =C2=A0 /* Clear per_core_isr */<br>
+=C2=A0 =C2=A0 for (core =3D 0; core &lt; NUM_CORES; core++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;per_core_isr[core] =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Update per_core_isr and per_ip_isr */<br>
+=C2=A0 =C2=A0 for (irq =3D 0; irq &lt; NUM_IRQS; irq++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(p-&gt;isr &amp; (1 &lt;&lt; irq))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (core =3D 0; core &lt; NUM_CORES; core++) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((p-&gt;mapper[irq] &amp; (1 =
&lt;&lt; core))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;per_core_isr=
[core] |=3D (1 &lt;&lt; irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (ip =3D 0; ip &lt; NUM_IPS; ip++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((p-&gt;mapper[irq] &amp; (1 =
&lt;&lt; (ip + 4)))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_ip_isr[ip] |=
=3D (1 &lt;&lt; irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Emit IRQ to parent! */<br>
+=C2=A0 =C2=A0 for (core =3D 0; core &lt; NUM_CORES; core++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (ip =3D 0; ip &lt; NUM_IPS; ip++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int parent =3D PARENT_COREx_IPy(=
core, ip);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;parent_state[parent] !=
=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!!p-&gt;per_core_=
isr[core] &amp;&amp; !!per_ip_isr[ip])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;parent_state=
[parent] =3D !p-&gt;parent_state[parent];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(p-&gt=
;parent_irq[<wbr>parent], p-&gt;parent_state[parent]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint64_t<br>
+liointc_read(void *opaque, hwaddr addr, unsigned int size)<br>
+{<br>
+=C2=A0 =C2=A0 struct loongson_liointc *p =3D opaque;<br>
+=C2=A0 =C2=A0 uint32_t r =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 /* Mapper is 1 byte */<br>
+=C2=A0 =C2=A0 if (size =3D=3D 1 &amp;&amp; addr &lt; R_MAPPER_END) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D p-&gt;mapper[addr];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Rest is 4 byte */<br>
+=C2=A0 =C2=A0 if (size !=3D 4 || (addr % 4)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (addr &gt;=3D R_PERCORE_ISR(0) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr &lt; R_PERCORE_ISR(NUM_CORES)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int core =3D (addr - R_PERCORE_ISR(0)) / 4;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D p-&gt;per_core_isr[core];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (addr) {<br>
+=C2=A0 =C2=A0 case R_ISR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D p-&gt;isr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case R_IEN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D p-&gt;ien;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 D(qemu_log(&quot;%s: size=3D%d addr=3D%lx val=3D%x\n&quot;, =
__func__, size, addr, r));<br>
+=C2=A0 =C2=A0 return r;<br>
+}<br>
+<br>
+static void<br>
+liointc_write(void *opaque, hwaddr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val64, unsigned int size)<br>
+{<br>
+=C2=A0 =C2=A0 struct loongson_liointc *p =3D opaque;<br>
+=C2=A0 =C2=A0 uint32_t value =3D val64;<br>
+<br>
+=C2=A0 =C2=A0 D(qemu_log(&quot;%s: size=3D%d, addr=3D%lx val=3D%x\n&quot;,=
 __func__, size, addr, value));<br>
+<br>
+=C2=A0 =C2=A0 /* Mapper is 1 byte */<br>
+=C2=A0 =C2=A0 if (size =3D=3D 1 &amp;&amp; addr &lt; R_MAPPER_END) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;mapper[addr] =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Rest is 4 byte */<br>
+=C2=A0 =C2=A0 if (size !=3D 4 || (addr % 4)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (addr &gt;=3D R_PERCORE_ISR(0) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr &lt; R_PERCORE_ISR(NUM_CORES)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int core =3D (addr - R_PERCORE_ISR(0)) / 4;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;per_core_isr[core] =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (addr) {<br>
+=C2=A0 =C2=A0 case R_IEN_SET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;ien |=3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case R_IEN_CLR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;ien &amp;=3D ~value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 update_irq(p);<br>
+}<br>
+<br>
+static const MemoryRegionOps pic_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D liointc_read,<br>
+=C2=A0 =C2=A0 .write =3D liointc_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+=C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static void irq_handler(void *opaque, int irq, int level)<br>
+{<br>
+=C2=A0 =C2=A0 struct loongson_liointc *p =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 p-&gt;pin_state &amp;=3D ~(1 &lt;&lt; irq);<br>
+=C2=A0 =C2=A0 p-&gt;pin_state |=3D level &lt;&lt; irq;<br>
+=C2=A0 =C2=A0 update_irq(p);<br>
+}<br>
+<br>
+static void loongson_liointc_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 struct loongson_liointc *p =3D LOONGSON_LIOINTC(obj);<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NUM_PARENTS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_<wbr>DEVICE(obj), &amp=
;p-&gt;parent_irq[i]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;p-&gt;<wbr>mmio, obj, &amp;pic_op=
s, p,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;loongson.liointc&quot;, R_END);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_<wbr>DEVICE(obj), &amp;p-&gt;mmio);=
<br>
+}<br>
+<br>
+static const TypeInfo loongson_liointc_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_LOONGSON_LI=
OINTC,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(struct loongson_liointc),<br>
+=C2=A0 =C2=A0 .instance_init =3D loongson_liointc_init,<br>
+};<br>
+<br>
+static void loongson_liointc_register_<wbr>types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;<wbr>loongson_liointc_info);<br>
+}<br>
+<br>
+type_init(loongson_liointc_<wbr>register_types)<br>
-- <br>
2.7.0<br>
<br>
</blockquote>

--0000000000002fef1e05a8c0ce83--

