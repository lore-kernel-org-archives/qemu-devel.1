Received: from eggs.gnu.org ([2001:4830:134:3::10]:37710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNSj-0005Ep-0c
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNSi-0003ZD-2Y
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daNSh-0003Y6-Pt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:38:56 -0400
References: <20170726143543.2530-1-ldoktor@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <5350ba91-66e6-fca2-62b8-df85fa83cff5@redhat.com>
Date: Wed, 26 Jul 2017 16:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170726143543.2530-1-ldoktor@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c0u2SdOf4eRKN4dS1XcDfaIe1vrrvSwfU"
Subject: Re: [Qemu-devel] [PATCH v3 00/14] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c0u2SdOf4eRKN4dS1XcDfaIe1vrrvSwfU
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, jsnow@redhat.com
Message-ID: <5350ba91-66e6-fca2-62b8-df85fa83cff5@redhat.com>
Subject: Re: [PATCH v3 00/14] qemu.py: Pylint/style fixes
References: <20170726143543.2530-1-ldoktor@redhat.com>
In-Reply-To: <20170726143543.2530-1-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 26.7.2017 v 16:35 Luk=C3=A1=C5=A1 Doktor napsal(a):
> Hello guys,
>=20
> I'm reading the available python modules to exercise qemu and while rea=
ding them
> I fixed some issues that caught my attention. It usually starts with a =
simple
> pylint/docstring fixes and slowly graduates to more controversial ones =
so I'm
> open to suggestion to remove some of them.
>=20
> Kind regards,
> Luk=C3=A1=C5=A1
>=20
> Changes v1->v2
>  - Squashed 2nd and 10th patches into 2nd one
>  - Use repr() in MonitorResponseError's description
>  - Improved commit message of the 6th patch
>  - Two tweaks to docstrings changed in the 6th patch
>  - Also updated qmp-shell to use new-style super calls (7th patch)
>  - Fixed the accidental rename of qmp `cmd_id` (kept the id->cmd_id pat=
ch)
>  - Changed the style of the style-fix in the 10th commit
>=20
> Changes v2->v3
>  - Don't use repr in the 5th patch in MonitorResponseError
>=20
> Daniel P. Berrange (1):
>   qcow: fix memory leaks related to encryption
>=20
> Kevin Wolf (1):
>   qemu-iotests: Fix reference output for 186
>=20
> Luk=C3=A1=C5=A1 Doktor (10):
>   qemu.py: Pylint/style fixes
>   qemu|qtest: Avoid dangerous arguments
>   qemu.py: Use iteritems rather than keys()
>   qemu.py: Simplify QMP key-conversion
>   qemu.py: Use custom exceptions rather than Exception
>   qmp.py: Couple of pylint/style fixes
>   qmp.py: Use object-based class for QEMUMonitorProtocol
>   qmp.py: Avoid "has_key" usage
>   qmp.py: Avoid overriding a builtin object
>   qtest.py: Few pylint/style fixes
>=20
> Peter Maydell (1):
>   Update version for v2.10.0-rc0 release
>=20
> Vladimir Sementsov-Ogievskiy (1):
>   qcow2-bitmap: fix bitmap_free
>=20

Oups, I'm sorry I based it on a wrong master... I'll send v4 without thos=
e.

Luk=C3=A1=C5=A1


--c0u2SdOf4eRKN4dS1XcDfaIe1vrrvSwfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZeKlwExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFJ
VggA1n2A8+GwN7rAiZ/X6iDKOF3mg1UCXNcbNEx3w9eB62WMrs31y4Co6lz2OPQK
NEwfzNqdRm527gTlQ1kj9lTli/dQHK+m6Fd/x1CntK/0V9aMtpbAeoQbCWQA0E0B
C2qtBG1sjjty/+4BwqF4N8JYcMEN3mXNce9JbtMSlg8mwwdyeYHmOMzckcGqh8CB
q3PBMrqtB/vFDXYyMR4ux/JvrCuwESt3WKtm3im315+DpqAusOSBhOLvtIvKqqym
ARgVgGK2lGc7E5x19bfUtJDUuLIS4xzkg9AVb8QETiRSQ2/a2uZbq8iulJFCIiX2
3jooR0+64HKfDSUKxQJ2aF5rpw==
=Sk6y
-----END PGP SIGNATURE-----

--c0u2SdOf4eRKN4dS1XcDfaIe1vrrvSwfU--
