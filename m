Received: from eggs.gnu.org ([2001:4830:134:3::10]:59582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPY4f-0007YQ-Pp
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPY4e-0002v1-RO
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:22:09 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
	<CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
	<ffd80fff-55bf-0578-4fe5-00f07ef6bdc6@deltatee.com>
	<CAKmqyKMhpAPXFF5cQkqKYcNjD5aciDW7Ek53+W=1XNp3RGFLmw@mail.gmail.com>
	<33646fef-adb7-26b4-ba01-79f9a0f5bdae@deltatee.com>
	<CAKmqyKMJvTb=JebfA1N-40-MqgHkAj98JOH51t6K--zjYLXSnA@mail.gmail.com>
	<d316a936-c726-dd4c-f90a-9690b4e3fc3d@deltatee.com>
In-Reply-To: <d316a936-c726-dd4c-f90a-9690b4e3fc3d@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 11:21:40 -0800
Message-ID: <CAKmqyKM1pf1zJVMuqZvocN07LxDGrRjoSNLojt=06UbN4P-bpg@mail.gmail.com>
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
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>

On Wed, Nov 21, 2018 at 11:19 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 12:16 p.m., Alistair Francis wrote:
> >>> Do you see the MicroSemi PCIe probe in your dmesg?
> >>
> >> I do when I have a kernel with microsemi PCI Support (specifically the
> >> one included in the bbl you sent us a while back).
> >
> > Yeah, so you need to make sure that doesn't happen.
>
> Well, I also have a kernel (one I've built myself) without microsemi
> support, but with Xilinx support and it also doesn't work (see my dmesg
> logs I sent).

So this one should work.

>
> > For people who have modified the standard bbl to edit the device tree
> > before passing it to Linux to add the MicroSemi PCIe node, it won't
> > work. That's a very small number of people who have modified the
> > standard boot loader. I don't think we need to document how those
> > people get back to the default set-up.
>
> I have not done that. And it's not working for me.

If you haven't done this then how can Linux know to probe the
MicroSemi PCIe root complex?

Alistair

>
> Logan
