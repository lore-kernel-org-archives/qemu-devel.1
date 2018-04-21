Received: from eggs.gnu.org ([2001:4830:134:3::10]:42325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9owM-0006Qr-KS
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9owL-0002dZ-Ag
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:36:18 -0400
Date: Sat, 21 Apr 2018 19:20:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180421092017.GW2434@umbus.fritz.box>
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
	<20180419183037.21826f8a@bahia.lan>
	<20180420021803.GC2434@umbus.fritz.box>
	<53e6af87-5f29-95d9-a921-bdad5a8e1ed2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MrbiU6dcJfOZ616B"
Content-Disposition: inline
In-Reply-To: <53e6af87-5f29-95d9-a921-bdad5a8e1ed2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13] Clear mem_path if we fall back to
 anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, imammedo@redhat.com, ehabkost@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--MrbiU6dcJfOZ616B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 05:34:38PM +0200, Paolo Bonzini wrote:
> On 20/04/2018 04:18, David Gibson wrote:
> > Paolo et al, as with my earlier patches adding some extensions to the
> > helpers for determining backing page sizes, if there are no objections
> > can I get an ack to merge this via my ppc tree?
>=20
> Yes, go ahead!

Thanks, applied to ppc-for-2.13.

>=20
> Thanks,
>=20
> Paolo
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MrbiU6dcJfOZ616B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrbAk8ACgkQbDjKyiDZ
s5ILMA/6AvwvQxie+WFoqec5Y6h0sFPKnBzGDAHVKvLsraJUXibjfYBOIYeZ9XIY
oMsWi0CmnllX5e+uNoNUmcPoGVHClHJjEKu76QbEfWCb6RIgf5Oq4n1S7X9ITFBO
E4FD46lqNdcV1rERgzJEFjlcN/osGBDPRg1iIz1qIv0mSeGdK8M7K6JQz1vJT4FR
FzuFzW73djRIVvlaUdaMiVIqCfwu/qNvc9zMogaBf5TA5sOGvXncXgmy6kPq0JbX
JE/JcA2V3I6a3fcfER51rgkRxd+H4ljvHjNlv2pUwAtA6+iD8sBZLT/P6jvscgw3
ib49+PC9oL5FB2QR3UofbLgrnD2Pj3ViO9zxbQDp1TOLLngAwGnj2trNUDQOO/sq
9mrnSYPVEJHSP+pVZApzF3RBkk+uDYYpUCGlTOZ6/CJfw2YQFxkU62r/WrOq/K/F
pJQVlNGKLumwu3pI7mipbdHghOJ0/ZIVvOfdngEeDSPjeLPcYXsiHyUaw4Paw1eK
KT2qDgyoO6yvceKFMFkTd0k5+AdT2mCnLn/z/hK/XkO5TJDQBYeEMOUvDd91qoCn
EmUmc8wjIWdV/LoPtFbKFjswJv7xm5/lUSkGJs4z95VpKs14FnfyzDQxfG/Kjjfk
BOrHQHurDnmoLc0Drm+jM9sCS+yf4kscdseJTYvTjiKARnrLoK4=
=OHi1
-----END PGP SIGNATURE-----

--MrbiU6dcJfOZ616B--
