Received: from eggs.gnu.org ([2001:4830:134:3::10]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eLno4-00011X-LQ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eLnny-00086a-Kx
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:17:00 -0500
Date: Mon, 4 Dec 2017 10:16:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171204101636.GA11502@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
	<f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
	<48c19394-6a8d-e2c1-3380-7f27c2f63909@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <48c19394-6a8d-e2c1-3380-7f27c2f63909@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 01:27:37PM -0600, Eric Blake wrote:
> On 12/01/2017 11:03 AM, Paolo Bonzini wrote:
> > Just my 2 cents on the language topic, as in general I agree completely
> > with Stefan.
> >=20
>=20
> > Luckily, several benefits don't require a full rewrite or language swit=
ch:
> >=20
> > - readability from RAII-style code.  If this is important enough, we
> > could actually use GCC __attribute__((cleanup)) or, heaven forbid,
> > slowly introduce C++ in QEMU's code base.
>=20
> This one is cool, and supported by both gcc and clang (and we really don't
> have any example of anyone clamoring for a different compiler). For examp=
le,
> here's what I recently added to nbdkit to make it MUCH easier to properly
> remember to unlock a mutex on all exit paths from a scope:
>=20
> https://github.com/libguestfs/nbdkit/commit/0f24d66648
> https://github.com/libguestfs/nbdkit/commit/b5ab4835e1

Yes, please!  __attribute__((cleanup)) is great and we should use it in
QEMU.

I haven't looked at compiler support though... :)

Stefan

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJSCEAAoJEJykq7OBq3PI7pwH/jSirP6kW9OI7g/021jiPSUI
ygQzjhk4ZAIbwIS0o50CW1203jtSIbQCCt109J4ShIwuEsO0bib4XrITAoXBt9Cd
c3ZKFhHbAv2vB3VnlbAntN8cM52l7RXotvz63Hu4ACLpjpnFOtMF5c5texPDQe8f
jL4FE0EgG3YP2yi6rljzRSq0uvCPONGhEKTg+EYRVoY2Mdy30+lHX9kA3UNT4quN
u/ToquW1ORjjajkxKquh5fBtxQB9Qj7y7o/8UGdlkHypnn7ddBnMn24EF5l0WdAM
TLo/xhtOyrCpjIuIdjEcyHFB/C9Q82sUh0nCxjbqjam8CAYVVRLIB7ZlDT/kKo4=
=9LZH
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
