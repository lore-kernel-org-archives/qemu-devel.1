Received: from eggs.gnu.org ([2001:4830:134:3::10]:44561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRW0v-0003up-Ip
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRW0u-0002ZD-GQ
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:57:37 -0400
Date: Sun, 2 Jul 2017 13:04:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170702030440.GN13989@umbus.fritz.box>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-24-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Content-Disposition: inline
In-Reply-To: <20170622124204.19407-24-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/31] ppc: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 02:41:56PM +0200, Marc-Andr=E9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/mem_helper.c | 2 +-
>  target/ppc/translate.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index e6383c6bfa..a34e604db3 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -111,7 +111,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr,=
 uint32_t reg,
>                   uint32_t ra, uint32_t rb)
>  {
>      if (likely(xer_bc !=3D 0)) {
> -        int num_used_regs =3D (xer_bc + 3) / 4;
> +        int num_used_regs =3D DIV_ROUND_UP(xer_bc, 4);
>          if (unlikely((ra !=3D 0 && lsw_reg_in_range(reg, num_used_regs, =
ra)) ||
>                       lsw_reg_in_range(reg, num_used_regs, rb))) {
>              raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c0cd64d927..76f9ccde25 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2882,7 +2882,7 @@ static void gen_lswi(DisasContext *ctx)
>      }
>      if (nb =3D=3D 0)
>          nb =3D 32;
> -    nr =3D (nb + 3) / 4;
> +    nr =3D DIV_ROUND_UP(nb, 4);
>      if (unlikely(lsw_reg_in_range(start, nr, ra))) {
>          gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWGLFAAoJEGw4ysog2bOSApwQAIAlw5hi1BCMl42KHO4o0BPN
G09pkj7yY1IcgGLo8EedBoinp43WG8+dkKERlihxIf72H0FQuKxf4y6xbdZELm15
r0LWvetFTOJKQ72Ai3HFTJMH2kjAujPROk+cdwpDNHk4z8pPj0gtYCUV385FMc4V
DGEEeCNjS/Z/QzwVZw3CDugWvnoScmIU7KGGsHTylMY69rWEHgdhukbUrykZ2WLq
5TLraBx8FlHlSKatZW/bIYCtuOIo5e99hknFbMmvocqgXhdSH/o+yNO9RCDhtGFE
aUQlixqxR25Ur2eU3r8lgDIbmpjw1lBZxHL7cPyB6MjwUT8hm+zS/t4S3tfF2Ufz
/+3IVQpTcpy6vU67fX2RILzx6iO016ekoX+JIZLUqQm4sZWBtX4xDovez0T6Nllt
IbQPlgmQAqGLw0PfMSufBahAPSaCuR5E4WHJQHwPMLA9hiMPbPTVTvS2AZs9L26n
jf/6z9DewNOGtp4sHQzhT/X6CAXwRU3l2/X1ROqJqy/fJL+oSN0qoKOUvd11derw
Jh5BunQArbXJaEtzXNkwyaOfBUGMNc1teloA19G6FWFR2nMT7inUhHhQbNqyCNUg
0B2UlRL7q71tJ4Q1B3haj2hR2Rd5P1dcwYn3kb+lA6q+tOVCRsO5uH0M+H7kHa8I
zO5Kyu3QVAxjs9VgA33m
=RaDc
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--
