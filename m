Received: from eggs.gnu.org ([2001:4830:134:3::10]:42254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3Cr-0005wF-F0
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3Cq-0000UU-Fz
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:16:49 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5c316901-5632-ff05-7700-6427cd33bf74@redhat.com>
Date: Wed, 1 Feb 2017 23:16:38 +0100
MIME-Version: 1.0
In-Reply-To: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7taDwnn2fvC5elqenV1dLC2mMEdn4F3LQ"
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
--7taDwnn2fvC5elqenV1dLC2mMEdn4F3LQ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5c316901-5632-ff05-7700-6427cd33bf74@redhat.com>
Subject: Re: [PATCH 1/2] qemu-io: don't allow I/O operations larger than
 INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
In-Reply-To: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 17:09, Alberto Garcia wrote:
> Passing a request size larger than INT_MAX to any of the I/O commands
> results in an error. While 'read' and 'write' handle the error
> correctly, 'aio_read' and 'aio_write' hit an assertion:
>=20
> blk_aio_read_entry: Assertion `rwco->qiov->size =3D=3D acb->bytes' fail=
ed.
>=20
> The reason is that the QEMU I/O code cannot handle request sizes
> larger than INT_MAX, so this patch makes qemu-io check that all values
> are within range.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-io-cmds.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Thanks, applied to my block tree, with
%s/INT_MAX/BDRV_REQUEST_MAX_BYTES/g:

https://github.com/XanClic/qemu/commits/block

(Maybe you should take a quick glance on whether all of the changes are
really OK for you, the commit currently resides under
https://github.com/XanClic/qemu/commit/beaf099368f91eb44ebd49e863c57bc0ff=
80659f
)

Max


--7taDwnn2fvC5elqenV1dLC2mMEdn4F3LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSXkYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6doH/1JJfSGqThctFeQUO9wCxdDrigFJVRp4
hoFDygMbJfcsR8e9b22+gmmfh5FZ4TPLcwF/cVfguR+/2JEnNzM6w4BNvYWQoAY+
VDijDRPT3A7yXZ2dQj158Mr3OBJ0df9nZF/83h3qGqjsCelgwNNGnTa2ZQkkm9I3
EhJELREPCG0VsQg+WbAL4gQx/WELpqzHMsazhrnacMZ9UdTxgok/ht0LgYVCMyOm
LUk/OkaerARxzrRvuxuUKFdPRboeaqE+PvjNtdEFlGRAFNH9a6/QlsQUrWLogFPU
DYY4sha0yYIOQ3uteSm0CV1tMERKn3LvgBZDaN/nar2sBs+JJtfftzA=
=WnkB
-----END PGP SIGNATURE-----

--7taDwnn2fvC5elqenV1dLC2mMEdn4F3LQ--
