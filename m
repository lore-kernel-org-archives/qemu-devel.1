Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9JeY-0004dL-Cz
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 20:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9JeX-00053U-LC
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 20:44:06 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<16ec059666d4e2177ad59b9a85978979a0d45917.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fbb888e7-7e0a-49cd-c2f8-b7038f8700ba@redhat.com>
Date: Mon, 8 Oct 2018 02:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <16ec059666d4e2177ad59b9a85978979a0d45917.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9qUJWSVS3OdxSIPS9ElHsEIs3t9VBGuNS"
Subject: Re: [Qemu-devel] [PATCH 01/14] block: Don't call
 update_flags_from_options() if the options are wrong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qUJWSVS3OdxSIPS9ElHsEIs3t9VBGuNS
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <fbb888e7-7e0a-49cd-c2f8-b7038f8700ba@redhat.com>
Subject: Re: [PATCH 01/14] block: Don't call update_flags_from_options() if
 the options are wrong
References: <cover.1537367701.git.berto@igalia.com>
 <16ec059666d4e2177ad59b9a85978979a0d45917.1537367701.git.berto@igalia.com>
In-Reply-To: <16ec059666d4e2177ad59b9a85978979a0d45917.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> If qemu_opts_absorb_qdict() fails and we carry on and call
> update_flags_from_options() then that can result on a failed
> assertion:
>=20
>    $ qemu-io -c 'reopen -o read-only=3Dfoo' hd.qcow2
>    block.c:1101: update_flags_from_options: Assertion `qemu_opt_find(op=
ts, BDRV_OPT_CACHE_DIRECT)' failed.
>    Aborted
>=20
> This only happens in bdrv_reopen_queue_child(). Although this function
> doesn't return errors, we can simply keep the wrong options in the
> reopen queue and later bdrv_reopen_prepare() will fail.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c                    | 11 +++++++++--
>  tests/qemu-iotests/133     |  6 ++++++
>  tests/qemu-iotests/133.out |  4 ++++
>  3 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9qUJWSVS3OdxSIPS9ElHsEIs3t9VBGuNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6qEwACgkQ9AfbAGHV
z0CuDQgAnRse8LCugsr4Zy6M/Is+akW5v0fqJFu1gQxuvDKym1DdJfNrLuIfEWMw
J9wJhnE7rJgZcHDijk4vbfAQ/kWXJe/je1P+V1BvI13qvHsNgoioztwz6iz3H347
ooIQ6zmNeDArQBq8GYvoOQNas54W0kMwZMIjzJjUFbG//N6eNIpfGOMpL1IbUPSI
1jOkyXCvq4m6Ip4lwQR58VQtnflqaewCItrbFIwievRv47vjgt8mIej9sEcUyMBY
N7S5r88dNJR5eZndZF2n3sk4gm7b3dXX+IYUGpjC//4AwKvhuyCkPw8/LWV2WJR3
9KkG0YzXEUajBukE/6Q8QL0LjJMYsw==
=2QrD
-----END PGP SIGNATURE-----

--9qUJWSVS3OdxSIPS9ElHsEIs3t9VBGuNS--
