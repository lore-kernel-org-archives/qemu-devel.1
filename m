Received: from eggs.gnu.org ([2001:4830:134:3::10]:50158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkRI7-0003rV-JX
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkRI4-0001YC-HQ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:50:07 -0400
Date: Tue, 31 Jul 2018 11:50:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <52bff728ba683daa71e32be776a55ff0@sebastianbauer.info>
Message-ID: <alpine.BSF.2.21.1807311139550.57924@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
	<CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
	<alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
	<20180731001847.GF2708@umbus.fritz.box>
	<52bff728ba683daa71e32be776a55ff0@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 31 Jul 2018, Sebastian Bauer wrote:
> There is also the possibility to make the special (num-irqs == 1) the common 
> case, as the Sam460ex platform is the only user of this bus so far (and 
> probably stays the only one). I'm not sure if it is worth all the hassle.

I'd vote for this as I've said before. This seems to be the simplest 
solution so just change ppc440_pcix to have one irq instead of 4.

> Also note that the entire ppc440_pcix.c source file seems to be created for 
> the sam board. I have no idea why that mapping function based on slots was 
> chosen in the first place so I kept it. I would also be fine to remove that, 
> which would simplify things a lot.

It may come from other similar devices I've based the implementation on 
(ppc4xx_pci and ppce500) so no particular reason as I had no info on the 
real hardware and since I haven't tried multiple PCI cards it was just 
left there. You can remove it, I don't have anything that says it should 
be there, definitely not needed for sam460ex.

> Let me know how to proceed.

Will you send an updated patch or should I take and modify your latest one 
to help with this?

Regards,
BALATON Zoltan
