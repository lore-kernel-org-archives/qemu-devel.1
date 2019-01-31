Received: from eggs.gnu.org ([209.51.188.92]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpHKU-0005iZ-Oj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpHKT-0003rG-0S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:44:50 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c615324-9f4d-9a7d-b659-84185574a750@redhat.com>
Date: Thu, 31 Jan 2019 12:44:22 -0600
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YZNGiDYKeGp5rli2uyBdOCJNGksAkEU6X"
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YZNGiDYKeGp5rli2uyBdOCJNGksAkEU6X
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <5c615324-9f4d-9a7d-b659-84185574a750@redhat.com>
Subject: Re: [RFC PATCH 08/11] qcow2: Add basic data-file infrastructure
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-9-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 11:55 AM, Kevin Wolf wrote:
> This adds a .bdrv_open option to specify the external data file node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  3 ++-
>  block/qcow2.h        |  4 +++-
>  block/qcow2.c        | 25 +++++++++++++++++++++++--
>  3 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7f6b4b3ddd..fc46396079 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2928,7 +2928,8 @@
>              '*l2-cache-entry-size': 'int',
>              '*refcount-cache-size': 'int',
>              '*cache-clean-interval': 'int',
> -            '*encrypt': 'BlockdevQcow2Encryption' } }
> +            '*encrypt': 'BlockdevQcow2Encryption',
> +            '*data-file': 'BlockdevRef' } }

Missing docs and a '(since 4.0)' tag. Then again, it's still RFC, so
that's understandable for this draft.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YZNGiDYKeGp5rli2uyBdOCJNGksAkEU6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxTQgYACgkQp6FrSiUn
Q2qkXgf+JiBAL788JDlaZXMokpyr1x++HJ3NJtkR6lwMRZcLuGAM1xPQfWdp2Xqf
wkCttwcY8pBzLnuqXwOT4rWC/zs94QzUyfyMC1cMUnPxl7kH3lA8JPWe6DFN0Sfv
6q3hzm67zBXyFPYJCsXlFy7mti/tFTZbPAEQ2lUCzzt18sOcnUPuF+0y20/sdYZ3
QZshVERhQ38f183OnM2ZzognSd5YeQpwuLZDP989s5id3n2u4XWtxZf9C/LqBaED
29JY9UzC7i/peFHK2qwUhbawKQUfOFdoPDapBi+79FIraMBIRrZ3LbfeEaVJMYQC
x+S9Wlpda0hsSEM5eD3SMV2TtGOqyA==
=NAzP
-----END PGP SIGNATURE-----

--YZNGiDYKeGp5rli2uyBdOCJNGksAkEU6X--
