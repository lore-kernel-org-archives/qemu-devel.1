Received: from eggs.gnu.org ([2001:4830:134:3::10]:56376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egDpd-0001By-4t
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egDpc-0002Dq-8A
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:07:01 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
	<ce7c11c5-bb34-fc54-308e-9f4ade6237fb@redhat.com>
	<20180129180608.GP6141@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d41a659b-29b4-2cf0-cef8-dacb30955d71@redhat.com>
Date: Mon, 29 Jan 2018 19:06:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180129180608.GP6141@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mKx28iaoL2sIMUhrS434giGm9G7OimPV6"
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mKx28iaoL2sIMUhrS434giGm9G7OimPV6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <d41a659b-29b4-2cf0-cef8-dacb30955d71@redhat.com>
Subject: Re: [RFC PATCH 02/10] block/qapi: Add qcow2 create options to schema
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-3-kwolf@redhat.com>
 <ce7c11c5-bb34-fc54-308e-9f4ade6237fb@redhat.com>
 <20180129180608.GP6141@localhost.localdomain>
In-Reply-To: <20180129180608.GP6141@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-01-29 19:06, Kevin Wolf wrote:
> Am 29.01.2018 um 17:57 hat Max Reitz geschrieben:
>> On 2018-01-11 20:52, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 1749376c61..9341f6708d 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3320,6 +3320,37 @@
>>>  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
>>> =20
>>>  ##
>>> +# @BlockdevQcow2CompatLevel:
>>> +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (ve=
rsion 2)
>>> +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (ver=
sion 3)
>>> +#
>>> +# Since: 2.10
>>> +##
>>> +{ 'enum': 'BlockdevQcow2CompatLevel',
>>> +  'data': [ '0_10', '1_1' ] }
>>
>> Just my two cents: I'd prefer 2 and 3 because I've never quite liked
>> that people are supposed to remember some pretty random qemu version
>> numbers anyway.
>=20
> Yeah. An enum with '2' and '3' wouldn't work for Eric's desire to have
> enum values starting in letters, though. I was originally planning to
> replace it with an int, but then it's not introspectable.

Aw.

> An enum with 'v2' and 'v3' then?

Would work for me.

Max


--mKx28iaoL2sIMUhrS434giGm9G7OimPV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvYr0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIfYH/2ZLruaWPoTvwd+9wLcXNnOkh+aPcwAA
QflummertjFoucjERsTaa07ltYfqrkQuLfWgzl1glAJGbk1VLCvAxWkNI0ZmLjrv
2oT5Nwf4cen2iQtVCLcfBjoB/ASt2s47MyBUu5xY1sD8JoowAvh7zcWcf60uTszg
7XC+dY9Qcw2hocgp5p0HeKrSYMQRw0dbEdHODFqBC1icla58dmBXrzvs8jjQD4Mb
F65Cj1qzX761UFk5YVhLmOq8WMFkghYHSJPJnV+mWDfO45DDUzP1VMmogigDy4aL
f2luuQBQObNJaDZ+awXx8sWiz37ub6mXO8OIJcfdbcCrcNoWLepsn+U=
=XUKN
-----END PGP SIGNATURE-----

--mKx28iaoL2sIMUhrS434giGm9G7OimPV6--
