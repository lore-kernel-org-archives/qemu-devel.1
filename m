Received: from eggs.gnu.org ([2001:4830:134:3::10]:39853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egxe6-0005JB-2B
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egxe0-0005Sz-75
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:02:10 -0500
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
	<fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b80e6451-fafe-8975-f71a-ac05f4521df8@redhat.com>
Date: Wed, 31 Jan 2018 14:01:39 -0500
MIME-Version: 1.0
In-Reply-To: <fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ACYWsYnYIwIOVUtIQ6H6e52Gp2zjtVyUo"
Subject: Re: [Qemu-devel] [PATCH] hbitmap: fix missing restore count when
 finish deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Liang Li <liliangleo@didichuxing.com>, vsementsov@virtuozzo.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ACYWsYnYIwIOVUtIQ6H6e52Gp2zjtVyUo
From: John Snow <jsnow@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Liang Li <liliangleo@didichuxing.com>,
 vsementsov@virtuozzo.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>
Message-ID: <b80e6451-fafe-8975-f71a-ac05f4521df8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hbitmap: fix missing restore count when
 finish deserialization
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
 <fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
In-Reply-To: <fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/31/2018 01:54 PM, Max Reitz wrote:
> On 2018-01-18 11:58, Liang Li wrote:
>> The .count of HBitmap is forgot to set in function
>> hbitmap_deserialize_finish, let's set it to the right value.
>>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
>> ---
>>  util/hbitmap.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>> index 289778a..58a2c93 100644
>> --- a/util/hbitmap.c
>> +++ b/util/hbitmap.c
>> @@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
>>      }
>> =20
>>      bitmap->levels[0][0] |=3D 1UL << (BITS_PER_LONG - 1);
>> +    bitmap->count =3D hb_count_between(bitmap, 0, bitmap->size - 1);
>>  }
>> =20
>>  void hbitmap_free(HBitmap *hb)
>=20
> Actually CC-ing John...
>=20
> (Looks good to me, though.)
>=20
> Max
>=20

Staged already, sorry. Will send the PR this Friday.

https://github.com/jnsnow/qemu/commit/78ad6913bd34a54f658d5182990fe149614=
d6402


--ACYWsYnYIwIOVUtIQ6H6e52Gp2zjtVyUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+ber27ys35W+dsvQfe+BBqr8OQ4FAlpyEp4ACgkQfe+BBqr8
OQ5qEA//WGXX1pozy5mY6PFq5XCfJooOieefCuMx9d6pDFQT2zTd6nj+ySE3ZltQ
7YmZxJ2Nf+Dh3mHqzy5o5VyTqPPHhS6EzBWrrFNlohb5o/EuOdVFxni+HPcUrFLw
cHktHx66cO6pQkLEzHekgjK3izA8dl3boJ5ChmrAxYR0Fyr+X8h7bcGMet18zzVM
grHph3+W03YIoQYWY36IwoZTg6CT3qr2vuorP8mexWIz6E9SIUIdAN6pvowDIU2U
Si3o6X5ANBaQFqzLkAIwo7NPC6Al+ZPf5HrC8gXhv0JS5ifQl3/YK7FdNtjmtobg
wF4xVUGJ3hMnnbO0CAfRybzdWfKXnScb2O1y+ewqFCHdumAdwsngyHlxIG8EYoeL
ZuJ5I8HSx14J27noL6eZGSoFKFiOMcRpwkWLjKe/CYZggxlooINCqXCIkaB6uiwQ
wZ+WgWUhWuRiXo02d7Nglj6VRk5B1FFW3gs6KM0XYkF1yC+TH+9igRwAxOIkL4HJ
fjZasHBiWV9JlJsusEJe9G2UaWGzs+uMXBUA9ufHOJBoL0Vk52IXNAMW1J+geo5u
8Zbkj5P8alMDk5DaklXrSzBVTNkxu74KvXAslMZ9MSInN6y6q6zmN834kNnWh8ac
Rv8uCGMd89FB818RCn/HqlBpTLpxXC3XSS27mzgecnRYCXcuDhM=
=klRv
-----END PGP SIGNATURE-----

--ACYWsYnYIwIOVUtIQ6H6e52Gp2zjtVyUo--
