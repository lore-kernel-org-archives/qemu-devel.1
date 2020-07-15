Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E9FC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF5A20578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFhdrt0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF5A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhSh-0000aW-V4
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jvhS5-00008b-Uf
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:28:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jvhS3-0000fN-1F
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594819677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARuQZeNUyJeazGrLaVL87YovuyuvBqJjoTxtSJ1hx2c=;
 b=RFhdrt0X/8npFWfgdW1IMLjyEnNLzVR1PiBD8aKlXRSobt7Rb+CA1jNv7ZOn92KbxpOQMI
 ZekfGu/M1xdsfyVWn/J3q2JQbfBd6XnFsrgCV3pb7dDZQ493XiTVOGzREevfm9bmq/QoiT
 lsiRHyW3JfyvmolLwwgd2gc2vwuNSik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-omuylC_QPI6WBfsgEBVZ_A-1; Wed, 15 Jul 2020 09:27:55 -0400
X-MC-Unique: omuylC_QPI6WBfsgEBVZ_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88C8D1009615;
 Wed, 15 Jul 2020 13:27:53 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5F5A2B583;
 Wed, 15 Jul 2020 13:27:49 +0000 (UTC)
Date: Wed, 15 Jul 2020 14:27:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [virtio-comment] [RFC] ivshmem v2: Shared memory device
 specification
Message-ID: <20200715132748.GA20677@stefanha-x1.localdomain>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
MIME-Version: 1.0
In-Reply-To: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
> IVSHMEM Device Specification
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> ** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE SPECIFICATI=
ON! **

Hi Jan,
Thanks for posting this! I have a posted comments where I wasn't sure
what the spec meant.

> The goal of the Inter-VM Shared Memory (IVSHMEM) device model is to
> define the minimally needed building blocks a hypervisor has to
> provide for enabling guest-to-guest communication. The details of
> communication protocols shall remain opaque to the hypervisor so that
> guests are free to define them as simple or sophisticated as they
> need.
>=20
> For that purpose, the IVSHMEM provides the following features to its
> users:
>=20
> - Interconnection between up to 65536 peers
>=20
> - Multi-purpose shared memory region
>=20
>     - common read/writable section
>=20
>     - output sections that are read/writable for one peer and only
>       readable for the others
>=20
>     - section with peer states
>=20
> - Event signaling via interrupt to remote sides
>=20
> - Support for life-cycle management via state value exchange and
>   interrupt notification on changes, backed by a shared memory
>   section
>=20
> - Free choice of protocol to be used on top
>=20
> - Protocol type declaration
>=20
> - Register can be implemented either memory-mapped or via I/O,
>   depending on platform support and lower VM-exit costs
>=20
> - Unprivileged access to memory-mapped or I/O registers feasible
>=20
> - Single discovery and configuration via standard PCI, no complexity
>   by additionally defining a platform device model
>=20
>=20
> Hypervisor Model
> ----------------
>=20
> In order to provide a consistent link between peers, all connected
> instances of IVSHMEM devices need to be configured, created and run
> by the hypervisor according to the following requirements:
>=20
> - The instances of the device shall appear as a PCI device to their
>   users.
>=20
> - The read/write shared memory section has to be of the same size for
>   all peers. The size can be zero.
>=20
> - If shared memory output sections are present (non-zero section
>   size), there must be one reserved for each peer with exclusive
>   write access. All output sections must have the same size and must
>   be readable for all peers.
>=20
> - The State Table must have the same size for all peers, must be
>   large enough to hold the state values of all peers, and must be
>   read-only for the user.

Who/what is the "user"? I guess this simply means that the State Table
is read-only and only the hypervisor can update the table entries?

