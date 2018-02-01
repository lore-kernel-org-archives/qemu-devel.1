Received: from eggs.gnu.org ([208.118.235.92]:49736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKv5-0006my-RR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKsc-0004PK-TI
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:51:49 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<8ad7c315825732f819cae7d1460e856a04d095a5.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <72febbd3-5526-77c2-6d89-d1df1d359f04@redhat.com>
Date: Thu, 1 Feb 2018 20:49:24 +0100
MIME-Version: 1.0
In-Reply-To: <8ad7c315825732f819cae7d1460e856a04d095a5.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wug11meMvkVkft4FDv1m08cSCFZjdb9Rh"
Subject: Re: [Qemu-devel] [PATCH v3 33/39] qcow2: Rename l2_table in
 count_contiguous_clusters()
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
--Wug11meMvkVkft4FDv1m08cSCFZjdb9Rh
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <72febbd3-5526-77c2-6d89-d1df1d359f04@redhat.com>
Subject: Re: [PATCH v3 33/39] qcow2: Rename l2_table in
 count_contiguous_clusters()
References: <cover.1516978645.git.berto@igalia.com>
 <8ad7c315825732f819cae7d1460e856a04d095a5.1516978645.git.berto@igalia.com>
In-Reply-To: <8ad7c315825732f819cae7d1460e856a04d095a5.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Wug11meMvkVkft4FDv1m08cSCFZjdb9Rh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzb0QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2YAH+gIWbmrc266EdI2Zt5Q2uljHUCkkv9CY
W5cqF8Q/ca01YdJ/cIkzCsWKE+kN5rjv7M0DTCBEzg5wOgRursHCAxPWiq9jRoSC
kHC4y9IZMx/1IPG+3Xnfnel2+1YdNEJftnQi8AgIbTqAIrzFraLKvJokYrUpftF+
N/xV3/Lv0R/HrEozsSHnbz4owi0RtHOyjrJfJ+epoAdKq/b/1nzNerZ/cPianG3A
ctMiQH75oCPHKPXWX5h2PzD5RLpMXLw1uaxsB65YFfhxj6oPUQ3145KCT5yr62jO
MFwxDSZs40H+rrgR2Hk516BzwdqI+iZBORRJT/lxINmgCKhRKvyl+E4=
=PaMT
-----END PGP SIGNATURE-----

--Wug11meMvkVkft4FDv1m08cSCFZjdb9Rh--
