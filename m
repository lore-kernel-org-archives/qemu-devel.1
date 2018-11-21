Received: from eggs.gnu.org ([2001:4830:134:3::10]:57204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPXyB-0003Fo-RN
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPXyA-0004nF-HZ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:15:27 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
	<CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
	<ffd80fff-55bf-0578-4fe5-00f07ef6bdc6@deltatee.com>
	<CAKmqyKMhpAPXFF5cQkqKYcNjD5aciDW7Ek53+W=1XNp3RGFLmw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1abdea1e-57bd-b841-a924-259baa3b9033@deltatee.com>
Date: Wed, 21 Nov 2018 12:15:14 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMhpAPXFF5cQkqKYcNjD5aciDW7Ek53+W=1XNp3RGFLmw@mail.gmail.com>
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



On 2018-11-21 12:02 p.m., Alistair Francis wrote:
> On Wed, Nov 21, 2018 at 10:50 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2018-11-21 11:32 a.m., Alistair Francis wrote:
>>> That seems like either a kernel or bbl issue.
>>>
>>> You need to make sure that bbl doesn't edit the device tree (to add
>>> the Microsemi device or remove the Xilinx one) and ensure your kernel
>>> supports the Xilinx one.
>>
>> Ok, how do I stop bbl from editing the device tree? I have a kernel with
>> Xilinx PCI support but it fails initializing on that machine (see below).
> 
> You should just be able to edit the source, grep for "microsemi".

I don't see any "microsemi" in my riscv-pk source...

Logan
