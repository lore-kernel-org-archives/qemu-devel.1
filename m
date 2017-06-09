Received: from eggs.gnu.org ([2001:4830:134:3::10]:46901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJJ3X-000833-Bn
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJJ3U-00083x-8G
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:30:23 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-10-vsementsov@virtuozzo.com>
	<e45c747d-240d-4a31-8935-ae8c42af16ea@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <29231d6f-d033-593b-c47a-ca651b4efb8a@redhat.com>
Date: Fri, 9 Jun 2017 14:29:53 +0200
MIME-Version: 1.0
In-Reply-To: <e45c747d-240d-4a31-8935-ae8c42af16ea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ptkebCQXb9aTPDnjPu64PsrCqV8s0idTW"
Subject: Re: [Qemu-devel] [PATCH v20 09/30] block/dirty-bitmap: fix comment
 for BlockDirtyBitmap.disabled field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ptkebCQXb9aTPDnjPu64PsrCqV8s0idTW
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <29231d6f-d033-593b-c47a-ca651b4efb8a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v20 09/30] block/dirty-bitmap: fix comment
 for BlockDirtyBitmap.disabled field
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-10-vsementsov@virtuozzo.com>
 <e45c747d-240d-4a31-8935-ae8c42af16ea@redhat.com>
In-Reply-To: <e45c747d-240d-4a31-8935-ae8c42af16ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 23:02, John Snow wrote:
>=20
>=20
> On 06/02/2017 07:21 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/dirty-bitmap.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 90af37287f..f25428868c 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -42,7 +42,8 @@ struct BdrvDirtyBitmap {
>>      BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen st=
atus */
>>      char *name;                 /* Optional non-empty unique ID */
>>      int64_t size;               /* Size of the bitmap (Number of sect=
ors) */
>> -    bool disabled;              /* Bitmap is read-only */
>> +    bool disabled;              /* Bitmap is disabled. It skips all w=
rites to
>> +                                   the device */
>=20
>=20
> Or, "Bitmap is disabled. Writes to the device are ignored." or similar.=


I'd like "It ignores all writes to the device" the most. :-)

("Writes are ignored" sounds a bit like they are ignored in general, not
just by this bitmap; and "it skips" just sounds a bit weird.)

> It's not very important.

Discussing the non-important stuff is the most fun!

Reviewed-by: Max Reitz <mreitz@redhat.com>

> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
>>      int active_iterators;       /* How many iterators are active */
>>      QLIST_ENTRY(BdrvDirtyBitmap) list;
>>  };
>>



--ptkebCQXb9aTPDnjPu64PsrCqV8s0idTW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOpTBEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQHOH
B/9/L9/279Dmek/mOItH/BzT/e4PQ1PxrmoSXTAVDKRW0zwykO9Gl8ym4QKe0k/8
M4zlet15Uuds/9f6rPm59OnCuGJOajcvCZZcgKsd7EYpWCqaNdepvJ7mAKDwlOnn
lgXBuBaYckrZYraYHqoKNUn/BBuqfaZSD7UOdjzIxiHW3daWz+QYiQKIg6elvnnr
tkHtWkQfz1KQGApoL+9uQ4NBpqUfZAGgB1eRtgnBuMEBjn2/Z9XgyNIvAfHp0wG8
vNMJJdL5k47tdqdzdlybN5HvbWQIYhzizW0Q24/QustKb0krZB8cPxcTkWV/dFWF
EBnjfenuG9hClTTLvX5px89o
=qHs/
-----END PGP SIGNATURE-----

--ptkebCQXb9aTPDnjPu64PsrCqV8s0idTW--
