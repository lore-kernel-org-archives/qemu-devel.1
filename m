Received: from eggs.gnu.org ([2001:4830:134:3::10]:56494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebr1a-0002rB-FM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebr1Z-0003y8-Ik
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:57:18 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-10-mreitz@redhat.com>
	<cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
	<11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
	<cf88fa6b-f9f6-d90b-c1b4-e14111f89aba@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd57ecac-9e93-5f9a-fd37-7650c06905a6@redhat.com>
Date: Wed, 17 Jan 2018 10:56:44 -0600
MIME-Version: 1.0
In-Reply-To: <cf88fa6b-f9f6-d90b-c1b4-e14111f89aba@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZuEw0VIbXDVz5k6jn5XS1gRBV1OUrde2O"
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
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZuEw0VIbXDVz5k6jn5XS1gRBV1OUrde2O
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <dd57ecac-9e93-5f9a-fd37-7650c06905a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123020832.8165-10-mreitz@redhat.com>
 <cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
 <11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
 <cf88fa6b-f9f6-d90b-c1b4-e14111f89aba@redhat.com>
In-Reply-To: <cf88fa6b-f9f6-d90b-c1b4-e14111f89aba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 07:41 AM, Max Reitz wrote:

>>> So we lost that support in
>>> f0a9c18f9e7
>>> and
>>> 81c219ac6ce
>>>
>>> Eric, any input before we downscope your test?
>>
>> Ouch, I broke my own test.
>>
>> Maybe the best thing would be to split 177 into two tests: the origina=
l
>> test (as it was before f0a9c18) that works on both compats, and a new
>> test that works on just compat=3D1.1 images for the things added in la=
ter
>> commits.
>>
>> Since I'm the author for all commits (so far) to that file, I guess I
>> can sign up for that work...
>=20
> Did you make any progress? :-)

Ah, thanks for the reminder.  Posted as
<20180117165420.15946-1-eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ZuEw0VIbXDVz5k6jn5XS1gRBV1OUrde2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfgEwACgkQp6FrSiUn
Q2oxJAf/UXWKHznaGN9NiVrOZkrNZeQP5zPoscpnK/sQoWtIsuyygpo7uKw1U/EZ
f89aqteFdgTqHABzqAK7nv/RiU2So0+TuK9IZA46wHKGqTjBoXvwxRyQ58sDJU00
k7obU5rw5HHZJjWHHTsIXaUnUHf4n3YmHIssi4d9L5WYETXGGWHWN9bG+hxqLdro
teV9mJu70kZ5xgR5X0y9WoDWLrB33HcjSAd+Y3JwHqoL1DLqy+Zo+sIRB9Rog1O7
iSMzmDZty356OOk2r2vBORFao7V8RtCCUsJKwpaX+gEzGS4MvKKMiuQswFb9sgCJ
C9p/nLNJSnf+QarzqyG0Yq0JWPC4mQ==
=5DlN
-----END PGP SIGNATURE-----

--ZuEw0VIbXDVz5k6jn5XS1gRBV1OUrde2O--
