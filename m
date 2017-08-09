Received: from eggs.gnu.org ([2001:4830:134:3::10]:34083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfTTC-00046x-UV
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfTT9-0008KT-Mo
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:04:30 -0400
References: <20170809151757.15743-1-vsementsov@virtuozzo.com>
	<565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
	<93a7eaf1-3387-0772-b779-b1ff3d3b9443@redhat.com>
	<bbc4083d-7a4c-2d93-d630-831fc0693161@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ecba212-dbd0-e81c-c7ad-50d09d1626e6@redhat.com>
Date: Wed, 9 Aug 2017 11:04:13 -0500
MIME-Version: 1.0
In-Reply-To: <bbc4083d-7a4c-2d93-d630-831fc0693161@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pprrAhUnnNSFG8NBxESaxAuH3sw3ftkHa"
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pprrAhUnnNSFG8NBxESaxAuH3sw3ftkHa
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Message-ID: <6ecba212-dbd0-e81c-c7ad-50d09d1626e6@redhat.com>
Subject: Re: [PATCH v2 for 2.10] iotests: fix 185
References: <20170809151757.15743-1-vsementsov@virtuozzo.com>
 <565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
 <93a7eaf1-3387-0772-b779-b1ff3d3b9443@redhat.com>
 <bbc4083d-7a4c-2d93-d630-831fc0693161@virtuozzo.com>
In-Reply-To: <bbc4083d-7a4c-2d93-d630-831fc0693161@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:57 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> This is because quite happens before first mirror request is done
>>> s/quite/quit/
>>>
>>>> (and, in specified case, even before block-job len field is set).
>>>> To prevent it let's just add a sleep for 0.3 seconds before quite.
>> Here, as well.
>>
>> Maybe:
>>
>> This is because, under heavy load, the quit can happen before the firs=
t
>> iteration of the mirror request has occurred.  To make sure we've had
>> time to iterate, let's just add a sleep for 0.3 seconds before quittin=
g.
>>
>>
>>>>        "return"
>>>>    +# If we don't sleep here 'quit' command may be handled before
>>>> +# the first mirror iteration is done
>>>> +sleep 0.5
>> The commit message disagrees with the code (.3 vs. .5) - which one is
>> correct?
>>
> Let it be .5, as I've tested it.

With a correct commit message (maintainer can touch it up),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pprrAhUnnNSFG8NBxESaxAuH3sw3ftkHa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLMn0ACgkQp6FrSiUn
Q2oyJQf5Af+Ja5lGDLGwDgPaVCOm0GFawyQKNjV6Q74p3B4rkkruEt3po2xFEKYr
yuaFuicD3KzRYvWqRjvnHMjG2aBONtqpgIFu5tyR2JR5hng5JVWFwTY2CLrJBRSC
8vkxs9Hqwh+cvtlzzyuL6mW0IZBPHArcMp3M4we/34HOAhTgHimBwlbdE2D+2cCH
e33btaA4kqhW7pbDW77iRD0Px6fg54FPYon9gTg/xxbQ/4Fl41Sddb3fHpY2sMKO
D78Y/hzS5GTjSlpn2w+2Teq5Jp7LueR2skeWWNdqZlln4N7ZftQlLLoWVC7TSl4A
NkcP48OcNsMV97DTud5JSRLZoo54Eg==
=HXiZ
-----END PGP SIGNATURE-----

--pprrAhUnnNSFG8NBxESaxAuH3sw3ftkHa--
