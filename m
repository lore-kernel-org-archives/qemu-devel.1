Received: from eggs.gnu.org ([2001:4830:134:3::10]:53098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPpO-0007g6-Vv
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPpL-0000sG-SX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:05:10 -0400
Date: Fri, 7 Apr 2017 10:04:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407090450.GE13602@stefanha-x1.localdomain>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20170405194741.18956-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/13] block: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Weil <sw@weilnetz.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:47:35PM -0500, Eric Blake wrote:
> We now have macros in place to make it less verbose to add a scalar
> to QDict and QList, so use them.
>=20
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir block --in-place
> then touched up manually to fix a couple of '?:' back to original spacing.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/blkdebug.c   |  6 +++---
>  block/blkverify.c  |  6 +++---
>  block/curl.c       |  2 +-
>  block/file-posix.c |  8 ++++----
>  block/file-win32.c |  4 ++--
>  block/iscsi.c      |  2 +-
>  block/nbd.c        | 41 ++++++++++++++++++++---------------------
>  block/nfs.c        | 43 +++++++++++++++++--------------------------
>  block/null.c       |  2 +-
>  block/qcow2.c      |  4 ++--
>  block/quorum.c     |  8 ++++----
>  block/rbd.c        | 16 ++++++++--------
>  block/ssh.c        | 16 +++++++---------
>  block/vvfat.c      | 10 +++++-----
>  14 files changed, 78 insertions(+), 90 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51YyAAoJEJykq7OBq3PIr4sH/R3Upzx7aMCePMEKgEzuUY+8
u8laVb59pbLn7ca1w5C79HTpaWx5daHxH5jN56q4KdQwM31dwk0ube49cs6BDozi
X/nreeICymdHxOxg6Ezz9mKZ1CEYkBKgdS6zx1sTsRA1Sbx8fxgrRefF4civa5Fw
FMpyKIp9n2LsVYP4L+2M7oRlRCksEx5eTrjZbzroR4qMytjCzwjb2n36BQMcDozC
/RYvT1srl78n1UAnZ2pqVbQ16F9FOoyuCJcrLwV5hWaZ22qKj4I4CxuxXryEOvuK
DTBjHMrJLFMdh25RC/o/kJpOtA+QRLoF5e6Vr/J8pj95zHy8f7XfBO/SGS+kX84=
=duWo
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
