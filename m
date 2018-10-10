Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gADZV-0007m5-F2
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gADZS-0006pb-3S
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gADZR-0006lC-Se
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:26:34 -0400
Message-ID: <5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 10 Oct 2018 14:26:21 +0200
In-Reply-To: <cover.1538683492.git.alistair.francis@wdc.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
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
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "stephen@eideticom.com" <stephen@eideticom.com>, "Richard W.M. Jones" <rjones@redhat.com>

On Thu, 2018-10-04 at 20:06 +0000, Alistair Francis wrote:
> Alistair Francis (5):
>   hw/riscv/virt: Increase the number of interrupts
>   hw/riscv/virt: Connect the gpex PCIe
>   riscv: Enable VGA and PCIE_VGA
>   hw/riscv/sifive_u: Connect the Xilinx PCIe
>   hw/riscv/virt: Connect a VirtIO net PCIe device
> 
>  default-configs/riscv32-softmmu.mak | 10 +++-
>  default-configs/riscv64-softmmu.mak | 10 +++-
>  hw/riscv/sifive_u.c                 | 64 +++++++++++++++++++++++++
>  hw/riscv/virt.c                     | 72 +++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u.h         |  4 +-
>  include/hw/riscv/virt.h             |  6 ++-
>  6 files changed, 161 insertions(+), 5 deletions(-)

I gave v4 a try a few weeks ago because I wanted to see what would
be needed to wire this up on the libvirt side. Turns out, not much
really :)

I still have a couple of questions that hopefully you'll be able
to answer:

* what should libvirt look for to figure out whether or not a RISC-V
  guest will have PCI support? For aarch64 we look for the presence
  of the 'gpex-pcihost' device, but of course that won't work for
  RISC-V so we need something else;

* I have succesfully started a RISC-V guest with virtio-pci devices
  attached but, while they show up in 'info qtree' and friends, the
  guest OS itself doesn't seem to recognize any of them - not even
  pcie.0! I'm using the guest images listed at [1] and following the
  corresponding instructions, but I think the BBL build (config at
  [2]) is missing some feature... Any ideas what we would need to
  add there?

If you can help with these I'll give the patches another spin and
gladly provide my Tested-by :)


[1] https://fedoraproject.org/wiki/Architectures/RISC-V/Installing
[2] https://github.com/rwmjones/fedora-riscv-kernel/blob/master/config
-- 
Andrea Bolognani / Red Hat / Virtualization
