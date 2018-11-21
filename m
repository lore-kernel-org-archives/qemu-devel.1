Received: from eggs.gnu.org ([2001:4830:134:3::10]:57839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPX3h-0008Ts-MU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPWsV-000569-0B
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:05:31 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
Date: Wed, 21 Nov 2018 11:05:21 -0700
MIME-Version: 1.0
In-Reply-To: <85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
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
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "abologna@redhat.com" <abologna@redhat.com>



On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> Connect the Xilinx PCIe device based on the information in the device
> tree stored in the ROM of the HiFish Unleashed board.

I only briefly tested this patch but could not get any PCI devices to
come up with the sifive_u machine. Depending on the kernel I tried, it
either failed to initialize a Xilinx PCIe (likely due to a mismatch with
the DT) or it appears to successfully initialize a Microsemi device but
did not enumerate any devices underneath.

In any case, it would be nice if the Microsemi/Xilinx confusion was at
least explained in the commit message.

Thanks,

Logan
