Received: from eggs.gnu.org ([2001:4830:134:3::10]:43466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMPlC-00081Z-TV
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 22:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMPlB-0003Si-Qf
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 22:16:18 -0400
Date: Sat, 17 Jun 2017 23:04:31 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170617150431.GA22102@umbus>
References: <20170616172230.22755-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20170616172230.22755-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr.c: consecutive
 'spapr->patb_entry = 0' statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 02:22:30PM -0300, Daniel Henrique Barboza wrote:
> In ppc_spapr_reset(), if the guest is using HPT, the code was executing:
>=20
>     } else {
>         spapr->patb_entry =3D 0;
>         spapr_setup_hpt_and_vrma(spapr);
>     }
>=20
> And, at the end of spapr_setup_hpt_and_vrma:
>=20
>     /* We're setting up a hash table, so that means we're not radix */
>     spapr->patb_entry =3D 0;
>=20
> Resulting in spapr->patb_entry being assigned to 0 twice in a row.
>=20
> Given that 'spapr_setup_hpt_and_vrma' is also called inside
> 'spapr_check_setup_free_hpt' of spapr_hcall.c, this trivial patch removes
> the 'patb_entry =3D 0' assignment from the 'else' clause inside ppc_spapr=
_reset
> to avoid this behavior.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e877d45..bd31972 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1326,7 +1326,6 @@ static void ppc_spapr_reset(void)
>           * Set the GR bit in PATB so that we know there is no HPT. */
>          spapr->patb_entry =3D PATBE1_GR;
>      } else {
> -        spapr->patb_entry =3D 0;
>          spapr_setup_hpt_and_vrma(spapr);
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZRUT9AAoJEGw4ysog2bOSHugP/RliM4lTAJuunsPuEub9B2dT
GVAKAHr85ktPy9jKWUVDEaPcbAPcqTBYMpAzP9ltOMlJwiS0M0SFLnRK/O58xe6D
mIlPqSXG+IeK5saYfI/YWRfwJcAe+RbBdtd3t/8Wn2PmEAGPO8Uk5BgOz4ief9IX
Pgq7HAmVmA9YtBmwuER5NUgjvP9SW11Ra4NFa5fK/mm8eftLqy7Ct4Nto9v/g5mv
d4gZCx83DbuwzFWq1xMnHy24nyzZY2rY6DxOYI4Th93Sz7iQDH5PuK6m5nyIxP5d
Rhj23ubu16X/Tlg2+zscLUzfh2vBH3kPw4PttYPjDMn4H2Z59kk+svY5tQr46iwq
G42Z0Wc81LxvthstGiqwzSmx/wair+Gv1bd2w1YXYZYGdExRv9RYfGbpzcZgjRJh
Ngba/rdM+1+juBGkykJCkh2qWwYMKo/XYOR4SgS5rMNs6EdXfnCl2HNgPQdaUmGa
3e2CLuhJMyPYW7xeMC/e05Pkt+ue+6GHsLmrAYQS3XYPJFkcZKfwMGvZAcouwlQq
3T54FqH5BjFweFqEJQIBp0nBC0JNu6ECoGxR/PuJWSII6pzL9gHbHNJsU01UBoyy
BTzdbdAnLpyjE2oF4Xyahl+cmoclP7VHHKlAuxDoKScy44rgdID7YWsol0g/2WhV
kXejy+QJbSOXGEHn1Y6j
=tR2Y
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
