Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjke-0003vh-7z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjka-0005Kj-4S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:28 -0500
Date: Thu, 23 Feb 2017 13:31:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223023145.GX12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-10-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-10-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 09/22] ppc/xics: remove
 xics_find_source()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:32PM +0100, C=E9dric Le Goater wrote:
> It is not used anymore now that we have the QOM interface for XICS.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Several of these patches are small enough that I wonder if they could
be merged, though.

> ---
>  hw/intc/xics.c        | 12 ------------
>  include/hw/ppc/xics.h |  1 -
>  2 files changed, 13 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 2decb921e4e3..bfd3a539561a 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -737,18 +737,6 @@ static const TypeInfo xics_interface_info =3D {
>  /*
>   * Exported functions
>   */
> -ICSState *xics_find_source(XICSState *xics, int irq)
> -{
> -    ICSState *ics;
> -
> -    QLIST_FOREACH(ics, &xics->ics, list) {
> -        if (ics_valid_irq(ics, irq)) {
> -            return ics;
> -        }
> -    }
> -    return NULL;
> -}
> -
>  qemu_irq xics_get_qirq(XICSInterface *xi, int irq)
>  {
>      XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 896fa5d87c1c..e10426e98e31 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -222,7 +222,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
> =20
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> =20
> -ICSState *xics_find_source(XICSState *icp, int irq);
>  void ics_resend(ICSState *ics);
> =20
>  #endif /* XICS_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkmRAAoJEGw4ysog2bOSORkQAIYXqCXluGE2v8iX57CHaA+H
x5Uq6EHMwZZwK7g+oilVEhYej5UsvI+ZaKGDkvkk3tNGpIO1fsIhDkBWxqRuLInO
KWxum8F9na1k9dxqUpNgna8o1Ttq6Sm+y3/R5tKG/Qc4CA5916aoHnGc24NGNusX
O+NDMz8+wBB4QVHIQbMlh8gOk5i6217Ca2Xx54sE+v6gJUevZNsdMPDEeBXKJaBo
9v7i37JkfuoRtojJEYh5KCD6OQHJo/IKTyofeAfsnRFbHCnkJ9Qozrc3GsfQKFLJ
sDHhqB7KGeIByINOOI/cFA/R0y3U/O89UkiL6iZNWbwKoKDCe+iiF0YdZZDJIrYG
CeyAjXktqImWvm1oitayCjh5fQp89Qd942Z5hVVUDmgzgJGsL67B22wCRdLd1o+m
CQQ6ydp3kBxWWDCE2YiVF98E2LJwHwAgd33op2PNY/vxIvOZBokPYzFgDEalNG3J
WwYnVttEQelwGrkcFcTF29t5Aow1VxKQBWO3sGKNAMGRKJxYtQJRvTy0AAqBDpR8
4k/MtbPShw6oP1IxyaWPD1vhi0GkD3+T+5alinAezxRArPeK6wb76e87kCgCAlgx
fEWB8pgdcyUBjYq03XzAujh6jB5VQK+jSkfI9Vxv/GSmLoQjbQRkeTEJ2Zs2tP+B
CcIh1JxBNzHFOMdVdsMs
=4YDE
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--
