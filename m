Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB9Bd-0005vB-I8
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB9BZ-0001Yq-Cg
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:25:33 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB9BY-0001Y9-Ur
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:25:29 -0400
Received: by mail-qk0-x243.google.com with SMTP id p186so18635473qkd.1
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 18:25:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b4090f17-757c-a012-f608-f6950de031ef@amsat.org>
Date: Tue, 24 Apr 2018 22:25:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Bkl98VXX5p5WYTDz99dfyzSuA65rBoS3j"
Subject: Re: [Qemu-devel] [PATCH v3 00/46] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, Agustin Henze <tin@debian.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Ulises Vitulli <dererk@debian.org>, YunQiang Su <syq@debian.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bkl98VXX5p5WYTDz99dfyzSuA65rBoS3j
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Agustin Henze <tin@debian.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com,
 berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de,
 qemu-devel@nongnu.org, Ulises Vitulli <dererk@debian.org>,
 YunQiang Su <syq@debian.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <b4090f17-757c-a012-f608-f6950de031ef@amsat.org>
Subject: Re: [PATCH v3 00/46] fix building of tests/tcg
References: <20180424152405.10304-1-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This is starting to shape up pretty nicely. I was able to add a whole
> bunch of additional architectures thanks to cross compilers in Debian
> Sid which are there to support the Debian "ports". These may not be
> around for ever, most "ports" are on the way out, but they will be the
> last thing to drop out of the Sid repo. Maybe when Debian stops
> caring (and no other distro does) maybe we should to?

