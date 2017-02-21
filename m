Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8S7-0004aH-0T
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8S2-0002m7-7b
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:17:51 -0500
Date: Tue, 21 Feb 2017 11:17:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170221111742.GD22731@stefanha-x1.localdomain>
References: <20170220153012.GK21255@stefanha-x1.localdomain>
	<20170220154554.GF4814@noname.redhat.com>
	<20170220162919.GA21263@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20170220162919.GA21263@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] blockdev-add I/O throttling parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 05:29:19PM +0100, Alberto Garcia wrote:
> On Mon, Feb 20, 2017 at 04:45:54PM +0100, Kevin Wolf wrote:
> > > I can imagine two solutions that do not need these parameters in
> > > blockdev-add:
> > >=20
> > > 1. I/O throttling is implemented by a BlockDriver.  Users are expected
> > >    to create the BDS themselves.  This is a little awkward since
> > >    query-block *does* include the throttling parameters in its output
> > >    and we must preserve this behavior for existing users.
> > >=20
> > > 2. block_set_io_throttle must be used after blockdev-add.  Suboptimal
> > >    because issuing two commands is not atomic (use transaction?).
> >=20
> > The existing I/O throttling code is working on BlockBackends, but
> > blockdev-add creates BlockDriverStates. So it can't possibly add
> > throttling parameters.
> >=20
> > The currently recommended solution block_set_io_throttle. The
> > other option to control BB level thorttling would be to add qdev
> > properties to the block devices.
> >=20
> > In the long term, I think going with 1. and moving throttling to the
> > block node level is the much nicer (and more flexible) option.
>=20
> Yeah I agree with Kevin.

Okay, thanks for clarifying.

Stefan

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrCHWAAoJEJykq7OBq3PIkQwH/A0MZXOrWClsDNfaf3rkrM0n
vPRRsmhrz9vcsavvFRNhD5+EVugUs/1JmQxAX29RR4HzufuPcsTBmfW0tEU5ox9b
YcAWZqUuqYl9JCx0bcqdgbA5Io1EY/fCvbyGDixNyTm5MTHjh5Hi/iEbI1ypa/Nt
4hE3m04iERf4yNvba5+Ey3Fe3vppqwGfaM9rpWhV80WjjxIvv9zzzvn0vHNjHPP5
dSJZNxog2o28DhQ8RVKqKoQ0h8FAc8RxLKhRX/vmzAh55SoD2vw53kwSibCL701s
MVGHYp2w2IXM4/0gMqZYca1X4SDUgZMjGAlgbN8Nje9k0mnAS3g5x1G5f/UcXo4=
=UQP0
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
