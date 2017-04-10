Received: from eggs.gnu.org ([2001:4830:134:3::10]:45809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbPH-0000au-SU
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbPG-0005w3-W3
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:39:07 -0400
Date: Mon, 10 Apr 2017 16:38:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170410153854.GE3214@stefanha-x1.localdomain>
References: <cover.1491597120.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 0/8] RBD reopen,
 read_only cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 04:55:24PM -0400, Jeff Cody wrote:
>=20
> Changes from v1:
>=20
> Patch 2: Has v1 patch 8 (do not blindly xset bs->read_only) squashed into=
 it
>          (thanks Stefan)
>          COW -> "copy-on-read" (Thanks John)
>          Drop unneeded call in vvfat, and bypass enable_write_target (Ste=
fan)
>=20
> Patch 5: Rename bdrv_try_... to bdrv_can_set_read_only() (Thanks John, St=
efan)
>=20
> Patch 6: Use "reopen_state->flags" not "reopen_state->bs->open_flags"
>          (Thanks John)
>=20
>=20
>=20
> This series does two things:
>=20
> 1.) Cleans up some of the logic behind setting the read_only flag
>     for a BDS in the block layer, so that it is done consistently
>     (and rules are applied consistently), and
>=20
> 2.) Adds .bdrv_reopen_prepare() implementation for RBD, so that block
>     jobs can be run on backing chains that have rbd protocol nodes.
>=20
> Jeff Cody (8):
>   block: add bdrv_set_read_only() helper function
>   block: do not set BDS read_only if copy_on_read enabled
>   block: honor BDRV_O_ALLOW_RDWR when clearing bs->read_only
>   block: code movement
>   block: introduce bdrv_can_set_read_only()
>   block: use bdrv_can_set_read_only() during reopen
>   block/rbd - update variable names to more apt names
>   block/rbd: Add support for reopen()
>=20
>  block.c               | 56 +++++++++++++++++++++++++++++++++++---------
>  block/bochs.c         |  5 +++-
>  block/cloop.c         |  5 +++-
>  block/dmg.c           |  6 ++++-
>  block/rbd.c           | 65 +++++++++++++++++++++++++++++++++++++--------=
------
>  block/vvfat.c         | 19 +++++++++++----
>  include/block/block.h |  2 ++
>  7 files changed, 123 insertions(+), 35 deletions(-)
>=20
> --=20
> 2.9.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY66cOAAoJEJykq7OBq3PIij8H/1FlRewY7jsXAsezBYBAGGgW
SJxLi0Pp9fL80V5FYjMnxbaZbEMAF+zHBacyVcgnOIMhPqq6H1zZcX9DM0VW0/dW
SckwH+ULXl7vESOijOXwDpa0vaks4UYFtuc8i0Y46WJ7LNNfMDCiYYytfGXrYSxl
6gvGkviqMZBf7V7pPzwFRGaMYEolLppA+DDQfImY/uWp7uO8BCqsaDyKULCzSyyW
8PwkJgh7WHPR8XXbjFBiVYY+sVLZChYHIIiM/s2f96xfsRG50ZneR2ieklMN8KlQ
JZc7F3tuHkVrciIZ8JrKOSR+72ScLU9DWoG2/jVkwS3xOXbm7Sf0+Ernvc3i91g=
=KlT2
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
