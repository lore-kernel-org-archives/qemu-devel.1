Received: from eggs.gnu.org ([209.51.188.92]:57699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfP-00071A-2H
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfN-0003CO-8Z
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:30 -0500
Date: Mon, 7 Jan 2019 11:42:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190107004228.GD13339@umbus.fritz.box>
References: <20190104133050.7468-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20190104133050.7468-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: return from post_load method
 when RTC import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 02:30:50PM +0100, C=E9dric Le Goater wrote:
> The error value can be squashed by the section handling radix migration.
> Simply bail out if an error occurs when the RTC offset is imported.
>=20
> This fixes the Coverity issue CID 1398591.
>=20
> Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>=20
>  Changes since v1 :
>=20
>  - Added Coverity issue CID
>=20
>  hw/ppc/spapr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f1725313e979..64397ee91ef0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1748,12 +1748,17 @@ static int spapr_post_load(void *opaque, int vers=
ion_id)
>          return err;
>      }
> =20
> -    /* In earlier versions, there was no separate qdev for the PAPR
> +    /*
> +     * In earlier versions, there was no separate qdev for the PAPR
>       * RTC, so the RTC offset was stored directly in sPAPREnvironment.
>       * So when migrating from those versions, poke the incoming offset
> -     * value into the RTC device */
> +     * value into the RTC device
> +     */
>      if (version_id < 3) {
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> +        if (err) {
> +            return err;
> +        }
>      }
> =20
>      if (kvm_enabled() && spapr->patb_entry) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwyoHQACgkQbDjKyiDZ
s5LYBA/+Jmr0VAQL4A+mBUeLwHDQLttJYF3MSmBaBIGKWikqT3A+YEkUSe3mRTQ1
Pexq0l8TT0uJxQJ9sQsGPh5lj6VHrN1TDPJrLuxEMC1swmkOyzHGSMMClWoWSjpb
E2F+XQj8u4bZdTMJxUjoX5AJfSRkQ6Rt14EX3oOQAewhPddWR9sO3mVhnibnvid2
JXjaQeEPvwAlYgLdydCSQbC6DWLv2LtwZvcVnUvyWUDeD64TkjQhItdo5uIalDtV
/hbJq+NHPhLrKOmooY/CcSVERKJ5525Dz6kePRxJxXh/rbMOWlsw9K41NiVhE1i2
ssWrqisfO/DBJq+15zrigHUUzZXVZOpe3yFWXSTrWW03bd6wD/+76vJ0h+s8Ra4F
7hM4/nlPU7ylhCfw+SnYLEnId9Zh2Tm2OI6zioo6RUF3XcA64hnMD6zNvhDwlBym
AhGTMiIKdATuYzxIXQ5L/QofQe9BZhxEu9NBNjIrotNwo7VSvQHyeUvEOFUnS8tC
yuULOPqTnfSocywD6cIjimAHzS1C2hT3ISWD/SIOSLh+vcgQJctVgftaXLTVRSzK
I8TcLdcSxLJ3tCrjo8bkTWR9Sq5e/V9ni2CP+zmFlbsvwHkZWDxKdcUT4w6FH/pd
qnZ7oNMrAxar7oMU7kgznf1WBbubh9W5uUoO6cnbWIrS9sdNKBQ=
=ulzS
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
