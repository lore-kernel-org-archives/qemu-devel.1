Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36921C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE12E20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin.edu header.i=@oberlin.edu header.b="JB/J679z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE12E20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVjo-0008Ni-1G
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <scheckow@oberlin.edu>) id 1hfUlS-0003pu-IB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <scheckow@oberlin.edu>) id 1hfUlO-0002NK-In
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:36:30 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <scheckow@oberlin.edu>)
 id 1hfUlE-00028J-TD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:36:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id i189so8081349pfg.10
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oberlin.edu; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Zrhol/4u5kdGsa3kthkiEPW1M/fmG81jnRGDThTgxHM=;
 b=JB/J679zHGqqZlx0fO+6mw1jhsIK5PKzLwnPCW63oLzNaRWHsqjUZb0+7SQJzXbXyE
 5PUglbcv+7oiMcO+U4maT53IzabNBSymFndBVuLS3BESi0C3uWDRnVfxQRS+n4KwJtd/
 RQlsMUWyMTMC7VkfjaGMesW6HEjFBuL2S5no6jlSjxh1jmunZsitygVE+VcmAZFZeypH
 SgvoggXA8JeH81p1aQ6x/XvZ5HDzad2gFcHemYCEA7OOkomdablo4nsYnZ1Y3YWGlXiW
 Hd+8CfQ6uzItWPA+W7BQTXMXFXBstixd1OnHOL2YuWLvXAaHEQfGD/oC5u09ox7t8mu9
 RNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Zrhol/4u5kdGsa3kthkiEPW1M/fmG81jnRGDThTgxHM=;
 b=gcSqwAlSr5/A1qDj7mNDZRNJab5Yt3i8kW7zFXSDVIXE25QESzGAgJKbGYcn4WlnmN
 LSjM2QdLkuDXdArqYQ3SKHq/Zb+KgixUBCux7PfvYnjyxbU8KxHKblUjd33KzenZAfkn
 OSCPHB5BDsF/+NA1MLMLAC+hTpIbrMevqlhnetT7KQx+Ns3G4JQbzHMEBXcZ5/Fopf+T
 zbg6ueHz4JiydfGStIrupuH3KFxew0xbon+ukRgWhBK5eLk1AZSYLePvQFpxfsZ2waau
 0tpidRWbwIb/js7syHfgDXcjdL5XaMMm4Ft+a59v0l5uHs03NKVxDXsydhgdf0pLi5K7
 YoQA==
X-Gm-Message-State: APjAAAVJiy13EXC26RWxPJkhsQCYkKgGnwduhccyhllBqXSHrkKxO0iR
 J6HRQOlG/r+6vlWnYJlyymTTIg==
X-Google-Smtp-Source: APXvYqyO7hn6//r4aV2rOTcKgBn9cXtqRzoA3Ilj726GMRwX7LHUEhoZ6fFShh8WOBqsHyy9PjGkEg==
X-Received: by 2002:a17:90a:9503:: with SMTP id
 t3mr26616191pjo.47.1561404968438; 
 Mon, 24 Jun 2019 12:36:08 -0700 (PDT)
Received: from [10.252.5.100] ([198.134.98.50])
 by smtp.gmail.com with ESMTPSA id h21sm12215783pgg.75.2019.06.24.12.36.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 12:36:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Stephen Checkoway <scheckow@oberlin.edu>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <b7730260-bfb6-f2b1-7c01-9d7b6a10c71e@amsat.org>
Date: Mon, 24 Jun 2019 12:36:05 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2BE0BC3-0C7D-42FB-8B3A-04FE2D0523E6@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
 <20190426162624.55977-5-stephen.checkoway@oberlin.edu>
 <6d2c9dcc-06f5-4eed-d779-b0c4d2b60182@amsat.org>
 <b7730260-bfb6-f2b1-7c01-9d7b6a10c71e@amsat.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
