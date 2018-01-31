Received: from eggs.gnu.org ([2001:4830:134:3::10]:44858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egtIg-0008FO-6g
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egtIa-0003XY-Cd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:23:46 -0500
Date: Wed, 31 Jan 2018 15:22:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180131142249.GB3598@localhost.localdomain>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
	<b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
	<20180130163820.GC4503@localhost.localdomain>
	<20180131141247.GC23336@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20180131141247.GC23336@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.01.2018 um 15:12 hat Stefan Hajnoczi geschrieben:
> On Tue, Jan 30, 2018 at 05:38:20PM +0100, Kevin Wolf wrote:
> > Am 30.01.2018 um 15:23 hat Eric Blake geschrieben:
> > > On 01/30/2018 12:34 AM, Fam Zheng wrote:
> > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > ---
> > > >  qemu-img.texi | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/qemu-img.texi b/qemu-img.texi
> > > > index 60a0e080c6..ec7e2f5d1e 100644
> > > > --- a/qemu-img.texi
> > > > +++ b/qemu-img.texi
> > > > @@ -86,6 +86,13 @@ exclusive with the @var{-O} parameters. It is cu=
rrently required to also use
> > > >  the @var{-n} parameter to skip image creation. This restriction ma=
y be relaxed
> > > >  in a future release.
> > > > =20
> > > > +@item --force-share (-U)
> > > > +If specified, @code{qemu-img} will open the image in shared mode, =
allowing
> > > > +concurrent writers. For example, this can be used to get the image=
 information
> > >=20
> > > Actually, we only permit one writer at a time.  Would it be better to
> > > say "allowing a concurrent writer"?
> >=20
> > As far as qemu-img is concerned, multiple writers to the image are
> > allowed. There may be further restrictions imposed by a writer so that a
> > second writer isn't allowed, but with raw images and share-rw=3Don noth=
ing
> > prevents two qemu instances writing to the same image while qemu-img is
> > accessing it read-only.
>=20
> I agree with what you wrote and it's technically correct, but this is a
> confusing place to mention concurrent writers.  They are a common source
> of user error and that's why locking was introduced in the first place.

So you understand "concurrent writers" as at least two writers? Because
I wouldn't understood it as a writer that is concurrent to the
(read-only) qemu-img.

Maybe rephrase it as "...allowing other processes to write to the
image" then?

> There should be a separate paragraph in docs/qemu-block-drivers.texi
> explaining that share-rw=3Don can be used safely with format=3Draw if the
> guests are configured to safely access a shared disk.  It should also
> mention that share-rw=3Don is unsafe for image formats.

share-rw=3Don is a -device option and only about the guest, not about the
backend. It is never unsafe if the guest can cope with external writers.
It just doesn't prevent qemu from locking the image file for image
formats.

Kevin

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJacdE4AAoJEH8JsnLIjy/Wu94QAKJK7FT1VjXQo/7YtTuIJNRe
bV34G2eVYZzaQVNg7yNFihI4rJtz8Z37uxLgGV1DXu8TBhBP688jhLfF+Ut8++dK
1cP+ALWvMlKcFROyfDi9qF20bYte/aPYVXz0EsFB1ZE2mMsseuSeEWj7OlxkYnGF
pts8GCKuKb1Wa/vLDKe4gNYvkt/ejusdsVJJBbTtudLTRmTMbQiW6zmFuvo0QUtG
7U44nht48UMcDDFbEmOSVJYMaah/PGwQQDNaY770Yp8GbNWyYtOfdr1xrI9r1dPm
p3gX21ahA+Hx22rmIUqBxqRv4+JLmW/4+4gpab7sJ+d7RJbvW6Jqq6FT3H6dHFwj
+3YT0n6N4Exvu5l1RUSB8UFAk2wsS2sv6Rjzlm8fiUTjRUXmqnyDJPqM56zpOHO3
pMokL0geCDf3/sNKvDRGzTRVV/kxxLD5xyCCRXVufiHkO7Lt59My9dKTHZYz5pij
JHewQ60CjXBNaQ1jlw2lY+zAwhRGGnyAAjcDps3eMlsL2VZKaE5G9jkXtUbSIk9h
Ad5RH22ophHIzeEaZUmys2k3r3F+hZJ64zQ09tmU77w0o9/EBusMR0ZkGhnoCMy0
Zok5mSfK4gw7Ng92SSZzw89jUzjlYXcJqVx1/MuulRxMpPcbR+tDhhtro+zJZYez
fbhdlBDyrh9e1Rvag+VG
=MgDz
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
