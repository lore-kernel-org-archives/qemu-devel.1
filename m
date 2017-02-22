Received: from eggs.gnu.org ([2001:4830:134:3::10]:41548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWB9-0002m4-1O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWB8-00010K-Aj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:37:55 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-5-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ae3c809-4b70-bce3-e72a-da42eea905c7@redhat.com>
Date: Wed, 22 Feb 2017 13:37:44 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dPEHjrFph9uhICT161WITvLvVWCn7h3PK"
Subject: Re: [Qemu-devel] [PATCH 04/54] block: Pass BdrvChild to
 bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dPEHjrFph9uhICT161WITvLvVWCn7h3PK
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <3ae3c809-4b70-bce3-e72a-da42eea905c7@redhat.com>
Subject: Re: [PATCH 04/54] block: Pass BdrvChild to bdrv_truncate()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                | 3 ++-
>  block/blkdebug.c       | 2 +-
>  block/block-backend.c  | 2 +-
>  block/crypto.c         | 2 +-
>  block/parallels.c      | 8 ++++----
>  block/qcow.c           | 4 ++--
>  block/qcow2-refcount.c | 2 +-
>  block/qcow2.c          | 4 ++--
>  block/raw-format.c     | 2 +-
>  block/vhdx-log.c       | 2 +-
>  block/vhdx.c           | 2 +-
>  include/block/block.h  | 2 +-
>  12 files changed, 18 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--dPEHjrFph9uhICT161WITvLvVWCn7h3PK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlithhkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJfQH/00fjSKSfunYRu/nYhl0FrK2P2gNITvq
iz2hTk/b2j/POvgVg2H6flgZCLlShgCUx5K934NReYO0i9ItJKFjT0HIoabzReKI
5grsfH7zfc8rztfn90Mo2bOSTsyLJ5vWepWRPzAuw5viM0DxSg2pXI8KECxZPdom
H7u8XThD3xi9aI3nsrVfSV6TK3WO7O5+q755vdFvdgWQMzl97d3tl5750Ho7klYn
Km0vm8ZPeusBgkuwxg1QoTX6WHiy3F1WS4+a5UqVBg0Csz8Z81PQOfT4K+pNWGbj
GZ5GCAdwsU6GpED7cRD/fjGu8Tmt2PxwSrOi0BdM1joapsH0udm1TcY=
=Mpl/
-----END PGP SIGNATURE-----

--dPEHjrFph9uhICT161WITvLvVWCn7h3PK--
