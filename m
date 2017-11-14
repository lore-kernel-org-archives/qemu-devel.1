Received: from eggs.gnu.org ([2001:4830:134:3::10]:54084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEbzl-0001LV-W0
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEbzg-00047f-TF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:15:21 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-2-mreitz@redhat.com>
	<w517eut0x8o.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <956742e0-55fb-36f4-2c9d-90f87383eaaa@redhat.com>
Date: Tue, 14 Nov 2017 15:15:00 +0100
MIME-Version: 1.0
In-Reply-To: <w517eut0x8o.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mXqDa8HBEJse8CFWqpTUqXmQCw4uTV4rs"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 1/3] qapi: Add
 qdict_is_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mXqDa8HBEJse8CFWqpTUqXmQCw4uTV4rs
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <956742e0-55fb-36f4-2c9d-90f87383eaaa@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-2-mreitz@redhat.com>
 <w517eut0x8o.fsf@maestria.local.igalia.com>
In-Reply-To: <w517eut0x8o.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 15:07, Alberto Garcia wrote:
> On Fri 10 Nov 2017 11:13:27 PM CET, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/qapi/qmp/qdict.h |  1 +
>>  qobject/qdict.c          | 10 ++++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> index fc218e7be6..c65ebfc748 100644
>> --- a/include/qapi/qmp/qdict.h
>> +++ b/include/qapi/qmp/qdict.h
>> @@ -76,6 +76,7 @@ int64_t qdict_get_try_int(const QDict *qdict, const =
char *key,
>>                            int64_t def_value);
>>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def=
_value);
>>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
>> +bool qdict_is_qnull(const QDict *qdict, const char *key);
>=20
> I found this name a bit confusing, how about something like
> qdict_entry_is_qnull() ?

Yes, that sounds better.  Thanks!

Max

> I'm fine if you want to keep it like this though,
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> Berto
>=20



--mXqDa8HBEJse8CFWqpTUqXmQCw4uTV4rs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloK+mQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4U0H/jZs4plr5MyUcHOpULJrqh1UOJFp0Roh
YVn0LhsWfus++Htnt1M4/xqnMbJ8kzhz5deSe72j5j+MWGW1hR2mbYX4i2nx4Ra1
BJxLPFvPn84VijpiJCj6c1dBO9HyRxXfBOGCm3t/vjfNxcB6e55BwS6QQFCwaubN
wAyLTI0GCD+vy5oLKQVgyg1gbBmB6DX2u7HEbI6m4ZCkdU4lEZ48w7mO1gzygqKo
N+E/5hF+BcUT3ZAZwwszhHGxYOFs8wHZ7osaMmo5TY+pbF6p3XLQPZ8DcVk3f6do
s4deXZEkMWGwmaLAlNcQua51DkJDxscNREUneGEWR4qgC1G8URpaJ4M=
=Hvhm
-----END PGP SIGNATURE-----

--mXqDa8HBEJse8CFWqpTUqXmQCw4uTV4rs--
