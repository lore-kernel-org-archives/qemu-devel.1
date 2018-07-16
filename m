Received: from eggs.gnu.org ([2001:4830:134:3::10]:49815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fesB7-0003VT-CG
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fesB3-0003wB-5m
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:19:53 -0400
Date: Mon, 16 Jul 2018 11:18:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716011856.GD2599@umbus.fritz.box>
References: <20180715211731.2EBA27456B1@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20180715211731.2EBA27456B1@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH for 3.0] sam460ex: Correct use after free
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2018 at 10:47:26PM +0200, BALATON Zoltan wrote:
> Commit 51b0d834c changed error handling to report file name in error
> message but forgot to move freeing it after usage. Noticed by Coverity.
>=20
> Fixes: CID 1394217
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/sam460ex.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index e2b7028..0999efc 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -269,11 +269,12 @@ static int sam460ex_load_device_tree(hwaddr addr,
>          exit(1);
>      }
>      fdt =3D load_device_tree(filename, &fdt_size);
> -    g_free(filename);
>      if (!fdt) {
>          error_report("Couldn't load dtb file `%s'", filename);
> +        g_free(filename);
>          exit(1);
>      }
> +    g_free(filename);
> =20
>      /* Manipulate device tree in memory. */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltL8n0ACgkQbDjKyiDZ
s5JBuhAAjobXzcgDgfeVLOGOReyBjcwJUdb6dllRKd1IqGiXNiZnaJ/EBoAAni8o
zd0Ll2rE8etcj86tkwKVKeMcEKQQk7MhV7g4cFGQASSjTuSCz9KzVvdmcJGTs6NX
U4gAoYSr8RMBPHDIg2w0bk36V5gk+fm7YZ3CUmLMFnzLAxaJ6pzskXPFG5Ej9Dvr
cguH98Y8mJQrWmWU4aNWPvEjZXCwJkUruzEI9ZRnc1U2R5Mm1nli+uyjWGvXL+N2
X+c6jySyuYetTHNT+cr0/9WwgIx++ZMXS+F+Ve7ZEx/cUTkmxIZFX0Aq1z3Nqx+/
VWzYfaQOxsAsTYReUMF+EBeTmCj3Zu9Z7qUrawBKqzRSfGFGlSj7aBASS8ItzsgR
bKOed7szz0V8kcX4MJ2gtyetLRTrTcXwKBY8bl7qUhDFpdDamma0r2qUr6+idHbA
DPYuN3lHOW/aAgO6tmYfuQip8VhP96aUCQrSozkaY2qwt0Q3ZwcaK2aKPm59zcUQ
mnptyTsT9+COfAz1csss+Kp0KNz53sWle3MUv95IssOX4fein1lCddjIzVIx3Lnz
Yf7DcB1OQWJUtJrEuhtIUfteYl2a8EBee0X3K2rlu4WOC5ZHgohjzR3FE0XudhVA
2Di4NlMlSVxgPvR6a86syhnUs42CAM00y999vSAydkOtA/N0M3w=
=7IH2
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
