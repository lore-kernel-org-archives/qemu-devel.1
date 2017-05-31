Received: from eggs.gnu.org ([2001:4830:134:3::10]:38547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG6B8-0004ud-Vz
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG6B8-0005IM-26
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:08:58 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-3-berrange@redhat.com>
	<f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
	<73621dcd-ace7-c7fa-8dd2-701ea7d6d249@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <651dfffa-b953-4879-06bb-2affb39bdcef@redhat.com>
Date: Wed, 31 May 2017 18:08:47 +0200
MIME-Version: 1.0
In-Reply-To: <73621dcd-ace7-c7fa-8dd2-701ea7d6d249@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1UKEi3r0GcsLW85qurTmvUhF5alKFrdqW"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] iotests: fix remainining tests to
 work with LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1UKEi3r0GcsLW85qurTmvUhF5alKFrdqW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <651dfffa-b953-4879-06bb-2affb39bdcef@redhat.com>
Subject: Re: [PATCH v5 2/5] iotests: fix remainining tests to work with LUKS
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-3-berrange@redhat.com>
 <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
 <73621dcd-ace7-c7fa-8dd2-701ea7d6d249@redhat.com>
In-Reply-To: <73621dcd-ace7-c7fa-8dd2-701ea7d6d249@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-31 17:59, Eric Blake wrote:
> On 05/31/2017 10:33 AM, Max Reitz wrote:
>> On 2017-05-09 19:33, Daniel P. Berrange wrote:
>>> The tests 033, 140, 145 and 157 were all broken
>>> when run with LUKS, since they did not correctly use
>>> the required image opts args syntax to specify the
>>> decryption secret. Further, the 120 test simply does
>>> not make sense to run with luks, as the scenario
>>> exercised is not relevant.
>>>
>>> The test 181 was broken when run with LUKS because
>>> it didn't take account of fact that $TEST_IMG was
>>> already in image opts syntax. The launch_qemu
>>> helper also didn't register the secret object
>>> providing the LUKS password.
>=20
>>> =20
>>> +if test "$IMGOPTSSYNTAX" =3D "true"
>>> +then
>>> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,$TEST_IMG
>>
>> I would like to propose wrapping this (or at least $TEST_IMG) in quote=
s,
>=20
> Makes no difference in assignment context (other than consistency that
> it's an easier rule to always quote even when not necessary, than it is=

> to remember which contexts don't need quoting).
>=20
>> but I'm aware of the fact that the whole test environment breaks if yo=
u
>> have a TEST_DIR with whitespace in it, so I don't mind...
>>
>> (But it is a bit weird to put $TEST_IMG into quotes below and then use=

>> $SYSEMU_DRIVE_ARG unquoted.)
>=20
> Assigning to SYSEMU_DRIVE_ARG without quotes works even if TEST_IMG
> contains spaces, but expanding SYSEMU_DRIVE_ARGS without quotes indeed
> breaks (whether or not you assigned with quotes).

Interesting, thanks. (I only knew that foo=3D$bar worked.)

Max


--1UKEi3r0GcsLW85qurTmvUhF5alKFrdqW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLuqQEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCve
B/4vsPhGvSS6JvDHjVncYAu1hpSO5twF2Kp+sPITiWTbvNrkToik5eSvVSXsVVkr
yZmWxmctRYj4hgO15qugnXHkMbf5Hi8+Q0een4jHz1wiU1vkjF5ajP2410krhHx4
yOK8MTh0ff8KLGjKRGTl4nLNVroZZjiHy+P+Ebspujl9GTiDN4ERO34HWYhFSzMm
m60B3Yss4BBnGqQPo//gPdXf739eStRA9EragNBNlI1Sah29XwE8OPOPTTqgFwuG
YdoduCnEtZWwxrV1oiP2rkpu/koqfnHiWHFKOyXeSOhWnnjvsDvMB6XufB9g1h6R
e9zLV4ySaClVeqty7lsAHuwi
=uT3p
-----END PGP SIGNATURE-----

--1UKEi3r0GcsLW85qurTmvUhF5alKFrdqW--
