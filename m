Received: from eggs.gnu.org ([2001:4830:134:3::10]:53615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRu2-0001MU-DS
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRtz-0005P6-DE
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYRtz-0005On-48
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 088D68553E
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:59:06 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-12-ldoktor@redhat.com>
	<20170720184414.GA2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <e80f1c2e-67b0-5182-6fad-2797ed070ce7@redhat.com>
Date: Fri, 21 Jul 2017 08:58:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170720184414.GA2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Iw0c7UbGeOwKQu6EjWJnnaMVwgjEb38gG"
Subject: Re: [Qemu-devel] [PATCH 11/11] qtest.py: Avoid using mutable list
 as default argument
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
--Iw0c7UbGeOwKQu6EjWJnnaMVwgjEb38gG
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <e80f1c2e-67b0-5182-6fad-2797ed070ce7@redhat.com>
Subject: Re: [PATCH 11/11] qtest.py: Avoid using mutable list as default
 argument
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-12-ldoktor@redhat.com>
 <20170720184414.GA2757@localhost.localdomain>
In-Reply-To: <20170720184414.GA2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.7.2017 v 20:44 Eduardo Habkost napsal(a):
> On Thu, Jul 20, 2017 at 06:28:15PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> The list is a mutable object and is dangerous to use it. Recently the
>> QEMUMachine was adjusted to allow None as default, let's use it here a=
s
>> well.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>=20
> This patch requires patch 02/11 and both are pretty small.
> I suggest squashing them together.
>=20

Sure, I'll change it in the v2.

Luk=C3=A1=C5=A1


--Iw0c7UbGeOwKQu6EjWJnnaMVwgjEb38gG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZcaYzExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFF
TAgAsguaLWGHTwXWuLI9wVQ0sItXZU7FjkBzbEc4eJOEji1F8kpU6/MPLxPSTEXB
H4gEqAkcZlw2k6u2rulHxAn/f4Un2otMmtTtHtvg5W/upfpAB1mXIBLzyA7ANyio
dz0isY0F3npucEzAWcp4B4F2aiZveVkvsyIDiJrgR6L/KSiFHBFod9Q50heaS11k
PeIzWxeCguYEIPk+1euK8dbZO7EiKLW9g4Hmgn2pzkAoflnBELfUSbUvW1vDWfcW
fkhvcYpWwjlWia1T33Gc9j/TDSEiwlhL+XkRdLOZzgTTH0DBPPZ1S/jTvZbT5mRe
9QiqIHM3KhYc5Vii64qM8q63yQ==
=F+l1
-----END PGP SIGNATURE-----

--Iw0c7UbGeOwKQu6EjWJnnaMVwgjEb38gG--
