Received: from eggs.gnu.org ([209.51.188.92]:33279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjoBA-0007Ti-R1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjoB6-00066Z-EY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:36:34 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-10-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <82d15c5e-b1ab-35f2-f78c-d5cfe58623f7@redhat.com>
Date: Wed, 16 Jan 2019 17:36:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FkvecXIEWwaKmObu13z7uvKFgNOGRUjCI"
Subject: Re: [Qemu-devel] [PATCH v5 09/11] block: add lock/unlock range
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FkvecXIEWwaKmObu13z7uvKFgNOGRUjCI
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <82d15c5e-b1ab-35f2-f78c-d5cfe58623f7@redhat.com>
Subject: Re: [PATCH v5 09/11] block: add lock/unlock range functions
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-10-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> From: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>
>=20
> Introduce lock/unlock range functionality, based on serialized
> requests. This is needed to refactor backup, dropping local
> tracked-request-like synchronization.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>
> ---
>  include/block/block_int.h |  4 ++++
>  block/io.c                | 45 ++++++++++++++++++++++++++++++++++++++-=

>  2 files changed, 48 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--FkvecXIEWwaKmObu13z7uvKFgNOGRUjCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw/XXYACgkQ9AfbAGHV
z0C8jQgArC+yGLcpHVkmD5TtaE9qw5PBxCh3JRbueQffb/nCHoaayxG7il9MEyp9
7L5R2OH6BmlZ0xPJEPymc6qZdPsL37RuBOKqbMZvTc/v6I9CV3Ao53B6zB+CvU9e
eI3iqvMybgr/07su7mvwjnyo1Ga712+fg7S+N+4iZPXtJUDxxyDuy7lzpg+VjcKN
e3vIHyv1BVQsyrwRQ/72PUJLD0u4gmHWVUrEnOu8Ufbi6AX/VqcbnskyV9gbaUs1
m9gpJqmxr8Lt2FX+byao9xvQnZFN62nzxYQcKrTKIsxFMXZQJU7UYHuxTYqyBL5e
+c8Qk9stPU5ShDldtP8sIlZ4vCvhYQ==
=oGg9
-----END PGP SIGNATURE-----

--FkvecXIEWwaKmObu13z7uvKFgNOGRUjCI--
