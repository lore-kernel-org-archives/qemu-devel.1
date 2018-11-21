Received: from eggs.gnu.org ([2001:4830:134:3::10]:52761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPait-000882-1v
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPais-0007wJ-77
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:11:50 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<44e7883bd17c6867f0ac488bdab6c880b2420a9b.1542819633.git.alistair.francis@wdc.com>
	<0ddaeccd-94fd-22a8-f5e0-91fbafdf1761@deltatee.com>
	<CAKmqyKNitWerbpVzQrNye3KiPj=5DVFXan4SpiN-+br_P-RG+Q@mail.gmail.com>
	<0fac09ca-12d5-1462-4456-66646f168ab5@deltatee.com>
	<CAKmqyKMTxgk41cBz=hW-meCUAi-_20vguqN40f_ThRU-rsaJXA@mail.gmail.com>
	<17256c59-cf5e-2247-985a-84c26f9d64a9@deltatee.com>
In-Reply-To: <17256c59-cf5e-2247-985a-84c26f9d64a9@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 14:11:21 -0800
Message-ID: <CAKmqyKMij-hfwFn8snBni0D7puJMwb1bHXiJP939QEPGznENEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 6/6] hw/riscv/virt: Connect a
 VirtIO net PCIe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>

On Wed, Nov 21, 2018 at 2:07 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 2:55 p.m., Alistair Francis wrote:
> > It is required for networking for PCIe devices. What PCIe device works
> > for you without this patch? Can you tell me your command line
> > arguments.
>
> I can run it without that patch using a e1000e device and it works just
> fine.
>
> Command line:
>
> $QEMU -s -nographic -machine virt -m 2G -kernel $BBL \
>    -object rng-random,filename=/dev/urandom,id=rng0 \
>    -append "console=hvc0 ro root=/dev/vda" \
>    -device e1000e,netdev=net0 \
>    -netdev user,id=net0 \
>    -device virtio-rng-device,rng=rng0 \
>    -device virtio-blk-device,drive=hd0 \
>    -drive file=rootfs.img,format=raw,id=hd0 \
>    -device nvme,drive=nvme0,serial=nvme0 \
>    -drive file=nvme0.qcow2,if=none,id=nvme0
>
> --
>
> lspcirv-hfu-01:~#
> 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> 00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> Connection
> 00:02.0 Non-Volatile memory controller: Intel Corporation QEMU NVM
> Express Controller (rev 02)
> root@rv-hfu-01:~#
>
> QEMU 3.0.92 monitor - type 'help' for more information
> (qemu) info pci
>   Bus  0, device   0, function 0:
>     Host bridge: PCI device 1b36:0008
>       PCI subsystem 1af4:1100
>       id ""
>   Bus  0, device   1, function 0:
>     Ethernet controller: PCI device 8086:10d3
>       PCI subsystem 8086:0000
>       IRQ 11.
>       BAR0: 32 bit memory at 0x40040000 [0x4005ffff].
>       BAR1: 32 bit memory at 0x40060000 [0x4007ffff].
>       BAR2: I/O at 0xffffffffffffffff [0x001e].
>       BAR3: 32 bit memory at 0x40080000 [0x40083fff].
>       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
>       id ""
>   Bus  0, device   2, function 0:
>     Class 0264: PCI device 8086:5845
>       PCI subsystem 1af4:1100
>       IRQ 9.
>       BAR0: 64 bit memory at 0x40084000 [0x40085fff].
>       id ""
> (qemu)

and networking works?

Alistair
