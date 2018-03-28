Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0z7S-0003jp-TY
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0z7P-00056A-RD
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:39:14 -0400
Date: Wed, 28 Mar 2018 11:38:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180328003852.GE3510@umbus.fritz.box>
References: <20180326001421.0E0937456D7@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <20180326001421.0E0937456D7@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix reserved bit mask of dstst
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 01:54:28AM +0200, BALATON Zoltan wrote:
> According to the Vector/SIMD extension documentation bit 6 that is
> currently masked is valid (listed as transient bit) but bits 7 and 8
> should be reserved instead. Fix the mask to match this.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.13, thanks.

> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3457d29..b0d79a3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6561,7 +6561,7 @@ GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, P=
PC_CACHE),
>  GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, PPC2_BOOK=
E206),
>  GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
>  GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
> -GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x02000001, PPC_ALTIVEC),
> +GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
>  GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
>  GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
>  GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq65BwACgkQbDjKyiDZ
s5KcaA//aCFxjX8Npa7wqADeihEWc8Z6MVsglefONHwjYACFYFhtJm3EfhaG2u0B
mhkRcUtBHKZYIjbUwFIcwr3oYOl3zszzjuMaktu293A8fSYsKS2UvIjOZLGXjmpl
sJpu+5nSmGWENr7Lx7iqqBNKEknHn/gucbWa9PROGWkqNth3QsvwCjURRtBdRxeR
239fwdkc16iJTf0SpgD2NHaOl296gWW83s7aYWseSuSII47iKyyqr23D0q/jl07P
VA7OdWY7KHOi4mX4asXBDpsh6peCxgr0i/4mnCalpU3zGw9StiQH3bVL9hk6D8wT
E4FzVAVBZ8RjCd3QGsvZHAqKWb0/D5+RJyIIl0608pY+3oIS/CXT+wGxa2wl3DW0
Z7c4RxKVUD99dvEnpn8dgMGQiQoypO8E1uvJ2oLemqGg6J7Fu0/ds0qYbxHTOghV
g9t0LK/CmzQUxUqm4TS/DeudDkGl+BTpbK7/Q9k+I3XIRBHUoF3r8Kwia4Y/6P4T
4b19/xrFBHWZdbognRyfCNIT26xEnCQ1F73kM5J4odqpsLW50G/rlpnHb+hdqkg0
Ass0RTn9d1xEi79Wch1qjtSYh5e5rsGJjEWCKCyD43J5Bdl8itksgUQcUN3sLo5w
o8YbvOcgPZoaJJ/2rxaQoQqbKFrhl8Pd4pCgdCysmLUsE6qv2yo=
=n1lh
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
