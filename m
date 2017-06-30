Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwOf-0007IS-Lm
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwOZ-0005Ox-As
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dQwOZ-0005NE-05
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:55:39 -0400
References: <20170614153557.3319-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e32fe960-bb2f-7c9c-dc2a-0ed46af154b1@redhat.com>
Date: Fri, 30 Jun 2017 15:55:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170614153557.3319-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2lMonC7uwMQsdSxMLCq6uN0Vc6eHeTr8q"
Subject: Re: [Qemu-devel] [PATCH v8 0/9] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lMonC7uwMQsdSxMLCq6uN0Vc6eHeTr8q
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <e32fe960-bb2f-7c9c-dc2a-0ed46af154b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/9] qemu-img: add measure sub-command
References: <20170614153557.3319-1-stefanha@redhat.com>
In-Reply-To: <20170614153557.3319-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-14 17:35, Stefan Hajnoczi wrote:
> v8:
>  * Check 2P file size in qemu-iotests 178 [Berto]
>  * Use QCOW_MAX_L1_SIZE to check maximum virtual disk size [Berto]
>=20
> v7:
>  * Check max file size with 7 exabytes [Berto]
>  * Really use UINT64_MAX everywhere instead of ~0ULL [Berto]
>=20
> v6:
>  * Change bdrv_measure() return type to BlockMeasureInfo * [Eric]
>  * Clarify that holes in sparse POSIX files are still counted [Eric]
>=20
> v5:
>  * Use UINT64_MAX instead of ~0ULL [Berto]
>  * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
>    [Berto]
>=20
> v4:
>  * Make qcow2 refcount calculation conservative [Maor]
>  * Include actual qemu-img convert image size in test cases
>=20
> v3:
>  * Drop RFC, this is ready to go for QEMU 2.10
>  * Use "required size" instead of "required bytes" in qemu-img output f=
or
>    consistency [Nir]
>  * Clarify BlockMeasureInfo semantics [Max]
>  * Clarify bdrv_measure() opts argument and error handling [Nir]
>  * Handle -o backing_file=3D for qcow2 [Max]
>  * Handle snapshot options in qemu-img measure
>  * Probe input image for allocated data clusters for qcow2.  Didn't cen=
tralize
>    this because there are format-specific aspects such as the cluster_s=
ize.  It
>    may make sense to centralize it later (with a bit more complexity) i=
f
>    support is added to more formats.
>  * Add qemu-img(1) man page section for 'measure' sub-command [Max]
>  * Extend test case to cover additional scenarios [Nir]
>=20
> RFCv2:
>  * Publishing RFC again to discuss the new user-visible interfaces.  Co=
de has
>    changed quite a bit, I have not kept any Reviewed-by tags.
>  * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
>  * Report both "required bytes" and "fully allocated bytes" to handle t=
he empty
>    image file and prealloc use cases [Nir and Dan]
>  * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
>  * Rename "err" label "out" in qemu-img-cmds.c [Nir]
>  * Add basic qcow2 support, doesn't support qemu-img convert from exist=
ing files yet
>=20
> RFCv1:
>  * Publishing patch series with just raw support, no qcow2 yet.  Please=
 review
>    the command-line interface and let me know if you are happy with thi=
s
>    approach.
>=20
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

The series looks good to me, but the output_fmt is a bit too weird to
take it. A follow-up patch would work, too, though.

Max


--2lMonC7uwMQsdSxMLCq6uN0Vc6eHeTr8q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVlhMEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPvP
B/0RAKUez6PHuXJtkDDm2z1iSKkmyq3B7rMR71gSf0msZr6MWtIjEyvGqgi37KVk
c8T0n/DjN7OSeetCDPZjWF/Aulk7PcycoViXP9UjySQodFIah1IQUrpxjuVwzIal
ty9W81QgsQ8zkU0fEXAH4u65p/shgXk4mRARM7dlWqnXkf1Pa5XX3JZXbaWXamez
H5kRH1IhwSqzLPrqa1vcnYtnvXW56xLvT3ZkJ/PwCEudO2XdbzUa5xXiYv2FGsAL
pbDr08VfOk6nGMmiJ2lwIS+SqFK4lzV4iZ8aBen6mWNfvY7I1QmFP8ZPjd2RQLPY
3AZ8EIbsLODWITQ4OkxG285V
=sumI
-----END PGP SIGNATURE-----

--2lMonC7uwMQsdSxMLCq6uN0Vc6eHeTr8q--
