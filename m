Received: from eggs.gnu.org ([2001:4830:134:3::10]:42647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpk29-0006dY-VJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpk24-0001Lw-Of
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:51:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:58078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpk24-0001JC-Cb
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:51:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpk22-0006tE-ED
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 00:51:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 044F92E8528
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 00:51:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 00:45:00 -0000
From: Michele Denber <1785698@bugs.launchpad.net>
Reply-To: Bug 1785698 <1785698@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153358448492.29549.3601216229452882398.malonedeb@chaenomeles.canonical.com>
	<5B7334CA.9000702@gmx.com>
Message-Id: <5B73778C.4090704@gmx.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785698] Did this work?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Here's a mystery.  It looks like I finally have a clean compile - there =

are no error messages but I don't see an executable.  Is there supposed =

to be something called "qemu" somewhere now?  I looked in build/, the =

top level, and /usr/local/bin/.

# gmake V=3D1
(cd /export/home/denber/qemu-2.12.0; if test -n ""; then pkgvers=3D""; =

else if test -d .git; then pkgvers=3D$(git describe --match 'v*' =

2>/dev/null | tr -d '\n'); if ! git diff-index --quiet HEAD &>/dev/null; =

then pkgvers=3D"${pkgvers}-dirty"; fi; fi; fi; printf "#define =

QEMU_PKGVERSION \"${pkgvers}\"\n"; if test -n "${pkgvers}"; then printf =

'#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"\n'; =

else printf '#define QEMU_FULL_VERSION QEMU_VERSION\n'; fi; ) > =

qemu-version.h.tmp
if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv =

qemu-version.h.tmp qemu-version.h; else rm qemu-version.h.tmp; fi
mkdir -p dtc/libfdt
mkdir -p dtc/tests
gmake -I/export/home/denber/qemu-2.12.0/dtc =

VPATH=3D/export/home/denber/qemu-2.12.0/dtc -C dtc V=3D"1" =

LIBFDT_srcdir=3D/export/home/denber/qemu-2.12.0/dtc/libfdt =

CPPFLAGS=3D"-I/export/home/denber/qemu-2.12.0/build/dtc =

-I/export/home/denber/qemu-2.12.0/dtc =

-I/export/home/denber/qemu-2.12.0/dtc/libfdt" CFLAGS=3D"-O2 =

-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g  -I/opt/csw/include/pixman-1   =

-I/export/home/denber/qemu-2.12.0/dtc/libfdt -D_REENTRANT -D_PTHREADS =

-I/opt/csw/include/glib-2.0 -I/opt/csw/lib/glib-2.0/include   -m32 =

-mv8plus -mcpu=3Dultrasparc -std=3Dgnu99 -D__EXTENSIONS__ =

-D_XOPEN_SOURCE=3D600 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 =

-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef =

-Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common =

-fwrapv  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-value =

-Wno-missing-include-dirs -Wempty-body -Wnested-externs =

-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers =

-Wold-style-declaration -Wold-style-definition -Wtype-limits =

-fstack-protector-strong -I/opt/csw/include  -I/usr/include/libpng12   =

-I/export/home/denber/qemu-2.12.0/capstone/include =

-I/export/home/denber/qemu-2.12.0/tests" LDFLAGS=3D"-m32 -mv8plus -g " =

ARFLAGS=3D"rv" CC=3D"gcc" AR=3D"ar" LD=3D"ld"  =

BUILD_DIR=3D/export/home/denber/qemu-2.12.0/build libfdt/libfdt.a
gmake[1]: Entering directory '/export/home/denber/qemu-2.12.0/build/dtc'
gmake[1]: 'libfdt/libfdt.a' is up to date.
gmake[1]: Leaving directory '/export/home/denber/qemu-2.12.0/build/dtc'
gmake -C /export/home/denber/qemu-2.12.0/capstone CAPSTONE_SHARED=3Dno =

BUILDDIR=3D"/export/home/denber/qemu-2.12.0/build/capstone" CC=3D"gcc" =

AR=3D"ar" LD=3D"ld" RANLIB=3D"ranlib" CFLAGS=3D"-O2 -U_FORTIFY_SOURCE =

-D_FORTIFY_SOURCE=3D2 -g -I/opt/csw/include/pixman-1 =

-I/export/home/denber/qemu-2.12.0/dtc/libfdt -D_REENTRANT -D_PTHREADS =

-I/opt/csw/include/glib-2.0 -I/opt/csw/lib/glib-2.0/include -m32 =

-mv8plus -mcpu=3Dultrasparc -std=3Dgnu99 -D__EXTENSIONS__ =

-D_XOPEN_SOURCE=3D600 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 =

