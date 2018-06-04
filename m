Received: from eggs.gnu.org ([2001:4830:134:3::10]:47338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAD-0006CH-TJ
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAC-0003Jm-WB
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:01 -0400
Date: Mon, 4 Jun 2018 10:39:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604003925.GB4251@umbus>
References: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
	<20180506142005.19580-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20180506142005.19580-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/4] uninorth: add impl min_access_size and
 max_access_size to unin_ops
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


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 03:20:02PM +0100, Mark Cave-Ayland wrote:
> >From testing all my local images the uninorth registers are only ever
> read or written with 32-bit accesses.

If that's the case, shouldn't you be setting the range of valid
accesses, rather than the range of implemented accesses?

>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/uninorth.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index ba76b84dbc..a658f9230a 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -548,6 +548,10 @@ static const MemoryRegionOps unin_ops =3D {
>      .read =3D unin_read,
>      .write =3D unin_write,
>      .endianness =3D DEVICE_BIG_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
>  };
> =20
>  static void unin_init(Object *obj)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUij0ACgkQbDjKyiDZ
s5Ixxw/7Bs4zrKhL/JZ0tQeUhLr/4dgFQ/kAt3vFqyQj/IXmtBoddubhMRqhD3VD
7+U+xv70PZBGIegLMlUvDcXCDy/UgjIG+yUQSNqC2/h1L0d1LxiSc/BE8Xrud6hQ
DIVnJEEi6CLCmvWgFjUVgviYAYqakm0jnrjXxsYoZ1T1J0Fi6Fyg4X3Os6/819jZ
o+qHUEntU8ebMnf9JSsa88jyidCHOz12f2IIj7mUQ4GqYbrB+9+HaAc9K+a5pBYP
PEVYivziJXMDrKqA2ZVhkAalH4xCF+LvC6NtewnMiVzZOu8NY7TDOQ5bK1Erzir5
jO7or67r05027LbvMmj/EkCvQbXCm8iSJMDNZPuR/RKbL6mut0VUyFTFiwtjNroA
gUgNyP8sJ2rNd7S63bTQ6ewxHhDLFAvh2i0caQhiMLtnt2JhRpu1PseUr2G46yPT
7lffG7cooEEZO7bHA+fbPTJKtykzrIOt6ns8kWenNRuuOk7+hvVCvpycIrel4Sca
BhyK9dpHGEzLWcHQlIiWzv2TB+Lh+mefaMdsdEa9ctYqffzcVPsVmYvY1EkEayqP
i5S7YIGseJSYXIxUmyvuiuUdtd6uYjIBxYTRTSgjeKzLrYOQmVXq0ouhJ0gN8gmd
PZlYdQxDbM63Byp6YsFhG8vVvnLKJqt3AwRk+zAJpnBAYtmFeYk=
=9a4e
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
