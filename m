Received: from eggs.gnu.org ([2001:4830:134:3::10]:44345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLBg3-0003SW-2t
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLBfz-0002kS-4t
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dLBfy-0002kC-Rg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:01:51 -0400
References: <20170609101808.13506-1-el13635@mail.ntua.gr>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e4ce9ef-806f-81d9-fdbe-4741d8c158a7@redhat.com>
Date: Wed, 14 Jun 2017 19:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170609101808.13506-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8Ve0NdhtOc4iUkUgaHOGng0RUSPLiKbjl"
Subject: Re: [Qemu-devel] [PATCH v3] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Ve0NdhtOc4iUkUgaHOGng0RUSPLiKbjl
From: Max Reitz <mreitz@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <0e4ce9ef-806f-81d9-fdbe-4741d8c158a7@redhat.com>
Subject: Re: [PATCH v3] block: change variable names in BlockDriverState
References: <20170609101808.13506-1-el13635@mail.ntua.gr>
In-Reply-To: <20170609101808.13506-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-09 12:18, Manos Pitsidianakis wrote:
> Change the 'int count' parameter in *pwrite_zeros, *pdiscard related
> functions (and some others) to 'int bytes', as they both refer to bytes=
=2E
> This helps with code legibility.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/blkdebug.c               | 36 +++++++++++++++----------------
>  block/blkreplay.c              |  8 +++----
>  block/block-backend.c          | 22 +++++++++----------
>  block/file-posix.c             | 34 +++++++++++++++---------------
>  block/io.c                     | 48 +++++++++++++++++++++-------------=
--------
>  block/iscsi.c                  | 20 +++++++++---------
>  block/mirror.c                 |  8 +++----
>  block/nbd-client.c             |  8 +++----
>  block/nbd-client.h             |  4 ++--
>  block/qcow2.c                  | 28 ++++++++++++------------
>  block/qed.c                    |  8 +++----
>  block/raw-format.c             |  8 +++----
>  block/rbd.c                    |  4 ++--
>  block/sheepdog.c               |  6 +++---
>  include/block/block.h          |  8 +++----
>  include/block/block_int.h      |  6 +++---
>  include/sysemu/block-backend.h | 20 +++++++++---------
>  qemu-io-cmds.c                 | 46 ++++++++++++++++++++--------------=
------
>  18 files changed, 161 insertions(+), 161 deletions(-)

Thank you, I've applied the patch to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--8Ve0NdhtOc4iUkUgaHOGng0RUSPLiKbjl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQWv5EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQHjK
B/0S0t9yF8sgwtAv8BBEypWe3qkZ6B+RxoVwhlHW/+GwAW/jxEnlR5dU2Jco79mF
FDtlAg/KudiRnVqmHahFhFbeOC+3+CoSrIU9xHKQGqOEmEpodlJPNFWl/J/Jdnqm
p9etsrdUSgDxPuYMnLp8Tg/DxlIr6jijqSNq01mhrbBEHDSFaV4Zy+oLS1A3cRBm
ZQqy3ypGvI1VNe3+lJCpCMryopjrfabXtIEeZGIm7H8EtowuI6fhIQOQR65mXv9x
46uWwjodPitVnFBXD05eMRc7EtkGLM8cyogMju9HiGnJKrDsswUCClNmeNbrw53p
KS/IUq4QRJJ7y3SQH7SpwRuy
=OhVO
-----END PGP SIGNATURE-----

--8Ve0NdhtOc4iUkUgaHOGng0RUSPLiKbjl--
