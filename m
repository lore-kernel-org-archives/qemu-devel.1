Received: from eggs.gnu.org ([2001:4830:134:3::10]:33867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djy3h-0008J5-1l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 21:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djy3e-00055b-GN
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 21:32:43 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1djy3e-000534-3W
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 21:32:42 -0400
Date: Tue, 22 Aug 2017 11:09:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822010917.GO12356@umbus.fritz.box>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aTCJOP0qgkSGqHWA"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--aTCJOP0qgkSGqHWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 12:18:07PM +0100, Peter Maydell wrote:
> On 16 August 2017 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 16/08/2017 10:26, Cornelia Huck wrote:
> >> Prefer to use the tcg accelarator if it is available: This is our only
> >> real smoke test for tcg, and fast enough to use it for that.
> >
> > I'm not sure this is required for 2.10.  Yes, it means the coverage from
> > "make check" is worse, but that's it.
>=20
> Yes, I'd put it under "if we need to roll an rc4 anyway for
> some more significant bug we might as well put this in too,
> but it doesn't merit cutting rc4 by itself."

It does entirely break "make check" on a ppc host.  And that in turn
has held up my testing cycle for a couple of ppc regressions from 2.9
that I was hoping to squeeze in.  Does that change your calculations?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aTCJOP0qgkSGqHWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmbhDoACgkQbDjKyiDZ
s5IwvxAAzTM65I5W48yNBlJB/RjMQpdaII4xXt/27qtQ482WWTYYE7m4uOamFS6/
6GH7AO6EvSyZGw1i9Q3YpbgMCtGcNLAMoMQk15o3WZ17Nnjxp2Gxi6ebA0u/f/pt
jC4W8rmhYBtkDXx5QL5JV99WO4L4b9sFUwbBFZDQFU3Kr9g+yFlUGUJPqaGNC4Fs
+9BZn0VGhVC8KShpWhOPlyJgU2KysrDLahVxn1F6pKPf2JQMp9JtSdQDJZNDwCuL
LoZ7xGdO2I7RmJ0vB/gWkGgeB+rjlH3lFy9K9l6D8/hra0e0FGQ5frOICX7jcgK4
BuoGtwqraB3agf68OBTan5Zg7i0vZ6AUG4MR05LyCkVTlQ6k93S/928bZcuhc4Og
1UPY/SVkJkmtggQCAweU8VrTWOUANLHCjX+O8WULkm5aewyw9RPdAr1Ajep8w4Ri
B/U4HZi0m/lEh3LebGavXpWsh8pFAq8hjvuL1xAdVglP971I7eLqgvG08EVs+wvs
ihRBPer/DCjTPaa3bemXbKXb+hXqa72pj+b3hk+mFF6EiPbSL4pOGdiZw9jQD2y6
vP9bPomoF1stGm0lQ/Gow0ZZJjgcy8D+wgX1aF0u0PwjgZmyxVGXQ4PCRp43RuOO
/TQFvlKAMMHJYqPpyZ5cDCRIRG17BSLumCcx5sAB9552FP8WsCQ=
=k+cd
-----END PGP SIGNATURE-----

--aTCJOP0qgkSGqHWA--
