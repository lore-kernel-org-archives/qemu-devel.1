Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B4C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869F5206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869F5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTp3-0001TX-Sw
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxTnz-0000cf-Sz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxTnt-0005U9-Ex
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:13:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxTnr-0005Qi-OR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:13:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so967443wma.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6NdA5i34wnLllxP3hMsnLhQ/JjM1PlR7BcWTRA7pLho=;
 b=dAUFNV4Fzc29jAMLfA1ys0OCbeOSf1M3xhxJYaJVHTXTAmb/pI9l+rEf9qf6ipJOPO
 PqFlXdVb/ATn0L/hNouxVjjTGEsU1hoKk2M5ycoi2wD5cD53Ht6urDwLAhubjXVnf+h2
 KRdXvLXcLhQBKPvsAR+M9ioljaaxM7A/zkAmcaHBGHWFgXtKG6fDXkGsdn8/sQghQ0bL
 /bNQ6GEN3MM1QVS8VU47utFhnvA45UG2+DgYQq2oyc/AFsaSxOqReHD6OzeEr50Q9vDS
 n4Q54NERm84fBM4kWgamlqe4A0gkI2UNAnJ6FHpQ2d91kHSK28suSYBWfEXL9fa96oT4
 4tFw==
X-Gm-Message-State: APjAAAWDqzmZkvew6PJ8u4XHXZ8eTISs/m7d6vxvy/hFaGgoi9PIu7Ci
 B6IIhiAd15NkQS4LnuukAIXonkxOGtw=
X-Google-Smtp-Source: APXvYqyhU267ATfa/6ESFlZqn/XDxD4NcMIzSeoZa4YKMqyW5sJFuVoHbRNYyY+HcGzdLg1EWYzHfQ==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr2207234wmj.2.1565691195378;
 Tue, 13 Aug 2019 03:13:15 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id a8sm1109858wma.31.2019.08.13.03.13.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 03:13:14 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-3-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <371f1371-ea8b-8a75-737d-5bb73b409a08@redhat.com>