> - State register changes (explicit writes, peer resets) have to be
>   propagated to the other peers by updating the corresponding State
>   Table entry and issuing an interrupt to all other peers if they
>   enabled reception.
>=20
> - Interrupts events triggered by a peer have to be delivered to the
>   target peer, provided the receiving side is valid and has enabled
>   the reception.
>=20
> - All peers must have the same interrupt delivery features available,
>   i.e. MSI-X with the same maximum number of vectors on platforms
>   supporting this mechanism, otherwise INTx with one vector.
>=20
>=20
> Guest-side Programming Model
> ----------------------------
>=20
> An IVSHMEM device appears as a PCI device to its users. Unless
> otherwise noted, it conforms to the PCI Local Bus Specification,
> Revision 3.0. As such, it is discoverable via the PCI configuration
> space and provides a number of standard and custom PCI configuration
> registers.
>=20
> ### Shared Memory Region Layout
>=20
> The shared memory region is divided into several sections.
>=20
>     +-----------------------------+   -
>     |                             |   :
>     | Output Section for peer n-1 |   : Output Section Size
>     |     (n =3D Maximum Peers)     |   :
>     +-----------------------------+   -
>     :                             :
>     :                             :
>     :                             :
>     +-----------------------------+   -
>     |                             |   :
>     |  Output Section for peer 1  |   : Output Section Size
>     |                             |   :
>     +-----------------------------+   -
>     |                             |   :
>     |  Output Section for peer 0  |   : Output Section Size
>     |                             |   :
>     +-----------------------------+   -
>     |                             |   :
>     |     Read/Write Section      |   : R/W Section Size
>     |                             |   :
>     +-----------------------------+   -
>     |                             |   :
>     |         State Table         |   : State Table Size
>     |                             |   :
>     +-----------------------------+   <-- Shared memory base address
>=20
> The first section consists of the mandatory State Table. Its size is
> defined by the State Table Size register and cannot be zero. This
> section is read-only for all peers.
>=20
> The second section consists of shared memory that is read/writable
> for all peers. Its size is defined by the R/W Section Size register.
> A size of zero is permitted.
>=20
> The third and following sections are output sections, one for each
> peer. Their sizes are all identical. The size of a single output
> section is defined by the Output Section Size register. An output
> section is read/writable for the corresponding peer and read-only for
> all other peers. E.g., only the peer with ID 3 can write to the
> fourths output section, but all peers can read from this section.

s/fourths/fourth/

>=20
> All sizes have to be rounded up to multiples of a mappable page in
> order to allow access control according to the section restrictions.

The host's mappable page size? I guess the guest's page size doesn't
matter here.

>=20
> ### Configuration Space Registers
>=20
> #### Header Registers
>=20
> | Offset | Register               | Content                              =
                |
> |-------:|:-----------------------|:-------------------------------------=
----------------|
> |    00h | Vendor ID              | 110Ah                                =
                |
> |    02h | Device ID              | 4106h                                =
                |
> |    04h | Command Register       | 0000h on reset, writable bits are:   =
                |
> |        |                        | Bit 0: I/O Space (if Register Region =
uses I/O)       |
> |        |                        | Bit 1: Memory Space (if Register Regi=
on uses Memory) |
> |        |                        | Bit 3: Bus Master                    =
                |
> |        |                        | Bit 10: INTx interrupt disable       =
                |
> |        |                        | Writes to other bits are ignored     =
                |
> |    06h | Status Register        | 0010h, static value                  =
                |
> |        |                        | In deviation to the PCI specification=
, the Interrupt |
> |        |                        | Status (bit 3) is never set          =
                |
> |    08h | Revision ID            | 00h                                  =
                |
