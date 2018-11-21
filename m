Received: from eggs.gnu.org ([2001:4830:134:3::10]:42846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPXZr-0005Lq-Gj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPXZq-0008BR-RA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:50:19 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
	<CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ffd80fff-55bf-0578-4fe5-00f07ef6bdc6@deltatee.com>
Date: Wed, 21 Nov 2018 11:50:07 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
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
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>



On 2018-11-21 11:32 a.m., Alistair Francis wrote:
> That seems like either a kernel or bbl issue.
> 
> You need to make sure that bbl doesn't edit the device tree (to add
> the Microsemi device or remove the Xilinx one) and ensure your kernel
> supports the Xilinx one.

Ok, how do I stop bbl from editing the device tree? I have a kernel with
Xilinx PCI support but it fails initializing on that machine (see below).

>> In any case, it would be nice if the Microsemi/Xilinx confusion was at
>> least explained in the commit message.
> 
> What should we say? The QEMU machine accurately models the real
> hardware which reports a Xilinx PCIe. The confusion generally appears
> above QEMU where people are used to using the MicroSemi one.

Maybe describing the bbl issue and what to do to overcome it would be
sufficient.

Logan





[    0.312000] xilinx-pcie 2000000000.pci: PCIe Link is UP
[    0.316000] xilinx-pcie 2000000000.pci: host bridge /pci@2000000000
ranges:
[    0.316000] xilinx-pcie 2000000000.pci:   No bus range found for
/pci@2000000000, using [bus 00-ff]
[    0.320000] xilinx-pcie 2000000000.pci:   MEM 0x40000000..0x5fffffff
-> 0x40000000
[    0.320000] xilinx-pcie 2000000000.pci: PCI host bridge to bus 0000:00
[    0.324000] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.324000] pci_bus 0000:00: root bus resource [mem
0x40000000-0x5fffffff]
[    0.332000] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.336000] pci_bus 0000:01: extended config space not accessible
[    0.340000] pci 0000:00:00.0: PCI bridge to [bus 01]