Date: Tue, 13 Aug 2019 12:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709073222.26370-3-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 2/6] m68k: Add NeXTcube keyboard device
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 9:32 AM, Thomas Huth wrote:
> It is likely still quite incomplete (e.g. mouse and interrupts are not
> implemented yet), but it is good enough for keyboard input at the firmware
> monitor.
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
> 
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-kbd.c
> 
> and altered to fit the latest interface of the current QEMU (e.g. to use
> memory_region_init_io() instead of cpu_register_physical_memory()).
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  hw/m68k/Makefile.objs       |   1 +
>  hw/m68k/next-kbd.c          | 284 ++++++++++++++++++++++++++++++++++++
>  include/hw/m68k/next-cube.h |   2 +
>  3 files changed, 287 insertions(+)
>  create mode 100644 hw/m68k/next-kbd.c
> 
> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
> index 482f8477b4..688002cac1 100644
> --- a/hw/m68k/Makefile.objs
> +++ b/hw/m68k/Makefile.objs
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_AN5206) += an5206.o mcf5206.o
>  obj-$(CONFIG_MCF5208) += mcf5208.o mcf_intc.o
> +obj-$(CONFIG_NEXTCUBE) += next-kbd.o
> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> new file mode 100644
> index 0000000000..c866562382
> --- /dev/null
> +++ b/hw/m68k/next-kbd.c
> @@ -0,0 +1,284 @@
> +/*
> + * QEMU NeXT Keyboard/Mouse emulation
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
> +
> +/*
> + * This is admittedly hackish, but works well enough for basic input. Mouse
> + * support will be added once we can boot something that needs the mouse.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "exec/address-spaces.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/m68k/next-cube.h"
> +#include "ui/console.h"
> +#include "sysemu/sysemu.h"
> +
> +#define NEXTKBD(obj) OBJECT_CHECK(NextKBDState, (obj), TYPE_NEXTKBD)
> +
> +/* following defintions from next68k netbsd */
> +#define CSR_INT 0x00800000
> +#define CSR_DATA 0x00400000
> +
> +#define KD_KEYMASK    0x007f
> +#define KD_DIRECTION  0x0080 /* pressed or released */
> +#define KD_CNTL       0x0100
> +#define KD_LSHIFT     0x0200
> +#define KD_RSHIFT     0x0400
> +#define KD_LCOMM      0x0800
> +#define KD_RCOMM      0x1000
> +#define KD_LALT       0x2000
> +#define KD_RALT       0x4000
> +#define KD_VALID      0x8000 /* only set for scancode keys ? */
> +#define KD_MODS       0x4f00
> +
> +#define KBD_QUEUE_SIZE 256
> +
> +typedef struct {
> +    uint8_t data[KBD_QUEUE_SIZE];
> +    int rptr, wptr, count;
> +} KBDQueue;
> +
> +
> +typedef struct NextKBDState {
> +    SysBusDevice sbd;
> +    MemoryRegion mr;
> +    KBDQueue queue;
> +    uint16_t shift;
> +} NextKBDState;
> +
> +static void queue_code(void *opaque, int code);
> +
> +/* lots of magic numbers here */
> +static uint32_t kbd_read_byte(void *opaque, hwaddr addr)
> +{
> +    switch (addr & 0x3) {
> +    case 0x0:   /* 0xe000 */
> +        return 0x80 | 0x20;
> +
> +    case 0x1:   /* 0xe001 */
> +        return 0x80 | 0x40 | 0x20 | 0x10;
> +
> +    case 0x2:   /* 0xe002 */
> +        /* returning 0x40 caused mach to hang */
> +        return 0x10 | 0x2 | 0x1;
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "NeXT kbd read byte %"HWADDR_PRIx"\n", addr);
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t kbd_read_word(void *opaque, hwaddr addr)
> +{

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    qemu_log_mask(LOG_UNIMP, "NeXT kbd read word %"HWADDR_PRIx"\n", addr);
> +    return 0;
> +}
> +
> +/* even more magic numbers */
> +static uint32_t kbd_read_long(void *opaque, hwaddr addr)
> +{
> +    int key = 0;
> +    NextKBDState *s = NEXTKBD(opaque);
> +    KBDQueue *q = &s->queue;
> +
> +    switch (addr & 0xf) {
> +    case 0x0:   /* 0xe000 */
> +        return 0xA0F09300;
> +
> +    case 0x8:   /* 0xe008 */
> +        /* get keycode from buffer */
> +        if (q->count > 0) {
> +            key = q->data[q->rptr];
> +            if (++q->rptr == KBD_QUEUE_SIZE) {
> +                q->rptr = 0;
> +            }
> +
> +            q->count--;
> +
> +            if (s->shift) {
> +                key |= s->shift;
> +            }
> +
> +            if (key & 0x80) {
> +                return 0;
> +            } else {
> +                return 0x10000000 | KD_VALID | key;
> +            }
> +        } else {
> +            return 0;
> +        }
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "NeXT kbd read long %"HWADDR_PRIx"\n", addr);
> +        return 0;
> +    }
> +}
> +
> +static uint64_t kbd_readfn(void *opaque, hwaddr addr, unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        return kbd_read_byte(opaque, addr);
> +    case 2:
> +        return kbd_read_word(opaque, addr);
> +    case 4:
> +        return kbd_read_long(opaque, addr);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void kbd_writefn(void *opaque, hwaddr addr, uint64_t value,
> +                        unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "NeXT kbd write: size=%u addr=0x%"HWADDR_PRIx
> +                  "val=0x%"PRIx64"\n", size, addr, value);
> +}
> +
> +static const MemoryRegionOps kbd_ops = {
> +    .read = kbd_readfn,
> +    .write = kbd_writefn,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void nextkbd_event(void *opaque, int ch)
> +{
> +    /*
> +     * Will want to set vars for caps/num lock
> +     * if (ch & 0x80) -> key release
> +     * there's also e0 escaped scancodes that might need to be handled
> +     */
> +    queue_code(opaque, ch);
> +}
> +
> +static const unsigned char next_keycodes[128] = {
> +    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
> +    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
> +    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
> +    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
> +    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
> +    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
> +    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
> +    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
> +};
> +
> +static void queue_code(void *opaque, int code)
> +{
> +    NextKBDState *s = NEXTKBD(opaque);
> +    KBDQueue *q = &s->queue;
> +    int key = code & KD_KEYMASK;
> +    int release = code & 0x80;
> +    static int ext;
> +
> +    if (code == 0xE0) {
> +        ext = 1;
> +    }
> +
> +    if (code == 0x2A || code == 0x1D || code == 0x36) {
> +        if (code == 0x2A) {
> +            s->shift = KD_LSHIFT;
> +        } else if (code == 0x36) {
> +            s->shift = KD_RSHIFT;
> +            ext = 0;
> +        } else if (code == 0x1D && !ext) {
> +            s->shift = KD_LCOMM;
> +        } else if (code == 0x1D && ext) {
> +            ext = 0;
> +            s->shift = KD_RCOMM;
> +        }
> +        return;
> +    } else if (code == (0x2A | 0x80) || code == (0x1D | 0x80) ||
> +               code == (0x36 | 0x80)) {
> +        s->shift = 0;
> +        return;
> +    }
> +
> +    if (q->count >= KBD_QUEUE_SIZE) {
> +        return;
> +    }
> +
> +    q->data[q->wptr] = next_keycodes[key] | release;
> +
> +    if (++q->wptr == KBD_QUEUE_SIZE) {
> +        q->wptr = 0;
> +    }
> +
> +    q->count++;
> +
> +    /*
> +     * might need to actually trigger the NeXT irq, but as the keyboard works
> +     * at the moment, I'll worry about it later
> +     */
> +    /* s->update_irq(s->update_arg, 1); */
> +}
> +
> +static void nextkbd_reset(DeviceState *dev)
> +{
> +    NextKBDState *nks = NEXTKBD(dev);
> +
> +    memset(&nks->queue, 0, sizeof(KBDQueue));
> +    nks->shift = 0;
> +}
> +
> +static void nextkbd_realize(DeviceState *dev, Error **errp)
> +{
> +    NextKBDState *s = NEXTKBD(dev);
> +
> +    memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
> +
> +    qemu_add_kbd_event_handler(nextkbd_event, s);
> +}
> +
> +static void nextkbd_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    dc->realize = nextkbd_realize;
> +    dc->reset = nextkbd_reset;
> +}
> +
> +static const TypeInfo nextkbd_info = {
> +    .name          = TYPE_NEXTKBD,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(NextKBDState),
> +    .class_init    = nextkbd_class_init,
> +};
> +
> +static void nextkbd_register_types(void)
> +{
> +    type_register_static(&nextkbd_info);
> +}
> +
> +type_init(nextkbd_register_types)
> diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
> index 090c7c51aa..37f7ce3e34 100644
> --- a/include/hw/m68k/next-cube.h
> +++ b/include/hw/m68k/next-cube.h
> @@ -4,4 +4,6 @@
>  
>  #define TYPE_NEXTFB "next-fb"
>  
> +#define TYPE_NEXTKBD "next-kbd"
> +
>  #endif /* NEXT_CUBE_H */
> 

