Received: from eggs.gnu.org ([2001:4830:134:3::10]:55757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfllj-00067A-Ah
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cflli-0001Ng-Fu
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:04:35 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-17-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef9df6e6-6029-29ba-caa6-93bdbe835bae@redhat.com>
Date: Mon, 20 Feb 2017 12:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-17-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pgQxvB9he3sPpsvjwcTSxAV4dcEc9EX6h"
Subject: Re: [Qemu-devel] [RFC PATCH 16/41] block: Add error parameter to
 blk_insert_bs()
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
--pgQxvB9he3sPpsvjwcTSxAV4dcEc9EX6h
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <ef9df6e6-6029-29ba-caa6-93bdbe835bae@redhat.com>
Subject: Re: [RFC PATCH 16/41] block: Add error parameter to blk_insert_bs()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-17-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> Mow that blk_insert_bs() requests the BlockBackend permissions for the
> node it attaches to, it can fail. Instead of aborting, pass the errors
> to the callers.

So it does qualify as a FIXME, but just for a single patch. Good. :-)

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/backup.c                   |  5 ++++-
>  block/block-backend.c            | 12 ++++++++----
>  block/commit.c                   | 38 ++++++++++++++++++++++++++++++--=
------
>  block/mirror.c                   | 15 ++++++++++++---
>  blockdev.c                       |  6 +++++-
>  blockjob.c                       |  7 ++++++-
>  hmp.c                            |  6 +++++-
>  hw/core/qdev-properties-system.c |  7 ++++++-
>  include/sysemu/block-backend.h   |  2 +-
>  migration/block.c                |  2 +-
>  nbd/server.c                     |  6 +++++-
>  tests/test-blockjob.c            |  2 +-
>  12 files changed, 84 insertions(+), 24 deletions(-)

[...]

> diff --git a/migration/block.c b/migration/block.c
> index 6b7ffd4..d259936 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -446,7 +446,7 @@ static void init_blk_migration(QEMUFile *f)
>          BlockDriverState *bs =3D bmds_bs[i].bs;
> =20
>          if (bmds) {
> -            blk_insert_bs(bmds->blk, bs);
> +            blk_insert_bs(bmds->blk, bs, &error_abort);

I don't think it's obvious why this is correct. I assume it is because
this was a legal configuration on the source, so it must be a legal
configuration on the destination.

But I'd certainly appreciate a comment to make that explicitly clear,
especially considering that it isn't obvious that blk_insert_bs() can
fail only because of op blockers and thus will always work if the
configuration is known to be legal.

Max

> =20
>              alloc_aio_bitmap(bmds);
>              error_setg(&bmds->blocker, "block device is in use by migr=
ation");


--pgQxvB9he3sPpsvjwcTSxAV4dcEc9EX6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliqzToSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlpkIALr2s7TIBTWjhGOr1KJSItgi1wWt4lA2
lmUu3vTqWUnNVMPWl+1ev0JEQ+XU1PMOU7/79d1M8s9zLNW0kouteicWcwSxloLy
sQrqEg6sG8HpDNSbvbJizRCjlbVm8NuqQkMu749SJCy54E3RuW3h6QkN+PpHockU
srxNCx3y3WO708rolzypbjoFpNheVuzIV1i+z7i+LjU84YwToafgHzmDKyd1cCdj
1f2cemu1CnXEYMB4ir4UwyuNvJHFZNYyqVBtRYawIZ85KIyG7FnkZY2i1r7kt0FX
9zwU3Q2aXTyL7YOozpDRVz2yA+ZVbf2/OjUYJwu0es/WSQBWWMy41b4=
=q2+F
-----END PGP SIGNATURE-----

--pgQxvB9he3sPpsvjwcTSxAV4dcEc9EX6h--
