Received: from eggs.gnu.org ([209.51.188.92]:57241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvmuF-0001Q6-FX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvmuE-00020J-Gp
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:40:39 -0500
References: <20190218104525.23674-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cc3964e3-5763-34d7-af12-b5303aa709a4@redhat.com>
Date: Mon, 18 Feb 2019 18:30:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190218104525.23674-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RNpOQYGdnJXQqWXl1xhP8KQTLgIo1COZc"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] qcow2: include LUKS payload
 overhead in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Daniel Berrange <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RNpOQYGdnJXQqWXl1xhP8KQTLgIo1COZc
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Daniel Berrange <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <cc3964e3-5763-34d7-af12-b5303aa709a4@redhat.com>
Subject: Re: [PATCH v3 0/2] qcow2: include LUKS payload overhead in qemu-img
 measure
References: <20190218104525.23674-1-stefanha@redhat.com>
In-Reply-To: <20190218104525.23674-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.19 11:45, Stefan Hajnoczi wrote:
> v3:
>  * Use encrypt.iter-time=3D10 to speed up qemu-iotests 178 [Max]

Thanks!

> v2:
>  * Take into account all "encrypt." image creation options since the LU=
KS
>    payload size varies depending on the cipher [Max]
>=20
> The LUKS payload has a significant size (>1 MB).  It must be included i=
n the
> qemu-img measure calculation so we arrive at the correct minimum image =
size.
>=20
> Stefan Hajnoczi (2):
>   qcow2: include LUKS payload overhead in qemu-img measure
>   iotests: add LUKS payload overhead to 178 qemu-img measure test
>=20
>  block/qcow2.c                    | 72 +++++++++++++++++++++++++++++++-=

>  tests/qemu-iotests/178           |  8 ++++
>  tests/qemu-iotests/178.out.qcow2 | 24 +++++++++++
>  3 files changed, 103 insertions(+), 1 deletion(-)

Applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--RNpOQYGdnJXQqWXl1xhP8KQTLgIo1COZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxq69AACgkQ9AfbAGHV
z0C7cAf/QvvsBjqA8EX76jHc97FPJWYyppG9ImOBZ+Hz+maQml9Yg34o3OtX/zvN
aWsTE0oetrl+8yHSsjjz+c3GalhRP7ki7GA1RsC7tMxohNnoffqQ0YZ2Srvna8RR
PCh7RvX/4e8iBKVFp/dOKOF/vwooT37GP81FUQ6GTfz/7YBJ+QgERPuI2FzcZOID
TyqSfkwpgkZ55zcMijSXuQDWIq+N/c85cWEWo4C3kXzaSKhGSitEonPwvbZVwhkQ
G47oCgyYLylm7aFruPSmfbxPZlSa3lttkvn891GFJNVN5hkIqXw4aoMfoRIbW1QO
NClUzKFU219zis4MoNg2zYT2RvQx4w==
=smX4
-----END PGP SIGNATURE-----

--RNpOQYGdnJXQqWXl1xhP8KQTLgIo1COZc--
