Received: from eggs.gnu.org ([2001:4830:134:3::10]:57075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZj5v-0007hl-C2
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZj5u-0007gO-OJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:00:27 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<5c316901-5632-ff05-7700-6427cd33bf74@redhat.com>
	<w5137fxoty9.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <afe2bd4b-130e-4d0d-88fb-861d6cf6639a@redhat.com>
Date: Fri, 3 Feb 2017 20:00:15 +0100
MIME-Version: 1.0
In-Reply-To: <w5137fxoty9.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d6VjITn91PxJhkWACOjAQmWepl4bRoAf6"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6VjITn91PxJhkWACOjAQmWepl4bRoAf6
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <afe2bd4b-130e-4d0d-88fb-861d6cf6639a@redhat.com>
Subject: Re: [PATCH 1/2] qemu-io: don't allow I/O operations larger than
 INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
 <5c316901-5632-ff05-7700-6427cd33bf74@redhat.com>
 <w5137fxoty9.fsf@maestria.local.igalia.com>
In-Reply-To: <w5137fxoty9.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.02.2017 09:52, Alberto Garcia wrote:
> On Wed 01 Feb 2017 11:16:38 PM CET, Max Reitz <mreitz@redhat.com> wrote=
:
>=20
>> Thanks, applied to my block tree, with
>> %s/INT_MAX/BDRV_REQUEST_MAX_BYTES/g:
>=20
> I think you can use %d to print BDRV_REQUEST_MAX_BYTES, after all the
> definition guarantees that it won't be larger than MIN(SIZE_MAX,INT_MAX=
)

I'm not sure what C makes of that expression. I'd think it becomes a
size_t, probably, regardless of whether it would fit into an int.

Max


--d6VjITn91PxJhkWACOjAQmWepl4bRoAf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU0z8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AssEH/2hGFdsdd/pMkztt+4EUHIBSCZT0OovJ
1TWouJ/WCdWcI9I5eoTMNzmICl6+AGH4lUP4/6LJkbUf1s1yX4igEsjTz4OrkqIo
gw8jxNylIb1qnFia/YLnfAM1ZRPMat92htTedxh6I30dpqIdILmXPLuK9hkfQh0s
A2JIORaQICasuws4BXevsXE6m9psqyEeiFe1f+K20LBi2sSjKCEP0HQrIljYtlaz
35mvWXLg6jkRzCYZtBMmLsh3tSNFnRvVCOV1MALOsKKO8o4Xm72lOR+XAFQYBWPh
5bUBO2MaJCSOx57ZjBlmmdsyXVfN0xe/RBJGhE5OeZITgEw5gn6+wkQ=
=Yqj8
-----END PGP SIGNATURE-----

--d6VjITn91PxJhkWACOjAQmWepl4bRoAf6--
