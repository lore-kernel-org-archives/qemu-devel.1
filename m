Received: from eggs.gnu.org ([2001:4830:134:3::10]:51034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb5-0007Fc-6G
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb0-0004b6-Vz
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:39 -0400
Received: from ozlabs.org ([103.22.144.67]:51807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dkJb0-0004Xa-4p
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:34 -0400
Date: Wed, 23 Aug 2017 10:29:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823002907.GC5379@umbus.fritz.box>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20170822134815.77020eb8.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 01:48:15PM +0200, Cornelia Huck wrote:
> On Tue, 22 Aug 2017 21:20:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Obviously it's not a thing to fix right now, but I've really been
> > thinking that none of the tests should use this "TCG or KVM" stuff.
> > They should instead be run with *both* options - or at least the ones
> > that are available on the host.
>=20
> Having one test as a 'smoke test' that is run for everything available
> sounds like a good idea, and the boot-serial test may be a good
> candidate for that.
>=20
> I would not want to run every test with every accelerator, however, as
> this makes 'make check' even slower than it is now. (Although it may be
> useful to be able to trigger 'run everything' tests on some dedicated
> test machines.)

I'd be fine with only running the full matrix on a "make check-harder"
or whatever, target.  But I'd like the option to be there.  Sometimes
(like when preparing a pull request) a slower check is an acceptable
cost for better coverage.

> > That would have caught the bug in the pull request I sent you, and
> > would at least have given you a chance at seeing the problem with
> > boot-serial-test.
>=20
> I don't think that would have been caught unless you have the right
> host available... and given that most developers will only have a
> x86_64 machine and whatever other architecture they are working on (if
> any) available, they will run most of 'make check' with tcg only.

Sure, but running make check (amongst other things) on a ppc host is
part of my standard pre-pull-request tests, so it certainly would have
caught it in this case.  Peter Maydell has said he has a ppc host
amongst his test systems.  At the moment it doesn't do KVM so wouldn't
have caught the other problem, but it'd be one step closer to doing
so.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmczFMACgkQbDjKyiDZ
s5I9Rw//V+DgeD1YxExCWCYDxYDGeRMjx3cPofivziIuEEygO7viBVsxWSllIGvE
3ERkbze/YCQBxmoxmTksRkc70AnG8zSW9Q4/Pb+uImb+JF01LiF0OaUtnwH7Q9Fw
h3ef8mU6sTxM9XJd0qDQaRsxbcCw3hDs6nsWw/iNNRi9EHmKIeqCVfHy8W2Kn9Ip
bRZvJOxTIzamqr3JPv43mvqjb/E1H5jgCyj2S27ILVw6bFbB/cQQjFOecz0BZeQ3
sXcdNTfNGWocdXF4ndZ+l4Ae2oRAsRu3xMaGyryq4NttlZx54GuS+lR9q/M4EYce
0wOPvsmCjHzSr72WKU8sApwfjfm9ct5217GS5TuI7W9JTXxnIb9xztEaQ/5p/X+D
ie+6IIwskOTBte8E4W+F9gQxO0ltM0ZVRE0BU8AlW10z5WvXy664KCgLiw8WacC9
2wixYpVcy4Ti6JwsKOtJ5PgNg5cHFHnzJGWw6GnqGyD1OoRymzT5H70Zgro+phVW
HirAtYPDb+MdjOiFJ0lyWUZYDWrFjmoJFiX6d0w27qHjWaq1I+6zctr9QpexRHqy
nPvULZTxIgl4g/nPyiUuKQTu0TOZgkYV1oLvkE7mrYQjC0YU2WC2oJeh7IxfHHlV
P2QAwgew3wS022Ca4na1ZskykFihqBFjsFowGpY62i3LpxBlXKA=
=UIof
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
