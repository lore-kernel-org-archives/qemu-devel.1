Received: from eggs.gnu.org ([2001:4830:134:3::10]:56212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkrHB-0005aA-6I
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkrH7-0000HS-9t
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:21 -0400
Date: Thu, 24 Aug 2017 21:15:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824111536.GJ5379@umbus.fritz.box>
References: <1503560493-5961-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7e8BFhNxqpjiNKz7"
Content-Disposition: inline
In-Reply-To: <1503560493-5961-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/nvram/spapr_nvram: Device can
 not be created by the users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--7e8BFhNxqpjiNKz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 09:41:33AM +0200, Thomas Huth wrote:
> Trying to add a spapr-nvram device currently aborts QEMU like this:
>=20
> $ ppc64-softmmu/qemu-system-ppc64  -device spapr-nvram
> qemu-system-ppc64: hw/ppc/spapr_rtas.c:407: spapr_rtas_register:
>  Assertion `!rtas_table[token].name' failed.
> Aborted (core dumped)
>=20
> This NVRAM device registers RTAS calls during its realize function
> and thus can only be used once - and that's internally from spapr.c.
> So let's mark the device with user_creatable =3D false to avoid that
> the users can crash their QEMU this way.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.11, thanks.

> ---
>  hw/nvram/spapr_nvram.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index bc355a4..4a0aec8 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -264,6 +264,8 @@ static void spapr_nvram_class_init(ObjectClass *klass=
, void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->props =3D spapr_nvram_properties;
>      dc->vmsd =3D &vmstate_spapr_nvram;
> +    /* Reason: Internal device only, uses spapr_rtas_register() in reali=
ze() */
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo spapr_nvram_type_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7e8BFhNxqpjiNKz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmetVcACgkQbDjKyiDZ
s5JGfRAAtsefcPpLUQWNTns1sdOG4A5wBkUKLUn1CGg14f4ifiwFQjbJZd7Q3LHE
oqaClJ0yaP3RvlsfiLfejiMV/DMiJPdey5QzViWMnZ8yzSbOfAcBJ/qnIAbgK6F7
i6fHU3YgzFdeBIe+KzHyNt0z+9yuGyTbSq4KzYDMaUDbGxjdiBwINeyx8zNgiKdB
dQkBB5bUCOLlK4CdJmFTZ05pGpzUG3waJhBsLQp0x+bUkKrW25Zjkgu712KhtwNJ
RKE4AgH7a8lMk4ShenuKFZ/OACicanoqC+yBRyaPN2UuiG2bQxw75I4o758MV3OR
xVzEtD4rZdYNeReDFy6mzbZWkkWT4vjVw6vH9gbMCnI3BprSr5srSX70Gw7C6QoK
Jnf8Y83hmHtZb1CASDuinu2YX33WNAEBFwTivI30fVgqwv81eihso/w2oGdpvV5Y
yw8WDvUzf7dTlkkLfx2HxrVaYvoJgSiJmiJM+H6DRcZHFx4kpM7bYedboFbq+aU9
XYjQ+62AuFbwv+0FwiDjHAUmiGo1Ir1y3fUOkWGxI56aCR8BovCfekqhtrAziDdw
V717NCTuG/YfjwQbEv6+9jF5BqfBD2gSxGBIGIY5m5m5qxEA2Rfch+69XGukVhnN
9MhwKB+1peToj4mdpD/dWPedZGzQ+Q0tJ6oVU1aJA+Snr0ySuhE=
=3X0M
-----END PGP SIGNATURE-----

--7e8BFhNxqpjiNKz7--
