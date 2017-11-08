Received: from eggs.gnu.org ([2001:4830:134:3::10]:49559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCHzc-0004c0-WD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCHzZ-0006VY-RQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:57066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCHzZ-0006VF-I5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCHzY-0007w9-81
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 04:29:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3BAB22E80C8
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 04:29:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2017 04:17:27 -0000
From: Launchpad Bug Tracker <1178101@bugs.launchpad.net>
Reply-To: Bug 1178101 <1178101@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130509055317.15126.74745.malonedeb@soybean.canonical.com>
Message-Id: <151011464807.16570.5760896280725705874.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1178101] Re: Could not enable gtk UI on build for
 Windows target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1178101

Title:
  Could not enable gtk UI on build for Windows target

Status in QEMU:
  Expired

Bug description:
  $ ${QEMU_SRC_DIR}/configure --prefix=3D${BIN_ROOT} --cross-
  prefix=3D${HOST_TRIPLET}- --extra-cflags=3D"-I${BIN_ROOT}/include"
  --extra-ldflags=3D"-L${BIN_ROOT}/lib" --enable-gtk --disable-xen

  ERROR: User requested feature gtk
         configure was not able to find it

  =

  $ cat config.log
  # QEMU configure log Thu May  9 13:50:40 CST 2013
  # Configured with: '/home/cauchy/vcs/git/qemu/configure' '--prefix=3D/hom=
e/cauchy/w32' '--cross-prefix=3Di686-w64-mingw32-' '--extra-cflags=3D-I/hom=
e/cauchy/w32/include' '--extra-ldflags=3D-L/home/cauchy/w32/lib' '--enable-=
gtk' '--disable-xen'
  #
  i686-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_=
SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings =
-Wmissing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -c -o =
/tmp/qemu-conf--18025-.o /tmp/qemu-conf--18025-.c
  /tmp/qemu-conf--18025-.c:2:2: error: #error __linux__ not defined
   #error __linux__ not defined
    ^
  i686-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_=
SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings =
-Wmissing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -c -o =
/tmp/qemu-conf--18025-.o /tmp/qemu-conf--18025-.c
  i686-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_=
SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings =
-Wmissing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -c -o =
/tmp/qemu-conf--18025-.o /tmp/qemu-conf--18025-.c
  i686-w64-mingw32-gcc -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_MEAN -=
DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissi=
ng-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -o /tmp/qemu-=
conf--18025-.exe /tmp/qemu-conf--18025-.c -g -L/home/cauchy/w32/lib -liberty
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -c -o /t=
mp/qemu-conf--18025-.o /tmp/qemu-conf--18025-.c
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Werror =
-Winitializer-overrides -o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--18025=
-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc: error: unrecognized command line option =E2=80=98-W=
initializer-overrides=E2=80=99
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Werror =
-Wendif-labels -o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--18025-.c -m32 =
-g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Werror -Wmissing-include-dirs -o /tmp/qemu-conf--18025-.exe /tmp/qe=
mu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Werror -Wempty-body -o /tmp/qemu-conf--18025=
-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Werror -Wnested-externs -o /tmp=
/qemu-conf--18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/=
lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Werror -Wforma=
t-security -o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -=
L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Werror -Wformat-y2k -o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--18025=
-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Werror -Winit-self -o /tmp/qemu-conf--18025-.exe /tmp/qemu=
-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Werror -Wignored-qualifiers -o /tmp/qemu-conf-=
-18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Werror -Wold-style-declar=
ation -o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/hom=
e/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
error -Wold-style-definition -o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--=
18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Werror -Wtype-limits -o /tmp/qemu-conf--18025-.exe /t=
mp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -Werror -fstack-protector-all -o /tmp/qe=
mu-conf--18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -fstack-protector-all -Werror -fno-gcse =
-o /tmp/qemu-conf--18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauc=
hy/w32/lib
  /tmp/qemu-conf--18025-.c:4:2: error: #error No bug in this compiler.
   #error No bug in this compiler.
    ^
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -fstack-protector-all -o /tmp/qemu-conf-=
-18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -fstack-protector-all -c -o /tmp/qemu-co=
nf--18025-.o /tmp/qemu-conf--18025-.c
  /tmp/qemu-conf--18025-.c:1:19: fatal error: sched.h: No such file or dire=
ctory
   #include <sched.h>
                     ^
  compilation terminated.
  i686-w64-mingw32-gcc -m32 -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_M=
EAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SO=
URCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -W=
missing-prototypes -fno-strict-aliasing -I/home/cauchy/w32/include -Wendif-=
labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -fstack-protector-all -o /tmp/qemu-conf-=
-18025-.exe /tmp/qemu-conf--18025-.c -m32 -g -L/home/cauchy/w32/lib -lz

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1178101/+subscriptions
