Received: from eggs.gnu.org ([2001:4830:134:3::10]:55673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2Gyw-0000jR-WA
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2Gyv-0004e6-Vc
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:23:31 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e48b71c5-5729-1691-75b8-5cd625382661@redhat.com>
Date: Wed, 11 Oct 2017 15:23:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171009215533.12530-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gC6h6wLhBMil6tF41Ur9Bvdh8CBGPMEW7"
Subject: Re: [Qemu-devel] [PATCH 0/3] qcow2: Fix preallocated truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gC6h6wLhBMil6tF41Ur9Bvdh8CBGPMEW7
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e48b71c5-5729-1691-75b8-5cd625382661@redhat.com>
Subject: Re: [PATCH 0/3] qcow2: Fix preallocated truncation
References: <20171009215533.12530-1-mreitz@redhat.com>
In-Reply-To: <20171009215533.12530-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 23:55, Max Reitz wrote:
> There are (at least...) two bugs in preallocated truncation, which this=

> series fixes.
>=20
> Both would have been apparent if the the related iotest had used the
> default cluster size in addition to 512 byte clusters, but alas, it did=

> not.  This is remedied by patch 3 of this series.
>=20
>=20
> Max Reitz (3):
>   qcow2: Fix unaligned preallocated truncation
>   qcow2: Always execute preallocate() in a coroutine
>   iotests: Add cluster_size=3D64k to 125
>=20
>  block/qcow2.c              |  42 +++-
>  tests/qemu-iotests/125     |   7 +-
>  tests/qemu-iotests/125.out | 480 +++++++++++++++++++++++++++++++++++++=
+++-----
>  3 files changed, 472 insertions(+), 57 deletions(-)

Thanks for the reviews, changed the reporter name to Ping Li in patch 1,
dropped the superfluous "struct" from patch 2, and applied to my block
branch:

https://github.com/XanClic/qemu/commits/block

Max


--gC6h6wLhBMil6tF41Ur9Bvdh8CBGPMEW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneG0YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9An6EH/iHV3C1Et9g3iuQzgIRuEr/yjWdgKuk3
db1O2skVYG1oWHDxDoF5nJRMz6XPXHW6rtustB06trlYi/3rterfB53GNza8rVSl
rpRDpKjHnyU0A9NdYuZy/vnlHEfpMkPNohlA3wYlXBxIuhhfKp5SdYAKaSUSCenW
gzx7YyED8glY/V1GIXHZDduODhHP2QP8uUPjdVRHn6JsWUqbscdcuSyFBS9B3vYy
rbyAfZNJgo15Y/Rj1FsysYpmjfguMuDdH5aXyCDtydKjR6zm9J2I/gxiKtiWcaxO
igv83Zbbda40bzLsPr7p+oCxxNg9jPN5+ZfkKUcDnGDRuFkJ5tdez/s=
=ZXOc
-----END PGP SIGNATURE-----

--gC6h6wLhBMil6tF41Ur9Bvdh8CBGPMEW7--
