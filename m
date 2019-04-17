Received: from eggs.gnu.org ([209.51.188.92]:52897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnfC-0007u2-R3
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnfC-000231-0j
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:43:58 -0400
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-8-mreitz@redhat.com>
	<c923c1c0-e866-9bbc-f351-1c5d861d830d@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a624f61-a20c-1839-4493-f1ca62664d71@redhat.com>
Date: Wed, 17 Apr 2019 18:43:51 +0200
MIME-Version: 1.0
In-Reply-To: <c923c1c0-e866-9bbc-f351-1c5d861d830d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7uUd2WrE6Am9eYfwLP7myMEBvmLc8SM0X"
Subject: Re: [Qemu-devel] [PATCH v3 7/7] iotests: Test qemu-img convert -C
 --salvage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7uUd2WrE6Am9eYfwLP7myMEBvmLc8SM0X
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <7a624f61-a20c-1839-4493-f1ca62664d71@redhat.com>
Subject: Re: [PATCH v3 7/7] iotests: Test qemu-img convert -C --salvage
References: <20190413165343.9018-1-mreitz@redhat.com>
 <20190413165343.9018-8-mreitz@redhat.com>
 <c923c1c0-e866-9bbc-f351-1c5d861d830d@virtuozzo.com>
In-Reply-To: <c923c1c0-e866-9bbc-f351-1c5d861d830d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.04.19 10:13, Vladimir Sementsov-Ogievskiy wrote:
> 13.04.2019 19:53, Max Reitz wrote:
>> We do not support this combination (yet), so this should yield an erro=
r
>> message.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>             [only -qcow2, as -nfs -qcow2 is already broken]
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Hmm, interesting, that this test is defined as
> _supported_fmt qcow2
> _supported_proto file nfs
>=20
> And of course, it doesn't work for -qcow2 -nfs combination..

Of course, nobody ever tests nfs. :-)

Thanks for reviewing!

Max


--7uUd2WrE6Am9eYfwLP7myMEBvmLc8SM0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3V8cACgkQ9AfbAGHV
z0AZFgf/StLfuF93VjLoJ0nvwMqMFVHTXlkQNba4xjipehFm15tqHj7xvrqFVnni
4+zPUn7necsL9yqLk9Khg1bhHz/zbgJPOv7BzZYx2kL/szqqsHLDT4Ha7wgWCSqx
DECcrK1Z/6qf1aSKYBAsFeoCWrF7on8AnGqI2+5go8aJy4X56HRWUGRPtY/4+MaW
Auaf76ddIIVBNPSIYS5EcRCnI5GhlyqXDGyX3RUNB3sTs6vMz+JOb5gpyIPxILA8
z/1fxMtWQ2UJwYoyJbLLCvBZ1qwX3GHZYQUOdLJoUnFEXYEnEfsniYxLBTV75d7q
86CI14eeV3oXFZEq+e6Fm8rt1xbWzw==
=Q6xL
-----END PGP SIGNATURE-----

--7uUd2WrE6Am9eYfwLP7myMEBvmLc8SM0X--
