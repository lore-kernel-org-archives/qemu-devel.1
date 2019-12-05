Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC8C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8544920707
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8544920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icyil-0005Qp-Kq
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 16:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1icygz-0004gh-K3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1icygt-0007QO-OY
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:29:43 -0500
Received: from david.siemens.de ([192.35.17.14]:60411)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1icygs-0007Co-8D
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:29:38 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id xB5LTYv0027013
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Dec 2019 22:29:34 +0100
Received: from [139.22.33.205] ([139.22.33.205])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xB5LTXVe023940;
 Thu, 5 Dec 2019 22:29:33 +0100
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <87blsndnxx.fsf@dusky.pond.sub.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <97dbf761-fae4-ab79-c7b0-4aae0b91dcb6@siemens.com>
Date: Thu, 5 Dec 2019 22:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <87blsndnxx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.14
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

On 05.12.19 12:14, Markus Armbruster wrote:
> This has been on the list for more than three weeks already.  I
> apologize for the delay.

No problem! Your feedback is highly appreciated.

> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This imports the ivshmem v2 specification draft from Jailhouse. Its
>> final home is to be decided, this shall just simplify the review process
>> at this stage.
>>
>> Note that specifically the Features register (offset 08h) is still under
>> consideration. In particular, its bit 0 seems useless now as its benefit
>> to guests, specifically when they want to be portable, is close to zero.
>> Maybe the register should still be kept, with all bits RsvdZ, for easier
>> extensibility.
>>
>> The rest appears now rather mature and reasonably implementable, as
>> proven also by a version for Jailhouse.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  docs/specs/ivshmem-2-device-spec.md | 333 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 333 insertions(+)
>>  create mode 100644 docs/specs/ivshmem-2-device-spec.md
>>
>> diff --git a/docs/specs/ivshmem-2-device-spec.md b/docs/specs/ivshmem-2-device-spec.md
>> new file mode 100644
>> index 0000000000..98cfde585a
>> --- /dev/null
>> +++ b/docs/specs/ivshmem-2-device-spec.md
>> @@ -0,0 +1,333 @@
>> +IVSHMEM Device Specification
>> +============================
>> +
>> +** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE SPECIFICATION! **
>> +
>> +The Inter-VM Shared Memory device provides the following features to its users:
>> +
>> +- Interconnection between up to 65536 peers
>> +
>> +- Multi-purpose shared memory region
>> +
>> +    - common read/writable section
>> +
>> +    - unidirectional sections that are read/writable for one peer and only
>> +      readable for the others
>> +
>> +    - section with peer states
>> +
>> +- Event signaling via interrupt to remote sides
>> +
>> +- Support for life-cycle management via state value exchange and interrupt
>> +  notification on changes, backed by a shared memory section
>> +
>> +- Free choice of protocol to be used on top
>> +
>> +- Protocol type declaration
>> +
>> +- Unprivileged access to memory-mapped or I/O registers feasible
>> +
>> +- Discoverable and configurable via standard PCI mechanisms
> 
> Stating requirements is much appreciated.  Design rationale would be
> even better :)

The idea is to avoid having to model also a platform device with
platform discovery mechanism. Based on our experiences with providing a
generic virtual PCI host controller, such a complication of
specification and implementation is simply not needed.

> 
> As pointed out many times, shared memory is not a solution to any
> communication problem, it's merely a building block for building such
> solutions: you invariably have to layer some protocol on top.  In your
> KVM Forum talk, you mention layering virtio on top.  Makes sense to me.
> But why does *this* virtio transport have to be an independent device?
> Other transports aren't.

This device is not only a virtio transport. As you correctly point out,
it is a foundation for communication, not the full solution by itself.

Its goal is to define the minimal piece that a hypervisor has to provide
to its guests in order to enable them building full communication
solutions of their preferred flavor on top. It does not want to deal
with those details, may they be virtio, may they be something much
simpler, much older or much more sophisticated (or complicated). All
that shall not be the business of a hypervisor.

