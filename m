Received: from eggs.gnu.org ([2001:4830:134:3::10]:41270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxhk-0007y4-W0
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxhj-0007uc-U0
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:05:56 -0500
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
	<fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
	<b80e6451-fafe-8975-f71a-ac05f4521df8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6fbb8669-ba8d-62f8-f12c-f583a4a84049@redhat.com>
Date: Wed, 31 Jan 2018 20:05:39 +0100
MIME-Version: 1.0
In-Reply-To: <b80e6451-fafe-8975-f71a-ac05f4521df8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gh1zY9y8JLpBgIWpMH1fKJD2sekljXEcT"
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
To: John Snow <jsnow@redhat.com>, Liang Li <liliangleo@didichuxing.com>, vsementsov@virtuozzo.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gh1zY9y8JLpBgIWpMH1fKJD2sekljXEcT
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Liang Li <liliangleo@didichuxing.com>,
 vsementsov@virtuozzo.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>
Message-ID: <6fbb8669-ba8d-62f8-f12c-f583a4a84049@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hbitmap: fix missing restore count when
 finish deserialization
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
 <fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
 <b80e6451-fafe-8975-f71a-ac05f4521df8@redhat.com>
In-Reply-To: <b80e6451-fafe-8975-f71a-ac05f4521df8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-31 20:01, John Snow wrote:
>=20
>=20
> On 01/31/2018 01:54 PM, Max Reitz wrote:
>> On 2018-01-18 11:58, Liang Li wrote:
>>> The .count of HBitmap is forgot to set in function
>>> hbitmap_deserialize_finish, let's set it to the right value.
>>>
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Cc: Fam Zheng <famz@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>>> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
>>> ---
>>>  util/hbitmap.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>>> index 289778a..58a2c93 100644
>>> --- a/util/hbitmap.c
>>> +++ b/util/hbitmap.c
>>> @@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
>>>      }
>>> =20
>>>      bitmap->levels[0][0] |=3D 1UL << (BITS_PER_LONG - 1);
>>> +    bitmap->count =3D hb_count_between(bitmap, 0, bitmap->size - 1);=

>>>  }
>>> =20
>>>  void hbitmap_free(HBitmap *hb)
>>
>> Actually CC-ing John...
>>
>> (Looks good to me, though.)
>>
>> Max
>>
>=20
> Staged already, sorry. Will send the PR this Friday.
>=20
> https://github.com/jnsnow/qemu/commit/78ad6913bd34a54f658d5182990fe1496=
14d6402

OK, good. :-)

Max


--gh1zY9y8JLpBgIWpMH1fKJD2sekljXEcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyE4MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiNgIAIdiiqiikhdQPZRY0uMV1jFG2/ivmC9j
dgQJYAYGDgBVJcsqgPL/K1GojsX4pRAX/YXxgWgmg5nj3XNUDGPKL4pDo154anK0
t3JABUDWKf+8uJqgBpwLWJu436B81sB08wWhMaKA/FS7dfHnMAjzeNAAELC1fC0w
qne8tPyioWKuYBOurFGyEgeEWRyDK8Yk1Yk/Sm1O8s1KsDmLAd+KP+m8bT/gGXFj
rZjnf6hMknUAJTJrGsTIEV3ordm7nziYHVX1zzCGZOuJL7ZtJpP1UhaBYgT0lacD
bHaYZPHtKqC8YCI2fsumGLxsYOVT3aZoBTrCqcUCmzmuJt8vJpM8Ecs=
=Affs
-----END PGP SIGNATURE-----

--gh1zY9y8JLpBgIWpMH1fKJD2sekljXEcT--
