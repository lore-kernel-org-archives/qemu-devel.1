Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dwaAz-0004fl-HV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dwaAy-00076a-Pc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:40:25 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-12-mreitz@redhat.com>
	<23eacf8d-8f80-f912-9b77-c955f8100a5f@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <37272a30-5dd5-f5a4-8137-b4e87e8571d7@redhat.com>
Date: Mon, 25 Sep 2017 22:40:03 +0200
MIME-Version: 1.0
In-Reply-To: <23eacf8d-8f80-f912-9b77-c955f8100a5f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Brs0J46Fjlj2mSPNH8ECJH9W0KJCQanBf"
Subject: Re: [Qemu-devel] [PATCH 11/18] hbitmap: Add @advance param to
 hbitmap_iter_next()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Brs0J46Fjlj2mSPNH8ECJH9W0KJCQanBf
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <37272a30-5dd5-f5a4-8137-b4e87e8571d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/18] hbitmap: Add @advance param to
 hbitmap_iter_next()
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-12-mreitz@redhat.com>
 <23eacf8d-8f80-f912-9b77-c955f8100a5f@virtuozzo.com>
In-Reply-To: <23eacf8d-8f80-f912-9b77-c955f8100a5f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-25 17:38, Vladimir Sementsov-Ogievskiy wrote:
> 13.09.2017 21:19, Max Reitz wrote:
>> This new parameter allows the caller to just query the next dirty
>> position without moving the iterator.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/qemu/hbitmap.h |=C2=A0 4 +++-
>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 tests/test-hbitmap.c=C2=A0=C2=A0 | 26 +++++++++++++------------=
-
>> =C2=A0 util/hbitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 10 +++++++---
>> =C2=A0 4 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
>> index d3a74a21fc..6a52575ad5 100644
>> --- a/include/qemu/hbitmap.h
>> +++ b/include/qemu/hbitmap.h
>> @@ -316,11 +316,13 @@ void hbitmap_free_meta(HBitmap *hb);
>> =C2=A0 /**
>> =C2=A0=C2=A0 * hbitmap_iter_next:
>> =C2=A0=C2=A0 * @hbi: HBitmapIter to operate on.
>> + * @advance: If true, advance the iterator.=C2=A0 Otherwise, the next=
 call
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of thi=
s function will return the same result.
>=20
> it's not quit right, as hbitmap iterator allows concurrent resetting of=

> bits, and in
> this case next call may return some other result. (see f63ea4e92bad1db)=


Ah, right!  I think it should still be useful for what I (currently)
need in patch 12, I would just need a different description then.

(Like "...will return the same result (if that position is still dirty)."=
)

Max


--Brs0J46Fjlj2mSPNH8ECJH9W0KJCQanBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnJaaMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AulwH/2rVu8F4ICXkmblYjgryr4S911Ysyi8W
63ijDRQxUlDnsWcXD5Z/8PZRaCob9MUkEhJcJw+m5H2fcIbS+Zov86kIETaPNO/I
Hd7wB1xsbs6zeDrCJQtN3cKD6It0rEONM2DtQzaKjiWwp5C6ii+1cgX5I9QDLalZ
tyWf9zGaowUF74QiDvAY3AYqMrMa6Q21R96C/2SjjA3RhZJs4P4JRd3AbpMpZdoR
o0Jch8dwh58fDxlgI86R+daiHiTzzt4i83iAOPzZM1IyG+6X+8qwKsoER368sH45
WJ3k0JZGma+f7xNYQqB8Lx3hCBgdgxehm92vx3VW9KKsCHULmGagDCQ=
=HzNY
-----END PGP SIGNATURE-----

--Brs0J46Fjlj2mSPNH8ECJH9W0KJCQanBf--
