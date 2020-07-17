Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FCCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CF720717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfXkPeeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CF720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPKR-00071Z-79
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jwPJd-0006J2-1M
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:18:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46860
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jwPJY-0000SB-Ca
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594988287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKaaIdn7SJuolsNdi21NTxBjrqMA3dgIvN6+Vw3eLwQ=;
 b=PfXkPeehpVDAPd5ZIcvdvKOjSP+95rFJBCJMImpXMbEYiF99b6l6STMCLVPzv8Blgek86g
 wSQYCqxhtU+lPTuC2BYf5BTHcR5rYj2pRrlNMsOKqpKdjDPexPku4cwyLAqqu6wvIyTtoH
 3DaWI7oqdcUufxqWcKIpvnp5LuAMMPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-QzPGE8ZeOAaxlyhH2oYrJQ-1; Fri, 17 Jul 2020 08:18:04 -0400
X-MC-Unique: QzPGE8ZeOAaxlyhH2oYrJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA7EE921;
 Fri, 17 Jul 2020 12:18:02 +0000 (UTC)
Received: from localhost (ovpn-114-107.ams2.redhat.com [10.36.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8855572AC7;
 Fri, 17 Jul 2020 12:17:54 +0000 (UTC)
Date: Fri, 17 Jul 2020 13:17:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
Message-ID: <20200717121753.GK128195@stefanha-x1.localdomain>
References: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com,
 tomassetti.andrea@gmail.com, John G Johnson <john.g.johnson@oracle.com>,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 konrad.wilk@oracle.com, yuvalkashtan@gmail.com, qemu-devel@nongnu.org,
 raphael.norwitz@nutanix.com, ismael@linux.com, alex.williamson@redhat.com,
 Kanth.Ghatraju@oracle.com, felipe@nutanix.com, marcandre.lureau@redhat.com,
 tina.zhang@intel.com, changpeng.liu@intel.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 08:31:43AM -0700, Thanos Makatos wrote:
> This patch introduces the VFIO-over-socket protocol specification, which
> is designed to allow devices to be emulated outside QEMU, in a separate
> process. VFIO-over-socket reuses the existing VFIO defines, structs and
> concepts.
>=20
> It has been earlier discussed as an RFC in:
> "RFC: use VFIO over a UNIX domain socket to implement device offloading"
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>  docs/devel/vfio-over-socket.rst | 1135 +++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 1135 insertions(+), 0 deletions(-)
>  create mode 100644 docs/devel/vfio-over-socket.rst

This is exciting! The spec is clear enough that I feel I could start
writing a client/server. There is enough functionality here to implement
real-world devices. Can you share links to client/server
implementations?

It would be useful to introduce a standard way of enumerating,
launching, and controlling device emulation processes. That doesn't need
to be part of this specification document though. In vhost-user there
are conventions for command-line parameters, process lifecycle, etc that
make it easier for management tools to run device processes (the
"Backend program conventions" section in vhost-user.rst).

> diff --git a/docs/devel/vfio-over-socket.rst b/docs/devel/vfio-over-socke=
t.rst
> new file mode 100644
> index 0000000..723b944
> --- /dev/null
> +++ b/docs/devel/vfio-over-socket.rst
> @@ -0,0 +1,1135 @@
> +***************************************
> +VFIO-over-socket Protocol Specification
> +***************************************
> +
> +Version 0.1

Please include a reference to the section below explaining how
versioning works.

Also, are there rules about noting versions when updating the spec? For
example:

  When making a change to this specification, the protocol version
  number must be included:

    The `foo` field contains ... Added in version 1.3.

> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +VFIO-over-socket, also known as vfio-user, is a protocol that allows a d=
evice

vfio-user is shorted. Now is the best time to start consistently using
"vfio-user" as the name for this protocol. Want to drop the name
VFIO-over-socket?

> +to be virtualized in a separate process outside of QEMU. VFIO-over-socke=
t

Is there anything QEMU-specific about this protocol?

I think the scope of this protocol is more general and it could be
described as:

  allows device emulation in a separate process outside of a Virtual
  Machine Monitor (VMM).

(Or "emulator" instead of VMM, if you prefer.)

> +devices consist of a generic VFIO device type, living inside QEMU, which=
 we

s/QEMU/the VMM/

> +call the client, and the core device implementation, living outside QEMU=
, which
> +we call the server. VFIO-over-socket can be the main transport mechanism=
 for
> +multi-process QEMU, however it can be used by other applications offerin=
g
> +device virtualization. Explaining the advantages of a
> +disaggregated/multi-process QEMU, and device virtualization outside QEMU=
 in
> +general, is beyond the scope of this document.
> +
> +This document focuses on specifying the VFIO-over-socket protocol. VFIO =
has
> +been chosen for the following reasons:

It's a little subtle here that "VFIO" means the Linux VFIO ioctl
interface. Expanding it a bit makes the rest of the text clearer:

  The `Linux VFIO ioctl
  interface
  <https://www.kernel.org/doc/html/latest/driver-api/vfio.html>`_ has
  been chosen as the base for this protocol for the following reasons:

> +
> +1) It is a mature and stable API, backed by an extensively used framewor=
k.
> +2) The existing VFIO client implementation (qemu/hw/vfio/) can be largel=
y
> +   reused.
> +
> +In a proof of concept implementation it has been demonstrated that using=
 VFIO