-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv =

-fstack-protector-strong -I/opt/csw/include -I/usr/include/libpng12 =

-I/export/home/denber/qemu-2.12.0/capstone/include =

-I/export/home/denber/qemu-2.12.0/tests -DCAPSTONE_USE_SYS_DYN_MEM =

-DCAPSTONE_HAS_ARM -DCAPSTONE_HAS_ARM64 -DCAPSTONE_HAS_POWERPC =

-DCAPSTONE_HAS_X86"  BUILD_DIR=3D/export/home/denber/qemu-2.12.0/build =

/export/home/denber/qemu-2.12.0/build/capstone/libcapstone.a
gmake[1]: Entering directory '/export/home/denber/qemu-2.12.0/capstone'
gmake[1]: '/export/home/denber/qemu-2.12.0/build/capstone/libcapstone.a' =

is up to date.
gmake[1]: Leaving directory '/export/home/denber/qemu-2.12.0/capstone'
gmake  BUILD_DIR=3D/export/home/denber/qemu-2.12.0/build -C x86_64-softmmu =

V=3D"1" TARGET_DIR=3D"x86_64-softmmu/" all
gmake[1]: Entering directory =

'/export/home/denber/qemu-2.12.0/build/x86_64-softmmu'
gmake[1]: Leaving directory =

'/export/home/denber/qemu-2.12.0/build/x86_64-softmmu'
#

I even did a gmake clean and then gmake again.  No change - no errors =

and no executable.  ???

             - Michele

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785698

Title:
  Solaris build error: unknown type name =E2=80=98gcry_error_t=E2=80=99

Status in QEMU:
  New

Bug description:
  Building qemu 2.12.0 on a Sun Oracle Enterprise M3000 SPARC64 VII,
  Solaris 10 Update 11, opencsw toolchain and gcc 7.3.0, gmake fails
  with a bunch of related errors all in cypher-gcrypt.c:

  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_encrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                ^~~~~~~~~=
~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_cipher_info
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:49: error: exp=
ected =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_encrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                         =
        ^~~
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:11: error: too=
 few arguments to function =E2=80=98gcry_cipher_encrypt=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_encrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);           ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:566:5: note: declared here
  =C2=A0int gcry_cipher_encrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_xts_decrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:271:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_decrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                ^~~~~~~~~=
~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_cipher_info
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:49: error: exp=
ected =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_decrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                         =
        ^~~
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:11: error: too=
 few arguments to function =E2=80=98gcry_cipher_decrypt=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_decrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);           ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:571:5: note: declared here
  =C2=A0int gcry_cipher_decrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_encrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:284:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:21: warning: p=
assing argument 1 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_encrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_encrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:34: warning: p=
assing argument 2 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_encrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_encrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:298:35: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_encrypt=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher=
_encrypt(ctx->handle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:566:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
  =C2=A0int gcry_cipher_encrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_decrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:320:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:21: warning: p=
assing argument 1 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_decrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_decrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:34: warning: p=
assing argument 2 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_decrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_decrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:334:35: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_decrypt=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher=
_decrypt(ctx->handle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:571:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
  =C2=A0int gcry_cipher_decrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_setiv=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:353:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: i=
mplicit declaration of function =E2=80=98gcry_cipher_setctr=E2=80=99; did y=
ou mean =E2=80=98gcry_cipher_setiv=E2=80=99? [-Wimplicit-function-declarati=
on]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_cipher_setiv
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: n=
ested extern declaration of =E2=80=98gcry_cipher_setctr=E2=80=99 [-Wnested-=
externs]
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: i=
mplicit declaration of function =E2=80=98gcry_cipher_reset=E2=80=99; did yo=
u mean =E2=80=98gcry_cipher_close=E2=80=99? [-Wimplicit-function-declaratio=
n]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0gcry_cipher_reset(ctx->handle);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^~~~~~~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0gcry_cipher_close
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: n=
ested extern declaration of =E2=80=98gcry_cipher_reset=E2=80=99 [-Wnested-e=
xterns]
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:373:19: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_ctl=E2=80=99 makes pointer from i=
nteger without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0err =3D gcry_cipher_setiv(ctx->handle, iv, niv);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:540:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
  =C2=A0int gcry_cipher_ctl( GcryCipherHd h, int cmd, void *buffer, size_t =
buflen);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~
  gmake: *** [/export/home/denber/qemu-2.12.0/rules.mak:67: crypto/cipher.o=
] Error 1

  ---------------------------------------------------------------------

  I do have libgcrypt, libgcrypt_dev, and libgcrypt_utils installed from
  opencsw.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785698/+subscriptions
