Received: from eggs.gnu.org ([2001:4830:134:3::10]:54090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAIjO-0001l0-9l
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAIjK-0007L5-JM
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:57:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gAIjK-0007KN-Cv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:57:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id l81-v6so3018318pfg.3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:57:06 -0700 (PDT)
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
Date: Wed, 10 Oct 2018 10:57:02 -0700
MIME-Version: 1.0
In-Reply-To: <5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: "palmer@sifive.com" <palmer@sifive.com>, "stephen@eideticom.com" <stephen@eideticom.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 10/10/2018 05:26 AM, Andrea Bolognani wrote:
> On Thu, 2018-10-04 at 20:06 +0000, Alistair Francis wrote:
>> Alistair Francis (5):
>>    hw/riscv/virt: Increase the number of interrupts
>>    hw/riscv/virt: Connect the gpex PCIe
>>    riscv: Enable VGA and PCIE_VGA
>>    hw/riscv/sifive_u: Connect the Xilinx PCIe
>>    hw/riscv/virt: Connect a VirtIO net PCIe device
>>
>>   default-configs/riscv32-softmmu.mak | 10 +++-
>>   default-configs/riscv64-softmmu.mak | 10 +++-
>>   hw/riscv/sifive_u.c                 | 64 +++++++++++++++++++++++++
>>   hw/riscv/virt.c                     | 72 +++++++++++++++++++++++++++++
>>   include/hw/riscv/sifive_u.h         |  4 +-
>>   include/hw/riscv/virt.h             |  6 ++-
>>   6 files changed, 161 insertions(+), 5 deletions(-)
> 
> I gave v4 a try a few weeks ago because I wanted to see what would
> be needed to wire this up on the libvirt side. Turns out, not much
> really :)

Great!

> 
> I still have a couple of questions that hopefully you'll be able
> to answer:
> 
> * what should libvirt look for to figure out whether or not a RISC-V
>    guest will have PCI support? For aarch64 we look for the presence
>    of the 'gpex-pcihost' device, but of course that won't work for
>    RISC-V so we need something else;

I'm not sure what you mean here. Why can we not do the same thing with 
RISC-V?

> 
> * I have succesfully started a RISC-V guest with virtio-pci devices
>    attached but, while they show up in 'info qtree' and friends, the
>    guest OS itself doesn't seem to recognize any of them - not even
>    pcie.0! I'm using the guest images listed at [1] and following the
>    corresponding instructions, but I think the BBL build (config at
>    [2]) is missing some feature... Any ideas what we would need to
>    add there?

I use this monolithic config: 
https://github.com/alistair23/meta-riscv/blob/7a950aa705b439b5ec19bb6f094930888335ba7b/recipes-kernel/linux/files/freedom-u540/defconfig

It has way too much enabled, but I think if you copy the PCIe part that 
should be enough.

My colleague Atish has Fedora booting on real hardware with the 
MicroSemi PCIe support. You can also see his config here: 
https://github.com/westerndigitalcorporation/RISC-V-Linux/blob/master/riscv-linux-conf/config_fedora_success_4.19_demo_sep11

Obviously on top of that you will need to enable the VirtIO support as 
that doesn't exist in the hardware.

Alistair

> 
> If you can help with these I'll give the patches another spin and
> gladly provide my Tested-by :)
> 
> 
> [1] https://fedoraproject.org/wiki/Architectures/RISC-V/Installing
> [2] https://github.com/rwmjones/fedora-riscv-kernel/blob/master/config
> 
