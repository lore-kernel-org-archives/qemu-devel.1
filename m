Received: from eggs.gnu.org ([2001:4830:134:3::10]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capMj-0004FE-F1
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capMi-0006ke-Pu
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:54:21 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cac924a-44a7-116c-3d20-f37fe4ece46e@redhat.com>
Date: Mon, 6 Feb 2017 13:54:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NVX1jkdrSN7KIxgisRJpDe4jAopWxVohJ"
Subject: Re: [Qemu-devel] [PATCH 01/18] nbd: rename NBD_REPLY_MAGIC to
 NBD_SIMPLE_REPLY_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NVX1jkdrSN7KIxgisRJpDe4jAopWxVohJ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <8cac924a-44a7-116c-3d20-f37fe4ece46e@redhat.com>
Subject: Re: [PATCH 01/18] nbd: rename NBD_REPLY_MAGIC to
 NBD_SIMPLE_REPLY_MAGIC
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> To be consistent when NBD_STRUCTURED_REPLY_MAGIC will be introduced.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c                             | 4 ++--
>  nbd/nbd-internal.h                       | 2 +-
>  nbd/server.c                             | 4 ++--
>  tests/qemu-iotests/nbd-fault-injector.py | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)

Mechanical, and makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NVX1jkdrSN7KIxgisRJpDe4jAopWxVohJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmNRlAAoJEKeha0olJ0NqhMIH/jc//TEQrzN1Yb6wsDqdgToU
07koMvioYQakJNV5OI7jcVow40vMhnHM1gX13c6Ck2Axb0AkuIR1CwWlRxwlTdGk
/OupsZfguXsL5rit3FkckHM0lcx6+sQqJ8V1M4hb9McgxHjcQazGxqCVHUAgSv8i
/XBhTcrRPHJng2cg3aQF1tOwOlkWxM/YeIIslxvhcGCVuUvHn7ujSWlzQ60Ec5AG
fi1n76OiAWa5d7NrEzena69Xwb0mCO39dQO5j88UH8GkMgTe/StF56BrzjK2MXcS
CmOh/Du/jC0fqp8xXaI3kzusycwx2smZHI6oLSkxhP0cV63KJKQ1VnNjG8rmaco=
=AKya
-----END PGP SIGNATURE-----

--NVX1jkdrSN7KIxgisRJpDe4jAopWxVohJ--
