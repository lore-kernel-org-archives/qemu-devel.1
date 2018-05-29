Received: from eggs.gnu.org ([2001:4830:134:3::10]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNei6-0001Zv-W8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNei3-0004Ms-6l
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:30:47 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-15-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1b662fd6-0701-b653-555c-c67502d2676b@redhat.com>
Date: Tue, 29 May 2018 15:30:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-15-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xdSAgkBeNrWrCY6AX39A1kPURyVm8g4Gy"
Subject: Re: [Qemu-devel] [PATCH 14/14] block/create: Mark blockdev-create
 stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xdSAgkBeNrWrCY6AX39A1kPURyVm8g4Gy
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1b662fd6-0701-b653-555c-c67502d2676b@redhat.com>
Subject: Re: [PATCH 14/14] block/create: Mark blockdev-create stable
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-15-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> We're ready to declare the blockdev-create job stable. This renames the=

> corresponding QMP command from x-blockdev-create to blockdev-create.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json       |  4 ++--
>  qapi/job.json              |  2 +-
>  block/create.c             |  4 ++--
>  tests/qemu-iotests/206     |  2 +-
>  tests/qemu-iotests/206.out | 54 +++++++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/207     |  2 +-
>  tests/qemu-iotests/207.out | 18 ++++++++--------
>  tests/qemu-iotests/210     |  2 +-
>  tests/qemu-iotests/210.out | 18 ++++++++--------
>  tests/qemu-iotests/211     |  2 +-
>  tests/qemu-iotests/211.out | 24 ++++++++++-----------
>  tests/qemu-iotests/212     |  2 +-
>  tests/qemu-iotests/212.out | 42 ++++++++++++++++++------------------
>  tests/qemu-iotests/213     |  2 +-
>  tests/qemu-iotests/213.out | 44 ++++++++++++++++++-------------------
>  15 files changed, 111 insertions(+), 111 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xdSAgkBeNrWrCY6AX39A1kPURyVm8g4Gy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNVfcACgkQ9AfbAGHV
z0D0HAf/a1osaKdeWfrGuJd7vqSgBA9g4h1yq7dsM8kaTcm5IGsVmX/MbYYvjF4q
lU4yjCVNPguJ4s4ccU4PxrQN+tDxwWEc7tG0MoRy5s//YQ8p/0I3c5UmJOnzilzm
O1ndxYKcZk1z/AyRXQRa7aTKilXkiUGISNBT7uhlBqkHvo4EFFrwb1OsHw5INzQP
pMnlXYZKzD/rxKxOpP4gdJ8WKL2P0Ew92AlyTKFIjEG5uLSE/GQPL0L5mXBLojG7
aVk07j330jewL7csBdC6ZMcso6VDCiYNFFN/GR08eZtTpFQijOOnbl/gFZYYiuFj
6U5COnwJjNJneDp2M4T/owcBRZlSGg==
=ZI8n
-----END PGP SIGNATURE-----

--xdSAgkBeNrWrCY6AX39A1kPURyVm8g4Gy--
