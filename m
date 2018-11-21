Received: from eggs.gnu.org ([2001:4830:134:3::10]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPY06-0004Xq-5j
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPY05-0006Vt-DD
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:17:26 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
	<CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
	<ffd80fff-55bf-0578-4fe5-00f07ef6bdc6@deltatee.com>
	<CAKmqyKMhpAPXFF5cQkqKYcNjD5aciDW7Ek53+W=1XNp3RGFLmw@mail.gmail.com>
	<33646fef-adb7-26b4-ba01-79f9a0f5bdae@deltatee.com>
In-Reply-To: <33646fef-adb7-26b4-ba01-79f9a0f5bdae@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 11:16:57 -0800
Message-ID: <CAKmqyKMJvTb=JebfA1N-40-MqgHkAj98JOH51t6K--zjYLXSnA@mail.gmail.com>
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

On Wed, Nov 21, 2018 at 11:09 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 12:02 p.m., Alistair Francis wrote:
> >> Ok, how do I stop bbl from editing the device tree? I have a kernel with
> >> Xilinx PCI support but it fails initializing on that machine (see below).
> >
> > You should just be able to edit the source, grep for "microsemi".
>
> Gross.
>
> > Do you see the MicroSemi PCIe probe in your dmesg?
>
> I do when I have a kernel with microsemi PCI Support (specifically the
> one included in the bbl you sent us a while back).

Yeah, so you need to make sure that doesn't happen.

They are practically the same device so they end up conflicting.

>
> >>
> >>>> In any case, it would be nice if the Microsemi/Xilinx confusion was at
> >>>> least explained in the commit message.
> >>>
> >>> What should we say? The QEMU machine accurately models the real
> >>> hardware which reports a Xilinx PCIe. The confusion generally appears
> >>> above QEMU where people are used to using the MicroSemi one.
> >>
> >> Maybe describing the bbl issue and what to do to overcome it would be
> >> sufficient.
> >
> > This is not really a QEMU problem though. If you tried to use the
> > Xilinx PCIe board on hardware you would see the same thing. Most
> > people don't have a MicroSemi board so most aren't using bbl versions
> > that are editing it into their device tree.
>
> It's a qemu problem in that people will want to be able to actually use
> qemu... somehow. It has to be documented what's required here. You can't
> just say that the sifive_u machine won't work and it's someone else's
> problem. People using qemu will not be able to figure out there are bbl
> issues.

I'm not saying the SiFive U won't work.

For people who have modified the standard bbl to edit the device tree
before passing it to Linux to add the MicroSemi PCIe node, it won't
work. That's a very small number of people who have modified the
standard boot loader. I don't think we need to document how those
people get back to the default set-up.

Alistair

>
> Logan
