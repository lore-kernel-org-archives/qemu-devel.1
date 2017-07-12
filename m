Received: from eggs.gnu.org ([2001:4830:134:3::10]:56942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVF0e-0004sc-Nv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVF0d-0000hz-VT
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:36:44 -0400
Date: Wed, 12 Jul 2017 11:36:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712103632.GG6923@stefanha-x1.localdomain>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <20170711163748.17817-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v4 4/4] block: add default implementations
 for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 07:37:48PM +0300, Manos Pitsidianakis wrote:
> bdrv_co_get_block_status_from_file() and
> bdrv_co_get_block_status_from_backing() set *file to bs->file and
> bs->backing respectively, so that bdrv_co_get_block_status() can recurse
> to them. Future block drivers won't have to duplicate code to implement
> this.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/blkdebug.c          | 12 +-----------
>  block/commit.c            | 12 +-----------
>  block/io.c                | 26 ++++++++++++++++++++++++++
>  block/mirror.c            | 12 +-----------
>  include/block/block_int.h | 18 ++++++++++++++++++
>  5 files changed, 47 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZfuwAAoJEJykq7OBq3PIn/IH/i7Sh3fFbxkQCclDRu65RkXj
/kwKefxxRSG+XWbmPB6HA3kXMHlchmZ/8f/IYMxH14l9e8mBpfKXpwIipmFTp+1j
e30SDekgfFclk6J/b2aTZtxk7tBPkJ6OUVgJI1o2JhVnnS+J577uVOHY1bvRO82+
k0csfmfe80norVZWV0xUVEwIsr0PvwmSLKdgIZYBDLqH3NhsttYbrSMc+UuIDEtL
IM5m6loXg0oxDCTzlxlPNRWs3J2ZcsMgRt7folUcBah+Yde4mVt4/snI0C4ISMyo
/5I/Gs/eZ9+0w7hTtAiQ5MPVnrsvK2MSa5HjLmcO8D763r0QPxlS8pSMsgkxZJg=
=i8VP
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
