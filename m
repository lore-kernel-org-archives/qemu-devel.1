Received: from eggs.gnu.org ([2001:4830:134:3::10]:48247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7N2N-0002Mf-Uc
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7N2J-0001kJ-UJ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:56:39 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:55147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7N2J-0001jx-LR
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:56:35 -0400
Received: from player755.ha.ovh.net (unknown [10.109.159.152])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 81E521D917F
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:56:33 +0200 (CEST)
References: <20180921161939.822-1-clg@kaod.org>
	<CAFEAcA_Nm7qX1w16spsW-VgsMOebW=tNo9VT0paws7+9YH+zZQ@mail.gmail.com>
	<CAFEAcA8FuQRB-p-CxQ+D9ins1ubFzC4TpW21=0076LWETFv4Gg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ddc7e69e-7ee7-2868-9d5d-23593bd31493@kaod.org>
Date: Tue, 2 Oct 2018 17:56:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FuQRB-p-CxQ+D9ins1ubFzC4TpW21=0076LWETFv4Gg@mail.gmail.com>
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

On 9/25/18 2:30 PM, Peter Maydell wrote:
> On 25 September 2018 at 13:20, Peter Maydell <peter.maydell@linaro.org>=
 wrote:
>> On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> wr=
ote:
>>> Hello,
>>>
>>> This series adds a couple of cleanups and two main features to the
>>> SMC controller of the Aspeed machines :
>>>
>>>  - a 'execute-in-place' property to boot directly from a memory regio=
n
>>>    alias of the FMC flash module using MMIO execution. This is not
>>>    activated by default because boot time needs to be improved on
>>>    recent firmwares. It also breaks migration compatibility.
>>>
>>>  - support for DMA to access the flash modules. Our primary need is
>>>    the checksum calculation which is used to evaluate the best clock
>>>    settings for reads.
>>
>> I've picked out the easy parts of this series and added
>> them to target-arm.next:
>>
>>>   aspeed/timer: fix compile breakage with clang 3.4.2
>>>   hw/arm/aspeed: change the FMC flash model of the AST2500 evb
>>>   hw/arm/aspeed: Add an Aspeed machine class
>>>   aspeed/smc: fix some alignment issues
>>
>> and left the rest for the moment (I've still got this series
>> on my to-review list).
>=20
> PS: review from people familiar with the SoC would also be helpful.

Joel has reviewed the u-boot patches. May be, he can chime in ?=20

Thanks,

C.=20
