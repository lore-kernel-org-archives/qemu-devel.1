Received: from eggs.gnu.org ([2001:4830:134:3::10]:54675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPan2-00043Y-HO
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPamy-0004NZ-Hz
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:06 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:40175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPamu-0004Gv-Np
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:02 -0500
Received: by mail-pl1-x631.google.com with SMTP id b22-v6so7385717pls.7
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 14:15:59 -0800 (PST)
Date: Wed, 21 Nov 2018 14:15:57 -0800 (PST)
In-Reply-To: <CAKmqyKMZ7+xAPcks33omgaEjQig9b-BSDGMbZBfTDSzW8eiThg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-03c7e6ba-b10e-4597-8383-c734fe78f4ad@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: alistair23@gmail.com
Cc: logang@deltatee.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, linux@roeck-us.net, abologna@redhat.com

On Wed, 21 Nov 2018 14:01:10 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 21, 2018 at 1:37 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 21 Nov 2018 11:21:40 PST (-0800), alistair23@gmail.com wrote:
>> > On Wed, Nov 21, 2018 at 11:19 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>> >>
>> >>
>> >>
>> >> On 2018-11-21 12:16 p.m., Alistair Francis wrote:
>> >> >>> Do you see the MicroSemi PCIe probe in your dmesg?
>> >> >>
>> >> >> I do when I have a kernel with microsemi PCI Support (specifically the
>> >> >> one included in the bbl you sent us a while back).
>> >> >
>> >> > Yeah, so you need to make sure that doesn't happen.
>> >>
>> >> Well, I also have a kernel (one I've built myself) without microsemi
>> >> support, but with Xilinx support and it also doesn't work (see my dmesg
>> >> logs I sent).
>> >
>> > So this one should work.
>> >
>> >>
>> >> > For people who have modified the standard bbl to edit the device tree
>> >> > before passing it to Linux to add the MicroSemi PCIe node, it won't
>> >> > work. That's a very small number of people who have modified the
>> >> > standard boot loader. I don't think we need to document how those
>> >> > people get back to the default set-up.
>> >>
>> >> I have not done that. And it's not working for me.
>> >
>> > If you haven't done this then how can Linux know to probe the
>> > MicroSemi PCIe root complex?
>>
>> BBL passes this through from the FSBL, which has the DTB compiled in:
>>
>> https://github.com/sifive/freedom-u540-c000-bootloader/blob/master/fsbl/ux00_fsbl.dts#L405
>
> That's fairly new though. Our boards show a Xilinx PCIe device.

Presumably you have the Xilinx motherboards, then?  That would mean you have a 
FSBL that was compiled with the device tree to match, which is the right thing 
to do.  Right now there's no way of probing for the motherboard, though at some 
point we designed a scheme to do so it's just not implemented yet.