> 
> Now let me indulge in spec nitpicking :)
> 
>> +
>> +
>> +Hypervisor Model
>> +----------------
>> +
>> +In order to provide a consistent link between peers, all connected instances of
>> +IVSHMEM devices need to be configured, created and run by the hypervisor
>> +according to the following requirements:
>> +
>> +- The instances of the device need to be accessible via PCI programming
>> +  interfaces on all sides.
> 
> What does that mean?

"From a guest point of view, this shall be a PCI device."

> 
>> +
>> +- The read/write shared memory section has to be of the same size for all
>> +  peers and, if non-zero, has to reflect the same memory content for them.
> 
> Isn't "same memory content" redundant with "shared memory"?

Probably.

> 
>> +
>> +- If output sections are present (non-zero section size), there must be one
>> +  reserved for each peer with exclusive write access. All output sections
>> +  must have the same size and must be readable for all peers. They have to
>> +  reflect the same memory content for all peers.
> 
> Are these the "unidirectional sections" mentioned previously?

Yep. The terms have some history, maybe worth consolidating them.

> 
>> +
>> +- The State Table must have the same size for all peers, must be large enough to
>> +  hold a state values of all peers, and must be read-only for the user.
> 
> "the state values", I guess.

Yes.

> 
>> +
>> +- State register changes (explicit writes, peer resets) have to be propagated
>> +  to the other peers by updating the corresponding State Table entry and issuing
>> +  an interrupt to all other peers if they enabled reception.
>> +
>> +- Interrupts events triggered by a peer have to be delivered to the target peer,
>> +  provided the receiving side is valid and has enabled the reception.
>> +
>> +- All peers must have the same interrupt delivery features available, i.e. MSI-X
>> +  with the same maximum number of vectors on platforms supporting this
>> +  mechanism, otherwise INTx with one vector.
> 
> Use case for legacy INTx?

Platforms without support for MSI-X injection. Quite a few current ARM
platforms still fall into this category, but they get less, indeed.

> 
> For what it's worth, we removed INTx support from ivshmem v1 in rev 1,
> QEMU 2.6.

Maybe worth to look into this again, specifically when we are done with
ITS emulation on the Jailhouse side. Maybe it will be the same story as
with our virtual PCI host controller there: After we had to add PCI
logic for devices with real controller anyway, the virtual one was
literally for free (not a single line of code added).

> 
>> +
>> +
>> +Guest-side Programming Model
>> +----------------------------
>> +
>> +An IVSHMEM device appears as a PCI device to its users. Unless otherwise noted,
>> +it conforms to the PCI Local Bus Specification, Revision 3.0 As such, it is
> 
> Uh, is there anything in it that does *not* conform to this spec?

See below.

> 
>> +discoverable via the PCI configuration space and provides a number of standard
>> +and custom PCI configuration registers.
>> +
>> +### Shared Memory Region Layout
>> +
>> +The shared memory region is divided into several sections.
>> +
>> +    +-----------------------------+   -
>> +    |                             |   :
>> +    | Output Section for peer n-1 |   : Output Section Size
>> +    |     (n = Maximum Peers)     |   :
>> +    +-----------------------------+   -
>> +    :                             :
>> +    :                             :
>> +    :                             :
>> +    +-----------------------------+   -
>> +    |                             |   :
>> +    |  Output Section for peer 1  |   : Output Section Size
>> +    |                             |   :
>> +    +-----------------------------+   -
>> +    |                             |   :
>> +    |  Output Section for peer 0  |   : Output Section Size
>> +    |                             |   :
>> +    +-----------------------------+   -
>> +    |                             |   :
>> +    |     Read/Write Section      |   : R/W Section Size
>> +    |                             |   :
>> +    +-----------------------------+   -
>> +    |                             |   :
>> +    |         State Table         |   : State Table Size
>> +    |                             |   :
>> +    +-----------------------------+   <-- Shared memory base address
>> +
>> +The first section consists of the mandatory State Table. Its size is defined by
>> +the State Table Size register and cannot be zero. This section is read-only for
>> +all peers.
>> +
>> +The second section consists of shared memory that is read/writable for all
>> +peers. Its size is defined by the R/W Section Size register. A size of zero is
>> +permitted.
>> +
>> +The third and following sections are unidirectional output sections, one for
>> +each peer. Their sizes are all identical. The size of a single output section is
>> +defined by the Output Section Size register. An output section is read/writable
>> +for the corresponding peer and read-only for all other peers. E.g., only the
>> +peer with ID 3 can write to the fourths output section, but all peers can read
>> +from this section.
>> +
>> +All sizes have to be rounded up to multiples of a mappable page in order to
>> +allow access control according to the section restrictions.
>> +
>> +### Configuration Space Registers
>> +
>> +#### Header Registers
>> +
>> +| Offset | Register               | Content                                              |
>> +|-------:|:-----------------------|:-----------------------------------------------------|
>> +|    00h | Vendor ID              | 1AF4h                                                |
>> +|    02h | Device ID              | 1110h                                                |
> 
> Same as ivshmem v1.  Revision ID (offset 08h) disambiguates.

