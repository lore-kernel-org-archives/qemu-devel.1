Received: from eggs.gnu.org ([2001:4830:134:3::10]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce0uS-0000CN-QV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce0uR-0004AW-Qe
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:50:20 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-6-vsementsov@virtuozzo.com>
	<e69c4f0f-ca4f-f3fd-18e4-3db9adb94021@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6158196a-7bf4-d9e1-b66e-9cf8e734f159@redhat.com>
Date: Wed, 15 Feb 2017 08:50:05 -0600
MIME-Version: 1.0
In-Reply-To: <e69c4f0f-ca4f-f3fd-18e4-3db9adb94021@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xorau0TQuQUI6nkKI6agw2bFNL0rU8naW"
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
Cc: kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, qemu-stable <qemu-stable@nongnu.org>, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xorau0TQuQUI6nkKI6agw2bFNL0rU8naW
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com,
 qemu-stable <qemu-stable@nongnu.org>, armbru@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, jsnow@redhat.com
Message-ID: <6158196a-7bf4-d9e1-b66e-9cf8e734f159@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/18] nbd/client: fix drop_sync
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-6-vsementsov@virtuozzo.com>
 <e69c4f0f-ca4f-f3fd-18e4-3db9adb94021@redhat.com>
In-Reply-To: <e69c4f0f-ca4f-f3fd-18e4-3db9adb94021@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2017 05:17 PM, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Comparison symbol is misused. It may lead to memory corruption.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  nbd/client.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Adding qemu-stable; this needs to be back-ported, and can be applied
> independently from your series.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

For the record, this is now assigned CVE-2017-2630.  My apologies for
introducing the bug in the first place (commit 7d3123e).  The maintainer
may want to touch up the commit message to give those further details,
since it is security-related.

>=20
>>
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 6caf6bda6d..351731bc63 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t siz=
e)
>>      char small[1024];
>>      char *buffer;
>> =20
>> -    buffer =3D sizeof(small) < size ? small : g_malloc(MIN(65536, siz=
e));
>> +    buffer =3D sizeof(small) > size ? small : g_malloc(MIN(65536, siz=
e));
>>      while (size > 0) {
>>          ssize_t count =3D read_sync(ioc, buffer, MIN(65536, size));
>> =20
>>
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xorau0TQuQUI6nkKI6agw2bFNL0rU8naW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpGqdAAoJEKeha0olJ0NqSLsH/RAYXMm+PLDAUYLv6bSzlQH3
aen/ect1ipAcSDfKkjeh5/p8AJNXBmivr6iu2RB9KuRtIVCNPK9x68wnCh+PFH+p
SemQbEe3tNUUU0cpohZiwdRzxdIurUy+nqiu7QT6+kQbtsdbFAsxDIbiSEsuK1Oh
dBu/ITyehze8GjbwPiWb1X5ooODHRWqv693jMu9BSjWyYFtD0W6AgDQlnSqhCsQo
+UkKWjib7TMSPf1/E5ruWWAA2SAb0tMjKPUqA0LuwvvSt8r6DM26/M+pcQ1TL4gw
hYtSneQKz8nPLSycZ75YzXKB7FblT+boIA3eO5+/seFzrCJ58mnFE6JFo/p9Scg=
=dYe+
-----END PGP SIGNATURE-----

--xorau0TQuQUI6nkKI6agw2bFNL0rU8naW--
