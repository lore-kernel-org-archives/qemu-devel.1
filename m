Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C011C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C372146E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C372146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfguJ-00020F-UO
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfgt8-0001Qf-Bz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfgt3-0002EF-HW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hfgsz-00029L-Bo; Tue, 25 Jun 2019 04:33:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78D91368E6;
 Tue, 25 Jun 2019 08:32:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD81919723;
 Tue, 25 Jun 2019 08:32:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C20E11386A0; Tue, 25 Jun 2019 10:32:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stephen Checkoway <scheckow@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
 <20190426162624.55977-5-stephen.checkoway@oberlin.edu>
 <6d2c9dcc-06f5-4eed-d779-b0c4d2b60182@amsat.org>
 <b7730260-bfb6-f2b1-7c01-9d7b6a10c71e@amsat.org>
 <F2BE0BC3-0C7D-42FB-8B3A-04FE2D0523E6@oberlin.edu>
Date: Tue, 25 Jun 2019 10:32:52 +0200
In-Reply-To: <F2BE0BC3-0C7D-42FB-8B3A-04FE2D0523E6@oberlin.edu> (Stephen
 Checkoway's message of "Mon, 24 Jun 2019 12:36:05 -0700")
Message-ID: <87d0j2jc97.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 25 Jun 2019 08:32:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stephen Checkoway <scheckow@oberlin.edu> writes:

>> On Jun 24, 2019, at 12:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>>=20
>>> On 6/22/19 2:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Stephen,
>>>=20
>>> This series haven't fall through the cracks, however it is taking me
>>> longer than expected to review it.
>>>=20
>>>> On 4/26/19 6:26 PM, Stephen Checkoway wrote:
>>>> It's common for multiple narrow flash chips to be hooked up in parallel
>>>> to support wider buses. For example, four 8-bit wide flash chips (x8)
>>>> may be combined in parallel to produce a 32-bit wide device. Similarly,
>>>> two 16-bit wide chips (x16) may be combined.
>>>>=20
>>>> This commit introduces `device-width` and `max-device-width` propertie=
s,
>>>> similar to pflash_cfi01, with the following meanings:
>>>> - `width`: The width of the logical, qemu device (same as before);
>>>> - `device-width`: The width of an individual flash chip, defaulting to
>>>>  `width`; and
>>>> - `max-device-width`: The maximum width of an individual flash chip,
>>>>  defaulting to `device-width`.
>>>>=20
>>>> Nothing needs to change to support reading such interleaved devices but
>>>> commands (e.g., erase and programming) must be sent to all devices at
>>>> the same time or else the various chips will be in different states.
>>>=20
>>> After some thoughts on this, I'd rather we model how hardware manage
>>> interleaved devices: do it at the bus level, and instanciate N devices
>>> in an interleaved config.
>>> I believe that would drastically reduce this device complexity, and we
>>> would match the real internal state machine.
>>> Also this could be reused by other parallel devices used in a such conf=
ig.
>>>=20
>>>> For example, a 4-byte wide logical device can be composed of four x8/x=
16
>>>> devices in x8 mode. That is, each device supports both x8 or x16 and
>>>> they're being used in the byte, rather than word, mode. This
>>>> configuration would have `width=3D4`, `device-width=3D1`, and
>>>> `max-device-width=3D2`.
>>>=20
>>>=20
>>> I'm thinking of this draft:
>>>=20
>>> FlashDevice # x8
>>>  MemoryRegionOps
>>>    .valid.max_access_size =3D 1
>>>=20
>>> FlashDevice # x16
>>>  MemoryRegionOps
>>>    .valid.min_access_size =3D 2
>>>    .valid.max_access_size =3D 2
>>>=20
>>> FlashDevice # x8/x16
>>>  MemoryRegionOps
>>>    .valid.min_access_size =3D 1
>>>    .valid.max_access_size =3D 2
>>>=20
>>> We might use .impl.min_access_size =3D 2 and consider all NOR flash usi=
ng
>>> 16-bit words internally.
>>>    .impl.max_access_size =3D 2 is implicit.
>>>=20
>>> So for you example we'd instanciate one:
>>>=20
>>> InterleaverDevice
>>>  Property
>>>    .bus_width =3D 4 # 4-byte wide logical device, `width=3D4`
>>>    .device_width =3D 1 # `device-width=3D1`
>>>  MemoryRegionOps
>>>    .valid.max_access_size =3D .bus_width # 4, set at realize()
>>>    .impl.max_access_size =3D .device_width # 1, set at realize()
>>>=20
>>> Then instanciate 4 pflash devices, and link them to the interleaver
>>> using object_property_set_link().
>>>=20
>>> typedef struct {
>>>    SysBusDevice parent_obj;
>>>    MemoryRegion iomem;
>>>    char *name;
>>>    /*
>>>     * On a 64-bit wide bus we can have at most
>>>     * 8 devices in 8-bit access mode.
>>>     */
>>>    MemoryRegion device[8];
>>>    unsigned device_count;
>>>    unsigned device_index_mask;
>>>    /* Properties */
>>>    unsigned bus_width;
>>>    unsigned device_width;
>>> } InterleaverDeviceState;
>>>=20
>>> static Property interleaver_properties[] =3D {
>>>    DEFINE_PROP_LINK("device[0]", InterleaverDeviceState,
>>>                     device[0],
>>>                     TYPE_MEMORY_REGION, MemoryRegion *),
>>>    ...
>>>    DEFINE_PROP_LINK("device[7]", InterleaverDeviceState,
>>>                     device[7],
>>>                     TYPE_MEMORY_REGION, MemoryRegion *),
>>>    DEFINE_PROP_END_OF_LIST(),
>>> };
>>>=20
>>> Then previous to call InterleaverDevice.realize():
>>>=20
>>> In the board realize():
>>>=20
>>>=20
>>>    for (i =3D 0; i < interleaved_devices; i++) {
>>>        pflash[i] =3D create_pflash(...);
>>>        ...
>>>    }
>>>=20
>>>    ild =3D ... create InterleaverDevice ...
>>>    for (i =3D 0; i < interleaved_devices; i++) {
>>>        char *propname =3D g_strdup_printf("device[%u]", i);
>>>=20
>>>=20
>>>        object_property_set_link(OBJECT(&ild->device[i]),
>>>                                 OBJECT(pflash[i]),
>>>                                 propname, &err);
>>>        ...
>>>    }
>>>=20
>>> Finally,
>>>=20
>>> static void interleaved_realize(DeviceState *dev, Error **errp)

I guess you mean interleaver_realize().

>>> {
>>>    InterleaverDeviceState *s =3D INTERLEAVER_DEVICE(opaque);
>>>=20
>>>    s->device_count =3D s->bus_width / s->device_width;
>>>    s->device_index_mask =3D ~(s->device_count - 1);
>>>    ...
>>> }
>>>=20
>>> static void interleaved_write(void *opaque, hwaddr offset,
>>>                              uint64_t value, unsigned size)

Likewise.

>>> {
>>>    InterleaverDeviceState *s =3D INTERLEAVER_DEVICE(opaque);
>>>    MemoryRegion *mr;
>>>=20
>>>    /*
>>>     * Since we set .impl.max_access_size =3D device_width,
>>>     * access_with_adjusted_size() always call this with
>>>     * size =3D device_width.
>>>     *
>>>     * Adjust the address (offset).
>>>     */
>>>    offset >>=3D size;
>>>    /* Access the N interleaved device */
>>>    mr =3D s->device[offset & s->device_index_mask];
>>>    memory_region_dispatch_write(mr, offset, &value, size,
>>>                                 MEMTXATTRS_UNSPECIFIED);
>>> }

What makes this idea interesting is the separation of concerns: we
capture the "interleave memory" aspect in its own device, which we can
then use with any kind of memory device (i.e. any device that provides
the interface the interleaver expects).  The memory devices remain
oblivious of the interleave aspect.

If we needed interleave for just one memory device model, baking it into
that device model would likely be simpler.  I think that's how we ended
up baking it into the cfi.pflash* devices.

>>>=20
>>> I'll try a PoC.
>>=20
>> So I have a PoC, but then realize I can not use the same flash dump...
>>=20
>> I need to deinterleave is. This is easily fixed with few lines of
>> Python, then if I want to store/share the dump (aka 'backend storage') I
>> have to re-interleave it.
>>=20
>> I wonder if it would be possible/easy to add a 'interleave' option to
>> blockdev to be able to have 2 pflash devices sharing the same backend...
>> Is it worthwhile? Kevin/Markus/Max any thought on this?

I'm not sure I understand completely, so let me restate the problem and
your solution idea.

"Flash memory is narrow, and needs to be interleaved to a more
convenient width" is an implementation detail.  For the most part, you
want to hide this detail, and view the combination of interleaver logic
+ narrow memory as a unit.  In particular, when connecting to a block
backend for persistence, you want to connect this whole unit, without
having to know anything about its internal interleaving.

You obviously have to connect the block backend to the interleaver.
But what do you connect to the memory devices then?

One idea is to have an interleaver block filter node.  Each memory
device gets connected to the block backend via a suitably configured
interleaver block filter node, which provides access to its own stripes.
Together, they cover the whole block backend.

Is this reasonably close to what you mean?

Here's another possible idea: factor persistence out of the memory
devices as well.

Our persistent memory devices are funny beasts: they pretend to be block
devices just to gain convenient means for implementing persistence.

Their access pattern is quite different from real block devices: they
read the complete image at initialization time, then only ever write.

Unless the device's unit of writes happens to be a multiple of the block
backend's block size, there's write amplification: we write the blocks
that contain the written range.  Due to the way the block layer works,
this can even result in a read-modify-write cycle (I think).

Now consider the following composite device:

           sysbus
             |
    +--------|--------+
    |        |	      |
    |    persister ------ block backend
    |        | 	      |
    |   interleaver   |
    |    /  ...  \    |
    | mem   ...   mem |
    +-----------------+

If we ignore the internal composition, we have a device similar to the
cfi.pflash*: it's a TYPE_SYS_BUS_DEVICE with a BlockBackend property.

Internally, the persister takes care of (1) initializing the contents,
and (2) persisting writes to the block backend.  The interleaver takes
care of routing reads and writes to the memory devices, adjusting width
as necessary.

Glossed over here: the guest interface.  I figure the interleaver and
the mem devices cooperate to support wide access.  I haven't thought
through the details.

Of course, device decomposition is not the only way to separate
concerns!  Perhaps factoring out persistence and interleaving into a
library for use by the device models that need it would be simpler.
Can't say without trying it.

> Hi Phil,
>
> Sorry for the delay, I=E2=80=99ve been traveling.
>
> I considered something like this approach and I think it could work. Ulti=
mately, I opted not to go that route for a few reasons:
> - duplicated CFI tables and other state waste (a small amount of) memory =
when the flash chips are the same (the usual case in my limited experience)

Is the state de-duplication 100% transparent to the guest?

> - it adds an extra layer of read/write calls plus recombining from/splitt=
ing into the component parts

I suspect the layer exists in a monolithic device model as well.  Going
to a composite device model then turns direct calls into indirect ones.
This is obviously not free.

I figure the persister could stay out of the read path.

> - duplicated timers firing to walk the programming/erasing state machine =
forward for each chip
> - the firmware or data stored in the chips is likely already interleaved =
necessitating either splitting it up before use or adding functionality to =
a lower layer to split it (as you=E2=80=99ve suggested here)
>
> None of the above seem like a big deal separately or together but I didn=
=E2=80=99t find the advantages of this approach to be sufficiently compelli=
ng to justify it. Namely, it allows using a heterogeneous set of flash chip=
s to implement a logical device.

As long as persistence and interleaving apply to flash memory only, we
can probably afford some emulation inefficiency.  Software engineering
concerns are likely more important.  Regardless, I agree with you that
the effort to separate things needs to be justified.

> Nevertheless, if that=E2=80=99s the route you think is best, I have no ob=
jections.

[...]

