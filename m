Received: from eggs.gnu.org ([209.51.188.92]:34797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gysWJ-0000u1-J2
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gysWH-0003hd-KJ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:16:43 -0500
Date: Wed, 27 Feb 2019 17:15:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190227061508.GA6872@umbus.fritz.box>
References: <20190227051859.26026-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rwlp4HDnqjg7pxzw"
Content-Disposition: inline
In-Reply-To: <20190227051859.26026-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc/spapr: Enable
 mitigations by default for pseries-4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--rwlp4HDnqjg7pxzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 04:18:59PM +1100, Suraj Jitindar Singh wrote:
> There are currently 3 vulnerability mitigations controlled by the
> spapr-caps mechanism, cap-cfpc, cap-sbbc, and cap-ibs. Enable these
> mitigations by default for the pseries-4.0 machine type.
>=20
> By now machine firmware should have been upgraded to allow these
> settings.
> Note: This means these caps will have to be set to broken for tcg
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

There was a conflict because you've diffed this against a tree which
already has your large decrementer patches, but I've fixed that up and appl=
ied.

> ---
>  hw/ppc/spapr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 73aba70aa9..1ef8865dc5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4313,9 +4313,9 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
> -    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> -    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> -    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_WORKAROUND;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_WORKAROUND;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_FIXED_CCD;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB */
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D 1;
> @@ -4394,6 +4394,9 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
>      smc->dr_phb_enabled =3D false;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rwlp4HDnqjg7pxzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx2KukACgkQbDjKyiDZ
s5I07hAAiBuYx6W3D+h5iHI2oah80BGvh0Wqjv7kcLSUGe/RMaRBEOUv+OM+VN5o
888YZl7alKXvPFLBkD80XGhwA+wm+SbioYKid1R5Z+F7SYYzk3GoiFd44+bhKo+O
f705YDq2/dBDK2cyeHbHD/Qgg+4He5Li7ujiFz3BvWSjex9CN20kobavPAIUhhop
+0T86vj1E7heEpAebfyTBngiFt8kRfYQwklufq+p62+9uxotOPlL2lTFhsJXFNgh
aJcpeANzlfmLliFZtEEuHTGcUj4VZD2lcvt56PlH96WPzOhLVmnTUpw0F8B0G9HC
DXH4OneKna1LbHcGF1AjHHNZY6DQIC6i4Sp2uzTRMhQARvwZMNy4QaIkjfAhp3F2
H9Z5RE0rldwoJWufxmFi0Ot5gR30bB2IaZ0+jTKTCFayJjmjv3F0hcnK/1dnzDCX
gQE87CYAF6P/lWIa9/MPTQ9YOSBbR5UZQG9LY6OW29BzesUxhKCygdUYh8aiPFfi
TpfJ6z3M/G8+noD3NX0IceqTqgBLhFpU45SFbHAeuQYvGwdJhNznIENj56D9GUco
bw5OvDMoqX1vC9RM2/V+4I6/1MNSSAENETll23Pvm1YznqE09p33xcYYqxcttxdn
x3gX7wdPEPtu9AmbjrY9a/q5htZ4lxICL59raVWJrBUpUAn6em4=
=t6dT
-----END PGP SIGNATURE-----

--rwlp4HDnqjg7pxzw--
