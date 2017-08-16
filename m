Received: from eggs.gnu.org ([2001:4830:134:3::10]:51867)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dhuiT-0003mu-Ne
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dhuiR-0007Ir-4E
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:34:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:57252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dhuiQ-0007IO-Q6
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:34:19 -0400
References: <20170816072104.24420-1-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9ad5fa6c-a7c1-e701-12e9-6e6d5372b16c@gmx.com>
Date: Wed, 16 Aug 2017 11:24:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170816072104.24420-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iN1MRSupK9IFiMn59vpsd466AoJI8gxxK"
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iN1MRSupK9IFiMn59vpsd466AoJI8gxxK
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <9ad5fa6c-a7c1-e701-12e9-6e6d5372b16c@gmx.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests (for
 non-x86_64 and/or non-Linux)
References: <20170816072104.24420-1-famz@redhat.com>
In-Reply-To: <20170816072104.24420-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.2017 09:20, Fam Zheng wrote:
> Build tests in one 32 bit Linux guest and three BSD images are defined =
in this
> series. This is a more managable way than the manually maintained virtu=
al
> machines in patchew. Also, one big advantage of ephemeral VMs over long=
 running
> guests is the reduced RAM usage of host, which makes it possible to hav=
e one
> host test all these BSD variants and probably more.
>=20

Thank you for your work on this!

> The BSD guest templates are manually prepared following
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> as it is not easy to automate. (The ideal approach is like the ubuntu.i=
386
> script, which configures the guest on top of an official released image=
, fully
> automatically.)
>=20

For the reference, inside the NetBSD infrastructure we use homegrown Anit=
a:

http://pkgsrc.se/misc/py-anita

> Need for help: "gmake check" in the added OpenBSD image fails with -ENO=
MEM
> errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? An=
d there
> is a warning from ./configure about OpenBSD going to be unsupported in =
coming
> releases, is it still the case?
>=20

I'm not sure about their defaults. Please check ulimit and perhaps
/etc/login.conf.

> Fam
>=20
> Fam Zheng (9):
>   gitignore: Ignore vm test images
>   qemu.py: Add variable vga type
>   qemu.py: Add "wait()" method
>   tests: Add vm test lib
>   tests: Add ubuntu.i386 image
>   tests: Add FreeBSD image
>   tests: Add NetBSD image
>   tests: Add OpenBSD image
>   Makefile: Add rules to run vm tests
>=20
>  .gitignore                |   2 +
>  Makefile                  |   2 +
>  configure                 |   2 +-
>  scripts/qemu.py           |   8 +-
>  tests/vm/Makefile.include |  41 ++++++++
>  tests/vm/basevm.py        | 246 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/vm/freebsd          |  44 +++++++++
>  tests/vm/netbsd           |  44 +++++++++
>  tests/vm/openbsd          |  45 +++++++++
>  tests/vm/ubuntu.i386      |  88 +++++++++++++++++
>  10 files changed, 520 insertions(+), 2 deletions(-)
>  create mode 100644 tests/vm/Makefile.include
>  create mode 100755 tests/vm/basevm.py
>  create mode 100755 tests/vm/freebsd
>  create mode 100755 tests/vm/netbsd
>  create mode 100755 tests/vm/openbsd
>  create mode 100755 tests/vm/ubuntu.i386
>=20



--iN1MRSupK9IFiMn59vpsd466AoJI8gxxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZlA9JAAoJEEuzCOmwLnZsx5wP/1Rrh+uRlGuNn4bDs+fLE1C6
MyPMFhtEPhWmrpsOjc4Xd3Bm0zGeDZm8Z3pIBm/YVgi6vb/PFIwymJCNk3S16Vpw
5sV6EpKxPILXdwPaCHLIEsdxOaP4pXxhhNRFYZ4O1lT1GAhh2dJoGn/RFKkZhOGr
z2XVqwctMhXCA0gWkbC5wkwX24WiWRNpCSuNUNrsl7cBGR4/EsMcm7y3tixMj2zv
OO21zv6rA9Wsmv2K7gSjpa7p5tgxV+6Gr1l8Tzh7lUy7C9xZfD6Lfz1l6qrpqpVi
dDHFgavSyEafxKn04A1jkHOwenq1X3taBc9C1URqHrS36CUoi3Tq83QwvJ7iCRAy
nylaNzSWonyk51KwdEQD2Pymyw5e8GGxpCbgsekmErwKQnt+Cchk+tcNkBSMssGB
fgbAeZBt8yYHKiI1+nzwqcXNZQgJhYBs2igDCTOk+31pDUp0Iuue8CtL+Ua+GVV8
xu2kV35DCxfeW1QZmfobisr7TD2PEgL+2BHFUuoSAwTp+ObwvTKi/mV98Xq5T0k/
qGLkabofhcsu87XIoXkZhS5N6RoJudmKFlrLxKT0CERAdbKbZ1lHfe1mLjCmgl9R
6vxpMMCQJUzoojM2DwGpAKhv3xXi07l1WPJ9KePpj8Ht1FBcrFplBs2U2od0MUTf
2tc2H8z32d++VKdlYw6q
=gMRP
-----END PGP SIGNATURE-----

--iN1MRSupK9IFiMn59vpsd466AoJI8gxxK--
