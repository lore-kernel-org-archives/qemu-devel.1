Received: from eggs.gnu.org ([209.51.188.92]:39714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gthds-0005Qh-KX
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gthdr-0002zf-CA
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:39:08 -0500
Date: Tue, 12 Feb 2019 16:59:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212055900.GN1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwtQuX191/I956S7"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-8-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 07/19] target/ppc: Make special ORs match
 x86 pause and don't generate on mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--wwtQuX191/I956S7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:13AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> There's no point in going out of translation on an SMT OR with
> mttcg since the backend won't do anything useful such as pausing,
> it's only useful on traditional TCG to give time to other
> processors.

Is it actively harmful in the MTTCG case, or just pointless?

>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e169c43643a1..7d40a1fbe6bd 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1580,7 +1580,7 @@ static void gen_pause(DisasContext *ctx)
>      tcg_temp_free_i32(t0);
> =20
>      /* Stop translation, this gives other CPUs a chance to run */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +    gen_exception_nip(ctx, EXCP_INTERRUPT, ctx->base.pc_next);

I don't see how this change relates to the rest.

>  }
>  #endif /* defined(TARGET_PPC64) */
> =20
> @@ -1662,7 +1662,9 @@ static void gen_or(DisasContext *ctx)
>           * than no-op, e.g., miso(rs=3D26), yield(27), mdoio(29), mdoom(=
30),
>           * and all currently undefined.
>           */
> -        gen_pause(ctx);
> +        if (!mttcg_enabled) {
> +            gen_pause(ctx);
> +        }
>  #endif
>  #endif
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wwtQuX191/I956S7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiYKEACgkQbDjKyiDZ
s5JFSRAAnDXwWL+Sx1hMlNETT0m3mjLbkZgie+NUbevAWfgoz9phoLiPumzOIas5
rQSwotMK7axq1VrlF/RmodiBCYkh/O1lIH+/rjkZzYwOKLfEtKAiMz+LUDLAaQAb
puSYQ67KndT+gLdLi2AZpkSuWaTu7JZmGhL03fuuklvYb2HIiuTsyOdrFtjGuMCO
JhmzhgftV53TWeRq4ljmH9PQ8DUNwC9GelqutBYzzf2AnpccvXMSJd5UQOktccbp
5IXKba+ZXWo9zEG027wtWg64TBJwmVBZ4pwBwsNbWk13OusTUY+aSWQpYGMmEzhi
I0nsTgSRVHByfRNFSzYtMEmFkCOj91qyq27LQY6wRgNIf3ZeJs0GRSQayDcF4x8H
mri6KFLjJ3WabhqYojPzfw56BY9caqOTw0IFj+85AiLBHUe0Ie5Ftl98oz/L/V7B
RN9uWxH+dXipngL7eqyGsZYaMuka7v39N8jLs78rVS3I6J5MjUHvLP83fZTvj6Rc
NsfrmaNbmi7UKzgG4oM40bhKiAyVsjOFG5AqtM1ZBzHE24zHl0xh/E5k5qjatTW0
QkGtE+nFhD8awC/0hkQPG682g7Va5eP70uZ4V624H9BdM1MaUVvww9Jn5JOxWS0H
5s8NRPCqGtt49sxo/xutLWF5dv86XBKCjsQjB9b3q7ocWJZXeQk=
=/p84
-----END PGP SIGNATURE-----

--wwtQuX191/I956S7--
