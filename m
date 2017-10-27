Received: from eggs.gnu.org ([2001:4830:134:3::10]:55257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e857i-0007mH-8U
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e857h-0000GA-AB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:56:34 -0400
Date: Fri, 27 Oct 2017 15:44:22 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171027134422.GB7115@umbus>
References: <20170630183736.13222-1-rth@twiddle.net>
	<1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
	<20171026211200.GA3181@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20171026211200.GA3181@umbus>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2017 at 11:12:00PM +0200, David Gibson wrote:
> On Thu, Oct 26, 2017 at 02:22:57PM +0200, Thomas Huth wrote:
> > On 30.06.2017 20:37, Richard Henderson wrote:
> > > Cc: qemu-ppc@nongnu.org
> > > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > > ---
> > >  target/ppc/translate.c | 23 ++++++++---------------
> > >  1 file changed, 8 insertions(+), 15 deletions(-)
> >=20
> > *ping*
> >=20
> > Richard, David, any chance that we can still get this in for 2.11? I
> > think this would be quite a nice performance improvement for PPC TCG...
>=20
> Uh.. sorry, I don't even remember this patch.

Managed to dig it out of my archives.  Looks like the problem was it
was just sent to the lists, not CCed to me.  I'm not generally able to
keep up with the lists, and I must have missed it on my periodic scans
through the list.  I've applied it now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnzOC4ACgkQbDjKyiDZ
s5JHgw/+PfxHeas5L8D6gQpcGBL6XY2F95kkoxE9jXD6muF+UjqpEOyjge33r9Te
/9+EvF/Iv9eCcwK7BcbPH+WACxtCcoJ+htAMkBVdd2HBGJ4bx7zfyAa2twSkBJgn
iafefCWuQs5rR/fBBZ2sdz7Z7pzuCyTGwkizssGpPnm5wF5nrSp5ppqPyiXKeza5
792X0QJGLyLwB3Lq2syQGMaFqMymkRCRkqrDb38R6NLZ4r7KmIYX90a/xxYIRUVO
t+QuHaq3wJcu2rBWmfFV8mph6rPKoInxLM5I9vhqG6FAk1T/pQXLyMfab8VUrWuw
qtRRAN8m3fZ2qnuwwlgmRjmtBqtIQjFYlgnOdSNre6nCSmG9/Lbh8DUl9cQcwQzI
SOrXmyBBRYnXWGpiYGVqOrpCKlYhGkK8s/LgMeq+qPO/N2YdmT/lQbpC5L/38F/9
cB0i4K/sNPWgx893VO8cZedN3jXqUXR4l+t41b+cifDcmssBi7MJHNv9WzhdO5kx
8u9TJdo343YnKdAHpRz1ly4d4AnMLs89kk0CYJhQOlXMqja1SyEsWQbdHi9EorPy
HyFb0cE/m0CqRjGhDw+YvStQzbcSG/jnk4Z9qsxe4tTT1tCmnZXIkna11OLTDx0K
OgTuLs1SkBxlxts1fIM8VUHnUT2mtrhtixEwqJwFiPqveNanWFs=
=U+21
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
