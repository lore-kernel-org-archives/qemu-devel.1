Received: from eggs.gnu.org ([209.51.188.92]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl4o-0000eD-KT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl4n-0007IS-CJ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:54:54 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <783d7c00-6f3d-9c7d-3439-7b14383050b5@redhat.com>
Date: Thu, 7 Feb 2019 08:54:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5BjeYP9cicn24sHxqDzEDua9gcgRKSoS"
Subject: Re: [Qemu-devel] [PATCH v3 03/17] block/block-backend: use
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
--D5BjeYP9cicn24sHxqDzEDua9gcgRKSoS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <783d7c00-6f3d-9c7d-3439-7b14383050b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/17] block/block-backend: use
 QEMU_IOVEC_INIT_BUF
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new QEMU_IOVEC_INIT_BUF() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-backend.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D5BjeYP9cicn24sHxqDzEDua9gcgRKSoS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcRqcACgkQp6FrSiUn
Q2p/zwgArJhJWl79+Np0fuR1UHjKRaUNljlbDhWfdiHShK5Eik9SSpsSL6W+gd/i
ogJwLBJFR7kRp6qaEN0qYepshzMLoOLqBeSie0O7tljpve6uWFvr9vg/+aNLnvqh
ZsPUo3ZqYwWgDx8CIZE/QRCSkpxZq/gGMniSSYWP0ylu6w1iA6Xw6iAmyf4L0xh0
ny9/f4y8FSaY64mb42Ftr5DDBNXdG/16Mho5zJG3xImWt/1HeeVt0iJhCLWL5Dm8
amM0eewCevtnqmuKrbiLwKhPVYkdBOKKJ/S73Jzx1ZGOJNqXF3di5BuTqeiQOoaD
qYwZR0qhRNvwgPT8FCCYTS93xMpY/Q==
=dMPz
-----END PGP SIGNATURE-----

--D5BjeYP9cicn24sHxqDzEDua9gcgRKSoS--
