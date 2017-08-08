Received: from eggs.gnu.org ([2001:4830:134:3::10]:50037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df66R-0002C1-Gm
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df66Q-0003Fb-94
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:07:27 -0400
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
	<20170807155717.GI6578@localhost.localdomain>
	<692a163e-acce-e594-896d-da96b7a099e9@virtuozzo.com>
	<20170808085352.GF4850@dhcp-200-186.str.redhat.com>
	<896f8482-6e3a-13e9-4cce-ca115a6c8881@virtuozzo.com>
	<645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51899b88-6b4b-88ce-f820-f62bc944c034@redhat.com>
Date: Tue, 8 Aug 2017 10:07:17 -0500
MIME-Version: 1.0
In-Reply-To: <645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XbNOofo9GlRgxEidsRrFhCqcIkRvhpwL6"
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XbNOofo9GlRgxEidsRrFhCqcIkRvhpwL6
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <51899b88-6b4b-88ce-f820-f62bc944c034@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
 <20170807155717.GI6578@localhost.localdomain>
 <692a163e-acce-e594-896d-da96b7a099e9@virtuozzo.com>
 <20170808085352.GF4850@dhcp-200-186.str.redhat.com>
 <896f8482-6e3a-13e9-4cce-ca115a6c8881@virtuozzo.com>
 <645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
In-Reply-To: <645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 04:04 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> Throttling "guaranties" that there will not be more than one
>>>> request. But
>>>> what prevent less than one, i.e. zero, like in my reproduction?
>>> Yes, I understand. Can we somehow make sure that at least one iterati=
on
>>> is made? I'd really like to keep the functional test for block job
>>> throttling. I suppose a simple 'sleep 0.1' would do the trick, though=

>>> it's not very clean.
>>>
>>> Kevin
>>
>>
>> I've started with 'sleep 0.5', now there are >100 successful
>> iterations... The other way is to check in test that there was 0 or 1
>> requests, but for this it looks better to rewrite it in python.
>>
>>
>=20
> is sleep for ms portable?

Sadly, sub-second sleep is a GNU coreutils feature; I suspect the BSD
machines may fail to parse it.  (Of course, we could do some sort of
'sleep $SMALL', where $SMALL is 0.5 if sleep supports it, and 1 otherwise=
).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XbNOofo9GlRgxEidsRrFhCqcIkRvhpwL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ06UACgkQp6FrSiUn
Q2qyxgf8DfKxjP1JH8Bh45kJ/Tf9KVbVte+jlBu3dibNFaSGsRoHvlq+l3Xq6DIT
xxcmPB+eqTn0OD1+5xzPJyJ4c4w4mdC9619vyKFi6Z6B5VqMXJaHftmM8nvaju9F
pJX4akw3M7+ixWyFew6oicSVwJyVJ8W5KukFp8acjQuu5utb7fnqmaUbqxxEZKIY
kihermJ/8m4HQZEA+r90dnHANSmDTsez2o5o53nC8zEUTvj3w3WNdI1opUjBOegV
+G0DOkPSDJNdBtdKlsSVFvIHswwc+sn/OuzLFWF0/wVppvAsXokLV3u/uqul7Cb1
4HFaJmO7pu+FrEZ/WWMQERNB4t0n+g==
=4/Yh
-----END PGP SIGNATURE-----

--XbNOofo9GlRgxEidsRrFhCqcIkRvhpwL6--
