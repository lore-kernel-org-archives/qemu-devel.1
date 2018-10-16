Received: from eggs.gnu.org ([2001:4830:134:3::10]:53887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCJvu-00069Y-AJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 03:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCJvq-0003jS-83
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 03:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gCJvk-0003aL-FH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 03:38:20 -0400
Message-ID: <967af677f4d0b60bfb201f639ade0b0712e09fc8.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 16 Oct 2018 09:38:08 +0200
In-Reply-To: <CAKmqyKMBxY6j3SwvyYsMVCCeAwKinuVE4+2kbAp6YapBWdKZig@mail.gmail.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
	<CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
	<23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
	<CAKmqyKMBxY6j3SwvyYsMVCCeAwKinuVE4+2kbAp6YapBWdKZig@mail.gmail.com>
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, stephen@eideticom.com, "Richard W.M. Jones" <rjones@redhat.com>

On Mon, 2018-10-15 at 09:59 -0700, Alistair Francis wrote:
> On Mon, Oct 15, 2018 at 7:39 AM Andrea Bolognani <abologna@redhat.com> wrote:
> > One more thing that I forgot to bring up earlier: at the same time
> > as PCIe support is added, we should also make sure that the
> > pcie-root-port device is built into the qemu-system-riscv* binaries
> > by default, as that device being missing will cause PCI-enabled
> > libvirt guests to fail to start.
> 
> We are dong that aren't we?

Doesn't look that way:

  $ riscv64-softmmu/qemu-system-riscv64 -device help 2>&1 | head -5
  Controller/Bridge/Hub devices:
  name "pci-bridge", bus PCI, desc "Standard PCI Bridge"
  name "pci-bridge-seat", bus PCI, desc "Standard PCI Bridge (multiseat)"
  name "vfio-pci-igd-lpc-bridge", bus PCI, desc "VFIO dummy ISA/LPC bridge for IGD assignment"

  $

Looking at the output of '-device help' in its entirety, I think
there's a lot of stuff in there that doesn't quite belong with a
RISC-V guest and that it would probably make sense to compile out.

-- 
Andrea Bolognani / Red Hat / Virtualization
