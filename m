Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28CC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2795208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2795208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGMj-0006cw-Pe
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hiGIX-00050O-Mp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hiGIS-0005pZ-Bp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:46:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hiGIR-0005k1-U9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:46:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so17175515wre.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GQQgIU4xVk3Zxp6hqseb5VHp8G1HcQI8fNGhS9cUekA=;
 b=jKa0qz1jweBkkHgCh7hGJrVq4dlVwpaStviWvECLj4Ou0cgoAQ56NMMOGI6J01zzaj
 l5oUwme77qLhKpVk3u8VYyiXjaPwl03HBSLMCh3H4dI9XN/pEX3XRoSOkITuuExUVefX
 j4y9fNFxP240XFQUqbwLBaMK9Y0xF5RbK+QhKBql4PaAsMFyBDeY3OGRV3ObYt9QoN0D
 YG2rvKXtOPzBdxhxJ/RZHCwQbE+4GdazUhsO++za46VVFoy/0cMUHDOa+DVpmJpVsht/
 4X1MK0a0NfSoZjvZ838cUKw4l/O8d9rI7v7RfOSvlwVIVX7WRyKfb/OpKZncwOwG+paR
 9EiQ==
X-Gm-Message-State: APjAAAVrX4kQdz0uOkoZe1uaO1Q11B0dpdvsn4Djk4OaR2SZP8RobnkL
 XsQlOOs/TK4w8C4wJOkev6I=
X-Google-Smtp-Source: APXvYqxeEaZRz6Q+U6V3FhDlW/wtFPPhehrjSb+I1GklwUtWtbct3Liu6dj+0nGiGxySxeYmwChBkg==
X-Received: by 2002:a05:6000:106:: with SMTP id
 o6mr24231641wrx.4.1562064355334; 
 Tue, 02 Jul 2019 03:45:55 -0700 (PDT)
Received: from thuth.remote.csb (p5791DA9F.dip0.t-ipconnect.de.
 [87.145.218.159])
 by smtp.gmail.com with ESMTPSA id s12sm2031376wmh.34.2019.07.02.03.45.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:45:54 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-3-huth@tuxfamily.org>
 <68f43288-a4d4-4550-77e2-f712d0aca85e@redhat.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <061cd03d-b6eb-ee2f-092b-10f86d30a947@tuxfamily.org>
Date: Tue, 2 Jul 2019 12:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <68f43288-a4d4-4550-77e2-f712d0aca85e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/4] m68k: Add NeXTcube keyboard device
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

On 29/06/2019 14.02, Philippe Mathieu-Daudé wrote:
> On 6/28/19 8:15 PM, Thomas Huth wrote:
>> It is likely still quite incomplete (e.g. mouse and interrupts are not
>> implemented yet), but it is good enough for keyboard input at the firmware
>> monitor.
[...]
>> +
>> +static uint32_t kbd_read_word(void *opaque, hwaddr addr)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "NeXT kbd read word %"HWADDR_PRIx"\n", addr);
> 
> This sounds odd... a bus working in 32-bit/8-bit but not 16...

I guess the bus is working in 16-bit, too, it's just that the firmware
(and the OS) does not access it in that mode, so neither Bryce nor I
spent time implementing this. It's an "UNIMP" log entry ... so whenever
we see it during runtime, we still can add it.

