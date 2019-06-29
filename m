Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500CBC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 11:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA422086D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA422086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhBvl-0005C1-4Z
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 07:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhBuy-0004hn-Ey
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 07:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhBuw-0007f8-Ox
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 07:53:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhBuw-0007eV-HM
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 07:53:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so11345648wmj.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 04:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NJxfCE7Gfr8RFGKZ68nmg6FbKBbDolJmQvX3t2b+hcg=;
 b=tyC7xeXJfH6tbe8j33/cvbWKICfRDBrM1+h1FD83XriFhv4jJAC+7s89mpvW33awUf
 L2B3sr5h5ziXvq50USI/KH3FeVjruEPfngYeFlGI1E6YyYc+lWJDxpx09Zq5dLti/BoE
 oCYkFnk83th3FYH/VlSveBb7OWikldwkD+xrJcA7FbxX8Aa9oKm5eafvAxkb78W8AAaH
 jfWX+ehI7Qu+rG5TIuK+kh1+hfUUTVYlwGQLxUHkf9mTztVB/52T8rVlhS5AxKKRz6q0
 O+vX4ByIn1pDX1nuz9U+y+niIPt6M82C3GmhPWInBguv59ZyoOIC+G7uwPwxRSiv0n36
 2zdQ==
X-Gm-Message-State: APjAAAWKWOpYRgpHS6u/9eKaHGIuPWfqRKscUiL+3KZFAnbTOiVpk7jI
 xwIuxKvw1198M4qhC00Dua0pow==
X-Google-Smtp-Source: APXvYqx3YuUtsGyPOxECVFyvO9UN2hxYY40PdGLm9tI1IZ49pnbJqQjjdo7Xqoc0kg27wgh1TAk71w==
X-Received: by 2002:a1c:9ecd:: with SMTP id h196mr10987433wme.98.1561809197140; 
 Sat, 29 Jun 2019 04:53:17 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t140sm9444683wmt.0.2019.06.29.04.53.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 04:53:16 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-2-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <994e8c6a-2137-9369-e9bb-05b017787b7b@redhat.com>
Date: Sat, 29 Jun 2019 13:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628181536.13729-2-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 1/4] m68k: Add NeXTcube framebuffer
 device emulation
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 6/28/19 8:15 PM, Thomas Huth wrote:
> The NeXTcube uses a linear framebuffer with 4 greyscale colors and
> a fixed resolution of 1120 * 832.
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
> 
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c

Please use SHA1 for reference (unlikely case of Bryce pushing a new
version to his repo):

https://github.com/blanham/qemu-NeXT/blob/34f4323/hw/next-fb.c

