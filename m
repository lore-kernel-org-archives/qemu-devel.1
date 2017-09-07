Received: from eggs.gnu.org ([2001:4830:134:3::10]:39356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpxAP-0002G3-On
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpxAL-0004hN-0X
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:48:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpxAK-0004gX-OH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:48:20 -0400
References: <20170906152111.16958-1-eblake@redhat.com>
	<CAFEAcA-1QOkSF+sG+0ymTv-Cx0WDEG4Ns4NydW-vz-box2Pi3Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ba61e49-3b84-46a4-2978-d42d3457f21b@redhat.com>
Date: Thu, 7 Sep 2017 08:48:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-1QOkSF+sG+0ymTv-Cx0WDEG4Ns4NydW-vz-box2Pi3Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aBKHrlulvwoUrTFnShvHTCKIo7p4QL8mo"
Subject: Re: [Qemu-devel] [PULL 0/5] NBD patches for 2017-09-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aBKHrlulvwoUrTFnShvHTCKIo7p4QL8mo
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ba61e49-3b84-46a4-2978-d42d3457f21b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/5] NBD patches for 2017-09-06
References: <20170906152111.16958-1-eblake@redhat.com>
 <CAFEAcA-1QOkSF+sG+0ymTv-Cx0WDEG4Ns4NydW-vz-box2Pi3Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-1QOkSF+sG+0ymTv-Cx0WDEG4Ns4NydW-vz-box2Pi3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2017 07:26 AM, Peter Maydell wrote:
> On 6 September 2017 at 16:21, Eric Blake <eblake@redhat.com> wrote:
>> The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896a=
c065e:
>>
>>   Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-09-06
>>
>> for you to fetch changes up to 030fa7f6f950f5c8963f1dee8e6bb7387ed86a9=
9:
>>
>>   nbd: Use new qio_channel_*_all() functions (2017-09-06 10:11:54 -050=
0)
>>

> I get an error in test-aio-multithread (clang, linux, x86-64):
>   GTESTER tests/test-aio-multithread
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-aio-multithread.=
c:368:test_multi_fair_mutex:
> assertion failed (counter =3D=3D atomic_counter): (532693 =3D=3D 532694=
)
> GTester: last random seed: R02Sa68ef1eb4822359eb869642ff26180df

I wonder if that is a rare but pre-existing bug, as I don't see any use
of qio_channel in test-aio-multithread, and therefore no obvious way
that this series would be the cause of the intermittent failure.

>=20
> Seems to be very intermittent, though -- I haven't been able
> to reproduce it, even with loading the box up with a
> compile job at the same time.

Paolo, this appears to be your area of expertise.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aBKHrlulvwoUrTFnShvHTCKIo7p4QL8mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxTh8ACgkQp6FrSiUn
Q2rXbQf6A+ANplA2Wm8KB1KGeIg72AwmDegLZAX2qeDWQkJmtuJE+0zdT+BepyGZ
D+BpcyfgXqWrx7U+kkNqURIGI3gfaMcUN+NiEm7aHXYRq96+5kTTDgnoGu0UJioo
4G2EqnU1L9PHPr6+De0WYIASpyhb9LO9qqdY+tXIovh+BEiLdMqgT0Yixp86E/IH
IFyrWR1g23qVLr1SCavShDiyLC1cDsb9kcFZeHa49rSCoDRXnP2733uxPtOnSKNi
dsdBllYJ5/ybyDFpt3PKooqwD82byOu9oq4Xq87S5dU9QuST84WYZtGL3nQ3DBf0
XMqdGufaju0FEyCITlkPzVXJu3uF5A==
=kjO3
-----END PGP SIGNATURE-----

--aBKHrlulvwoUrTFnShvHTCKIo7p4QL8mo--