Will become 110Ah (Siemens) / 4106h (freshly reserved for a new ivshmem)
in the next round.

> 
>> +|    04h | Command Register       | 0000h on reset, implementing bits 1, 2, 10           |
> 
> What does "implementing bits ..." mean?

Ignore writes to the other bits.

> 
>> +|    06h | Status Register        | 0010h, static value (bit 3 not implemented)          |
> 
> What does "bit 3 not implemented" mean?

Will stay at 0, no "pending INTx" information available.

> 
>> +|    08h | Revision ID            | 02h                                                  |
> 
> ivshmem v1 is rev 0 before QEMU 2.6, rev 1 since.  Rev 1 is
> backward-compatible to rev 0 for guest software.  Is rev 2 intended to
> be backward-compatible, too?
> 
> You should probably explan how your v2 relates to v1 in more detail,
> possibly in its own top-level section.

With that new, separate device IT, this register will start at 0 in the
next revision of this document.

> 
>> +|    09h | Class Code, Interface  | Protocol Type bits 0-7, see [Protocols](#Protocols)  |
>> +|    0Ah | Class Code, Sub-Class  | Protocol Type bits 8-15, see [Protocols](#Protocols) |
>> +|    0Bh | Class Code, Base Class | FFh                                                  |
> 
> FFh means "device does not fit any defined class."  For what it's worth,
> ivshmem v1 uses 05h "Memory Controller", with sub-class and interface
> 00h "RAM Controller".

I know. But using that scheme would needlessly wast 8 bits for protocol
ID encoding. In turn, having the protocol encoded into the class code
helps a lot with automatic driver probing on Linux e.g.

> 
>> +|    0Eh | Header Type            | 00h                                                  |
>> +|    10h | BAR 0                  | MMIO or I/O register region                          |
> 
> Use case for I/O?

Faster VM exit handling. But, granted, that was not exploited so far in
existing implementations. I just wanted to keep that door open.

> 
> For what it's worth, ivshmem v1 never supported I/O.
> 
>> +|    14h | BAR 1                  | MSI-X region                                         |
>> +|    18h | BAR 2 (with BAR 3)     | optional: 64-bit shared memory region                |
> 
> What does "(with BAR 3)" mean?

64-bit resource regions always use two BARs, see PCI spec.

> 
>> +|    2Ch | Subsystem Vendor ID    | same as Vendor ID, or provider-specific value        |
>> +|    2Eh | Subsystem ID           | same as Device ID, or provider-specific value        |
> 
> ivshmem v1 leaves these blank.

Same story as with virtio: This should encode the ID of the provider
(hypervisor), also for the case we ever face deviating implementations,
due to quirks of specification vagueness.

> 
>> +|    34h | Capability Pointer     | First capability                                     |
>> +|    3Eh | Interrupt Pin          | 01h-04h, must be 00h if MSI-X is available           |
> 
> "If MSI-X is available"?
> 
> A PCIe device always provides MSI-X, and may additionally provide legacy
> INTx.  A conventional PCI device may provide either or both.  In any
> case, the Interrupt Pin register is zero when legacy INTx is not
> provided,

All known. This shall just "encourage" to provide more powerfull MSI-x
when the platform provides that for other devices anyway. Only if the
platform this device is injected to does not have such support, INTx
shall be there.

> 
>> +
>> +If BAR 2 is not present, the shared memory region is not relocatable by the
>> +user. In that case, the hypervisor has to implement the Base Address register in
>> +the vendor-specific capability.
>> +
>> +Other header registers may not be implemented. If not implemented, they return 0
>> +on read and ignore write accesses.
> 
> Is this an example of where the device does not conform to the PCI Local
> Bus Specification?

- INTx is an edge interrupt
- there is no INTx status bit
- there is no pending MSI-X bitmap

> 
>> +
>> +#### Vendor Specific Capability (ID 09h)
>> +
>> +| Offset | Register            | Content                                        |
>> +|-------:|:--------------------|:-----------------------------------------------|
>> +|    00h | ID                  | 09h                                            |
>> +|    01h | Next Capability     | Pointer to next capability or 00h              |
>> +|    02h | Length              | 18h or 20h                                     |
>> +|    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt mode    |
>> +|        |                     | Bits 1-7: RsvdZ                                |
> 
> Please define RsvdZ somewhere, or use plainer language.

OK.

> 
>> +|    04h | State Table Size    | 32-bit size of read-only State Table           |
>> +|    08h | R/W Section Size    | 64-bit size of common read/write section       |
>> +|    10h | Output Section Size | 64-bit size of unidirectional output sections  |
>> +|    18h | Base Address        | optional: 64-bit base address of shared memory |
> 
> Length is 20h when Base Adress is present, else 18h.  Worth spelling
> that out?

Sure.

> 
>> +
>> +All registers are read-only, except for bit 0 of the Privileged Control
>> +register.
> 
> Well, the other bits of that register are writable, they're just
> ignored.
> 
> For what it's worth, existing ivshmem-spec.txt uses the terms read-only,
> write-only, read/write and reserved bits rigorously: "Software should
> only access the registers as specified [...]  Reserved bits should be
> ignored on read, and preserved on write."

Will change.

> 
>> +
>> +When bit 0 in the Privileged Control register is set to 1, the device clears
>> +bit 0 in the Interrupt Control register on each interrupt delivery. This enables
>> +automatic interrupt throttling when re-enabling shall be performed by a
>> +scheduled unprivileged instance on the user side.
>> +
>> +If an IVSHMEM device does not support a relocatable shared memory region, BAR 2
>> +must not be implemented by the provider. Instead, the Base Address register has
>> +to be implemented to report the location of the shared memory region in the
>> +user's address space.
> 
> Rationale for not wanting to support relocatable shared memory?

Locked-down second stage page tables during runtime. We can even
check-sum their content periodically when we do not allow guest to
influence the shared memory guest location. Relevant for safety and
possibly also security scenarios.

> 
>> +
>> +A non-existing shared memory section has to report zero in its Section Size
>> +register.
> 
> This vendor-specific capability must always be present, I presume.
> Worth spelling out.

Ack.

> 
>> +
>> +#### MSI-X Capability (ID 11h)
>> +
>> +On platforms supporting MSI-X, IVSHMEM has to provide interrupt delivery via
>> +this mechanism. In that case, the legacy INTx delivery mechanism is not
>> +available, and the Interrupt Pin configuration register returns 0.
> 
> I'm confused.  Does that mean the device shall support either MSI-X or
> legacy INTx, but never both?

Correct, see above. There is no point in requesting both and requiring
the hypervisor to deal with the guest switching between things during
runtime.

> 
>> +
>> +The IVSHMEM device has no notion of pending interrupts. Therefore, reading from
>> +the MSI-X Pending Bit Array will always return 0.
> 
> I guess this means a polling mode of operation is not possible.
> Correct?

Of course, polling remains possible, but the guest driver should rather
obtain the interrupt-triggering state information from the much faster
shared memory. There is simply no value in also mirroring that into
interrupt registers for this particular device.

> 
>> +
>> +The corresponding MSI-X MMIO region is configured via BAR 1.
>> +
>> +The MSI-X table size reported by the MSI-X capability structure is identical for
>> +all peers.
>> +
>> +### Register Region
>> +
>> +The register region may be implemented as MMIO or I/O.
>> +
>> +When implementing it as MMIO, the hypervisor has to ensure that the register
>> +region can be mapped as a single page into the address space of the user. Write
> 
> "can be mapped as a single page" depends on the host system, not the
> device.

When host system provides this device, it must ensure that the MMIO
register region can be mapped by its guest as one page, without
potential overlap with other resources.

> 
> For what it's worth, ivshmem v1 fixes the size of BAR0 to 256 bytes.
> Any particular reason to keep its size so loosely specified in v2?

UIO. The v1 device can't be handed out to untrusted UIO applications
without intercepting the MMIO writes in the guest kernel in order to
restrict them to the valid range. This device supports that.

> 
>> +accesses to MMIO region offsets that are not backed by registers have to be
>> +ignored, read accesses have to return 0. This enables the user to hand out the
>> +complete region, along with the shared memory, to an unprivileged instance.
>> +
>> +The region location in the user's physical address space is configured via BAR
>> +0. The following table visualizes the region layout:
>> +
>> +| Offset | Register                                                            |
>> +|-------:|:--------------------------------------------------------------------|
>> +|    00h | ID                                                                  |
>> +|    04h | Maximum Peers                                                       |
>> +|    08h | Features                                                            |
>> +|    0Ch | Interrupt Control                                                   |
>> +|    10h | Doorbell                                                            |
>> +|    14h | State                                                               |
>> +
>> +All registers support only aligned 32-bit accesses.
> 
> Definitely not backwards compatible to rev 1.  I figure that means v2
> should use a different Vendor ID / Device ID, not just bump the Revsion
> ID.

Yep, see above.

> 
> No interrupt status register?

Yep, see above.

> 
>> +
>> +#### ID Register (Offset 00h)
>> +
>> +Read-only register that reports the ID of the local device. It is unique for all
>> +of the connected devices and remains unchanged over their lifetime.
>> +
>> +#### Maximum Peers Register (Offset 04h)
>> +
>> +Read-only register that reports the maximum number of possible peers (including
>> +the local one). The supported range is between 2 and 65536 and remains constant
>> +over the lifetime of all peers.
> 
> Value 1 would be boring, but is it really impossible?

Likely not, didn't think about it so far. Would we gain anything by
permitting this?

> 
>> +
>> +#### Features Register (Offset 08h)
>> +
>> +Read-only register that reports features of the local device or the connected
>> +peers. Its content remains constant over the lifetime of all peers.
>> +
>> +| Bits | Content                                                               |
>> +|-----:|:----------------------------------------------------------------------|
>> +|    0 | 1: Synchronized shared memory base address                            |
>> +| 1-31 | RsvdZ                                                                 |
>> +
>> +If "synchronized shared memory base address" is reported (bit 0 is set), the
>> +shared memory region is mapped at the same address into the user address spaces
>> +of all connected peers. Thus, peers can use physical addresses as pointers when
>> +exchanging information via the shared memory. This feature flag is never set
>> +when the shared memory region is relocatable via BAR 2.
>> +
>> +#### Interrupt Control Register (Offset 0Ch)
>> +
>> +This read/write register controls the generation of interrupts whenever a peer
>> +writes to the Doorbell register or changes its state.
>> +
>> +| Bits | Content                                                               |
>> +|-----:|:----------------------------------------------------------------------|
>> +|    0 | 1: Enable interrupt generation                                        |
>> +| 1-31 | RsvdZ                                                                 |
>> +
>> +Note that bit 0 is reset to 0 on interrupt delivery if one-shot interrupt mode
>> +is enabled in the Enhanced Features register.
>> +
>> +The value of this register after device reset is 0.
> 
> I presume this applies only to legacy INTx.  Correct?

Nope, this applies to both INTx and MSI-x. It's a building block for UIO
devices, see one-shot interrupt mode. In that mode, bit 0 will be
cleared by the device after each interrupt delivery, avoiding that the
guest UIO driver needs to do that via a vmexit.

> 
> ivshmem v1 calls this Interrupt Mask.

As "set" does not mean "masked", I chose "enable" here.

> 
>> +
>> +#### Doorbell Register (Offset 10h)
>> +
>> +Write-only register that triggers an interrupt vector in the target device if it
>> +is enabled there.
>> +
>> +| Bits  | Content                                                              |
>> +|------:|:---------------------------------------------------------------------|
>> +|  0-15 | Vector number                                                        |
>> +| 16-31 | Target ID                                                            |
>> +
>> +Writing a vector number that is not enabled by the target has no effect. The
>> +peers can derive the number of available vectors from their own device
>> +capabilities and are expected to define or negotiate the used ones via the
>> +selected protocol.
> 
> That's because all peers use the same number of vectors.  Worth spelling out?

I thought I did that somewhere. Will check.

> 
>> +
>> +Addressing a non-existing or inactive target has no effect. Peers can identify
>> +active targets via the State Table.
>> +
>> +The behavior on reading from this register is undefined.
>> +
>> +#### State Register (Offset 14h)
>> +
>> +Read/write register that defines the state of the local device. Writing to this
>> +register sets the state and triggers interrupt vector 0 on the remote device if
> 
> "the remote device"?  Do you mean all peers?

Historic singular (an earlier revision only supported 2 peers). Will fix.

> 
> "interrupt vector 0" assumes MSI-X.  With legacy INTx, it simply
> triggers an interrupt.

Right, INTx only has vector 0.

> 
> How can guest software distinguish between "interrupt due to remote
> state change" and "interrupt due to doorbell"?

By checking those states. Both are in shared memory, thus quickly readable.

> 
> Things become so much easier when you ditch INTx: reserve vector 0 for
> state change, done.

That aspect does not make things complicated with INTx, but I agree that
we should look at its "TCO" again.

> 
>> +the written state value differs from the previous one. The user of the remote
>> +device can read the value written to this register from the State Table.
>> +
>> +The value of this register after device reset is 0.
> 
> I guess the meaning of state values depends on the protocol type.
> Correct?

Yes, except for value 0 which means "reset state". The protocols are
free to define all other values according to their needs.

> 
>> +
>> +### State Table
>> +
>> +The State Table is a read-only section at the beginning of the shared memory
>> +region. It contains a 32-bit state value for each of the peers. Locating the
>> +table in shared memory allows fast checking of remote states without register
>> +accesses.
>> +
>> +The table is updated on each state change of a peers. Whenever a user of an
>> +IVSHMEM device writes a value to the Local State register, this value is copied
>> +into the corresponding entry of the State Table. When a IVSHMEM device is reset
>> +or disconnected from the other peers, zero is written into the corresponding
>> +table entry. The initial content of the table is all zeros.
>> +
>> +    +--------------------------------+
>> +    | 32-bit state value of peer n-1 |
>> +    +--------------------------------+
>> +    :                                :
>> +    +--------------------------------+
>> +    | 32-bit state value of peer 1   |
>> +    +--------------------------------+
>> +    | 32-bit state value of peer 0   |
>> +    +--------------------------------+ <-- Shared memory base address
>> +
>> +
>> +Protocols
>> +---------
>> +
>> +The IVSHMEM device shall support the peers of a connection in agreeing on the
>> +protocol used over the shared memory devices. For that purpose, the interface
>> +byte (offset 09h) and the sub-class byte (offset 0Ah) of the Class Code register
>> +encodes a 16-bit protocol type for the users. The following type values are
>> +defined:
>> +
>> +| Protocol Type | Description                                                  |
>> +|--------------:|:-------------------------------------------------------------|
>> +|         0000h | Undefined type                                               |
>> +|         0001h | Virtual peer-to-peer Ethernet                                |
>> +|   0002h-3FFFh | Reserved                                                     |
>> +|   4000h-7FFFh | User-defined protocols                                       |
>> +|   8000h-BFFFh | Virtio over Shared Memory, front-end peer                    |
>> +|   C000h-FFFFh | Virtio over Shared Memory, back-end peer                     |
>> +
>> +Details of the protocols are not in the scope of this specification.
> 
> Are you sure this use of PCI class code is kosher?

Well, we are in the 0xff range. To my understanding, there are no
constraints on what you put in the other bits for that class.

> 
> Final request: please break your lines around column 70 for readability.
> 

Sure, can do.

Thanks a lot,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

