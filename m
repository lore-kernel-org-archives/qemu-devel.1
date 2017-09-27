Received: from eggs.gnu.org ([2001:4830:134:3::10]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJI3-00059f-0t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJI2-0001XA-Be
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:50:43 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
	<20170927125340.12360-6-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc789b5a-968b-34db-e991-b54f15c390bb@redhat.com>
Date: Wed, 27 Sep 2017 22:50:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4o0c59EP1sxnCbNpiS1s8LOcM45i0lcIe"
Subject: Re: [Qemu-devel] [PATCH v4 5/6] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
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
--4o0c59EP1sxnCbNpiS1s8LOcM45i0lcIe
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <dc789b5a-968b-34db-e991-b54f15c390bb@redhat.com>
Subject: Re: [PATCH v4 5/6] block: convert qcrypto_block_encrypt|decrypt to
 take bytes offset
References: <20170927125340.12360-1-berrange@redhat.com>
 <20170927125340.12360-6-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-27 14:53, Daniel P. Berrange wrote:
> Instead of sector offset, take the bytes offset when encrypting
> or decrypting data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c         | 12 ++++--------
>  block/qcow.c           | 11 +++++++----
>  block/qcow2-cluster.c  |  8 +++-----
>  block/qcow2.c          |  4 ++--
>  crypto/block-luks.c    | 12 ++++++++----
>  crypto/block-qcow.c    | 12 ++++++++----
>  crypto/block.c         | 20 ++++++++++++++------
>  crypto/blockpriv.h     |  4 ++--
>  include/crypto/block.h | 14 ++++++++------
>  9 files changed, 56 insertions(+), 41 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--4o0c59EP1sxnCbNpiS1s8LOcM45i0lcIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnMDxUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9hEIAKYEuUyqN1W2j4Ujo+ZbnoS6kHBhgCfU
O8O+FWmEXgW7uI5r/eVtEQhw9d+sG0a9DrhsYMmpp8zgmrYblCgQ5HLYJtkNyMDU
W0avL9dTMHgwTTTseaCkcWbFWofW6FFq0uaEU9gOdq3TBQffhpetV+E2oVAHO3WD
+uBa3BOZ+BOdzelMzG5E5aysR8e+mh7oqEmRdO1swX95gdFitk/ESrpzu+qU4EZO
R/o3nAjjVsey3TJ4gnCHxcwEBe5T6bXJA4DUtjJznY2r1e8opfvozb6AUoOUs5BR
6QnF2BZqsRLFxt+yz8jv9fhwIygD45Bh/QSu9Ld0AvNP6de2calwTto=
=88H2
-----END PGP SIGNATURE-----

--4o0c59EP1sxnCbNpiS1s8LOcM45i0lcIe--
