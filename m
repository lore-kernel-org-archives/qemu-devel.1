Received: from eggs.gnu.org ([2001:4830:134:3::10]:50193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gPmhh-0004jl-Sv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gPmhe-0007WP-Oh
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:59:25 -0500
Message-ID: <84778e31610b0b98aea9b2dec5570a02dbf52180.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 22 Nov 2018 11:59:18 +0100
In-Reply-To: <cover.1542819633.git.alistair.francis@wdc.com>
References: <cover.1542819633.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "logang@deltatee.com" <logang@deltatee.com>

On Wed, 2018-11-21 at 17:02 +0000, Alistair Francis wrote:
> V7:
>  - Fix the GPEX memory mapping thanks to Bin Meng
>  - Fix the interrupt mapping thanks to Logan Gunthorpe
> 
[...]
> 
> Alistair Francis (6):
>   hw/riscv/virt: Increase the number of interrupts
>   hw/riscv/virt: Adjust memory layout spacing
>   hw/riscv/virt: Connect the gpex PCIe
>   riscv: Enable VGA and PCIE_VGA
>   hw/riscv/sifive_u: Connect the Xilinx PCIe
>   hw/riscv/virt: Connect a VirtIO net PCIe device

Using QEMU master + these patches, libvirt master + my own patches,
a disk image from [1] and the bbl from [2], I was able to run a pure
PCI RISC-V guest, including connecting to it through ssh and
performing a system update using dnf; based on these results, the
series gets a big old

  Tested-by: Andrea Bolognani <abologna@redhat.com>


[1] https://fedora-riscv.tranquillity.se/koji/
    Unfortunately the site is broken at the moment :(
[2] https://fedorapeople.org/groups/risc-v/disk-images/
    PCI support is included in the bbl now! \o/
-- 
Andrea Bolognani / Red Hat / Virtualization
