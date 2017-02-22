Received: from eggs.gnu.org ([2001:4830:134:3::10]:45012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgYGZ-0000Nx-5d
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgYGY-0003Rn-8F
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:51:39 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-27-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc5b0489-2ed0-73e9-f38d-f07d9ecf162a@redhat.com>
Date: Wed, 22 Feb 2017 15:51:29 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-27-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5uBUF2S3opGHQ64ACiMCaXDj9Du58N5W1"
Subject: Re: [Qemu-devel] [PATCH 26/54] block: Add BDRV_O_RESIZE for
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
--5uBUF2S3opGHQ64ACiMCaXDj9Du58N5W1
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <dc5b0489-2ed0-73e9-f38d-f07d9ecf162a@redhat.com>
Subject: Re: [PATCH 26/54] block: Add BDRV_O_RESIZE for blk_new_open()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-27-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-27-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
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
>  block/qcow2.c         | 3 ++-
>  block/qed.c           | 3 ++-
>  block/vdi.c           | 3 ++-
>  block/vhdx.c          | 3 ++-
>  block/vmdk.c          | 6 ++++--
>  block/vpc.c           | 3 ++-
>  include/block/block.h | 1 +
>  qemu-img.c            | 2 +-
>  10 files changed, 20 insertions(+), 10 deletions(-)

Shouldn't writes beyond EOF with allow_write_beyond_eof count as a
resize, too? Then there would be one more place in qcow2.c and one in
sheepdog.c which require BDRV_O_RESIZE.

Max


--5uBUF2S3opGHQ64ACiMCaXDj9Du58N5W1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitpXESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWaQH/1KhQL4ComJlOyZew8CypHQR2A5CNsib
PcJ9dF2QCwhxAk75Memagp7oaT/G+0QHbMcD2jnEeO5LL480smULaH8iPNdOfXHs
uL4LI8q4aY9s/6I3rj4MZrned5gmpt11wMXnIOjo2ezmZ2Q4kyDOkZZMswCet9zb
0cEL58m1lniNzeLB/XYRBDXsBwowhs07SHrLYB44ezFVUOTKQChG/HjZAJGfw+KJ
T/h+t/xwgVjfqysiaxXZGlbrj4my8n2P3ttvFZyPArsQS/olv7zbRMaW1nI4u1DK
WPRwwm3i7FK38bDqDOGyq5bCxpJu/bn0OfhbBsouwghgA0IWehoBzPo=
=4HHX
-----END PGP SIGNATURE-----

--5uBUF2S3opGHQ64ACiMCaXDj9Du58N5W1--
