Received: from eggs.gnu.org ([2001:4830:134:3::10]:50309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyDB-0001V7-PU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyDA-0004Vb-Ua
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:38:25 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<4a7de8aa1edebbb18e7ee0eeafc5bf2ddd51ebd9.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9944fc33-c921-a0de-8641-9eba18f766c6@redhat.com>
Date: Wed, 31 Jan 2018 20:38:11 +0100
MIME-Version: 1.0
In-Reply-To: <4a7de8aa1edebbb18e7ee0eeafc5bf2ddd51ebd9.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cZNYsoT7peVJhDkawTrtg8JkLM22c4DyL"
Subject: Re: [Qemu-devel] [PATCH v3 10/39] qcow2: Remove BDS parameter from
 qcow2_cache_discard()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZNYsoT7peVJhDkawTrtg8JkLM22c4DyL
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <9944fc33-c921-a0de-8641-9eba18f766c6@redhat.com>
Subject: Re: [PATCH v3 10/39] qcow2: Remove BDS parameter from
 qcow2_cache_discard()
References: <cover.1516978645.git.berto@igalia.com>
 <4a7de8aa1edebbb18e7ee0eeafc5bf2ddd51ebd9.1516978645.git.berto@igalia.com>
In-Reply-To: <4a7de8aa1edebbb18e7ee0eeafc5bf2ddd51ebd9.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_idx() and qcow2_cache_table_release(). This
> is no longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c    | 2 +-
>  block/qcow2-refcount.c | 6 +++---
>  block/qcow2.h          | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--cZNYsoT7peVJhDkawTrtg8JkLM22c4DyL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGyMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Acx4IAIveDpzze7no9MfJ7CV/+rgqs2c5pbJ4
QHGDY7ml2R2OGkNlPhYsb5Qpu9kPAMJicdeyWC2nGzPIVuuFtX5DMjBUpc3qJCHr
LMCxLVdQl4T9OU2JMr65AGJjLkYF/WuShxxoMa9YQ1fs84/ru5ThUi6zCrSBmedL
8OndqlWnn7nC4sqE9wPhEUM/SYA+C7iQ+H3GdCr3mGFrylmW1XBDdWjOlSKkc6y8
cGPYdiAWhiIqVzOfleqOK3weQFmVpgg8XJNskPeDS06o3pTcWU8bExyMVd8HWQBb
rffjYec/GEHCsq7MZwdrbDOHUpsrX9iScEA3nxVGAJWsRBTkCepFuUU=
=//J7
-----END PGP SIGNATURE-----

--cZNYsoT7peVJhDkawTrtg8JkLM22c4DyL--
