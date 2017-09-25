Received: from eggs.gnu.org ([2001:4830:134:3::10]:34338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwYXA-0004Sq-6S
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwYX7-0000Qg-1J
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:55:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dwYX6-0000Pt-Rk
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:55:08 -0400
Date: Mon, 25 Sep 2017 14:55:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170925185507.GA11022@flamenco>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<20170922224855.GA6905@flamenco> <87fubawt1q.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87fubawt1q.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 25, 2017 at 21:07:45 +0300, Llu=EDs Vilanova wrote:
> You're doing it right, and I've checked that the branch is properly pushe=
d. Can
> you compile with V=3D1 to show me the failing cmdline?

$ make V=3D1
(cd /data/src/qemu2; printf '#define QEMU_PKGVERSION '; if test -n ""; then=
 printf '""\n'; else if test -d .git; then printf '" ('; git describe --mat=
ch 'v*' 2>/dev/null | tr -d '\n'; if ! git diff-index --quiet HEAD &>/dev/n=
ull; then printf -- '-dirty'; fi; printf ')"\n'; else printf '""\n'; fi; fi=
) > qemu-version.h.tmp
if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv qemu-version.h.tmp q=
emu-version.h; else rm qemu-version.h.tmp; fi
make -I/data/src/qemu2/dtc VPATH=3D/data/src/qemu2/dtc -C dtc V=3D"1" LIBFD=
T_srcdir=3D/data/src/qemu2/dtc/libfdt CPPFLAGS=3D"-I/data/src/qemu2/build/d=
tc -I/data/src/qemu2/dtc -I/data/src/qemu2/dtc/libfdt" CFLAGS=3D"-O2 -U_FOR=
TIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g  -fvisibility=3Dhidden -I/usr/include/=
pixman-1 -I/data/src/qemu2/dtc/libfdt -Werror -pthread -I/usr/include/glib-=
2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D=
_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototype=
s -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno=
-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missing-include-d=
irs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-sel=
f -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtyp=
e-limits -fstack-protector-strong -I/usr/include/libpng12 -I/data/src/qemu2=
/tests" LDFLAGS=3D"-rdynamic -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie=
 -m64 -g " ARFLAGS=3D"rv" CC=3D"cc" AR=3D"ar" LD=3D"ld"  BUILD_DIR=3D/data/=
src/qemu2/build libfdt/libfdt.a
make[1]: Entering directory '/data/src/qemu2/build/dtc'
make[1]: 'libfdt/libfdt.a' is up to date.
make[1]: Leaving directory '/data/src/qemu2/build/dtc'
make  BUILD_DIR=3D/data/src/qemu2/build -C x86_64-linux-user V=3D"1" TARGET=
_DIR=3D"x86_64-linux-user/" all
make[1]: Entering directory '/data/src/qemu2/build/x86_64-linux-user'
cc -I/data/src/qemu2/build/. -I. -I/data/src/qemu2/tcg -I/data/src/qemu2/tc=
g/i386 -I/data/src/qemu2/instrument -I/data/src/qemu2/linux-headers -I/data=
/src/qemu2/build/linux-headers -I. -I/data/src/qemu2 -I/data/src/qemu2/acce=
l/tcg -I/data/src/qemu2/include -fvisibility=3Dhidden -I/usr/include/pixman=
-1 -I/data/src/qemu2/dtc/libfdt -Werror -pthread -I/usr/include/glib-2.0 -I=
/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU_S=
OURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wre=
dundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-stric=
t-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missing-include-dirs -W=
empty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wig=
nored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limi=
ts -fstack-protector-strong -I/usr/include/libpng12  -I../linux-headers -I.=
=2E -I/data/src/qemu2/target/i386 -DNEED_CPU_H -I/data/src/qemu2/include -I=
/data/src/qemu2/linux-user/x86_64 -I/data/src/qemu2/linux-user/host/x86_64 =
-I/data/src/qemu2/linux-user -MMD -MP -MT gdbstub-xml.o -MF ./gdbstub-xml.d=
 -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g  -DQEMU_TARGET_BUILD=3D1  -=
c -o gdbstub-xml.o gdbstub-xml.c
cc -I/data/src/qemu2/build/instrument -Iinstrument -I/data/src/qemu2/tcg -I=
/data/src/qemu2/tcg/i386 -I/data/src/qemu2/instrument -I/data/src/qemu2/lin=
ux-headers -I/data/src/qemu2/build/linux-headers -I. -I/data/src/qemu2 -I/d=
ata/src/qemu2/accel/tcg -I/data/src/qemu2/include -fvisibility=3Dhidden -I/=
usr/include/pixman-1 -I/data/src/qemu2/dtc/libfdt -Werror -pthread -I/usr/i=
nclude/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m=
64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstri=
ct-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-pro=
totypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missi=
ng-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2=
k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-defi=
nition -Wtype-limits -fstack-protector-strong -I/usr/include/libpng12  -I..=
/linux-headers -I.. -I/data/src/qemu2/target/i386 -DNEED_CPU_H -I/data/src/=
qemu2/include -I/data/src/qemu2/linux-user/x86_64 -I/data/src/qemu2/linux-u=
ser/host/x86_64 -I/data/src/qemu2/linux-user -MMD -MP -MT instrument/trace.=
o -MF instrument/trace.d -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g  -D=
QEMU_TARGET_BUILD=3D1  -c -o instrument/trace.o /data/src/qemu2/instrument/=
trace.c
/data/src/qemu2/instrument/trace.c:13:30: fatal error: qemu-instr/trace.h: =
No such file or directory
compilation terminated.
/data/src/qemu2/rules.mak:66: recipe for target 'instrument/trace.o' failed
make[1]: *** [instrument/trace.o] Error 1
make[1]: Leaving directory '/data/src/qemu2/build/x86_64-linux-user'
Makefile:326: recipe for target 'subdir-x86_64-linux-user' failed
make: *** [subdir-x86_64-linux-user] Error 2

Thanks,

		Emilio