X-Mailman-Approved-At: Mon, 24 Jun 2019 16:35:39 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 24, 2019, at 12:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
>=20
>> On 6/22/19 2:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Stephen,
>>=20
>> This series haven't fall through the cracks, however it is taking me
>> longer than expected to review it.
>>=20
>>> On 4/26/19 6:26 PM, Stephen Checkoway wrote:
>>> It's common for multiple narrow flash chips to be hooked up in parallel
>>> to support wider buses. For example, four 8-bit wide flash chips (x8)
>>> may be combined in parallel to produce a 32-bit wide device. Similarly,
>>> two 16-bit wide chips (x16) may be combined.
>>>=20
>>> This commit introduces `device-width` and `max-device-width` properties,=

>>> similar to pflash_cfi01, with the following meanings:
>>> - `width`: The width of the logical, qemu device (same as before);
>>> - `device-width`: The width of an individual flash chip, defaulting to
>>>  `width`; and
>>> - `max-device-width`: The maximum width of an individual flash chip,
>>>  defaulting to `device-width`.
>>>=20
>>> Nothing needs to change to support reading such interleaved devices but
>>> commands (e.g., erase and programming) must be sent to all devices at
>>> the same time or else the various chips will be in different states.
>>=20
>> After some thoughts on this, I'd rather we model how hardware manage
>> interleaved devices: do it at the bus level, and instanciate N devices
>> in an interleaved config.
>> I believe that would drastically reduce this device complexity, and we
>> would match the real internal state machine.
>> Also this could be reused by other parallel devices used in a such config=
.
>>=20
>>> For example, a 4-byte wide logical device can be composed of four x8/x16=

>>> devices in x8 mode. That is, each device supports both x8 or x16 and
>>> they're being used in the byte, rather than word, mode. This
>>> configuration would have `width=3D4`, `device-width=3D1`, and
>>> `max-device-width=3D2`.
>>=20
>>=20
>> I'm thinking of this draft:
>>=20
>> FlashDevice # x8
>>  MemoryRegionOps
>>    .valid.max_access_size =3D 1
>>=20
>> FlashDevice # x16
>>  MemoryRegionOps
>>    .valid.min_access_size =3D 2
>>    .valid.max_access_size =3D 2
>>=20
>> FlashDevice # x8/x16
>>  MemoryRegionOps
>>    .valid.min_access_size =3D 1
>>    .valid.max_access_size =3D 2
>>=20
>> We might use .impl.min_access_size =3D 2 and consider all NOR flash using=

