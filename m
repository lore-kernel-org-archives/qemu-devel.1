Received: from eggs.gnu.org ([2001:4830:134:3::10]:58053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqjMz-0004sP-RJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqjMz-0004Ov-11
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:44:21 -0400
Date: Wed, 22 Mar 2017 16:44:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170322164413.GD16717@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-5-mreitz@redhat.com>
	<20170320110023.GH17887@stefanha-x1.localdomain>
	<a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix:
 Generalize raw_regular_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 04:11:24PM +0100, Max Reitz wrote:
> On 20.03.2017 12:00, Stefan Hajnoczi wrote:
> > On Mon, Mar 13, 2017 at 10:40:36PM +0100, Max Reitz wrote:
> >> +static int raw_regular_truncate(int fd, BlockDriverState *bs, int64_t=
 offset,
> >=20
> > The presence of both a file descriptor and a BlockDriverState (actually
> > it must be a BDRVRawState) arguments is unusual.  It seems bs is needed
> > for bdrv_getlength().
> >=20
> > How about using fstat(fd, &st) and then dropping bs and create?
>=20
> Well, I could do that, but bdrv_getlength() is a bit simpler and I don't
> see much of an issue with specifying both an fd and a bs.

Arguments that provide overlapping information make the function harder
to understand and use correctly (there are combinations of these
arguments that are invalid or don't make sense).  Saving a few lines of
code in the function implementation is a poor trade-off IMO.

Stefan

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0qndAAoJEJykq7OBq3PInccIAI0a7z7Sg5ttr6216ghry100
np44Kv0crgRqIRNcIEIvCAWBuj+xUL6AmjUGAmEeoB1EVu3i9MC1tMms95MnW/Ci
zvhIpfcPeoIjR4pcEpKAGvNeih78ZeJdRiFpJMGmShTrDNxghcvttXYY15fIs0N/
PQEqqTvZbhUFZheyKK9z0aI9/r1AVKfSkiji3I+fHtCsy7BHBvNnuCpRQDq8GxqX
YoxjWJ48ev86Wl61NTwNCLOJEC7JmjXEV/iQ+xDGvDxoRngvoftsRX7BrwlpT+29
k/+yvfcS83z1M6OdXFoyFyozbEnsPqk3P64cI3Y2NkF1XB7bDSOelHrAmhU7uT8=
=BlkM
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