> +over a UNIX domain socket is a viable option. VFIO-over-socket is design=
ed with
> +QEMU in mind, however it could be used by other client applications. The
> +VFIO-over-socket protocol does not require that QEMU's VFIO client
> +implementation is used in QEMU. None of the VFIO kernel modules are requ=
ired
> +for supporting the protocol, neither in the client nor the server, only =
the
> +source header files are used.

In the long run only the last sentence in this paragraph needs to be in
the specification.

The proof of concept and QEMU-specific info is good to know for the
discussion right now, but I don't think this needs to be in the
specification.

> +
> +The main idea is to allow a virtual device to function in a separate pro=
cess in
> +the same host over a UNIX domain socket. A UNIX domain socket (AF_UNIX) =
is
> +chosen because we can trivially send file descriptors over it, which in =
turn
> +allows:
> +
> +* Sharing of guest memory for DMA with the virtual device process.

Should the spec start consistently using "server" instead of various
terms like "virtual device process"?

> +* Sharing of virtual device memory with the guest for fast MMIO.

The VIRTIO spec restricts itself to the terms "device" and "driver" so
that the scope isn't too specific to virtualization of software devices.
I think the same might be good here because who knows how
VFIO-over-socket will be used in the future. Maybe it will be used
outside the context of traditional guests. For example, it's a great
interface for writing device emulation tests and fuzzers!

I suggest consistently using "client" (for the guest) and "server" (for
the device emulation process). That way the spec isn't focussed on a
specific use case.

> +* Efficient sharing of eventfd's for triggering interrupts.
> +
> +However, other socket types could be used which allows the virtual devic=
e
> +process to run in a separate guest in the same host (AF_VSOCK) or remote=
ly
> +(AF_INET). Theoretically the underlying transport doesn't necessarily ha=
ve to
> +be a socket, however we don't examine such alternatives. In this documen=
t we
> +focus on using a UNIX domain socket and introduce basic support for the =
other
> +two types of sockets without considering performance implications.

This is a good place to be explicit about the protocol requirements:

Is file-descriptor passing necessary?

Is shared-memory necessary?

Is there always an in-band message-passing fallback for any operation
that can be optimized via fd passing?

By stating something about this in the spec it's easier to ensure that
the protocol continues to follow these design parameters in the future
when other people make modifications.

> +This document does not yet describe any internal details of the server-s=
ide
> +implementation, however QEMU's VFIO client implementation will have to b=
e
> +adapted according to this protocol in order to support VFIO-over-socket =
virtual
> +devices.

This paragraph about the QEMU implementation status can be dropped from
the specification.

> +
> +VFIO
> +=3D=3D=3D=3D
> +VFIO is a framework that allows a physical device to be securely passed =
through
> +to a user space process; the kernel does not drive the device at all.
> +Typically, the user space process is a VM and the device is passed throu=
gh to
> +it in order to achieve high performance. VFIO provides an API and the re=
quired
> +functionality in the kernel. QEMU has adopted VFIO to allow a guest virt=
ual
> +machine to directly access physical devices, instead of emulating them i=
n
> +software

s/software/software./

> +
> +VFIO-over-socket reuses the core VFIO concepts defined in its API, but
> +implements them as messages to be sent over a UNIX-domain socket. It doe=
s not

Can "UNIX-domain" be dropped here? If the protocol design is intended to
support other transports then it helps to avoid mentioning a specific
transport even if only AF_UNIX will be implemented in the beginning.

> +change the kernel-based VFIO in any way, in fact none of the VFIO kernel
> +modules need to be loaded to use VFIO-over-socket. It is also possible f=
or QEMU
> +to concurrently use the current kernel-based VFIO for one guest device, =
and use
> +VFIO-over-socket for another device in the same guest.
> +
> +VFIO Device Model
> +-----------------
> +A device under VFIO presents a standard VFIO model to the user process. =
Many

