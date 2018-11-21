Received: from eggs.gnu.org ([2001:4830:134:3::10]:37111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gPXMH-0006YP-QJ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gPXMH-00006S-1H
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:36:17 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Nov 2018 10:36:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181121183613.GA4874@roeck-us.net>
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "abologna@redhat.com" <abologna@redhat.com>

Hi Logan,

On Wed, Nov 21, 2018 at 11:05:21AM -0700, Logan Gunthorpe wrote:
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

What kernel configuration, devicetree, and qemu command line do you use
for the sifive_u machine ?

Thanks,
Guenter

> 
> In any case, it would be nice if the Microsemi/Xilinx confusion was at
> least explained in the commit message.
> 
> Thanks,
> 
> Logan
