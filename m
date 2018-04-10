Received: from eggs.gnu.org ([2001:4830:134:3::10]:47911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5uNS-0006b7-72
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5uNO-0007Ia-BE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:36:06 -0400
Date: Tue, 10 Apr 2018 16:35:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180410143551.GF7026@localhost.localdomain>
References: <20180404150146.23281-1-stefanha@redhat.com>
	<5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
	<20180410081158.GA20090@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20180410081158.GA20090@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, QingFeng Hao <haoqf@linux.vnet.ibm.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.04.2018 um 10:11 hat Stefan Hajnoczi geschrieben:
> On Wed, Apr 04, 2018 at 06:16:12PM +0200, Max Reitz wrote:
> > On 2018-04-04 17:01, Stefan Hajnoczi wrote:
> >  =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
> >=20
> > This seems to be independent of whether there is actually data on
> > TEST_IMG (the commit source), so something doesn't seem quite right with
> > the block job throttling here...?
>=20
> I've been playing around with this test failure.  Let's leave it broken
> (!) in QEMU 2.12 because this test has uncovered a block job ratelimit
> issue that's not a regression.  The fix shouldn't be rushed.

Makes sense.

Thanks, applied to the block branch.

Kevin

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJazMvGAAoJEH8JsnLIjy/WvSsP/3M/hBYJLgMVP32URO3j4a0k
z1prcYVo915QlrLs8RC9q7fyyJ/tmLxdr22c3bQV6EK7nwM2svGhCSE+tOtJlnwe
tyJMQ6oeUvx/NTxMla4olUMsd/xEHSrC/cMmSPs3k/FseSwu/dC5GohHbbaKxwN/
DWvHpwzfm2/58v9ZKULiJYBcNI3iJwOG/zgIInIAIumpmg9esubo9mwFksdZCllN
nfEuotjPVZsxq5+w3CdWLpr4sWTlFA/7lw8aOk9ns96b1MSx0dae1GpaLma00fB1
/OJAUZtba3OQWKft1PD07jMCHHLFyZMKYuH9LUqAnMO0nrvmkzYFHmJVXI8++CRH
YCqlmWEfYkq03f4QS3ij/MQecg5vFW3Q/hY/llfGw6X4LLBLk5e9r0aXIdC4tLZB
ZsCG/8rqVcjoMEmV0gAhu5JQT2UVveJhugOAYtqQKcsRBn+eqJoYnfMOs/+OyrJz
sQ3Qd+Byf6PsQdA7UeTTjsl+lYnlrB2sjwl/UOSguURRCMizHh2nRZR+SBNQIiWw
vTptfWEWoMrPPlbYPE9fJnQsYdZDaDJfNgzQy3P0pQIDWKYxGsB8Xe+kDeHVG1vK
Wj5DFakSp8X1OjbfdBg6Ge3+P+7fi4rAHXPiPoE1cakVZiH0Pn2CM1gVgSFgpHYt
BsBM7O4aH5j7uXxCUrC9
=Cre6
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
