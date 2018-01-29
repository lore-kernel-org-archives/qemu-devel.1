Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFZp-0001nq-53
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFZo-0005b7-Fo
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:58:49 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-7-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <695142d6-8353-53c1-f639-0791d7a3a117@redhat.com>
Date: Mon, 29 Jan 2018 20:58:37 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-7-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3xI2kjgI9HfZ6P57JJY4TaOu8GJB3k4Zo"
Subject: Re: [Qemu-devel] [PATCH v7 6/9] block: support BDRV_REQ_ALLOCATE in
 passthrough drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xI2kjgI9HfZ6P57JJY4TaOu8GJB3k4Zo
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <695142d6-8353-53c1-f639-0791d7a3a117@redhat.com>
Subject: Re: [PATCH v7 6/9] block: support BDRV_REQ_ALLOCATE in passthrough
 drivers
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-7-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:49, Anton Nefedov wrote:
> Support the flag if the underlying BDS supports it
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/blkdebug.c   | 3 ++-
>  block/blkverify.c  | 2 +-
>  block/mirror.c     | 2 +-
>  block/raw-format.c | 3 ++-
>  4 files changed, 6 insertions(+), 4 deletions(-)

May need a fixup for mirror.c; and maybe quorum would be another driver
to think about (it currently doesn't handle these flags at all).

Max


--3xI2kjgI9HfZ6P57JJY4TaOu8GJB3k4Zo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvfO0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ah/kH/2h9F15wzc+Ukdv7M/FUDy25j60gKh5G
fV3l1hWQ/wT+7fbQa9++0oW0wLF+YsgA09J7pYgyw01AitQazVcqK0g6vFFN4Bl4
NjpCJZ07njFR20XB3LfCv/TwToXEDo+Z2PRwWPjTP7aFQxasY6zabOvY7iE9OOig
UWglbflm3uR5Q7iJCqb374eHrdQSlS7SfL3X6nE1qe11FSi9P47OpAvFb1vsivVb
Cl14r9XFAmooo4F+rIC+b52jCtoxfw2ARfYnlHFzJBCZQmqBsj6p086z7QQOq1D5
aleTyYvtaBJwVEGYnZEZYA4RJPYM9vDkZ5o0c7XZdmSq4cF9s8T38Vc=
=jGK/
-----END PGP SIGNATURE-----

--3xI2kjgI9HfZ6P57JJY4TaOu8GJB3k4Zo--
