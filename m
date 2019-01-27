Received: from eggs.gnu.org ([209.51.188.92]:35400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnsEY-0001lE-BI
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 16:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnsEX-0004re-3J
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 16:44:54 -0500
Date: Mon, 28 Jan 2019 00:27:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190127132732.GB1870@umbus.fritz.box>
References: <20190127100215.12584-1-sourav.jb1988@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20190127100215.12584-1-sourav.jb1988@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/input/adb.c: set device category of adb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 03:32:15PM +0530, kumar sourav wrote:
> Sets the category of adb as DEVICE_CATEGORY_INPUT
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX
>=20
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>

Applied, thanks.

> ---
>  hw/input/adb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index bbb40aeef1..6ca7c5641c 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -126,6 +126,7 @@ static void adb_device_class_init(ObjectClass *oc, vo=
id *data)
>      dc->realize =3D adb_device_realizefn;
>      dc->props =3D adb_device_properties;
>      dc->bus_type =3D TYPE_ADB_BUS;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
> =20
>  static const TypeInfo adb_device_type_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxNscEACgkQbDjKyiDZ
s5IgJRAA0ILqCo/JtJWtOJpAmLZL8JrBcBBj18I14svTvWzco6DME4opCDs1mAK2
DELgQI5/vpwfZK5zCHLXNUE6R6nK7DzmDXwOsFNROr0k+XTZ3rmx4OfYaFVID15s
bWwk36Gufcg7Eu0GFNAa+0XuIuQZunsow4Ru7hj+GV89cY32xuBWxpsAaZ2JR0Cv
GCtrCbYk+ssAkMe4tw20HtynepQJYNc0CwhdgEhUCoUPVXfhPiG5qUOKpPtSfxl1
jOyOVbpkQ2amOsg/ordtylkCgP/sIxEicnzjyLFbyY+miKVcbbeCiOgRRppul8jU
H572Vr8jFy85YU4Sy5OjN0pLm4LklxDdZiLHqyYj4eB+tuGS9kvw/QwHYRtoVHr3
kZCzSh6X84Q348CSiNoF6Ia+tXDif2oEuY0cwM+vaVgkybG//XMaISHNt7tW989Y
VopKK0tjGM1un44+C8m3FYFND4b+cbjZ7bh2XdsbFP7jubCBPk0ujLIGpKUZNpoO
llrUpHk6PqNBDAaDj2zVhi5jjHxvhxHCmkBGf6CKYT+e1ekEI2TmRvh4hJOKP32E
5mmiF8hUzhFSoUkNe4afVFFMLtN1XGqv7Z5lGDBjhWaDw8CAk4fTdpyx9qBlDbel
xsO+2SxSW4NxRhb4hhVKja0aXt8yKDHTswdk/sULIpk549S2hP4=
=+MDI
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
