Received: from eggs.gnu.org ([2001:4830:134:3::10]:47625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcgx-0000Gh-2C
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcgt-0007E4-5V
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dZcgs-0007Dd-S1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB31E64DF
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:42:25 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-11-ldoktor@redhat.com>
	<20170720184211.GZ2757@localhost.localdomain>
	<2bf739d6-1860-b064-6366-ac3b406c23da@redhat.com>
	<20170721185625.GE2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <a0e06be8-4f0a-fe87-4ff6-16026ed7f1a5@redhat.com>
Date: Mon, 24 Jul 2017 14:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170721185625.GE2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KQhtw1AipDxTpcKevlBUrExkSKlPu9s1P"
Subject: Re: [Qemu-devel] [PATCH 10/11] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQhtw1AipDxTpcKevlBUrExkSKlPu9s1P
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <a0e06be8-4f0a-fe87-4ff6-16026ed7f1a5@redhat.com>
Subject: Re: [PATCH 10/11] qtest.py: Few pylint/style fixes
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-11-ldoktor@redhat.com>
 <20170720184211.GZ2757@localhost.localdomain>
 <2bf739d6-1860-b064-6366-ac3b406c23da@redhat.com>
 <20170721185625.GE2757@localhost.localdomain>
In-Reply-To: <20170721185625.GE2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 21.7.2017 v 20:56 Eduardo Habkost napsal(a):
> On Fri, Jul 21, 2017 at 08:57:34AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> Dne 20.7.2017 v 20:42 Eduardo Habkost napsal(a):
>>> On Thu, Jul 20, 2017 at 06:28:14PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
>>> [...]
>>>> @@ -83,8 +80,11 @@ class QEMUQtestMachine(qemu.QEMUMachine):
>>>>                   socket_scm_helper=3DNone):
>>>>          if name is None:
>>>>              name =3D "qemu-%d" % os.getpid()
>>>> -        super(QEMUQtestMachine, self).__init__(binary, args, name=3D=
name, test_dir=3Dtest_dir,
>>>> -                                               socket_scm_helper=3D=
socket_scm_helper)
>>>> +        scm_helper =3D socket_scm_helper
>>>
>>> Why is this necessary?
>>>
>> to avoid > 80 chars line. It should be optimized-out by the
>> python compiler so it should not slow down the execution.
>> Alternative solution is to use:
>>
>>     super(QEMUQtestMachine,
>>           self.__init__(...)
>>
>> which looks IMO uglier, but I can use that in v2, should that be your =
preferred style.
>=20
> I think that would be better.  The purpose of the extra variable
> isn't clear when reading the code, making it more confusing.
>=20

OK, will fix in v2.
Luk=C3=A1=C5=A1


--KQhtw1AipDxTpcKevlBUrExkSKlPu9s1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZdespExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGf
bgf/bLYZQlyEqEfTE3cJN01Yt+tKqkaPNL1sut7mgg7DTpPvjlThEjoRWEVq5272
fvdP7AbviGRCoUVJ3JagGu0psb0vvhRCQAxAG0RXtSxgXg+J4qyc7ZukFOt2tkOL
J0lHlAKCHsn1Y0lgLw40DSM5KM5lQzT7dHB3SB9sr58V6XdY1pmA+2mOJWON+jwO
JZWj4ZblGTNRK3V0NCjJp2CcycMPZHbbEVjBRIBI5snZXIcdNfLIa+O1/uhj1Q0t
3pOK83c587oiGEdqvOCkbHdq7mz9ztBIw1IUpyAZ9EQT9tak46hYb1uuEsYakHxC
0zpXkPGscZyXjR/yhL2jm9dxSQ==
=53CR
-----END PGP SIGNATURE-----

--KQhtw1AipDxTpcKevlBUrExkSKlPu9s1P--
