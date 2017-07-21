Received: from eggs.gnu.org ([2001:4830:134:3::10]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWtO-0006Us-Lq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWtK-0003Ww-1o
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYWtJ-0003WY-Oo
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:18:45 -0400
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
	<CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
	<20170721093433.GG17693@redhat.com>
	<CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
Date: Fri, 21 Jul 2017 07:18:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tb8ApiF2NeOQLVDWBSbM2g2uUAKX4ov5S"
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
--Tb8ApiF2NeOQLVDWBSbM2g2uUAKX4ov5S
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
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
In-Reply-To: <CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[please don't top-post on technical lists]

On 07/21/2017 04:41 AM, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> oh Maybe the version is something wrong?
>=20
> qemu-img -V
>=20
>> qemu-img version 2.9.0
>=20
>=20
> qemu-nbd -V
>=20
>> qemu-nbd version 0.0.1
>=20
>=20
> They're not correspondent?

Not currently, although patches are welcome (qemu-img and qemu-io share
versions, so qemu-nbd is the only oddball)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Tb8ApiF2NeOQLVDWBSbM2g2uUAKX4ov5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx8SMACgkQp6FrSiUn
Q2o0Nwf/fg2X9LDh5JXwGQieTd0gZj9pU1r1S0ShxPNzSOqtTMQLfZhRTNGKb2hw
AFr7uiky28r1/niuXHqDJ0YghHKJm3gOeGZUbgdToWbi38V1w4/QFSRbrGxkKhTt
OlsnlLnB4wH74CNxmWWL0AJv4RxGJX/LdBvNuONpfRsXXhJsRrXfEdDeR7ZbO8lS
nWHkn9Z2v3ijpofiq4y3D97mzEufALvRdAT0dnCXng9caitzUNL8srE55YTjFVWa
rZkkqlb5S4giA1wKxIU6VsYLJ+IaRDNfUCClIBhQXIzNfkJQbX6QuN1fXePwRL/X
9bErd7lB6pYMJEd5srOb2b4NyfVDtg==
=e4Xa
-----END PGP SIGNATURE-----

--Tb8ApiF2NeOQLVDWBSbM2g2uUAKX4ov5S--
