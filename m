Received: from eggs.gnu.org ([2001:4830:134:3::10]:46690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egYwc-0005b4-C4
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egYwY-0002dj-Ft
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:39:38 -0500
Date: Tue, 30 Jan 2018 17:38:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180130163820.GC4503@localhost.localdomain>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
	<b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.01.2018 um 15:23 hat Eric Blake geschrieben:
> On 01/30/2018 12:34 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qemu-img.texi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/qemu-img.texi b/qemu-img.texi
> > index 60a0e080c6..ec7e2f5d1e 100644
> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -86,6 +86,13 @@ exclusive with the @var{-O} parameters. It is curren=
tly required to also use
> >  the @var{-n} parameter to skip image creation. This restriction may be=
 relaxed
> >  in a future release.
> > =20
> > +@item --force-share (-U)
> > +If specified, @code{qemu-img} will open the image in shared mode, allo=
wing
> > +concurrent writers. For example, this can be used to get the image inf=
ormation
>=20
> Actually, we only permit one writer at a time.  Would it be better to
> say "allowing a concurrent writer"?

As far as qemu-img is concerned, multiple writers to the image are
allowed. There may be further restrictions imposed by a writer so that a
second writer isn't allowed, but with raw images and share-rw=3Don nothing
prevents two qemu instances writing to the same image while qemu-img is
accessing it read-only.

Kevin

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJacJ98AAoJEH8JsnLIjy/WSpEQAKt192s7zWpOr+CmRpWUaSQS
pHI+1+8rn7aTBvH94gf4AqPeF3hGZGdvWtYs26yqKCfzc0Ta5ZMKBvnjrGU4MZbR
uUWxHvzhe6vt56BZUclKskkltwm2lYcaP8ctIiULd2fVyin6fHXL9QzG4/PrY3YE
T2f+G2n6rTqbMYQaaiJ6j2WK4sbSeQDfi6mnkRnXFcwhx3qTKd66XVkgMUKsnow4
igw5YOG8D5aNUSuVEA4xjlZx1dLkpL+vssU055LJLFivcUZKNatIbK3DFq/aHCkz
pZq7XcjVxVFGnRwNWwwVudvtaP9G+moTDEn+BPQbMzrUt8ONd2I5puVrNhV10KTL
aedxRFUM8JiDDTLdAxdLAfs2QrA8x3HeTuk8GX4qH/lfSve4fWa841fXVByVoVrs
aLzMKdOJ01cRbokvzxwpk5Qve/SvqJdpSnEeiK08sCpdnCihQzDRmOXXp65ooRuS
uLIcjoqhMDBPpQDzA0JUc8yVfdru+RPybqW2DzAlKpAmV+x0AjFg0Arf6HHyOw5+
bWN891Vh9dYdz3T4aTjiNa8L7eBs261xUDjm/xrdpP+oBCYH6wVFVnP58sy+XQ1P
RtzWluN6p90CfhOFLLOPL6SZOTmaHM6YzXc4eK4n5i3Rrd2HoiKdNLO8yAs+6W0v
KHT2xKGizDfr2Pe1VzUa
=outo
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
