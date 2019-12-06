Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B43C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B2D20659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHICtHHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B2D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEWR-0000pr-7e
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idEKI-0005BK-GZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idEKE-0003uw-B9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idEKA-0003qE-So
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KigS9ytz+53Vq0YjcSEuarVrnxrytWJ60c9MnnyKdTA=;
 b=SHICtHHRhcd3NThT3XGwIcokNfsjBaQPiTHHfVoh5JD4rdAWGCAHBkNeMQ6cebIfi8bCps
 GVX+uOynW9ef8WA+xX8vi6XUpzxtwWgG6E7jCMHbzJ0j7B6KmyXqeY42N06b8icGyqdDHY
 vt7yGMy7s2bhShMvL4WdQ6Q7xHpAumc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-dZqiRk2zOOu1Y7gCp3iB5g-1; Fri, 06 Dec 2019 05:08:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB633107ACC7;
 Fri,  6 Dec 2019 10:08:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97E9F10013D9;
 Fri,  6 Dec 2019 10:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2AB8C1138606; Fri,  6 Dec 2019 11:08:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <87blsndnxx.fsf@dusky.pond.sub.org>
 <97dbf761-fae4-ab79-c7b0-4aae0b91dcb6@siemens.com>
Date: Fri, 06 Dec 2019 11:08:25 +0100
In-Reply-To: <97dbf761-fae4-ab79-c7b0-4aae0b91dcb6@siemens.com> (Jan Kiszka's
 message of "Thu, 5 Dec 2019 22:29:32 +0100")
Message-ID: <877e39ix5y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: dZqiRk2zOOu1Y7gCp3iB5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 05.12.19 12:14, Markus Armbruster wrote:
>> This has been on the list for more than three weeks already.  I
>> apologize for the delay.
>
> No problem! Your feedback is highly appreciated.
>
>>=20
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This imports the ivshmem v2 specification draft from Jailhouse. Its
>>> final home is to be decided, this shall just simplify the review proces=
s
>>> at this stage.
>>>
>>> Note that specifically the Features register (offset 08h) is still unde=
r
>>> consideration. In particular, its bit 0 seems useless now as its benefi=
t
>>> to guests, specifically when they want to be portable, is close to zero=
.
>>> Maybe the register should still be kept, with all bits RsvdZ, for easie=
r
>>> extensibility.
>>>
>>> The rest appears now rather mature and reasonably implementable, as
>>> proven also by a version for Jailhouse.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  docs/specs/ivshmem-2-device-spec.md | 333 ++++++++++++++++++++++++++++=
++++++++
>>>  1 file changed, 333 insertions(+)
>>>  create mode 100644 docs/specs/ivshmem-2-device-spec.md
>>>
>>> diff --git a/docs/specs/ivshmem-2-device-spec.md b/docs/specs/ivshmem-2=
-device-spec.md
>>> new file mode 100644
>>> index 0000000000..98cfde585a
>>> --- /dev/null
>>> +++ b/docs/specs/ivshmem-2-device-spec.md
>>> @@ -0,0 +1,333 @@
>>> +IVSHMEM Device Specification
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>> +
>>> +** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE SPECIFIC=
ATION! **
>>> +
>>> +The Inter-VM Shared Memory device provides the following features to i=
ts users:
>>> +
>>> +- Interconnection between up to 65536 peers
>>> +
>>> +- Multi-purpose shared memory region
>>> +
>>> +    - common read/writable section
>>> +
>>> +    - unidirectional sections that are read/writable for one peer and =
only
>>> +      readable for the others
>>> +
>>> +    - section with peer states
>>> +
>>> +- Event signaling via interrupt to remote sides
>>> +
>>> +- Support for life-cycle management via state value exchange and inter=
rupt
>>> +  notification on changes, backed by a shared memory section
>>> +
>>> +- Free choice of protocol to be used on top
>>> +
>>> +- Protocol type declaration
>>> +
>>> +- Unprivileged access to memory-mapped or I/O registers feasible
>>> +
>>> +- Discoverable and configurable via standard PCI mechanisms
>>=20
>> Stating requirements is much appreciated.  Design rationale would be
>> even better :)
>
> The idea is to avoid having to model also a platform device with
> platform discovery mechanism. Based on our experiences with providing a
> generic virtual PCI host controller, such a complication of
> specification and implementation is simply not needed.

