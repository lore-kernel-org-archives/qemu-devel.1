Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxBB-0005TA-Lk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fux31-0006Sz-D1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:46:00 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-8-mreitz@redhat.com>
	<w51d0u2sllv.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <926d8985-2709-b6b4-fb4b-1dd6b5fd309b@redhat.com>
Date: Wed, 29 Aug 2018 11:45:52 +0200
MIME-Version: 1.0
In-Reply-To: <w51d0u2sllv.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EHc3glLQDZlCzS3Uv7ICd10L6iIWS3l3P"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 07/31] iotests.py: Add
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EHc3glLQDZlCzS3Uv7ICd10L6iIWS3l3P
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <926d8985-2709-b6b4-fb4b-1dd6b5fd309b@redhat.com>
Subject: Re: [PATCH for-3.1 v10 07/31] iotests.py: Add node_info()
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180809213528.14738-8-mreitz@redhat.com>
 <w51d0u2sllv.fsf@maestria.local.igalia.com>
In-Reply-To: <w51d0u2sllv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-28 14:48, Alberto Garcia wrote:
> On Thu 09 Aug 2018 11:35:04 PM CEST, Max Reitz wrote:
>> This function queries a node; since we cannot do that right now, it
>> executes query-named-block-nodes and returns the matching node's objec=
t.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 5c45788dac..6583001ac8 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -465,6 +465,16 @@ class VM(qtest.QEMUQtestMachine):
>>                  else:
>>                      iotests.log(ev)
>> =20
>> +    def node_info(self, node_name, require_existence=3DTrue):
>> +        nodes =3D self.qmp('query-named-block-nodes')
>> +        for x in nodes['return']:
>> +            if x['node-name'] =3D=3D node_name:
>> +                return x
>> +        if require_existence:
>> +            assert False
>> +        else:
>> +            return None
>> +
>=20
> I don't think you need the require_existence parameter here... if you
> simply return None you'll get an error as soon as you try to use the
> return value.

Hm!  True.  I'm not sure I like the non-verbosity of "Did not find key X
in None" (or whatever error Python's going to throw), but then again,
"assert False" is not really any better.  So, yep, will change.

Thanks for reviewing,

Max


--EHc3glLQDZlCzS3Uv7ICd10L6iIWS3l3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGa1AACgkQ9AfbAGHV
z0Aa1ggAl9TQlX4NHfbpnA85n2BDZ4XSXaj0pn/jX6wAuZI/deYfdVpVwXTtl9+a
yNmMDZ6slaiP7l6F+etUYd1T9viXfjUncxMQdN25bS0Nv1GSWGFUmjRZtnkNRUwZ
yjOzio465QulM8q883IYJepKpp/AveVdWgDdWypcT1yfTbanJcUe6mBAcXCiXPvb
SffYtHzXZKUjZb2gyQsVPr7NEtxqtypdBMipUTHanWx3YUnE2hmgkwr0YnNhWlZo
g6kiQxGe3aaAUbd0a/Fiti/JNGP8Mgpo5bkB+sHd78CGUtdemMBch/7rHXsRmY/t
RYBQW+cw/olgu9P4O1ArVitnnrTgVQ==
=Q94p
-----END PGP SIGNATURE-----

--EHc3glLQDZlCzS3Uv7ICd10L6iIWS3l3P--
