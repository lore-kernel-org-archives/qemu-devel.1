Received: from eggs.gnu.org ([2001:4830:134:3::10]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR7hS-00024i-VQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR7hR-0006pi-N1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:04:26 -0400
Date: Fri, 8 Jun 2018 13:03:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608030319.GE3344@umbus.fritz.box>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <20180607144645.10187-3-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 11:46:43AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Use abort() instead of error_setg(&error_abort),
> as suggested by the "qapi/error.h" documentation:
>=20
>     Please don't error_setg(&error_fatal, ...), use error_report() and
>     exit(), because that's more obvious.
>     Likewise, don't error_setg(&error_abort, ...), use assert().
>=20
> Use abort() instead of the suggested assert() because the assertion is
> already verified by the switch case.

I think g_assert_not_reached() would be the right thing here.

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/ppc/spapr_drc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 8a045d6b93..b934b9c9ed 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -366,7 +366,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
>              break;
>          }
>          default:
> -            error_setg(&error_abort, "device FDT in unexpected state: %d=
", tag);
> +            abort(); /* device FDT in unexpected state */
>          }
>          fdt_offset =3D fdt_offset_next;
>      } while (fdt_depth !=3D 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ8fUACgkQbDjKyiDZ
s5IyURAAz0c4WX9kJMhH4r7VZ39QKxJDERT9r+maqEe83rbcOO0AANCMOlsgL80C
jeUlto5tQnUpdcylsUgrkjdiELZ4vitpTdSmNDU4qODWTsFcW/UpGRkoBcIEE3SZ
nmJkt/zyoGY6nQHn1uEBHF/z5RyBQdlZIXnnQy7E0JL4KDn/xQbg/dOtseXmm2k3
LBaVjV0XxpqkLaBpirVdQZqcvhOSJNDtbGU+F2moroFIUCYdiTCViu2E3BpIvlhJ
LBXVsBM1G7FvSKHt5ZrPEmLUQQ7HjKjwVD3HqM7qSMQvEMeaZa8sA4Nr4N8GS5gc
aIiecpmVa0fy3zcWPMJjCnyQME4mm49Dq5DS8NSdxp9HuXH69neb6GXtV7YIF3aJ
4p7lBmnhbUw3GbQT+rBPcu9f/7YT1Kv75Dc4SWXoaMm45q7euGXhXxcyNV7Em4XO
fKALJuNQlQmi22eCvYGQWAGBXNW/qsdCULlRjzWXsXbHIGrvnAPfmPRuqGsDxGlW
CQwh0/Nsawzp+DCGMh4VnEifDbZKucDxFIuWseF0KB7dLjq1msZR4lba74CYwBBR
V2/y58JtTi2vGP0b4E5hpWw4XgyaLqc1EdyY+ftWIolxLn1Dpx6ehh8QWuh65qvx
Y3rRLzZ7yTOMAVthL0wpbgRS80jT5gxlN3l6fo4LVUxu6BgVUD4=
=aWnp
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
