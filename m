Received: from eggs.gnu.org ([2001:4830:134:3::10]:54363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCY5-0001xL-Q5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCY0-0007Rt-Rc
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:13:45 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-9-mreitz@redhat.com>
	<ba5e8366-e549-5611-b161-1710fc2f95b5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2418987f-17d1-7025-5e83-e46d87cdc322@redhat.com>
Date: Fri, 11 May 2018 20:13:35 +0200
MIME-Version: 1.0
In-Reply-To: <ba5e8366-e549-5611-b161-1710fc2f95b5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NtUmwsP6K9oTvjCKzFfGatpLCSkMz4Urq"
Subject: Re: [Qemu-devel] [PATCH 08/13] tests: Add
 qdict_stringify_for_keyval() test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NtUmwsP6K9oTvjCKzFfGatpLCSkMz4Urq
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <2418987f-17d1-7025-5e83-e46d87cdc322@redhat.com>
Subject: Re: [PATCH 08/13] tests: Add qdict_stringify_for_keyval() test
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-9-mreitz@redhat.com>
 <ba5e8366-e549-5611-b161-1710fc2f95b5@redhat.com>
In-Reply-To: <ba5e8366-e549-5611-b161-1710fc2f95b5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-10 18:02, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/check-qdict.c | 54
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 54 insertions(+)
>>
>=20
>> +static void qdict_stringify_for_keyval_test(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 QDict *dict =3D qdict_new();
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Test stringification of:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "a": "null",
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "b": 42,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "c": -23,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "d": false,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "e": null,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "f": "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "g": 0.5,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "h": 0xfffffffffff=
fffff,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "i": true,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "j": 0
>=20
> Is it worth testing fun things like '-0.0'?

Sure, why not.  Maybe even infinity, although I'm not quite sure the
input visitor can handle it...
>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "a"), "null")=
);
>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "b"), "42"));=

>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "c"), "-23"))=
;
>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "d"), "off"))=
;
>> +=C2=A0=C2=A0=C2=A0 g_assert(qobject_type(qdict_get(dict, "e")) =3D=3D=
 QTYPE_QNULL);
>=20
> Is it worth shortening this line to:
> g_assert(qobject_to(QNull, qdict_get(dict, "e")));

I think explicitly checking the type is a bit more expressive.

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>


--NtUmwsP6K9oTvjCKzFfGatpLCSkMz4Urq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr13U8ACgkQ9AfbAGHV
z0D5rwf/XlT+AJp9KYdl+v1JPhNFzmX1UfgaHzUdbwD83lzDcIp2wh5BS5XF1lL5
ZU9qcoWBs8fEJwafjQ17HTCraA+PDR3GjEZl1gNct8CIqNIvYbuN3UC3WVv5cLVk
xVatHoB9/4RmVVOjey4cPhcPU2DuU2VfNzBqtDQbyoKVfJgginMg9NWwsiPm7wr5
JuK9mjXfICX+IPQkl8994ThD8iJ+1q1F4llJbMqZ7dzX4qc6haB2Ewyi8O+jh0ja
wZjpwMVq8EMBlxC//RwbYraBtiHPA+ZU/wSjZE7Nsz6e2ZRQtCX8+tBMk8oUFMov
umr3LiCuBsHXrFk3ZBghdQnoyIQKHQ==
=C28n
-----END PGP SIGNATURE-----

--NtUmwsP6K9oTvjCKzFfGatpLCSkMz4Urq--
