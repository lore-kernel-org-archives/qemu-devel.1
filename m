Received: from eggs.gnu.org ([2001:4830:134:3::10]:33366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbcjJ-0003bt-Rt
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbcjI-0001sw-Hg
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:36:57 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-15-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d22bc91d-0344-7839-3786-61080a0bcc4d@redhat.com>
Date: Thu, 9 Feb 2017 01:36:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-15-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MsNq3ecmvhK7LjO5ESqr0TwDS91C7MRq2"
Subject: Re: [Qemu-devel] [PATCH v3 14/18] qcow2: add iotests to cover LUKS
 encryption support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MsNq3ecmvhK7LjO5ESqr0TwDS91C7MRq2
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d22bc91d-0344-7839-3786-61080a0bcc4d@redhat.com>
Subject: Re: [PATCH v3 14/18] qcow2: add iotests to cover LUKS encryption
 support
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-15-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-15-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 11:18, Daniel P. Berrange wrote:
> This extends the 087 iotest to cover LUKS encryption when doing
> blockdev-add.
>=20
> Two further tests are added to validate read/write of LUKS
> encrypted images with a single file and with a backing file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/087     | 32 ++++++++++++++++-
>  tests/qemu-iotests/087.out | 14 +++++++-
>  tests/qemu-iotests/174     | 76 ++++++++++++++++++++++++++++++++++++++=
++
>  tests/qemu-iotests/174.out | 19 ++++++++++
>  tests/qemu-iotests/175     | 86 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/175.out | 26 ++++++++++++++
>  tests/qemu-iotests/group   |  2 ++
>  7 files changed, 253 insertions(+), 2 deletions(-)
>  create mode 100755 tests/qemu-iotests/174
>  create mode 100644 tests/qemu-iotests/174.out
>  create mode 100755 tests/qemu-iotests/175
>  create mode 100644 tests/qemu-iotests/175.out

[...]

> diff --git a/tests/qemu-iotests/174.out b/tests/qemu-iotests/174.out
> new file mode 100644
> index 0000000..bf1a23a
> --- /dev/null
> +++ b/tests/qemu-iotests/174.out
> @@ -0,0 +1,19 @@
> +QA output created by 174
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 encryptio=
n-format=3Dluks luks-key-secret=3Dsec0 luks-iter-time=3D10
> +
> +=3D=3D reading whole image =3D=3D
> +read 16777216/16777216 bytes at offset 0
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D rewriting whole image =3D=3D
> +wrote 16777216/16777216 bytes at offset 0
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D verify pattern =3D=3D
> +read 16777216/16777216 bytes at offset 0
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D verify open failure with wrong password =3D=3D
> +can't open: Invalid password, cannot unlock any keyslot
> +no file open, try 'help open'

This line will need to be removed because of:
https://github.com/XanClic/qemu/commit/d943be0de2168543a3ada81c292f6ff379=
e71590

Also, the test numbers need to be bumped up (173 and 174 are taken), but
all of these are things the maintainer can fix, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


[...]

> +SECRET0=3D"secret,id=3Dsec0,data=3Dastrochicken"
> +SECRET1=3D"secret,id=3Dsec1,data=3Dfurby"

You always have the best passwords.


--MsNq3ecmvhK7LjO5ESqr0TwDS91C7MRq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibuaASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdtUIAJf5AbsN8nqwSCjmBoBgjWBakBaEzMVQ
pc0awJYfXSSXdjkUdmgw02PCLiudGVuxr+JGVrcNoqrMFPVrzaeR1homrKuA9hT0
UZEGccqlLi29xomiLGVmbOYmbyEAvVoavwoD9E1vSVtp0SkZri1BG9nHr86kkFvm
bK+nV3MWY3zzjm2sI4rxghzwyJd4916a1mJcWcuIYFhc4l93P8scaCAfYCakmeoA
Y1acxE5fjRYUyglCYH0NAUC7ZUGK50KHvs4mwPbouZrbEMPoS4PjbO3Y6dRp2AEO
sVYr6eq6e4ygV/xuEnFtlaE+WfOo2qPtg48+/hEtPKiq2cJM3U8h1h0=
=TJTw
-----END PGP SIGNATURE-----

--MsNq3ecmvhK7LjO5ESqr0TwDS91C7MRq2--
