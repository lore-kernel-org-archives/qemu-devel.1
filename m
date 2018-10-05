Received: from eggs.gnu.org ([208.118.235.92]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g8SBg-0000vM-UK
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g8S3T-0003Ko-3o
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:30:19 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:54459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g8S3S-0003GS-Rs
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:30:14 -0400
Received: from player693.ha.ovh.net (unknown [10.109.146.32])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 95BC42F366
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 17:30:06 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-9-clg@kaod.org>
	<CAFEAcA8W0ixkfje4NSx-+kdw4rNh44JgNTu2OhDD_p91nHK7hw@mail.gmail.com>
	<f18e92fa-7b49-04b6-0adb-4f1a84668168@kaod.org>
	<CAFEAcA_injuKY7=fLvG7sj2p7Ffzx5tNQ4f3RxjsNk8Hy-rYMA@mail.gmail.com>
Message-ID: <e677b210-0879-2127-2ea6-e76f21313a3d@kaod.org>
Date: Fri, 5 Oct 2018 17:29:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_injuKY7=fLvG7sj2p7Ffzx5tNQ4f3RxjsNk8Hy-rYMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] aspeed/smc: add support for DMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/2/18 6:12 PM, Peter Maydell wrote:
> On 2 October 2018 at 16:48, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> On 10/2/18 12:56 PM, Peter Maydell wrote:
>>> Rather than having the DMA device directly grab the system_memory
>>> MR like this, it's better to have the device have a MemoryRegion
>>> property, which the SoC sets with whatever the DMA device should
>>> be able to see.
>>
>> ok. I see, but it seems I have a chicken & egg problem.
>>
>> The MemoryRegion I would liked to grab is the bmc->ram one in aspeed.c
>> but it is initialized after the SoC is. I don't know how to lazy bind
>> this region in the Aspeed SMC model using the Aspeed SoC model as a
>> proxy to pass the region property through a link or/and alias.
>>
>> If I could find a way, the model would be much cleaner.
>=20
> Usually what you want to pass is not the RAM region directly but
> some container object (which contains the RAM region among
> other things). This is often a container that you're passing
> to the SoC anyway so it can put its devices in it.
>=20
> (The direct answer to your chicken-and-egg problem is that you
> can create a container before creating the SoC, pass that to
> the SoC, then create the RAM afterwards and put it in the
> container after. But that feels a bit like a workaround for
> a less than ideal structure, somehow.)

couldn't we just initialize the RAM under the SoC ? We don't need
it at the machine level AFAICT, nor does the raspi model I think.

What is the rational behind putting the RAM region in a state=20
structure at the machine level ?=20

Thanks,

C.
