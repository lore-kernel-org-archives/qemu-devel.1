Received: from eggs.gnu.org ([2001:4830:134:3::10]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZLz-0005Bu-DS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZLv-0002ns-DH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:01:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgZLv-0002mh-5Z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:01:15 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan> <20170207113231.44e35be6@bahia.lan>
	<6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
	<20170207172933.05574f60@bahia.lan>
	<20170214132122.GH23310@stefanha-x1.localdomain>
	<20170222144153.131dee9d@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18735c6a-e21e-6aaf-4283-53f980afae3f@redhat.com>
Date: Wed, 22 Feb 2017 10:01:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170222144153.131dee9d@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2aT3M9jlm2fPunw3gHoACSxRK8fOdWc6T"
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2aT3M9jlm2fPunw3gHoACSxRK8fOdWc6T
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org,
 Fam Zheng <famz@redhat.com>
Message-ID: <18735c6a-e21e-6aaf-4283-53f980afae3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
 <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
 <20170207001533.3f18e4ea@bahia.lan> <20170207113231.44e35be6@bahia.lan>
 <6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
 <20170207172933.05574f60@bahia.lan>
 <20170214132122.GH23310@stefanha-x1.localdomain>
 <20170222144153.131dee9d@bahia.lan>
In-Reply-To: <20170222144153.131dee9d@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 07:41 AM, Greg Kurz wrote:
> Eric,
>=20
> I fully understand your concern about the missing QMP bits, but given t=
he other
> comments people made on this series, I'd like to move forward and merge=
 it for
> 2.9, without the 'x-' prefixed options. Is it okay with you ?

Yes, I think we'll be okay. Libvirt will just be unable to recognize the
feature until the QMP bits are in place.


>>>> If it cannot be probed via QMP, then libvirt will most likely assume=

>>>> that it does not exist.  I guess we're okay having command line only=
 in
>>>> 2.9 if you can't get QMP working, because libvirt will just never dr=
ive
>>>> the feature until 2.10 when QMP is available; but then we risk the
>>>> command line subtly changing and breaking someone else that was usin=
g
>>>> the command line without QMP.  Maybe the safest approach is to just =
use
>>>> the 'x-' prefix to the command line portion, until the feature is co=
mplete.
>>>>  =20
>>>
>>> The semantics here are exactly the same as for block devices. The
>>> command line options added to -fsdev are the very same already used
>>> by -drive for years.
>>>
>>> Patch 2/2 in this series even factors them out to a common header fil=
e
>>> to be used by fsdev and blockdev. I really don't expect any modificat=
ion
>>> at all on the command line (nor the other people who reviewed that pa=
tch
>>> obviously)... are you suggesting that we should put 2/2 on hold and
>>> use the 'x-' prefix anyway ? =20
>>
>> I see these parameter names as stable.  There is little risk that they=

>> would change.

We just need to be sure that when we do add QMP, that it doesn't use
names that differ from the command line (blockdev is an example where we
weren't careful in 2.8, and had to rename things in 2.9 to be
consistent, and I want to avoid repeating that mistake).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2aT3M9jlm2fPunw3gHoACSxRK8fOdWc6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrbXGAAoJEKeha0olJ0NqHhgIAKbUDrGUQYjBZBDbhFsMxamC
eWgsFlBqACwP9RJROMxH2K6MJFlDds9gsocEfe533lwReYC6/sTtY+3H2bbyWDAt
3Jki1VyKUkXXlRryTA6tE2xyWDY+JEUWAQ6/2hOk9Q7J4gDlJy0oMDYNtjdTtkz7
/7JFONQULuEiH0/xVZHU769z62PmAJZD0zhjJx0Gqk0R3PyBLWSknK8fEIHNRIXv
KTLlHDmpd7Op7RDiRO+HBmIN154AxHw3gQNdTXXTc5Yo1m7pok8O4gtw6h7AWFF/
nTXkfTl1Ai6B0GROPWqX15VZuFD9tkSWGArlR+HaWdN7vGK4S74eT6xFmLWYVAQ=
=hYVg
-----END PGP SIGNATURE-----

--2aT3M9jlm2fPunw3gHoACSxRK8fOdWc6T--
