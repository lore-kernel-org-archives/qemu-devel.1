Received: from eggs.gnu.org ([2001:4830:134:3::10]:56137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1uX3-0003gN-7t
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1uWt-0004rt-C1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:25:13 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:53886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1uWt-0004rU-69
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:25:03 -0400
Received: by mail-wm0-x231.google.com with SMTP id q132so5303210wmd.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 06:25:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <900ffff3-3667-7e17-bf38-7c6a520ed838@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<CAFEAcA9-dmTD3v1YU7Wr5EcA53z=c_WxS0K1+1zbw16q=vj-vQ@mail.gmail.com>
	<f3871f0a-7df2-a5e0-1770-8df04bb76750@kaod.org>
	<CAFEAcA-kJ-qEoo-2ZWaH0XPv-cJA4O3wZAW=FwmM5nUU4-mVBg@mail.gmail.com>
	<900ffff3-3667-7e17-bf38-7c6a520ed838@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 14:24:41 +0100
Message-ID: <CAFEAcA-tZG-mVMk-kfxZz3oKOSBr9QDpwJWc_CSvqc7An8NNbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 10 October 2017 at 14:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/10/2017 11:54 AM, Peter Maydell wrote:
>> The goal is to model hardware correctly. Hardware gives
>> aborts if you touch a physical address with no device there,
>> and so QEMU's model should do the same. If you have guest
>> code that touches a physical address and blows up because
>> of an abort (but doesn't when run on h/w) then either:
>>  * it is trying to probe a device that exists in real h/w:
>>    you need to provide a stub implementation in QEMU
>>  * the SoC's bus fabric really doesn't pass aborts back
>>    to the CPU; I think this is unlikely, but you can model
>>    it at the SoC level with a suitable default memory region
>
> well, that is case it seems.

If it is, then we should model the SoC that way, ie find
out from the hardware docs what part of the bus fabric
ignores decode errors and use memory regions with the
right default behaviour to cover the relevant address
ranges.

thanks
-- PMM
