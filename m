Received: from eggs.gnu.org ([2001:4830:134:3::10]:45721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7MvJ-0003yP-5h
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7MvB-00079s-2m
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:18 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:44223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7MvA-00079G-GB
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:12 -0400
Received: from player697.ha.ovh.net (unknown [10.109.146.20])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 67104128409
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:10 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<CAFEAcA_Nm7qX1w16spsW-VgsMOebW=tNo9VT0paws7+9YH+zZQ@mail.gmail.com>
	<539cfb28-e4bc-f7d4-6ed9-881bc0cab8bc@kaod.org>
	<CAFEAcA-X7QdyjU9_aM9RAm-GZZWezyx-toEdT5vf-1P=XkdX-Q@mail.gmail.com>
Message-ID: <1ea83c48-2150-7fc4-3423-3c43e100a848@kaod.org>
Date: Tue, 2 Oct 2018 17:49:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-X7QdyjU9_aM9RAm-GZZWezyx-toEdT5vf-1P=XkdX-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] aspeed: misc fixes and
 enhancements (SMC)
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

On 10/2/18 12:57 PM, Peter Maydell wrote:
> On 25 September 2018 at 15:10, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>> On 9/25/18 2:20 PM, Peter Maydell wrote:
>>> On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> w=
rote:
>>>> Hello,
>>>>
>>>> This series adds a couple of cleanups and two main features to the
>>>> SMC controller of the Aspeed machines :
>>>>
>>>>  - a 'execute-in-place' property to boot directly from a memory regi=
on
>>>>    alias of the FMC flash module using MMIO execution. This is not
>>>>    activated by default because boot time needs to be improved on
>>>>    recent firmwares. It also breaks migration compatibility.
>>>>
>>>>  - support for DMA to access the flash modules. Our primary need is
>>>>    the checksum calculation which is used to evaluate the best clock
>>>>    settings for reads.
>>>
>>> I've picked out the easy parts of this series and added
>>> them to target-arm.next:
>>>
>>>>   aspeed/timer: fix compile breakage with clang 3.4.2
>>>>   hw/arm/aspeed: change the FMC flash model of the AST2500 evb
>>>>   hw/arm/aspeed: Add an Aspeed machine class
>>>>   aspeed/smc: fix some alignment issues
>>>
>>> and left the rest for the moment (I've still got this series
>>> on my to-review list).
>>
>> I will wait for your comments on the DMA part before resending.
>=20
> I've now commented on that patch. I think I'm done with review on
> this version, unless there's something specific you want more
> input on ?

No, a part from the chicken & egg problem on the RAM memory region
may be if you have some idea.  I will dig in before re-sending anyhow.

Thanks,

C.=20
