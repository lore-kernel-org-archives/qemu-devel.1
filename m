Received: from eggs.gnu.org ([209.51.188.92]:37626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopqU-00029X-BZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopqR-0007KO-NO
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:24:02 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-7-mreitz@redhat.com>
	<d1590928-5836-6630-ca30-02ee9d5c6efd@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c47ce928-de73-f333-efdc-cc8f412cd746@redhat.com>
Date: Wed, 30 Jan 2019 14:23:47 +0100
MIME-Version: 1.0
In-Reply-To: <d1590928-5836-6630-ca30-02ee9d5c6efd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M7A6mHMuGjVjs1d5FgU5jSQGO5wgmSSDy"
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests.py: Add is_str()
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
--M7A6mHMuGjVjs1d5FgU5jSQGO5wgmSSDy
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c47ce928-de73-f333-efdc-cc8f412cd746@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests.py: Add is_str()
References: <20190123144610.8842-1-mreitz@redhat.com>
 <20190123144610.8842-7-mreitz@redhat.com>
 <d1590928-5836-6630-ca30-02ee9d5c6efd@redhat.com>
In-Reply-To: <d1590928-5836-6630-ca30-02ee9d5c6efd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.19 22:35, John Snow wrote:
>=20
>=20
> On 1/23/19 9:46 AM, Max Reitz wrote:
>> Strings can have various representations, this helper function checks
>> whether a given value is in any of them.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index f51456fa63..29e4e3306f 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -221,6 +221,12 @@ def image_size(img):
>>      r =3D qemu_img_pipe('info', '--output=3Djson', '-f', imgfmt, img)=

>>      return json.loads(r)['virtual-size']
>> =20
>> +def is_str(val):
>> +    if sys.version_info.major >=3D 3:
>> +        return isinstance(val, str) or isinstance(val, bytes)
>> +    else:
>> +        return isinstance(val, str) or isinstance(val, unicode)
>> +
>=20
> conflating bytes with strings under a function named "is_str()" makes m=
e
> nervous, but... I have no concrete objections beyond hypothetically
> "What if people take this function name literally?"

Hm.  Well, the strings from 2.x are byte strings in 3.x, so.

But then there's this:

$ python2
[...]
>>> 'foo'.replace('f', 'g')
'goo'
>>> u'foo'.replace('f', 'g')
u'goo'

$ python3
[...]
>>> 'foo'.replace('f', 'g')
'goo'
>>> b'foo'.replace('f', 'g')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: a bytes-like object is required, not 'str'

So that just doesn't work for the next patch.  How about I just drop the
bytes test and if at some point someone feels the need to add it, we can
think about it again?

Max

> *prays for 2.x support to get dropped*
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20



--M7A6mHMuGjVjs1d5FgU5jSQGO5wgmSSDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxRpWMACgkQ9AfbAGHV
z0CADggAvPPGrP4OSFG4/a4d36GOOC/AgbNDqLOoa1RW5HLKc9U9e9gmJ2jtv7BV
GffOR+vsUgtWUJxZGnq2XloT+IIJe123lQwh8ZHnuSLWUPNgQ5/etvAgU+E1qV+N
q3ZFZZqzzJnWiW/owPqwvv1d//Uo36UtURZP64UhGISj5dGpyjGj/da21fiazbeX
A9p+16WOeV/74NNeJoRXBc7raH4QwIx08v8Loy5FTgWtqCDmvc31m7ifzeAw7QBO
9OyajEzqloP/Vss3p/0ggovkf3fIusD8PBdjADO2pOT4ajqIGifuAT2yNUoOHfJW
hl6RxqSGhVI6nRnZcGskJjUV1sHUGg==
=u3K6
-----END PGP SIGNATURE-----

--M7A6mHMuGjVjs1d5FgU5jSQGO5wgmSSDy--
