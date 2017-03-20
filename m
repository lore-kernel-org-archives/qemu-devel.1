Received: from eggs.gnu.org ([2001:4830:134:3::10]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuH3-0002Ix-9A
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuH2-0005bM-Ew
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:10:49 -0400
Date: Mon, 20 Mar 2017 10:10:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320101037.GB17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20170313214001.26339-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 01/16] block: Add
 PreallocMode to BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
> Add a PreallocMode parameter to the bdrv_truncate() function implemented
> by each block driver. Currently, we always pass PREALLOC_MODE_OFF and no
> driver accepts anything else.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h |  3 ++-
>  block.c                   |  2 +-
>  block/blkdebug.c          |  9 ++++++++-
>  block/crypto.c            |  8 +++++++-
>  block/file-posix.c        |  9 ++++++++-
>  block/file-win32.c        |  9 ++++++++-
>  block/gluster.c           |  6 +++++-
>  block/iscsi.c             |  7 ++++++-
>  block/nfs.c               |  8 +++++++-
>  block/qcow2.c             |  9 ++++++++-
>  block/qed.c               |  9 ++++++++-
>  block/raw-format.c        |  9 ++++++++-
>  block/rbd.c               |  7 ++++++-
>  block/sheepdog.c          | 11 +++++++++--
>  14 files changed, 91 insertions(+), 15 deletions(-)

This patch reminds me that some block drivers aren't using Error **errp
yet.  I have added a BiteSizedTasks entry so that this can be fixed
someday.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz6qdAAoJEJykq7OBq3PItt8IAIH/ueOctnG1iOosoKEpYy9u
aanz/ylDENoRDu8QmhTlHXUSEVLgSQ9PBtqZav1o9sVmVPM/P1XTqMZYe0G9bF7V
aS+e4KYTdNyUPbHq/Eg2yJjhnjGEpjETT3kruYha70+63prjnR278LQ0apnd3GGq
iaxnmOn1j22wYe6iVzEeyyo1CsjTdQEeY99B7upAFtZisfCF82TxMiMKVzKe9KTo
zcAM1767du58ggspREArwapX8fBt/E9f20zkRXYogi2vCJWnD8tu98Nz/g72K51H
K8tXWJ3zBWdfaPXFNczTBLJyp9zBY8hxOMxQ6gQez1LTYWAkdB97SSe92HZ7Eo0=
=bOO/
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