I'm not sure what the meaning of the first sentence is.

s/standard VFIO model/standard interface/ ?

> +of the VFIO operations in the existing kernel model use the ioctl() syst=
em
> +call, and references to the existing model are called the ioctl()
> +implementation in this document.
> +
> +The following sections describe the set of messages that implement the V=
FIO
> +device model over a UNIX domain socket. In many cases, the messages are =
direct
> +translations of data structures used in the ioctl() implementation. Mess=
ages
> +derived from ioctl()s will have a name derived from the ioctl() command =
name.
> +E.g., the VFIO_GET_INFO ioctl() command becomes a VFIO_USER_GET_INFO mes=
sage.
> +The purpose for this reuse is to share as much code as feasible with the
> +ioctl() implementation.
> +
> +Client and Server
> +^^^^^^^^^^^^^^^^^
> +The socket connects two processes together: a client process and a serve=
r
> +process. In the context of this document, the client process is the proc=
ess
> +emulating a guest virtual machine, such as QEMU. The server process is a
> +process that provides device emulation.
> +
> +Connection Initiation
> +^^^^^^^^^^^^^^^^^^^^^
> +After the client connects to the server, the initial server message is
> +VFIO_USER_VERSION to propose a protocol version and set of capabilities =
to
> +apply to the session. The client replies with a compatible version and s=
et of
> +capabilities it will support, or closes the connection if it cannot supp=
ort the
> +advertised version.
> +
> +Guest Memory Configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +The client uses VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP messages to in=
form
> +the server of the valid guest DMA ranges that the server can access on b=
ehalf
> +of a device. Guest memory may be accessed by the server via VFIO_USER_DM=
A_READ
> +and VFIO_USER_DMA_WRITE messages over the socket.

"Guest" is a virtualization term. "DMA Memory Configuration" and "DMA
memory may be accessed ..." would be more general.

> +
> +An optimization for server access to guest memory is for the client to p=
rovide
> +file descriptors the server can mmap() to directly access guest memory. =
Note
> +that mmap() privileges cannot be revoked by the client, therefore file
> +descriptors should only be exported in environments where the client tru=
sts the
> +server not to corrupt guest memory.
> +
> +Device Information
> +^^^^^^^^^^^^^^^^^^
> +The client uses a VFIO_USER_DEVICE_GET_INFO message to query the server =
for
> +information about the device. This information includes:
> +
> +* The device type and capabilities,
> +* the number of memory regions, and

VFIO calls them "device regions", which is clearer:
1. It cannot be confused with "DMA Memory Regions"
2. It allows for I/O space in additional to Memory space

I suggest using "device regions" consistently.

> +* the device presents to the guest the number of interrupt types the dev=
ice
> +  supports.
> +
> +Region Information
> +^^^^^^^^^^^^^^^^^^
> +The client uses VFIO_USER_DEVICE_GET_REGION_INFO messages to query the s=
erver
> +for information about the device's memory regions. This information desc=
ribes:
> +
> +* Read and write permissions, whether it can be memory mapped, and wheth=
er it
> +  supports additional capabilities.
> +* Region index, size, and offset.
> +
> +When a region can be mapped by the client, the server provides a file
> +descriptor which the client can mmap(). The server is responsible for po=
lling
> +for client updates to memory mapped regions.
> +
> +Region Capabilities
> +"""""""""""""""""""
> +Some regions have additional capabilities that cannot be described adequ=
ately
> +by the region info data structure. These capabilities are returned in th=
e
> +region info reply in a list similar to PCI capabilities in a PCI device'=
s
> +configuration space.=20
> +
> +Sparse Regions
> +""""""""""""""
> +A region can be memory-mappable in whole or in part. When only a subset =
of a
> +region can be mapped by the client, a VFIO_REGION_INFO_CAP_SPARSE_MMAP
> +capability is included in the region info reply. This capability describ=
es
> +which portions can be mapped by the client.
> +
> +For example, in a virtual NVMe controller, sparse regions can be used so=
 that
