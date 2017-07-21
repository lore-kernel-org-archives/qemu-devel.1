Received: from eggs.gnu.org ([2001:4830:134:3::10]:49956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRlg-0007UU-AN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRld-0000FF-9e
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYRlc-0000EV-Vv
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:50:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA7118E685
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:50:27 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-8-ldoktor@redhat.com>
	<20170720183522.GW2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <79c348d8-fb6c-7b08-e143-eab8572b5468@redhat.com>
Date: Fri, 21 Jul 2017 08:50:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170720183522.GW2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9pc8691OwtEJPRKlaphLOrQ6Bc6C7Hc4T"
Subject: Re: [Qemu-devel] [PATCH 07/11] qmp.py: Use object-based class for
 QEMUMonitorProtocol
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
--9pc8691OwtEJPRKlaphLOrQ6Bc6C7Hc4T
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <79c348d8-fb6c-7b08-e143-eab8572b5468@redhat.com>
Subject: Re: [PATCH 07/11] qmp.py: Use object-based class for
 QEMUMonitorProtocol
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-8-ldoktor@redhat.com>
 <20170720183522.GW2757@localhost.localdomain>
In-Reply-To: <20170720183522.GW2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.7.2017 v 20:35 Eduardo Habkost napsal(a):
> On Thu, Jul 20, 2017 at 06:28:11PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> There is no need to define QEMUMonitorProtocol as old-style class.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>  scripts/qmp/qmp.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> index bb4d614..68f3420 100644
>> --- a/scripts/qmp/qmp.py
>> +++ b/scripts/qmp/qmp.py
>> @@ -30,7 +30,7 @@ class QMPTimeoutError(QMPError):
>>      pass
>> =20
>> =20
>> -class QEMUMonitorProtocol:
>> +class QEMUMonitorProtocol(object):
>=20
> I don't fully understand the consequences of changing to
> new-style classes when using old-style SuperClass.__init__()
> calls in the __init__().  Should we change QMPShell.__init__() to
> use super()?
>=20
The consequence is it becomes a proper object with full object model and =
less workarounds. It also consumes a bit more memory but are the only ava=
ilable mode in py3.

As for the old-style superclass, it works, but the correct approach is to=
 replace it with `super` call. I'll address that in the v2 (I only checke=
d for `.py` files but there are many python sources in qemu tree without =
the proper extension. I still need to get used to this.).

Luk=C3=A1=C5=A1

>=20
>> =20
>>      #: Socket's error class
>>      error =3D socket.error
>> --=20
>> 2.9.4
>>
>=20



--9pc8691OwtEJPRKlaphLOrQ6Bc6C7Hc4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZcaQuExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFt
JAf/SDS6/kZaza7RBkYLzcsk9VYUldJ2Ft7MrjLCYQehVSqNaBz/uW0Tvnep66bg
r5/ym5rIOzHNuTFmcEM8vzjLQ3kQGLA/XYzSNUbM2I5E37BzRCNkr6DZOttuMS1A
s55GXcNOUqyDRJ8i1TfI0XmUuh2GopdaVBQXXFzJqmNp6gmsL6J5O236AVWL8N6x
U/vJ0k0qX5Lfd4pgFJvjCjMAFQU4vVdfANtrviFowqTARcqoCKouWr4y1bav9min
QC62r6RkrxZ6BEMTDH8p9cDXqBq78BoZerLjm7zQtjV1jPOw3ngxAUIUh3mNXphU
DoYJwhqWLJBW2mIuSWngT+Dx6Q==
=zGH+
-----END PGP SIGNATURE-----

--9pc8691OwtEJPRKlaphLOrQ6Bc6C7Hc4T--
