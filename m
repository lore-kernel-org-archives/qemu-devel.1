Received: from eggs.gnu.org ([2001:4830:134:3::10]:34377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilY-000274-4o
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilU-0006Wf-UJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:52 -0400
Date: Mon, 4 Jun 2018 11:25:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604012544.GF4251@umbus>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<20180529174821.19964-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline
In-Reply-To: <20180529174821.19964-3-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by error_report() + abort()
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


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 02:48:19PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Use error_report() + abort() instead of error_setg(&error_abort),
> as suggested by the "qapi/error.h" documentation:
>=20
>     Please don't error_setg(&error_fatal, ...), use error_report() and
>     exit(), because that's more obvious.
>     Likewise, don't error_setg(&error_abort, ...), use assert().
>=20
> Use abort() instead of the suggested assert() because the error message
> already got displayed.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied to ppc-for-2.13, thanks.

> ---
>  hw/ppc/spapr_drc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 8a045d6b93..2edb7d1e9c 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -366,7 +366,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
>              break;
>          }
>          default:
> -            error_setg(&error_abort, "device FDT in unexpected state: %d=
", tag);
> +            error_report("device FDT in unexpected state: %d", tag);
> +            abort();
>          }
>          fdt_offset =3D fdt_offset_next;
>      } while (fdt_depth !=3D 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUlRMACgkQbDjKyiDZ
s5LkVxAAooh+AOYkAl0qB8DmNHEsnIQ//BkKuOVi+cMFH+NNSgmOpJJT5qDW5vnn
AyEm8iRqNmsJBaHjhhhS6V4lCoWc/j147jwc1F1HA8LX5AEpihGysWnVd8Hfzpiq
x+JW3Noa+CIyKBrNY86riOvC9ZcwsB+diNAoM0fG2iKNx3mrEtAnC2p29wLDMhbH
QftQC2u19HOHBimzUjnfItS+K6V/s7z682FiUm+AHT4kjhYJHBLVZusBwDy/P4Az
QYbBicqxQWl8RC0dTHxY1sJ/G5bQk8UTsUDn9eGcoPCUKqQE3xmm+mUZjBvFXioi
JchG+puzjw0U2VSTPR0PT2f5fg/KkHwsSI5rxkFdhLyfhM8HuWXIRjw37BOKa7Yn
jaUV1apw4KLMbPobepDxrIRiPryMeYdRq+yHyZf+BnOHq49qHCl50uNWL6P3eYma
DqvOwZ5nKaRvc7eaWtC11dPTfpLbXsusUi/fRV2QiOcNWJg9lu6mF4nfkT1RlEgj
Cjsh23nhLqlKDNWfI+xl62+tr3WvLqVi2aDUDnqVozSfPXugifebUrQ4SQx142mS
C1hKYh9velu1J5YrGwN6opFdUBj/OIi1pWGXGoylyOD5gRAQ/Q8BE6qJzQTl5OcY
HvqUrXLtn4VLIztLRIDsBao1etMWW9qdmB8bSQUwfYvU19/8dts=
=BSgD
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
