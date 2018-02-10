Received: from eggs.gnu.org ([2001:4830:134:3::10]:36715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekRNQ-0004tW-DF
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 04:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekRNM-0000Rk-9E
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 04:23:20 -0500
Date: Sat, 10 Feb 2018 20:22:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210092240.GP11634@umbus.fritz.box>
References: <20180209081858.27013-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qcTtWMBd/uZDG7+Y"
Content-Disposition: inline
In-Reply-To: <20180209081858.27013-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: set vsmt to MAX(8, smp_threads)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>


--qcTtWMBd/uZDG7+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 09:18:58AM +0100, Laurent Vivier wrote:
> We ignore silently the value of smp_threads when we set
> the default VSMT value, and if smp_threads is greater than VSMT
> kernel is going into trouble later.
>=20
> Fixes: 8904e5a750
> ("spapr: Adjust default VSMT value for better migration compatibility")
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied, thanks.

> ---
>=20
> Notes:
>     v3: use MAX(8, smp_threads) and let KVM to return an error
>         if nb_threads is too big
>         update subject to reflect the change
>    =20
>     v2: display a specific error message when the default VSMT is used
>         fix subject
>=20
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 32a876be56..c8a1eefa17 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2310,7 +2310,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *=
spapr, Error **errp)
>           * the value that we'd get with KVM on POWER8, the
>           * overwhelmingly common case in production systems.
>           */
> -        spapr->vsmt =3D 8;
> +        spapr->vsmt =3D MAX(8, smp_threads);
>      }
> =20
>      /* KVM: If necessary, set the SMT mode: */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qcTtWMBd/uZDG7+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+udgACgkQbDjKyiDZ
s5Ie+RAAqoDrNRevguP9ZhWMhE0jxJyBIo+XEaiVlVQ3KZNvOHqg3VO2jrdzzfig
lUfdi/pAHawt1icnGkmQM3yusJ5yDolcnYwpeyXJXcdFowVE4u6HzIAHTpCmMSyz
/6MYYAhu5uMo4KNyTgqoVwivnmwZrX+CeZ5/0ca9/fdlNS9/HaK2g9sassLibclL
F0/HDgIOqWbA2ips3tMSEA+DYze/rgc94Nv1mucBM+bXvb0er5U/XpXWjWNzlq3L
9hAnCBQYuXQSjcaf1XeancRiLVLdkokLRRLtTh7m2O1JYkt3NP/59FKa2nVQgmSx
vLSstLS21ed/vFpVB1Mvpa2fwIhD2LDbgatxJ1n0WreDlpB4XNsQ90OuW4equzQO
we9L/LJa7DDQUiIMzXsaJm4fLQW+jGd6BUrKwk1ouKMiZA4ct0job80aFDUuCQm3
6vrUu4tIGjCNjpJ3QiDdVnlkdJbqU9teXpiuGItnJKVeUG6KQNkgFUrCr5lU9OtT
0jCeMuuTY81d9N3yarJboHUOp4sZ2fBSb6pPv6LB7dxIltCd+Vh+y5zFjB8Ao3gh
raAcTaotGIOu0AhTRzT6RTta7PQha4keFMkUmUwD6CmzmuSTzbxUvpSTCHzVjha5
6FFx4Nne5yjcH0ogTmkDgFzmKI5MvBGyGK6IQZbDvkwnjqMJR5s=
=3hDa
-----END PGP SIGNATURE-----

--qcTtWMBd/uZDG7+Y--
