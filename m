Received: from eggs.gnu.org ([2001:4830:134:3::10]:44812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOswv-0006iD-BE
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 17:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOswt-0001D4-Su
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 17:22:53 -0500
References: <20171212144054.16955-1-edgar.kaziakhmedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efce3fe5-83da-19ac-983d-4ac206b2b847@redhat.com>
Date: Tue, 12 Dec 2017 16:22:42 -0600
MIME-Version: 1.0
In-Reply-To: <20171212144054.16955-1-edgar.kaziakhmedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OE8MhTMhHfuT06UBmhik8QWrkl7jWc4Hm"
Subject: Re: [Qemu-devel] [PATCH] qcow2: get rid of qcow2_backing_read1
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com, klim.kireev@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OE8MhTMhHfuT06UBmhik8QWrkl7jWc4Hm
From: Eric Blake <eblake@redhat.com>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 klim.kireev@virtuozzo.com, den@openvz.org
Message-ID: <efce3fe5-83da-19ac-983d-4ac206b2b847@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: get rid of qcow2_backing_read1
 routine
References: <20171212144054.16955-1-edgar.kaziakhmedov@virtuozzo.com>
In-Reply-To: <20171212144054.16955-1-edgar.kaziakhmedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2017 08:40 AM, Edgar Kaziakhmedov wrote:
> Since bdrv_co_preadv does all neccessary checks including

s/neccessary/necessary/

> reading after the end of the backing file, avoid duplication
> of verification before bdrv_co_preadv call.
>=20
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 51 ++++++++-------------------------------------------=

>  block/qcow2.h |  3 ---
>  2 files changed, 8 insertions(+), 46 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OE8MhTMhHfuT06UBmhik8QWrkl7jWc4Hm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlowVrIACgkQp6FrSiUn
Q2oP3gf/VoVjKHb0M/iLCzTwnB4ignyYTHFY0Ya0Whuce40bZVZ4jWkgZdguWlGR
5BjvsMwbUgW+sGLtU6J2TtZnkGQHk7o6Z2HaNaw70wO9xxwpKodqd8cdeUoSTrm1
i2Wwnb4enHRg+9CKMwalKTKRwajJrwNdaDMr/wRILSO3baqdG7RkXtWlac8rulC/
lUjkaOM1+pKB8fJyH2lE77TEfr+TSuOhIwO4QHx6Tojsa9HptfGwdf9hfXDPoKmC
2uHdftr/4+wwK1PhzKEdUjMu0yoM+z0+SL+st1R0g0vWfTH8ozrXnTBeUq6a97v9
gO/3U0ZqAoEyD6TvMKnExwESScNfLg==
=HmU5
-----END PGP SIGNATURE-----

--OE8MhTMhHfuT06UBmhik8QWrkl7jWc4Hm--
