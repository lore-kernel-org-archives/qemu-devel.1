Received: from eggs.gnu.org ([2001:4830:134:3::10]:52584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijNo-0004KJ-8E
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijNn-0002xw-Cg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:08:08 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-16-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eaaa3aa2-178a-5d9e-ff9d-08978c2a6cda@redhat.com>
Date: Tue, 28 Feb 2017 16:07:57 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-16-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qea6MMVO6o1BQdFW09c7ImmMJiUE8IktM"
Subject: Re: [Qemu-devel] [PATCH v3 15/44] block: Add BDRV_O_RESIZE for
 blk_new_open()
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
--qea6MMVO6o1BQdFW09c7ImmMJiUE8IktM
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <eaaa3aa2-178a-5d9e-ff9d-08978c2a6cda@redhat.com>
Subject: Re: [PATCH v3 15/44] block: Add BDRV_O_RESIZE for blk_new_open()
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-16-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> blk_new_open() is a convenience function that processes flags rather
> than QDict options as a simple way to just open an image file.
>=20
> In order to keep it convenient in the future, it must automatically
> request the necessary permissions. This can easily be inferred from the=

> flags for read and write, but we need another flag that tells us whethe=
r
> to get the resize permission.
>=20
> We can't just always request it because that means that no block jobs
> can run on the resulting BlockBackend (which is something that e.g.
> qemu-img commit wants to do), but we also can't request it never becaus=
e
> most of the .bdrv_create() implementations call blk_truncate().
>=20
> The solution is to introduce another flag that is passed by all users
> that want to resize the image.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/parallels.c     | 3 ++-
>  block/qcow.c          | 3 ++-
>  block/qcow2.c         | 6 ++++--
>  block/qed.c           | 3 ++-
>  block/sheepdog.c      | 2 +-
>  block/vdi.c           | 3 ++-
>  block/vhdx.c          | 3 ++-
>  block/vmdk.c          | 6 ++++--
>  block/vpc.c           | 3 ++-
>  include/block/block.h | 1 +
>  qemu-img.c            | 2 +-
>  11 files changed, 23 insertions(+), 12 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qea6MMVO6o1BQdFW09c7ImmMJiUE8IktM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1kk0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdlIIAJwGfO+K4OpWe0BoYrP1eHilRD1SmeQM
SLGMTVv9irdCuojrZWizDAW59SzroA4GBdI4fKfKQb5oLxBZn5ZlhOILrl24V5Y0
XSD/polbIFncFsojhp8FNyyqqmTZxyo/DnDU+6PDHA8X/54WrkWFhzREhXnT432d
wWSaCN5i+xsoOKom/vpdJC55cmzsf4qc5YSkO1L7uERPAH1MeLADMO3/B2pPKyOP
ZwYiJ/LAmgURy+qADAd3iIRNS9g0Fqacpe/X+8cnyDyVDpl+OyxTvf4E1P8+azmX
NUHeLbPPTgc6gL19NBQe4px7oBFmuVp6/9AddFW7BQ4huUsukjk3EjU=
=fgrk
-----END PGP SIGNATURE-----

--qea6MMVO6o1BQdFW09c7ImmMJiUE8IktM--
