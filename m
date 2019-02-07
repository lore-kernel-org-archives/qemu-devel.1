Received: from eggs.gnu.org ([209.51.188.92]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlHk-00029P-Fz
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlHi-00088o-QU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:08:16 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca057299-6602-5513-3aa3-54fe67d7fde8@redhat.com>
Date: Thu, 7 Feb 2019 09:07:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wtshtimc8rcCAx6kEU3EFcWJmU6GTBomb"
Subject: Re: [Qemu-devel] [PATCH v3 05/17] block/commit: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wtshtimc8rcCAx6kEU3EFcWJmU6GTBomb
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <ca057299-6602-5513-3aa3-54fe67d7fde8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/17] block/commit: use
 QEMU_IOVEC_INIT_BUF
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new QEMU_IOVEC_INIT_BUF() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/commit.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wtshtimc8rcCAx6kEU3EFcWJmU6GTBomb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcScoACgkQp6FrSiUn
Q2qfQAgAiaYPlEoqzT+QXqKfulSYby/bjVKwmF5AXh+da54xtNhUn6x4VKG/anRm
75UEobSp+hbSTlB0s08p7OAOPlqUFT9GDne7qTeOe4pkUMidhGWov1KaEMgELUY4
oyLnnXttEiMYWbNg1pDHEKMD31LD/pIP+bFcaUhe91dLZ/mV9KbqaBwCK3N81/kK
nSCHzKQMEU7fj8jwt/duFefxwvyGD66u82rZWnVjChJYo04drePcD2rXBM4XpDQ0
yKRxVT7EW28jpn21MhurkXxd7k7fv+49ZNT3cYmTDdkwgXuGWw+/TRZDwAxA9YCN
82GteSyHyrktm4EGLT7yy/Xo8l6Pcg==
=KnXi
-----END PGP SIGNATURE-----

--wtshtimc8rcCAx6kEU3EFcWJmU6GTBomb--
