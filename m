Received: from eggs.gnu.org ([2001:4830:134:3::10]:45582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPp-0000bs-W5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPl-0003Kz-SS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:41 -0400
Date: Fri, 22 Jun 2018 20:25:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622102550.GI612@umbus.fritz.box>
References: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
	<20180622080009.5707-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20180622080009.5707-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/2] mac_newworld: always enable
 disable_direct_reg3_writes for ADB machines
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


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 09:00:09AM +0100, Mark Cave-Ayland wrote:
> Commit 84051eb400 "adb: add property to disable direct reg 3 writes" adde=
d a
> workaround for MacOS 9 incorrectly setting the mouse address during boot =
of
> PMU machines.
>=20
> Further testing has shown that since fb6649f172 "adb: fix read reg 3 byte
> ordering" this can still sometimes happen with the CUDA mac99 machine,
> so let's enable this workaround for all New World machines using ADB for =
now.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/mac_newworld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index ff715ffffd..2b13fcdde5 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -407,11 +407,11 @@ static void ppc_core99_init(MachineState *machine)
> =20
>          adb_bus =3D qdev_get_child_bus(dev, "adb.0");
>          dev =3D qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
> -        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", has_pmu);
> +        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
>          qdev_init_nofail(dev);
> =20
>          dev =3D qdev_create(adb_bus, TYPE_ADB_MOUSE);
> -        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", has_pmu);
> +        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
>          qdev_init_nofail(dev);
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsszq4ACgkQbDjKyiDZ
s5LaRBAApXrjXONBPZsxL2zqSbLwQ643EklXU64KjBNvoiw0QAh/LG7OUK3WAGm3
yyqxqdSRbJQ+wJhxFDqZgxMZYMuR4WQL8qopFde+1/RHMzPg7NHvmdnXrjuedAiH
aTm8xe5zgVRB0sq05nGf+CpwXus37LThg+I8NyogJLQWFia+eSZCeQmVHRafDE8n
lpt8d8veMaG/sspijmTCbTSgvB4wHTrqViyspK+1ctxiaaUDdVjXBCBarRgtWsCP
L/5723TEHUqTat3B3Mmf0W5ZrZfTvVWMKIDlNtTM+186Mfh++pIH+1Bgri/ok1v2
4DWrhXbtUKoq8G7869HAi+ns2Ja1w561Zbti/9k3Z5cL0paD4GW/uJj5FoHipaFg
eNC5yUuh3rbSyM9eXTJjbIUVow2g1NMHXVwtueBcMToF6fbp33Fcoe3JBzc48UHr
n8+Dkp/0XQv8gJbMVkMN1w6DQJeLNY0s/bSuHMFC2rEbJn08Sio8rhjRhvSm+8x2
sTr5l/97OriD4yrSTn9mdPJaMR+920aiPEazAS0i0wnbx1ZBYKFWrdKXgOloH22W
xON94k/7ZuHeqHDUC+tNB4KBXp6f/8+hk4fl0nOmjHSem+3yEbby73o0Elo5/Djr
EyzZevKZ8j0npZCgVx5KBLPuyWUftRQmGrZTCri4yNjUCuNDgzk=
=JLQ5
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
