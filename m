Received: from eggs.gnu.org ([2001:4830:134:3::10]:41765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egt8J-0004Ob-MW
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egt8I-0003GX-N0
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:13:03 -0500
Date: Wed, 31 Jan 2018 14:12:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180131141247.GC23336@stefanha-x1.localdomain>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
	<b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
	<20180130163820.GC4503@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20180130163820.GC4503@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 05:38:20PM +0100, Kevin Wolf wrote:
> Am 30.01.2018 um 15:23 hat Eric Blake geschrieben:
> > On 01/30/2018 12:34 AM, Fam Zheng wrote:
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  qemu-img.texi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/qemu-img.texi b/qemu-img.texi
> > > index 60a0e080c6..ec7e2f5d1e 100644
> > > --- a/qemu-img.texi
> > > +++ b/qemu-img.texi
> > > @@ -86,6 +86,13 @@ exclusive with the @var{-O} parameters. It is curr=
ently required to also use
> > >  the @var{-n} parameter to skip image creation. This restriction may =
be relaxed
> > >  in a future release.
> > > =20
> > > +@item --force-share (-U)
> > > +If specified, @code{qemu-img} will open the image in shared mode, al=
lowing
> > > +concurrent writers. For example, this can be used to get the image i=
nformation
> >=20
> > Actually, we only permit one writer at a time.  Would it be better to
> > say "allowing a concurrent writer"?
>=20
> As far as qemu-img is concerned, multiple writers to the image are
> allowed. There may be further restrictions imposed by a writer so that a
> second writer isn't allowed, but with raw images and share-rw=3Don nothing
> prevents two qemu instances writing to the same image while qemu-img is
> accessing it read-only.

I agree with what you wrote and it's technically correct, but this is a
confusing place to mention concurrent writers.  They are a common source
of user error and that's why locking was introduced in the first place.

There should be a separate paragraph in docs/qemu-block-drivers.texi
explaining that share-rw=3Don can be used safely with format=3Draw if the
guests are configured to safely access a shared disk.  It should also
mention that share-rw=3Don is unsafe for image formats.

Stefan

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacc7fAAoJEJykq7OBq3PIT5AH/0w4DK0g6OQtF2V7InP7BBn1
PQaG8FtRyu93BMZ5N2r1qy8CL3GRwSyyPUU9L33g0p/Cgsp9QkaAVgaW2NFod8U/
nhTess6SzJMUVtNx3vZZRA3tzjGlHjBLxxFNZNguP/FaUtPaFnBE323jcVKiGdqu
+YAINkM+nmIcEoxao+YWAbHcXav/yoMLCamNHSmtZrVNPCE69IBc3T+X0GYdoztj
bcPixFnVodGLFnpAaGG4Bzzgrzke/yaC0FFYV3d7iWSKyXlaLRK8fo+DBsgiDSiu
aqYXwlzNUUwwGc6eBMMe/QiRjx7tHXpQ8035p+1qwzsWng/OyrZCWPxjRs0N8y0=
=1cYR
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
