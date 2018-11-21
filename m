Received: from eggs.gnu.org ([2001:4830:134:3::10]:49022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPaZE-0001OA-Ou
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPaZA-0001XT-QE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:01:50 -0500
MIME-Version: 1.0
References: <CAKmqyKM1pf1zJVMuqZvocN07LxDGrRjoSNLojt=06UbN4P-bpg@mail.gmail.com>
	<mhng-ad48cd5f-383f-427e-9bd6-db4947b3839f@palmer-si-x1c4>
In-Reply-To: <mhng-ad48cd5f-383f-427e-9bd6-db4947b3839f@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 14:01:10 -0800
Message-ID: <CAKmqyKMZ7+xAPcks33omgaEjQig9b-BSDGMbZBfTDSzW8eiThg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>

On Wed, Nov 21, 2018 at 1:37 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 21 Nov 2018 11:21:40 PST (-0800), alistair23@gmail.com wrote:
> > On Wed, Nov 21, 2018 at 11:19 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2018-11-21 12:16 p.m., Alistair Francis wrote:
> >> >>> Do you see the MicroSemi PCIe probe in your dmesg?
> >> >>
> >> >> I do when I have a kernel with microsemi PCI Support (specifically the
> >> >> one included in the bbl you sent us a while back).
> >> >
> >> > Yeah, so you need to make sure that doesn't happen.
> >>
> >> Well, I also have a kernel (one I've built myself) without microsemi
> >> support, but with Xilinx support and it also doesn't work (see my dmesg
> >> logs I sent).
> >
> > So this one should work.
> >
> >>
> >> > For people who have modified the standard bbl to edit the device tree
> >> > before passing it to Linux to add the MicroSemi PCIe node, it won't
> >> > work. That's a very small number of people who have modified the
> >> > standard boot loader. I don't think we need to document how those
> >> > people get back to the default set-up.
> >>
> >> I have not done that. And it's not working for me.
> >
> > If you haven't done this then how can Linux know to probe the
> > MicroSemi PCIe root complex?
>
> BBL passes this through from the FSBL, which has the DTB compiled in:
>
> https://github.com/sifive/freedom-u540-c000-bootloader/blob/master/fsbl/ux00_fsbl.dts#L405

That's fairly new though. Our boards show a Xilinx PCIe device.

Alistair
