Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7401C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC2020645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpveUlZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC2020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfUP7-000147-Bx
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 15:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfUHX-0004NZ-1T
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfUHM-00087j-KW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:05:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfUHE-0007iT-Cf; Mon, 24 Jun 2019 15:05:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id k11so15095021wrl.1;
 Mon, 24 Jun 2019 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:references:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fZ6CNwT3zViWq6XPHMpwuT5Ktb4gW3hpumkdLMOQQeI=;
 b=rpveUlZF4zgnwYA4YB9kLFfO+qwo9YD/CQW6S9d0PF4V9g6HBI/EqHUkvDCLSUzQNf
 EbaobkIUyk+xAnVJ9H0SlmdMkqDnPnlJYPrrO1fwmOHrRiF+spSzsYCmyCE//5ZKpiiS
 4zaNi77kAMK2He5ptoIaw4FOkdHX3U43Yia1+RabmU/t+j1GLPGBllzzmL4TZvPXxNTs
 TUIvKAX2qTj0dW3raWrd5McCRe0FcL2t1J26xa40ICdmluq3maVo2SxgExVqcxBA2wPf
 kd1P3eOSkKryuTH/IoaLQU8iJpxCfICXxjHIZtvhp/0oXBD/GlviNQjocjDkuvxV8w0R
 Sl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:references:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fZ6CNwT3zViWq6XPHMpwuT5Ktb4gW3hpumkdLMOQQeI=;
 b=LwVRRyHDgO7EPq7blTjW4ZdQvR8Y7IXCKUlJy1tispwtwz6G1QvzssRQHnLB2MwX1H
 AiqocHUt6bByQikQp3lwfJ2q+QFp6ODGVSBsknh21gMLBgtn31TC+qiNQLuF5a8H0brY
 UfT7B/YSsZo2E1v+RN53xxQRvqBF1YsYFKrwYziu+w2+1FZdY485O2G//cnh9c+fVjuB
 mfsjHQt9HSlLuaWUxnCJsjaessj35hCRal8tQAy8HwP8grz3UgQHZrpE17MNEfKlaG6e
 bh8Xe+e+eTgPPbgWeNuMcLBbacbpOsFQXsxf1kPa65mDDj15wWDYumXsTvdbr+fbXuVB
 orVA==
X-Gm-Message-State: APjAAAVLNgu7BvcK+3Ka2hvENIgTPyV0KNMPyCL8IihPr4gziXzCaUu7
 bSzNldOx2vpDn4e/8qkN55Q=
X-Google-Smtp-Source: APXvYqyngSDJRqjn8YdyY2KOHGZ6qh0YTBBfktKXxQhTzdg9zeZRKVjK/28z3YblXExfXVP9is99YA==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr47684579wrk.229.1561403103776; 
 Mon, 24 Jun 2019 12:05:03 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id j132sm253473wmj.21.2019.06.24.12.05.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 12:05:02 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
 <20190426162624.55977-5-stephen.checkoway@oberlin.edu>
 <6d2c9dcc-06f5-4eed-d779-b0c4d2b60182@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <b7730260-bfb6-f2b1-7c01-9d7b6a10c71e@amsat.org>
