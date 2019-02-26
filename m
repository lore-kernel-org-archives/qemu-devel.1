Received: from eggs.gnu.org ([209.51.188.92]:48851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTtq-0003t4-OW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTto-0007je-GP
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:22 -0500
Date: Tue, 26 Feb 2019 14:21:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226032103.GJ6872@umbus.fritz.box>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
In-Reply-To: <20190225232009.GB30778@kermit.br.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Araujo wrote:
> Hi, Maxiwell.
>=20
> On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrote:
> > This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> > guest to collect host information. It is disabled by default to
> > avoid unwanted information leakage. To enable it, use:
> > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
>=20
> The patch for setting host-serial and host-model already landed Gibson's
> ppc-for-4.0 branch:
>=20
>   commit 9e584f45868f6945c1282c938278038cba0e4af2
>   Author: Prasad J Pandit <pjp@fedoraproject.org>
>   Date:   Mon Feb 18 23:43:49 2019 +0530
>=20
>       ppc: add host-serial and host-model machine attributes (CVE-2019-89=
34)
>=20
>=20
> QEMU should only return host-serial and host-model from the host if the
> following combination of parameters are provided:
>=20
>   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-export=3Don
>=20
> If host-serial or host-model are set with a user-string, ibm,get-vpd shou=
ld
> honor these values and return them, not exposing host information by acci=
dent.
>=20
> I'm not even sure if we need vpd-export=3D<bool> setting. Its logic could=
 be
> derived from the presence of host-serial=3Dpassthrough and host-model=3Dp=
assthrough
> options.
>=20
> What do you think?

That's an excellent point - I hadn't thought through the fact that
this is the same information exposed by those properties.  I do indeed
think that exposing the same information set in those properties - and
thereby avoiding the new machine option - would be a better plan.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0sJwACgkQbDjKyiDZ
s5I5dA//WA9E1n/my8tO0KIgty699WqVnJtQX7LP42s2G2SENIvI55vT631bRCn7
D2bfbSoyq2N6yCqJyboTR7gJCy5F6Lu+tEAnVl3gEh5THEg7zaZ11BSuTZqO6H/A
sYDzgDki/6VWjdcRT0x3dmGOvb0HIuosN7ic1spZsCGd9lAq7ZpFokKAfRpg9C2y
Bn9IBcMvTzX8zGv+rGq3lvwjD5FieKmRYHiTMlTLmhkx2dEbrudYVoOam8M55ncQ
HdC3+ewysmNm6gepH/1FgPBgyZprjuP+zI0hcKaxn9Ro/Td1fSb6AYDCZyA3d94w
miag6ctoDKxNy1YuQL8mbNWgpZ9w6HaEY/cNI6ehNq8AifE4Q5AFe3zYMYQVfFqO
4XHgvtuZ1eWrHBobdeBWk8ghF/bkV7NAypnZ6nuy52Q57ryTJVeD6+EO4c0GvDHv
SR671HzBazVDE1IQZELS1OulZbbiaCxeEHEOssHXIsRjrFevm1l6SZXBYSjqgwHZ
M3BZfHVg7s4eAdt8u/Q5KhqepeCd7km1jncNjCzDF1CfDZzwKtGwB8sJzEmBFJnY
QRauBl4fOpaUXsrYpzNcyNB843VQHKCCNE9d1tjs8kJdHusu7qhh4vrjnubds1eI
Bvy8nqOdIbKMShwKLY09ywc3qIFmVUWmxl/3sn/jBsz+od4zvdQ=
=+nst
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