Work that into the document please.

>> As pointed out many times, shared memory is not a solution to any
>> communication problem, it's merely a building block for building such
>> solutions: you invariably have to layer some protocol on top.  In your
>> KVM Forum talk, you mention layering virtio on top.  Makes sense to me.
>> But why does *this* virtio transport have to be an independent device?
>> Other transports aren't.
>
> This device is not only a virtio transport. As you correctly point out,
> it is a foundation for communication, not the full solution by itself.
>
> Its goal is to define the minimal piece that a hypervisor has to provide
> to its guests in order to enable them building full communication
> solutions of their preferred flavor on top. It does not want to deal
> with those details, may they be virtio, may they be something much
> simpler, much older or much more sophisticated (or complicated). All
> that shall not be the business of a hypervisor.

Likewise.

>> Now let me indulge in spec nitpicking :)
>>=20
>>> +
>>> +
>>> +Hypervisor Model
>>> +----------------
>>> +
>>> +In order to provide a consistent link between peers, all connected ins=
tances of
>>> +IVSHMEM devices need to be configured, created and run by the hypervis=
or
>>> +according to the following requirements:
>>> +
>>> +- The instances of the device need to be accessible via PCI programmin=
g
>>> +  interfaces on all sides.
>>=20
>> What does that mean?
>
> "From a guest point of view, this shall be a PCI device."

Clearer.

>>> +
>>> +- The read/write shared memory section has to be of the same size for =
all
>>> +  peers and, if non-zero, has to reflect the same memory content for t=
hem.
>>=20
>> Isn't "same memory content" redundant with "shared memory"?
>
> Probably.
>
>>=20
>>> +
>>> +- If output sections are present (non-zero section size), there must b=
e one
>>> +  reserved for each peer with exclusive write access. All output secti=
ons
>>> +  must have the same size and must be readable for all peers. They hav=
e to
>>> +  reflect the same memory content for all peers.
>>=20
>> Are these the "unidirectional sections" mentioned previously?
>
> Yep. The terms have some history, maybe worth consolidating them.

Yes, please.  Consistent terminology helps.

>>> +
>>> +- The State Table must have the same size for all peers, must be large=
 enough to
>>> +  hold a state values of all peers, and must be read-only for the user=
.
>>=20
>> "the state values", I guess.
>
> Yes.
>
>>=20
>>> +
>>> +- State register changes (explicit writes, peer resets) have to be pro=
pagated
>>> +  to the other peers by updating the corresponding State Table entry a=
nd issuing
>>> +  an interrupt to all other peers if they enabled reception.
>>> +
>>> +- Interrupts events triggered by a peer have to be delivered to the ta=
rget peer,
>>> +  provided the receiving side is valid and has enabled the reception.
>>> +
>>> +- All peers must have the same interrupt delivery features available, =
i.e. MSI-X
>>> +  with the same maximum number of vectors on platforms supporting this
>>> +  mechanism, otherwise INTx with one vector.
>>=20
>> Use case for legacy INTx?
>
> Platforms without support for MSI-X injection. Quite a few current ARM
> platforms still fall into this category, but they get less, indeed.
>
>>=20
>> For what it's worth, we removed INTx support from ivshmem v1 in rev 1,
>> QEMU 2.6.
>
> Maybe worth to look into this again, specifically when we are done with
> ITS emulation on the Jailhouse side. Maybe it will be the same story as
> with our virtual PCI host controller there: After we had to add PCI
> logic for devices with real controller anyway, the virtual one was
> literally for free (not a single line of code added).

