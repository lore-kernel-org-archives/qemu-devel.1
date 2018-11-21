Received: from eggs.gnu.org ([2001:4830:134:3::10]:60124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPX8P-0004xA-0O
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPX8M-0007rl-DB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:21:56 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<86e2120f18412152ed2994b72bd874120b86d749.1542819633.git.alistair.francis@wdc.com>
	<b49b54bf-2548-5a6b-1808-511b57cd33ad@deltatee.com>
In-Reply-To: <b49b54bf-2548-5a6b-1808-511b57cd33ad@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 10:21:19 -0800
Message-ID: <CAKmqyKP4pp_QFGrLHTm4TzjTKzpTcCXyA+_5+unbtrkiEUj9Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 3/6] hw/riscv/virt: Connect the
 gpex PCIe
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

On Wed, Nov 21, 2018 at 10:01 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
>
> > diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> > index 7937c69e22..3e3d195f37 100644
> > --- a/default-configs/riscv32-softmmu.mak
> > +++ b/default-configs/riscv32-softmmu.mak
> > @@ -1,7 +1,11 @@
> >  # Default configuration for riscv-softmmu
> >
> > +include pci.mak
> > +
> >  CONFIG_SERIAL=y
> >  CONFIG_VIRTIO_MMIO=y
> > -include virtio.mak
> >
> >  CONFIG_CADENCE=y
> > +
> > +CONFIG_PCI_GENERIC=y
> > +CONFIG_PCI_XILINX=y
>
> Nit: should PCI_XILINX not be in patch 5? It's not used in this patch
> and was a bit confusing when reviewing.

It probably should be, I have moved it.

Alistair

>
> Logan
