Received: from eggs.gnu.org ([2001:4830:134:3::10]:55256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e857i-0007mG-8W
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e857h-0000G6-9t
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:56:34 -0400
Date: Fri, 27 Oct 2017 15:55:27 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171027135527.GC7115@umbus>
References: <20170630183736.13222-1-rth@twiddle.net>
	<1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
	<20171026211200.GA3181@umbus> <20171027134422.GB7115@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20171027134422.GB7115@umbus>
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


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2017 at 03:44:22PM +0200, David Gibson wrote:
> On Thu, Oct 26, 2017 at 11:12:00PM +0200, David Gibson wrote:
> > On Thu, Oct 26, 2017 at 02:22:57PM +0200, Thomas Huth wrote:
> > > On 30.06.2017 20:37, Richard Henderson wrote:
> > > > Cc: qemu-ppc@nongnu.org
> > > > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > > > ---
> > > >  target/ppc/translate.c | 23 ++++++++---------------
> > > >  1 file changed, 8 insertions(+), 15 deletions(-)
> > >=20
> > > *ping*
> > >=20
> > > Richard, David, any chance that we can still get this in for 2.11? I
> > > think this would be quite a nice performance improvement for PPC TCG.=
=2E.
> >=20
> > Uh.. sorry, I don't even remember this patch.
>=20
> Managed to dig it out of my archives.  Looks like the problem was it
> was just sent to the lists, not CCed to me.  I'm not generally able to
> keep up with the lists, and I must have missed it on my periodic scans
> through the list.  I've applied it now.

=2E. and now I've unapplied it, because it doesn't compile.  Richard,
can you resend a current version?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnzOs0ACgkQbDjKyiDZ
s5KciBAA1yI7bsaJPgMF0yOFTKVd6XeYxeKYA1sdi/DrJdgpK3mcaINqEv4HJzuk
ktw8OdQrf+60zntj0okKfPplhOQPWW4ykDfRg4C5lyrHxzvWauMmwylToAr3sBIt
mCIEfpkox1NDLKDe2nJM7Wn2wuVY0IgroYhpJJ+NQXQ1CPJ9pVnbG/HJrX2hxy5I
wDr7z4t2+M6x1hI+grifJL+nXt46GODK6qu7SMpd3qfWKli3h8w1DhrfeTmc76wm
T4xk2JeHIZdB6SN7214exCjCKJa0UCZJHcJq3zUMHJj2MqhpaexP1Kh86YKUQUf5
P0WlbvVXdSuRiT80w0tC7CMxZNHjjlWWarfLmuriYi7rYyUmNnUcb2mqKnJD0TeL
R5aYPiAxV6zp5vrvEgTzvAI75X97w38rlyo1dbQ8fQCIB6e7VYJVCJkAklJbyiiP
mRWnxuO57SVaDgxQy2c+MRkEITjylYFmiY+BkYysqQbt5nt+hWqfzuaBB2LAZPpc
g5Y3BDNRzL6uVCeoYhLel0EymyexrcaLJwHJOiD8HI9FC9saFNiu2ut8AQ1RTfG4
ESnc2IeMOgkfm4+8O74hou193YUDmuwF07NBpKZYH6xGgKLMcIhXKwaXnrnhmpBA
iCEiW4Of7ACFrfSWOSHBeD7ysFIUZRfhkgP1MjIDddXJuRyi2Eo=
=8WCA
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
