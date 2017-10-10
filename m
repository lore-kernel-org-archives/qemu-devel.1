Received: from eggs.gnu.org ([2001:4830:134:3::10]:46067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1wcR-0007lH-Kz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1wcM-0000dF-3i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:38:55 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1wcL-0000b8-RT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:38:50 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B59A558BAA
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:38:41 +0200 (CEST)
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<CAFEAcA9-dmTD3v1YU7Wr5EcA53z=c_WxS0K1+1zbw16q=vj-vQ@mail.gmail.com>
	<f3871f0a-7df2-a5e0-1770-8df04bb76750@kaod.org>
	<CAFEAcA-kJ-qEoo-2ZWaH0XPv-cJA4O3wZAW=FwmM5nUU4-mVBg@mail.gmail.com>
	<900ffff3-3667-7e17-bf38-7c6a520ed838@kaod.org>
	<CAFEAcA-tZG-mVMk-kfxZz3oKOSBr9QDpwJWc_CSvqc7An8NNbg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cf00417c-86a6-cf7c-eea7-b1b46d9b2cc1@kaod.org>
Date: Tue, 10 Oct 2017 17:38:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-tZG-mVMk-kfxZz3oKOSBr9QDpwJWc_CSvqc7An8NNbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/10/2017 03:24 PM, Peter Maydell wrote:
> On 10 October 2017 at 14:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> On 10/10/2017 11:54 AM, Peter Maydell wrote:
>>> The goal is to model hardware correctly. Hardware gives
>>> aborts if you touch a physical address with no device there,
>>> and so QEMU's model should do the same. If you have guest
>>> code that touches a physical address and blows up because
>>> of an abort (but doesn't when run on h/w) then either:
>>>  * it is trying to probe a device that exists in real h/w:
>>>    you need to provide a stub implementation in QEMU
>>>  * the SoC's bus fabric really doesn't pass aborts back
>>>    to the CPU; I think this is unlikely, but you can model
>>>    it at the SoC level with a suitable default memory region
>>
>> well, that is case it seems.
>=20
> If it is, then we should model the SoC that way, ie find
> out from the hardware docs what part of the bus fabric
> ignores decode errors and use memory regions with the
> right default behaviour to cover the relevant address
> ranges.

The addresses generating memory fault errors are all in=20
the region where the BMC SPI Flash Memory is mapped :=20
[ 20000000-2FFFFFFF ]

but we should not be doing any writes there. I will make
some inquiries.

Thanks,

C.=20
