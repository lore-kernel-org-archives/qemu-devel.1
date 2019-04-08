Received: from eggs.gnu.org ([209.51.188.92]:37858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZYG-00028j-BV
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZYF-0007hE-14
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:03:28 -0400
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
Date: Mon, 8 Apr 2019 21:03:06 +0200
MIME-Version: 1.0
In-Reply-To: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: discard bitmap when removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
Subject: Re: [PATCH v2] qcow2: discard bitmap when removed
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.02.19 10:26, Andrey Shinkevich wrote:
> When a bitmap is removed, we can clean some space on the disk. The size=

> of a cluster may be larger, so is the size of the bitmap that includes
> many clusters. Some bitmaps can be as large as tens of megabytes.
> The flag QCOW2_DISCARD_ALWAYS allows a call to the raw_co_pdiscard()
> that does the actual cleaning of the image on disk, while with the flag=

> QCOW2_DISCARD_OTHER, a reference count of the cluster is updated only.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> v1: Discard old bitmap directories in QCOW2 image
>=20
> In the first version of the patch, any call to qcow2_free_clusters() in=

> block/qcow2-bitmap.c was with the flag QCOW2_DISCARD_ALWAYS, even in th=
e
> cases when the cleaned space is insignificant, particularly, in case of=

> bitmap directories.
> Discussed in the email thread with the message ID
> <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>=20
>  block/qcow2-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, changed the commit message to Vladimir=E2=80=99s proposal and app=
lied to
my block-next branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyrmusACgkQ9AfbAGHV
z0Bz1AgAobena+F9O1UAYsE+dsFEdKmtKwt31AB1+kzAZ5BMHu5y+o9eA845tAS7
tRulyBFi1jECq/QeL/Pk2voFEInfjAKs87Wx8fmLVAPnBi0yoG+5E/1zlhcYig+7
W4buiJJhC6pXkpPuzmXhpGwG547iARRBKWNjUCtTnZAaYSQjxSXCehVjLY2QZsI9
QNK7d9JN69gImQvYPg3k6ORPsU54soItUYsoS/IGX1wxVdqgqPaVkAE+t5DDgqj6
xOt2JiO4yUCladKLHExUnrkBZFeFKI84vrSTpPuj5AoRI2QxAJwfvNPlhbAJRqMq
10UA2pFF8zXJ0MRt0JzYFfyDnqR1rg==
=vVXa
-----END PGP SIGNATURE-----

--bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY--
