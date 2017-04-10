Received: from eggs.gnu.org ([2001:4830:134:3::10]:55006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbns-0008W9-CV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbnr-0005yV-Ie
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:04:32 -0400
Date: Mon, 10 Apr 2017 17:04:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170410160417.GH3214@stefanha-x1.localdomain>
References: <20170410022636.29925-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <20170410022636.29925-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 10:26:34AM +0800, Fam Zheng wrote:
> v3: Use bdrv_parent_drained_begin/end. [Kevin]
>     Do it before releasing new_context. [Stefan]
>=20
> Fam Zheng (2):
>   block: Make bdrv_parent_drained_begin/end public
>   block: Quiesce old aio context during bdrv_set_aio_context
>=20
>  block.c               |  7 +++++--
>  block/io.c            |  4 ++--
>  include/block/block.h | 16 ++++++++++++++++
>  3 files changed, 23 insertions(+), 4 deletions(-)

Thanks, applied to my block tree for 2.10:
https://github.com/stefanha/qemu/commits/block

If you'd like this in a stable release please CC qemu-stable.

Stefan

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY660BAAoJEJykq7OBq3PIkKMIAJPmuLNTxra8XoWK28cfpsgV
zAkmCASU1LWGK3X7bUvb8duLcJ3Hf74cgHW00AaFa8sBFvpzdiQAzILrrPNPWoGq
6A2ZiYcVDATT0/O9LVJiISvz2KqGu1aXjiMZFBbNCY8wQ6hjeYeUMme4TsQClkgR
7tRdWUbWrG/XLAAxi7FKWC8WrqYwk8smfShuShmSSnHs2+LGcBQY+q+VHVGhcHC9
KQ44fScl+aivRU31WWL7+MtqZlEKARDrL3h1jgOgejyEKli+hOLyIvQRnhY41GCw
6CpI+grs8yr4jMjFII6tTeRj9cjt+F4quk89jcPMxHCzhcjhpeS4Zymc489PiEs=
=SrZx
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
