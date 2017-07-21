Received: from eggs.gnu.org ([2001:4830:134:3::10]:52997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRse-0000ab-QI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRsb-0004cz-QC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYRsb-0004cc-Gw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:57:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 684B44620F
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:57:40 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-11-ldoktor@redhat.com>
	<20170720184211.GZ2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <2bf739d6-1860-b064-6366-ac3b406c23da@redhat.com>
Date: Fri, 21 Jul 2017 08:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170720184211.GZ2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VfrCatvdX0N5Vt5rimfBIdg1Dx1h8uckR"
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
--VfrCatvdX0N5Vt5rimfBIdg1Dx1h8uckR
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <2bf739d6-1860-b064-6366-ac3b406c23da@redhat.com>
Subject: Re: [PATCH 10/11] qtest.py: Few pylint/style fixes
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-11-ldoktor@redhat.com>
 <20170720184211.GZ2757@localhost.localdomain>
In-Reply-To: <20170720184211.GZ2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.7.2017 v 20:42 Eduardo Habkost napsal(a):
> On Thu, Jul 20, 2017 at 06:28:14PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

> [...]
>> @@ -83,8 +80,11 @@ class QEMUQtestMachine(qemu.QEMUMachine):
>>                   socket_scm_helper=3DNone):
>>          if name is None:
>>              name =3D "qemu-%d" % os.getpid()
>> -        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dn=
ame, test_dir=3Dtest_dir,
>> -                                               socket_scm_helper=3Dso=
cket_scm_helper)
>> +        scm_helper =3D socket_scm_helper
>=20
> Why is this necessary?
>=20
to avoid > 80 chars line. It should be optimized-out by the python compil=
er so it should not slow down the execution. Alternative solution is to u=
se:

    super(QEMUQtestMachine,
          self.__init__(...)

which looks IMO uglier, but I can use that in v2, should that be your pre=
ferred style.

Luk=C3=A1=C5=A1

>> +        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dn=
ame,
>> +                                               test_dir=3Dtest_dir,
>> +                                               socket_scm_helper=3Dsc=
m_helper)
>> +        self._qtest =3D None
>>          self._qtest_path =3D os.path.join(test_dir, name + "-qtest.so=
ck")
>> =20
>>      def _base_args(self):
>> --=20
>> 2.9.4
>>
>=20



--VfrCatvdX0N5Vt5rimfBIdg1Dx1h8uckR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZcaXeExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGi
OwgAzJAeABm3gC8s+UtqwM4S9eNgFuOHixHyF9ekLNtD4A6VSqsN5ziGa+8kQb+x
6tj3WtVLS79a/ff/yUO+AUI+uS0xSOOl0hW5+4z0fW+BAJKQcj9otEHX3e6GoWkR
cfsAZvLb8DaXkxL17nBTdM/6O82JNWj2wGN1y2WahZy6vePOBbQ/mmTilmBZq++F
UFWHDXRML7JPhYDnZ1WQvRVOKYgoxoXndGLS8N7Z0XHz2l1Kzej6nXEbjqlkKGk/
y4ciVFNnPucJvK5rMxraEyB+DCEiIIc9LFiyYYVbVpo7Bs2pxsk4yADr90rkBKhT
cpvP02R7jO+VZ351z1TatqeCTw==
=kolA
-----END PGP SIGNATURE-----

--VfrCatvdX0N5Vt5rimfBIdg1Dx1h8uckR--
