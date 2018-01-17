Received: from eggs.gnu.org ([2001:4830:134:3::10]:53085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnyu-0002Vb-TZ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnyu-000585-6Z
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:42:20 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-10-mreitz@redhat.com>
	<cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
	<11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cf88fa6b-f9f6-d90b-c1b4-e14111f89aba@redhat.com>
Date: Wed, 17 Jan 2018 14:41:57 +0100
MIME-Version: 1.0
In-Reply-To: <11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="akk1Zoh3oAR1D7MQsgVcJaHRk2XdjHFeo"
Subject: Re: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--akk1Zoh3oAR1D7MQsgVcJaHRk2XdjHFeo
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <cf88fa6b-f9f6-d90b-c1b4-e14111f89aba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123020832.8165-10-mreitz@redhat.com>
 <cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
 <11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
In-Reply-To: <11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-09 17:53, Eric Blake wrote:
> On 12/08/2017 07:46 PM, John Snow wrote:
>>
>>
>> On 11/22/2017 09:08 PM, Max Reitz wrote:
>>> Tests 080, 130, 137, and 176 simply do not work with compat=3D0.10 fo=
r the
>>> reasons stated there.
>>>
>>> 177 is a bit more interesting:  Originally, it was actually very much=

>>> intended to work with compat=3D0.10 (it even had a special case for t=
hat).
>>> However, it now prints the test image's map twice, and short of just =
not
>>> doing that, there is no solution I can imagine that is both simple an=
d
>>> would leave compat=3D0.10 support intact.
>>>
>>
>> So we lost that support in
>> f0a9c18f9e7
>> and
>> 81c219ac6ce
>>
>> Eric, any input before we downscope your test?
>=20
> Ouch, I broke my own test.
>=20
> Maybe the best thing would be to split 177 into two tests: the original=

> test (as it was before f0a9c18) that works on both compats, and a new
> test that works on just compat=3D1.1 images for the things added in lat=
er
> commits.
>=20
> Since I'm the author for all commits (so far) to that file, I guess I
> can sign up for that work...

Did you make any progress? :-)

Max


--akk1Zoh3oAR1D7MQsgVcJaHRk2XdjHFeo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpfUqUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGKYH/AtXoRng/0v+qNxHHoSpZnV58eWayzgQ
njpEckjKOAhWBfIouBW5VIzdRZSJux2EJ5FSiIjNU+91QbcDKOiOkKtKO5UR38+T
LXctfPNAIlNI8xAs0oHUxG+VDlpXtJxdguAfkWj7LAiRRgucp7m+k7XrjfBrzadE
au+InBc57SJMQq3YyA7Ay31hRoB3Q49Cl7vvZ1dlBEmhSRVZNbFCefrldEo++eQc
ZGHP4FIW+n/jEoXOMcYAwQr9k2mdWq25KXZJn2YGxZnkw7PI6hBx5yT65Cjxs7W/
NwpUSIfvsrrHNfQNxErnXf6ALpijtt56zl9DdcboCz4SdvA/relgArQ=
=LzOJ
-----END PGP SIGNATURE-----

--akk1Zoh3oAR1D7MQsgVcJaHRk2XdjHFeo--
