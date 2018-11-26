Received: from eggs.gnu.org ([2001:4830:134:3::10]:52702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gROVY-0008FE-39
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gROVW-0006lS-5d
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:33:32 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Nov 2018 13:33:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181126213325.GA4937@roeck-us.net>
References: <84778e31610b0b98aea9b2dec5570a02dbf52180.camel@redhat.com>
	<mhng-b12cc231-a10a-454f-a088-21932acd8edf@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b12cc231-a10a-454f-a088-21932acd8edf@palmer-si-x1c4>
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
To: Palmer Dabbelt <palmer@sifive.com>
Cc: abologna@redhat.com, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, logang@deltatee.com

On Mon, Nov 26, 2018 at 11:34:58AM -0800, Palmer Dabbelt wrote:
> On Thu, 22 Nov 2018 02:59:18 PST (-0800), abologna@redhat.com wrote:
> > On Wed, 2018-11-21 at 17:02 +0000, Alistair Francis wrote:
> >> V7:
> >>  - Fix the GPEX memory mapping thanks to Bin Meng
> >>  - Fix the interrupt mapping thanks to Logan Gunthorpe
> >>
> > [...]
> >>
> >> Alistair Francis (6):
> >>   hw/riscv/virt: Increase the number of interrupts
> >>   hw/riscv/virt: Adjust memory layout spacing
> >>   hw/riscv/virt: Connect the gpex PCIe
> >>   riscv: Enable VGA and PCIE_VGA
> >>   hw/riscv/sifive_u: Connect the Xilinx PCIe
> >>   hw/riscv/virt: Connect a VirtIO net PCIe device
> >
> > Using QEMU master + these patches, libvirt master + my own patches,
> > a disk image from [1] and the bbl from [2], I was able to run a pure
> > PCI RISC-V guest, including connecting to it through ssh and
> > performing a system update using dnf; based on these results, the
> > series gets a big old
> >
> >   Tested-by: Andrea Bolognani <abologna@redhat.com>
> >
> >
> > [1] https://fedora-riscv.tranquillity.se/koji/
> >     Unfortunately the site is broken at the moment :(
> 
> FWIW, I get my images from here
> 
>     https://fedorapeople.org/groups/risc-v/disk-images/
> 
> which is linked to from the Fedora wiki
> 
>     https://fedoraproject.org/wiki/Architectures/RISC-V/Disk_images
> 
> the stage4 there is quite old (April, 2018), is yours newer?  I'm having some 
> problems updating my disk image and since I'm not a Fedora user I have no idea 
> what's going on.
> 
> > [2] https://fedorapeople.org/groups/risc-v/disk-images/
> >     PCI support is included in the bbl now! \o/
> 
> Great!  I've yet to figure out how to get all the PCI stuff working, but I was 
> trying to go with a virgl-based GPU which I suspect is broken for other 
> reasons.  What sort of devices did you attach?

FWIW, here is my list of tests.

Building riscv:virt:defconfig:initrd ... running ....... passed
Building riscv:virt:defconfig:virtio-blk:rootfs ... running ........ passed
Building riscv:virt:defconfig:virtio:rootfs ... running ........ passed
Building riscv:virt:defconfig:virtio-pci:rootfs ... running ........ passed
Building riscv:virt:defconfig:mmc:rootfs ... running ........ passed
Building riscv:virt:defconfig:nvme:rootfs ... running ........ passed
Building riscv:virt:defconfig:usb-ohci:rootfs ... running ........ passed
Building riscv:virt:defconfig:usb-ehci:rootfs ... running ........ passed
Building riscv:virt:defconfig:usb-xhci:rootfs ... running ......... passed
Building riscv:virt:defconfig:usb-uas-ehci:rootfs ... running ......... passed
Building riscv:virt:defconfig:usb-uas-xhci:rootfs ... running ......... passed
Building riscv:virt:defconfig:scsi[53C810]:rootfs ... running ........... passed
Building riscv:virt:defconfig:scsi[53C895A]:rootfs ... running ......... passed
Building riscv:virt:defconfig:scsi[AM53C974]:rootfs ... skipped
Building riscv:virt:defconfig:scsi[DC395]:rootfs ... skipped
Building riscv:virt:defconfig:scsi[MEGASAS]:rootfs ... running ......... passed
Building riscv:virt:defconfig:scsi[MEGASAS2]:rootfs ... running ........ passed
Building riscv:virt:defconfig:scsi[FUSION]:rootfs ... running ....... passed
Building riscv:virt:defconfig:scsi[virtio]:rootfs ... running ....... passed
Building riscv:virt:defconfig:scsi[virtio-pci]:rootfs ... running ........ passed

The skipped tests work as well, but the emulation is flaky and fails once
in a while. This is obviously with usb enabled.

Guenter
