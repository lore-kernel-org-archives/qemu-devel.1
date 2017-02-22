Received: from eggs.gnu.org ([2001:4830:134:3::10]:42390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWEz-0005YT-Ar
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWEy-0001r5-99
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:41:53 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-6-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef381f0b-d0f3-ab9f-163a-51dbb880a35b@redhat.com>
Date: Wed, 22 Feb 2017 13:41:42 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WXuUhnoUppILv1WgbbLk7IcAP02OVlggA"
Subject: Re: [Qemu-devel] [PATCH 05/54] block: Attach bs->file only during
 .bdrv_open()
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
--WXuUhnoUppILv1WgbbLk7IcAP02OVlggA
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <ef381f0b-d0f3-ab9f-163a-51dbb880a35b@redhat.com>
Subject: Re: [PATCH 05/54] block: Attach bs->file only during .bdrv_open()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> The way that attaching bs->file worked was a bit unusual in that it was=

> the only child that would be attached to a node which is not opened yet=
=2E
> Because of this, the block layer couldn't know yet which permissions th=
e
> driver would eventually need.
>=20
> This patch moves the point where bs->file is attached to the beginning
> of the individual .bdrv_open() implementations, so drivers already know=

> what they are going to do with the child. This is also more consistent
> with how driver-specific children work.
>=20
> For a moment, bdrv_open() gets its own BdrvChild to perform image
> probing, but instead of directly assigning this BdrvChild to the BDS, i=
t
> becomes a temporary one and the node name is passed as an option to the=

> drivers, so that they can simply use bdrv_open_child() to create anothe=
r
> reference for their own use.
>=20
> This duplicated child for (the not opened yet) bs is not the final
> state, a follow-up patch will change the image probing code to use a
> BlockBackend, which is completely independent of bs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                       | 35 ++++++++++++++++++++++++-----------=

>  block/bochs.c                 |  6 ++++++
>  block/cloop.c                 |  6 ++++++
>  block/crypto.c                |  6 ++++++
>  block/dmg.c                   |  6 ++++++
>  block/parallels.c             |  6 ++++++
>  block/qcow.c                  |  6 ++++++
>  block/qcow2.c                 | 18 +++++++++++++++---
>  block/qed.c                   | 18 +++++++++++++++---
>  block/raw-format.c            |  6 ++++++
>  block/replication.c           |  6 ++++++
>  block/vdi.c                   |  6 ++++++
>  block/vhdx.c                  |  6 ++++++
>  block/vmdk.c                  |  6 ++++++
>  block/vpc.c                   |  6 ++++++
>  tests/qemu-iotests/051.out    |  4 ++--
>  tests/qemu-iotests/051.pc.out |  4 ++--
>  17 files changed, 130 insertions(+), 21 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--WXuUhnoUppILv1WgbbLk7IcAP02OVlggA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlithwYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjyoIALWgD6VmTelZHwr3Dvpali9LKF16eKeN
EuEvnezd7Gv3Hho+hjIX93TQkC8BXsAsbWUZYrtNtYQcQ1Fl0bQWDOduUueZzyf7
sftlYhldIxD51ReQ3RneT1P9hQS2xPyCn3LGRHQk4ecneWFnibyFh0lyiERrre67
fKiw+hCTy6OG6nALHaWxCTprBG1obLNOmO58wI+oXxkxCOMFiAozTWKLwjcnBkbD
5IFIlQxjtrKSMpLmQwlm/R4XJzTpXo+wKWbgyHkgX5haVf0Cf+FZ5xkMBtWHRzf1
jDZpll2ECL1ZifGoOXnyoJqAF9yPzGy/JonKlM9ww2SJwzGkqtxpgMA=
=HSvn
-----END PGP SIGNATURE-----

--WXuUhnoUppILv1WgbbLk7IcAP02OVlggA--
