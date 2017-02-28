Received: from eggs.gnu.org ([2001:4830:134:3::10]:49397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikVf-0000Ip-3U
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikVe-0004Ls-CA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:20:19 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-44-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f2019448-7cd9-ef1f-5bb8-14b04199d301@redhat.com>
Date: Tue, 28 Feb 2017 17:20:08 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-44-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dUUW83BoggxtJfn9mDIgQ9AmaH5LREmdx"
Subject: Re: [Qemu-devel] [PATCH v3 43/44] block: Add Error parameter to
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
--dUUW83BoggxtJfn9mDIgQ9AmaH5LREmdx
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <f2019448-7cd9-ef1f-5bb8-14b04199d301@redhat.com>
Subject: Re: [PATCH v3 43/44] block: Add Error parameter to
 bdrv_set_backing_hd()
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-44-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-44-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> Not all callers of bdrv_set_backing_hd() know for sure that attaching
> the backing file will be allowed by the permission system. Return the
> error from the function rather than aborting.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 30 +++++++++++++++++++++++-------
>  block/commit.c        | 14 +++++++-------
>  block/mirror.c        |  7 ++++++-
>  block/stream.c        |  9 ++++++++-
>  block/vvfat.c         |  2 +-
>  include/block/block.h |  3 ++-
>  6 files changed, 47 insertions(+), 18 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--dUUW83BoggxtJfn9mDIgQ9AmaH5LREmdx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1ozkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqboIAJXyTZaB2UYel1GrgSDGa2ZeuNhO5p7M
wRP0pxHtFSmbTMxvgSCGktYOA9aVRAtLyACXcu54UiIEJCjGjS1DRA0DhCrJuPTU
8RipOgdTEA6ahYZHfd2JlUI8nc7TO/9+47M1iiMLV8iRembMxN7T1GZhUlpVVa6X
1YiyvCl9/SbS8/DevVVXKhXLFuHbevNFzx9KmoKRlNOc18RQ0NvtZlTATISLdtmo
jMNqAjd7gif+QR9s+HUmoJmdTAnhGPgthQMtqAgoq8Y/I+rtxR6BLkibc5Zu4Qsr
vdPZJ93Frzr60gAHnBQM6LHgdIlboC8it9ESMQds+UQq0pp4YnYCAaE=
=a493
-----END PGP SIGNATURE-----

--dUUW83BoggxtJfn9mDIgQ9AmaH5LREmdx--
