Received: from eggs.gnu.org ([2001:4830:134:3::10]:38658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISU-0000Ux-2t
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTIST-0004Um-4I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:57:58 -0400
Date: Thu, 14 Jun 2018 11:36:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614013644.GH3042@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<9862fa0cf70d29b686e80039696596f2c23b148c.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline
In-Reply-To: <9862fa0cf70d29b686e80039696596f2c23b148c.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 5/9] sam460ex: Add RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> The Sam460ex has an M41T80 serial RTC chip on I2C bus 0 at address 0x68.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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
>      smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_siz=
e);
>      g_free(smbus_eeprom_buf);
> +    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
> =20
>      dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][3]=
);
>      i2c[1] =3D PPC4xx_I2C(dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxqwACgkQbDjKyiDZ
s5IIlw/+MtJ9Br7ua1BS8uQ2ba+pIgKGDXw893WvdpG29p8QrztpTjrjOZaOoTiU
SGzdCKg6T20sD32zazd2Lne+g7qa0vL/6hDctddpjzoQ9sEaMQurzJOqAy7xhHrI
xcsIqxpWfDFfd2RBPnIduROPRmqSzoPTwz2LJ4sGuKjnhDfTvcpIjv23VpYkoyDg
Cgjn2uSm59pH781+FrORUpN3o/DoGQOo+u2a86C0crHhQGimzkaMAzsj9nnWeBO6
uJLBCme74rYuGBFvhaGOlmFNC6qKAoYUTBU3BNqULBvy4iGZB8vf7Wo048+QGQ7W
KTQhLti3ElL36+64mLLtlv7HtOz8rr1D+WlDCOv6c8vYbsYA4oiqXSOCENx7IGgL
ZjD8f7+HhMIqRyhRfpHVZdLPDeZ6gZc4G0Sw7ri9Qv8EAfRmwLRN4KQ3mqiuLZHX
Ry4D825V5OahoRoJLfduWyCXKvoRY3Crpt4IvECz5rLgVoeFMJW8711P23LWsbh8
9N5bQ74YX6b4bp9aqBmz+gdOVuHaKNNQE1+3EHFpKduQfwPMUmHdv4lBBgXLT+ME
LM4YSeXCgRktlHh8xLNiHd803K9mXz3JpansFjzCExGgubic2lOAOcNSe9cNWVwu
RP3dx5GRNojvOBfcj5vcVHA7souXzvdfApQrdkKYwkw3xvl1KMs=
=iHDh
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
