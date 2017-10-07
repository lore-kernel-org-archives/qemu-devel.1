Received: from eggs.gnu.org ([2001:4830:134:3::10]:42192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0sDO-0008IM-Fy
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0sDL-0005a8-Cr
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:44:38 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:32980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0sDL-0005Zi-6U
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:44:35 -0400
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D314F7CD93
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 18:44:33 +0200 (CEST)
References: <20170920070135.31379-1-clg@kaod.org>
	<CAFEAcA9Avqgbm7sZTKuex9dOp-1wzw0Moa8XVvXw5GZjSeC5Xw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7fb02e55-68dc-8509-7c2b-d049eca19d9e@kaod.org>
Date: Sat, 7 Oct 2017 18:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Avqgbm7sZTKuex9dOp-1wzw0Moa8XVvXw5GZjSeC5Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] aspeed: add a witherspoon-bmc
 machine
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

On 10/06/2017 05:13 PM, Peter Maydell wrote:
> On 20 September 2017 at 08:01, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>> Hello,
>>
>> This series adds a new Aspeed machine to emulate the BMC of a
>> Witherspoon system. It also extends the other Aspeed machines with I2C
>> devices and adds a simple model for the pca9552 LED blinker present on
>> the witherspoon board.
>>
>> Thanks,
>>
>> C.
>>
>> Changes since v1:
>>
>>  - introduced smbus_eeprom_init_one()
>>
>> C=C3=A9dric Le Goater (6):
>>   aspeed: add support for the witherspoon-bmc board
>>   aspeed: add an I2C RTC device to all machines
>>   smbus: add a smbus_eeprom_init_one() routine
>>   aspeed: Add EEPROM I2C devices
>>   misc: add pca9552 LED blinker model
>>   aspeed: add the pc9552 chips to the witherspoon machine
>=20
> Hi -- I've made a couple of review comments and nothing else
> leapt out as obviously wrong, but I'm hoping that somebody more
> familiar with the aspeed devices will do review...

Joel,=20

Now that we have updated the DTs, could you please take a look=20
to make sure that the I2C busses in the models have devices=20
which makes sense with the real boards.

Thanks,

C.  =20
