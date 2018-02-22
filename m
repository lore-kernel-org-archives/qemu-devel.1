Received: from eggs.gnu.org ([208.118.235.92]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eogiF-00030k-MB
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eoghG-0002s0-QR
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:34:23 -0500
Date: Thu, 22 Feb 2018 13:24:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180222022413.GD2164@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-11-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-11-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 10/11] macio: move setting of CUDA timebase
 frequency to macio_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:21PM +0000, Mark Cave-Ayland wrote:
> This removes the last of the functionality from macio_init() in preparati=
on
> for its subsequent removal.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/misc/macio/macio.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index e5288f1084..f71ed61819 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -101,6 +101,8 @@ static void macio_common_realize(PCIDevice *d, Error =
**errp)
>      memory_region_add_subregion(&s->bar, 0x08000,
>                                  sysbus_mmio_get_region(sysbus_dev, 0));
> =20
> +    qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
> +                         s->frequency);
>      object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -444,12 +446,7 @@ type_init(macio_register_types)
>  void macio_init(PCIDevice *d,
>                  MemoryRegion *pic_mem)
>  {
> -    MacIOState *macio_state =3D MACIO(d);
> -
>      /* Note: this code is strongly inspirated from the corresponding code
>         in PearPC */
> -    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency=
",
> -                         macio_state->frequency);
> -
>      qdev_init_nofail(DEVICE(d));
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqOKc0ACgkQbDjKyiDZ
s5LKpRAA3YF05JZMVOsRtWNu7PcuCjRWEFIWndgTy3oToozITBlSz4VhiXynMlK/
o4e8SRlu0W8R6Ux7AlldQ2sN9GMh0UTq8pguWzDe2NzgPpf4W3kUkHA3dJiQJBfd
E3W1mRzKEugqbFcLadCX7WRXKEbG+1iH7JtCxK/cVs9jIGA/qtK9+witPWrR5j8W
oWEuNyBWZiR/92eww7G4N+2pfOknLmhPFb6WxhBbdVQ7GyDg3sRidZNOByHyEgwp
QwK+coTHg8Bk8hetSk+J2MT/D6WmUFUDzjT/Ag4mNfQy6C7/aq7EFSJY6cjAzHkb
2W/mmzOgZf+6xUxVFgqsk3wN+JQXRZZh41gRN2bz/X6ILSqHb5GYubc2TEXk7y41
QtIZLf22YX2BkDZGlwlY1KxQCnLh/HNo8ptRC8YQ9jMBk+6pajyk7FFPHBasabu0
Smnd9gpo0u15UmF4mz6iTiStCAgqtAEdvC/lBbI8fiB1mhfHXRl9btgMW2LKmS1t
nRf4GpyJ1lOEJghcrbA/PqPTz7Woc5tKKW7YkSmXOov5dlwNnCqESKKNFB+CCT5q
OxZD3Yuh6h4M2CD5t4t+LX3MuexqjWBXLV/lvXSD1Zwr4w3T1pC5qWbP3dseHu+3
Rs1HllKLk2v7iUG+icqk2CDIbJyrIFyWsoUnjGDsvdP+A00ofrI=
=DC8z
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
