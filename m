Received: from eggs.gnu.org ([2001:4830:134:3::10]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG06I-000091-JN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG06D-0000ho-O5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:39:34 -0400
Date: Wed, 31 May 2017 10:39:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531093921.GA15666@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-7-famz@redhat.com>
	<20170511194100.GI24584@stefanha-x1.localdomain>
	<20170524021844.GG12279@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20170524021844.GG12279@lemon.lan>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 06/16] backup: Request
 BLK_PERM_AIO_CONTEXT_CHANGE on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 10:18:44AM +0800, Fam Zheng wrote:
> On Thu, 05/11 15:41, Stefan Hajnoczi wrote:
> > On Wed, Apr 19, 2017 at 05:43:46PM +0800, Fam Zheng wrote:
> > > What's done in the source's context change notifier is moving the
> > > target's context to follow the new one, so we request this permission
> > > here.
> >=20
> > It's true that the backup block job must be able to set target's
> > AioContext, but does this change also allow other users to set target's
> > AioContext while the backup job is running?  If yes, then we need to
> > handle that.
>=20
> If through job->target, yes, but I don't think there is any user of job->=
target.
> Otherwise, it's not allowed, because the second parameter of blk_new does=
n't
> have BLK_PERM_AIO_CONTEXT_CHANGE.
>=20
> So it's okay.

What about blockdev-backup?  It allows the user to specify 'target'.
Therefore the user can also run other monitor commands on target.  Some
of them could change the AioContext and the backup job wouldn't know!

Stefan

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLo9JAAoJEJykq7OBq3PI0woH/Al1hJplvjUtrKC86fhoyyUu
6tuxtVCydPUOeZ/4JmbLG2HFsUz95G3nPBiwOZhH9LAletzH6qZ2HbnONb3id5a9
bhjnwmErQL48zqcAum7iKDcqfYf5QgLDz+p7XjGeGeriJ2ODN1DH4tHNOXsVTJKX
FmBzuKUYAYb3qEKVTFFepW4xtPrVI0sfRio+QV0QvFvI5B1Y99COMDfJ2ErpVmby
dxuUL+tefnGPQtn2iI7B2FUifBHn8nqnFNBW+HDphFMMZxEnKCaVFkGnqPXnh6kP
KIZb1Mf/jVGPBqRmq0FAfIEIjau4QIYkmsseX3XYyD+oaxpKtfO5avtW2pm/eGk=
=mQV1
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
