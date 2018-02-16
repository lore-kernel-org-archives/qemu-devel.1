Received: from eggs.gnu.org ([2001:4830:134:3::10]:34182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emVyX-0008Bz-3Z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emVyW-00012k-1X
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:42:13 -0500
Date: Fri, 16 Feb 2018 13:41:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180216024129.GB2074@umbus.fritz.box>
References: <20180216023328.8407-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20180216023328.8407-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V4 1/2] ppc/spapr-caps: Disallow
 setting workaround for spapr-cap-ibs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 01:33:27PM +1100, Suraj Jitindar Singh wrote:
> The spapr-cap cap-ibs can only have values broken or fixed as there is
> no explicit workaround required. Currently setting the value workaround
> for this cap will hit an assert if the guest makes the hcall
> h_get_cpu_characteristics.
>=20
> Report an error when attempting to apply the setting with a more helpful
> error message.
>=20
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied, thanks.

>=20
> ---
>=20
> V3 -> V4:
>  - Add this patch back from V1 to replace
>    "ppc/spapr-caps: Convert spapr-cap-ibs to be a boolean"
>    as this was deemed to be a better solution
> ---
>  hw/ppc/spapr_caps.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e69d308560..99a4b71d19 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -205,7 +205,9 @@ static void cap_safe_bounds_check_apply(sPAPRMachineS=
tate *spapr, uint8_t val,
>  static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
>                                             uint8_t val, Error **errp)
>  {
> -    if (tcg_enabled() && val) {
> +    if (val =3D=3D SPAPR_CAP_WORKAROUND) { /* Can only be Broken or Fixe=
d */
> +        error_setg(errp, "Requested safe indirect branch capability leve=
l \"workaround\" not valid, try cap-ibs=3Dfixed");
> +    } else if (tcg_enabled() && val) {
>          /* TODO - for now only allow broken for TCG */
>          error_setg(errp, "Requested safe indirect branch capability leve=
l not supported by tcg, try a different value for cap-ibs");
>      } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_bran=
ch())) {
> @@ -263,7 +265,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>      },
>      [SPAPR_CAP_IBS] =3D {
>          .name =3D "ibs",
> -        .description =3D "Indirect Branch Serialisation" VALUE_DESC_TRIS=
TATE,
> +        .description =3D "Indirect Branch Serialisation (broken, fixed)",
>          .index =3D SPAPR_CAP_IBS,
>          .get =3D spapr_cap_get_tristate,
>          .set =3D spapr_cap_set_tristate,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqGRNkACgkQbDjKyiDZ
s5KZwhAAzDzXnonR8TkwfaGL9Zq7mZ83zxoGu5BiojyN4tNhb7pCN4XS0bxnbKuO
+7ddB5bLChzBKSA+3UROksRgw4QEa2iUsgwjtNhVRpzMiwaI/d66tnDPXSt/yYxw
OYz/yMvAwguxa9+GSTFnlo63zk+AokrZjFKjBJmWduGSPqpqfCLUSG1xdBPNDndk
UurkDa6X2KHwxoXxZy2LNoieEyuU6G9IjhgzKZI5An922ClPiHX1kTV1HizkA5/C
nnvKPNulxuoEYnrYkrWZNZVmzcG2V1aKrKCrvsWXXHqZvwvjp7I5I4Qc9A7TJ3gD
pafCo4k8y28S19yTySCA/0CerCBbWkENeovOTKGRFxCO7nqI+rHh5HxvbFD7wZTN
2vfTB0wtVj2/y3Y7uk0voko7baGn2GWXk1QBsQOJdfLs46i+cMSPw6Y5RvuGwIWp
0DHVLy8gqBca65ZaW7q2h1Y0c1FnAIloqBhGT/k+69G/C55gcI0/dbVk4KSzewmu
YZ0IjsCcEw8X3CQuKWLOgxWFOToDHbKVx9aGFCA12MKSYH3s9fuqkPbS7VVVYDDL
zSf8evv30waEXpZXlbe4jjldUWRRFyUHKxarFiFpBn/8xLX+OhLxKFX6684gCwDu
WDhOF2xC146o9O8xirruFxy072bhoCrmvSRhf6k058VMESVJ/As=
=rMfB
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
