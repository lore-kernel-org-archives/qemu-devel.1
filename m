Received: from eggs.gnu.org ([2001:4830:134:3::10]:35470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Xhw-0007ij-Ve
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Xhv-00073w-0o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:44:32 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-5-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6aa6d171-d554-6953-e72b-9a5cef00a5ca@redhat.com>
Date: Mon, 8 Oct 2018 17:44:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YMao7PC8L5d2gd4vEvcLwvwod5qxZg1KV"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] block/qcow2-refcount:
 check_refcounts_l2: reduce ignored overlaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YMao7PC8L5d2gd4vEvcLwvwod5qxZg1KV
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <6aa6d171-d554-6953-e72b-9a5cef00a5ca@redhat.com>
Subject: Re: [PATCH v2 4/7] block/qcow2-refcount: check_refcounts_l2: reduce
 ignored overlaps
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> Reduce number of structures ignored in overlap check: when checking
> active table ignore active tables, when checking inactive table ignore
> inactive ones.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--YMao7PC8L5d2gd4vEvcLwvwod5qxZg1KV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7e1EACgkQ9AfbAGHV
z0AL3wf/QQWeg00ONT7VvtDubBayP7XFrYu8qFF9TQWiEfZ1z4GUdbCikcWbEqsb
+wDacyQjiv3B/AMPe2T3RTKEIyZJvEOYVDiXP1GFC4dqS0O6xPGtfJMqlDkGrFTm
h1MVsHrSZsgebXFiMUH63H2qPgOH+lqp+CpyVAHN2hACsAQ3yFE5BN1DusNqTebu
JVRuxhCOytz27clTkMwfuqJ+dyq4OksV28wMqFPhzBKF6fbMhTPjdRp39bHsfH33
V6c9fXWDUN1/z7imn9W2FX3mk0U9Z+u14b8giOV4bDfMT/vJuFG2azOwzGU0IcqY
LwwgZ81DgofhovP4DyAij9KRQXfieA==
=ShnA
-----END PGP SIGNATURE-----

--YMao7PC8L5d2gd4vEvcLwvwod5qxZg1KV--
