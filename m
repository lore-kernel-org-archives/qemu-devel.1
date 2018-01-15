Received: from eggs.gnu.org ([2001:4830:134:3::10]:55086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb6Kb-0006EP-KC
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb6KX-0004D1-CN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:05:49 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-7-vsementsov@virtuozzo.com>
	<a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
	<624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
	<fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
	<39f16940-1b62-5054-d872-80e9ce0fc560@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c228c4f2-3f4b-1898-4ae6-92b2087e73ae@redhat.com>
Date: Mon, 15 Jan 2018 09:05:24 -0600
MIME-Version: 1.0
In-Reply-To: <39f16940-1b62-5054-d872-80e9ce0fc560@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0pEI3tqW7fTJltfhBlgdMQyGFChJwLAn2"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0pEI3tqW7fTJltfhBlgdMQyGFChJwLAn2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <c228c4f2-3f4b-1898-4ae6-92b2087e73ae@redhat.com>
Subject: Re: [PATCH v2 6/6] iotest 201: new test for qmp nbd-server-remove
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-7-vsementsov@virtuozzo.com>
 <a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
 <624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
 <fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
 <39f16940-1b62-5054-d872-80e9ce0fc560@virtuozzo.com>
In-Reply-To: <39f16940-1b62-5054-d872-80e9ce0fc560@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 08:40 AM, Vladimir Sementsov-Ogievskiy wrote:

>> And the list archives show several threads of people complaining that
>> ./check failing with a diff that merely shows:
>>
>> -.....
>> +..E..
>=20
> didn't see that. usually, for failed iotests I see
>=20
> -.....
> +..E..
>=20
> + some kind of assert-fail in one of testcases

Although deciphering the assert-fail is not always trivial, and it is
still sorely underdocumented on how to manually reproduce the situation
that got to the stackdump.

>=20
> so we know in which testcase and in which line it was failed.
>=20
>>
>> makes it rather hard to see WHAT test 2 was doing that caused an error=

>> instead of a pass, let alone set up a reproduction scenario on JUST th=
e
>> failing test.=C2=A0 Yes, a lot of existing iotests use this unittest l=
ayout,
>> and on that grounds, I'm not opposed to adding another one; but test 1=
94
>> really IS easier to debug when something goes wrong.
>>
>>> And there 3 test cases, sharing same setUp. Do not you say that unitt=
est
>>> becomes
>>> deprecated in qemu? I think, if we have only one testcase, we may use=

>>> 194-like approach,
>>> but if we have more, it's better to use unittest.
>> Yes, I think a nice goal for improved testing is to write more
>> python-based iotests in the style that uses actual output, and not jus=
t
>> the unittest framework, in the test log.=C2=A0 It's not a hard require=
ment as
>> long as no one has converted existing tests, but is food for thought.
>>
>=20
> I think, it doesn't mean that we should not use unittest at all, we jus=
t
> need more output with
> it.

Yes, that's also a potentially viable option.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0pEI3tqW7fTJltfhBlgdMQyGFChJwLAn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpcwzQACgkQp6FrSiUn
Q2rwMwf/eBqqhwaEYtaxbDJCB2k5KZa37rMkHz4TyhlwLoNzNU9QBZqti30bWrc6
MPHcVieksNC/VhEvztCazG5TabZH8ynL1vKDt5XCTE3mDY5MYksl9v1BZxE+e2Ad
esaqL3+9VEgAUPOG8+05NViQRJoAW9HLZISTfnNvWB7If5i3o0HwA3oNJdXNg2LQ
htHr9gSeGg6C/rMog+Q5UP52nlzB1VfnKXnCNM5zC9qq4kz8JGpI58UF5qPY1Ed2
J/D1YmzodFJx/M0Hivm1bDiw/PsTX9fVvWAqNoZmh9zghbGD0zwJIhDKJjmWq+M9
J0KEwpxVJ6JgQ7+Ea4W+oq2FsqkbKg==
=X63i
-----END PGP SIGNATURE-----

--0pEI3tqW7fTJltfhBlgdMQyGFChJwLAn2--
