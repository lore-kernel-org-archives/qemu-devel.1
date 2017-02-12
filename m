Received: from eggs.gnu.org ([2001:4830:134:3::10]:56175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cchgw-0007Yf-07
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 19:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cchgu-0002YF-Qu
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 19:06:57 -0500
References: <20170124115748.21473-1-berrange@redhat.com>
	<20170124115748.21473-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <072d7d6f-d5ad-efe3-db77-364647593a81@redhat.com>
Date: Sun, 12 Feb 2017 01:06:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170124115748.21473-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GBc0Rgjm1sRA5nHNDJjQfPV3AlJsLuInQ"
Subject: Re: [Qemu-devel] [PATCH v3 1/5] iotests: skip 159 & 170 with luks
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GBc0Rgjm1sRA5nHNDJjQfPV3AlJsLuInQ
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <072d7d6f-d5ad-efe3-db77-364647593a81@redhat.com>
Subject: Re: [PATCH v3 1/5] iotests: skip 159 & 170 with luks format
References: <20170124115748.21473-1-berrange@redhat.com>
 <20170124115748.21473-2-berrange@redhat.com>
In-Reply-To: <20170124115748.21473-2-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 24.01.2017 12:57, Daniel P. Berrange wrote:
> While the qemu-img dd command does accept --image-opts
> this is not sufficient to make it work with the LUKS
> image yet. This is because bdrv_create() still always
> requires the non-image-opts syntax.
>=20
> Thus we must skip 159/170 with luks for now
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/159 | 2 +-
>  tests/qemu-iotests/170 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

https://github.com/XanClic/qemu/commit/b4a2caa4bd5ad4e3cd6dd7eb1c0067d920=
5280cb
introduces _unsupported_fmt. Would that be a better fit?

(Yes, I'll send a pull request today.)

Max


--GBc0Rgjm1sRA5nHNDJjQfPV3AlJsLuInQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlifpxcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOlsH/1aY/IY5VuR1r7SgbaiDOMwgUKUk52m4
V/xmXt/hkrcn9RGOU0GLcbZi4wF0VzbuuUJjUjW3AiEMGHQYVWoYoEKIM5S0xW2Z
gfei7erhHNad7fclQVaLQ9mHHbqZc1HhiJMpwGz+fPHuFG6Qg5boaoj2ydCrXX6j
uUdoNmarTZKt82Gsp92Kh7eOevPGmXspZLqJKD6HqOmz4YMWZjSaxT8wuUSiXE9O
munegi8KrGweBMBu9KV+EzU1nLWS6iARCM+CCIoP1GOG1Uf9l1Wq/O50h3VIVr6O
TRD4tDglvDlfc+VjWfrk/n/CvAlk/kF/Bi6h8CXkuWo/HcfLHavwln4=
=GzDZ
-----END PGP SIGNATURE-----

--GBc0Rgjm1sRA5nHNDJjQfPV3AlJsLuInQ--
