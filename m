Received: from eggs.gnu.org ([2001:4830:134:3::10]:37687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXQh5-0006fa-3N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXQh1-0000I3-4z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:29:35 -0400
Date: Tue, 18 Jul 2017 21:12:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170718111208.GJ3140@umbus.fritz.box>
References: <20170718101632.3304-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline
In-Reply-To: <20170718101632.3304-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr/htab: fix savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sbobroff@redhat.com


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 12:16:32PM +0200, Laurent Vivier wrote:
> Commit 3a38429 ("spapr: Add a "no HPT" encoding to HTAB migration stream")
> allows to migrate an empty HPT, but doesn't mark correctly the
> end of the migration stream.
>=20
> The end condition (value returned by htab_save_iterate())
> should be 1, whereas in 3a38429 it returns 0.
>=20
> The problem can be reproduced with QEMU monitor command "savevm":
> the command never stops and the disk image grows without limit.
>=20
> Fixes: 3a38429748aa4f74abaecf16c4c087e8a325e12a
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-2.10, thanks.

> ---
> v2: remove change in htab_save_complete() as
>     it always return 0 in case of success (Thomas)
>=20
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 970093e..1cb09e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1827,7 +1827,7 @@ static int htab_save_iterate(QEMUFile *f, void *opa=
que)
>      /* Iteration header */
>      if (!spapr->htab_shift) {
>          qemu_put_be32(f, -1);
> -        return 0;
> +        return 1;
>      } else {
>          qemu_put_be32(f, 0);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllt7QYACgkQbDjKyiDZ
s5JeLQ/7BWEf0HU0WnLH0cWtBX2VdYoHml8Nuwn14FXbGIC9R7EAZNKAjNrkXVlj
8J2lJ4MYm1dERAr0T3gDa6D+8zaVDL4Z+rNbTeQ/l8aCIlA0WfIjxpxVagCdUkl+
UQ1uNhu5+bKcPnPmpVRInFYeFJVdqUWC4axgzK6zDHLRGbD5nekYMxEs1HS/Hwrp
6NVoT+Op0HiyyVfaGl0ie2BqxNIGuDppCUnq5diI9zeKSpJUndCThm+RZffd2III
2UEXPIgkGEsGmB9CdX65LO0G3jLcHsmqGZB10uStqBptt9W9t6He+bmzTejmdVwQ
idfZ/KI0tDjpsSKwajopccuY1WstARnAmflnyNPi8gp0rzKdx5+3kOhgkzhLcKO6
QzUN7401ZiMLP7UrPmIhewMzLf9f0a+PVny8F/2ecefXFhTZKw1a4w6QsMNjHK47
Jf3YiS6Se6DEZLaeDQn06MnasjnfRAzuBjUNTcDEY6y87QGl5/ILIpZIDNUFfdpH
H61PSushknNBDWF8zn3QYCbrgd1J2v1Jl3LTPYIxm9UJERyQYByVXmSs7rjlPPbI
DUVZxHJ92+WUbrlGoQDTRkULBIfAYOLiEbRs2UFiJx339jnC17/PeWpOgpEOzHOt
zsA7TV48/KVc1mrsGB/BE6Qz5yce/x9sHwO4g2MDDU3pKIBTaA8=
=kLcz
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--
