Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE89C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 17:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A750B214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 17:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A750B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhHRg-0003ow-OV
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 13:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hhHQ6-0003NX-OI
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 13:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hhHQ5-0004Mk-1j
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 13:45:50 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hhHQ4-0004Lu-RI
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 13:45:48 -0400
Received: by mail-wm1-f53.google.com with SMTP id u8so11859888wmm.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 10:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=itNaMeRc/pP9VyirDVgdOPtQvWPuF9JJ6Iuog5YjXvE=;
 b=N3E5S44VjcMoLJeWL5ThVLTNSkZnjWDxQYZ8FswvnXpPyKNMgbDxvb2ZFO2IdfUW/q
 yWKNsVjgUZ80msLNMNJZWB2IUkOfo+13VfvRzlt9k2BifY4eao6gNSUVO0WqRoPhIPsP
 Ya1DIjm9QRIJJui+AdDC3bMHAmFoXXtGVFnSVorkGhYWe+hFWz1WpB75wKNYl22u//9d
 agTFxoAE/EoZLftAbgXL8mkBspbb9ue9te9ALSsPQCquSk3y99Hs/NHmg5CDZ8/RcGzK
 lXa/1143SRFKj9HTIDc90x3rWCgwc4XnNlV/4PmR3sUIUw4LwV56+nNMbh5IqdBXcaJQ
 ctWw==
X-Gm-Message-State: APjAAAWMoICSUEHsjm8sCnQxIVvCg50jYfIf9tL7CIDmMP2FDi7Wy2nH
 gjznJfFMGT3Gf/oxYTDN6Qk=
X-Google-Smtp-Source: APXvYqzYDyEKCykTQ0JGDG35MTL7kuqmf9aUkTT39hajesK50odnQOVkeB2umf70k67/VPoiO+XBPg==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr10748726wmg.54.1561830347662; 
 Sat, 29 Jun 2019 10:45:47 -0700 (PDT)
Received: from thuth.remote.csb (p5791D7DD.dip0.t-ipconnect.de.
 [87.145.215.221])
 by smtp.gmail.com with ESMTPSA id w24sm4186481wmc.30.2019.06.29.10.45.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 10:45:45 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-2-huth@tuxfamily.org>
 <994e8c6a-2137-9369-e9bb-05b017787b7b@redhat.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <169e1d10-94c9-9f1a-8799-7483ba815538@tuxfamily.org>
Date: Sat, 29 Jun 2019 19:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <994e8c6a-2137-9369-e9bb-05b017787b7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
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

On 29/06/2019 13.53, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 6/28/19 8:15 PM, Thomas Huth wrote:
>> The NeXTcube uses a linear framebuffer with 4 greyscale colors and
>> a fixed resolution of 1120 * 832.
>> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>>
>>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c
> 
> Please use SHA1 for reference (unlikely case of Bryce pushing a new
> version to his repo):
> 
> https://github.com/blanham/qemu-NeXT/blob/34f4323/hw/next-fb.c

But if Bryce ever pushes a new version to his branch, the old SHA IDs
won't be part of a branch anymore, so they will be garbage collected
after a while and the links will become invalid. I think it's better to
refer to the "next-cube" branch.

