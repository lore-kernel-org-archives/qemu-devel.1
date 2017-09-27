Received: from eggs.gnu.org ([2001:4830:134:3::10]:33475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJGV-00044p-5A
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJGU-0008QZ-Dd
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:49:07 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
	<20170927125340.12360-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f113271d-fc23-cd12-fc4b-1c92ac1a9ecd@redhat.com>
Date: Wed, 27 Sep 2017 22:48:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BVbbWisUQk74l1rwJaRJ8sw3XrCFoMhQQ"
Subject: Re: [Qemu-devel] [PATCH v4 4/6] block: convert crypto driver to
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BVbbWisUQk74l1rwJaRJ8sw3XrCFoMhQQ
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <f113271d-fc23-cd12-fc4b-1c92ac1a9ecd@redhat.com>
Subject: Re: [PATCH v4 4/6] block: convert crypto driver to
 bdrv_co_preadv|pwritev
References: <20170927125340.12360-1-berrange@redhat.com>
 <20170927125340.12360-5-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-27 14:53, Daniel P. Berrange wrote:
> Make the crypto driver implement the bdrv_co_preadv|pwritev
> callbacks, and also use bdrv_co_preadv|pwritev for I/O
> with the protocol driver beneath. This replaces sector based
> I/O with byte based I/O, and allows us to stop assuming the
> physical sector size matches the encryption sector size.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 106 +++++++++++++++++++++++++++++--------------------=
--------
>  1 file changed, 54 insertions(+), 52 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BVbbWisUQk74l1rwJaRJ8sw3XrCFoMhQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnMDrQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKZ8H/1UCcC0fKGSv4r81kG7W/P7JXHVP7YQY
vB1eeg8uwxMUrw0iJQYJKCf3T1KT7p68xrgs/FUzioPqnTIbYZepWTv/cOtFmaNK
024uvbwi6vurIxT+uUzA/hmqv1fkC4JmAfB8do3NCHYGmpa+0e//EwMFBok0Bcuc
te4dwnBnal6G9AVsXyD624YdM2SWDa+S02lzNmrNtE92lsE0JJxkx9ErUav9q7nB
GMvVCsR2GPXuemcoxfVWmEID1vclZ5B9QZOY4gxXVvRvIKNyLNbE5awKeK/w1sXP
ZykuCrKByJN3jVRMuvZo+MAZSvraM5oP/hTBzwANTbtPEFiQd6GzK9A=
=2FIG
-----END PGP SIGNATURE-----

--BVbbWisUQk74l1rwJaRJ8sw3XrCFoMhQQ--
