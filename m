Received: from eggs.gnu.org ([2001:4830:134:3::10]:54768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPanD-0004Dz-HU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPan8-0004bJ-Vr
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:19 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPan6-0004J7-QT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:12 -0500
Received: by mail-pl1-x641.google.com with SMTP id v1-v6so7396513plo.2
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 14:16:01 -0800 (PST)
Date: Wed, 21 Nov 2018 14:15:59 -0800 (PST)
In-Reply-To: <00f7a2ba-8eb1-77fd-1c4b-14e83e553bed@deltatee.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a407b21a-ace2-461c-8f27-ee95ed9c3d9b@palmer-si-x1c4>
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
To: logang@deltatee.com
Cc: alistair23@gmail.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, linux@roeck-us.net, abologna@redhat.com

On Wed, 21 Nov 2018 14:01:34 PST (-0800), logang@deltatee.com wrote:
>
>
> On 2018-11-21 2:54 p.m., Alistair Francis wrote:
>> The last time I tested this it worked (although I might not have
>> tested interrupts) and now it doesn't. Nothing has changed in the
>> series, my guest software has changed though. I can see the root
>> complex, but no devices underneath it.
>>
>> Sorry for the confusion with the MicroSemi PCIe root complex.
>>
>> I think I'll just drop this patch. It doesn't work for 32-bit guests,
>> but I would like to model the hardware so I don't want to change the
>> addresses. We can revisit this in the future along with the gpex high
>> MMIO support and USB support.
>
> Yeah, I'm less concerned about all the board variant stuff as I am about
> having something actually work. I don't want to have to jump through any
> bbl hoops or anything to use it if it doesn't work out of the box. And
> you're right, getting the virt pci support upstream seems more important
> and this issue can be revisited later.
>
> On an slight tangent: what root device do you use with the sifive_u
> machine? I can't find any virtual hardware that works. If I had PCI I
> could use NVMe, but that's not working. And for this reason I've only
> been using the 'virt' device.

I've only been using the virt device as well.
