Received: from eggs.gnu.org ([2001:4830:134:3::10]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hSD-0002KG-7W
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hSC-0008Rz-1Z
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:15:13 -0400
Date: Sat, 7 Oct 2017 15:38:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171007043835.GD10050@umbus.fritz.box>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-56-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <20171006235023.11952-56-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 55/88] PReP: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 08:49:50PM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/prep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 94138a4e8c..c638d3d17a 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -512,7 +512,7 @@ static void ppc_prep_init(MachineState *machine)
>      int ppc_boot_device;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> =20
> -    sysctrl =3D g_malloc0(sizeof(sysctrl_t));
> +    sysctrl =3D g_new0(sysctrl_t, 1);
> =20
>      linux_boot =3D (kernel_filename !=3D NULL);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnYWkkACgkQbDjKyiDZ
s5LuhxAAp9FQk73Q/sIzyoa9XyFZgOPo00brOX8S1MZaUX/3VfkBnQyHi75dVnD8
zHpIi+xDFKvzQ+X+YQsTqiFhiIAtKzWp8ZvdjDZKzALy7mkBDI/BLfIbGzGu/VBC
hY957F9ECPZrE18Z3sPLoju335bFJ7Nta4HQUA6eSvZCYlLvvO83BTuYC4ZUq/DC
gUCKN0UT51w/eT2J2C6YC4jjq/XY5j0+RLR0ZA4C8/OVoPNKOoR7BS8LZGRYYwBW
Lgj5sbs8cPGNrHQ2rX4KCnpZ+i5WwGYU91ZMKBoYLhi8deiUcoiHj1fZKRLrsHAG
qJmpa/UBgfOGVWfoH4AsuAIPuTGsQFpR3kDcG2/BQdthTOzF50Rr+sv4CR8zlQha
ANZFpawOlgP5V89+8D441uo4fl4kCrQ/BYnvzy586PqmSTCSBvqTAA2NNNvM12oK
FFpRSSxjraa+/FB/3e64YoAdKsIbgRBarL/BW7DnsyUBS/WvtucUDhGrkRQ6PPxd
k8EAjAiOwY2SLwJhTWXlAFZlhZd+udKfAklt0JJLNQOxOxfJcoKk/JrKg4MPlsVq
CRkxL+R4jVK5Z02C/8jFyGA1oIPJSsXzxNN+cOfa3DshtoEBFcbJP4JxDlnHlSlu
JloVk7N8yM9/Ba5b57Q8/Azpk/1xjvcV3OZC2QzniCvKG8UIgrg=
=CNhv
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
