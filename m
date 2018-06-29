Received: from eggs.gnu.org ([2001:4830:134:3::10]:51740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlO7-0003HR-Ga
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlO4-0007oA-Do
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:52:03 -0400
Date: Fri, 29 Jun 2018 14:47:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629044732.GG3422@umbus.fritz.box>
References: <cover.1530225513.git.balaton@eik.bme.hu>
	<05ab4c16e793ce06710bc9035d9ca8c1fafa7c7f.1530225513.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <05ab4c16e793ce06710bc9035d9ca8c1fafa7c7f.1530225513.git.balaton@eik.bme.hu>
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


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 12:38:33AM +0200, BALATON Zoltan wrote:
> The Sam460ex has an M41T80 serial RTC chip on I2C bus 0 at address 0x68.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

With C=E9dric's review, I've applied patches 1..3 to ppc-for-3.0.

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

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1ueIACgkQbDjKyiDZ
s5KXmxAAnigAicLkdfB0eT3MLQTFWnPLpVbX53jtKDzYOC0zghwKZJGR/RqsMDf1
3Ldt8tgFr+OCEjJDjyZZ2uGNzzCQXHwmgM6uqzuMNp60s7RIZk8xBL+KDSTXHBGn
sFFJfbmVQVN1WksCfbjY4zFYEs3pwLmutVHlq91f54ZYeqXsiNthjcjISaWzOe/u
cttERTL0ItrapWzt6hmJ1xRsbEUlvmo2/qz/QwQGi5XFsxSxYrbmEt9F+Pq6RaI0
1ChkD7tRjQJSMhjCaublq/uUt/lWGoqgO5m8B6KePmgNohstnlEbf4DArEI2aZGN
U9lOiqPly460Mw2zQhRFWQPcnz64hmWEoL6JDEhpuYhPeA/4Z1OBxkpOJtynUm7k
pqAV1fHcntI6OlE/X5H6OWh5XX+5SpTNAAdKls3x+cxL+dQEAkv+3phdO4QLNWB7
ZwfoJBhlxiBqjmwwiLXz20tw9UFC/KwDDia1L8yzkHkds2eHhfC6oTKoMEFcAfcM
XQefRSr5pkDpjO9lzcl4uUp1MCrzrgYWUrQCC/dnvqnCpoK1UVNpfnqXfHRmNmNx
+Gw4ilEJVStZDM692Mc/dA2NL0K9KQG1ozao7oewGnMPPvLAaL30Er4fbtvKpe/c
wO26yuD7kcqVS7G5pRkv4sIar+QhCdY84o4+dQA9JAJYM0Ssj+U=
=h884
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
