Received: from eggs.gnu.org ([2001:4830:134:3::10]:50556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG2Ki-000834-6N
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG2Ke-0006hb-90
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:07:08 -0400
Date: Tue, 8 May 2018 14:07:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508130701.GQ19710@stefanha-x1.localdomain>
References: <20180504155014.10311-1-stefanha@redhat.com>
	<20180504174619.GA3107@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline
In-Reply-To: <20180504174619.GA3107@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-iotests: post-QEMU
 2.12 fixes for 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 01:46:19PM -0400, Jeff Cody wrote:
> On Fri, May 04, 2018 at 04:50:12PM +0100, Stefan Hajnoczi wrote:
> > The 185 qemu-iotests test case was in a bad state for the QEMU 2.12 rel=
ease.
> > We fudged the expected test output to make it pass, except for
> > non-deterministic behavior.
> >=20
> > These patches get us back to pre-QEMU 2.12.  Notably the offsets report=
ed in
> > block job events now correspond to smaller buffer sizes because the job=
 doesn't
> > iterate during drain.
> >=20
> > It's worth mentioning that the test case is still non-deterministic.  F=
or more
> > on that, see the first patch.
> >=20
> > Stefan Hajnoczi (2):
> >   qemu-iotests: reduce chance of races in 185
> >   blockjob: do not cancel timer in resume
> >=20
> >  blockjob.c                 | 22 +++++++++++++++-------
> >  tests/qemu-iotests/185     | 12 ++++++++++++
> >  tests/qemu-iotests/185.out | 10 +++++-----
> >  3 files changed, 32 insertions(+), 12 deletions(-)
> >=20
> > --=20
> > 2.14.3
> >
>=20
> This series has a minor collision with my block branch in the output; wou=
ld
> you like me to just merge together the appropriate 185.out when applying?

I'll send a v2 based on your branch.

Stefan

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8aD1AAoJEJykq7OBq3PIwvMH/1OhNt9wumZeC1uIlmUHbm21
Ko3jSqsh2Xki37PMbb+z9yQQX00T5+jaK/Nk7M5dajDtCnf+8dpM5mVIz/PpWQxA
T7CtzuHU2PE2j5R15RvW4mWGjpU7Azfu+FAYPZouBl3Trms0TQQUutsXMrY4tVbP
NVj7JHUShY5ieWJIdolIa4It6SJHwtXi9bTaP0QDMHy22gZ8JvPRW8btZJIStb+2
2Tkz/jZNfiN9qHx57EmHz/td6XnBX3zp54vAVJ7lYfWyQ1u+zSV1MM2vtlQOk67+
kBlu6oGf1agCY/XyVB4kS5l54J2WHm2aTPungq4yJ5S3G5AJWlGpSr+19UvwlQc=
=EoR5
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--
