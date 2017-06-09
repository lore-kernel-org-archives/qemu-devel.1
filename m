Received: from eggs.gnu.org ([2001:4830:134:3::10]:43646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKUD-0006TE-Fy
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKU6-0000zi-0G
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:02:01 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-31-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a805c668-0996-44ce-7cb5-3d3195510e48@redhat.com>
Date: Fri, 9 Jun 2017 16:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-31-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b3PbqmxcU5QGilUHRDEh98V6poKRx1GfW"
Subject: Re: [Qemu-devel] [PATCH v20 30/30] block: release persistent
 bitmaps on inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b3PbqmxcU5QGilUHRDEh98V6poKRx1GfW
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <a805c668-0996-44ce-7cb5-3d3195510e48@redhat.com>
Subject: Re: [PATCH v20 30/30] block: release persistent bitmaps on inactivate
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-31-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-31-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
> We should release them here to reload on invalidate cache.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                      |  4 ++++
>  block/dirty-bitmap.c         | 29 +++++++++++++++++++++++------
>  include/block/dirty-bitmap.h |  1 +
>  3 files changed, 28 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--b3PbqmxcU5QGilUHRDEh98V6poKRx1GfW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOqpCEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGVb
B/0Y7ORZuwU5RVNySoJP4O8hCugumEdVVQhHtAoCe+N9Co744QaxVliZ2CA3U12c
TSmdHHHI7aXpCQsWEorB4YtMykbpm8B7j/EA0PujzyfLKQRglp6G7UMwv6wYsb3V
1okytcw4bwPSayIRMl0IFksIKP72+3XnO7Va15m3J+THvYf+iC84lCwQnDwzkmxd
mwihW1gzvBa8m31eSZ63tVU5nDq0XAT49td0lUfy5dI4Nls3JnrnU79qLiVgEL3U
7mQdg0STvGBRrrzNHR7dpwYKUV9IqcS5AAz81GtbVqR/V2Pmc95LtlJpPwqQxywb
xPIDAPrfp3mRu+M58IDfKAqr
=v9rA
-----END PGP SIGNATURE-----

--b3PbqmxcU5QGilUHRDEh98V6poKRx1GfW--