> |    09h | Class Code, Interface  | Protocol Type bits 0-7, see [Protocol=
s](#Protocols)  |
> |    0Ah | Class Code, Sub-Class  | Protocol Type bits 8-15, see [Protoco=
ls](#Protocols) |
> |    0Bh | Class Code, Base Class | FFh                                  =
                |
> |    0Eh | Header Type            | 00h                                  =
                |
> |    10h | BAR 0                  | MMIO or I/O register region          =
                |
> |    14h | BAR 1                  | MSI-X region                         =
                |
> |    18h | BAR 2 (with BAR 3)     | optional: 64-bit shared memory region=
                |
> |    2Ch | Subsystem Vendor ID    | same as Vendor ID, or provider-specif=
ic value        |
> |    2Eh | Subsystem ID           | same as Device ID, or provider-specif=
ic value        |
> |    34h | Capability Pointer     | First capability                     =
                |
> |    3Eh | Interrupt Pin          | 01h-04h, must be 00h if MSI-X is avai=
lable           |
>=20
> The INTx status bit is never set by an implementation. Users of the
> IVSHMEM device are instead expected to derive the event state from
> protocol-specific information kept in the shared memory. This
> approach is significantly faster, and the complexity of
> register-based status tracking can be avoided.
>=20
> If BAR 2 is not present, the shared memory region is not relocatable
> by the user. In that case, the hypervisor has to implement the Base
> Address register in the vendor-specific capability.

What does relocatable mean in this context?

>=20
> Subsystem IDs shall encode the provider (hypervisor) in order to
> allow identifying potential deviating implementations in case this
> should ever be required.
>=20
> If its platform supports MSI-X, an implementation of the IVSHMEM
> device must provide this interrupt model and must not expose INTx
> support.
>=20
> Other header registers may not be implemented. If not implemented,
> they return 0 on read and ignore write accesses.
>=20
> #### Vendor Specific Capability (ID 09h)
>=20
> This capability must always be present.
>=20
> | Offset | Register            | Content                                 =
       |
> |-------:|:--------------------|:----------------------------------------=
-------|
> |    00h | ID                  | 09h                                     =
       |
> |    01h | Next Capability     | Pointer to next capability or 00h       =
       |
> |    02h | Length              | 20h if Base Address is present, 18h othe=
rwise  |
> |    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt m=
ode    |
> |        |                     | Bits 1-7: Reserved (0 on read, writes ig=
nored) |
> |    04h | State Table Size    | 32-bit size of read-only State Table    =
       |
> |    08h | R/W Section Size    | 64-bit size of common read/write section=
       |
> |    10h | Output Section Size | 64-bit size of output sections          =
       |
> |    18h | Base Address        | optional: 64-bit base address of shared =
memory |
>=20
> All registers are read-only. Writes are ignored, except to bit 0 of
> the Privileged Control register.
>=20
> When bit 0 in the Privileged Control register is set to 1, the device
> clears bit 0 in the Interrupt Control register on each interrupt
> delivery.

The Interrupt Control register has not be defined yet at this point in
the spec. Maybe you can rearrange this or include a reference to the
section on the Interrupt Control register.

> This enables automatic interrupt throttling when
> re-enabling shall be performed by a scheduled unprivileged instance
> on the user side.

This last sentence is hard to parse.

I guess the flow is:

1. Guest sets Interrupt Control Bit 0 to 1 to enable interrupts from a
   peer.
2. Peer writes doorbell and the hypervisor clears Interrupt Control Bit
   0 and raises the interrupt.
3. The guest's interrupt handler is scheduled at a later point in time.
   If any additional doorbell writes occur then will not result in
   additional interrupts until the guest sets Interrupt Control again.

Does this mean the peer still takes a vmexit writing to the doorbell
register but the hypervisor ignores the write?

VIRTIO exposes whether notifications are desired in shared memory. That
way the peer can skip the doorbell write entirely (saving a vmexit).
This is a fast approach for software device implementations (slow for
hardware implementations because they would need to do a DMA read).

>=20
> An IVSHMEM device may not support a relocatable shared memory region.
> This support the hypervisor in locking down the guest-to-host address
> mapping and simplifies the runtime logic. In such a case, BAR 2 must
> not be implemented by the hypervisor. Instead, the Base Address
> register has to be implemented to report the location of the shared
> memory region in the user's address space.

This paragraph is confusing. There seem to be two concepts:

1. Relocatable memory. Placing shared memory at a fixed addresses
   eliminates the need for address translation. But this seems like a
   security issue if a peer can make me access an arbitrary address, why
   not just use relative addresses from the start of the shared memory
   region?

2. Location of shared memory. BAR 2 is a regular PCI bar and the memory
   is located on the device. In the non-BAR 2 case I think the spec says
   the shared memory is located in guest RAM instead?

> A non-existing shared memory section has to report zero in its
> Section Size register.
>=20
> #### MSI-X Capability (ID 11h)
>=20
> On platforms supporting MSI-X, IVSHMEM has to provide interrupt
> delivery via this mechanism. In that case, the MSI-X capability is
> present while the legacy INTx delivery mechanism is not available,
> and the Interrupt Pin configuration register returns 0.
>=20
> The IVSHMEM device has no notion of pending interrupts. Therefore,
> reading from the MSI-X Pending Bit Array will always return 0. Users
> of the IVSHMEM device are instead expected to derive the event state
> from protocol-specific information kept in the shared memory. This
> approach is significantly faster, and the complexity of
> register-based status tracking can be avoided.

Isn't the PBA just used for masked MSI-X interrupts? That is a standard
MSI-X feature.

On a minimal system that doesn't used masking it makes sense to strip
down the implementation, but I think the spec should allow for PCI
compliance.

> The corresponding MSI-X MMIO region is configured via BAR 1.
>=20
> The MSI-X table size reported by the MSI-X capability structure is
> identical for all peers.
>=20
> ### Register Region
>=20
> The register region may be implemented as MMIO or I/O.

Is that "either MMIO or I/O" or "MMIO and/or I/O"?

Drivers and devices will have to implement both anyway to be compatible
with all other devices and drivers, respectively. But allowing both MMIO
and I/O at the same time ensures that a device will work with any
driver.

> When implementing it as MMIO, the hypervisor has to ensure that the
> register region can be mapped as a single page into the address space
> of the user, without causing potential overlaps with other resources.

Can "page size" be replaced with a specific value like 4 KB? In general
devices shouldn't know about CPU MMU page sizes because they vary.

> Write accesses to MMIO region offsets that are not backed by
> registers have to be ignored, read accesses have to return 0. This
> enables the user to hand out the complete region, along with the
> shared memory, to an unprivileged instance.
>=20
> The region location in the user's physical address space is
> configured via BAR 0. The following table visualizes the region
> layout:
>=20
> | Offset | Register                                                      =
      |
> |-------:|:--------------------------------------------------------------=
------|
> |    00h | ID                                                            =
      |
> |    04h | Maximum Peers                                                 =
      |
> |    08h | Interrupt Control                                             =
      |
> |    0Ch | Doorbell                                                      =
      |
> |    10h | State                                                         =
      |
>=20
> All registers support only aligned 32-bit accesses.
>=20
> #### ID Register (Offset 00h)
>=20
> Read-only register that reports the ID of the local device. It is
> unique for all of the connected devices and remains unchanged over
> their lifetime.

What is the purpose of the ID?

> #### Maximum Peers Register (Offset 04h)
>=20
> Read-only register that reports the maximum number of possible peers
> (including the local one). The permitted range is between 2 and 65536
> and remains constant over the lifetime of all peers.
>=20
> #### Interrupt Control Register (Offset 08h)
>=20
> This read/write register controls the generation of interrupts
> whenever a peer writes to the Doorbell register or changes its state.
>=20
> | Bits | Content                                                         =
      |
> |-----:|:----------------------------------------------------------------=
------|
> |    0 | 1: Enable interrupt generation                                  =
      |
> | 1-31 | Reserved (0 on read, writes ignored)                            =
      |
>=20
> Note that bit 0 is reset to 0 on interrupt delivery if one-shot
> interrupt mode is enabled in the Enhanced Features register.
>=20
> The value of this register after device reset is 0.

This is a global interrupt enable/disable for all vectors?

> #### Doorbell Register (Offset 0Ch)
>=20
> Write-only register that triggers an interrupt vector in the target
> device if it is enabled there.
>=20
> | Bits  | Content                                                        =
      |
> |------:|:---------------------------------------------------------------=
------|
> |  0-15 | Vector number                                                  =
      |
> | 16-31 | Target ID                                                      =
      |

s/Target ID/Peer/ ?

>=20
> Writing a vector number that is not enabled by the target has no
> effect. The peers can derive the number of available vectors from
> their own device capabilities because the provider is required to

What is the "provider"? The hypervisor?

> expose an identical number of vectors to all connected peers. The
> peers are expected to define or negotiate the used ones via the

s/ones/vectors/ is clearer

> selected protocol.
>=20
> Addressing a non-existing or inactive target has no effect. Peers can
> identify active targets via the State Table.
>=20
> Implementations of the Doorbell register must ensure that data written by=
 the
> CPU prior to issuing the register write is visible to the receiving peer =
before
> the interrupt arrives.

Physical devices have no control over CPU memory ordering. Normally the
drivers have the necessary memory barriers. Why is it the device's
responsibility to do this in IVSHMEM v2?

>=20
> The behavior on reading from this register is undefined.
>=20
> #### State Register (Offset 10h)
>=20
> Read/write register that defines the state of the local device.
> Writing to this register sets the state and triggers MSI-X vector 0
> or the INTx interrupt, respectively, on the remote device if the
> written state value differs from the previous one. Users of peer
> devices can read the value written to this register from the State
> Table. They are expected differentiate state change interrupts from
> doorbell events by comparing the new state value with a locally
> stored copy.

Does this mean drivers using INTx must compare the state table entries
for their peers on each interrupt to differentiate from doorbell events?
That seems inefficient.

>=20
> The value of this register after device reset is 0. The semantic of
> all other values can be defined freely by the chosen protocol.
>=20
> ### State Table
>=20
> The State Table is a read-only section at the beginning of the shared
> memory region. It contains a 32-bit state value for each of the
> peers. Locating the table in shared memory allows fast checking of
> remote states without register accesses.
>=20
> The table is updated on each state change of a peers. Whenever a user
> of an IVSHMEM device writes a value to the Local State register, this
> value is copied into the corresponding entry of the State Table. When
> a IVSHMEM device is reset or disconnected from the other peers, zero
> is written into the corresponding table entry. The initial content of
> the table is all zeros.
>=20
>     +--------------------------------+
>     | 32-bit state value of peer n-1 |
>     +--------------------------------+
>     :                                :
>     +--------------------------------+
>     | 32-bit state value of peer 1   |
>     +--------------------------------+
>     | 32-bit state value of peer 0   |
>     +--------------------------------+ <-- Shared memory base address
>=20
>=20
> Protocols
> ---------
>=20
> The IVSHMEM device shall support the peers of a connection in
> agreeing on the protocol used over the shared memory devices. For
> that purpose, the interface byte (offset 09h) and the sub-class byte
> (offset 0Ah) of the Class Code register encodes a 16-bit protocol
> type for the users. The following type values are defined:
>=20
> | Protocol Type | Description                                            =
      |
> |--------------:|:-------------------------------------------------------=
------|
> |         0000h | Undefined type                                         =
      |
> |         0001h | Virtual peer-to-peer Ethernet                          =
      |
> |   0002h-3FFFh | Reserved                                               =
      |
> |   4000h-7FFFh | User-defined protocols                                 =
      |
> |   8000h-BFFFh | Virtio over Shared Memory, front-end peer              =
      |
> |   C000h-FFFFh | Virtio over Shared Memory, back-end peer               =
      |
>=20
> Details of the protocols are not in the scope of this specification.

If I understand correctly the reason for creating IVSHMEM v2 is to
support non-VIRTIO devices? If you just want VIRTIO devices then IVSHMEM
v2 + VIRTIO is more complex than a pure VIRTIO solution. But if you
don't want VIRTIO then IVSHMEM + a minimal device can be simpler than
VIRTIO.

Stefan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8PBFQACgkQnKSrs4Gr
c8hQ2Qf/aXiZ1PCvABaXKoW7kpRn6MrNLkBsM6rCFYJ/Z0Rl0MTgcW18LqvdH8bP
xImxp2YpCery5R3YqM0CoqgBc1eqC3G6hAYo52EuHWOkzDYsbCaNtUggNvHWOSMF
rhd+MgArLSIpeYRmFkRLzkL/wYdXrrTvPbQwkPkdqiiYQRuCAen6Aa2ZfVWZlyc2
jg+iP1N+XunzYrSs7CxA4hOI7A2zsqnkT0Uj8rSANKz/cNSeaAZJEyiDlby0U1ES
dgGc/u5ZQ/N3i/Hald2NWqj+BoJ6cDFmMI3h2vKrlNGjkRhF6wBXY8vYGcecXN51
is1TQ3g0e4MVOjkfqqM/sRacU4tpfg==
=I4NV
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--


