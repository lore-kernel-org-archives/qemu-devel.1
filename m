Received: from eggs.gnu.org ([2001:4830:134:3::10]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZq51-0005JS-Ld
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZq50-0005XT-JX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:04:47 -0400
Date: Mon, 2 Jul 2018 14:04:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702040436.GU3422@umbus.fritz.box>
References: <cover.1530225513.git.balaton@eik.bme.hu>
	<05ab4c16e793ce06710bc9035d9ca8c1fafa7c7f.1530225513.git.balaton@eik.bme.hu>
	<20180629044732.GG3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Content-Disposition: inline
In-Reply-To: <20180629044732.GG3422@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v6 3/5] sam460ex: Add RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Cedric Le Goater <clg@kaod.org>


--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 02:47:32PM +1000, David Gibson wrote:
> On Fri, Jun 29, 2018 at 12:38:33AM +0200, BALATON Zoltan wrote:
> > The Sam460ex has an M41T80 serial RTC chip on I2C bus 0 at address 0x68.
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> With C=E9dric's review, I've applied patches 1..3 to ppc-for-3.0.

So, I discovered after this that 3/3 breaks make check for the
ppcemb-softmmu target, because ppcemb included sam460ex, but not the
i2c bits it now requires.

I've fixed that up by removing sam460ex from the ppcemb build by
adding a new config option.

Please remember to do an all-targets make and make check before
posting, though.

>=20
> > ---
> >  hw/ppc/sam460ex.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index bdc53d2..dc730cc 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -457,6 +457,7 @@ static void sam460ex_init(MachineState *machine)
> >      object_property_set_bool(OBJECT(dev), true, "realized", NULL);
> >      smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_s=
ize);
> >      g_free(smbus_eeprom_buf);
> > +    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
> > =20
> >      dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][=
3]);
> >      i2c[1] =3D PPC4xx_I2C(dev);
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5pFQACgkQbDjKyiDZ
s5LN1BAAipdG5ZPyTfh19W0uxh9QuXhafT/qvOAoVQpEvuN9PlkMQIOA8lcOzXJE
eRm1IfEsYkkhBhcdVRvNHNLTFZozuStjlBq/SmVaUzByPRq8AppgUlPeFwPO9xzd
+BZK2BkPqX7NwWIGKz5W9rV9hWzfUVrPoEm9iAC9IyFrlqdJKncvV93uVSADDTA4
LSpcn0WG4/IpIlpaRNa2hEO/TcwbzWwMzcJmq+YXDjnDo/HjXpdFDIGbLoJmuHqj
SargKgXCwsYdVcp/AaNxowuUO9zWK+MIQS9UqySGf0ERMlrlGo5Qu3008zFvACQC
Qky86boy7TwAurmKTxGl0QKKIQwLP1cA5orEIG9RRY/PO5deiH/uQuFYmJpqlv8E
xMdW/1VTPTChe04g4BEnn5l5ryAnMVdIZYl8ayQQQi3bDZh1eMDJmsymBxiaVrfS
FF4oV61KWBjyY3Z9sqqVYISLuO1H6JftCnu0eMWILUMMKNXrrbAvnxrCDP+NSddD
9syVHkiI6SfuxxPFWrzU8JiI7FnZ/7t/lBHnEXwiyp2N9RxayCV5BRoQowTSqBpd
7C0CSRwPCrrrMWz4IGU04zb5rJkIvCAoxlwwC8GIn0AG3RgZ0yO2zb+bRB7KGe8d
KJM7W6T1gUkIedALLlInqqShnLYv5FEKUzxR3lOvYkyu+onQAVc=
=1TjZ
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--