Date: Mon, 24 Jun 2019 21:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6d2c9dcc-06f5-4eed-d779-b0c4d2b60182@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 04/10] block/pflash_cfi02: Implement
 intereleaved flash devices
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/19 2:25 PM, Philippe Mathieu-Daudé wrote:
> Hi Stephen,
> 
> This series haven't fall through the cracks, however it is taking me
> longer than expected to review it.
> 
> On 4/26/19 6:26 PM, Stephen Checkoway wrote:
>> It's common for multiple narrow flash chips to be hooked up in parallel
>> to support wider buses. For example, four 8-bit wide flash chips (x8)
>> may be combined in parallel to produce a 32-bit wide device. Similarly,
>> two 16-bit wide chips (x16) may be combined.
>>
>> This commit introduces `device-width` and `max-device-width` properties,
>> similar to pflash_cfi01, with the following meanings:
>> - `width`: The width of the logical, qemu device (same as before);
>> - `device-width`: The width of an individual flash chip, defaulting to
>>   `width`; and
>> - `max-device-width`: The maximum width of an individual flash chip,
>>   defaulting to `device-width`.
>>
>> Nothing needs to change to support reading such interleaved devices but
>> commands (e.g., erase and programming) must be sent to all devices at
>> the same time or else the various chips will be in different states.
> 
> After some thoughts on this, I'd rather we model how hardware manage
> interleaved devices: do it at the bus level, and instanciate N devices
> in an interleaved config.
> I believe that would drastically reduce this device complexity, and we
> would match the real internal state machine.
> Also this could be reused by other parallel devices used in a such config.
> 
>> For example, a 4-byte wide logical device can be composed of four x8/x16
>> devices in x8 mode. That is, each device supports both x8 or x16 and
>> they're being used in the byte, rather than word, mode. This
>> configuration would have `width=4`, `device-width=1`, and
>> `max-device-width=2`.
> 
> 
> I'm thinking of this draft:
> 
> FlashDevice # x8
>   MemoryRegionOps
>     .valid.max_access_size = 1
> 
> FlashDevice # x16
>   MemoryRegionOps
>     .valid.min_access_size = 2
>     .valid.max_access_size = 2
> 
> FlashDevice # x8/x16
>   MemoryRegionOps
>     .valid.min_access_size = 1
>     .valid.max_access_size = 2
> 
> We might use .impl.min_access_size = 2 and consider all NOR flash using
> 16-bit words internally.
>     .impl.max_access_size = 2 is implicit.
> 
> So for you example we'd instanciate one:
> 
> InterleaverDevice
>   Property
>     .bus_width = 4 # 4-byte wide logical device, `width=4`
>     .device_width = 1 # `device-width=1`
>   MemoryRegionOps
>     .valid.max_access_size = .bus_width # 4, set at realize()
>     .impl.max_access_size = .device_width # 1, set at realize()
> 
> Then instanciate 4 pflash devices, and link them to the interleaver
> using object_property_set_link().
> 
> typedef struct {
>     SysBusDevice parent_obj;
>     MemoryRegion iomem;
>     char *name;
>     /*
>      * On a 64-bit wide bus we can have at most
>      * 8 devices in 8-bit access mode.
>      */
>     MemoryRegion device[8];
>     unsigned device_count;
>     unsigned device_index_mask;
>     /* Properties */
>     unsigned bus_width;
>     unsigned device_width;
> } InterleaverDeviceState;
> 
> static Property interleaver_properties[] = {
>     DEFINE_PROP_LINK("device[0]", InterleaverDeviceState,
>                      device[0],
>                      TYPE_MEMORY_REGION, MemoryRegion *),
>     ...
>     DEFINE_PROP_LINK("device[7]", InterleaverDeviceState,
>                      device[7],
>                      TYPE_MEMORY_REGION, MemoryRegion *),
>     DEFINE_PROP_END_OF_LIST(),
> };
> 
> Then previous to call InterleaverDevice.realize():
> 
> In the board realize():
> 
> 
>     for (i = 0; i < interleaved_devices; i++) {
>         pflash[i] = create_pflash(...);
>         ...
>     }
> 
>     ild = ... create InterleaverDevice ...
>     for (i = 0; i < interleaved_devices; i++) {
>         char *propname = g_strdup_printf("device[%u]", i);
> 
> 
>         object_property_set_link(OBJECT(&ild->device[i]),
>                                  OBJECT(pflash[i]),
>                                  propname, &err);
>         ...
>     }
> 
> Finally,
> 
> static void interleaved_realize(DeviceState *dev, Error **errp)
> {
>     InterleaverDeviceState *s = INTERLEAVER_DEVICE(opaque);
> 
>     s->device_count = s->bus_width / s->device_width;
>     s->device_index_mask = ~(s->device_count - 1);
>     ...
> }
> 
> static void interleaved_write(void *opaque, hwaddr offset,
>                               uint64_t value, unsigned size)
> {
>     InterleaverDeviceState *s = INTERLEAVER_DEVICE(opaque);
>     MemoryRegion *mr;
> 
>     /*
>      * Since we set .impl.max_access_size = device_width,
>      * access_with_adjusted_size() always call this with
>      * size = device_width.
>      *
>      * Adjust the address (offset).
>      */
>     offset >>= size;
>     /* Access the N interleaved device */
>     mr = s->device[offset & s->device_index_mask];
>     memory_region_dispatch_write(mr, offset, &value, size,
>                                  MEMTXATTRS_UNSPECIFIED);
> }
> 
> I'll try a PoC.

So I have a PoC, but then realize I can not use the same flash dump...

I need to deinterleave is. This is easily fixed with few lines of
Python, then if I want to store/share the dump (aka 'backend storage') I
have to re-interleave it.

I wonder if it would be possible/easy to add a 'interleave' option to
blockdev to be able to have 2 pflash devices sharing the same backend...
Is it worthwhile? Kevin/Markus/Max any thought on this?

Thanks,

Phil.

>> In addition to commands being sent to all devices, guest firmware
>> expects the status and CFI queries to be replicated for each device.
>> (The one exception to the response replication is that each device gets
>> to report its own status bit DQ7 while programming because its value
>> depends on the value being programmed which will usually differ for each
>> device.)
>>
>> Testing is limited to 16-bit wide devices due to the current inability
>> to override the properties set by `pflash_cfi02_register`, but multiple
>> configurations are tested.
>>
>> Stop using global_qtest. Instead, package the qtest variable inside the
>> FlashConfig structure.
>>
>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/block/pflash_cfi02.c   | 270 +++++++++++++++------
>>  tests/pflash-cfi02-test.c | 476 ++++++++++++++++++++++++++++++--------
>>  2 files changed, 576 insertions(+), 170 deletions(-)

