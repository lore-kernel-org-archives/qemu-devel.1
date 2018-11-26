Received: from eggs.gnu.org ([2001:4830:134:3::10]:57645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRJN1-0004YU-HM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRJN0-0003nB-HJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:04:23 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<84778e31610b0b98aea9b2dec5570a02dbf52180.camel@redhat.com>
In-Reply-To: <84778e31610b0b98aea9b2dec5570a02dbf52180.camel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Nov 2018 08:03:51 -0800
Message-ID: <CAKmqyKPb0C5Y7HvEz5e5=fqQh4YPnCeo4nUPaq1VvVS0y_CmrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 0/6] Connect a PCIe host and
 graphics support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Logan Gunthorpe <logang@deltatee.com>

On Thu, Nov 22, 2018 at 2:59 AM Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Wed, 2018-11-21 at 17:02 +0000, Alistair Francis wrote:
> > V7:
> >  - Fix the GPEX memory mapping thanks to Bin Meng
> >  - Fix the interrupt mapping thanks to Logan Gunthorpe
> >
> [...]
> >
> > Alistair Francis (6):
> >   hw/riscv/virt: Increase the number of interrupts
> >   hw/riscv/virt: Adjust memory layout spacing
> >   hw/riscv/virt: Connect the gpex PCIe
> >   riscv: Enable VGA and PCIE_VGA
> >   hw/riscv/sifive_u: Connect the Xilinx PCIe
> >   hw/riscv/virt: Connect a VirtIO net PCIe device
>
> Using QEMU master + these patches, libvirt master + my own patches,
> a disk image from [1] and the bbl from [2], I was able to run a pure
> PCI RISC-V guest, including connecting to it through ssh and
> performing a system update using dnf; based on these results, the
> series gets a big old
>
>   Tested-by: Andrea Bolognani <abologna@redhat.com>

Great! Thanks for testing.

Alistair

>
>
> [1] https://fedora-riscv.tranquillity.se/koji/
>     Unfortunately the site is broken at the moment :(
> [2] https://fedorapeople.org/groups/risc-v/disk-images/
>     PCI support is included in the bbl now! \o/
> --
> Andrea Bolognani / Red Hat / Virtualization
>