I *think* working with Sid is not recommended as very unstable and not
reproducible. A reproducible way is to use the Debian Snapshot Archive
(http://snapshot.debian.org/) eventually using package specific version
and holding packages at this version.

I found an example in the following post:
https://blog.sleeplessbeastie.eu/2017/07/17/how-to-install-packages-using=
-repository-snapshot/

(I Cc'ed Debian experts who might have a better idea).


For stable releases, this shouldn't be a problem since End of Life
Debian versions stay on archive.debian.org; as for Docker images:

https://hub.docker.com/r/debian/eol/

> However compiling big-endian targets continues to be a massive pain as
> even if compilers support switching endianess with flags you are
> usually let down by a partial set of headers or the linker not being
> able to link against wrong-endian crt.o or libgcc files. Ultimately

=C2=AF\_(=E3=83=84)_/=C2=AF https://bugs.launchpad.net/gcc-arm-embedded/+=
bug/1718206

> any guests that are not supported by any distro are probably going to
> be stuck with bare metal or hand crafted tests like in
> tests/tcg/alpha.
>=20
> The final patch (tests/tcg: override runners for broken tests)
> suppresses a bunch of tests that fail on different guest setups. This
> was to allow me to test "make check-tcg" could make it all the way
> through. I'm sure some of them are bugs that need fixing so it would
> be cool if maintainers could look through and see if there are any
> easy wins.
>=20
> Major Changes:
>   - check-tcg now runs the tests (c.f build-tcg/clean-tcg)
>   - clean use of quiet-command for CROSS-BUILD/RUN-TESTS and TEST
>   - bunch of additional targets (alpha, hppa, m68k, sh4, sparc64, mips6=
4)
>   - review comments and tags
>   - dropped fp-test and additional aarch64 tests for now
>=20
> As usual detailed notes are bellow the --- in the commit messages.
>=20
> Currently un-reviewed:
>=20
> patch 0002/configure add test for docker availability.patch needs revie=
w
> patch 0003/configure add support for cross cc FOO.patch needs review
> patch 0004/configure move i386_cc to cross_cc_i386.patch needs review
> patch 0005/configure allow user to specify cross cc cflags f.patch need=
s review
> patch 0014/tests tcg multiarch enable additional linux test .patch need=
s review
> patch 0015/tests tcg multiarch move most output to stdout.patch needs r=
eview
> patch 0017/docker Add fedora i386 cross image.patch needs review
> patch 0018/tests tcg enable building for i386.patch needs review
> patch 0021/tests tcg i386 fix test i386 fprem.patch needs review
> patch 0022/tests tcg i386 disable i386 version of test i386 .patch need=
s review
> patch 0023/tests tcg x86_64 add Makefile.target.patch needs review
> patch 0025/tests tcg i386 test i386 fix printf format.patch needs revie=
w
> patch 0027/tests tcg arm fix up test arm iwmmxt test.patch needs review=

> patch 0028/tests tcg aarch64 add Makefile.target.patch needs review
> patch 0029/tests tcg aarch64 add fcvt test cases for AArch64.patch need=
s review
> patch 0031/tests tcg enable building for MIPS.patch needs review
> patch 0032/tests tcg mips include common mips hello mips.patch needs re=
view
> patch 0035/tests tcg enable building for Alpha.patch needs review
> patch 0036/tests tcg alpha add Alpha specific tests.patch needs review
> patch 0037/tests tcg alpha fix warnings about write.patch needs review
> patch 0038/tests tcg enable building for HPPA.patch needs review
> patch 0039/tests tcg enable building for m68k.patch needs review
> patch 0040/tests tcg enable building for sh4.patch needs review
> patch 0041/tests tcg enable building for sparc64.patch needs review
> patch 0042/tests tcg enable building for mips64.patch needs review
> patch 0043/tests tcg Makefile update to be called from Makef.patch need=
s review
> patch 0044/Makefile.target add clean guest tests targets.patch needs re=
view
> patch 0046/tests tcg override runners for broken tests UPSTR.patch need=
s review
>=20
>=20
> Alex Benn=C3=A9e (41):
>   configure: add test for docker availability
>   configure: add support for --cross-cc-FOO
>   configure: move i386_cc to cross_cc_i386
>   configure: allow user to specify --cross-cc-cflags-foo=3D
>   configure: set cross_cc_FOO for host compiler
>   docker: Add "cc" subcommand
>   docker: extend "cc" command to accept compiler
>   docker: allow "cc" command to run in user context
>   docker: Makefile.include introduce DOCKER_SCRIPT
>   tests/tcg: move architecture independent tests into subdir
>   tests/tcg/multiarch: enable additional linux-test tests
>   tests/tcg/multiarch: move most output to stdout
>   tests/tcg: move i386 specific tests into subdir
>   tests/tcg: enable building for i386
>   tests/tcg/i386: fix test-i386
>   tests/tcg/i386: fix test-i386-fprem
>   tests/tcg/i386: disable i386 version of test-i386-ssse
>   tests/tcg/x86_64: add Makefile.target
>   tests/tcg/i386/test-i386: use modern vector_size attributes
>   tests/tcg/i386/test-i386: fix printf format
>   tests/tcg: move ARM specific tests into subdir
>   tests/tcg/arm: fix up test-arm-iwmmxt test
>   tests/tcg/aarch64: add Makefile.target
>   tests/tcg/aarch64: add fcvt test cases for AArch64
>   tests/tcg: move MIPS specific tests into subdir
>   tests/tcg: enable building for MIPS
>   tests/tcg/mips: include common mips hello-mips
>   tests/tcg: enable building for s390x
>   tests/tcg: enable building for ppc64
>   tests/tcg: enable building for Alpha
>   tests/tcg/alpha: add Alpha specific tests
>   tests/tcg/alpha: fix warnings about write()
>   tests/tcg: enable building for HPPA
>   tests/tcg: enable building for m68k
>   tests/tcg: enable building for sh4
>   tests/tcg: enable building for sparc64
>   tests/tcg: enable building for mips64
>   tests/tcg/Makefile: update to be called from Makefile.target
>   Makefile.target: add (clean-)guest-tests targets
>   tests/Makefile.include: add [build|clean|check]-tcg targets
>   tests/tcg: override runners for broken tests (!UPSTREAM)
>=20
> Fam Zheng (4):
>   Makefile: Rename TARGET_DIRS to TARGET_LIST
>   tests/tcg/multiarch: Build fix for linux-test
>   docker: Add fedora-i386-cross image
>   tests/tcg/i386: Build fix for hello-i386
>=20
> Peter Maydell (1):
>   docker: add "probe" command for configure
>=20
>  Makefile                                      |   20 +-
>  Makefile.target                               |    5 +
>  configure                                     |  136 +-
>  scripts/create_config                         |    2 +-
>  tests/Makefile.include                        |   28 +-
>  tests/docker/Makefile.include                 |   16 +-
>  tests/docker/docker.py                        |   49 +
>  .../dockerfiles/debian-alpha-cross.docker     |   12 +
>  .../dockerfiles/debian-cross-build.docker     |   36 +
>  .../dockerfiles/debian-hppa-cross.docker      |   12 +
>  .../dockerfiles/debian-m68k-cross.docker      |   12 +
>  .../dockerfiles/debian-mips64-cross.docker    |   12 +
>  .../dockerfiles/debian-sh4-cross.docker       |   12 +
>  tests/docker/dockerfiles/debian-sid.docker    |   23 +
>  .../dockerfiles/debian-sparc64-cross.docker   |   12 +
>  .../dockerfiles/fedora-i386-cross.docker      |   14 +
>  tests/tcg/Makefile                            |  193 +--
>  tests/tcg/Makefile.include                    |   86 ++
>  tests/tcg/README                              |   69 +-
>  tests/tcg/aarch64/Makefile.target             |   13 +
>  tests/tcg/aarch64/fcvt.c                      |  260 ++++
>  tests/tcg/aarch64/fcvt.out                    | 1305 +++++++++++++++++=

>  tests/tcg/alpha/Makefile                      |   35 -
>  tests/tcg/alpha/Makefile.include              |    2 +
>  tests/tcg/alpha/Makefile.target               |   36 +
>  tests/tcg/alpha/{crt.s =3D> crt.S}              |    0
>  tests/tcg/alpha/hello-alpha.c                 |    2 +
>  tests/tcg/alpha/test-cond.c                   |    1 +
>  tests/tcg/alpha/test-ovf.c                    |    2 +
>  tests/tcg/arm/Makefile.target                 |   20 +
>  tests/tcg/arm/README                          |   11 +
>  tests/tcg/{ =3D> arm}/hello-arm.c               |    0
>  .../test-arm-iwmmxt.S}                        |    0
>  tests/tcg/hppa/Makefile.include               |    2 +
>  tests/tcg/hppa/Makefile.target                |   10 +
>  tests/tcg/i386/Makefile.include               |    9 +
>  tests/tcg/i386/Makefile.target                |   52 +
>  tests/tcg/i386/README                         |   38 +
>  tests/tcg/{ =3D> i386}/hello-i386.c             |    1 +
>  tests/tcg/{ =3D> i386}/pi_10.com                |  Bin
>  tests/tcg/{ =3D> i386}/runcom.c                 |    0
>  tests/tcg/{ =3D> i386}/test-i386-code16.S       |    0
>  tests/tcg/{ =3D> i386}/test-i386-fprem.c        |   12 +-
>  tests/tcg/{ =3D> i386}/test-i386-muldiv.h       |    0
>  tests/tcg/{ =3D> i386}/test-i386-shift.h        |    0
>  tests/tcg/{ =3D> i386}/test-i386-ssse3.c        |    0
>  tests/tcg/{ =3D> i386}/test-i386-vm86.S         |    0
>  tests/tcg/{ =3D> i386}/test-i386.c              |    7 +-
>  tests/tcg/{ =3D> i386}/test-i386.h              |    0
>  tests/tcg/m68k/Makefile.include               |    2 +
>  tests/tcg/m68k/Makefile.target                |   11 +
>  tests/tcg/mips/Makefile.include               |   20 +
>  tests/tcg/mips/Makefile.target                |   29 +
>  tests/tcg/mips/README                         |    7 +
>  tests/tcg/{ =3D> mips}/hello-mips.c             |    0
>  tests/tcg/multiarch/Makefile.target           |   29 +
>  tests/tcg/multiarch/README                    |    1 +
>  tests/tcg/{ =3D> multiarch}/linux-test.c        |   93 +-
>  tests/tcg/{ =3D> multiarch}/sha1.c              |    0
>  tests/tcg/{ =3D> multiarch}/test-mmap.c         |   38 +-
>  tests/tcg/{ =3D> multiarch}/testthread.c        |    0
>  tests/tcg/ppc64le/Makefile.include            |    2 +
>  tests/tcg/s390x/Makefile.include              |    2 +
>  tests/tcg/s390x/Makefile.target               |    6 +
>  tests/tcg/sh4/Makefile.include                |    4 +
>  tests/tcg/sh4/Makefile.target                 |    6 +
>  tests/tcg/sparc64/Makefile.include            |    2 +
>  tests/tcg/sparc64/Makefile.target             |    8 +
>  tests/tcg/test_path.c                         |  157 --
>  tests/tcg/x86_64/Makefile.target              |   15 +
>  70 files changed, 2495 insertions(+), 504 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-cross-build.docker
>  create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker=

>  create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-sid.docker
>  create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docke=
r
>  create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
>  create mode 100644 tests/tcg/Makefile.include
>  create mode 100644 tests/tcg/aarch64/Makefile.target
>  create mode 100644 tests/tcg/aarch64/fcvt.c
>  create mode 100644 tests/tcg/aarch64/fcvt.out
>  delete mode 100644 tests/tcg/alpha/Makefile
>  create mode 100644 tests/tcg/alpha/Makefile.include
>  create mode 100644 tests/tcg/alpha/Makefile.target
>  rename tests/tcg/alpha/{crt.s =3D> crt.S} (100%)
>  create mode 100644 tests/tcg/arm/Makefile.target
>  create mode 100644 tests/tcg/arm/README
>  rename tests/tcg/{ =3D> arm}/hello-arm.c (100%)
>  rename tests/tcg/{test-arm-iwmmxt.s =3D> arm/test-arm-iwmmxt.S} (100%)=

>  create mode 100644 tests/tcg/hppa/Makefile.include
>  create mode 100644 tests/tcg/hppa/Makefile.target
>  create mode 100644 tests/tcg/i386/Makefile.include
>  create mode 100644 tests/tcg/i386/Makefile.target
>  create mode 100644 tests/tcg/i386/README
>  rename tests/tcg/{ =3D> i386}/hello-i386.c (96%)
>  rename tests/tcg/{ =3D> i386}/pi_10.com (100%)
>  rename tests/tcg/{ =3D> i386}/runcom.c (100%)
>  rename tests/tcg/{ =3D> i386}/test-i386-code16.S (100%)
>  rename tests/tcg/{ =3D> i386}/test-i386-fprem.c (97%)
>  rename tests/tcg/{ =3D> i386}/test-i386-muldiv.h (100%)
>  rename tests/tcg/{ =3D> i386}/test-i386-shift.h (100%)
>  rename tests/tcg/{ =3D> i386}/test-i386-ssse3.c (100%)
>  rename tests/tcg/{ =3D> i386}/test-i386-vm86.S (100%)
>  rename tests/tcg/{ =3D> i386}/test-i386.c (99%)
>  rename tests/tcg/{ =3D> i386}/test-i386.h (100%)
>  create mode 100644 tests/tcg/m68k/Makefile.include
>  create mode 100644 tests/tcg/m68k/Makefile.target
>  create mode 100644 tests/tcg/mips/Makefile.include
>  create mode 100644 tests/tcg/mips/Makefile.target
>  create mode 100644 tests/tcg/mips/README
>  rename tests/tcg/{ =3D> mips}/hello-mips.c (100%)
>  create mode 100644 tests/tcg/multiarch/Makefile.target
>  create mode 100644 tests/tcg/multiarch/README
>  rename tests/tcg/{ =3D> multiarch}/linux-test.c (87%)
>  rename tests/tcg/{ =3D> multiarch}/sha1.c (100%)
>  rename tests/tcg/{ =3D> multiarch}/test-mmap.c (94%)
>  rename tests/tcg/{ =3D> multiarch}/testthread.c (100%)
>  create mode 100644 tests/tcg/ppc64le/Makefile.include
>  create mode 100644 tests/tcg/s390x/Makefile.include
>  create mode 100644 tests/tcg/s390x/Makefile.target
>  create mode 100644 tests/tcg/sh4/Makefile.include
>  create mode 100644 tests/tcg/sh4/Makefile.target
>  create mode 100644 tests/tcg/sparc64/Makefile.include
>  create mode 100644 tests/tcg/sparc64/Makefile.target
>  delete mode 100644 tests/tcg/test_path.c
>  create mode 100644 tests/tcg/x86_64/Makefile.target
>=20


--Bkl98VXX5p5WYTDz99dfyzSuA65rBoS3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrf2P4ACgkQ4+MsLN6t
wN43mw//RFX2EbEyjS0RitgOJ7gzVAk16T/sX0hbQTPf5g6VlIERMlqLC0EErmws
hgfk7pyOR+90IHHoWKkj3D+faW2g2/PwM6nC3k6gT3vVbAWT7Yqt6140OZnFEVzp
S5Hf1WgeaTMU1L4PloSuSmghhvv+37mpLZztVHPMyP4Eq0IgBdbIjoRhj+/6cMVU
jUOBqvMvfFgD2ISQDq3O8bxGiHHUThM3j3IVAlb+EuMYHCqfssa5W2G/XAorF31F
lbbDXt87E0Z/Rxit5J93n1n3k/ku4U3xC7ValbuHCX39elFxyo93XgiAFRZgDFET
ot0W2lE8jes4HCpbsIP68mDq8MyjbdTvJ0A2Yb0Z7OxT3Pq8TBrf3Qx/r9PS96VJ
YAoT63GTFp8rsZ856Vbb5a3y8Qoo2He9xzCfD/gXgedOZu+2FCRXOdm8OP/VBxQE
neI3pkdrZEhGXex0HY0/Mg8OK8jDE04Tx1Us9gDsyc4728i34Z9miXurAuY/X9s4
9GSFZE7AyFOP6coESEGb9JiLngWFHD2NHcl9lcjM/mejLWnoojkbnO1SH6hc8M84
OGRHbtzhSM6RBr1PHDGSgsICm02GNUmXbyKIlPR7+8q0BGYWlaW/lJYGdSGuBdIB
ksiJyWOt2LD805w+deRMq/Q+Wam2Jbu/g/AAQY7n2rTwLgUMbo0=
=sX5g
-----END PGP SIGNATURE-----

--Bkl98VXX5p5WYTDz99dfyzSuA65rBoS3j--