> 
> and altered to fit the latest interface of the current QEMU (e.g.
> the device has been "qdev"-ified etc.).
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  default-configs/m68k-softmmu.mak |   1 +
>  hw/display/Makefile.objs         |   1 +
>  hw/display/next-fb.c             | 157 +++++++++++++++++++++++++++++++
>  hw/m68k/Kconfig                  |   4 +
>  include/hw/m68k/next-cube.h      |   8 ++
>  5 files changed, 171 insertions(+)
>  create mode 100644 hw/display/next-fb.c
>  create mode 100644 include/hw/m68k/next-cube.h
> 
> diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
> index 4049a8f2ba..d67ab8b96d 100644
> --- a/default-configs/m68k-softmmu.mak
> +++ b/default-configs/m68k-softmmu.mak
> @@ -6,3 +6,4 @@ CONFIG_SEMIHOSTING=y
>  #
>  CONFIG_AN5206=y
>  CONFIG_MCF5208=y
> +CONFIG_NEXTCUBE=y
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index a64998fc7b..8d1c71026d 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -38,6 +38,7 @@ obj-$(CONFIG_RASPI) += bcm2835_fb.o
>  obj-$(CONFIG_SM501) += sm501.o
>  obj-$(CONFIG_TCX) += tcx.o
>  obj-$(CONFIG_CG3) += cg3.o
> +obj-$(CONFIG_NEXTCUBE) += next-fb.o
>  
>  obj-$(CONFIG_VGA) += vga.o
>  
> diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
> new file mode 100644
> index 0000000000..740102d7e9
> --- /dev/null
> +++ b/hw/display/next-fb.c
> @@ -0,0 +1,157 @@
> +/*
> + * NeXT Cube/Station Framebuffer Emulation
> + *
> + * Copyright (c) 2011 Bryce Lanham
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "ui/console.h"
> +#include "hw/hw.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/display/framebuffer.h"
> +#define BITS 8

'BITS' is not used, remove?

> +#include "ui/pixel_ops.h"
> +#include "hw/m68k/next-cube.h"
> +
> +#define TYPE_NEXTFB "next-fb"
> +#define NEXTFB(obj) OBJECT_CHECK(NeXTFbState, (obj), TYPE_NEXTFB)
> +
> +struct NeXTFbState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion fb_mr;
> +    MemoryRegionSection fbsection;
> +    QemuConsole *con;
> +
> +    uint32_t pitch;
> +    uint32_t cols;
> +    uint32_t rows;
> +    int invalidate;
> +};
> +typedef struct NeXTFbState NeXTFbState;
> +
> +static void nextfb_draw_line(void *opaque, uint8_t *d, const uint8_t *s,
> +                             int width, int pitch)
> +{
> +    NeXTFbState *nfbstate = NEXTFB(opaque);
> +    static const uint32_t pal[4] = {
> +        0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0xFF000000
> +    };
> +    uint32_t *buf = (uint32_t *)d;
> +    int i = 0;
> +
> +    for (i = 0; i < nfbstate->cols / 4; i++) {
> +        int j = i * 4;
> +        uint8_t src = s[i];
> +        buf[j + 3] = pal[src & 0x3];

0x3 -> 3?

or 0b11 :)

> +        src >>= 2;
> +        buf[j + 2] = pal[src & 0x3];
> +        src >>= 2;
> +        buf[j + 1] = pal[src & 0x3];
> +        src >>= 2;
> +        buf[j + 0] = pal[src & 0x3];
> +    }
> +}
> +
> +static void nextfb_update(void *opaque)
> +{
> +    NeXTFbState *s = NEXTFB(opaque);
> +    int dest_width = 4;
> +    int src_width;
> +    int first = 0;
> +    int last  = 0;
> +    DisplaySurface *surface = qemu_console_surface(s->con);
> +
> +    src_width = s->cols / 4 + 8;
> +    dest_width = s->cols * 4;

Since those are currently const, should we move them to NeXTFbState
and initialize them in nextfb_realize()?

> +
> +    if (s->invalidate) {
> +        framebuffer_update_memory_section(&s->fbsection, &s->fb_mr, 0,
> +                                          s->cols, src_width);
> +        s->invalidate = 0;
> +    }
> +
> +    framebuffer_update_display(surface, &s->fbsection, 1120, 832,

1120 -> s->cols?
832 -> s->rows?

> +                               src_width, dest_width, 0, 1, nextfb_draw_line,
> +                               s, &first, &last);
> +
> +    dpy_gfx_update(s->con, 0, 0, 1120, 832);

Ditto.

> +}
> +
> +static void nextfb_invalidate(void *opaque)
> +{
> +    NeXTFbState *s = NEXTFB(opaque);
> +    s->invalidate = 1;
> +}
> +
> +static const GraphicHwOps nextfb_ops = {
> +    .invalidate  = nextfb_invalidate,
> +    .gfx_update  = nextfb_update,
> +};
> +
> +static void nextfb_realize(DeviceState *dev, Error **errp)
> +{
> +    NeXTFbState *s = NEXTFB(dev);
> +
> +    memory_region_init_ram(&s->fb_mr, OBJECT(dev), "next-video", 0x1CB100,
> +                           &error_fatal);

2 bits * cols * rows = 2 * 832 * 1120 = 0x1c7000

0x1cb100 - 0x1c7000 = 0x4100

Any idea what are these 16K + 256 extra bytes for?

Anyway we have 2MB of VRAM on the hardware here, right?
If so you should replace 0x1CB100 -> 2 * MiB.

> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->fb_mr);
> +
> +    s->invalidate = 1;
> +    s->cols = 1120;
> +    s->rows = 832;
> +
> +    s->con = graphic_console_init(dev, 0, &nextfb_ops, s);
> +    qemu_console_resize(s->con, s->cols, s->rows);
> +}
> +
> +static void nextfb_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->realize = nextfb_realize;
> +}
> +
> +static const TypeInfo nextfb_info = {
> +    .name          = TYPE_NEXTFB,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(NeXTFbState),
> +    .class_init    = nextfb_class_init,
> +};
> +
> +static void nextfb_register_types(void)
> +{
> +    type_register_static(&nextfb_info);
> +}
> +
> +type_init(nextfb_register_types)
> +
> +void nextfb_init(void)
> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_create(NULL, TYPE_NEXTFB);
> +    qdev_init_nofail(dev);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xB000000);

I'd appreciate this written as 0x0B000000 (32-bit address range).

Should you map the aliased VRAM regions here too?

    for (int i = 0; i <= 4; i++) {
       sysbus_mmio_map(SYS_BUS_DEVICE(dev), i,
                       0x0b000000 + 0x01000000 * i);
    }

Anyway nextfb_init() content is this is board-specific code, not
related to the device. Can you move it there?

Thanks,

Phil.

> +}
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index 49ef0b3f6d..ec58a2eb06 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -7,3 +7,7 @@ config MCF5208
>      bool
>      select COLDFIRE
>      select PTIMER
> +
> +config NEXTCUBE
> +    bool
> +    select FRAMEBUFFER
> diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
> new file mode 100644
> index 0000000000..cf07243bda
> --- /dev/null
> +++ b/include/hw/m68k/next-cube.h
> @@ -0,0 +1,8 @@
> +
> +#ifndef NEXT_CUBE_H
> +#define NEXT_CUBE_H
> +
> +/* next-fb.c */
> +void nextfb_init(void);
> +
> +#endif /* NEXT_CUBE_H */
> 

