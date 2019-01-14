Received: from eggs.gnu.org ([209.51.188.92]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj2wr-0007Qe-7u
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj2wq-0002Gl-G5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:10:41 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <385561a7-4dd2-914d-3027-e1a89c39b27e@redhat.com>
Date: Mon, 14 Jan 2019 15:10:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V5z18tAr8fEn1I9nSzLqxsKxlok5orrZJ"
Subject: Re: [Qemu-devel] [PATCH v5 02/11] block/backup: move to copy_bitmap
 with granularity
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
--V5z18tAr8fEn1I9nSzLqxsKxlok5orrZJ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <385561a7-4dd2-914d-3027-e1a89c39b27e@redhat.com>
Subject: Re: [PATCH v5 02/11] block/backup: move to copy_bitmap with
 granularity
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> We are going to share this bitmap between backup and backup-top filter
> driver, so let's share something more meaningful. It also simplifies
> some calculations.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 48 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--V5z18tAr8fEn1I9nSzLqxsKxlok5orrZJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8mEUACgkQ9AfbAGHV
z0AsKQf9EsJsMEebxJoRtNJ23IWNgKpKLOXa0Ooxk3pPuebBL6vE3vlFwMr3M3Ef
cbWQ27Rw4tHlkA3PKre//H61L2IhzjWQl+eWdjJ48zV6D9ylHta0DkqAjUeWB1sa
dTDbDccAG7AWYY8vy8G7ay4tdwhNfZf0YCErCG7iVfAuwGx725kczdvrXitt1Qwt
OALkgl6+A0tjExwLX05ewaZaRMTGC81uJ7VV4THD+fxMZ8A2cqs4ck4LJldcxPfe
D0e7O2UzCqJHkqZweKucu6ms5OH5heytaGD0xoA/cScfselOmWht+yCTVwrYjdHH
9Ik1nh+k/PU8aknNdjSRLDYHMjMC8g==
=8h/t
-----END PGP SIGNATURE-----

--V5z18tAr8fEn1I9nSzLqxsKxlok5orrZJ--
