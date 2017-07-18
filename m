Received: from eggs.gnu.org ([2001:4830:134:3::10]:43409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTw1-0004gs-Jf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTvy-0001Kw-8E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXTvx-0001KT-TH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:57:10 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93a523dc-0cf4-c73b-518d-ef48e9f8ca64@redhat.com>
Date: Tue, 18 Jul 2017 09:57:07 -0500
MIME-Version: 1.0
In-Reply-To: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KGmfWPE1ieXSRwwkSUwUFlHPf6vN6noIj"
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KGmfWPE1ieXSRwwkSUwUFlHPf6vN6noIj
From: Eric Blake <eblake@redhat.com>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <93a523dc-0cf4-c73b-518d-ef48e9f8ca64@redhat.com>
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
In-Reply-To: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 10:01 PM, Jing Liu wrote:
> Hi all,
>=20
> Do you anybody have iotests failure: 188, 189 and 087 of the latest qem=
u
> upsteam?
>=20
> I just wondered if it has something wrong with my test machines because=

> I have different results with two machines.

It might help to show the ./check command line you are using, as well as
the errors you are getting.  Right now, master is failing on 51, 140,
and 143 when I test across './check -raw', './check -qcow2', and
'./check nbd', but not the three you mention.  But the iotests framework
allows a lot more combinations of testing (and we probably have some
lurking testsuite bugs on some of the more exotic combinations).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KGmfWPE1ieXSRwwkSUwUFlHPf6vN6noIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluIcMACgkQp6FrSiUn
Q2oqHgf/Rng5CvU58F9ezgJKENoCcBs9wmc26L2YBlxPku2yzTmyt0rsb/HTLa7q
u81f3er1HhiDlvxLBuhpRpI0vbmxLtPqQQQqjWKV1kAFF1RrKIZJc1hMZwoEJOFo
Z1PRRvwdiQk3ZrlUsuS1s1Vgo00JZcemvBoPP1fbvyqNya1bBnVUf9UwgQT0PiDS
Y15izV6Q2WSLUWXG1zyK9L2KDp/YOn3UK42UdHTisoDhtNJMIg+P29KdrQZ+7yef
m9wJjGFEFkfshBEQf7heW77kJ/Igyz7THRT1vqk0AiE/oNe655V2dqd3ZSPQ/Jod
bbCnt24noNeC6rsKwqzw230UAoPzRg==
=rnd6
-----END PGP SIGNATURE-----

--KGmfWPE1ieXSRwwkSUwUFlHPf6vN6noIj--
