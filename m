Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4276BC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46FB2133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin.edu header.i=@oberlin.edu header.b="ok9dhGTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46FB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoWT-0004w4-Rj
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hfoVb-0004Qr-0a
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hfoVY-0004gG-U7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:41:26 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
 id 1hfoVY-0004do-Jr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:41:24 -0400
Received: by mail-io1-xd43.google.com with SMTP id i10so2318038iol.13
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oberlin.edu; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Xpd26UVHmE6qN3Du0fSXP5CIh23lPCnpsuj8y4qlrRg=;
 b=ok9dhGTsGwndzlSkMmnM5oQCwGyO/XxedHstWoH21NUStrK+x0JnXxtaE4upsmWpfH
 ToWs0spigJxe+GocV4Cs6XF8ieblgo+gIzY3u2JAn41cPAQlWsadBf90IP6w6WdO4B4j
 ywIOj83G5zovlHU8974G1U2H4r0+mWgrFOCe29R0rIrK2X2O95C2Qzs5NenKHXx6YZGo
 mIMmXRME35Bi982yQFR9lgyhTd/Crpk1aqWUu8BR9fRYmzK77da4GovrYluonc4Opg9l
 XvZkhdAtfvQ27XRAH5YWXvbDxKx52FCRQuVJmahRC/GZ9jQia7IWLlzYZzls1aswCvDK
 CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Xpd26UVHmE6qN3Du0fSXP5CIh23lPCnpsuj8y4qlrRg=;
 b=TYEqET2uP3ygV+I5Y+gV/yfd3aM1mwTe7uoFsy2+oRbqvNsoyjGI3DU/IB83gmk6h/
 jW5zCSnOntCbjbVuF4s7I3M25i8Xkpv19LXWPh4KtxmxfczeqfBMwozB+bZwah/N4N3E
 eZpDhv4uT1eIpbc6xyJ92HGfJ5oZW4aydKEtJLofoDsWUrRE2a8GoZFuFq4hIhgz4dUO
 0uzAnevrm9SDCJT4skcAYsif6xURwfYqh5Nbc/ebhAy1zqPqEVEL/Gr7CySihJ9ri7GH
 SDsnA/g33PJyjOuIf+U401+YGYErgx1Ma1wtFuXuJZ6+tEw8TcIFDH5W6JpG4NfNjOrd
 8NoA==
X-Gm-Message-State: APjAAAV3i+47fSBWMgA3gihF2Ua8EkOVizYXgDCFxKLNx08PnBRume4+
 M5Sq8NquOdw5Cf79LwjzTeNGGw==
X-Google-Smtp-Source: APXvYqylAx1Z1L7KAaWztsjR+lZi5CzKOGP9/DQYS2wdqM1jWwr4sy43/NDM4ISCPbebpECquAczeg==
X-Received: by 2002:a05:6638:cf:: with SMTP id
 w15mr33465040jao.136.1561480881901; 
 Tue, 25 Jun 2019 09:41:21 -0700 (PDT)
Received: from ip-74-52.wireless.oberlin.edu (ip-74-52.wireless.oberlin.edu.
 [132.162.74.52])
 by smtp.gmail.com with ESMTPSA id r5sm12191269iom.42.2019.06.25.09.41.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 09:41:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <87d0j2jc97.fsf@dusky.pond.sub.org>
Date: Tue, 25 Jun 2019 12:41:19 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8F3B7A3-0903-4A86-BB50-026CA3A5EEF1@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
 <20190426162624.55977-5-stephen.checkoway@oberlin.edu>
 <6d2c9dcc-06f5-4eed-d779-b0c4d2b60182@amsat.org>
 <b7730260-bfb6-f2b1-7c01-9d7b6a10c71e@amsat.org>
 <F2BE0BC3-0C7D-42FB-8B3A-04FE2D0523E6@oberlin.edu>
 <87d0j2jc97.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 25, 2019, at 04:32, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Stephen Checkoway <scheckow@oberlin.edu> writes:
