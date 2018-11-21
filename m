Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gPXoO-0006Fu-54
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gPXoE-0003bJ-NU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:05:14 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Nov 2018 11:04:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181121190455.GA9571@roeck-us.net>
References: <1542754831-25567-1-git-send-email-linux@roeck-us.net>
	<CAKmqyKNNAkBY6o06=jokZcMipmtdFyX5zq9W-cQvx96R=RzzRg@mail.gmail.com>
	<d793d87c-3825-9a72-971d-856291286d57@roeck-us.net>
	<CAKmqyKNEE-9kA+yhcbs5cbGhD_Miza=hvXSrJ5F+V6fkYR0yfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKNEE-9kA+yhcbs5cbGhD_Miza=hvXSrJ5F+V6fkYR0yfQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] riscv: virt: Fix pcie memory ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrea Bolognani <abologna@redhat.com>, paul.walmsley@sifive.com

On Wed, Nov 21, 2018 at 08:00:45AM -0800, Alistair Francis wrote:
> On Tue, Nov 20, 2018 at 8:08 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi Alistair,
> >
> > On 11/20/18 4:43 PM, Alistair Francis wrote:
> > > On Tue, Nov 20, 2018 at 3:01 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> - Provide separate maps for VIRT_PCIE_MMIO (32 bit) and
> > >>    VIRT_PCIE_MMIO_HIGH (64 bit)
> > >> - VIRT_PCIE_PIO is for IO ports, not for the physical address
> > >> - VIRT_PCIE_ECAM size reduced to size needed to cover 256 ports
> > >> - Use memmap[VIRT_PCIE_ECAM].size instead of memmap[VIRT_PCIE_ECAM].base
> > >>    to calculate the bus number range
> > >> - Use qemu_fdt_setprop_sized_cells() to create reg and ranges entries
> > >> - Fix parameters for gpex_pcie_init()
> > >>    (ECAM and MMIO addresses were swapped)
> > >>
> > >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > Hey Gunter,
> > >
> > > Thanks for the patch! This was causing me all kinds of headaches.
> > > Unfortunately I had managed to figure out the memory addresses thanks
> > > to Bin Meng's help.
> > >
> > > You can see the new tree here:
> > > https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_pcie.next
> > >
> >
> > Looks good. With your patch series applied on top of v3.1-rc2 and usb.mak
> > added to the build:
> >
> > Building riscv:virt:defconfig:initrd ... running ....... passed
> > Building riscv:virt:defconfig:virtio-blk:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:virtio:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:virtio-pci:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:mmc:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:nvme:rootfs ... running ................... passed
> > Building riscv:virt:defconfig:usb-ohci:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:usb-ehci:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:usb-xhci:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:usb-uas-ehci:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:usb-uas-xhci:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:scsi[53C810]:rootfs ... running ........ passed
> > Building riscv:virt:defconfig:scsi[53C895A]:rootfs ... running ........ passed
> > Building riscv:virt:defconfig:scsi[MEGASAS]:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:scsi[MEGASAS2]:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:scsi[FUSION]:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:scsi[virtio]:rootfs ... running ....... passed
> > Building riscv:virt:defconfig:scsi[virtio-pci]:rootfs ... running ....... passed
> 
> Awesome! Can I add your tested by tag?
> 
Sure, go ahead.

Guenter

> Alistair
> 
> >
> > Guenter
