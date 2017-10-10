Received: from eggs.gnu.org ([2001:4830:134:3::10]:38914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU1-0004NV-IT
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004Wg-7O
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:25 -0400
Date: Tue, 10 Oct 2017 13:05:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010020518.GI2668@umbus.fritz.box>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-18-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline
In-Reply-To: <1507578671-158758-18-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/24] ppc: move ppc_cpu_lookup_alias()
 before its first user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:51:04PM +0200, Igor Mammedov wrote:
> next commit will drop ppc_cpu_lookup_alias() declaration from header
> and make it static which will break its last user ppc_cpu_class_by_name()
> since ppc_cpu_class_by_name() defined before ppc_cpu_lookup_alias().
>=20
> To avoid this move ppc_cpu_lookup_alias() right before
> ppc_cpu_class_by_name().
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>   - split from "ppc: spapr: use generic cpu_model parsing"
>     were asked by David, it makes the next patch a little
>     smaller
> ---
>  target/ppc/translate_init.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 3d16481..17ac95b 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10060,6 +10060,19 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint3=
2_t pvr)
>      return pcc;
>  }
> =20
> +const char *ppc_cpu_lookup_alias(const char *alias)
> +{
> +    int ai;
> +
> +    for (ai =3D 0; ppc_cpu_aliases[ai].alias !=3D NULL; ai++) {
> +        if (strcmp(ppc_cpu_aliases[ai].alias, alias) =3D=3D 0) {
> +            return ppc_cpu_aliases[ai].model;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  static ObjectClass *ppc_cpu_class_by_name(const char *name)
>  {
>      char *cpu_model, *typename;
> @@ -10152,19 +10165,6 @@ static void ppc_cpu_parse_featurestr(const char =
*type, char *features,
>      pcc->parent_parse_features(type, features, errp);
>  }
> =20
> -const char *ppc_cpu_lookup_alias(const char *alias)
> -{
> -    int ai;
> -
> -    for (ai =3D 0; ppc_cpu_aliases[ai].alias !=3D NULL; ai++) {
> -        if (strcmp(ppc_cpu_aliases[ai].alias, alias) =3D=3D 0) {
> -            return ppc_cpu_aliases[ai].model;
> -        }
> -    }
> -
> -    return NULL;
> -}
> -
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncKt4ACgkQbDjKyiDZ
s5LReQ//c8DmRHeScelHwX/896rvDDltSFYn+hOy27mUOGhI2dSRixEXmRAlrv6n
HFkUigbB5CM9L5OEIeRyUi+8MI5d2zygmXNYxFfrRjYWyb/7rP2shiJ3mk2UBVzj
Tjp38HP5l3w2ClQHvteZ/9JdgS3J+kjg3xKIePJjeu3XKJOSPLMxbr8C82yYFKMf
r8SlNhYDwWZGSATIvfyAxq29yRZxMlkIL2LPjh2KI/XzAwGFvXN/M27W4jK4jKV+
uwF2H30veidw5tNs9vSASR4aaw/l6tW9vmDtSYR/jWQoOZeo86Dz5OLEZ5L3wETw
rIKDD7d273UzD+M5Gr+sRYdlfOa0x1xcQuW5kcuwQxY2lj6ir+qXJ2prWiBZdazm
NKoKXc6jTJT79tXg1Gn2ihFX4NWCX8dmwSsMO4shrZ4hEbr0U/0tzFPBjfUq3n1w
khfgg9cYaYqx07IcApZ4ntQfrdlVn/rx3Ulpszy9KBmF7/eMTkGGLCNELbUFCAue
BltygTzqPJcO8EN43Ai/N/hsptYOGbYxymxluchuyvRYvTfIWSNeIYk5NdQQsGoo
oewFvxM8QROg2dSMJ271d6JpwZa8e5eBgUwLwAeFHpfv3mUSSwrCYFxXVA4sqf/Y
UCmv7166687OqCnhCvTldLJHcK8SY7rEYHZqUR2FRGUUo1m1098=
=z/5N
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
