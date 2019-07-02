Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDEF2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDEF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMJJ-0003tw-9w
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiLEJ-0000A0-Tj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiLEH-0007Gz-SV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:02:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiLEF-0007CS-RV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:02:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so899256wme.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 09:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/+SBXBKvYpBl9uqyUOlcFHlfFZ9MOGSGZNovWomQn3E=;
 b=c8moHwxafA+JJu8Npl0qupMHhJx4KGoKPt/6Mg+lnaNLa26xkYl8mZI97vyrEPm6Wy
 96Skl6PCm0lMNVVhiJwg6tHHMouwedQm0D1PBWYwJZ+gQNnizD4zSOdl+v3UgkljgYu/
 8hXQvN+bAGVNoTtaPhPJM2xjqZZvhRhAqt9ubxx47NgDFAQsYLDe6jhWj7Ki0Ot0m7QD
 0ttp+5wpefJxp8QOf/htqIWW9sA5co92Y6m8TkOAWaqkgWUm6cEFXsf3F/T7ZWXg4dmj
 rfkzXlMOGlmmMvwcON9ejftHSSwNPpOzXBV5XTuL65gixIB79fLoCT7dwrct8T4Whngo
 1wXw==
X-Gm-Message-State: APjAAAVqlBATgpitFHuioI95+tjOu7BHri8HpHncoZFqrLQUjoK6MA3f
 pxbOFYEbfJNw4eok4ZaAKFd8BA==
X-Google-Smtp-Source: APXvYqwVYzvMwvUBIIV+6znLP2CXGU+oiNTkBdK1lO23vSN4sxNX0F54498Ht0Tjcs2PUM5Im0mDuw==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr3918275wmi.15.1562083311075;
 Tue, 02 Jul 2019 09:01:51 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id t15sm13698274wrx.84.2019.07.02.09.01.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 09:01:50 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-2-huth@tuxfamily.org>
 <994e8c6a-2137-9369-e9bb-05b017787b7b@redhat.com>
 <169e1d10-94c9-9f1a-8799-7483ba815538@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f1b026d5-794c-a2cb-f67d-d3f4ac99d615@redhat.com>
Date: Tue, 2 Jul 2019 18:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <169e1d10-94c9-9f1a-8799-7483ba815538@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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

On 6/29/19 7:45 PM, Thomas Huth wrote:
> On 29/06/2019 13.53, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 6/28/19 8:15 PM, Thomas Huth wrote:
>>> The NeXTcube uses a linear framebuffer with 4 greyscale colors and
>>> a fixed resolution of 1120 * 832.
>>> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>>>
>>>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c
>>
>> Please use SHA1 for reference (unlikely case of Bryce pushing a new
>> version to his repo):
>>
>> https://github.com/blanham/qemu-NeXT/blob/34f4323/hw/next-fb.c
> 
> But if Bryce ever pushes a new version to his branch, the old SHA IDs
> won't be part of a branch anymore, so they will be garbage collected
> after a while and the links will become invalid. I think it's better to
> refer to the "next-cube" branch.

OK.

