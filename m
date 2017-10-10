Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ueV-0008MS-Sc
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ueV-0000us-0S
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:32:55 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:46891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1ueU-0000ua-OH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:32:54 -0400
Received: by mail-wm0-x235.google.com with SMTP id m72so5230541wmc.1
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 06:32:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <48144f71-c876-0e89-f01e-cbfe87687aee@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<1507507449.5452.147.camel@aj.id.au>
	<48144f71-c876-0e89-f01e-cbfe87687aee@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 14:32:32 +0100
Message-ID: <CAFEAcA-oJrvJqpdw_7ybBH3oy0ykaVd7SsM_Xx+d9yY9ZXmDkA@mail.gmail.com>
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 10 October 2017 at 14:30, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/09/2017 02:04 AM, Andrew Jeffery wrote:
>> On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
>>> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>>> +{
>>> +    AspeedSoCState *soc =3D &bmc->soc;
>>> +
>>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423=
", 0x4c);
>>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423=
", 0x4c);
>>> +
>>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105=
", 0x4a);
>>
>> Looks like I need to track down newer versions of the schematics I have.
>
> the device on the board is a tmp275 but the tmp105 model is compatible.

This kind of deviation from the real hardware is worth having
a comment to document, I think.

thanks
-- PMM
