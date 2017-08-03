Received: from eggs.gnu.org ([2001:4830:134:3::10]:54539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dd5Yh-0003Yx-Lj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 22:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dd5Yg-0005ca-8H
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 22:08:19 -0400
Date: Thu, 3 Aug 2017 11:37:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170803013723.GI394@umbus.fritz.box>
References: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] ppc: fix double-free in cpu_post_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 07:34:16PM +0200, Greg Kurz wrote:
> When running nested with KVM PR, ppc_set_compat() fails and QEMU crashes
> because of "double free or corruption (!prev)". The crash happens because
> error_report_err() has already called error_free().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Oops, that's a bit embarassing.  Applied to ppc-for-2.10.

> ---
>  target/ppc/machine.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index f578156dd411..abe0a1cdf021 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -239,7 +239,6 @@ static int cpu_post_load(void *opaque, int version_id)
>          ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> -            error_free(local_err);
>              return -1;
>          }
>      } else
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmCflEACgkQbDjKyiDZ
s5KwThAA3n3J+E06G2QjUm1rQLfB2GlJEZQ+IgdpjNUZLvhFCPukWz2dmvX82j92
z+PdQern9jpc7Z9KtXo+C6/aQG8/OJAcMpWMAbwM7IJoFqkFSIGAsv5MiBrBrnOG
oRsnE6+vn/rMT2HiWQMWLYZfDZdjplbpXYCNPqhHWjL64jlmqrGkMf7S9s7G9w+H
OY2pOdZAGkagRlvwBCIzJ7qyNmCybWlzgMRQqUJvv0WU8aWM5DiJ+aUvFYwjheD4
xukmnKepgIA1WdvNm9YDIKEkoUr6gKIVSh+Mk9PsbRMmkLG0WSnNa7bTURBJzEpC
S9U50ARczncUgTaP4ijRPHQzgh2dlgB9uqhe7N7SUjIH9F41Fw7UmFp0npZkhKON
hMGysoSaTM+v1hBaZCQKQyLCn1/Ggl8PulJlPbm/lIc8eVM0zLxUVRyTPAAO6P06
oi2ZrOJx2+Q7chSIVC15g0gp745AoTZp1QbAi0SSzfkCeAmoKcbwCctRa2Vs8I76
/urQpT2UlcZW9tsp/BKP+BIVKI1FXI7Vb6fP34Cf5Jri1wGwecolEdDqplGliekE
cvm/evGQeCswdgRDRA7MXuALO0PosZd2YNwCGcBWW0shDXMWgUSMA2b84Z/EXw9i
DgoGbKPM0tSB4BDrr297gGgWAAqvc89k29IqXeAcjHJhQxs6dVA=
=cxx8
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