I'd like to encourage you to consider this once more.  Dropping legacy
INTx support will simplify this document quite a bit.

>>> +
>>> +
>>> +Guest-side Programming Model
>>> +----------------------------
>>> +
>>> +An IVSHMEM device appears as a PCI device to its users. Unless otherwi=
se noted,
>>> +it conforms to the PCI Local Bus Specification, Revision 3.0 As such, =
it is
>>=20
>> Uh, is there anything in it that does *not* conform to this spec?
>
> See below.

I'm not opposed to reasoned deviations.  I'd like to see the "unless
otherwise noted" promise honored with explicit notes, though.

>>=20
>>> +discoverable via the PCI configuration space and provides a number of =
standard
>>> +and custom PCI configuration registers.
>>> +
>>> +### Shared Memory Region Layout
>>> +
>>> +The shared memory region is divided into several sections.
>>> +
>>> +    +-----------------------------+   -
>>> +    |                             |   :
>>> +    | Output Section for peer n-1 |   : Output Section Size
>>> +    |     (n =3D Maximum Peers)     |   :
>>> +    +-----------------------------+   -
>>> +    :                             :
>>> +    :                             :
>>> +    :                             :
>>> +    +-----------------------------+   -
>>> +    |                             |   :
>>> +    |  Output Section for peer 1  |   : Output Section Size
>>> +    |                             |   :
>>> +    +-----------------------------+   -
>>> +    |                             |   :
>>> +    |  Output Section for peer 0  |   : Output Section Size
>>> +    |                             |   :
>>> +    +-----------------------------+   -
>>> +    |                             |   :
>>> +    |     Read/Write Section      |   : R/W Section Size
>>> +    |                             |   :
>>> +    +-----------------------------+   -
>>> +    |                             |   :
>>> +    |         State Table         |   : State Table Size
>>> +    |                             |   :
>>> +    +-----------------------------+   <-- Shared memory base address
>>> +
>>> +The first section consists of the mandatory State Table. Its size is d=
efined by
>>> +the State Table Size register and cannot be zero. This section is read=
-only for
>>> +all peers.
>>> +
>>> +The second section consists of shared memory that is read/writable for=
 all
>>> +peers. Its size is defined by the R/W Section Size register. A size of=
 zero is
>>> +permitted.
>>> +
>>> +The third and following sections are unidirectional output sections, o=
ne for
>>> +each peer. Their sizes are all identical. The size of a single output =
section is
>>> +defined by the Output Section Size register. An output section is read=
/writable
>>> +for the corresponding peer and read-only for all other peers. E.g., on=
ly the
>>> +peer with ID 3 can write to the fourths output section, but all peers =
can read
>>> +from this section.
>>> +
>>> +All sizes have to be rounded up to multiples of a mappable page in ord=
er to
>>> +allow access control according to the section restrictions.
>>> +
>>> +### Configuration Space Registers
>>> +
>>> +#### Header Registers
>>> +
>>> +| Offset | Register               | Content                           =
                   |
>>> +|-------:|:-----------------------|:----------------------------------=
-------------------|
>>> +|    00h | Vendor ID              | 1AF4h                             =
                   |
>>> +|    02h | Device ID              | 1110h                             =
                   |
>>=20
>> Same as ivshmem v1.  Revision ID (offset 08h) disambiguates.
>
> Will become 110Ah (Siemens) / 4106h (freshly reserved for a new ivshmem)
> in the next round.

Better.

>>> +|    04h | Command Register       | 0000h on reset, implementing bits =
1, 2, 10           |
>>=20
>> What does "implementing bits ..." mean?
>
> Ignore writes to the other bits.
>
>>=20
>>> +|    06h | Status Register        | 0010h, static value (bit 3 not imp=
lemented)          |
>>=20
>> What does "bit 3 not implemented" mean?
>
> Will stay at 0, no "pending INTx" information available.
>
>>=20
>>> +|    08h | Revision ID            | 02h                               =
                   |