> +accesses to the NVMe registers (found in the beginning of BAR0) are trap=
ped (an
> +infrequent an event), while allowing direct access to the doorbells (an
> +extremely frequent event as every I/O submission requires a write to BAR=
0),
> +found right after the NVMe registers in BAR0.
> +
> +Interrupts
> +^^^^^^^^^^
> +The client uses VFIO_USER_DEVICE_GET_IRQ_INFO messages to query the serv=
er for
> +the device's interrupt types. The interrupt types are specific to the bu=
s the
> +device is attached to, and the client is expected to know the capabiliti=
es of
> +each interrupt type. The server can signal an interrupt either with
> +VFIO_USER_VM_INTERRUPT messages over the socket, or can directly inject
> +interrupts into the guest via an event file descriptor. The client confi=
gures
> +how the server signals an interrupt with VFIO_USER_SET_IRQS messages.
> +
> +Device Read and Write
> +^^^^^^^^^^^^^^^^^^^^^
> +When the guest executes load or store operations to device memory, the c=
lient
> +forwards these operations to the server with VFIO_USER_REGION_READ or
> +VFIO_USER_REGION_WRITE messages. The server will reply with data from th=
e
> +device on read operations or an acknowledgement on write operations.
> +
> +DMA
> +^^^
> +When a device performs DMA accesses to guest memory, the server will for=
ward
> +them to the client with VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messa=
ges.
> +These messages can only be used to access guest memory the client has
> +configured into the server.
> +
> +Protocol Specification
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +To distinguish from the base VFIO symbols, all VFIO-over-socket symbols =
are
> +prefixed with vfio_user or VFIO_USER. In revision 0.1, all data is in th=
e
> +little-endian format, although this may be relaxed in future revision in=
 cases
> +where the client and server are both big-endian. The messages are format=
ted
> +for seamless reuse of the native VFIO structs. A server can serve:
> +
> +1) multiple clients, and/or
> +2) multiple virtual devices, belonging to one or more clients.
> +
> +Therefore each message requires a header that uniquely identifies the vi=
rtual
> +device. It is a server-side implementation detail whether a single serve=
r
> +handles multiple virtual devices from the same or multiple guests.
> +
> +Socket
> +------
> +A single UNIX domain socket is assumed to be used for each device. The l=
ocation
> +of the socket is implementation-specific. Multiplexing clients, devices,=
 and
> +servers over the same socket is not supported in this version of the pro=
tocol,
> +but a device ID field exists in the message header so that a future supp=
ort can
> +be added without a major version change.

There is a version negotiation mechanism for making protocol changes.
I'm not sure there is any advantage to including the multiplexing header
now? I suggest keeping it simple and dropping the unused header.

> +
> +Authentication
> +--------------
> +For AF_UNIX, we rely on OS mandatory access controls on the socket files=
,
> +therefore it is up to the management layer to set up the socket as requi=
red.
> +Socket types than span guests or hosts will require a proper authenticat=
ion
> +mechanism. Defining that mechanism is deferred to a future version of th=
e
> +protocol.
> +
> +Request Concurrency
> +-------------------
> +There can be multiple outstanding requests per virtual device, e.g. a
> +frame buffer where the guest does multiple stores to the virtual device.=
 The
> +server can execute and reorder non-conflicting requests in parallel, dep=
ending
> +on the device semantics.

The word "request" has not been used up to this point in the spec. What
does "request" mean here?

I'm not sure if this section is talking about vfio-user protocol message
exchanges (e.g. a client->server message followed by a server->client
message) or something else?

What about the ordering semantics at the vfio-user protocol level? For
example, if a client sends multiple VFIO_USER_DMA_MAP/UNMAP messages
then the order matters. What are the rules? I wonder if maybe
concurrency is a special case and really only applies to a subset of
protocol commands?

I'm not sure how a client would exploit parallelism in this protocol.
Can you give an example of a case where there would be multiple commands
pending on a single device?

> +
> +Socket Disconnection Behavior
> +-----------------------------
> +The server and the client can disconnect from each other, either intenti=
onally
> +or unexpectedly. Both the client and the server need to know how to hand=
le such
> +events.
> +
> +Server Disconnection
> +^^^^^^^^^^^^^^^^^^^^
> +A server disconnecting from the client may indicate that:
> +
> +1) A virtual device has been restarted, either intentionally (e.g. becau=
se of a
> +device update) or unintentionally (e.g. because of a crash). In any case=
, the
> +virtual device will come back so the client should not do anything (e.g.=
 simply
> +reconnect and retry failed operations).
> +
> +2) A virtual device has been shut down with no intention to be restarted=
.
> +
> +It is impossible for the client to know whether or not a failure is
> +intermittent or innocuous and should be retried, therefore the client sh=
ould
> +attempt to reconnect to the socket. Since an intentional server restart =
(e.g.
> +due to an upgrade) might take some time, a reasonable timeout should be =
used.
> +In cases where the disconnection is expected (e.g. the guest shutting do=
wn), no
> +new requests will be sent anyway so this situation doesn't pose a proble=
m. The
> +control stack will clean up accordingly.
> +
> +Parametrizing this behaviour by having the virtual device advertise a