>>> and altered to fit the latest interface of the current QEMU (e.g.
>>> the device has been "qdev"-ified etc.).
>>>
>>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>>> ---
> [...]
>>> diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
>>> new file mode 100644
>>> index 0000000000..740102d7e9
>>> --- /dev/null
>>> +++ b/hw/display/next-fb.c
>>> @@ -0,0 +1,157 @@
>>> +/*
>>> + * NeXT Cube/Station Framebuffer Emulation
>>> + *
>>> + * Copyright (c) 2011 Bryce Lanham
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>>> + * of this software and associated documentation files (the "Software"), to deal
>>> + * in the Software without restriction, including without limitation the rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>>> + * copies of the Software, and to permit persons to whom the Software is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>> + * THE SOFTWARE.
>>> + */
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "ui/console.h"
>>> +#include "hw/hw.h"
>>> +#include "hw/boards.h"
>>> +#include "hw/loader.h"
>>> +#include "hw/display/framebuffer.h"
>>> +#define BITS 8
>>
>> 'BITS' is not used, remove?
> 
> Seems unused, indeed. I'll remove it.
> 
>>> +static void nextfb_draw_line(void *opaque, uint8_t *d, const uint8_t *s,
>>> +                             int width, int pitch)
>>> +{
>>> +    NeXTFbState *nfbstate = NEXTFB(opaque);
>>> +    static const uint32_t pal[4] = {
>>> +        0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0xFF000000
>>> +    };
>>> +    uint32_t *buf = (uint32_t *)d;
>>> +    int i = 0;
>>> +
>>> +    for (i = 0; i < nfbstate->cols / 4; i++) {
>>> +        int j = i * 4;
>>> +        uint8_t src = s[i];
>>> +        buf[j + 3] = pal[src & 0x3];
>>
>> 0x3 -> 3?
> 
> I prefer the "0x" for bit-wise logical operations.

OK

>> or 0b11 :)
> 
> Hmm, does that work with all compiler versions that we currently
> support? I remember it was not working with older versions of GCC...

$ git grep 0b
accel/tcg/user-exec.c:608:    switch (((insn >> 0) & 0b11)) {
accel/tcg/user-exec.c:610:        switch (((insn >> 2) & 0b11111)) {
...

It now certainly does :)

> Anyway, Bryce used 0x3 in his original code, so I'd like to keep it
> close to his original code for the first commit. We can rework stuff
> like this in later patches if we like, but for the initial commit, it
> would be adequate that you can still recognize the original code, I think.

Fair enough.

>>> +        src >>= 2;
>>> +        buf[j + 2] = pal[src & 0x3];
>>> +        src >>= 2;
>>> +        buf[j + 1] = pal[src & 0x3];
>>> +        src >>= 2;
>>> +        buf[j + 0] = pal[src & 0x3];
>>> +    }
>>> +}
>>> +
>>> +static void nextfb_update(void *opaque)
>>> +{
>>> +    NeXTFbState *s = NEXTFB(opaque);
>>> +    int dest_width = 4;
>>> +    int src_width;
>>> +    int first = 0;
>>> +    int last  = 0;
>>> +    DisplaySurface *surface = qemu_console_surface(s->con);
>>> +
>>> +    src_width = s->cols / 4 + 8;
>>> +    dest_width = s->cols * 4;
>>
>> Since those are currently const, should we move them to NeXTFbState
>> and initialize them in nextfb_realize()?
> 
> Should not matter much ... I think I'll also keep the original code here
> for now.
> 
>>> +
>>> +    if (s->invalidate) {
>>> +        framebuffer_update_memory_section(&s->fbsection, &s->fb_mr, 0,
>>> +                                          s->cols, src_width);
>>> +        s->invalidate = 0;
>>> +    }
>>> +
>>> +    framebuffer_update_display(surface, &s->fbsection, 1120, 832,
>>
>> 1120 -> s->cols?
>> 832 -> s->rows?
>>
>>> +                               src_width, dest_width, 0, 1, nextfb_draw_line,
>>> +                               s, &first, &last);
>>> +
>>> +    dpy_gfx_update(s->con, 0, 0, 1120, 832);
>>
>> Ditto.
> 
> Ok.
> 
>>> +}
>>> +
>>> +static void nextfb_invalidate(void *opaque)
>>> +{
>>> +    NeXTFbState *s = NEXTFB(opaque);
>>> +    s->invalidate = 1;
>>> +}
>>> +
>>> +static const GraphicHwOps nextfb_ops = {
>>> +    .invalidate  = nextfb_invalidate,
>>> +    .gfx_update  = nextfb_update,
>>> +};
>>> +
>>> +static void nextfb_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    NeXTFbState *s = NEXTFB(dev);
>>> +
>>> +    memory_region_init_ram(&s->fb_mr, OBJECT(dev), "next-video", 0x1CB100,
>>> +                           &error_fatal);
>>
>> 2 bits * cols * rows = 2 * 832 * 1120 = 0x1c7000
>>
>> 0x1cb100 - 0x1c7000 = 0x4100
>>
>> Any idea what are these 16K + 256 extra bytes for?
> 
> No clue. But as you can see in nextfb_update() ("src_width = s->cols / 4
> + 8"), a line is a little bit wider than the visible 1120 pixels.

Weird :)

>> Anyway we have 2MB of VRAM on the hardware here, right?
>> If so you should replace 0x1CB100 -> 2 * MiB.
> 
> I don't know the Cube hardware that well ... so let's keep the original
> values for now, we can still tune it later if necessary.
> 
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->fb_mr);
>>> +
>>> +    s->invalidate = 1;
>>> +    s->cols = 1120;
>>> +    s->rows = 832;
>>> +
>>> +    s->con = graphic_console_init(dev, 0, &nextfb_ops, s);
>>> +    qemu_console_resize(s->con, s->cols, s->rows);
>>> +}
>>> +
>>> +static void nextfb_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>>> +
>>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>>> +    dc->realize = nextfb_realize;
>>> +}
>>> +
>>> +static const TypeInfo nextfb_info = {
>>> +    .name          = TYPE_NEXTFB,
>>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>>> +    .instance_size = sizeof(NeXTFbState),
>>> +    .class_init    = nextfb_class_init,
>>> +};
>>> +
>>> +static void nextfb_register_types(void)
>>> +{
>>> +    type_register_static(&nextfb_info);
>>> +}
>>> +
>>> +type_init(nextfb_register_types)
>>> +
>>> +void nextfb_init(void)
>>> +{
>>> +    DeviceState *dev;
>>> +
>>> +    dev = qdev_create(NULL, TYPE_NEXTFB);
>>> +    qdev_init_nofail(dev);
>>> +
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xB000000);
>>
>> I'd appreciate this written as 0x0B000000 (32-bit address range).
>>
>> Should you map the aliased VRAM regions here too?
>>
>>     for (int i = 0; i <= 4; i++) {
>>        sysbus_mmio_map(SYS_BUS_DEVICE(dev), i,
>>                        0x0b000000 + 0x01000000 * i);
>>     }
> 
> Where do you've got the information from that the VRAM region is aliased
> a couple of times?

I looked at Previous, the Next emulator:

https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/cpu/memory.c#l41

Than looked around the code.

>> Anyway nextfb_init() content is this is board-specific code, not
>> related to the device. Can you move it there?
> 
> Ok, will do.
> 
> Thanks for the review!
> 
>  Thomas
> 

