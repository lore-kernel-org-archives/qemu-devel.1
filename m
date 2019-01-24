Received: from eggs.gnu.org ([209.51.188.92]:58208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gmfFb-0005Ni-Cc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gmf8e-0000by-EH
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:33:49 -0500
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:37121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gmf8e-0000Px-8Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:33:48 -0500
Received: from player690.ha.ovh.net (unknown [10.109.143.24])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9FEA01C6D17
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:33:29 +0100 (CET)
References: <20190121154928.32065-1-clg@kaod.org>
	<CAFEAcA-n-5GVpnKn_w03bJUR2Wxf=vCtyeXt1GK=PKEzvahTMg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fae7c680-9164-f42b-40f7-a3fecaa42552@kaod.org>
Date: Thu, 24 Jan 2019 14:33:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-n-5GVpnKn_w03bJUR2Wxf=vCtyeXt1GK=PKEzvahTMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] aspeed/smc: snoop SPI transfers to fake
 dummy cycles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Francisco Iglesias <frasse.iglesias@gmail.com>

On 1/24/19 2:24 PM, Peter Maydell wrote:
> On Mon, 21 Jan 2019 at 15:49, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> The m25p80 models dummy cycles using byte transfers. This works well
>> when the transfers are initiated by the QEMU model of a SPI controller
>> but when these are initiated by the OS, it breaks emulation.
>>
>> Snoop the SPI transfer to catch commands requiring dummy cycles and
>> replace them with byte transfers compatible with the m25p80 model.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>=20
> This fails to compile:
>=20
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c: In
> function =E2=80=98aspeed_smc_do_snoop=E2=80=99:
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:646:42:
> error: =E2=80=98R_DUMMY_DATA=E2=80=99 undeclared (first use in this fun=
ction)
>              ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
>                                           ^
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:646:42:
> note: each undeclared identifier is reported only once for each
> function it appears in
> /home/petmay01/linaro/qemu-from-laptop/qemu/rules.mak:69: recipe for
> target 'hw/ssi/aspeed_smc.o' failed
>=20
> Is it dependent on some other patch ?

oups. sorry :/ it depends on another patch adding this register.=20

I will build a patchset for the whole. It shouldn't be controversial.
I haven't add time to rework the DMA support so I will leave that out.

Thanks,

C.
=20
