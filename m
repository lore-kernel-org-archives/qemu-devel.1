Received: from eggs.gnu.org ([2001:4830:134:3::10]:38743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkSlj-0002Dn-63
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkSlf-0000gx-VN
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:24:47 -0400
Date: Tue, 31 Jul 2018 13:24:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <dfd55d04ca9cd76ab22bfad5617ef388@sebastianbauer.info>
Message-ID: <alpine.BSF.2.21.1807311320150.86593@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
	<CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
	<alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
	<20180731001847.GF2708@umbus.fritz.box>
	<52bff728ba683daa71e32be776a55ff0@sebastianbauer.info>
	<alpine.BSF.2.21.1807311139550.57924@zero.eik.bme.hu>
	<dfd55d04ca9cd76ab22bfad5617ef388@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] sam460ex: Fix PCI interrupt
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 31 Jul 2018, Sebastian Bauer wrote:
> Am 2018-07-31 11:50, schrieb BALATON Zoltan:
>> On Tue, 31 Jul 2018, Sebastian Bauer wrote:
>>> There is also the possibility to make the special (num-irqs == 1) the 
>>> common case, as the Sam460ex platform is the only user of this bus so far 
>>> (and probably stays the only one). I'm not sure if it is worth all the 
>>> hassle.
>> 
>> I'd vote for this as I've said before. This seems to be the simplest
>> solution so just change ppc440_pcix to have one irq instead of 4.
>
> I now think so too, as, when devising my initial patch, I was not aware of 
> the fact that this bus emulation was only created for the SAM.
>
>>> Let me know how to proceed.
>> Will you send an updated patch or should I take and modify your latest
>> one to help with this?
>
> I don't care so much about the how, but I would appreciate it, if the bug can 
> be fixed, so that further PCI cards can be used without too much hassle 
> (e.g., network cards). David seemed to be OK with my 2nd patch after I rebase 
> it if I understood it correctly. My plan is to do this. But I'll also submit 
> another alternative (shorter) patch that tailors the bus to the SAM only.

I've sent the shorter version as I think would be the easiest fix, please 
check if this is acceptable which may save you some work on updating your 
more complex patch which I think might not be needed at this point until 
something is found to need more interrupts in the ppc440_pcix model.

I've checked that this improves sound with ES1370, haven't checked with 
pci-ohci so you could verify that.

Regards,
BALATON Zoltan
