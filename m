Received: from eggs.gnu.org ([2001:4830:134:3::10]:51274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAK8X-0004Rp-MQ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAK8W-0004VN-GR
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:50:25 -0400
References: <20170515164712.6643-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df2e9a8f-45dd-74ea-ade2-ec00296f9a5d@redhat.com>
Date: Mon, 15 May 2017 19:50:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170515164712.6643-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eeH7kTRdf2rGkKGnmmc909pNIRrKha9EX"
Subject: Re: [Qemu-devel] [PATCH v10 0/4] Improve convert and dd commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eeH7kTRdf2rGkKGnmmc909pNIRrKha9EX
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <df2e9a8f-45dd-74ea-ade2-ec00296f9a5d@redhat.com>
Subject: Re: [PATCH v10 0/4] Improve convert and dd commands
References: <20170515164712.6643-1-berrange@redhat.com>
In-Reply-To: <20170515164712.6643-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-15 18:47, Daniel P. Berrange wrote:
> Update to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05699.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00728.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04391.ht=
ml
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02153.ht=
ml
>   v5: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04109.ht=
ml
>   v6: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00215.ht=
ml
>   v7: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00242.ht=
ml
>   v8: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02028.ht=
ml
>   v9: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03504.ht=
ml
>=20
> This series is in response to Max pointing out that you cannot
> use 'convert' for an encrypted target image.
>=20
> The 'convert' and 'dd' commands need to first create the image
> and then open it. The bdrv_create() method takes a set of options
> for creating the image, which let us provide a key-secret for the
> encryption key. When the commands then open the new image, they
> don't provide any options, so the image is unable to be opened
> due to lack of encryption key. It is also not possible to use
> the --image-opts argument to provide structured options in the
> target image name - it must be a plain filename to satisfy the
> bdrv_create() API contract.
>=20
> This series addresses these problems to some extent
>=20
>  - Adds a new --target-image-opts flag which is used to say
>    that the target filename is using structured options.
>    It is *only* permitted to use this when -n is also set.
>    ie the target image must be pre-created so convert/dd
>    don't need to run bdrv_create().
>=20
>  - When --target-image-opts is not used, add special case
>    code that identifies options passed to bdrv_create()
>    named "*key-secret" and adds them to the options used
>    to open the new image
>=20
> In future it is desirable to make --target-image-opts work even when -n=
 is
> *not* given. This requires considerable work to create a new bdrv_creat=
e()
> API impl.
>=20
> The first patch fixes a bug in the 'dd' command while the second adds s=
upport
> for the missing '--object' arg to 'dd', allowing it to reference secret=
s when
> opening files.  The last two patches implement the new features describ=
ed above
> for the 'convert' command.

Thanks,

Reviewed-by: Max Reitz <mreitz@redhat.com>

=2E..and applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--eeH7kTRdf2rGkKGnmmc909pNIRrKha9EX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGepSEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJTI
B/9q+eDDNh0QYyBuYjgP/hFu7xyA1Q2amVM2Ml08bhLM/ht+CmE+iVSpXyonV0OC
e4L0HPuJQR4fnz8x6/d86ROqG/u9hYTASy6EfRXHg9n9JVoo8iTtLq4dsO5Bo2Q6
OlxtacLmgZWom1f5h1uD5y0iyZmi64+/Ev9KOLks8ECJ4MurvQFq8NNScdPtQBNp
8Doy2xx2UOCsl33Aa4uz/sEp945uB0d4GNpriOmnSWGKEborhzf+x+PIhN6jDwBc
T+hW7/D+D31l7JAv5XFrKAVK/GYVzcKZFeQI0KoGbRCC/DwIyr7IlyZE7obY3N/D
GGPCLECvjggvLbPHjQeqVwOq
=hYCw
-----END PGP SIGNATURE-----

--eeH7kTRdf2rGkKGnmmc909pNIRrKha9EX--
