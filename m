Received: from eggs.gnu.org ([2001:4830:134:3::10]:42792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1casXb-0005WV-Tj
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1casXa-0003sN-PZ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:17:47 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e69c4f0f-ca4f-f3fd-18e4-3db9adb94021@redhat.com>
Date: Mon, 6 Feb 2017 17:17:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6BgRc7uCFxLVkXhjXTnFcLqTmRXs5C6P2"
Subject: Re: [Qemu-devel] [PATCH 05/18] nbd/client: fix drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6BgRc7uCFxLVkXhjXTnFcLqTmRXs5C6P2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <e69c4f0f-ca4f-f3fd-18e4-3db9adb94021@redhat.com>
Subject: Re: [PATCH 05/18] nbd/client: fix drop_sync
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Comparison symbol is misused. It may lead to memory corruption.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Adding qemu-stable; this needs to be back-ported, and can be applied
independently from your series.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 6caf6bda6d..351731bc63 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size=
)
>      char small[1024];
>      char *buffer;
> =20
> -    buffer =3D sizeof(small) < size ? small : g_malloc(MIN(65536, size=
));
> +    buffer =3D sizeof(small) > size ? small : g_malloc(MIN(65536, size=
));
>      while (size > 0) {
>          ssize_t count =3D read_sync(ioc, buffer, MIN(65536, size));
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6BgRc7uCFxLVkXhjXTnFcLqTmRXs5C6P2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmQQOAAoJEKeha0olJ0NquBsH/Aq+Pv3njVgET3t7Ae+GdYZ2
+xUQzExksKmUvNm36arR0P5mRu4iZhtrhyafFIZkVTJMfz7S6UHiSw1kNjU6urXx
MZCvHfiv7bC3Uc7X1Hsl1qYd58ja2O+avIit2KSADp/eNOaP9dQf/K03HLRZYM9w
KEa2xqAusjNyZotchdgg/yBcJx7V2C7h5T/+vN4NCEx2pfiVEM9lxQJ5Qp3BTXVf
URlGiPMsDVQz2LKXVVs9UzI9DrYeV8vmJoNw4sUYCAa6RDq32uDn7060ziqfVPOF
eES6xAxqgpd+TgwJtl+HKovKz3pVvZQGcXfKGZbcZWEz7WBm1knX9qvS//NQel8=
=OSNe
-----END PGP SIGNATURE-----

--6BgRc7uCFxLVkXhjXTnFcLqTmRXs5C6P2--
