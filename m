Received: from eggs.gnu.org ([2001:4830:134:3::10]:41537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgY2O-0007OR-Nv
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgY2N-0007jZ-S3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:37:00 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-25-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <64b46b03-6ea1-6f7c-dfab-6d722a707714@redhat.com>
Date: Wed, 22 Feb 2017 15:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-25-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RS3eCIFMP4lxAFchwibF9OxuXHgoqTrdj"
Subject: Re: [Qemu-devel] [PATCH 24/54] block: Add permissions to blk_new()
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
--RS3eCIFMP4lxAFchwibF9OxuXHgoqTrdj
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <64b46b03-6ea1-6f7c-dfab-6d722a707714@redhat.com>
Subject: Re: [PATCH 24/54] block: Add permissions to blk_new()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-25-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> We want every user to be specific about the permissions it needs, so
> we'll pass the initial permissions as parameters to blk_new(). A user
> only needs to call blk_set_perm() if it wants to change the permissions=

> after the fact.
>=20
> The permissions are stored in the BlockBackend and applied whenever a
> BlockDriverState should be attached in blk_insert_bs().
>=20
> This does not include actually choosing the right set of permissions
> everywhere yet. Instead, the usual FIXME comment is added to each place=

> and will be addressed in individual patches.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                          |  2 +-
>  block/backup.c                   |  3 ++-
>  block/block-backend.c            | 21 ++++++++++++++-------
>  block/commit.c                   | 12 ++++++++----
>  block/mirror.c                   |  3 ++-
>  block/qcow2.c                    |  2 +-
>  blockdev.c                       |  4 ++--
>  blockjob.c                       |  3 ++-
>  hmp.c                            |  3 ++-
>  hw/block/fdc.c                   |  3 ++-
>  hw/core/qdev-properties-system.c |  3 ++-
>  hw/ide/qdev.c                    |  3 ++-
>  hw/scsi/scsi-disk.c              |  3 ++-
>  include/sysemu/block-backend.h   |  2 +-
>  migration/block.c                |  3 ++-
>  nbd/server.c                     |  3 ++-
>  tests/test-blockjob.c            |  3 ++-
>  tests/test-throttle.c            |  7 ++++---
>  18 files changed, 53 insertions(+), 30 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RS3eCIFMP4lxAFchwibF9OxuXHgoqTrdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitogISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AajkH/i1pyN//FZv2xR9JS2nFG7rg2dZ0STxY
DVw0GEMvAD6WRpkPobBdAB1PD0IfzExTq5Utk0ZURjjJRLuR6v8YOylnoQVsgphK
o1xmGELVP5YYyy03KsJ6W2T4+uB8Uk/VEVBZyhot/H3ntBpK363EidDafQtfoCKs
jvJeNxRf/Nf8U+RuNVk6Rurne21Hfumqn7M1lBvYS+kOWASJCxN+N4rJmoCrB0qf
Sk/KHq6Kh2y956ZL+FjRwYsIK5yG21ZHTvQrej/FwAU2JS4WAD3DfhNk1fndvcRB
DCFC1bN7RaKi3Ha/iq+VnlFQcfkQVrOjDv6/ZVcgZ96zK3vYY5iYbBQ=
=tTrv
-----END PGP SIGNATURE-----

--RS3eCIFMP4lxAFchwibF9OxuXHgoqTrdj--
