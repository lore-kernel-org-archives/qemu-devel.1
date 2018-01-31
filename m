Received: from eggs.gnu.org ([2001:4830:134:3::10]:49996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyCJ-0000sa-2x
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyCI-0003CB-9F
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:37:31 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<9373dc21083ea85c3fded0edd717ad4f61fb68dc.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <205d83ae-29f5-a434-377e-9fa9fd950fca@redhat.com>
Date: Wed, 31 Jan 2018 20:37:20 +0100
MIME-Version: 1.0
In-Reply-To: <9373dc21083ea85c3fded0edd717ad4f61fb68dc.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6GfuoaocnfzCtG6Vcmj4rQ8y6zOlghGeY"
Subject: Re: [Qemu-devel] [PATCH v3 09/39] qcow2: Remove BDS parameter from
 qcow2_cache_clean_unused()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6GfuoaocnfzCtG6Vcmj4rQ8y6zOlghGeY
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <205d83ae-29f5-a434-377e-9fa9fd950fca@redhat.com>
Subject: Re: [PATCH v3 09/39] qcow2: Remove BDS parameter from
 qcow2_cache_clean_unused()
References: <cover.1516978645.git.berto@igalia.com>
 <9373dc21083ea85c3fded0edd717ad4f61fb68dc.1516978645.git.berto@igalia.com>
In-Reply-To: <9373dc21083ea85c3fded0edd717ad4f61fb68dc.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_table_release(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c | 2 +-
>  block/qcow2.c       | 4 ++--
>  block/qcow2.h       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6GfuoaocnfzCtG6Vcmj4rQ8y6zOlghGeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGvASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AD08H/3WooWFASEeJTH9Y5es2oztHbFWGevJ5
vwGIk5kZnHtXu47h9XeIdsjwwjpoxwJOsmm9VxwKSyd5y7Yl3pimYu1dFGsRs1/q
QjPV6qjWhXOdSa9PNfd8C+bWpdH1n5iptzHwuWDDuoXx35/KzUa45R+JSmcQSN6o
6wPY6ahn6CXwhbqFI24obrh8nm61z+X84KWu0KxVo5qHZkencpl702KxdB0o92uX
tPRbrv3tVpGPWc4y2Kt5+bGqQ1CGwJ8eAnb55uvOFOx+aYgeOf6NUGitDkA6G9QR
se6nn+dTifQPmWwENQoHKSY6zOoU7e5bAS8pLIHiLElWudHzhylc2oc=
=8Bct
-----END PGP SIGNATURE-----

--6GfuoaocnfzCtG6Vcmj4rQ8y6zOlghGeY--
