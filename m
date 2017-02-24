Received: from eggs.gnu.org ([2001:4830:134:3::10]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chFwQ-0004KW-3M
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chFwP-00057G-74
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:29:46 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-29-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1b54b3e8-326b-ce44-8d9c-3713bac742a1@redhat.com>
Date: Fri, 24 Feb 2017 14:29:35 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-29-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QBFoDdTDSQSLjeDBJ2u60S9JImbhSgdxn"
Subject: Re: [Qemu-devel] [PATCH 28/54] block: Allow error return in
 BlockDevOps.change_media_cb()
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
--QBFoDdTDSQSLjeDBJ2u60S9JImbhSgdxn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1b54b3e8-326b-ce44-8d9c-3713bac742a1@redhat.com>
Subject: Re: [PATCH 28/54] block: Allow error return in
 BlockDevOps.change_media_cb()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-29-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-29-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Some devices allow a media change between read-only and read-write
> media. They need to adapt the permissions in their .change_media_cb()
> implementation, which can fail. So add an Error parameter to the
> function.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          | 20 +++++++++++++++-----
>  blockdev.c                     | 19 +++++++++++++++----
>  hw/block/fdc.c                 |  2 +-
>  hw/ide/core.c                  |  2 +-
>  hw/scsi/scsi-disk.c            |  2 +-
>  hw/sd/sd.c                     |  2 +-
>  include/block/block_int.h      |  2 +-
>  include/sysemu/block-backend.h |  2 +-
>  8 files changed, 36 insertions(+), 15 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QBFoDdTDSQSLjeDBJ2u60S9JImbhSgdxn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwNUASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJywIAJwkVzcS0CM72G2iMKtzj0zivOoJGhRr
6+l1xRnsw7lmp/7fHFCwsV/PpmIukgSxYKaJI512UaF+ejU+IAv7y0SexlMP/WW+
+IJxSrJTBqhm1yose0apNDlbxf2lPuTwW4VdH6HL+zHdh92nPHCwgiPd7DzxXLL6
knAKTQTLEd2uzGh8E7dnSW/1zAnJ6Z9WTEE32twMVZNSFkLEbbZRG2Ayo40FYnMu
FvmU9D0YwRuArtWLiPHCfFjyWAJ/uP6xcsNeWsDE0AgaubAayD1k8h5e5h6S+S04
KI5NwYikP76BdTf0BDvvOprt3HWs8aQJok6PaV2cMej082u0gNNuUH4=
=UbLU
-----END PGP SIGNATURE-----

--QBFoDdTDSQSLjeDBJ2u60S9JImbhSgdxn--
