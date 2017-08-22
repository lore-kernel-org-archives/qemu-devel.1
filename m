Received: from eggs.gnu.org ([2001:4830:134:3::10]:45633)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dkAOn-00081P-J7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dkAOj-0001HB-Hh
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:43:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:61057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dkAOj-0001Gm-5H
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:43:17 -0400
References: <20170822044155.2451-1-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <b9454dbb-1663-6198-3f7e-4fbd5eb492fa@gmx.com>
Date: Tue, 22 Aug 2017 16:33:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i3lR2iMcHgrNVRjvCNcN6xgR5EBSDtiWj"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
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
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i3lR2iMcHgrNVRjvCNcN6xgR5EBSDtiWj
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 eblake@redhat.com
Message-ID: <b9454dbb-1663-6198-3f7e-4fbd5eb492fa@gmx.com>
Subject: Re: [PATCH v3 00/10] tests: Add VM based build tests (for non-x86_64
 and/or non-Linux)
References: <20170822044155.2451-1-famz@redhat.com>
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I propose to rename *bsd.img.xz (like netbsd.img.xz) to
*bsd-version-arch.img.xz, like netbsd-7.1-amd64.img.xz. This will be
more verbose about the version and leave room for image upgrades in futur=
e.

On 22.08.2017 06:41, Fam Zheng wrote:
> v3: Drop RFC.
>     Add Stefan's and Kamil's reviewed-bys.
>     Use optparse. [Stefan]
>     Drop the VGA patch. [Paolo, Stefan]
>     Improve exit/exit code/doc. [Stefan]
>     Drop unused line from basevm.py. [Stefan]
>     Drop "--target-list" form Makefile.
>     More intelligent '-j'.
>     Add README. [Stefan]
>=20
> v2: - Add docstring. [Stefan]
>     - Call self._load_io_lod. [Stefan]
>     - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
>     - Add image checksum.
>     - Use os.rename() and os.makedirs(). [Stefan]
>     - Fix NetBSD URL. [Kamil]
>=20
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
> Need for help: "gmake check" in the added OpenBSD image fails with -ENO=
MEM
> errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? An=
d there
> is a warning from ./configure about OpenBSD going to be unsupported in =
coming
> releases, is it still the case?
>=20
> Fam
>=20
> Fam Zheng (10):
>   gitignore: Ignore vm test images
>   qemu.py: Add "wait()" method
>   tests: Add vm test lib
>   tests: Add ubuntu.i386 image
>   tests: Add FreeBSD image
>   tests: Add NetBSD image
>   tests: Add OpenBSD image
>   Makefile: Add rules to run vm tests
>   MAINTAINERS: Add tests/vm entry
>   tests: Add README for vm tests
>=20
>  .gitignore                |   2 +
>  MAINTAINERS               |   1 +
>  Makefile                  |   2 +
>  configure                 |   2 +-
>  scripts/qemu.py           |   7 ++
>  tests/vm/Makefile.include |  40 +++++++
>  tests/vm/README           |  63 +++++++++++
>  tests/vm/basevm.py        | 278 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/vm/freebsd          |  45 ++++++++
>  tests/vm/netbsd           |  45 ++++++++
>  tests/vm/openbsd          |  46 ++++++++
>  tests/vm/ubuntu.i386      |  88 +++++++++++++++
>  12 files changed, 618 insertions(+), 1 deletion(-)
>  create mode 100644 tests/vm/Makefile.include
>  create mode 100644 tests/vm/README
>  create mode 100755 tests/vm/basevm.py
>  create mode 100755 tests/vm/freebsd
>  create mode 100755 tests/vm/netbsd
>  create mode 100755 tests/vm/openbsd
>  create mode 100755 tests/vm/ubuntu.i386
>=20



--i3lR2iMcHgrNVRjvCNcN6xgR5EBSDtiWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnECuAAoJEEuzCOmwLnZsZiQP/joT3hLpW5xAhdtwswS5yZiF
7DCCBCUAtsPZFx1voBgFDwiDtmqaLJg4jPJMBlpqjT7vxGh1e8ax5eJIks8jdcuC
nl06qTWpzDAxv2jIRBu2MY1Wcc3jiHdg3THF5HC/YSwmcJauVJmzUopshAvr9fby
qDbFZ4OxkkJ422MmFjM+/O2O22i+BoqC+nnDUgMbEvVwNbl5Hj0eGrCC+4+27SEM
5hRIDwTj7e0FVuRxL++HkUHeWxyOQaNCx4zH2RYz2n6tT7M23vKv29oN/+XHA8OU
6tXI7+rTyktfU+PC/bn7JK2lB9fvjvLrHKevGF6l8txcW54ZJJ0yqBdyCkY+7x7A
vqhSbVKxuZr6svgmTBHNCYG3o6NJusOs5jP2itl28LueBUbfxixo9UljFNbnhiQC
kdgLY+28nwpW4WU6Jvrb+NLS1vSXJelavse0I1qfxJE2h7Y2unUPkD7HmWg4Y7VL
MyV4IB3xubo3rjQnU7NiGZkiOtP/zjR6s5CePKsFmgIaVVlnkbwfsvz2o8rWRF3M
17YOvKl+7c86oOKR2YRwn4BBHgmeofE7GCgJNubXGFJ2lejrK4sdUq2wtvqAGAsq
JOEtV5LDMmaOMkmaEF4tZoFNDyotObw8kJLfGiviM2N8tHELVsA7HkNSCaZC2ssj
cQr4iCxbjCN9MoaHGFtr
=2c+w
-----END PGP SIGNATURE-----

--i3lR2iMcHgrNVRjvCNcN6xgR5EBSDtiWj--
