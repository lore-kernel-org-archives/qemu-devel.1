Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B8BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB3B2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB3B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwT3C-0005tl-Go
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jwT1u-0004oB-Ml
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:16:10 -0400
Received: from goliath.siemens.de ([192.35.17.28]:33987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jwT1p-0000AB-An
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:16:09 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06HGFxL1001740
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2020 18:15:59 +0200
Received: from [167.87.7.111] ([167.87.7.111])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06HGFwwj011900;
 Fri, 17 Jul 2020 18:15:58 +0200
Subject: Re: [virtio-comment] [RFC] ivshmem v2: Shared memory device
 specification
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200715132748.GA20677@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <88a33034-783a-07d2-85e0-c1a1ecd2721f@siemens.com>
Date: Fri, 17 Jul 2020 18:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715132748.GA20677@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.35.17.28; envelope-from=jan.kiszka@siemens.com;
 helo=goliath.siemens.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 12:16:01
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15.07.20 15:27, Stefan Hajnoczi wrote:
> On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
>> IVSHMEM Device Specification
>> ============================
>>
>> ** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE SPECIFICATION! **
> 
> Hi Jan,
> Thanks for posting this! I have a posted comments where I wasn't sure
> what the spec meant.
> 
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
>>      - common read/writable section
>>
>>      - output sections that are read/writable for one peer and only
>>        readable for the others
>>
>>      - section with peer states
>>
>> - Event signaling via interrupt to remote sides
>>
>> - Support for life-cycle management via state value exchange and
>>    interrupt notification on changes, backed by a shared memory
>>    section
>>
>> - Free choice of protocol to be used on top
>>
>> - Protocol type declaration
>>
>> - Register can be implemented either memory-mapped or via I/O,
>>    depending on platform support and lower VM-exit costs
>>
>> - Unprivileged access to memory-mapped or I/O registers feasible
>>
>> - Single discovery and configuration via standard PCI, no complexity
>>    by additionally defining a platform device model
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
>>    users.
>>
>> - The read/write shared memory section has to be of the same size for
>>    all peers. The size can be zero.
>>
>> - If shared memory output sections are present (non-zero section
>>    size), there must be one reserved for each peer with exclusive
>>    write access. All output sections must have the same size and must
>>    be readable for all peers.
>>
>> - The State Table must have the same size for all peers, must be
>>    large enough to hold the state values of all peers, and must be
>>    read-only for the user.
> 
> Who/what is the "user"? I guess this simply means that the State Table
> is read-only and only the hypervisor can update the table entries?

Read-only for the guest, right. I used the term "user" here and 
elsewhere, switching to "guest" might be better.

> 
>> - State register changes (explicit writes, peer resets) have to be
>>    propagated to the other peers by updating the corresponding State
>>    Table entry and issuing an interrupt to all other peers if they
>>    enabled reception.
>>
>> - Interrupts events triggered by a peer have to be delivered to the
>>    target peer, provided the receiving side is valid and has enabled
>>    the reception.
>>
>> - All peers must have the same interrupt delivery features available,
>>    i.e. MSI-X with the same maximum number of vectors on platforms
>>    supporting this mechanism, otherwise INTx with one vector.
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
>>      +-----------------------------+   -
>>      |                             |   :
>>      | Output Section for peer n-1 |   : Output Section Size
>>      |     (n = Maximum Peers)     |   :
>>      +-----------------------------+   -
>>      :                             :
>>      :                             :
>>      :                             :
>>      +-----------------------------+   -
>>      |                             |   :
>>      |  Output Section for peer 1  |   : Output Section Size
>>      |                             |   :
>>      +-----------------------------+   -
>>      |                             |   :
>>      |  Output Section for peer 0  |   : Output Section Size
>>      |                             |   :
>>      +-----------------------------+   -
>>      |                             |   :
>>      |     Read/Write Section      |   : R/W Section Size
>>      |                             |   :
>>      +-----------------------------+   -
>>      |                             |   :
>>      |         State Table         |   : State Table Size
>>      |                             |   :
>>      +-----------------------------+   <-- Shared memory base address
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
> 
> s/fourths/fourth/
> 
>>
>> All sizes have to be rounded up to multiples of a mappable page in
>> order to allow access control according to the section restrictions.
> 
> The host's mappable page size? I guess the guest's page size doesn't
> matter here.

It does, in fact. This is to allow unprivileged direct access to memory 
regions (as well as the register space), i.e. to enable the guest OS to 
map the regions without overlaps.

> 
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
> What does relocatable mean in this context?

That the guest can decide (via BAR) where the resource should show up in 
the physical guest address space. We do not want to support this in 
setups like for static partitioning hypervisors, and then we use that 
side-channel read-only configuration.

> 
>>
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
>> |    18h | Base Address        | optional: 64-bit base address of shared memory |
>>
>> All registers are read-only. Writes are ignored, except to bit 0 of
>> the Privileged Control register.
>>
>> When bit 0 in the Privileged Control register is set to 1, the device
>> clears bit 0 in the Interrupt Control register on each interrupt
>> delivery.
> 
> The Interrupt Control register has not be defined yet at this point in
> the spec. Maybe you can rearrange this or include a reference to the
> section on the Interrupt Control register.

I can add a reference.

> 
>> This enables automatic interrupt throttling when
>> re-enabling shall be performed by a scheduled unprivileged instance
>> on the user side.
> 
> This last sentence is hard to parse.
> 
> I guess the flow is:
> 
> 1. Guest sets Interrupt Control Bit 0 to 1 to enable interrupts from a
>     peer.
> 2. Peer writes doorbell and the hypervisor clears Interrupt Control Bit
>     0 and raises the interrupt.
> 3. The guest's interrupt handler is scheduled at a later point in time.
>     If any additional doorbell writes occur then will not result in
>     additional interrupts until the guest sets Interrupt Control again.

Right, that is the behavior. The reasoning is in the second half of my 
short explanation: We want to use for setups like UIO, where the final 
consumer is an unprivileged application. That applicaiton shall not be 
able to cause incoming interrupts at a rate higher than its own 
schedule. And that is achieved by forcing it to re-enable IRQs (via 
directly mapped MMIO regs) when it actually runs again.

> 
> Does this mean the peer still takes a vmexit writing to the doorbell
> register but the hypervisor ignores the write?

Yes, this is no optimization for kick-related vmexits. I would consider 
that an application-level thing, doable - like in virtio - via 
protocol-specific fields in the shared memory.

> 
> VIRTIO exposes whether notifications are desired in shared memory. That
> way the peer can skip the doorbell write entirely (saving a vmexit).
> This is a fast approach for software device implementations (slow for
> hardware implementations because they would need to do a DMA read).

Which if fine and should actually work as-is when mapping virtio over 
ivshmem. Other ivshmem protocols may implement their own peer-to-peer 
hints for skipping kicks.

> 
>>
>> An IVSHMEM device may not support a relocatable shared memory region.
>> This support the hypervisor in locking down the guest-to-host address

Maybe better: "This allows the hypervisor to lock down..."

>> mapping and simplifies the runtime logic. In such a case, BAR 2 must
>> not be implemented by the hypervisor. Instead, the Base Address
>> register has to be implemented to report the location of the shared
>> memory region in the user's address space.
> 
> This paragraph is confusing. There seem to be two concepts:
> 
> 1. Relocatable memory. Placing shared memory at a fixed addresses
>     eliminates the need for address translation. But this seems like a
>     security issue if a peer can make me access an arbitrary address, why
>     not just use relative addresses from the start of the shared memory
>     region?

The interpretation of addresses in the shared memory is completely up to 
the protocol used on top of ivshmem, thus is out of scope for this spec. 
The protocol may use relative addresses or some other basis. If fact, it 
should use relative addresses because this ivshmem spec does not provide 
means to tell all peers if they see the shared memory at the same guest 
physical base addresses.

> 
> 2. Location of shared memory. BAR 2 is a regular PCI bar and the memory
>     is located on the device. In the non-BAR 2 case I think the spec says
>     the shared memory is located in guest RAM instead?

Maybe we should clarify the second aspect: If shared memory is described 
via the side-channel, it is still a resource separate from guest RAM. 
That is at least how Jailhouse implements it, and I do not see a use 
case yet for doing it differently.

> 
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
> 
> Isn't the PBA just used for masked MSI-X interrupts? That is a standard
> MSI-X feature.
> 
> On a minimal system that doesn't used masking it makes sense to strip
> down the implementation, but I think the spec should allow for PCI
> compliance.

Well, we are already in incompliance when we allow PBA to be 
non-functional or when we make INTx and edge interrupt. Both is to make 
things virtualization friendly (low overhead for the guest, low effort 
for the host). If compliance has a strong use case, we can allow that, 
but I would like to see the use case first.

> 
>> The corresponding MSI-X MMIO region is configured via BAR 1.
>>
>> The MSI-X table size reported by the MSI-X capability structure is
>> identical for all peers.
>>
>> ### Register Region
>>
>> The register region may be implemented as MMIO or I/O.
> 
> Is that "either MMIO or I/O" or "MMIO and/or I/O"?

Was thought of as "either ... or". No implementation for I/O exists so 
for, though.

> 
> Drivers and devices will have to implement both anyway to be compatible
> with all other devices and drivers, respectively. But allowing both MMIO
> and I/O at the same time ensures that a device will work with any
> driver.

In fact, I would then rather consider to drop the (so far unused) I/O 
option to avoid having to implement that even more complex case.

> 
>> When implementing it as MMIO, the hypervisor has to ensure that the
>> register region can be mapped as a single page into the address space
>> of the user, without causing potential overlaps with other resources.
> 
> Can "page size" be replaced with a specific value like 4 KB? In general
> devices shouldn't know about CPU MMU page sizes because they vary.

It's a configuration thing of your hypervisor, in practice. The 
hypervisor should allow the system configurator to specify also larger 
sizes of the MMIO region. We just had the case that TI needed 64K for 
the kernel of their J721e SDK (which I suggested them to avoid, but for 
different reasons).

> 
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
> 
> What is the purpose of the ID?

- find out which is my output region
- differentiate from other peers (regarding input regions, state table
   fields, doorbell targets)

> 
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
> 
> This is a global interrupt enable/disable for all vectors?

Yes, that is the current model. I didn't consider of per-vector control 
so far. That's probably because UIO does not support multiple vectors, 
and there was no other use case for this register yet. If we added 
per-vector support, we would limit the vector number or would need more 
registers...

> 
>> #### Doorbell Register (Offset 0Ch)
>>
>> Write-only register that triggers an interrupt vector in the target
>> device if it is enabled there.
>>
>> | Bits  | Content                                                              |
>> |------:|:---------------------------------------------------------------------|
>> |  0-15 | Vector number                                                        |
>> | 16-31 | Target ID                                                            |
> 
> s/Target ID/Peer/ ?

ID refers to the ID register. Target is what the doorbell is targeting.

> 
>>
>> Writing a vector number that is not enabled by the target has no
>> effect. The peers can derive the number of available vectors from
>> their own device capabilities because the provider is required to
> 
> What is the "provider"? The hypervisor?

Yes. I think I didn't consistently switch from the former more abstract 
"provider of this device" term to "hypervisor".

> 
>> expose an identical number of vectors to all connected peers. The
>> peers are expected to define or negotiate the used ones via the
> 
> s/ones/vectors/ is clearer
> 
>> selected protocol.
>>
>> Addressing a non-existing or inactive target has no effect. Peers can
>> identify active targets via the State Table.
>>
>> Implementations of the Doorbell register must ensure that data written by the
>> CPU prior to issuing the register write is visible to the receiving peer before
>> the interrupt arrives.
> 
> Physical devices have no control over CPU memory ordering. Normally the
> drivers have the necessary memory barriers. Why is it the device's
> responsibility to do this in IVSHMEM v2?

It's an optimizing requirement: When the guest does not know if the 
hypervisor uses a synchronizing mechanism to actually submit the 
interrupt, it has to add an unconditional barrier in case it is actually 
needed. In contrast, it is easy for the hypervisor to add a barrier when 
the kick mechanism should in come with an implicit one.

> 
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
> 
> Does this mean drivers using INTx must compare the state table entries
> for their peers on each interrupt to differentiate from doorbell events?
> That seems inefficient.

Yes, single-vector INTx is not optimal. But the state table is in RAM, 
and it will only become noteworthy when you have dozens of peers. In 
that case, I would indeed recommend providing an MSI-X implementation.

Markus already asked if we couldn't drop INTx. On the long run, he is 
right as most newer SOCs come with support for MSI-X, thus the guests 
can also handle virtually injected events. Existing SOCs do not always, 
so that's why INTx is here.

> 
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
>>      +--------------------------------+
>>      | 32-bit state value of peer n-1 |
>>      +--------------------------------+
>>      :                                :
>>      +--------------------------------+
>>      | 32-bit state value of peer 1   |
>>      +--------------------------------+
>>      | 32-bit state value of peer 0   |
>>      +--------------------------------+ <-- Shared memory base address
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
> If I understand correctly the reason for creating IVSHMEM v2 is to
> support non-VIRTIO devices? If you just want VIRTIO devices then IVSHMEM
> v2 + VIRTIO is more complex than a pure VIRTIO solution. But if you
> don't want VIRTIO then IVSHMEM + a minimal device can be simpler than
> VIRTIO.

One reason is to provide non-virtio "devices" or rather simple 
application-to-application protocols. Many embedded hypervisor offer 
this already today, as it is simple and "flexible" (hacky...). But the 
other reason is to provide the simplest possible transport for virtio 
(from the hypervisor POV) that does not require knowing all the 
countless details of virtio. Such a stack will allow to keep the trusted 
hypervisor core untouched when adding a new virtio device. Try that with 
PCI or MMIO transport. The price of implementating virtio natively into 
a 5-10 thousand LoC hypervisor is simply too high. Or it ends up in 
non-robust, insecure or even worse architectures.

Thanks for the feedback!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

