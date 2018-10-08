Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9beR-00036i-Kt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9beQ-0002AV-Ut
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:57:11 -0400
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-8-mreitz@redhat.com>
	<d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <de892465-6f19-defc-c726-6e1bcf2ccbba@redhat.com>
Date: Mon, 8 Oct 2018 21:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yEvFJYjwxGFME4TXbooHMn52Or634aZN0"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v11 07/31] iotests.py: Add
 node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yEvFJYjwxGFME4TXbooHMn52Or634aZN0
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <de892465-6f19-defc-c726-6e1bcf2ccbba@redhat.com>
Subject: Re: [Qemu-block] [PATCH v11 07/31] iotests.py: Add node_info()
References: <20181005234023.8104-1-mreitz@redhat.com>
 <20181005234023.8104-8-mreitz@redhat.com>
 <d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
In-Reply-To: <d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 21:34, John Snow wrote:
>=20
>=20
> On 10/05/2018 07:39 PM, Max Reitz wrote:
>> This function queries a node; since we cannot do that right now, it
>> executes query-named-block-nodes and returns the matching node's objec=
t.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 5c45788dac..604f200600 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -465,6 +465,13 @@ class VM(qtest.QEMUQtestMachine):
>>                  else:
>>                      iotests.log(ev)
>> =20
>> +    def node_info(self, node_name):
>> +        nodes =3D self.qmp('query-named-block-nodes')
>> +        for x in nodes['return']:
>> +            if x['node-name'] =3D=3D node_name:
>> +                return x
>> +        return None
>> +
>> =20
>>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>> =20
>>
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> Do we ever want to revisit the idea that our API should not do any
> pre-filtering and that it's always up to the client to do so?

I mean we certainly want to revisit the idea that we should have a
proper query API.

But what exactly do you mean by pre-filtering?

Max


--yEvFJYjwxGFME4TXbooHMn52Or634aZN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7towACgkQ9AfbAGHV
z0BVOwgAwbxXeIEG7MOBHKqhJ0XLXTEWgZcBiHPtE2/RN5Vq39/k4O44n32erKe2
+RwthNJ9IqIDGmZW56lpBeCNSa2LXjzeYlLnUT+C4p2jZYo4lHshkwjMgmsW6z3X
FLJ8km8K5d9YNDWkqSUV+nW2025F0j9xywvJKCKfTkmlcQ9TprnUPLkEzqbGHF2R
NL9oFmvIiIeyCBz4RR7SimXaQS0BsmaNVKSD6Gry5gJ8M1ka6toPuIWq9Y3AbEUv
kub9JCa1FiAKQV4pokSkoA4yTYVK/T8+lVAGlbjBn7uYU3mj5doXCDNxXEQhhEfv
TFpySgKP6INh7FiNbx9OvluEPbv8fQ==
=V1NP
-----END PGP SIGNATURE-----

--yEvFJYjwxGFME4TXbooHMn52Or634aZN0--
