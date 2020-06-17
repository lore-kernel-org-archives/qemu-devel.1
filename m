Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43197C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076642080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076642080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaiJ-0008PG-AW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jlahe-0007pk-UU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:14:18 -0400
Received: from gecko.sbs.de ([194.138.37.40]:56140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jlahb-0008SD-Fl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:14:18 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 05HGAjNH002558
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2020 18:10:46 +0200
Received: from [139.25.68.37] ([139.25.68.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05HGAjV9012217;
 Wed, 17 Jun 2020 18:10:45 +0200
Subject: Re: [RFC] ivshmem v2: Shared memory device specification
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <87pn9xwvwj.fsf@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c798bf36-162f-5474-4e21-efcc0d7c295e@siemens.com>
Date: Wed, 17 Jun 2020 18:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87pn9xwvwj.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.138.37.40;
 envelope-from=jan.kiszka@siemens.com; helo=gecko.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 12:10:48
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.06.20 17:32, Alex Bennée wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi all,
>>
>> as requested by Michael, find below the current version of the Inter-VM 
>> Shared Memory device specification version 2 (as version 1 could be 
>> considered what is currently in QEMU).
>>
>> This posting is intended to collect feedback from the virtio community 
>> before officially proposing it to become part of the spec. As you can 
>> see, the spec format is not yet integrated with the virtio documents at 
>> all.
>>
>> IVSHMEM has value of its own, allowing unprivileged applications to 
>> establish links to other applications in VMs connected via this 
>> transport. In addition, and that is where virtio comes into play even 
>> more, it can be used to build virtio backend-frontend connections 
>> between two VMs. Prototypes have been developed, see e.g. [1], 
>> specifying that transport is still a to-do. I will try to reserve a few 
>> cycle in the upcoming weeks for a first draft.
>>
>> My current strategy for these two pieces, ivshmem2 and virtio-shmem, is 
>> propose them both to virtio but allowing virtio-shmem to also be mapped 
>> on other shared memory channels for virtual machines.
>>
>> The ivshmem2 device model is fairly stable now, also being in use in 
>> Jailhouse for quite a while. Still there are some aspects that could be 
>> worth to discuss in particular:
>>
>>  - Do we also need a platform device model, in addition to PCI? My
>>    feelings are negative, but there has been at least one request.
>>
>>  - Should we add some feature flags, or is using the PCI revision ID
>>    sufficient (...to do that later)? Currently, there is no need for
>>    communicating features this way.
>>
>>  - Should we try to model the doorbell interface more flexibly, in way
>>    that may allow mapping it on hardware-provided mailboxes (i.e. VM-
>>    exit free channels)? Unfortunately, I'm not yet aware of any hardware
>>    that could provide this feature and, thus, could act as a use case to
>>    design against.
>>
>> Thanks,
>> Jan
>>
>> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg668749.html
>>
>> ---
>>
>> IVSHMEM Device Specification
>> ============================
>>
>> ** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE SPECIFICATION! **
>>
>> The goal of the Inter-VM Shared Memory (IVSHMEM) device model is to
>> define the minimally needed building blocks a hypervisor has to
>> provide for enabling guest-to-guest communication. The details of
>> communication protocols shall remain opaque to the hypervisor so that
>> guests are free to define them as simple or sophisticated as they
>> need.
>>
>> For that purpose, the IVSHMEM provides the following features to its
>> users:
>>
>> - Interconnection between up to 65536 peers
>>
>> - Multi-purpose shared memory region
>>
>>     - common read/writable section
>>
>>     - output sections that are read/writable for one peer and only
>>       readable for the others
>>
>>     - section with peer states
>>
>> - Event signaling via interrupt to remote sides
>>
>> - Support for life-cycle management via state value exchange and
>>   interrupt notification on changes, backed by a shared memory
>>   section
>>
>> - Free choice of protocol to be used on top
>>
>> - Protocol type declaration
>>
>> - Register can be implemented either memory-mapped or via I/O,
>>   depending on platform support and lower VM-exit costs
>>
>> - Unprivileged access to memory-mapped or I/O registers feasible
>>
>> - Single discovery and configuration via standard PCI, no complexity
>>   by additionally defining a platform device model
>>
>>
>> Hypervisor Model
>> ----------------
>>
>> In order to provide a consistent link between peers, all connected
>> instances of IVSHMEM devices need to be configured, created and run
>> by the hypervisor according to the following requirements:
>>
>> - The instances of the device shall appear as a PCI device to their
>>   users.
> 
> Would there ever be scope for a plain MMIO style device to be reported?

As pointed out above, there has been a question already targeting at
MMIO binding.

> While I agree PCI is pretty useful from the point of view of easy
> discovery I note a number of machine types prefer device tree reported
> devices because they are faster to bring up for cloudy fast VM purposes
> (c.f. microvm).

Can't you avoid that probing delay by listing devices explicitly in the
device tree? I have no data on that, just heard about. Maybe the same
works with ACPI.

What I heard so far the concerns were more targeting the complexity of
PCI driver stacks in the guests. But that complexity quickly grows also
on the MMIO platform side when getting feature-wise on a similar level
as PCI.

> 
>> - The read/write shared memory section has to be of the same size for
>>   all peers. The size can be zero.
>>
>> - If shared memory output sections are present (non-zero section
>>   size), there must be one reserved for each peer with exclusive
>>   write access. All output sections must have the same size and must
>>   be readable for all peers.
>>
>> - The State Table must have the same size for all peers, must be
>>   large enough to hold the state values of all peers, and must be
>>   read-only for the user.
>>
>> - State register changes (explicit writes, peer resets) have to be
>>   propagated to the other peers by updating the corresponding State
>>   Table entry and issuing an interrupt to all other peers if they
>>   enabled reception.
>>
>> - Interrupts events triggered by a peer have to be delivered to the
>>   target peer, provided the receiving side is valid and has enabled
>>   the reception.
>>
>> - All peers must have the same interrupt delivery features available,
>>   i.e. MSI-X with the same maximum number of vectors on platforms
>>   supporting this mechanism, otherwise INTx with one vector.
>>
>>
>> Guest-side Programming Model
>> ----------------------------
>>
>> An IVSHMEM device appears as a PCI device to its users. Unless
>> otherwise noted, it conforms to the PCI Local Bus Specification,
>> Revision 3.0. As such, it is discoverable via the PCI configuration
>> space and provides a number of standard and custom PCI configuration
>> registers.
>>
>> ### Shared Memory Region Layout
>>
>> The shared memory region is divided into several sections.
>>
>>     +-----------------------------+   -
>>     |                             |   :
>>     | Output Section for peer n-1 |   : Output Section Size
>>     |     (n = Maximum Peers)     |   :
>>     +-----------------------------+   -
>>     :                             :
>>     :                             :
>>     :                             :
>>     +-----------------------------+   -
>>     |                             |   :
>>     |  Output Section for peer 1  |   : Output Section Size
>>     |                             |   :
>>     +-----------------------------+   -
>>     |                             |   :
>>     |  Output Section for peer 0  |   : Output Section Size
>>     |                             |   :
>>     +-----------------------------+   -
> 
> There doesn't seem to be any mention of limits on the output section
> size. If you wanted to limit visibility between peers there would have
> to be an explicit page alignment requirement for these sections.

That is needed for managing write access, in fact. We should likely
mention that alignment need (which also depends on the guests' smallest
page size), but the actual value is out of scope for the spec.

> 
> Or would the alternative be for the hypervisor to instantiate additional
> IVSHMEM devices for each combination of peers that need visibility of
> each other?

If you link guests via a set of IVSHMEM devices, that implies the guests
are aware of who can see what. And it is actually the model to have
multiple IVSHMEM links, split per purpose (protocol) or split per
visibility constraints.

> 
>>     |                             |   :
>>     |     Read/Write Section      |   : R/W Section Size
>>     |                             |   :
>>     +-----------------------------+   -
>>     |                             |   :
>>     |         State Table         |   : State Table Size
>>     |                             |   :
>>     +-----------------------------+   <-- Shared memory base address
>>
>> The first section consists of the mandatory State Table. Its size is
>> defined by the State Table Size register and cannot be zero. This
>> section is read-only for all peers.
>>
>> The second section consists of shared memory that is read/writable
>> for all peers. Its size is defined by the R/W Section Size register.
>> A size of zero is permitted.
>>
>> The third and following sections are output sections, one for each
>> peer. Their sizes are all identical. The size of a single output
>> section is defined by the Output Section Size register. An output
>> section is read/writable for the corresponding peer and read-only for
>> all other peers. E.g., only the peer with ID 3 can write to the
>> fourths output section, but all peers can read from this section.
>>
>> All sizes have to be rounded up to multiples of a mappable page in
>> order to allow access control according to the section restrictions.
>>
>> ### Configuration Space Registers
>>
>> #### Header Registers
>>
>> | Offset | Register               | Content                                              |
>> |-------:|:-----------------------|:-----------------------------------------------------|
>> |    00h | Vendor ID              | 110Ah                                                |
>> |    02h | Device ID              | 4106h                                                |
>> |    04h | Command Register       | 0000h on reset, writable bits are:                   |
>> |        |                        | Bit 0: I/O Space (if Register Region uses I/O)       |
>> |        |                        | Bit 1: Memory Space (if Register Region uses Memory) |
>> |        |                        | Bit 3: Bus Master                                    |
>> |        |                        | Bit 10: INTx interrupt disable                       |
>> |        |                        | Writes to other bits are ignored                     |
>> |    06h | Status Register        | 0010h, static value                                  |
>> |        |                        | In deviation to the PCI specification, the Interrupt |
>> |        |                        | Status (bit 3) is never set                          |
>> |    08h | Revision ID            | 00h                                                  |
>> |    09h | Class Code, Interface  | Protocol Type bits 0-7, see [Protocols](#Protocols)  |
>> |    0Ah | Class Code, Sub-Class  | Protocol Type bits 8-15, see [Protocols](#Protocols) |
>> |    0Bh | Class Code, Base Class | FFh                                                  |
>> |    0Eh | Header Type            | 00h                                                  |
>> |    10h | BAR 0                  | MMIO or I/O register region                          |
>> |    14h | BAR 1                  | MSI-X region                                         |
>> |    18h | BAR 2 (with BAR 3)     | optional: 64-bit shared memory region                |
>> |    2Ch | Subsystem Vendor ID    | same as Vendor ID, or provider-specific value        |
>> |    2Eh | Subsystem ID           | same as Device ID, or provider-specific value        |
>> |    34h | Capability Pointer     | First capability                                     |
> 
> Is this a PCI thing? How are additional capabilities described?

Here the link goes to the PCI spec: nothing special, the usual linked list.

> 
>> |    3Eh | Interrupt Pin          | 01h-04h, must be 00h if MSI-X is available           |
>>
>> The INTx status bit is never set by an implementation. Users of the
>> IVSHMEM device are instead expected to derive the event state from
>> protocol-specific information kept in the shared memory. This
>> approach is significantly faster, and the complexity of
>> register-based status tracking can be avoided.
>>
>> If BAR 2 is not present, the shared memory region is not relocatable
>> by the user. In that case, the hypervisor has to implement the Base
>> Address register in the vendor-specific capability.
> 
> Sorry I don't follow - if there is no BAR2 there is still a shared
> memory region but you just can't move it around the guests address

Exactly. PCI unfortunatly does not allow us to describe that with PCI
means, so we need a side-channel. If tried PCI EA once, but it did not
work out:
https://groups.google.com/d/msg/jailhouse-dev/H62ahr0_bRk/pyHyohSdDAAJ

> space? I guess this ties in with my question above about capabilities,
> is there just a value you read for the physical address? What about it's
> size?

See vendor cap below.

> 
>> Subsystem IDs shall encode the provider (hypervisor) in order to
>> allow identifying potential deviating implementations in case this
>> should ever be required.
>>
>> If its platform supports MSI-X, an implementation of the IVSHMEM
>> device must provide this interrupt model and must not expose INTx
>> support.
>>
>> Other header registers may not be implemented. If not implemented,
>> they return 0 on read and ignore write accesses.
>>
>> #### Vendor Specific Capability (ID 09h)
>>
>> This capability must always be present.
>>
>> | Offset | Register            | Content                                        |
>> |-------:|:--------------------|:-----------------------------------------------|
>> |    00h | ID                  | 09h                                            |
>> |    01h | Next Capability     | Pointer to next capability or 00h              |
>> |    02h | Length              | 20h if Base Address is present, 18h otherwise  |
>> |    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt mode    |
>> |        |                     | Bits 1-7: Reserved (0 on read, writes ignored) |
>> |    04h | State Table Size    | 32-bit size of read-only State Table           |
>> |    08h | R/W Section Size    | 64-bit size of common read/write section       |
>> |    10h | Output Section Size | 64-bit size of output sections                 |
>> |    18h | Base Address        | optional: 64-bit base address of
>> shared memory |
> 
> ah so we follow Capability Pointer and then walk down the table in Next
> Capability chunks? Next Capability is described as a pointer but only at
> an offset of 01h with Length at 02h. Is it really a pointer or just the
> size of this capability record?

It's an offset in the config space region. PCI standard.

> 
> I think this answers the question further up - no BAR2 and the optional
> Base Address in the Vendor Specific Capability.
> 
>> All registers are read-only. Writes are ignored, except to bit 0 of
>> the Privileged Control register.
>>
>> When bit 0 in the Privileged Control register is set to 1, the device
>> clears bit 0 in the Interrupt Control register on each interrupt
>> delivery. This enables automatic interrupt throttling when
>> re-enabling shall be performed by a scheduled unprivileged instance
>> on the user side.
>>
>> An IVSHMEM device may not support a relocatable shared memory region.
>> This support the hypervisor in locking down the guest-to-host address
>> mapping and simplifies the runtime logic. In such a case, BAR 2 must
>> not be implemented by the hypervisor. Instead, the Base Address
>> register has to be implemented to report the location of the shared
>> memory region in the user's address space.
> 
> This seems useful - especially in the case of trying to keep the guest
> using a fixed guest physical address and not potentially breaking up
> mappings in the hypervisor by moving stuff around.

Exactly. One motivation in Jailhouse context is to allow for a
runtime-verifiable checksum over most of the stage-2 page tables (not
yet implemented but in mind). Permitting the guest to control where its
shared memory shall be would prevent that. I would also mean TLB
management for the second-stage page tables during guest runtime,
something we do not have in Jailhouse and would like to avoid.

> 
>>
>> A non-existing shared memory section has to report zero in its
>> Section Size register.
>>
>> #### MSI-X Capability (ID 11h)
>>
>> On platforms supporting MSI-X, IVSHMEM has to provide interrupt
>> delivery via this mechanism. In that case, the MSI-X capability is
>> present while the legacy INTx delivery mechanism is not available,
>> and the Interrupt Pin configuration register returns 0.
>>
>> The IVSHMEM device has no notion of pending interrupts. Therefore,
>> reading from the MSI-X Pending Bit Array will always return 0. Users
>> of the IVSHMEM device are instead expected to derive the event state
>> from protocol-specific information kept in the shared memory. This
>> approach is significantly faster, and the complexity of
>> register-based status tracking can be avoided.
>>
>> The corresponding MSI-X MMIO region is configured via BAR 1.
>>
>> The MSI-X table size reported by the MSI-X capability structure is
>> identical for all peers.
>>
>> ### Register Region
>>
>> The register region may be implemented as MMIO or I/O.
>>
>> When implementing it as MMIO, the hypervisor has to ensure that the
>> register region can be mapped as a single page into the address space
>> of the user, without causing potential overlaps with other resources.
>> Write accesses to MMIO region offsets that are not backed by
>> registers have to be ignored, read accesses have to return 0. This
>> enables the user to hand out the complete region, along with the
>> shared memory, to an unprivileged instance.
>>
>> The region location in the user's physical address space is
>> configured via BAR 0. The following table visualizes the region
>> layout:
>>
>> | Offset | Register                                                            |
>> |-------:|:--------------------------------------------------------------------|
>> |    00h | ID                                                                  |
>> |    04h | Maximum Peers                                                       |
>> |    08h | Interrupt Control                                                   |
>> |    0Ch | Doorbell                                                            |
>> |    10h | State                                                               |
>>
>> All registers support only aligned 32-bit accesses.
>>
>> #### ID Register (Offset 00h)
>>
>> Read-only register that reports the ID of the local device. It is
>> unique for all of the connected devices and remains unchanged over
>> their lifetime.
>>
>> #### Maximum Peers Register (Offset 04h)
>>
>> Read-only register that reports the maximum number of possible peers
>> (including the local one). The permitted range is between 2 and 65536
>> and remains constant over the lifetime of all peers.
>>
>> #### Interrupt Control Register (Offset 08h)
>>
>> This read/write register controls the generation of interrupts
>> whenever a peer writes to the Doorbell register or changes its state.
>>
>> | Bits | Content                                                               |
>> |-----:|:----------------------------------------------------------------------|
>> |    0 | 1: Enable interrupt generation                                        |
>> | 1-31 | Reserved (0 on read, writes ignored)                                  |
>>
>> Note that bit 0 is reset to 0 on interrupt delivery if one-shot
>> interrupt mode is enabled in the Enhanced Features register.
>>
>> The value of this register after device reset is 0.
>>
>> #### Doorbell Register (Offset 0Ch)
>>
>> Write-only register that triggers an interrupt vector in the target
>> device if it is enabled there.
>>
>> | Bits  | Content                                                              |
>> |------:|:---------------------------------------------------------------------|
>> |  0-15 | Vector number                                                        |
>> | 16-31 | Target ID                                                            |
>>
>> Writing a vector number that is not enabled by the target has no
>> effect. The peers can derive the number of available vectors from
>> their own device capabilities because the provider is required to
>> expose an identical number of vectors to all connected peers. The
>> peers are expected to define or negotiate the used ones via the
>> selected protocol.
>>
>> Addressing a non-existing or inactive target has no effect. Peers can
>> identify active targets via the State Table.
>>
>> Implementations of the Doorbell register must ensure that data written by the
>> CPU prior to issuing the register write is visible to the receiving peer before
>> the interrupt arrives.
>>
>> The behavior on reading from this register is undefined.
>>
>> #### State Register (Offset 10h)
>>
>> Read/write register that defines the state of the local device.
>> Writing to this register sets the state and triggers MSI-X vector 0
>> or the INTx interrupt, respectively, on the remote device if the
>> written state value differs from the previous one. Users of peer
>> devices can read the value written to this register from the State
>> Table. They are expected differentiate state change interrupts from
>> doorbell events by comparing the new state value with a locally
>> stored copy.
>>
>> The value of this register after device reset is 0. The semantic of
>> all other values can be defined freely by the chosen protocol.
>>
>> ### State Table
>>
>> The State Table is a read-only section at the beginning of the shared
>> memory region. It contains a 32-bit state value for each of the
>> peers. Locating the table in shared memory allows fast checking of
>> remote states without register accesses.
>>
>> The table is updated on each state change of a peers. Whenever a user
>> of an IVSHMEM device writes a value to the Local State register, this
>> value is copied into the corresponding entry of the State Table. When
>> a IVSHMEM device is reset or disconnected from the other peers, zero
>> is written into the corresponding table entry. The initial content of
>> the table is all zeros.
>>
>>     +--------------------------------+
>>     | 32-bit state value of peer n-1 |
>>     +--------------------------------+
>>     :                                :
>>     +--------------------------------+
>>     | 32-bit state value of peer 1   |
>>     +--------------------------------+
>>     | 32-bit state value of peer 0   |
>>     +--------------------------------+ <-- Shared memory base address
>>
>>
>> Protocols
>> ---------
>>
>> The IVSHMEM device shall support the peers of a connection in
>> agreeing on the protocol used over the shared memory devices. For
>> that purpose, the interface byte (offset 09h) and the sub-class byte
>> (offset 0Ah) of the Class Code register encodes a 16-bit protocol
>> type for the users. The following type values are defined:
>>
>> | Protocol Type | Description                                                  |
>> |--------------:|:-------------------------------------------------------------|
>> |         0000h | Undefined type                                               |
>> |         0001h | Virtual peer-to-peer Ethernet                                |
>> |   0002h-3FFFh | Reserved                                                     |
>> |   4000h-7FFFh | User-defined protocols                                       |
>> |   8000h-BFFFh | Virtio over Shared Memory, front-end peer                    |
>> |   C000h-FFFFh | Virtio over Shared Memory, back-end peer                     |
>>
>> Details of the protocols are not in the scope of this specification.
> 
> Otherwise it reads fine to me.  I'm sure some of my confusion is from
> not being familiar with the details of PCI devices.
> 

We could link into chapters of PCI spec directly if that helps.

Thanks for the feedback!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

