Received: from eggs.gnu.org ([2001:4830:134:3::10]:44866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb87u-0000Jp-K9
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb87p-0004er-RE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47731)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cb87p-0004eE-Il
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:56:13 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan> <20170207113231.44e35be6@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
Date: Tue, 7 Feb 2017 09:56:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170207113231.44e35be6@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="skq5pBnJIhgBkxQtGvbRqPfaKo9pqr5l0"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--skq5pBnJIhgBkxQtGvbRqPfaKo9pqr5l0
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org
Message-ID: <6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
 <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
 <20170207001533.3f18e4ea@bahia.lan> <20170207113231.44e35be6@bahia.lan>
In-Reply-To: <20170207113231.44e35be6@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/07/2017 04:32 AM, Greg Kurz wrote:
>>
>> I'm not aware of anything related to fsdev in QMP... and libvirt seems=
 to
>> only parse the output of -help to guess fsdev capabilities.
>=20
> Oops, reading some more libvirt code I now see that libvirt doesn't par=
se
> -help anymore with QEMU >=3D 1.2.0... sorry for the noise :)
>=20
>> And indeed,
>> qemu-options.hx doesn't expose this new feature.
>>
>>> Please make sure we don't reach 2.9 with only a half-baked feature;
>>> whether that means finishing the QMP work or temporarily disabling th=
e
>>> cli additions until a later release can finish the work.
>>>  =20
>>
>> Would this be ok to add the missing bits in qemu-options.hx or do you
>> expect more ?

If it cannot be probed via QMP, then libvirt will most likely assume
that it does not exist.  I guess we're okay having command line only in
2.9 if you can't get QMP working, because libvirt will just never drive
the feature until 2.10 when QMP is available; but then we risk the
command line subtly changing and breaking someone else that was using
the command line without QMP.  Maybe the safest approach is to just use
the 'x-' prefix to the command line portion, until the feature is complet=
e.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--skq5pBnJIhgBkxQtGvbRqPfaKo9pqr5l0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYme4ZAAoJEKeha0olJ0Nqsd8H/iHaq0Lhaf0rr9+7zaf5GWex
Ni2zR8+LeIkKcPE0LeKj7paYiHd3vPcO8EDoLkHJbafPBqVZULg1J547LbqxsAXt
A/R0GyQdj4KwmSrPRnjckaZDz6WXeghdCtloQuKDc6w8OlXropBEFOG7tnyvdWq7
hzXjaP28vJKOd/gzDdTRCSploMsU2yoFyIhSBdAsaAPSc1izJXZlyvKfFvA4dGMV
wM4n4djDMyleLfr4K/i0y9jcRSslKFkC1FJLBcLSh+BZ2qA4B0OswdHyNFnEy/3c
qD5pQGbduyBEjXUsaTdWvQCRbOpHw0sMBh4gFQbCSJHpV53iPxn/9XQhtOd730w=
=W08J
-----END PGP SIGNATURE-----

--skq5pBnJIhgBkxQtGvbRqPfaKo9pqr5l0--
