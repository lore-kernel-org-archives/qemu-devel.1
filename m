Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BC9C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0441722248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiXyCVWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0441722248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvcr-00027c-4E
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQv6H-0006Dt-KF
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQv6F-0003Z7-0j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602260310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=07lR0FP0ryIFMVv1cU20nyQhTHCIvnrJpS5le+5dSsA=;
 b=PiXyCVWId0ZocIfqi2HT2gTfUSrZjqnmUugEHsRpJc5dx4eG14hTfpyu4P9tkJpC1QrMbh
 b1kgt1MiMck7qQAslaWeK5KtemDA0m1Zbw4djH/ATnb6JL217SMDfaaKSS+czZBfB81L3J
 f6nAQiCP260PcaGW/hRY4e+Ro3DVpPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-1I43fUM5NhqjvFsauIFYTg-1; Fri, 09 Oct 2020 12:18:28 -0400
X-MC-Unique: 1I43fUM5NhqjvFsauIFYTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DC91084D79;
 Fri,  9 Oct 2020 16:18:26 +0000 (UTC)
Received: from localhost (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8CB6266E;
 Fri,  9 Oct 2020 16:18:15 +0000 (UTC)
Date: Fri, 9 Oct 2020 17:18:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Requirements for out-of-process device emulation
Message-ID: <20201009161815.GA321402@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniele Buono <dbuono@us.ibm.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, rust-vmm@lists.opendev.org,
 Hubertus Franke <frankeh@us.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just posted the following on my blog to outline the requirements that
have been discussed over the past few months around out-of-process
device emulation (vhost-user, vfio-user, etc). I hope it's helpful for
covering various angles of out-of-process device emulation.

It's long, so no worries if you don't want to join the discussion.

Stefan
---
Requirements for out-of-process device emulation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Over the past months I have participated in discussions about
out-of-process device emulation. This post describes the requirements
that have become apparent. I hope this will be a useful guide to
understanding the big picture about out-of-process device emulation.

What is out-of-process device emulation?
----------------------------------------
Device emulation is traditionally implemented in the program that
executes guest code. This approach is natural because accesses to device
registers are trapped as part of the CPU run loop that sits at the core
of an emulator or virtual machine monitor (VMM).

In some use cases it is advantageous to perform device emulation in
separate processes. For example, software-defined network switches can
minimize data copies by emulating network cards directly in the switch
process. Out-of-process device emulation also enables privilege
separation and tighter sandboxing for security.

Why are these requirements important?
-------------------------------------
When emulated devices are implemented in the VMM they use common VMM
APIs. Adding new devices is relatively easy because the APIs are already
there and the developer can focus on the device specifics.
Out-of-process device emulation potentially leaves developers without
APIs since the device emulation program is a separate program that
literally starts from main(). Developers want to focus on implementing
their specific device, not on solving general problems related to
out-of-process device emulation infrastructure.

It is not only a lot of work to implement an out-of-process device
completely from scratch, but there is also a risk of developing the
wrong solution because some subtleties of device emulation are not
obvious at first glance.

I hope sharing these requirements will help in the creation of common
infrastructure so it's easy to implement high-quality out-of-process
devices.

Not all use cases have the full set of requirements. Therefore it's best
if requirements are addressed in separate, reusable libraries so that
device implementors can pick the ones that are relevant to them.

Device emulation
----------------
Device resources
````````````````
Devices provide resources that drivers interact with such as hardware
registers, memory, or interrupts. The fundamental requirement of
out-of-process device emulation is exposing device resources.

The following types of device resources are needed:

Synchronous MMIO/PIO accesses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The most basic device emulation operation is the hardware register
access. This is a memory-mapped I/O (MMIO) or programmed I/O (PIO)
access to the device. A read loads a value from a device register. A
write stores a value to a device register. These operations are
synchronous because the vCPU is paused until completion.
Asynchronous doorbells

Devices often have doorbell registers, allowing the driver to inform the
device that new requests are ready for processing. The vCPU does not
need to wait since the access is a posted write.

The kvm.ko ioeventfd mechanism can be used to implement asynchronous
doorbells.

Shared device memory
~~~~~~~~~~~~~~~~~~~~
Devices may have memory-like regions that the CPU can access (such as
PCI Memory BARs). The device emulation process therefore needs to share
a region of its memory space with the VMM so the guest can access it.
This mechanism also allows device emulation to busy wait (poll) instead
of using synchronous MMIO/PIO accesses or asynchronous doorbells for
notifications.

Direct Memory Access (DMA)
~~~~~~~~~~~~~~~~~~~~~~~~~~
Devices often require read and write access to a memory address space
belonging to the CPU. This allows network cards to transmit packet
payloads that are located in guest RAM, for example.

Early out-of-process device emulation interfaces simply shared guest
RAM. The allowed DMA to any guest physical memory address. More advanced
IOMMU and address space identifier mechanisms are now becoming
ubiquitous. Therefore, new out-of-process device emulation interfaces
should incorporate IOMMU functionality.

The key requirement for IOMMU mechanisms is allowing the VMM to grant
access to a region of memory so the device emulation process can read
from and/or write to it.

Interrupts
~~~~~~~~~~
Devices notify the CPU using interrupts. An interrupt is simply a
message sent by the device emulation process to the VMM. Interrupt
configuration is flexible on modern devices, meaning the driver may be
able to select the number of interrupts and a mapping (using one
interrupt with multiple event sources). This can be implemented using
the Linux eventfd mechanism or via in-band device emulation protocol
messages, for example.

Extensibility for new bus types
```````````````````````````````
It should be possible to support multiple bus types. vhost-user only
supports vhost devices. VFIO is more extensible but currently focussed
on PCI devices. It is likely that QEMU SysBus devices will be desirable
for implementing ad-hoc out-of-process devices (especially for
System-on-Chip target platforms).

Bus-level APIs, not protocol bindings
`````````````````````````````````````
Developers should not need to learn the out-of-process device emulation
protocol (vfio-user, etc). APIs should focus on bus-level concepts such
as defining VIRTIO or PCI devices rather than protocol bindings for
dealing with protocol messages, file descriptor passing, and shared
memory.

In other words, developers should be thinking in terms of the problem
domain, not worrying about how out-of-process device emulation is
implemented. The protocol should be hidden behind bus-level APIs.

Multi-threading support from the beginning
``````````````````````````````````````````
Threading issues arise often in device emulation because asynchronous
requests or multi-queue devices can be implemented using threads.
Therefore it is necessary to clearly document what threading models are
supported and how device lifecycle operations like reset interact with
in-flight requests.

Live migration, live upgrade, and crash recovery
------------------------------------------------
There are several related issues around device state and restarting the
device emulation program without disrupting the guest.

Live migration
``````````````
Live migration transfers the state of a device from one device emulation
process to another (typically running on another host). This requires
the following functionality:

Quiescing the device
~~~~~~~~~~~~~~~~~~~~
Some devices can be live migrated at any point in time without any
preparation, while others must be put into a quiescent state to avoid
issues. An example is a storage controller that has a write request in
flight. It is not safe to live migration until the write request has
completed or been canceled. Failure to wait might result in data
corruption if the write takes effect after the destination has resumed
execution.

Therefore it is necessary to quiesce a device. After this point there is
no further device activity and no guest-visible changes will be made by
the device.

Saving/loading device state
~~~~~~~~~~~~~~~~~~~~~~~~~~~
It must be possible to save and load device state. Device state includes
the contents of hardware registers as well as device-internal state
necessary for resuming operation.

It is typically necessary to determine whether the device emulation
processes on the migration source and destination are compatible before
attempting migration. This avoids migration failure when the destination
tries to load the device state and discovers it doesn't support it. It
may be desirable to support loading device state that was generated by a
different implementation of the same device type (for example, two
virtio-net implementations).

Dirty memory logging
~~~~~~~~~~~~~~~~~~~~
Pre-copy live migration starts with an iterative phase where dirty
memory pages are copied from the migration source to the destination
host. Devices need to participate in dirty memory logging so that all
written pages are transferred to the destination and no pages are
"missed".

Crash recovery
``````````````
If the device emulation process crashes it should be possible to restart
it and resume device emulation without disrupting the guest (aside from
a possible pause during reconnection).

Doing this requires maintaining device state (contents of hardware
registers, etc) outside the device emulation process. This way the state
remains even if the process crashes and it can be resume when a new
process starts.

Live upgrade
````````````
It must be possible to upgrade the device emulation process and the VMM
without disrupting the guest. Upgrading the device emulation process is
similar to crash recovery in that the process terminates and a new one
resumes with the previous state.

Device versioning
`````````````````
The guest-visible aspects of the device must be versioned. In the
simplest case the device emulation program would have a
--compat-version=3DN command-line option that controls which version of
the device the guest sees. When guest-visible changes are made to the
program the version number must be increased.

By giving control of the guest-visible device behavior it is possible to
save/load and live migrate reliably. Otherwise loading device state in a
newer device emulation program could affect the running guest. Guest
drivers typically are not prepared for the device to change underneath
them and doing so could result in guest crashes or data corruption.

Security
--------
The trust model
```````````````
The VMM must not trust the device emulation program. This is key to
implementing privilege separation and the principle of least privilege.
If a compromised device emulation program is able to gain control of the
VMM then out-of-process device emulation has failed to provide isolation
between devices.

The device emulation program must not trust the VMM to the extent that
this is possible. For example, it must validate inputs so that the VMM
cannot gain control of the device emulation process through memory
corruptions or other bugs. This makes it so that even if the VMM has
been compromised, access to device resources and associated system calls
still requires further compromising the device emulation process.

Unprivileged operation
``````````````````````
The device emulation program should run unprivileged to the extent that
this is possible. If special permissions are required to access hardware
resources then these resources can sometimes be provided via file
descriptor passing by a more privileged parent process.

Sandboxing
``````````
Operating system sandboxing mechanisms can be applied to device
emulation processes more effectively than monolithic VMMs. Seccomp can
limit the Linux system calls that may be invoked. SELinux can restrict
access to system resources.

Sandboxing is a common task that most device emulation programs need.
Therefore it is a good candidate for a library or launcher tool that is
shared by device emulation programs.

Management
----------
Command-line interface
``````````````````````
A common command-line interface should be defined where possible. For
example, vhost-user's standard --socket-path=3DPATH argument makes it easy
to launch any vhost-user device backend. Protocol-specific options (e.g.
socket path) and device type-specific options (e.g. virtio-net) can be
standardized.

Some options are necessarily specific to the device emulation program
and therefore cannot be standardized.

The advantage of standard options is that management tools like libvirt
can launch the device emulation programs without further user
configuration.

RPC interface
`````````````
It may be necessary to issue commands at runtime. Examples include
adjusting throttling limits, enabling/disabling logging, etc. These
operations can be performed over an RPC interface.

Various RPC interfaces are used throughout open source virtualization
software. Adopting a widely-used RPC protocol and standardizing commands
is beneficial because it makes it easy to communicate with the software
and management tools can support them relatively easily.

Conclusion
----------
This was largely a brain dump but I hope it is useful food for thought
as out-of-process device emulation interfaces are designed and
developed. There is a lot more to it than simply implementing a protocol
for device register accesses and guest RAM DMA. Developing open source
libraries in Rust and C that can be used as needed will ensure that
out-of-process devices are high-quality and easy for users to deploy.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+AjUcACgkQnKSrs4Gr
c8grKAgAsRXlAVsdjwXKmL8GzXMuqV8mZwMTpZ8TxJh0yHVfhoMYU6BCjX6qD2MV
DHxNGdbEFL3y7UktIZzv9Z/cAQ3vWPnZiBh+AvLXTwW0QTTFxOewfYy/3CMKh7gi
6mNYejnM/ZovguFtND3QG66f5fbyjjca/cFN1j8Kyq74SYYmfd1NL+G6JBEKy1R/
ChYqELsaQvo/ZyMgRCsnijnSUrDpkdmsgSdc/k5MCkXgBVRpUocdy+73SP99kQKI
/622/m3IkAvZPDmm+nwuvUn1AT2xGSj+aNkJTA/NUvtVPHrbET8Ak2S8ZLmDUo0t
AA7+2YTUuLEaEwY0kWRYF9VuXE2mJg==
=cnM/
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--


