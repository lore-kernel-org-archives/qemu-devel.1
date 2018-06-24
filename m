Received: from eggs.gnu.org ([2001:4830:134:3::10]:43682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fX9FB-0002eY-2Q
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 13:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fX9F7-0001R9-78
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 13:56:09 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fX9F6-0001Oe-VV
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 13:56:05 -0400
Received: from player168.ha.ovh.net (unknown [10.109.122.100])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6FD1F18519D
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 19:56:03 +0200 (CEST)
References: <cover.1529839203.git.balaton@eik.bme.hu>
	<35f80e9e4960ce04b8918c5208914daad4073c89.1529839203.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ee494769-6ce3-bc7c-0fd2-f06634b2f7e9@kaod.org>
Date: Sun, 24 Jun 2018 19:55:59 +0200
MIME-Version: 1.0
In-Reply-To: <35f80e9e4960ce04b8918c5208914daad4073c89.1529839203.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 3/4] sam460ex: Add RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 06/24/2018 01:20 PM, BALATON Zoltan wrote:
> The Sam460ex has an M41T80 serial RTC chip on I2C bus 0 at address 0x68=
.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  hw/ppc/sam460ex.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index bdc53d2..dc730cc 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -457,6 +457,7 @@ static void sam460ex_init(MachineState *machine)
>      object_property_set_bool(OBJECT(dev), true, "realized", NULL);
>      smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_s=
ize);
>      g_free(smbus_eeprom_buf);
> +    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
> =20
>      dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][=
3]);
>      i2c[1] =3D PPC4xx_I2C(dev);
>=20
