Received: from eggs.gnu.org ([2001:4830:134:3::10]:51344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJkf-00058E-61
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJkY-00082H-8j
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:43:13 -0400
References: <20170905112152.8851-1-ppandit@redhat.com>
	<CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
	<7FD21DDFE9A3784693E393AF276FE7D21F17E49E@DGGEMA501-MBX.china.huawei.com>
	<CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4dac78d2-da60-95c7-4d46-76f660db6a9f@redhat.com>
Date: Tue, 5 Sep 2017 14:42:46 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Od5WInuJV72EVsEl2cCTLXPX4XB053hqX"
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBbUEFUQ0hdIGludGM6IGFybV9naWN2?=
 =?utf-8?q?3=3A_limit_GICR_ipriority_index?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, niuguoxiang <niuguoxiang@huawei.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Od5WInuJV72EVsEl2cCTLXPX4XB053hqX
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 niuguoxiang <niuguoxiang@huawei.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Message-ID: <4dac78d2-da60-95c7-4d46-76f660db6a9f@redhat.com>
Subject: =?UTF-8?Q?Re:_[Qemu-devel]_=e7=ad=94=e5=a4=8d:_[PATCH]_intc:_arm=5f?=
 =?UTF-8?Q?gicv3:_limit_GICR_ipriority_index?=
References: <20170905112152.8851-1-ppandit@redhat.com>
 <CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
 <7FD21DDFE9A3784693E393AF276FE7D21F17E49E@DGGEMA501-MBX.china.huawei.com>
 <CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
In-Reply-To: <CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 07:35 AM, Peter Maydell wrote:
> On 5 September 2017 at 13:30, niuguoxiang <niuguoxiang@huawei.com> wrot=
e:
>> I think only assert is not enough, because assert() depends on NDEBUG
>> preprocessing
>=20

> Incidentally, QEMU can never be compiled with NDEBUG not
> set -- we will #error in the compilation if it is not set.

Well, right now, we only #error if you happen to compile certain
devices, although the proposal has been made to #error for ALL builds:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03608.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Od5WInuJV72EVsEl2cCTLXPX4XB053hqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmu/jYACgkQp6FrSiUn
Q2oNoAf+MHcGk37Q1saDI/TiX3T6/1WZ7lKeYJjjaLnUupKKeWRmgYjduY/Z9GVH
tkY/ciMEyWBdp2185TjjViIZ3YMSbgnIs+SEpvLukJGCiEaQFbwnF0ZyViLl4RAF
3gKcNP5aeSnuqV3sAwa7Vs+Lvuy9xyo22sLGK023h9WjJXfUHhuGKet+xj6N75Nq
1vZ3FGQ1p48kQP3TUzyLB4jLbzIs0DPR4wHAbYttGtyYZVPSoxj1q2V8Hu9Q3jg6
a/gewurjHqc7BOyjd2QID2/umdUtx8XkJk/GqcAaCA/syvsmbONjVpwnBsWLOKoT
fK+UOjalG7zdZNWY1UPaA77AXt61ZQ==
=FeB6
-----END PGP SIGNATURE-----

--Od5WInuJV72EVsEl2cCTLXPX4XB053hqX--
