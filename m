Received: from eggs.gnu.org ([2001:4830:134:3::10]:49281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5Qan-0005Lg-Jw
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5Qak-0008Hk-B1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:15:37 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e5Qak-0008HG-44
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:15:34 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E66DB146547
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 08:15:32 +0200 (CEST)
References: <20171019163546.2039-1-clg@kaod.org>
	<20171019163546.2039-9-clg@kaod.org>
	<2348bd8d-3247-c0f8-8a75-59b9ea0b2732@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5aed53e6-f649-a3b4-a672-a08758482766@kaod.org>
Date: Fri, 20 Oct 2017 08:15:27 +0200
MIME-Version: 1.0
In-Reply-To: <2348bd8d-3247-c0f8-8a75-59b9ea0b2732@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 8/8] aspeed: add the pc9552 chips to the
 witherspoon machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

On 10/20/2017 04:59 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/19/2017 01:35 PM, C=C3=A9dric Le Goater wrote:
>> The pca9552 LED blinkers on the Witherspoon machine are used for leds
>> but also as GPIOs to control fans and GPUs.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>> ---
>>  hw/arm/aspeed.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index df7f266800ba..0e2a4fa62c26 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -397,6 +397,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardSt=
ate *bmc)
>>      AspeedSoCState *soc =3D &bmc->soc;
>>      uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
>> =20
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca95=
52", 0x60);
>=20
> TYPE_PCA9552 ?

I expect one day that the full "pca9550,1,2,3" device family will=20
exist and I am not sure there is much point in adding a define for=20
each. I should probably remove the TYPE_PCA9552.

Thanks,

C.=20

>> +
>>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp42=
3", 0x4c);
>>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp42=
3", 0x4c);
>> =20
>> @@ -409,6 +411,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardSt=
ate *bmc)
>> =20
>>      smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), =
0x51,
>>                            eeprom_buf);
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca9=
552",
>=20
> ditto
>=20
>> +                     0x60);
>>  }
>> =20
>>  static void witherspoon_bmc_init(MachineState *machine)
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