>>=20
>> ivshmem v1 is rev 0 before QEMU 2.6, rev 1 since.  Rev 1 is
>> backward-compatible to rev 0 for guest software.  Is rev 2 intended to
>> be backward-compatible, too?
>>=20
>> You should probably explan how your v2 relates to v1 in more detail,
>> possibly in its own top-level section.
>
> With that new, separate device IT, this register will start at 0 in the
> next revision of this document.

By making the device clearly different that way, you don't need to
discuss differences in detail.  In particular, backward compatibility
can be treated as non-issue.  But I'd still like to see a higher level
discussion of the differences.  In your KVM Forum presentation, you
covered v1's deficits (slide 5), and v2's key differences (slide 6).

docs/specs/ivshmem-spec.txt documents numerous v1 deficits.  Referring
to that document might be helpful.

>>> +|    09h | Class Code, Interface  | Protocol Type bits 0-7, see [Proto=
cols](#Protocols)  |
>>> +|    0Ah | Class Code, Sub-Class  | Protocol Type bits 8-15, see [Prot=
ocols](#Protocols) |
>>> +|    0Bh | Class Code, Base Class | FFh                               =
                   |
>>=20
>> FFh means "device does not fit any defined class."  For what it's worth,
>> ivshmem v1 uses 05h "Memory Controller", with sub-class and interface
>> 00h "RAM Controller".
>
> I know. But using that scheme would needlessly wast 8 bits for protocol
> ID encoding. In turn, having the protocol encoded into the class code
> helps a lot with automatic driver probing on Linux e.g.

Less of an issue (or none-issue?) now that you use a fresh Vendor ID /
Device ID pair.

>>=20
>>> +|    0Eh | Header Type            | 00h                               =
                   |
>>> +|    10h | BAR 0                  | MMIO or I/O register region       =
                   |
>>=20
>> Use case for I/O?
>
> Faster VM exit handling. But, granted, that was not exploited so far in
> existing implementations. I just wanted to keep that door open.

Write that down, please :)

*Why* things are designed a certain way is often as useful to know as
the actual design.

>> For what it's worth, ivshmem v1 never supported I/O.
>>=20
>>> +|    14h | BAR 1                  | MSI-X region                      =
                   |
>>> +|    18h | BAR 2 (with BAR 3)     | optional: 64-bit shared memory reg=
ion                |
>>=20
>> What does "(with BAR 3)" mean?
>
> 64-bit resource regions always use two BARs, see PCI spec.

Right.  Perhaps we can convey that more clearly to readers who forgot
(or never knew) this PCI detail, but I admit I'm drawing blanks right
now.

>>> +|    2Ch | Subsystem Vendor ID    | same as Vendor ID, or provider-spe=
cific value        |
>>> +|    2Eh | Subsystem ID           | same as Device ID, or provider-spe=
cific value        |
>>=20
>> ivshmem v1 leaves these blank.
>
> Same story as with virtio: This should encode the ID of the provider
> (hypervisor), also for the case we ever face deviating implementations,
> due to quirks of specification vagueness.

This intended use makes sense.  Write it down, please.

>>> +|    34h | Capability Pointer     | First capability                  =
                   |
>>> +|    3Eh | Interrupt Pin          | 01h-04h, must be 00h if MSI-X is a=
vailable           |
>>=20
>> "If MSI-X is available"?
>>=20
>> A PCIe device always provides MSI-X, and may additionally provide legacy
>> INTx.  A conventional PCI device may provide either or both.  In any
>> case, the Interrupt Pin register is zero when legacy INTx is not
>> provided,
>
> All known. This shall just "encourage" to provide more powerfull MSI-x
> when the platform provides that for other devices anyway. Only if the
> platform this device is injected to does not have such support, INTx
> shall be there.

In case you keep legacy INTx support: I'd phrase this as a (strong)
recommendation, not as (vague) specification.

>>> +
>>> +If BAR 2 is not present, the shared memory region is not relocatable b=
y the
>>> +user. In that case, the hypervisor has to implement the Base Address r=
egister in
>>> +the vendor-specific capability.
>>> +
>>> +Other header registers may not be implemented. If not implemented, the=
y return 0
>>> +on read and ignore write accesses.
>>=20
>> Is this an example of where the device does not conform to the PCI Local
>> Bus Specification?
>
> - INTx is an edge interrupt
> - there is no INTx status bit
> - there is no pending MSI-X bitmap

Two more reasons to ditch legacy INTx.

For each of these, I'd like to see an clear notice of deviation from the
PCI spec, and rationale (why are deviating).

>>> +
>>> +#### Vendor Specific Capability (ID 09h)
>>> +
>>> +| Offset | Register            | Content                              =
          |
>>> +|-------:|:--------------------|:-------------------------------------=
----------|
>>> +|    00h | ID                  | 09h                                  =
          |
>>> +|    01h | Next Capability     | Pointer to next capability or 00h    =
          |
>>> +|    02h | Length              | 18h or 20h                           =
          |
>>> +|    03h | Privileged Control  | Bit 0 (read/write): one-shot interrup=
t mode    |
>>> +|        |                     | Bits 1-7: RsvdZ                      =
          |
>>=20
>> Please define RsvdZ somewhere, or use plainer language.
>
> OK.
>
>>=20
>>> +|    04h | State Table Size    | 32-bit size of read-only State Table =
          |
>>> +|    08h | R/W Section Size    | 64-bit size of common read/write sect=
ion       |
>>> +|    10h | Output Section Size | 64-bit size of unidirectional output =
sections  |
>>> +|    18h | Base Address        | optional: 64-bit base address of shar=
ed memory |
>>=20
>> Length is 20h when Base Adress is present, else 18h.  Worth spelling
>> that out?
>
> Sure.
>
>>=20
>>> +
>>> +All registers are read-only, except for bit 0 of the Privileged Contro=
l
>>> +register.
>>=20
>> Well, the other bits of that register are writable, they're just
>> ignored.
>>=20
>> For what it's worth, existing ivshmem-spec.txt uses the terms read-only,
>> write-only, read/write and reserved bits rigorously: "Software should
>> only access the registers as specified [...]  Reserved bits should be
>> ignored on read, and preserved on write."
>
> Will change.

Could also help with documenting Command and Status register more
clearly.

>>> +
>>> +When bit 0 in the Privileged Control register is set to 1, the device =
clears
>>> +bit 0 in the Interrupt Control register on each interrupt delivery. Th=
is enables
>>> +automatic interrupt throttling when re-enabling shall be performed by =
a
>>> +scheduled unprivileged instance on the user side.
>>> +
>>> +If an IVSHMEM device does not support a relocatable shared memory regi=
on, BAR 2
>>> +must not be implemented by the provider. Instead, the Base Address reg=
ister has
>>> +to be implemented to report the location of the shared memory region i=
n the
>>> +user's address space.
>>=20
>> Rationale for not wanting to support relocatable shared memory?
>
> Locked-down second stage page tables during runtime. We can even
> check-sum their content periodically when we do not allow guest to
> influence the shared memory guest location. Relevant for safety and
> possibly also security scenarios.

Write that down, please.

>>> +
>>> +A non-existing shared memory section has to report zero in its Section=
 Size
>>> +register.
>>=20
>> This vendor-specific capability must always be present, I presume.
>> Worth spelling out.
>
> Ack.
>
>>=20
>>> +
>>> +#### MSI-X Capability (ID 11h)
>>> +
>>> +On platforms supporting MSI-X, IVSHMEM has to provide interrupt delive=
ry via
>>> +this mechanism. In that case, the legacy INTx delivery mechanism is no=
t
>>> +available, and the Interrupt Pin configuration register returns 0.
>>=20
>> I'm confused.  Does that mean the device shall support either MSI-X or
>> legacy INTx, but never both?
>
> Correct, see above. There is no point in requesting both and requiring
> the hypervisor to deal with the guest switching between things during
> runtime.

The PCI spec is cool with devices that only implement one of the two.
But shipping one kind of device come in two such different flavours
while still sharing the same Vendor ID, Device ID is something that
would get a hardware vendor yelled at, and rightfully so.

Now, this isn't physical hardware.  And you might have a high tolerance
for getting yelled at.

Still, yet another reason to ditch legacy INTx.

If not, I'd advocate for a more prominent "caveat emptor" sticker on
this particular, unusual feature.

>>> +
>>> +The IVSHMEM device has no notion of pending interrupts. Therefore, rea=
ding from
>>> +the MSI-X Pending Bit Array will always return 0.
>>=20
>> I guess this means a polling mode of operation is not possible.
>> Correct?
>
> Of course, polling remains possible, but the guest driver should rather
> obtain the interrupt-triggering state information from the much faster
> shared memory. There is simply no value in also mirroring that into
> interrupt registers for this particular device.

I see.  Mirroring it just for spec compliance may not be worthwhile.
Please explain this in this document.

>>> +
>>> +The corresponding MSI-X MMIO region is configured via BAR 1.
>>> +
>>> +The MSI-X table size reported by the MSI-X capability structure is ide=
ntical for
>>> +all peers.
>>> +
>>> +### Register Region
>>> +
>>> +The register region may be implemented as MMIO or I/O.
>>> +
>>> +When implementing it as MMIO, the hypervisor has to ensure that the re=
gister
>>> +region can be mapped as a single page into the address space of the us=
er. Write
>>=20
>> "can be mapped as a single page" depends on the host system, not the
>> device.
>
> When host system provides this device, it must ensure that the MMIO
> register region can be mapped by its guest as one page, without
> potential overlap with other resources.
>
>>=20
>> For what it's worth, ivshmem v1 fixes the size of BAR0 to 256 bytes.
>> Any particular reason to keep its size so loosely specified in v2?
>
> UIO. The v1 device can't be handed out to untrusted UIO applications
> without intercepting the MMIO writes in the guest kernel in order to
> restrict them to the valid range. This device supports that.

Sad.  BARs changing size while Vendor ID, Device ID stays the same is
unusual, but the other BARs *have* be that way, so this one hardly makes
it more unusual.

Please write this down.

>>> +accesses to MMIO region offsets that are not backed by registers have =
to be
>>> +ignored, read accesses have to return 0. This enables the user to hand=
 out the
>>> +complete region, along with the shared memory, to an unprivileged inst=
ance.
>>> +
>>> +The region location in the user's physical address space is configured=
 via BAR
>>> +0. The following table visualizes the region layout:
>>> +
>>> +| Offset | Register                                                   =
         |
>>> +|-------:|:-----------------------------------------------------------=
---------|
>>> +|    00h | ID                                                         =
         |
>>> +|    04h | Maximum Peers                                              =
         |
>>> +|    08h | Features                                                   =
         |
>>> +|    0Ch | Interrupt Control                                          =
         |
>>> +|    10h | Doorbell                                                   =
         |
>>> +|    14h | State                                                      =
         |
>>> +
>>> +All registers support only aligned 32-bit accesses.
>>=20
>> Definitely not backwards compatible to rev 1.  I figure that means v2
>> should use a different Vendor ID / Device ID, not just bump the Revsion
>> ID.
>
> Yep, see above.
>
>>=20
>> No interrupt status register?
>
> Yep, see above.

Where?  Is it "guest driver should rather obtain the
interrupt-triggering state information from the much faster shared
memory"?

>>=20
>>> +
>>> +#### ID Register (Offset 00h)
>>> +
>>> +Read-only register that reports the ID of the local device. It is uniq=
ue for all
>>> +of the connected devices and remains unchanged over their lifetime.
>>> +
>>> +#### Maximum Peers Register (Offset 04h)
>>> +
>>> +Read-only register that reports the maximum number of possible peers (=
including
>>> +the local one). The supported range is between 2 and 65536 and remains=
 constant
>>> +over the lifetime of all peers.
>>=20
>> Value 1 would be boring, but is it really impossible?
>
> Likely not, didn't think about it so far. Would we gain anything by
> permitting this?

Running a lone guest with an ivshmem device wouldn't be out of spec.

Never stipulate an error you don't want to detect and handle :)

>>> +
>>> +#### Features Register (Offset 08h)
>>> +
>>> +Read-only register that reports features of the local device or the co=
nnected
>>> +peers. Its content remains constant over the lifetime of all peers.
>>> +
>>> +| Bits | Content                                                      =
         |
>>> +|-----:|:-------------------------------------------------------------=
---------|
>>> +|    0 | 1: Synchronized shared memory base address                   =
         |
>>> +| 1-31 | RsvdZ                                                        =
         |
>>> +
>>> +If "synchronized shared memory base address" is reported (bit 0 is set=
), the
>>> +shared memory region is mapped at the same address into the user addre=
ss spaces
>>> +of all connected peers. Thus, peers can use physical addresses as poin=
ters when
>>> +exchanging information via the shared memory. This feature flag is nev=
er set
>>> +when the shared memory region is relocatable via BAR 2.
>>> +
>>> +#### Interrupt Control Register (Offset 0Ch)
>>> +
>>> +This read/write register controls the generation of interrupts wheneve=
r a peer
>>> +writes to the Doorbell register or changes its state.
>>> +
>>> +| Bits | Content                                                      =
         |
>>> +|-----:|:-------------------------------------------------------------=
---------|
>>> +|    0 | 1: Enable interrupt generation                               =
         |
>>> +| 1-31 | RsvdZ                                                        =
         |
>>> +
>>> +Note that bit 0 is reset to 0 on interrupt delivery if one-shot interr=
upt mode
>>> +is enabled in the Enhanced Features register.
>>> +
>>> +The value of this register after device reset is 0.
>>=20
>> I presume this applies only to legacy INTx.  Correct?
>
> Nope, this applies to both INTx and MSI-x. It's a building block for UIO
> devices, see one-shot interrupt mode. In that mode, bit 0 will be
> cleared by the device after each interrupt delivery, avoiding that the
> guest UIO driver needs to do that via a vmexit.

How does this play with MSI-X per-vector masking?

>> ivshmem v1 calls this Interrupt Mask.
>
> As "set" does not mean "masked", I chose "enable" here.

I'm confused.  Can you explain the difference?

>>> +
>>> +#### Doorbell Register (Offset 10h)
>>> +
>>> +Write-only register that triggers an interrupt vector in the target de=
vice if it
>>> +is enabled there.
>>> +
>>> +| Bits  | Content                                                     =
         |
>>> +|------:|:------------------------------------------------------------=
---------|
>>> +|  0-15 | Vector number                                               =
         |
>>> +| 16-31 | Target ID                                                   =
         |
>>> +
>>> +Writing a vector number that is not enabled by the target has no effec=
t. The
>>> +peers can derive the number of available vectors from their own device
>>> +capabilities and are expected to define or negotiate the used ones via=
 the
>>> +selected protocol.
>>=20
>> That's because all peers use the same number of vectors.  Worth spelling=
 out?
>
> I thought I did that somewhere. Will check.
>
>>=20
>>> +
>>> +Addressing a non-existing or inactive target has no effect. Peers can =
identify
>>> +active targets via the State Table.
>>> +
>>> +The behavior on reading from this register is undefined.
>>> +
>>> +#### State Register (Offset 14h)
>>> +
>>> +Read/write register that defines the state of the local device. Writin=
g to this
>>> +register sets the state and triggers interrupt vector 0 on the remote =
device if
>>=20
>> "the remote device"?  Do you mean all peers?
>
> Historic singular (an earlier revision only supported 2 peers). Will fix.
>
>>=20
>> "interrupt vector 0" assumes MSI-X.  With legacy INTx, it simply
>> triggers an interrupt.
>
> Right, INTx only has vector 0.

INTx has no concept of vectors, it uses pins.  Suggest to be a bit more
verbose to avoid confusion.

>> How can guest software distinguish between "interrupt due to remote
>> state change" and "interrupt due to doorbell"?
>
> By checking those states. Both are in shared memory, thus quickly readabl=
e.

I think that's worth pointing out somewhere.

>> Things become so much easier when you ditch INTx: reserve vector 0 for
>> state change, done.
>
> That aspect does not make things complicated with INTx, but I agree that
> we should look at its "TCO" again.
>
>>=20
>>> +the written state value differs from the previous one. The user of the=
 remote
>>> +device can read the value written to this register from the State Tabl=
e.
>>> +
>>> +The value of this register after device reset is 0.
>>=20
>> I guess the meaning of state values depends on the protocol type.
>> Correct?
>
> Yes, except for value 0 which means "reset state". The protocols are
> free to define all other values according to their needs.
>
>>=20
>>> +
>>> +### State Table
>>> +
>>> +The State Table is a read-only section at the beginning of the shared =
memory
>>> +region. It contains a 32-bit state value for each of the peers. Locati=
ng the
>>> +table in shared memory allows fast checking of remote states without r=
egister
>>> +accesses.
>>> +
>>> +The table is updated on each state change of a peers. Whenever a user =
of an
>>> +IVSHMEM device writes a value to the Local State register, this value =
is copied
>>> +into the corresponding entry of the State Table. When a IVSHMEM device=
 is reset
>>> +or disconnected from the other peers, zero is written into the corresp=
onding
>>> +table entry. The initial content of the table is all zeros.
>>> +
>>> +    +--------------------------------+
>>> +    | 32-bit state value of peer n-1 |
>>> +    +--------------------------------+
>>> +    :                                :
>>> +    +--------------------------------+
>>> +    | 32-bit state value of peer 1   |
>>> +    +--------------------------------+
>>> +    | 32-bit state value of peer 0   |
>>> +    +--------------------------------+ <-- Shared memory base address
>>> +
>>> +
>>> +Protocols
>>> +---------
>>> +
>>> +The IVSHMEM device shall support the peers of a connection in agreeing=
 on the
>>> +protocol used over the shared memory devices. For that purpose, the in=
terface
>>> +byte (offset 09h) and the sub-class byte (offset 0Ah) of the Class Cod=
e register
>>> +encodes a 16-bit protocol type for the users. The following type value=
s are
>>> +defined:
>>> +
>>> +| Protocol Type | Description                                         =
         |
>>> +|--------------:|:----------------------------------------------------=
---------|
>>> +|         0000h | Undefined type                                      =
         |
>>> +|         0001h | Virtual peer-to-peer Ethernet                       =
         |
>>> +|   0002h-3FFFh | Reserved                                            =
         |
>>> +|   4000h-7FFFh | User-defined protocols                              =
         |
>>> +|   8000h-BFFFh | Virtio over Shared Memory, front-end peer           =
         |
>>> +|   C000h-FFFFh | Virtio over Shared Memory, back-end peer            =
         |
>>> +
>>> +Details of the protocols are not in the scope of this specification.
>>=20
>> Are you sure this use of PCI class code is kosher?
>
> Well, we are in the 0xff range. To my understanding, there are no
> constraints on what you put in the other bits for that class.
>
>>=20
>> Final request: please break your lines around column 70 for readability.
>>=20
>
> Sure, can do.
>
> Thanks a lot,

You're welcome!


