Received: from eggs.gnu.org ([209.51.188.92]:60215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJEuH-00055N-4N
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJErW-0008Uk-98
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:52676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJErW-0008Se-1f
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:10:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJErU-0000Ii-O2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AF3BA2E8058
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 09:58:01 -0000
From: Gwendolyn Haller <1826172@bugs.launchpad.net>
Reply-To: Bug 1826172 <1826172@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155609911336.14005.5630723939838624325.malonedeb@gac.canonical.com>
Message-Id: <155609988130.6774.16636212352386756831.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826172] Re: Compilation on MSYS2/MinGW-w64 fails
 with error: "__USE_MINGW_ANSI_STDIO" redefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

MinGW-w64 toolchain version:

$ pacman -Ss mingw-w64-x86_64-toolchain
mingw64/mingw-w64-x86_64-binutils 2.30-5 (mingw-w64-x86_64-toolchain) [inst=
alled]
    A set of programs to assemble and manipulate binary and object files (m=
ingw-w64)
mingw64/mingw-w64-x86_64-crt-git 7.0.0.5397.291c4f8d-1 (mingw-w64-x86_64-to=
olchain) [installed]
    MinGW-w64 CRT for Windows
mingw64/mingw-w64-x86_64-gcc 8.3.0-2 (mingw-w64-x86_64-toolchain) [installe=
d]
    GNU Compiler Collection (C,C++,OpenMP) for MinGW-w64
mingw64/mingw-w64-x86_64-gcc-ada 8.3.0-2 (mingw-w64-x86_64-toolchain) [inst=
alled]
    GNU Compiler Collection (Ada) for MinGW-w64
mingw64/mingw-w64-x86_64-gcc-fortran 8.3.0-2 (mingw-w64-x86_64-toolchain) [=
installed]
    GNU Compiler Collection (Fortran) for MinGW-w64
mingw64/mingw-w64-x86_64-gcc-libgfortran 8.3.0-2 (mingw-w64-x86_64-toolchai=
n) [installed]
    GNU Compiler Collection (libgfortran) for MinGW-w64
mingw64/mingw-w64-x86_64-gcc-libs 8.3.0-2 (mingw-w64-x86_64-toolchain) [ins=
talled]
    GNU Compiler Collection (libraries) for MinGW-w64
mingw64/mingw-w64-x86_64-gcc-objc 8.3.0-2 (mingw-w64-x86_64-toolchain) [ins=
talled]
    GNU Compiler Collection (ObjC,Obj-C++) for MinGW-w64
mingw64/mingw-w64-x86_64-gdb 8.2.1-2 (mingw-w64-x86_64-toolchain) [installe=
d]
    GNU Debugger (mingw-w64)
mingw64/mingw-w64-x86_64-headers-git 7.0.0.5397.291c4f8d-1 (mingw-w64-x86_6=
4-toolchain) [installed]
    MinGW-w64 headers for Windows
mingw64/mingw-w64-x86_64-libmangle-git 7.0.0.5230.69c8fad6-1 (mingw-w64-x86=
_64-toolchain) [installed]
    MinGW-w64 libmangle
mingw64/mingw-w64-x86_64-libwinpthread-git 7.0.0.5325.11a5459d-1 (mingw-w64=
-x86_64-toolchain) [installed]
    MinGW-w64 winpthreads library
mingw64/mingw-w64-x86_64-make 4.2.1-2 (mingw-w64-x86_64-toolchain) [install=
ed]
    GNU make utility to maintain groups of programs (mingw-w64)
mingw64/mingw-w64-x86_64-pkg-config 0.29.2-1 (mingw-w64-x86_64-toolchain) [=
installed]
    A system for managing library compile/link flags (mingw-w64)
mingw64/mingw-w64-x86_64-tools-git 7.0.0.5394.0dfb3d3f-1 (mingw-w64-x86_64-=
toolchain) [installed]
    MinGW-w64 tools
mingw64/mingw-w64-x86_64-winpthreads-git 7.0.0.5325.11a5459d-1 (mingw-w64-x=
86_64-toolchain) [installed]
    MinGW-w64 winpthreads library
mingw64/mingw-w64-x86_64-winstorecompat-git 7.0.0.5394.0dfb3d3f-1 (mingw-w6=
4-x86_64-toolchain) [installed]
    MinGW-w64 winRT compat library

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826172

Title:
  Compilation on MSYS2/MinGW-w64 fails with error:
  "__USE_MINGW_ANSI_STDIO" redefined

Status in QEMU:
  New

Bug description:
  Compilation against GIT master fails at the following step:

  =C2=A0=C2=A0CC      qga/commands.o
  In file included from qga/commands.c:13:
  C:/Tempy-chan/qemu/include/qemu/osdep.h:97: error: "__USE_MINGW_ANSI_STDI=
O" redefined [-Werror]
  =C2=A0#define __USE_MINGW_ANSI_STDIO 1

  In file included from C:/msys64/mingw64/x86_64-w64-mingw32/include/vadefs=
.h:9,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/_mingw_stdarg.h:14,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/stdarg.h:140,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/lib/gcc/x86_64-w64-min=
gw32/8.3.0/include/stdarg.h:1,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/Tempy-chan/qemu/include/qemu/osdep.h:=
88,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from qga/commands.c:13:
  C:/msys64/mingw64/x86_64-w64-mingw32/include/_mingw.h:431: note: this is =
the location of the previous definition
  =C2=A0#define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it shou=
ld be 0 */

  cc1.exe: all warnings being treated as errors
  make: *** [/c/Tempy-chan/qemu/rules.mak:69: qga/commands.o] Error 1

  Passing --extra-cflags=3D"-D__USE_MINGW_ANSI_STDIO" to configure
  resolves the error. Digging deeper in
  x86_64-w64-mingw32/include/_mingw.h, it looks like
  __USE_MINGW_ANSI_STDIO is only defined for _GNU_SOURCE in C++
  compilation. With C only code it's ignored and doesn't define
  __USE_MINGW_ANSI_STDIO as expected:

  /* We are activating __USE_MINGW_ANSI_STDIO for various define indicators.
  =C2=A0=C2=A0=C2=A0Note that we enable it also for _GNU_SOURCE in C++, but=
 not for C case. */
  #if (defined (_POSIX) || defined (_POSIX_SOURCE) || defined (_POSIX_C_SOU=
RCE) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_ISOC99_SOURCE) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_XOPEN_SOURCE) || defined (_XOP=
EN_SOURCE_EXTENDED) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (defined (_GNU_SOURCE) && defined (__cpl=
usplus)) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_SVID_SOURCE)) \
  =C2=A0=C2=A0=C2=A0=C2=A0&& !defined(__USE_MINGW_ANSI_STDIO)
  /* Enable __USE_MINGW_ANSI_STDIO if _POSIX defined
  =C2=A0* and If user did _not_ specify it explicitly... */
  #  define __USE_MINGW_ANSI_STDIO			1
  #endif

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826172/+subscriptions
