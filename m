Received: from eggs.gnu.org ([2001:4830:134:3::10]:36051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPXJM-0004nM-0j
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPXJL-0003DB-54
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:33:16 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
In-Reply-To: <e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 10:32:45 -0800
Message-ID: <CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
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

On Wed, Nov 21, 2018 at 10:05 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> > Connect the Xilinx PCIe device based on the information in the device
> > tree stored in the ROM of the HiFish Unleashed board.
>
> I only briefly tested this patch but could not get any PCI devices to
> come up with the sifive_u machine. Depending on the kernel I tried, it
> either failed to initialize a Xilinx PCIe (likely due to a mismatch with
> the DT) or it appears to successfully initialize a Microsemi device but
> did not enumerate any devices underneath.

That seems like either a kernel or bbl issue.

You need to make sure that bbl doesn't edit the device tree (to add
the Microsemi device or remove the Xilinx one) and ensure your kernel
supports the Xilinx one.

>
> In any case, it would be nice if the Microsemi/Xilinx confusion was at
> least explained in the commit message.

What should we say? The QEMU machine accurately models the real
hardware which reports a Xilinx PCIe. The confusion generally appears
above QEMU where people are used to using the MicroSemi one.

Alistair

>
> Thanks,
>
> Logan
