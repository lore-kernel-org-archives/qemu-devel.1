Received: from eggs.gnu.org ([2001:4830:134:3::10]:33521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCQlD-0004Zd-12
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCQl9-0003VW-Og
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gCQl9-0003Rw-Ff
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:55:47 -0400
Message-ID: <138e8c0bd96f9fa58c1b79e89615ba9a6f4318fd.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 16 Oct 2018 16:55:41 +0200
In-Reply-To: <4089265c6ef44f79f0dd67d203f69e5bde9b8d85.camel@redhat.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
	<CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
	<23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
	<CAKmqyKMBxY6j3SwvyYsMVCCeAwKinuVE4+2kbAp6YapBWdKZig@mail.gmail.com>
	<967af677f4d0b60bfb201f639ade0b0712e09fc8.camel@redhat.com>
	<4089265c6ef44f79f0dd67d203f69e5bde9b8d85.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, stephen@eideticom.com

On Tue, 2018-10-16 at 16:11 +0200, Andrea Bolognani wrote:
[...]
> If the network device is the only one
> using virtio-pci, though, despite still getting
> 
>   pci 0000:00:01.0: BAR 0: no space for [io  size 0x0020]
>   pci 0000:00:01.0: BAR 0: failed to assign [io  size 0x0020]
> 
> I can get all the way to a prompt, and the device will show up in
> the output of lspci:
> 
[...]
>   00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
> 	Subsystem: Red Hat, Inc. Device 0001
> 	Flags: bus master, fast devsel, latency 0, IRQ 1
> 	I/O ports at <unassigned> [disabled]
> 	Memory at 40040000 (64-bit, prefetchable) [size=16K]
> 	[virtual] Expansion ROM at 40000000 [disabled] [size=256K]
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 	Kernel driver in use: virtio-pci

Forgot to mention that, despite showing up, the device doesn't quite
work: for example, it can't seem to be able to acquire an IP address.

-- 
Andrea Bolognani / Red Hat / Virtualization
