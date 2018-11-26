Received: from eggs.gnu.org ([2001:4830:134:3::10]:42823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRMeu-0005bP-24
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRMeq-000094-Rm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:35:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gRMeq-00008W-LL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:35:00 -0500
Received: by mail-pl1-x644.google.com with SMTP id z23so14357276plo.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:35:00 -0800 (PST)
Date: Mon, 26 Nov 2018 11:34:58 -0800 (PST)
In-Reply-To: <84778e31610b0b98aea9b2dec5570a02dbf52180.camel@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-b12cc231-a10a-454f-a088-21932acd8edf@palmer-si-x1c4>
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 0/6] Connect a PCIe host and
 graphics support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: abologna@redhat.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, logang@deltatee.com, linux@roeck-us.net

On Thu, 22 Nov 2018 02:59:18 PST (-0800), abologna@redhat.com wrote:
> On Wed, 2018-11-21 at 17:02 +0000, Alistair Francis wrote:
>> V7:
>>  - Fix the GPEX memory mapping thanks to Bin Meng
>>  - Fix the interrupt mapping thanks to Logan Gunthorpe
>>
> [...]
>>
>> Alistair Francis (6):
>>   hw/riscv/virt: Increase the number of interrupts
>>   hw/riscv/virt: Adjust memory layout spacing
>>   hw/riscv/virt: Connect the gpex PCIe
>>   riscv: Enable VGA and PCIE_VGA
>>   hw/riscv/sifive_u: Connect the Xilinx PCIe
>>   hw/riscv/virt: Connect a VirtIO net PCIe device
>
> Using QEMU master + these patches, libvirt master + my own patches,
> a disk image from [1] and the bbl from [2], I was able to run a pure
> PCI RISC-V guest, including connecting to it through ssh and
> performing a system update using dnf; based on these results, the
> series gets a big old
>
>   Tested-by: Andrea Bolognani <abologna@redhat.com>
>
>
> [1] https://fedora-riscv.tranquillity.se/koji/
>     Unfortunately the site is broken at the moment :(

FWIW, I get my images from here

    https://fedorapeople.org/groups/risc-v/disk-images/

which is linked to from the Fedora wiki

    https://fedoraproject.org/wiki/Architectures/RISC-V/Disk_images

the stage4 there is quite old (April, 2018), is yours newer?  I'm having some 
problems updating my disk image and since I'm not a Fedora user I have no idea 
what's going on.

> [2] https://fedorapeople.org/groups/risc-v/disk-images/
>     PCI support is included in the bbl now! \o/

Great!  I've yet to figure out how to get all the PCI stuff working, but I was 
trying to go with a virgl-based GPU which I suspect is broken for other 
reasons.  What sort of devices did you attach?
