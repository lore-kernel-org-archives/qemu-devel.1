Received: from eggs.gnu.org ([2001:4830:134:3::10]:47219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUI0x-000408-1L
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUI0t-0007Qg-Rv
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dUI0t-0007QQ-Id
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:37:03 -0400
References: <20170705125738.8777-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3c7c5985-19b6-1488-2f53-cdd8ef421d8f@redhat.com>
Date: Sun, 9 Jul 2017 21:36:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170705125738.8777-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="67DPKVxTct3t3lt2aBf97kWVWWKTmvoQG"
Subject: Re: [Qemu-devel] [PATCH v9 0/9] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--67DPKVxTct3t3lt2aBf97kWVWWKTmvoQG
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <3c7c5985-19b6-1488-2f53-cdd8ef421d8f@redhat.com>
Subject: Re: [PATCH v9 0/9] qemu-img: add measure sub-command
References: <20170705125738.8777-1-stefanha@redhat.com>
In-Reply-To: <20170705125738.8777-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 14:57, Stefan Hajnoczi wrote:
> v9:
>  * Fix swapped fmt <-> output_fmt parameters in documentation [Max]

Oh, it was just the wrong way around there.

>  * Clarify that backing file clusters also available in the new image
>    file *may* be ommitted from the calculation [Max]

[...]

> Users and management tools sometimes need to know the size required for=
 a new
> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead o=
f time.
> Image formats like qcow2 have non-trivial metadata that makes it hard t=
o
> estimate the exact size without knowledge of file format internals.
>=20
> This patch series introduces a new qemu-img sub-command that calculates=
 the
> required size for both image creation and conversion scenarios.
>=20
> The conversion scenario is:
>=20
>   $ qemu-img measure -f raw -O qcow2 input.img
>   required size: 1327680
>   fully allocated size: 1074069504
>=20
> Here an existing image file is taken and the output includes the space =
required
> for data from the input image file.
>=20
> The creation scenario is:
>=20
>   $ qemu-img measure -O qcow2 --size 5G
>   required size: 327680
>   fully allocated size: 1074069504
>=20
> Stefan Hajnoczi (9):
>   block: add bdrv_measure() API
>   raw-format: add bdrv_measure() support
>   qcow2: extract preallocation calculation function
>   qcow2: make refcount size calculation conservative
>   qcow2: extract image creation option parsing
>   qcow2: add bdrv_measure() support
>   qemu-img: add measure subcommand
>   qemu-iotests: support per-format golden output files
>   iotests: add test 178 for qemu-img measure
>=20
>  qapi/block-core.json             |  25 +++
>  include/block/block.h            |   2 +
>  include/block/block_int.h        |   2 +
>  block.c                          |  35 ++++
>  block/qcow2.c                    | 383 +++++++++++++++++++++++++++++--=
--------
>  block/raw-format.c               |  26 +++
>  qemu-img.c                       | 234 ++++++++++++++++++++++++
>  qemu-img-cmds.hx                 |   6 +
>  qemu-img.texi                    |  30 +++
>  tests/qemu-iotests/178           | 170 +++++++++++++++++
>  tests/qemu-iotests/178.out.qcow2 | 286 +++++++++++++++++++++++++++++
>  tests/qemu-iotests/178.out.raw   | 158 ++++++++++++++++
>  tests/qemu-iotests/check         |   5 +
>  tests/qemu-iotests/group         |   1 +
>  14 files changed, 1268 insertions(+), 95 deletions(-)
>  create mode 100755 tests/qemu-iotests/178
>  create mode 100644 tests/qemu-iotests/178.out.qcow2
>  create mode 100644 tests/qemu-iotests/178.out.raw

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--67DPKVxTct3t3lt2aBf97kWVWWKTmvoQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYoXWEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCiC
B/46n6axV672oqDaArMdRNjEwRHc+fHqlAOfd5tdYzMHdoqt2Jlha0fTjR01Wu1j
Ft8nw9R+zVLWvYsrtXVQRUjLBcxaeAuqTEZGvCGdSUSDDEw3jxhhOagZQKOaYUpz
PK/ZuUQO2zZZ5G6zrDc0VCHq0/bQq+tY9RRZmh/SflHu3Yi51rYGVhR8e8AVKcZU
jo9mO+Znmb9rdo1Kzx4qRY6KGfbNxCXyKd8CKJIIpBye6VNq+4Glx8GZbYknX1BY
0BMfuCWVqQ/zsgL7zHmwqL3x61Z9hfry28QopinLHTnAQGuuGT3NsulJkrBeypPO
livjefAspQIVmqrm4UXatS2+
=+VR9
-----END PGP SIGNATURE-----

--67DPKVxTct3t3lt2aBf97kWVWWKTmvoQG--