>> 16-bit words internally.
>>    .impl.max_access_size =3D 2 is implicit.
>>=20
>> So for you example we'd instanciate one:
>>=20
>> InterleaverDevice
>>  Property
>>    .bus_width =3D 4 # 4-byte wide logical device, `width=3D4`
>>    .device_width =3D 1 # `device-width=3D1`
>>  MemoryRegionOps
>>    .valid.max_access_size =3D .bus_width # 4, set at realize()
>>    .impl.max_access_size =3D .device_width # 1, set at realize()
>>=20
>> Then instanciate 4 pflash devices, and link them to the interleaver
>> using object_property_set_link().
>>=20
>> typedef struct {
>>    SysBusDevice parent_obj;
>>    MemoryRegion iomem;
>>    char *name;
>>    /*
>>     * On a 64-bit wide bus we can have at most
>>     * 8 devices in 8-bit access mode.
>>     */
>>    MemoryRegion device[8];
>>    unsigned device_count;
>>    unsigned device_index_mask;
>>    /* Properties */
>>    unsigned bus_width;
>>    unsigned device_width;
>> } InterleaverDeviceState;
>>=20
>> static Property interleaver_properties[] =3D {
>>    DEFINE_PROP_LINK("device[0]", InterleaverDeviceState,
>>                     device[0],
>>                     TYPE_MEMORY_REGION, MemoryRegion *),
>>    ...
>>    DEFINE_PROP_LINK("device[7]", InterleaverDeviceState,
>>                     device[7],
>>                     TYPE_MEMORY_REGION, MemoryRegion *),
>>    DEFINE_PROP_END_OF_LIST(),
>> };
>>=20
>> Then previous to call InterleaverDevice.realize():
>>=20
>> In the board realize():
>>=20
>>=20
>>    for (i =3D 0; i < interleaved_devices; i++) {
>>        pflash[i] =3D create_pflash(...);
>>        ...
>>    }
>>=20
>>    ild =3D ... create InterleaverDevice ...
>>    for (i =3D 0; i < interleaved_devices; i++) {
>>        char *propname =3D g_strdup_printf("device[%u]", i);
>>=20
>>=20
>>        object_property_set_link(OBJECT(&ild->device[i]),
>>                                 OBJECT(pflash[i]),
>>                                 propname, &err);
>>        ...
>>    }
>>=20
>> Finally,
>>=20
>> static void interleaved_realize(DeviceState *dev, Error **errp)
>> {
>>    InterleaverDeviceState *s =3D INTERLEAVER_DEVICE(opaque);
>>=20
>>    s->device_count =3D s->bus_width / s->device_width;
>>    s->device_index_mask =3D ~(s->device_count - 1);
>>    ...
>> }
>>=20
>> static void interleaved_write(void *opaque, hwaddr offset,
>>                              uint64_t value, unsigned size)
>> {
>>    InterleaverDeviceState *s =3D INTERLEAVER_DEVICE(opaque);
>>    MemoryRegion *mr;
>>=20
>>    /*
>>     * Since we set .impl.max_access_size =3D device_width,
>>     * access_with_adjusted_size() always call this with
>>     * size =3D device_width.
>>     *
>>     * Adjust the address (offset).
>>     */
>>    offset >>=3D size;
>>    /* Access the N interleaved device */
>>    mr =3D s->device[offset & s->device_index_mask];
>>    memory_region_dispatch_write(mr, offset, &value, size,
>>                                 MEMTXATTRS_UNSPECIFIED);
>> }
>>=20
>> I'll try a PoC.
>=20
> So I have a PoC, but then realize I can not use the same flash dump...
>=20
> I need to deinterleave is. This is easily fixed with few lines of
> Python, then if I want to store/share the dump (aka 'backend storage') I
> have to re-interleave it.
>=20
> I wonder if it would be possible/easy to add a 'interleave' option to
> blockdev to be able to have 2 pflash devices sharing the same backend...
> Is it worthwhile? Kevin/Markus/Max any thought on this?

Hi Phil,

Sorry for the delay, I=E2=80=99ve been traveling.

I considered something like this approach and I think it could work. Ultimat=
ely, I opted not to go that route for a few reasons:
- duplicated CFI tables and other state waste (a small amount of) memory whe=
n the flash chips are the same (the usual case in my limited experience)
- it adds an extra layer of read/write calls plus recombining from/splitting=
 into the component parts
- duplicated timers firing to walk the programming/erasing state machine for=
ward for each chip
- the firmware or data stored in the chips is likely already interleaved nec=
essitating either splitting it up before use or adding functionality to a lo=
wer layer to split it (as you=E2=80=99ve suggested here)

None of the above seem like a big deal separately or together but I didn=E2=80=
=99t find the advantages of this approach to be sufficiently compelling to j=
ustify it. Namely, it allows using a heterogeneous set of flash chips to imp=
lement a logical device.

Nevertheless, if that=E2=80=99s the route you think is best, I have no objec=
tions.

Cheers,

Steve

>=20
> Thanks,
>=20
> Phil.
>=20
>>> In addition to commands being sent to all devices, guest firmware
>>> expects the status and CFI queries to be replicated for each device.
>>> (The one exception to the response replication is that each device gets
>>> to report its own status bit DQ7 while programming because its value
>>> depends on the value being programmed which will usually differ for each=

>>> device.)
>>>=20
>>> Testing is limited to 16-bit wide devices due to the current inability
>>> to override the properties set by `pflash_cfi02_register`, but multiple
>>> configurations are tested.
>>>=20
>>> Stop using global_qtest. Instead, package the qtest variable inside the
>>> FlashConfig structure.
>>>=20
>>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> hw/block/pflash_cfi02.c   | 270 +++++++++++++++------
>>> tests/pflash-cfi02-test.c | 476 ++++++++++++++++++++++++++++++--------
>>> 2 files changed, 576 insertions(+), 170 deletions(-)