s/Parametrizing/Parameterizing/

> +reasonable reconnect is deferred to a future version of the protocol.

No mention is made of recovering state or how disconnect maps to VFIO
device types (PCI, etc.). Does a disconnect mean that the device has
been reset?

> +
> +Client Disconnection
> +^^^^^^^^^^^^^^^^^^^^
> +The client disconnecting from the server primarily means that the QEMU p=
rocess
> +has exited. Currently this means that the guest is shut down so the devi=
ce is
> +no longer needed therefore the server can automatically exit. However, t=
here
> +can be cases where a client disconnect should not result in a server exi=
t:
> +
> +1) A single server serving multiple clients.
> +2) A multi-process QEMU upgrading itself step by step, which isn't yet
> +   implemented.
> +
> +Therefore in order for the protocol to be forward compatible the server =
should
> +take no action when the client disconnects. If anything happens to the c=
lient
> +process the control stack will know about it and can clean up resources
> +accordingly.
> +
> +Request Retry and Response Timeout
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +QEMU's VFIO retries certain operations if they fail. While this makes se=
nse for
> +real HW, we don't know for sure whether it makes sense for virtual devic=
es. A
> +failed request is a request that has been successfully sent and has been
> +responded to with an error code. Failure to send the request in the firs=
t place
> +(e.g. because the socket is disconnected) is a different type of error e=
xamined
> +earlier in the disconnect section.
> +
> +Defining a retry and timeout scheme if deferred to a future version of t=
he
> +protocol.
> +
> +Commands
> +--------
> +The following table lists the VFIO message command IDs, and whether the
> +message request is sent from the client or the server.
> +
> ++----------------------------------+---------+-------------------+
> +| Name                             | Command | Request Direction |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| VFIO_USER_VERSION                | 1       | server ???????? client   =
|

Unicode issues? I see "????????" instead of the characters that were
supposed to be here.

> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_MAP                | 2       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_UNMAP              | 3       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_GET_INFO        | 4       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_GET_REGION_INFO | 5       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_GET_IRQ_INFO    | 6       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_SET_IRQS        | 7       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_REGION_READ            | 8       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_REGION_WRITE           | 9       | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_READ               | 10      | server ???????? client   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_READ               | 11      | server ???????? client   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_VM_INTERRUPT           | 12      | server ???????? client   =
|
> ++----------------------------------+---------+-------------------+
> +| VFIO_DEVICE_RESET                | 13      | client ???????? server   =
|
> ++----------------------------------+---------+-------------------+

Why is this command named VFIO_DEVICE_RESET and not
VFIO_USER_DEVICE_RESET?

> +
> +Header
> +------
> +All messages are preceded by a 16 byte header that contains basic inform=
ation

I suggest dropping "16 byte" here because the table already shows this
and it is easy to forget to update the text when changing the table.

> +about the message. The header is followed by message-specific data descr=
ibed
> +in the sections below.
> +
> ++----------------+--------+-------------+
> +| Name           | Offset | Size        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID      | 0      | 2           |
> ++----------------+--------+-------------+
> +| Message ID     | 2      | 2           |
> ++----------------+--------+-------------+
> +| Command        | 4      | 4           |
> ++----------------+--------+-------------+
> +| Message size   | 8      | 4           |
> ++----------------+--------+-------------+
> +| Flags          | 12     | 4           |
> ++----------------+--------+-------------+
> +|                | +-----+------------+ |
> +|                | | Bit | Definition | |
> +|                | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+ |
> +|                | | 0   | Reply      | |
> +|                | +-----+------------+ |
> +|                | | 1   | No_reply   | |
> +|                | +-----+------------+ |=20
> ++----------------+--------+-------------+
> +| <message data> | 16     | variable    |
> ++----------------+--------+-------------+
> +
> +* Device ID identifies the destination device of the message. This field=
 is
> +  reserved when the server only supports one device per socket.

Clearer:
s/is reserved/must be 0/

> +* Message ID identifies the message, and is used in the message acknowle=
dgement.

Are Message IDs global or per-device?

> +* Command specifies the command to be executed, listed in the Command Ta=
ble.
> +* Message size contains the size of the entire message, including the he=
ader.
> +* Flags contains attributes of the message:
> +
> +  * The reply bit differentiates request messages from reply messages. A=
 reply
> +    message acknowledges a previous request with the same message ID.
> +  * No_reply indicates that no reply is needed for this request. This is
> +    commonly used when multiple requests are sent, and only the last nee=
ds
> +    acknowledgement.

