Received: from eggs.gnu.org ([2001:4830:134:3::10]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edCAz-0003NB-8G
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edCAw-0004hK-6l
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:44:33 -0500
Date: Sun, 21 Jan 2018 20:44:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180121094419.GB28199@umbus>
References: <20180119081511.24010-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20180119081511.24010-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix PnvChip redefinition in
 <hw/ppc/pnv_xscom.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 09:15:11AM +0100, C=E9dric Le Goater wrote:
> This redefinition generates warnings on some clang compilers and older
> gcc4.4.
>=20
> ...include/hw/ppc/pnv_xscom.h:24:24: warning: redefinition of typedef 'Pn=
vChip' is a C11
>       feature [-Wtypedef-redefinition]
> typedef struct PnvChip PnvChip;
>                        ^
> ...include/hw/ppc/pnv.h:65:3: note: previous definition is here
> } PnvChip;
>   ^
> 1 warning generated.
>   CC      ppc64-softmmu/hw/ppc/pnv_xscom.o
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/pnv_xscom.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index fb1bd5df095a..255b26a5aaf6 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -21,8 +21,6 @@
> =20
>  #include "qom/object.h"
> =20
> -typedef struct PnvChip PnvChip;
> -
>  typedef struct PnvXScomInterface {
>      Object parent;
>  } PnvXScomInterface;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpkYPMACgkQbDjKyiDZ
s5LS9RAA1mJfuJZWVNDfFpx+zjrj6KSsr8QTMwhCK46jBvZ+OZ5GZ1JALyL9pIZG
/tUFx85SlndvkbfAorla63brsJ1cT+FgSl9Xu3vZq0EsduNWXyPMMP7H0w/dpZt5
VYxTCdLGYX5DSOGLaNmAFaxoA7xKzkE7nhmjQqNTg1hQSNWqQIfyK2EXxOaFlKrB
sHb1T8CJB3G6/O420c0lCXUC9YtwXzuOeqG14hZvtlqzbUSq/7Z7cHHmetlkHK8s
idXDwZZ1znflS6aVVD3i3HYDBOu3fyV8t8qh4HwkHZ2rutZbHUpkntJ7GHjoh3vI
4Go79HlEScYPNyZIQWoUZ5ypQgs2sXooUVrPnwvxQzZGcTMxw7u39Q+U021Y8R6g
IBxEfW5hsKbf1RJHqVUQ6Us3LtYVkabRiUm3gqoz23+Hs3aTkGKDaAJyC8DmO3vg
U4kj+7701C0Unccj9BMn5yM/EXio1Mj3B8HDrofn8MkBHnaXwXBsmBEU3IoOZMWq
mbc1Qajenq/atgki9IhsfKghWShXIZjnfm/L0mMuFslv+WcgtkdKVSNf/PF94UHp
sfgNylySkCMYiT4EiyvkKyDNHYb1jZnECy2YCW1VGGStSa9OBZT7Xa3kBomrkpvP
KzvYOCWxe4FmIEl+guHSGp3OqLXoHOr8KnQpIeNo5rhDxow/spA=
=7Hyk
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
