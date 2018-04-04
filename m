Received: from eggs.gnu.org ([2001:4830:134:3::10]:34615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jva-0008NT-NE
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jvZ-0008Ot-Vt
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:02:22 -0400
Date: Wed, 4 Apr 2018 16:02:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404150218.GX4467@stefanha-x1.localdomain>
References: <20180403140314.8795-1-stefanha@redhat.com>
	<20180403141336.GE11070@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Er97KPJOrxRt+yKZ"
Content-Disposition: inline
In-Reply-To: <20180403141336.GE11070@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: update 185
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--Er97KPJOrxRt+yKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 04:13:36PM +0200, Kevin Wolf wrote:
> Am 03.04.2018 um 16:03 hat Stefan Hajnoczi geschrieben:
> > Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> > vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the
> > drain operation the block job iterates one more time than before.  The
> > 185 output no longer matches and the test is failing now.
> >=20
> > It may be possible to avoid the superfluous block job iteration, but
> > that type of patch is not suitable late in the QEMU 2.12 release cycle.
> >=20
> > This patch simply updates the 185 output file.  The new behavior is
> > correct, just not optimal, so make the test pass again.
> >=20
> > Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shut=
down()")
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Do you want to update the comment in the 185 test case code that
> explains which values we expect?

Thanks, I have sent v2.

Stefan

--Er97KPJOrxRt+yKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxOj6AAoJEJykq7OBq3PIbXYH/iVbk1t+MLPxskiFZtxI9h3f
bpv4byMFMEQJPgkAvdwuRIIjdnHsRmOR32x4yOgv+Wl1ukWEuCzCJjXuczGDQNxp
/fcWrMhpAvOn0M6ZFr0jBDza9QB5TpwqY2aE6XSj0bsYXKpq5Nwl3Ecn5WWIP7CZ
f684E0kj/MDNh4Ur1/0pTyUbFnAikVE4xqA3OuPt9qZl6a36HcOyyFW2jX9KbtQa
xvWkBwJpzff9rNHMkd3Dw+A1MObZOK+oQ4/TJfTOmxeOiTDVl+uu/gEy+GDGibSn
tyuIoJNECQKgJJcqlVsXO1dt/WVsG7gcPYTen3X6nY2Ryn491fsIgFoFN0Z/GgQ=
=sToc
-----END PGP SIGNATURE-----

--Er97KPJOrxRt+yKZ--
