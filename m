Received: from eggs.gnu.org ([2001:4830:134:3::10]:57763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK1Ox-0008FC-LW
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK1Ot-00073Y-Us
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:23:43 -0500
References: <20171129035502.GD8889@lemon>
	<20171129063006.GD18521@localhost.localdomain>
	<20171129121611.GC2601@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b46a3a6-db40-3e5c-7ef0-903433c94772@redhat.com>
Date: Wed, 29 Nov 2017 13:22:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171129121611.GC2601@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wD9SSe4DEIe3NgWHNe76Dwx9g3mEcvKpX"
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wD9SSe4DEIe3NgWHNe76Dwx9g3mEcvKpX
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com
Message-ID: <6b46a3a6-db40-3e5c-7ef0-903433c94772@redhat.com>
Subject: Re: Block layer complexity: what to do to keep it under control?
References: <20171129035502.GD8889@lemon>
 <20171129063006.GD18521@localhost.localdomain>
 <20171129121611.GC2601@stefanha-x1.localdomain>
In-Reply-To: <20171129121611.GC2601@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/11/2017 13:16, Stefan Hajnoczi wrote:
> While the atomics documentation is good, atomics themselves have been a=

> source of difficult bugs.
>=20
> They should be used as little as possible and only where they can be
> encapsulated in a composable abstraction (i.e. don't expect users of
> your abstraction to understand atomics).
>=20
> Why?  They are damn hard to use.  None of us is capable of using them
> without introducing difficult bugs.
>=20
> There is also a temptation to rely on implicit effects of other code
> (e.g. when you know there is a barrier in another function) for best
> performance.  That's a bad property for code to have because it becomes=

> hard to change safely.

I agree.  atomics.txt should be augmented with examples of well-known
idioms/patterns and a big red sign "if this is not what you're doing,
don't do it".

However, I'll note that in the end atomics are not very different from
very small critical sections.  If anything, atomics have the advantage
that you have to think more about acquire/release semantics.  So it's in
general a matter of "being as clever as you need, but not more than
that" (and IMO util/async.c and util/qemu-coroutine-lock.c do need all
the cleverness they can muster, but it should stop there).

Thanks,

Paolo


--wD9SSe4DEIe3NgWHNe76Dwx9g3mEcvKpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloeprYACgkQv/vSX3jH
roOxuQf/WR/+42oiQuIJjIO/PHcqJt5pJ3m0gk08g6p4VwZuVV6mWHcUS0t8eiDM
NP1/PdHgaRS3gY0vM873eNeC4Fki0ZVF+UF4ZviMxKiWU35TAyqYpSBAijbQoOIw
BaQAdyOL6vCNtR+KfOurh9IGALlUhhJLO82/ii/PYNSmM11x8KpdXriFQ7o4r4Kb
1iDOaywpOyLESYEFdGblqcl3UwIYjDN7FwSFHDp1H6cvPij3AS3z5SUiaT2KqVoJ
UvFOJtD5A/64OjUHPZQq2zCgRoTN3a0KzD344SWSyvfbkuBNJ5XRCQYTd3+KSldO
MoDOUNa5+NZBvlJP2d0eEPPnBjLQEg==
=ryKB
-----END PGP SIGNATURE-----

--wD9SSe4DEIe3NgWHNe76Dwx9g3mEcvKpX--