>=20
>>> On Jun 24, 2019, at 12:05, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>>>=20
>>>> On 6/22/19 2:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Hi Stephen,
>>>>=20
>>>> This series haven't fall through the cracks, however it is taking =
me
>>>> longer than expected to review it.
>>>>=20
>>>>> On 4/26/19 6:26 PM, Stephen Checkoway wrote:
>>>>> It's common for multiple narrow flash chips to be hooked up in =
parallel
>>>>> to support wider buses. For example, four 8-bit wide flash chips =
(x8)
>>>>> may be combined in parallel to produce a 32-bit wide device. =
Similarly,
>>>>> two 16-bit wide chips (x16) may be combined.
>>>>>=20
>>>>> This commit introduces `device-width` and `max-device-width` =
properties,
>>>>> similar to pflash_cfi01, with the following meanings:
>>>>> - `width`: The width of the logical, qemu device (same as before);
>>>>> - `device-width`: The width of an individual flash chip, =
defaulting to
>>>>> `width`; and
>>>>> - `max-device-width`: The maximum width of an individual flash =
chip,
>>>>> defaulting to `device-width`.
>>>>>=20
>>>>> Nothing needs to change to support reading such interleaved =
devices but
>>>>> commands (e.g., erase and programming) must be sent to all devices =
at
>>>>> the same time or else the various chips will be in different =
states.
>>>>=20
>>>> After some thoughts on this, I'd rather we model how hardware =
manage
>>>> interleaved devices: do it at the bus level, and instanciate N =
devices
>>>> in an interleaved config.
>>>> I believe that would drastically reduce this device complexity, and =
we
>>>> would match the real internal state machine.
>>>> Also this could be reused by other parallel devices used in a such =
config.
>>>>=20
>>>>> For example, a 4-byte wide logical device can be composed of four =
x8/x16
>>>>> devices in x8 mode. That is, each device supports both x8 or x16 =
and
>>>>> they're being used in the byte, rather than word, mode. This
>>>>> configuration would have `width=3D4`, `device-width=3D1`, and
>>>>> `max-device-width=3D2`.
>>>>=20
>>>>=20
>>>> I'm thinking of this draft:
>>>>=20
>>>> FlashDevice # x8
>>>> MemoryRegionOps
>>>>   .valid.max_access_size =3D 1
>>>>=20
>>>> FlashDevice # x16
>>>> MemoryRegionOps
>>>>   .valid.min_access_size =3D 2
>>>>   .valid.max_access_size =3D 2
>>>>=20
>>>> FlashDevice # x8/x16
>>>> MemoryRegionOps
>>>>   .valid.min_access_size =3D 1
>>>>   .valid.max_access_size =3D 2
>>>>=20
>>>> We might use .impl.min_access_size =3D 2 and consider all NOR flash =
using
>>>> 16-bit words internally.
>>>>   .impl.max_access_size =3D 2 is implicit.
>>>>=20
>>>> So for you example we'd instanciate one:
>>>>=20
>>>> InterleaverDevice
>>>> Property
>>>>   .bus_width =3D 4 # 4-byte wide logical device, `width=3D4`
>>>>   .device_width =3D 1 # `device-width=3D1`
>>>> MemoryRegionOps
>>>>   .valid.max_access_size =3D .bus_width # 4, set at realize()
>>>>   .impl.max_access_size =3D .device_width # 1, set at realize()
>>>>=20
>>>> Then instanciate 4 pflash devices, and link them to the interleaver
>>>> using object_property_set_link().
>>>>=20
>>>> typedef struct {
>>>>   SysBusDevice parent_obj;
>>>>   MemoryRegion iomem;
>>>>   char *name;
>>>>   /*
>>>>    * On a 64-bit wide bus we can have at most
>>>>    * 8 devices in 8-bit access mode.
>>>>    */
>>>>   MemoryRegion device[8];
>>>>   unsigned device_count;
>>>>   unsigned device_index_mask;
>>>>   /* Properties */
>>>>   unsigned bus_width;
>>>>   unsigned device_width;
>>>> } InterleaverDeviceState;
>>>>=20
>>>> static Property interleaver_properties[] =3D {
>>>>   DEFINE_PROP_LINK("device[0]", InterleaverDeviceState,
>>>>                    device[0],
>>>>                    TYPE_MEMORY_REGION, MemoryRegion *),
>>>>   ...
>>>>   DEFINE_PROP_LINK("device[7]", InterleaverDeviceState,
>>>>                    device[7],
>>>>                    TYPE_MEMORY_REGION, MemoryRegion *),
>>>>   DEFINE_PROP_END_OF_LIST(),
>>>> };
>>>>=20
>>>> Then previous to call InterleaverDevice.realize():
>>>>=20
>>>> In the board realize():
>>>>=20
>>>>=20
>>>>   for (i =3D 0; i < interleaved_devices; i++) {
>>>>       pflash[i] =3D create_pflash(...);
>>>>       ...
>>>>   }
>>>>=20
>>>>   ild =3D ... create InterleaverDevice ...
>>>>   for (i =3D 0; i < interleaved_devices; i++) {
>>>>       char *propname =3D g_strdup_printf("device[%u]", i);
>>>>=20
>>>>=20
>>>>       object_property_set_link(OBJECT(&ild->device[i]),
>>>>                                OBJECT(pflash[i]),
>>>>                                propname, &err);
>>>>       ...
>>>>   }
>>>>=20
>>>> Finally,
>>>>=20
>>>> static void interleaved_realize(DeviceState *dev, Error **errp)
>=20
> I guess you mean interleaver_realize().
>=20
>>>> {
>>>>   InterleaverDeviceState *s =3D INTERLEAVER_DEVICE(opaque);
>>>>=20
>>>>   s->device_count =3D s->bus_width / s->device_width;
>>>>   s->device_index_mask =3D ~(s->device_count - 1);
>>>>   ...
>>>> }
>>>>=20
>>>> static void interleaved_write(void *opaque, hwaddr offset,
>>>>                             uint64_t value, unsigned size)
>=20
> Likewise.
>=20
>>>> {
>>>>   InterleaverDeviceState *s =3D INTERLEAVER_DEVICE(opaque);
>>>>   MemoryRegion *mr;
>>>>=20
>>>>   /*
>>>>    * Since we set .impl.max_access_size =3D device_width,
>>>>    * access_with_adjusted_size() always call this with
>>>>    * size =3D device_width.
>>>>    *
>>>>    * Adjust the address (offset).
>>>>    */
>>>>   offset >>=3D size;
>>>>   /* Access the N interleaved device */
>>>>   mr =3D s->device[offset & s->device_index_mask];
>>>>   memory_region_dispatch_write(mr, offset, &value, size,
>>>>                                MEMTXATTRS_UNSPECIFIED);
>>>> }
>=20
> What makes this idea interesting is the separation of concerns: we
> capture the "interleave memory" aspect in its own device, which we can
> then use with any kind of memory device (i.e. any device that provides
> the interface the interleaver expects).  The memory devices remain
> oblivious of the interleave aspect.
>=20
> If we needed interleave for just one memory device model, baking it =
into
> that device model would likely be simpler.  I think that's how we =
ended
> up baking it into the cfi.pflash* devices.
>=20
>>>>=20
>>>> I'll try a PoC.
>>>=20
>>> So I have a PoC, but then realize I can not use the same flash =
dump...
>>>=20
>>> I need to deinterleave is. This is easily fixed with few lines of
>>> Python, then if I want to store/share the dump (aka 'backend =
storage') I
>>> have to re-interleave it.
>>>=20
>>> I wonder if it would be possible/easy to add a 'interleave' option =
to
>>> blockdev to be able to have 2 pflash devices sharing the same =
backend...
>>> Is it worthwhile? Kevin/Markus/Max any thought on this?
>=20
> I'm not sure I understand completely, so let me restate the problem =
and
> your solution idea.
>=20
> "Flash memory is narrow, and needs to be interleaved to a more
> convenient width" is an implementation detail.  For the most part, you
> want to hide this detail, and view the combination of interleaver =
logic
> + narrow memory as a unit.  In particular, when connecting to a block
> backend for persistence, you want to connect this whole unit, without
> having to know anything about its internal interleaving.
>=20
> You obviously have to connect the block backend to the interleaver.
> But what do you connect to the memory devices then?
>=20
> One idea is to have an interleaver block filter node.  Each memory
> device gets connected to the block backend via a suitably configured
> interleaver block filter node, which provides access to its own =
stripes.
> Together, they cover the whole block backend.
>=20
> Is this reasonably close to what you mean?
>=20
> Here's another possible idea: factor persistence out of the memory
> devices as well.
>=20
> Our persistent memory devices are funny beasts: they pretend to be =
block
> devices just to gain convenient means for implementing persistence.
>=20
> Their access pattern is quite different from real block devices: they
> read the complete image at initialization time, then only ever write.
>=20
> Unless the device's unit of writes happens to be a multiple of the =
block
> backend's block size, there's write amplification: we write the blocks
> that contain the written range.  Due to the way the block layer works,
> this can even result in a read-modify-write cycle (I think).
>=20
> Now consider the following composite device:
>=20
>           sysbus
>             |
>    +--------|--------+
>    |        |	      |
>    |    persister ------ block backend
>    |        | 	      |
>    |   interleaver   |
>    |    /  ...  \    |
>    | mem   ...   mem |
>    +-----------------+
>=20
> If we ignore the internal composition, we have a device similar to the
> cfi.pflash*: it's a TYPE_SYS_BUS_DEVICE with a BlockBackend property.
>=20
> Internally, the persister takes care of (1) initializing the contents,
> and (2) persisting writes to the block backend.  The interleaver takes
> care of routing reads and writes to the memory devices, adjusting =
width
> as necessary.
>=20
> Glossed over here: the guest interface.  I figure the interleaver and
> the mem devices cooperate to support wide access.  I haven't thought
> through the details.
>=20
> Of course, device decomposition is not the only way to separate
> concerns!  Perhaps factoring out persistence and interleaving into a
> library for use by the device models that need it would be simpler.
> Can't say without trying it.
>=20
>> Hi Phil,
>>=20
>> Sorry for the delay, I=E2=80=99ve been traveling.
>>=20
>> I considered something like this approach and I think it could work. =
Ultimately, I opted not to go that route for a few reasons:
>> - duplicated CFI tables and other state waste (a small amount of) =
memory when the flash chips are the same (the usual case in my limited =
experience)
>=20
> Is the state de-duplication 100% transparent to the guest?

It isn't. I think there are four basic cases where it wouldn't be =
transparent, but I don't think any are useful to support:

1. Two (or more) models of flash chips can be interleaved. These would =
have different entries in the common flash interface (CFI) tables that =
the guests could query. Probably the most important values in the tables =
are sector sizes and the erase blocks. I can't imagine trying to =
construct a system where those differed. But there are also IDs that can =
be read out.

2. Each chip has a state machine driven by read and write cycles and =
guests could send different commands to different chips. I can't think =
of a use case for erasing a sector of one chip but not another, for =
example. In principle it could be done, but it would make for some =
pretty terrible guest logic.

3. Physical differences in the chips could lead to differing times for =
operations like programming (which we don't currently model) and erasing =
(which we do). Guests could detect one of the chips had finished erasing =
a sector before another. I'm not sure what use that could serve.

4. Sort of a combination of 1 and 3: chips with different timings (e.g., =
one that erases fast and one that erases slowly) could be used and the =
difference could be measured.

I don't find any of those compelling enough to add the complexity to =
support them (plus pay the minor costs of duplicating state).

> - it adds an extra layer of read/write calls plus recombining =
from/splitting into the component parts
>=20
> I suspect the layer exists in a monolithic device model as well.  =
Going
> to a composite device model then turns direct calls into indirect =
ones.
> This is obviously not free.

I'm not sure I follow this. My implementation for read is essentially =
two lines (plus some for tracing that should be simplified but I haven't =
looked much into QEMU's trace functionality). =
https://github.com/stevecheckoway/qemu/blob/pflash02/hw/block/pflash_cfi02=
.c#L253

uint8_t *p =3D (uint8_t *)pfl->storage + offset;
uint64_t ret =3D pfl->be ? ldn_be_p(p, width) : ldn_le_p(p, width);

With an extra interleave layer, I'd imagine it would need to call other =
read functions at the narrow width on the linked devices and then =
combine the result.


--=20
Stephen Checkoway






