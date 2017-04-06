Received: from eggs.gnu.org ([2001:4830:134:3::10]:36678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6Wc-0007E4-6Z
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6Wb-00062n-6f
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:28:30 -0400
Date: Thu, 6 Apr 2017 13:28:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406122819.GF21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 for-2.10 01/16] block: Add
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:21PM +0200, Max Reitz wrote:
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
>  block/gluster.c           |  8 +++++++-
>  block/iscsi.c             |  9 ++++++++-
>  block/nfs.c               |  9 ++++++++-
>  block/qcow2.c             |  9 ++++++++-
>  block/qed.c               |  9 ++++++++-
>  block/raw-format.c        |  9 ++++++++-
>  block/rbd.c               |  9 ++++++++-
>  block/sheepdog.c          | 11 +++++++++--
>  14 files changed, 98 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5jRjAAoJEJykq7OBq3PIrGIH/0Vpz7jPluk6Kbck/5s1Qzca
kYJZIP2hNmx2Drd148tK1ivegYnvSApxif2M9c0wLxZV7UW/XtxH64b8omtBcFBx
C4yFI+PDMDLkMgbqjy2XpIfeXZwPxpFOuIM8sKgihaEBvJdkemcTOWMLuJUktD/R
YGCKbLNwwSk/y4bGYtF9lBlRJ21iWnWmayOio8K8EG2GPOigBd0ywUR+V3zBZhg6
Rdd2w9ueDlTWP4H3r+Rs9rYhiShwpdFCt4lNkO+fU+ycKSacugg/zKQTPq41yDiC
v0TyWiADLSx/7mNMKGCUwlASXuAATrinpI2h/uCLbBQmzXAceiRqVeRbd4NHctk=
=ogQx
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
