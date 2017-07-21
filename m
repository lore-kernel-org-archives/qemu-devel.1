Received: from eggs.gnu.org ([2001:4830:134:3::10]:52692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYXb-0000Le-Ap
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYXZ-0004mg-NJ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYYXZ-0004m2-EY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A9AB883C8
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:04:24 +0000 (UTC)
References: <20170720214008.28494-1-eblake@redhat.com>
	<20170720214008.28494-4-eblake@redhat.com>
	<87shhpj3uo.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3b66d5f-4dad-4d46-a5f8-6709a40aabf4@redhat.com>
Date: Fri, 21 Jul 2017 09:04:22 -0500
MIME-Version: 1.0
In-Reply-To: <87shhpj3uo.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="juRPwKsUS8BUjaQ3nXc01AgUeMvdwretV"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qtest: Avoid passing raw strings
 through hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--juRPwKsUS8BUjaQ3nXc01AgUeMvdwretV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <f3b66d5f-4dad-4d46-a5f8-6709a40aabf4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qtest: Avoid passing raw strings
 through hmp()
References: <20170720214008.28494-1-eblake@redhat.com>
 <20170720214008.28494-4-eblake@redhat.com>
 <87shhpj3uo.fsf@dusky.pond.sub.org>
In-Reply-To: <87shhpj3uo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:50 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> The next patch will add __attribute__((__format__)) to hmp(), which
>=20
> It did in v1, but no more.  Intentional?

Oh shoot.  I got so busy deleting the attribute for qmp() and friends
that I also deleted it for hmp().  I'm not having a very good run at
this, am I?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--juRPwKsUS8BUjaQ3nXc01AgUeMvdwretV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyCeYACgkQp6FrSiUn
Q2pdQAgArM/6H/FwmMVL6RNK/5iXkdT1EKjYNZGiJlRT+5aT6NTg2+wfT65V898+
adtbFldocpZp5Whv7FCnSFcQeJhJhrr8a217ocPUh2zxYCSvhrSvPHs6aQ3d1cSg
rCvKYQ8v/pJoZiUb2sCofZ1u93OLsPFPjvMzGlzO6EnzbMirkagqai6lXr7Xbo1U
wNI/JYF7XHrptfFhOYlWf5vtAoKD1FGvR/LvigJTkL06gci2Lk6BV79YsdMeO+5a
B73tTguY/+Jf5tlkGmxeEJzglkPKbOXgHMEFpsd7seeow5ixpvS8as7SJCvELYy7
sTqAYTj0YbVydaPQV8lAQ0yxZOH5sA==
=bsJJ
-----END PGP SIGNATURE-----

--juRPwKsUS8BUjaQ3nXc01AgUeMvdwretV--