>> +    return 0;
>> +}
[...]
>> +static void kbd_write_byte(void *opaque, hwaddr addr, uint32_t val)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "NeXT kbd write byte %"HWADDR_PRIx"\n", addr);
>> +}
>> +static void kbd_write_word(void *opaque, hwaddr addr, uint32_t val)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "NeXT kbd write addr %"HWADDR_PRIx"\n", addr);
>> +}
>> +static void kbd_write_long(void *opaque, hwaddr addr, uint32_t val)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "NeXT kbd write long %"HWADDR_PRIx"\n", addr);
>> +}
>> +
>> +static uint64_t kbd_readfn(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    switch (size) {
>> +    case 1:
>> +        return kbd_read_byte(opaque, addr);
>> +    case 2:
>> +        return kbd_read_word(opaque, addr);
>> +    case 4:
>> +        return kbd_read_long(opaque, addr);
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static void kbd_writefn(void *opaque, hwaddr addr, uint64_t value,
>> +                        unsigned size)
>> +{
>> +    switch (size) {
>> +    case 1:
>> +        kbd_write_byte(opaque, addr, value);
>> +        break;
>> +    case 2:
>> +        kbd_write_word(opaque, addr, value);
>> +        break;
>> +    case 4:
>> +        kbd_write_long(opaque, addr, value);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
> 
> Well, you can replace this by:
> 
>     qemu_log_mask(LOG_UNIMP,
>                   "NeXT kbd write size:%u 0x%"HWADDR_PRIx"\n",
>                   size, addr);
> 
> and kill the kbd_write_*() functions and the assert (never
> reached since .valid.max_access_size = 4).

Good idea, I'll do it in v3.

>> +}
>> +
>> +static const MemoryRegionOps kbd_ops = {
>> +    .read = kbd_readfn,
>> +    .write = kbd_writefn,
>> +    .valid.min_access_size = 1,
>> +    .valid.max_access_size = 4,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>> +static void nextkbd_event(void *opaque, int ch)
>> +{
>> +    /*
>> +     * Will want to set vars for caps/num lock
>> +     * if (ch & 0x80) -> key release
>> +     * there's also e0 escaped scancodes that might need to be handled
>> +     */
>> +    queue_code(opaque, ch);
>> +}
>> +
>> +static const unsigned char next_keycodes[128] = {
>> +    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>> +    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>> +    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>> +    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>> +    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>> +    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>> +    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>> +    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>> +};
>> +
>> +static void queue_code(void *opaque, int code)
>> +{
>> +    NextKBDState *s = NEXTKBD(opaque);
>> +    KBDQueue *q = &s->queue;
>> +    int key = code & 0x7F;
> 
> Here 0x7f is ARRAY_SIZE(next_keycodes) - 1, ok.
> Isn't it the KD_KEYMASK definition from above then?

I guess so ... I'll use it in v3.

>> +    int release = code & 0x80;
>> +    static int ext;
>> +
>> +    if (code == 0xE0) {
>> +        ext = 1;
>> +    }
>> +
>> +    if (code == 0x2A || code == 0x1D || code == 0x36) {
>> +        if (code == 0x2A) {
>> +            s->shift = KD_LSHIFT;
>> +        } else if (code == 0x36) {
>> +            s->shift = KD_RSHIFT;
>> +            ext = 0;
>> +        } else if (code == 0x1D && !ext) {
>> +            s->shift = KD_LCOMM;
>> +        } else if (code == 0x1D && ext) {
>> +            ext = 0;
>> +            s->shift = KD_RCOMM;
>> +        }
>> +        return;
>> +    } else if (code == (0x2A | 0x80) || code == (0x1D | 0x80) ||
>> +               code == (0x36 | 0x80)) {
>> +        s->shift = 0;
>> +        return;
>> +    }
>> +
>> +    if (q->count >= KBD_QUEUE_SIZE) {
>> +        return;
>> +    }
>> +
>> +    q->data[q->wptr] = next_keycodes[key] | release;
>> +
>> +    if (++q->wptr == KBD_QUEUE_SIZE) {
>> +        q->wptr = 0;
>> +    }
>> +
>> +    q->count++;
>> +
>> +    /*
>> +     * might need to actually trigger the NeXT irq, but as the keyboard works
>> +     * at the moment, I'll worry about it later
>> +     */
>> +    /* s->update_irq(s->update_arg, 1); */
>> +}
>> +
>> +static void nextkbd_reset(DeviceState *dev)
>> +{
>> +    NextKBDState *nks = NEXTKBD(dev);
>> +
>> +    memset(&nks->queue, 0, sizeof(KBDQueue));
>> +    nks->shift = 0;
>> +}
>> +
>> +static void nextkbd_realize(DeviceState *dev, Error **errp)
>> +{
>> +    NextKBDState *s = NEXTKBD(dev);
>> +
>> +    memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
>> +
>> +    qemu_add_kbd_event_handler(nextkbd_event, s);
>> +}
>> +
>> +static void nextkbd_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +
>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>> +    dc->realize = nextkbd_realize;
>> +    dc->reset = nextkbd_reset;
>> +}
>> +
>> +static const TypeInfo nextkbd_info = {
>> +    .name          = TYPE_NEXTKBD,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(NextKBDState),
>> +    .class_init    = nextkbd_class_init,
>> +};
>> +
>> +static void nextkbd_register_types(void)
>> +{
>> +    type_register_static(&nextkbd_info);
>> +}
>> +
>> +type_init(nextkbd_register_types)
>> +
>> +void nextkbd_init(void)
>> +{
>> +    DeviceState *dev;
>> +    NextKBDState *nks;
>> +
>> +    dev = qdev_create(NULL, TYPE_NEXTKBD);
>> +    qdev_init_nofail(dev);
>> +
>> +    nks = NEXTKBD(dev);
>> +    memory_region_add_subregion(get_system_memory(), 0x200e000, &nks->mr);
> 
> 0x200e000 -> 0x0200e000 :)

Ok.

>> +}
> 
> Again, nextkbd_init() is board-specific code.
> Could you move this function there?

Will do.

 Thanks,
  Thomas

