Received: from eggs.gnu.org ([2001:4830:134:3::10]:59678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1fFHLg-0005IF-M4
	for qemu-devel@nongnu.org; Sun, 06 May 2018 06:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1fFHLf-0006Oi-9U
	for qemu-devel@nongnu.org; Sun, 06 May 2018 06:57:00 -0400
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 6 May 2018 12:56:54 +0200
Message-ID: <CABLmASE-AqqfVEZ5Q-vWBuXRTHTHhW9=c5f2PRZ34tVCMiRfdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Compilation error for qemu-system-ppc on Fedora 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi all,

I get these errors compiling qemu-system-ppc on Fedora 28, gcc 8.0.1:

/home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce500_load_=
device_tree=E2=80=99:
/home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=E2=80=
=99
directive output may be truncated writing 5 bytes into a region of
size between 1 and 128 [-Werror=3Dformat-truncation=3D]
     snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_REGS_OFF=
SET);
                                     ^~~~~
In file included from /usr/include/stdio.h:862,
                 from /home/hsp/src/qemu-master/include/qemu/osdep.h:68,
                 from /home/hsp/src/qemu-master/hw/ppc/e500.c:17:
/usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99
output between 11 and 138 bytes into a destination of size 128
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/hsp/src/qemu-master/hw/ppc/e500.c:470:39: error:
=E2=80=98/global-utilities@=E2=80=99 directive output may be truncated writ=
ing 18
bytes into a region of size between 1 and 128
[-Werror=3Dformat-truncation=3D]
     snprintf(gutil, sizeof(gutil), "%s/global-utilities@%llx", soc,
                                       ^~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from /home/hsp/src/qemu-master/include/qemu/osdep.h:68,
                 from /home/hsp/src/qemu-master/hw/ppc/e500.c:17:
/usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99
output between 24 and 151 bytes into a destination of size 128
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/hsp/src/qemu-master/hw/ppc/e500.c:477:36: error: =E2=80=98/msi@=E2=80=
=99
directive output may be truncated writing 5 bytes into a region of
size between 0 and 127 [-Werror=3Dformat-truncation=3D]
     snprintf(msi, sizeof(msi), "/%s/msi@%llx", soc, MPC8544_MSI_REGS_OFFSE=
T);
                                    ^~~~~
In file included from /usr/include/stdio.h:862,
                 from /home/hsp/src/qemu-master/include/qemu/osdep.h:68,
                 from /home/hsp/src/qemu-master/hw/ppc/e500.c:17:
/usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99
output between 12 and 139 bytes into a destination of size 128
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [/home/hsp/src/qemu-master/rules.mak:66: hw/ppc/e500.o] Error =
1
make: *** [Makefile:478: subdir-ppc-softmmu] Error 2

gcc -v
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap
--enable-languages=3Dc,c++,objc,obj-c++,fortran,ada,go,lto --prefix=3D/usr
--mandir=3D/usr/share/man --infodir=3D/usr/share/info
--with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla --enable-shared
--enable-threads=3Dposix --enable-checking=3Drelease --enable-multilib
--with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-gnu-unique-object
--enable-linker-build-id --with-gcc-major-version-only
--with-linker-hash-style=3Dgnu --enable-plugin --enable-initfini-array
--with-isl --enable-libmpx --enable-offload-targets=3Dnvptx-none
--without-cuda-driver --enable-gnu-indirect-function
--with-tune=3Dgeneric --with-arch_32=3Di686 --build=3Dx86_64-redhat-linux
Thread model: posix
gcc version 8.0.1 20180324 (Red Hat 8.0.1-0.20) (GCC)

Best, Howard
