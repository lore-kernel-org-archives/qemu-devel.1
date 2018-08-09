Received: from eggs.gnu.org ([2001:4830:134:3::10]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnp8Q-00067Z-Jl
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnp8P-000371-Ql
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:54:06 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-8-mreitz@redhat.com>
	<w51wot28c55.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ec759067-a8af-8f7c-7d85-ed6bed37398a@redhat.com>
Date: Thu, 9 Aug 2018 19:53:55 +0200
MIME-Version: 1.0
In-Reply-To: <w51wot28c55.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8K1t7X7R6bPSS5UFjinDCeNXX8D5Y8bxG"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 07/31] iotests.py: Add
 node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8K1t7X7R6bPSS5UFjinDCeNXX8D5Y8bxG
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ec759067-a8af-8f7c-7d85-ed6bed37398a@redhat.com>
Subject: Re: [Qemu-block] [PATCH v9 07/31] iotests.py: Add node_info()
References: <20180628000745.4477-1-mreitz@redhat.com>
 <20180628000745.4477-8-mreitz@redhat.com>
 <w51wot28c55.fsf@maestria.local.igalia.com>
In-Reply-To: <w51wot28c55.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-07 16:49, Alberto Garcia wrote:
> On Thu 28 Jun 2018 02:07:21 AM CEST, Max Reitz wrote:
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
>> index 5c45788dac..3b18907f6a 100644
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
>> +        assert False
>> +
>=20
> There are cases in which you want to verify that a node doesn't exist
> anymore (e.g. after you have removed it), so it would be nice to return=

> None if the node doesn't exist.

Can do (and then maybe add a wrapper function that aborts if the node
doesn't exist).

Thanks for reviewing!

Max

> I actually have a similar function (minus the "return None" part) in on=
e
> of my tests from the blockdev-reopen series, so I could make use of thi=
s
> one instead.
>=20
> Berto
>=20



--8K1t7X7R6bPSS5UFjinDCeNXX8D5Y8bxG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltsf7MACgkQ9AfbAGHV
z0Br4ggAp5BA/sjU5hkEhXkqAQX954/ZcIAYADjaXIFzTj6P/DXAaTndo5qK3I0q
mVJANq6PjznEnWp65KIaUnrRlqXYUbVAHR6mHbOGM5ATpxWYVHdUeKjzBk8br8+7
UEMYBrE4dKlEauym8vBUa7jcUca7IiiJOpCa5L1eaJ6BxeL1AeIKlUkubn35cB6K
aaWbYLCdreHA0cHLq+Wj5Z8gmQT+6h9eti3z1A2tbMXukRra10qNV/FvLAkUcwYw
MIIfXQobVcEP2TV7ncwAGf0oheaEBzWe3rrM+9I2g6Uu37b+tABLGHIg9xVkOomi
WZMYLyY8K4414/CoMKp6JomzOgx4aQ==
=vIRO
-----END PGP SIGNATURE-----

--8K1t7X7R6bPSS5UFjinDCeNXX8D5Y8bxG--
