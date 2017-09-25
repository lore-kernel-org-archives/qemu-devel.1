Received: from eggs.gnu.org ([2001:4830:134:3::10]:48358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwcvf-0000fj-4p
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwcve-0000Z4-7m
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:36:47 -0400
Date: Tue, 26 Sep 2017 09:05:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170925230507.GC12504@umbus>
References: <20170925085825.20549-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20170925085825.20549-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: check for OPAL firmware file
 presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 10:58:25AM +0200, C=E9dric Le Goater wrote:
> and exit before uselessly trying to load it if the file does not
> exists.
>=20
> Issue discovered by Coverity Scan.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.11, thanks.

> ---
>=20
>  Changes since v1:
>=20
>  - fixed spelling
>  - improved OPAL naming by adding firmware=20
>=20
>  hw/ppc/pnv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 47221158d415..d46d91c76f5c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -570,10 +570,14 @@ static void ppc_powernv_init(MachineState *machine)
>      }
> =20
>      fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!fw_filename) {
> +        error_report("Could not find OPAL firmware '%s'", bios_name);
> +        exit(1);
> +    }
> =20
>      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
>      if (fw_size < 0) {
> -        error_report("Could not load OPAL '%s'", fw_filename);
> +        error_report("Could not load OPAL firmware '%s'", fw_filename);
>          exit(1);
>      }
>      g_free(fw_filename);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJi6AACgkQbDjKyiDZ
s5KRPQ//VGkbEvsxEL5HCd8ylfGtM2eppttuIaWWJGsG4Stc25fKJ89TTUd+qs1l
KIg4kEZhEARsikvcBoO1qaEoiUzWuqBmCFIdZZnwmJ8+iF1Zt/NquO2zq59bljm6
Lt/e3uBofi2YRsfCQNF7aRrwpzWatMC6gSrORWECi/G5TqkURRZlnbiBLs2ebMso
46aEga1MjS9D0nEZaovpPBvDrMFlDyByPKKuu4J1s0VsnSm0jTLMkEEghAuRwqLn
ZJmYd9ERp50i6vS182S/7sDYZTg8Rn9qOKwe7XoBNkGGYvFhYyRgWDvv9yA+P7H5
eoO8aH9XinMIa5P7Ht9tQn5W8oDsm4nKPGi7aV6tn5wSXzsxBYyx3G55gxLTS75e
UxSsZDaUPWbb5FSws2nYR/rGMWqKg+c2JqtAZiV+cBmX4H+ccJGbHbXespkC1TND
DuIB4/69vxq0YZv2V35e33tWZ9IUiaN9UyEpOTDtmURbKvi7cC9CzLfSoVxTLoYh
UiWazsQBc5P9bnTYPg7Gr/x4QI9nESj3G7Zh0jrIXqSjBuZwR/jzREdKfwP6F5ja
Kd7uRsk5LUDdpcvPxTSwYndkVkaiDl+S10PrxPqcsHtqgjkPbZ25EEaDrwEw3vkg
4y/PMxv1JgCFxUkY9O+PfMybQDdRZOUrMxz7s5otZfVl7fXTBcs=
=7J04
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
