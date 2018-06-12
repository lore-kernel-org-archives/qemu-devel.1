Received: from eggs.gnu.org ([2001:4830:134:3::10]:54260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx7-00066w-P8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx6-0001zi-UI
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:53 -0400
Date: Wed, 13 Jun 2018 09:38:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612233836.GI30690@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline
In-Reply-To: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: drop empty #if/#endif block
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


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 06:27:54PM +0200, Greg Kurz wrote:
> Commit 9d6f106552fa moved the last line in this block to somewhere else,
> but it forgot to remove the now useless #if/#endif.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  target/ppc/cpu.h |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0247c1f04c37..a91f1a8777eb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1300,8 +1300,6 @@ void ppc_store_ptcr(CPUPPCState *env, target_ulong =
value);
>  void ppc_store_msr (CPUPPCState *env, target_ulong value);
> =20
>  void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
> -#if defined(TARGET_PPC64)
> -#endif
> =20
>  /* Time-base and decrementer management */
>  #ifndef NO_CPU_IO_DEFS
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgWXwACgkQbDjKyiDZ
s5KhWRAA1p9OTVMF2MBDNA+pIL0TIa9S9WOQL59jqRwn+1GwFZfnxn7TglRK4sqo
ps9ih7ItWPnAa6y5ah9Eyw027o4SzJllk3++pteIb8Ami6SdvkVcCxkDCe5zpVwF
pknUqQziyECoE4uKYfiah7VtMkdXNDgnRANnXq8HGhCxwcEsNSmjnnrxb+r912IZ
wLzdSs5Nz5eDtMD8gxJjquQzHCtcY5BoncZNhnwkK0zQU2uPUAJJdZO9xH7chBKc
DlukmddtPAvyWkYRE9Gt8NVikpJbkSyqO539qmU5UNAFr4ZkafSUCtcLPVjSFUTn
N0zOHRJ2tnscalla+UBOMuVBl8l0fu/PfWoVhbuTH4/cJ7c/otyatkhlQ+kCt40E
b/szJ9mxrS3n4qsP2ok33+24tU0nTNnA1q4k0RKOvI1CCzNkwalThUzVQxUu82Ow
jicEbkdzP+gS7O+9TSKM4FmdVNE8sRA9SnHiVWU/JQiZUo56L4tASlVOf7Aqe5TJ
invkLNyRFm0rWMukLIbOlYgTMwnQ1Qt/ZvMPT1xEvlvr7FO8zSzA+ucpSK4FSHjb
pGfAc8SIe4PAigFY8ZcdnDTswYX8TOhahdH4IyKl8JB954NBb3BTOa/B5iJAB+za
+S1dj4jh1Ahqw+/S80UFFHoojPmmDogzmVpru0ZjFAiznSjEays=
=n0Sd
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--
