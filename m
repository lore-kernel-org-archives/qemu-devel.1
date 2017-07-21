Received: from eggs.gnu.org ([2001:4830:134:3::10]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYYZ-000130-JP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYYW-0005bJ-SM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYYYW-0005ZE-IR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:05:24 -0400
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
	<CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
	<20170721093433.GG17693@redhat.com>
	<CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
	<9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
Date: Fri, 21 Jul 2017 09:05:21 -0500
MIME-Version: 1.0
In-Reply-To: <9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1S5uJdk4q5VxKDLcU9XVNLpGlhMwd0KdC"
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1S5uJdk4q5VxKDLcU9XVNLpGlhMwd0KdC
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
 <20170720085958.GC21566@redhat.com>
 <CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
 <20170720091224.GD21566@redhat.com>
 <CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
 <20170721083816.GC17693@redhat.com>
 <CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
 <20170721093433.GG17693@redhat.com>
 <CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
 <9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
In-Reply-To: <9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 07:18 AM, Eric Blake wrote:
> [please don't top-post on technical lists]
>=20
> On 07/21/2017 04:41 AM, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
>> oh Maybe the version is something wrong?
>>
>> qemu-img -V
>>
>>> qemu-img version 2.9.0
>>
>>
>> qemu-nbd -V
>>
>>> qemu-nbd version 0.0.1
>>
>>
>> They're not correspondent?
>=20
> Not currently, although patches are welcome (qemu-img and qemu-io share=

> versions, so qemu-nbd is the only oddball)

Oops, looks like 'git send-email' doesn't know how to auto-cc
'Reported-by:' tags.  I meant to include you on my proposed patch:
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06931.html

Hmm, I wonder if scripts/get_maintainer.pl can be enhanced to scrape
commit messages for additional addresses to cc (sadly, my perl is not
strong enough for me to volunteer for the task)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1S5uJdk4q5VxKDLcU9XVNLpGlhMwd0KdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyCiEACgkQp6FrSiUn
Q2qvNgf+MDmsJosiP7flWt3FmMV++Qj+fpAWpsReBH1fw7tnAl4XTL5KgtqK2/Wa
55Wo3xUrPp660sL6vVP2qqv2I25jaImpRcxbx06ge+MrL69RRsTHotBXxO7Kiy8j
Az5fqm8oX+gmhHBoHTxTcS595XJXAk6LXcbPtkaxPhxValGlqqre3kylKeQmOs0U
/2zJbjL9jlUrNVaP+jgnlDZrRCmA/vV+Vm9MA39Ibm0Nwp7aH4QN8EhqxefnIo84
lBCewbpsks3nCh5ZfwbcKGyldYsnlFu8XOzVt1m4NX3N8OvvjiQuQW41P2J7p5HQ
OkB9/TaZscHRZNdm6oxbtvkvYYmHkw==
=0HzY
-----END PGP SIGNATURE-----

--1S5uJdk4q5VxKDLcU9XVNLpGlhMwd0KdC--
