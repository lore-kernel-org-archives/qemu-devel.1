Received: from eggs.gnu.org ([2001:4830:134:3::10]:45416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RVr-0005Kh-0B
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RVn-0002Qw-Sp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:35:20 -0400
Date: Fri, 20 Apr 2018 16:35:12 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420083512.GO15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MmQIYbZiCoQ2kDro"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/9] block: Support
 BDRV_REQ_WRITE_UNCHANGED in filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--MmQIYbZiCoQ2kDro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 06:58:46PM +0200, Max Reitz wrote:
> Update the rest of the filter drivers to support
> BDRV_REQ_WRITE_UNCHANGED.  They already forward write request flags to
> their children, so we just have to announce support for it.
>=20
> This patch does not cover the replication driver because that currently
> does not support flags at all, and because it just grabs the WRITE
> permission for its children when it can, so we should be fine just
> submitting the incoming WRITE_UNCHANGED requests as normal writes.
>=20
> It also does not cover format drivers for similar reasons.  They all use
> bdrv_format_default_perms() as their .bdrv_child_perm() implementation
> so they just always grab the WRITE permission for their file children
> whenever possible.  In addition, it often would be difficult to
> ascertain whether incoming unchanging writes end up as unchanging writes
> in their files.  So we just leave them as normal potentially changing
> writes.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/blkdebug.c   |  9 +++++----
>  block/blkreplay.c  |  3 +++
>  block/blkverify.c  |  3 +++
>  block/cor.c        | 10 ++++++----
>  block/mirror.c     |  2 ++
>  block/raw-format.c |  9 +++++----
>  block/throttle.c   |  6 ++++--
>  7 files changed, 28 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MmQIYbZiCoQ2kDro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2aZAAAoJEJykq7OBq3PIS5oH/3pSlWaSC3LYlG87hvX/dFge
P2qbmrfIbJhQybHeh8DflAN31r3ESQJpE+Unq/vwvt5ZgpMXXWY7ojZJi/+t+/C6
OaRN6eB2xtcisuTuyOsUnaEHB7q4t8EQ/mepJ3Yd23Ah0w/kulGdMBIiUwzOyroy
yKbNq7zyyOO3MbpGz11xjauRdXFLQFTo8bscdyvKk63phcak01L0Z4vvoJT6O2qz
+XdEphVqj50Qrq7BgTmTatpZVLOVRvHDnfEx7v3Kw9ceCNFtZ6rNbaAG56xZoNvY
3/8gphiiP8ya7paN0utvUbfwjrNpEAxwlfXKSXvDhOH58Rm3wlkGbCywtYKdZHI=
=YCSE
-----END PGP SIGNATURE-----

--MmQIYbZiCoQ2kDro--
