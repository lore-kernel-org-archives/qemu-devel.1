Received: from eggs.gnu.org ([2001:4830:134:3::10]:56816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cheOj-0002D0-9k
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cheOi-0000uu-Dw
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:36:37 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-54-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <650b3bd8-7e89-82ce-5985-624abf1160ed@redhat.com>
Date: Sat, 25 Feb 2017 16:36:27 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-54-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BHdRjVV2Wd8a6gOWj5FPqMuAFx2j16Klc"
Subject: Re: [Qemu-devel] [PATCH 53/54] block: Add Error parameter to
 bdrv_set_backing_hd()
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
--BHdRjVV2Wd8a6gOWj5FPqMuAFx2j16Klc
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <650b3bd8-7e89-82ce-5985-624abf1160ed@redhat.com>
Subject: Re: [PATCH 53/54] block: Add Error parameter to bdrv_set_backing_hd()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-54-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-54-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Not all callers of bdrv_set_backing_hd() know for sure that attaching
> the backing file will be allowed by the permission system. Return the
> error from the function rather than aborting.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 27 ++++++++++++++++++++-------
>  block/commit.c        | 14 +++++++-------
>  block/mirror.c        | 16 +++++++++++++++-
>  block/stream.c        |  9 ++++++++-
>  block/vvfat.c         |  2 +-
>  include/block/block.h |  3 ++-
>  6 files changed, 53 insertions(+), 18 deletions(-)

It's a bit unfortunate that bdrv_set_backing_hd() is not atomic, that
is, that the node will no longer have a backing file if the command
fails. Oh well.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BHdRjVV2Wd8a6gOWj5FPqMuAFx2j16Klc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixpHsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANPUH/0MZpDL6ChIbuAjYvhDzxCU+sQ54sGgv
HL6etQKU0iOcIgfWm9dnqUsVxRuEfG3aGKT5/STi9+KUMOrk+aVK85vHfML2wtnn
mfBrSvk8tCor69P/zV0Q/b2IzVFOhw7jXqznPc9R+Aq/emR3SLpGDHVt5N+ChuKw
NXCS+W+0kQp+SXTC8kX0zpBst3oeLSwFDkFcB+l5oYbObKmbTxXaIJX6SnGCP8gx
3u0FXUPHyJV1ldKx6cKhfmh7Q4q+E+Mt/WElcq3RJw4/04y0Sj4Ez4cQxvBnLWxM
lPpHJRMgP8to5RDN7Y4Cuvse1YewK4i6XMCiALTwiyVe+b8PqocOkAg=
=144u
-----END PGP SIGNATURE-----

--BHdRjVV2Wd8a6gOWj5FPqMuAFx2j16Klc--