Is_Reply and Dont_Reply are more self-explanatory to me, but this is
probably subjective.

> +
> +VFIO_USER_VERSION
> +-----------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | 0                      |
> ++--------------+------------------------+

The Device ID is always 0 and this message is sent just once regardless
of the number of devices? Please describe this explicitly so it's clear
that this message is per-session and not per-device.

There could also be a special NO_DEVICE (0xff) value but I don't think
it matters.

> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 1                      |
> ++--------------+------------------------+
> +| Message size | 16 + version length    |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| Version      | JSON byte array        |
> ++--------------+------------------------+
> +
> +This is the initial message sent by the server after the socket connecti=
on is
> +established. The version is in JSON format, and the following objects mu=
st be
> +included:
> +
> ++--------------+--------+-----------------------------------------------=
----+
> +| Name         | Type   | Description                                   =
    |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
> +| version      | object | {???????major????????: <number>, ???????minor?=
???????: <number>}            |

More Unicode issues.

> +|              |        | Version supported by the sender, e.g. ???????0=
.1????????.      |
> ++--------------+--------+-----------------------------------------------=
----+
> +| type         | string | Fixed to ???????vfio-user????????.            =
                 |
> ++--------------+--------+-----------------------------------------------=
----+
> +| capabilities | array  | Reserved. Can be omitted for v0.1, otherwise m=
ust |
> +|              |        | be empty.                                     =
    |
> ++--------------+--------+-----------------------------------------------=
----+

s/array/array of strings/ ?

> +
> +Versioning and Feature Support
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Upon accepting a connection, the server must send a VFIO_USER_VERSION me=
ssage
> +proposing a protocol version and a set of capabilities. The client compa=
res
> +these with the versions and capabilities it supports and sends a
> +VFIO_USER_VERSION reply according to the following rules.
> +
> +* The major version in the reply must be the same as proposed. If the cl=
ient
> +  does not support the proposed major, it closes the connection.
> +* The minor version in the reply must be equal to or less than the minor
> +  version proposed.
> +* The capability list must be a subset of those proposed. If the client
> +  requires a capability the server did not include, it closes the connec=
tion.
> +* If type is not ???????vfio-user????????, the client closes the connect=
ion.

Is there a rationale for this field? In order to get to the point where
this JSON is parsed we must already implement the vfio-user protocol
(e.g. parse the header).

> +
> +The protocol major version will only change when incompatible protocol c=
hanges
> +are made, such as changing the message format. The minor version may cha=
nge
> +when compatible changes are made, such as adding new messages or capabil=
ities,
> +Both the client and server must support all minor versions less than the
> +maximum minor version it supports. E.g., an implementation that supports
> +version 1.3 must also support 1.0 through 1.2.
> +
> +VFIO_USER_DMA_MAP
> +-----------------
> +
> +VFIO_USER_DMA_UNMAP
> +-------------------
> +
> +Message Format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | 0                      |
> ++--------------+------------------------+

Is this message per-session instead of per-device?

This has implications on IOMMU semantics. Two different devices sharing
a connection have access to the same DMA memory?

> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | MAP=3D2, UNMAP=3D3         |
> ++--------------+------------------------+
> +| Message size | 16 + table size        |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| Table        | array of table entries |
> ++--------------+------------------------+
> +
> +This message is sent by the client to the server to inform it of the gue=
st
> +memory regions the device can access. It must be sent before the device =
can
> +perform any DMA to the guest. It is normally sent directly after the ver=
sion
> +handshake is completed, but may also occur when memory is added or subtr=
acted
> +in the guest.
> +
> +The table is an array of the following structure. This structure is 32 b=
ytes
> +in size, so the message size will be 16 + (# of table entries * 32). If =
a
> +region being added can be directly mapped by the server, an array of fil=
e
> +descriptors will be sent as part of the message meta-data. Each region e=
ntry
> +will have a corresponding file descriptor. On AF_UNIX sockets, the file
> +descriptors will be passed as SCM_RIGHTS type ancillary data.
> +
> +Table entry format
> +^^^^^^^^^^^^^^^^^^
> +
> ++-------------+--------+-------------+
> +| Name        | Offset | Size        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Address     | 0      | 8           |
> ++-------------+--------+-------------+
> +| Size        | 8      | 8           |
> ++-------------+--------+-------------+
> +| Offset      | 16     | 8           |
> ++-------------+--------+-------------+
> +| Protections | 24     | 4           |
> ++-------------+--------+-------------+
> +| Flags       | 28     | 4           |
> ++-------------+--------+-------------+
> +|             | +-----+------------+ |
> +|             | | Bit | Definition | |
> +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|             | | 0   | Mappable   | |
> +|             | +-----+------------+ |
> ++-------------+--------+-------------+
> +
> +* Address is the base DMA address of the region.
> +* Size is the size of the region.
> +* Offset is the file offset of the region with respect to the associated=
 file
> +  descriptor.
> +* Protections are the region's protection attributes as encoded in
> +  ``<sys/mman.h>``.
> +* Flags contain the following region attributes:
> +
> +  * Mappable indicate the region can be mapped via the mmap() system cal=
l using
> +    the file descriptor provided in the message meta-data.

What are the semantics of map/unmap with respect to mapping over
existing regions, unmapping a subset of an existing region, etc?

What are the concerns for MAP/UNMAP while the device is operational and
may be performing DMA? Should this command be combined into a single
VFIO_USER_SET_DMA_REGIONS command with Flags Bit 1 indicating Add/Delete
so that a single message can atomically add and delete DMA regions?

What is the format of the reply to this message?

> +
> +VFIO_USER_DEVICE_GET_INFO
> +-------------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+----------------------------+
> +| Name         | Value                      |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                       |
> ++--------------+----------------------------+
> +| Message ID   | <ID>                       |
> ++--------------+----------------------------+
> +| Command      | 4                          |
> ++--------------+----------------------------+
> +| Message size | 16 in request, 32 in reply |
> ++--------------+----------------------------+
> +| Flags        | Reply bit set in reply     |
> ++--------------+----------------------------+
> +| Device info  | VFIO device info           |
> ++--------------+----------------------------+
> +
> +This message is sent by the client to the server to query for basic info=
rmation
> +about the device. Only the message header is needed in the request messa=
ge.
> +The VFIO device info structure is defined in ``<sys/vfio.h>`` (``struct
> +vfio_device_info``).
> +
> +VFIO device info format
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+--------+--------------------------+
> +| Name        | Offset | Size                     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| argsz       | 16     | 4                        |
> ++-------------+--------+--------------------------+
> +| flags       | 20     | 4                        |
> ++-------------+--------+--------------------------+
> +|             | +-----+-------------------------+ |
> +|             | | Bit | Definition              | |
> +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
> +|             | +-----+-------------------------+ |
> +|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
> +|             | +-----+-------------------------+ |
> ++-------------+--------+--------------------------+
> +| num_regions | 24     | 4                        |
> ++-------------+--------+--------------------------+
> +| num_irqs    | 28     | 4                        |
> ++-------------+--------+--------------------------+
> +
> +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> +  implementation.
> +* flags contains the following device attributes.
> +
> +  * VFIO_DEVICE_FLAGS_RESET indicates the device supports the
> +    VFIO_USER_DEVICE_RESET message.

Why is VFIO_USER_DEVICE_RESET support optional?

> +  * VFIO_DEVICE_FLAGS_PCI indicates the device is a PCI device.
> +
> +* num_regions is the number of memory regions the device exposes.
> +* num_irqs is the number of distinct interrupt types the device supports=
.
> +
> +This version of the protocol only supports PCI devices. Additional devic=
es may
> +be supported in future versions.=20
> +
> +VFIO_USER_DEVICE_GET_REGION_INFO
> +--------------------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------+
> +| Name         | Value            |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>             |
> ++--------------+------------------+
> +| Message ID   | <ID>             |
> ++--------------+------------------+
> +| Command      | 5                |=20
> ++--------------+------------------+
> +| Message size | 48 + any caps    |
> ++--------------+------------------+

The client does not know how much space capabilities need when sending
the request. Should the client send a 48-byte request and expect the
server to reply with a 48+ byte response?

> +DMA Read/Write Data
> +^^^^^^^^^^^^^^^^^^^
> +
> ++---------+--------+----------+
> +| Name    | Offset | Size     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +| Address | 16     | 8        |
> ++---------+--------+----------+
> +| Count   | 24     | 4        |
> ++---------+--------+----------+
> +| Data    | 28     | variable |
> ++---------+--------+----------+
> +
> +* Address is the area of guest memory being accessed. This address must =
have
> +  been exported to the server with a VFIO_USER_DMA_MAP message.
> +* Count is the size of the data to be transferred.
> +* Data is the data to be read or written.
> +
> +Address and count can also be accessed as ``struct iovec`` from ``<sys/u=
io.h>``.

This seems to be incorrect since the count field is 4 bytes but struct
iovec::iov_len is size_t (64-bit on 64-bit hosts).

> +
> +VFIO_USER_REGION_READ
> +---------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 8                      |
> ++--------------+------------------------+
> +| Message size | 32 + data size         |
> ++--------------+------------------------+
> +| Flags Reply  | bit set in reply       |
> ++--------------+------------------------+
> +| Read info    | REGION read/write data |
> ++--------------+------------------------+
> +
> +This request is sent from the client to the server to read from device m=
emory.
> +In the request messages, there will be no data, and the count field will=
 be the
> +amount of data to be read. The reply will include the data read, and its=
 count
> +field will be the amount of data read.
> +
> +VFIO_USER_REGION_WRITE
> +----------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 9                      |
> ++--------------+------------------------+
> +| Message size | 32 + data size         |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| Write info   | REGION read write data |
> ++--------------+------------------------+
> +
> +This request is sent from the client to the server to write to device me=
mory.
> +The request message will contain the data to be written, and its count f=
ield
> +will contain the amount of write data. The count field in the reply will=
 be
> +zero.
> +
> +VFIO_USER_DMA_READ
> +------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+---------------------+
> +| Name         | Value               |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                |
> ++--------------+---------------------+
> +| Message ID   | <ID>                |
> ++--------------+---------------------+
> +| Command      | 10                  |
> ++--------------+---------------------+
> +| Message size | 28 + data size      |
> ++--------------+---------------------+
> +| Flags Reply  | bit set in reply    |
> ++--------------+---------------------+
> +| DMA info     | DMA read/write data |
> ++--------------+---------------------+
> +
> +This request is sent from the server to the client to read from guest me=
mory.
> +In the request messages, there will be no data, and the count field will=
 be the
> +amount of data to be read. The reply will include the data read, and its=
 count
> +field will be the amount of data read.
> +
> +VFIO_USER_DMA_WRITE
> +-------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 11                     |
> ++--------------+------------------------+
> +| Message size | 28 + data size         |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| DMA info     | DMA read/write data    |
> ++--------------+------------------------+
> +
> +This request is sent from the server to the client to write to guest mem=
ory.
> +The request message will contain the data to be written, and its count f=
ield
> +will contain the amount of write data. The count field in the reply will=
 be
> +zero.
> +
> +VFIO_USER_VM_INTERRUPT
> +----------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++----------------+------------------------+
> +| Name           | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID      | <ID>                   |
> ++----------------+------------------------+
> +| Message ID     | <ID>                   |
> ++----------------+------------------------+
> +| Command        | 12                     |
> ++----------------+------------------------+
> +| Message size   | 24                     |
> ++----------------+------------------------+
> +| Flags          | Reply bit set in reply |
> ++----------------+------------------------+
> +| Interrupt info | <interrupt>            |
> ++----------------+------------------------+
> +
> +This request is sent from the server to the client to signal the device =
has
> +raised an interrupt.
> +
> +Interrupt info format
> +^^^^^^^^^^^^^^^^^^^^^
> +
> ++----------+--------+------+
> +| Name     | Offset | Size |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D+
> +| Index    | 16     | 4    |
> ++----------+--------+------+
> +| Subindex | 20     | 4    |
> ++----------+--------+------+
> +
> +* Index is the interrupt index; it is the same value used in VFIO_USER_S=
ET_IRQS.
> +* Subindex is relative to the index, e.g., the vector number used in PCI=
 MSI/X
> +  type interrupts.
> +
> +VFIO_USER_DEVICE_RESET
> +----------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 13                     |
> ++--------------+------------------------+
> +| Message size | 16                     |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +
> +This request is sent from the client to the server to reset the device.

How are errors treated in any of these commands? For example, if memory
addresses are out-of-bounds?

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RlvEACgkQnKSrs4Gr
c8gZ9wf+N9XTRTbBmjcKUJ6TbD4HONpoqxD2JVyRy3M66hZ3uQqHhXkzUZkCHcRM
ikHA8T+aOYrzYWh+8rwmO2oMCtyC0UpLmK8aNkLvrTB9QyXkeI4JLyzEVBqM5uQ+
/GQ2NvmA0jgsVLwDSDdac6Ezl/1on/4KlQFHqlWlA8AalaJMciTojigpAhCIzkfC
FD0EDi9a9dPQuaG8hrsUNSyE2H2GSqX57bGCnf0bIQHh7jL0N1cLyIcuZiHJT9aB
Izuby4njDPGyRSNvFN05lLgy+u1NyU1eo6sRJ9WDQWng15qYZ+i3fg4Qbw2Iyktz
ixR10dBe3oPAWoGWMijLMTqUEoFR7w==
=PjqZ
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--


