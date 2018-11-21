Received: from eggs.gnu.org ([2001:4830:134:3::10]:36680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPXL0-0005aI-F6
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPXKz-0005fJ-Iw
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:34:58 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<44e7883bd17c6867f0ac488bdab6c880b2420a9b.1542819633.git.alistair.francis@wdc.com>
	<0ddaeccd-94fd-22a8-f5e0-91fbafdf1761@deltatee.com>
In-Reply-To: <0ddaeccd-94fd-22a8-f5e0-91fbafdf1761@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 10:34:26 -0800
Message-ID: <CAKmqyKNitWerbpVzQrNye3KiPj=5DVFXan4SpiN-+br_P-RG+Q@mail.gmail.com>
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

On Wed, Nov 21, 2018 at 10:07 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 2018-11-21 10:03 a.m., Alistair Francis wrote:
> > +    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
> > +
> > +    for (i = 0; i < nb_nics; i++) {
> > +        NICInfo *nd = &nd_table[i];
> > +
> > +        if (!nd->model) {
> > +            nd->model = g_strdup("virtio");
> > +        }
> > +
> > +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> > +    }
>
> I don't understand what this patch actually accomplishes. It doesn't
> seem to affect my network devices when running QEMU. Can you provide a
> commit message explaining this?

Could you connect a PCIe networking device without this commit? This
is what the other architectures all do as well.

I'll rejig the commit message/title to make this clearer.

Alistair

>
> Thanks,
>
> Logan