>> and altered to fit the latest interface of the current QEMU (e.g.
>> the device has been "qdev"-ified etc.).
>>
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>> ---
[...]
>> diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
>> new file mode 100644
>> index 0000000000..740102d7e9
>> --- /dev/null
>> +++ b/hw/display/next-fb.c
>> @@ -0,0 +1,157 @@
>> +/*
>> + * NeXT Cube/Station Framebuffer Emulation
>> + *
>> + * Copyright (c) 2011 Bryce Lanham
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "ui/console.h"
>> +#include "hw/hw.h"
>> +#include "hw/boards.h"
>> +#include "hw/loader.h"
>> +#include "hw/display/framebuffer.h"
>> +#define BITS 8
> 
> 'BITS' is not used, remove?

Seems unused, indeed. I'll remove it.

>> +static void nextfb_draw_line(void *opaque, uint8_t *d, const uint8_t *s,
>> +                             int width, int pitch)
>> +{
>> +    NeXTFbState *nfbstate = NEXTFB(opaque);
>> +    static const uint32_t pal[4] = {
>> +        0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0xFF000000
>> +    };
>> +    uint32_t *buf = (uint32_t *)d;
>> +    int i = 0;
>> +
>> +    for (i = 0; i < nfbstate->cols / 4; i++) {
>> +        int j = i * 4;
>> +        uint8_t src = s[i];
>> +        buf[j + 3] = pal[src & 0x3];
> 
> 0x3 -> 3?

I prefer the "0x" for bit-wise logical operations.

> or 0b11 :)

Hmm, does that work with all compiler versions that we currently
support? I remember it was not working with older versions of GCC...

Anyway, Bryce used 0x3 in his original code, so I'd like to keep it
close to his original code for the first commit. We can rework stuff
like this in later patches if we like, but for the initial commit, it
would be adequate that you can still recognize the original code, I think.

>> +        src >>= 2;
>> +        buf[j + 2] = pal[src & 0x3];
>> +        src >>= 2;
>> +        buf[j + 1] = pal[src & 0x3];
>> +        src >>= 2;
>> +        buf[j + 0] = pal[src & 0x3];
>> +    }
>> +}
>> +
>> +static void nextfb_update(void *opaque)
>> +{
>> +    NeXTFbState *s = NEXTFB(opaque);
>> +    int dest_width = 4;
>> +    int src_width;
>> +    int first = 0;
>> +    int last  = 0;
>> +    DisplaySurface *surface = qemu_console_surface(s->con);
>> +
>> +    src_width = s->cols / 4 + 8;
>> +    dest_width = s->cols * 4;
> 
> Since those are currently const, should we move them to NeXTFbState
> and initialize them in nextfb_realize()?

Should not matter much ... I think I'll also keep the original code here
for now.

>> +
>> +    if (s->invalidate) {
>> +        framebuffer_update_memory_section(&s->fbsection, &s->fb_mr, 0,
>> +                                          s->cols, src_width);
>> +        s->invalidate = 0;
>> +    }
>> +
>> +    framebuffer_update_display(surface, &s->fbsection, 1120, 832,
> 
> 1120 -> s->cols?
> 832 -> s->rows?
> 
>> +                               src_width, dest_width, 0, 1, nextfb_draw_line,
>> +                               s, &first, &last);
>> +
>> +    dpy_gfx_update(s->con, 0, 0, 1120, 832);
> 
> Ditto.

Ok.

>> +}
>> +
>> +static void nextfb_invalidate(void *opaque)
>> +{
>> +    NeXTFbState *s = NEXTFB(opaque);
>> +    s->invalidate = 1;
>> +}
>> +
>> +static const GraphicHwOps nextfb_ops = {
>> +    .invalidate  = nextfb_invalidate,
>> +    .gfx_update  = nextfb_update,
>> +};
>> +
>> +static void nextfb_realize(DeviceState *dev, Error **errp)
>> +{
>> +    NeXTFbState *s = NEXTFB(dev);
>> +
>> +    memory_region_init_ram(&s->fb_mr, OBJECT(dev), "next-video", 0x1CB100,
>> +                           &error_fatal);
> 
> 2 bits * cols * rows = 2 * 832 * 1120 = 0x1c7000
> 
> 0x1cb100 - 0x1c7000 = 0x4100
> 
> Any idea what are these 16K + 256 extra bytes for?

No clue. But as you can see in nextfb_update() ("src_width = s->cols / 4
+ 8"), a line is a little bit wider than the visible 1120 pixels.

> Anyway we have 2MB of VRAM on the hardware here, right?
> If so you should replace 0x1CB100 -> 2 * MiB.

I don't know the Cube hardware that well ... so let's keep the original
values for now, we can still tune it later if necessary.

>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->fb_mr);
>> +
>> +    s->invalidate = 1;
>> +    s->cols = 1120;
>> +    s->rows = 832;
>> +
>> +    s->con = graphic_console_init(dev, 0, &nextfb_ops, s);
>> +    qemu_console_resize(s->con, s->cols, s->rows);
>> +}
>> +
>> +static void nextfb_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +
>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>> +    dc->realize = nextfb_realize;
>> +}
>> +
>> +static const TypeInfo nextfb_info = {
>> +    .name          = TYPE_NEXTFB,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(NeXTFbState),
>> +    .class_init    = nextfb_class_init,
>> +};
>> +
>> +static void nextfb_register_types(void)
>> +{
>> +    type_register_static(&nextfb_info);
>> +}
>> +
>> +type_init(nextfb_register_types)
>> +
>> +void nextfb_init(void)
>> +{
>> +    DeviceState *dev;
>> +
>> +    dev = qdev_create(NULL, TYPE_NEXTFB);
>> +    qdev_init_nofail(dev);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xB000000);
> 
> I'd appreciate this written as 0x0B000000 (32-bit address range).
> 
> Should you map the aliased VRAM regions here too?
> 
>     for (int i = 0; i <= 4; i++) {
>        sysbus_mmio_map(SYS_BUS_DEVICE(dev), i,
>                        0x0b000000 + 0x01000000 * i);
>     }

Where do you've got the information from that the VRAM region is aliased
a couple of times?

> Anyway nextfb_init() content is this is board-specific code, not
> related to the device. Can you move it there?

Ok, will do.

Thanks for the review!

 Thomas

