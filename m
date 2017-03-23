Received: from eggs.gnu.org ([2001:4830:134:3::10]:57047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr5Mx-0004EM-Ed
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr5Mt-00037m-IC
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:13:47 -0400
Date: Thu, 23 Mar 2017 16:13:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323161333.GH12560@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-5-mreitz@redhat.com>
	<20170320110023.GH17887@stefanha-x1.localdomain>
	<a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
	<20170322164413.GD16717@stefanha-x1.localdomain>
	<7e892dd3-2eab-3a2e-c5ca-43aa4b36b988@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <7e892dd3-2eab-3a2e-c5ca-43aa4b36b988@redhat.com>
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


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 05:53:00PM +0100, Max Reitz wrote:
> On 22.03.2017 17:44, Stefan Hajnoczi wrote:
> > On Mon, Mar 20, 2017 at 04:11:24PM +0100, Max Reitz wrote:
> >> On 20.03.2017 12:00, Stefan Hajnoczi wrote:
> >>> On Mon, Mar 13, 2017 at 10:40:36PM +0100, Max Reitz wrote:
> >>>> +static int raw_regular_truncate(int fd, BlockDriverState *bs, int64=
_t offset,
> >>>
> >>> The presence of both a file descriptor and a BlockDriverState (actual=
ly
> >>> it must be a BDRVRawState) arguments is unusual.  It seems bs is need=
ed
> >>> for bdrv_getlength().
> >>>
> >>> How about using fstat(fd, &st) and then dropping bs and create?
> >>
> >> Well, I could do that, but bdrv_getlength() is a bit simpler and I don=
't
> >> see much of an issue with specifying both an fd and a bs.
> >=20
> > Arguments that provide overlapping information make the function harder
> > to understand and use correctly (there are combinations of these
> > arguments that are invalid or don't make sense).  Saving a few lines of
> > code in the function implementation is a poor trade-off IMO.
>=20
> My brain likes to agree but for some reason my heart really prefers
> block layer functions (where I know what can go wrong) over POSIX
> functions (where I always have the feeling of maybe not having though of
> everything).
>=20
> I guess I'll have to silence my heart for a bit, then.

In matters of the heart I cannot give advice on this mailing list,
sorry.

Stefan

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0/QtAAoJEJykq7OBq3PIx0MH/30FnwDgyWfQBExfbfjacZcT
lJzkuK8Y5rD1XUKgT1AtMMO40W9G8xHQrksS3FoIOX1HkFnksUk9aYoNnnA3fGpR
VD+F9irUeIS+zw2VcOZiE7+9qen7pKQArKrjPxnmPdFMYlmUZHkiksfBlOlBoYru
RpeFdfNNErz7o5XVabGv7uLTwaVHReRVTZI3Jc2OAaMc4sHMewALV+VvWw41Zqi7
Bqn33unp2aabs6zai+wRX/1msJsamnx5/En6NQlLSdkiCzYasf3BADkz4p98Lhzf
B6T8ZxUGRdgZ+to3wdMs7DMdFEzjNcZZc8E0CstnmVLozTpiekvHbxoV5XgMI/8=
=+ZOL
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
