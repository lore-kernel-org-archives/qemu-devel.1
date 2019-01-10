Received: from eggs.gnu.org ([209.51.188.92]:37348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ghioW-0006Ok-EQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 17:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ghioV-0001LU-Hg
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 17:28:36 -0500
MIME-Version: 1.0
References: <c162ffeb1bb1cbcdeb47ea62a829294168a0ebdf.1547078463.git.alistair.francis@wdc.com>
	<mhng-cf28bdac-e5b7-46a3-b53d-b01a329f9100@palmer-si-x1c4>
In-Reply-To: <mhng-cf28bdac-e5b7-46a3-b53d-b01a329f9100@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Jan 2019 14:28:07 -0800
Message-ID: <CAKmqyKOceCJrZcK-3JTObRjpif-TXQ8N2sTv=Z-bGGgCyOgNTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] default-configs: Enable USB support
 for RISC-V machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Thu, Jan 10, 2019 at 8:53 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 09 Jan 2019 16:01:34 PST (-0800), Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  default-configs/riscv32-softmmu.mak | 1 +
> >  default-configs/riscv64-softmmu.mak | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> > index dbc9398284..c9c5971409 100644
> > --- a/default-configs/riscv32-softmmu.mak
> > +++ b/default-configs/riscv32-softmmu.mak
> > @@ -1,6 +1,7 @@
> >  # Default configuration for riscv-softmmu
> >
> >  include pci.mak
> > +include usb.mak
> >
> >  CONFIG_SERIAL=y
> >  CONFIG_VIRTIO_MMIO=y
> > diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> > index dbc9398284..c9c5971409 100644
> > --- a/default-configs/riscv64-softmmu.mak
> > +++ b/default-configs/riscv64-softmmu.mak
> > @@ -1,6 +1,7 @@
> >  # Default configuration for riscv-softmmu
> >
> >  include pci.mak
> > +include usb.mak
> >
> >  CONFIG_SERIAL=y
> >  CONFIG_VIRTIO_MMIO=y
> > --
> > 2.19.1
>
> Does this work for you?  I tried it out but my kernel hangs in early boot if I
> enable the generic PCI controller.  This is my WIP kernel so the problem is
> probably on my end.

I had tested it awhile ago when I was working on the PCIe patches and
it worked for Linux.

I didn't runtime test it this time as by default there is no change it
just lets users have more boot options. Even if it doesn't work for
Linux it will be useful for other non-Linux guests.

Alistair

>
> I'm trying to boot with
>
>     -device usb-ehci
>     -drive id=my_usb_disk,file=usbdisk.img,if=none,format=raw
>     -device usb-storage,drive=my_usb_dis
