Received: from eggs.gnu.org ([2001:4830:134:3::10]:53232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chb7B-0006Tw-Hf
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chb7A-0000hw-Pz
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:06:17 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-39-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1549e73b-eec1-312b-648d-747547840f8d@redhat.com>
Date: Sat, 25 Feb 2017 13:06:07 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-39-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wm1PxThnw4mDKcoLOELl6jM4tIGmJm0Rq"
Subject: Re: [Qemu-devel] [PATCH 38/54] backup: Use real permissions in
 backup block job
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
--wm1PxThnw4mDKcoLOELl6jM4tIGmJm0Rq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1549e73b-eec1-312b-648d-747547840f8d@redhat.com>
Subject: Re: [PATCH 38/54] backup: Use real permissions in backup block job
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-39-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-39-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> The backup block job doesn't have very complicated requirements: It
> needs to read from the source and write to the target, but it's fine
> with either side being changed. The only restriction is that we can't
> resize the image because the job uses a cached value.
>=20
> qemu-iotests 055 needs to be changed because it used a target which was=

> already attached to a virtio-blk device. The permission system correctl=
y
> forbids this (virtio-blk can't accept another writer with its default
> share-rw=3Doff).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/backup.c         | 15 ++++++++++-----
>  tests/qemu-iotests/055 | 11 +++++++----
>  2 files changed, 17 insertions(+), 9 deletions(-)

Not sure how much sense it makes to allow other writers on the target
node, but it's not as if the backup block job itself would care:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--wm1PxThnw4mDKcoLOELl6jM4tIGmJm0Rq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixcy8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AP5IIALywYdSV01DBmL6nI8GYlMDTYanPXlTJ
uaBJuxWFd6XlB6DaPAJ9+R0bJ0eUh6m6PBOWRiDxlHhFQtQLu0B6DUCT7cRIfeRT
/TXpmloO45ED8Pn76FZcWaG3SjCbnEB3SDv/4uNy1NBD1J+BVaOhNe1Ia87c0KMc
e2IR/3lfLxKQtYMsGe0onCE3aCuLIpPOWCSMxkiaea2ugDaSs0bESs42pXVkswXy
AikCnKNXA4F8tVu2dZ8r367nm+yNEb13fNwPt9jbBaEGfSkXOPEHly45J45O2bRd
G9LndpSB6SxlznXmQw//z8HiAhiG01WE8suGmazXhJuRGYuk3+/AKJ8=
=TmWB
-----END PGP SIGNATURE-----

--wm1PxThnw4mDKcoLOELl6jM4tIGmJm0Rq--
