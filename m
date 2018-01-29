Received: from eggs.gnu.org ([2001:4830:134:3::10]:49977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egF4o-0006lP-UJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egF4o-0006Tp-0q
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:26:46 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
	<3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
Date: Mon, 29 Jan 2018 13:26:38 -0600
MIME-Version: 1.0
In-Reply-To: <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T8GUEbQTEq4S2cbjqQ3gFJoetqWClsFjQ"
Subject: Re: [Qemu-devel] [PATCH v7 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T8GUEbQTEq4S2cbjqQ3gFJoetqWClsFjQ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov
 <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 berto@igalia.com
Message-ID: <563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
Subject: Re: [PATCH v7 1/9] mirror: inherit supported write/zero flags
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
 <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
In-Reply-To: <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/29/2018 01:21 PM, Max Reitz wrote:
> On 2018-01-18 18:48, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/mirror.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index c9badc1..d18ec65 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1064,6 +1064,11 @@ static void bdrv_mirror_top_refresh_filename(Bl=
ockDriverState *bs, QDict *opts)
>>      bdrv_refresh_filename(bs->backing->bs);
>>      pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
>>              bs->backing->bs->filename);
>> +    bs->supported_write_flags =3D BDRV_REQ_FUA &
>> +        bs->backing->bs->supported_write_flags;
>> +    bs->supported_zero_flags =3D
>> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
>> +        bs->backing->bs->supported_zero_flags;
>>  }
>> =20
>>  static void bdrv_mirror_top_close(BlockDriverState *bs)
>=20
> Fundamentally OK, but why is this in *_refresh_filename()?

Indeed, I missed that (or maybe it got moved during a botched rebase?).
For comparison, blkdebug sets it during blkdebug_open(), and nbd sets it
during nbd_client_init() (called during nbd_open()).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--T8GUEbQTEq4S2cbjqQ3gFJoetqWClsFjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpvdW4ACgkQp6FrSiUn
Q2qBZwgApMZv4I+JzZGPwuUVoo0+iB/SFjat53LzKSf1mlx/Aa90SA+hRqQ4yQ7V
3nIyTFQvf+WXnBP1HXmrpGnbocyamgs0Xa4HV/+mEThqo++DSwKTRXtPz4kJzhH+
bcYYAlwlEEvLmSw3YANwx9hjiIgfXj28cT6DZqcvb6I/8yFV3YKu22Ea78ACUKtE
GkOYpt1CMieOULYG8el9XvVENxSHKgRp/d61E5jDdRJrH9ikAD9wM7nxh2+PjAW5
ulOpnZvjydowKTWjy4Hc02ttB2UNT0IAO0+FD5wCbXby5BjVPThW/ngdILjsrq6H
pDfrqijD6hIGGiojH77zW30u3G9Txw==
=Fy8C
-----END PGP SIGNATURE-----

--T8GUEbQTEq4S2cbjqQ3gFJoetqWClsFjQ--
