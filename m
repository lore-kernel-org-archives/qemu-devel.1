Received: from eggs.gnu.org ([2001:4830:134:3::10]:51105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikYA-0002Gs-1C
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikY9-00063i-8K
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:22:54 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-45-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d0b58368-5a80-8f34-f7c3-7b73029af671@redhat.com>
Date: Tue, 28 Feb 2017 17:22:46 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-45-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ph3WX4hlGKAh3U5vwVKcPXPREwcddlSex"
Subject: Re: [Qemu-devel] [PATCH v3 44/44] block: Add Error parameter to
 bdrv_append()
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
--Ph3WX4hlGKAh3U5vwVKcPXPREwcddlSex
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <d0b58368-5a80-8f34-f7c3-7b73029af671@redhat.com>
Subject: Re: [PATCH v3 44/44] block: Add Error parameter to bdrv_append()
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-45-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-45-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> Aborting on error in bdrv_append() isn't correct. This patch fixes it
> and lets the callers handle failures.
>=20
> Test case 085 needs a reference output update. This is caused by the
> reversed order of bdrv_set_backing_hd() and change_parent_backing_link(=
)
> in bdrv_append(): When the backing file of the new node is set, the
> parent nodes are still pointing to the old top, so the backing blocker
> is now initialised with the node name rather than the BlockBackend name=
=2E
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                    | 23 +++++++++++++++++------
>  block/mirror.c             |  9 ++++++++-
>  blockdev.c                 | 18 +++++++++++++++---
>  include/block/block.h      |  3 ++-
>  tests/qemu-iotests/085.out |  2 +-
>  5 files changed, 43 insertions(+), 12 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks for leaving me the opportunity to write a patch which removes the
bdrv_unref() from bdrv_append(). :-)

Max


--Ph3WX4hlGKAh3U5vwVKcPXPREwcddlSex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1o9cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Abi0IAL7D4e6T+Ndby3QmJQ2PVIch5f9uEOxk
FYycxKmJD3Q1qVWVI245Xldmm3a+KMkZDh2xLCXeg7/XmkCuAbjzpria+sacSiTe
7Pko90NGfnLTn9wFp4FxTdmi2BR4Uf83qlbfymRoB2YU47o54/sie8XpD+/ejvqy
1Jz1gv/d/FAoMXOq/uhlsiv7pipQXwNhqlUk/+jQm2BbOCQtNdoM+xoy4NMXuAcQ
dmGKQNgmj/d2Jw1LmzSMZ8CgPHPTFi5qmL5eXsyPhEZkKg8dOFq13DoClPlqHVUt
czb6+HGqNp/Sd6WW+d0HpX4koYq+HsnQx59KCjp/vHBDqnnQ92RZXDg=
=JbQo
-----END PGP SIGNATURE-----

--Ph3WX4hlGKAh3U5vwVKcPXPREwcddlSex--
