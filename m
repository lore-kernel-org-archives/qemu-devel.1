Received: from eggs.gnu.org ([2001:4830:134:3::10]:45182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehKNX-0003cg-NQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehKNW-0003KE-Ix
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:18:35 -0500
References: <20180130062503.32596-1-famz@redhat.com>
	<7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
	<CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
	<8f78f816-a37e-e968-e844-a7088e87b9e4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6be652dd-d2c7-700f-cb7f-cfffb968b40f@redhat.com>
Date: Thu, 1 Feb 2018 13:18:23 -0600
MIME-Version: 1.0
In-Reply-To: <8f78f816-a37e-e968-e844-a7088e87b9e4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sME39GITvGAYmYthF8OYhNdvBVlwKVpqE"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sME39GITvGAYmYthF8OYhNdvBVlwKVpqE
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
Message-ID: <6be652dd-d2c7-700f-cb7f-cfffb968b40f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
References: <20180130062503.32596-1-famz@redhat.com>
 <7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
 <CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
 <8f78f816-a37e-e968-e844-a7088e87b9e4@redhat.com>
In-Reply-To: <8f78f816-a37e-e968-e844-a7088e87b9e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 11:59 AM, Max Reitz wrote:

>>> Hmmmm, now this fails again on my 32 bit build. :-(
>>>
>>> The issue there is that you get a "Cannot allocate memory" when tryin=
g
>>> to open the file.  My current fix was 2291712c39111a732 which simply
>>> converted that to "Invalid argument", but now it's getting a bit more=

>>> complicated...  Should I just continue to play the game and check the=

>>> output for "Cannot allocate memory" and print exactly what the refere=
nce
>>> output is expecting...?
>>
>> Ahhh. OK, then, with a big comment.
>>
>> I'd say let's just _notrun on 32 bit.
>=20
> Sounds OK, but how would we test that? uname? Or just _notrun when we
> see the ENOMEM message?

_notrun when you detect ENOMEM seems reasonable (the equivalent of exit
status 77 in skipping a test in an automake context)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sME39GITvGAYmYthF8OYhNdvBVlwKVpqE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzZ/8ACgkQp6FrSiUn
Q2rQAQf/Q0G74SPVl/vojocF40o27rZC1Va43287XN3tYpCBI0hxsGA1Gmy93R17
LHlzVBIlsdbmEEYaGMzae60SayjRne2M4XyzikVbp/xUzLnBn1vcdKlnI1itqeA2
Tat9P7pvAITqK21LJ8vbjON2auNkHeIOCVJ1UXhb3abGUNwMyg1n45vKDZZAVWF7
HnblMa6yCPj1l670VkmDvWRQP5XbYCuaiW5ShZItu22rXiRYUDByxk5uHKKua0UM
yit0lYB7AQz2eoyH10ZWtm0b14cVHRgOJJnWTykP/7Sd7B3MYskiYOPT9+ztO6TK
jq6OYO49dHubzn/R0HfUuB92kpyXog==
=U21w
-----END PGP SIGNATURE-----

--sME39GITvGAYmYthF8OYhNdvBVlwKVpqE--
