Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shiftag@nanotek.info>) id 1eY4s8-0005TS-1y
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 01:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shiftag@nanotek.info>) id 1eY4s3-0006u6-Mb
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 01:55:56 -0500
Received: from mail.nanotek.info ([188.166.13.56]:40672)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shiftag@nanotek.info>) id 1eY4s3-0006sQ-2Z
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 01:55:51 -0500
Received: from webmail.nanotek.info (localhost [127.0.0.1])
	by mail.nanotek.info (Postfix) with ESMTPSA id 1EDAF61464
	for <qemu-devel@nongnu.org>; Sun,  7 Jan 2018 07:55:25 +0100 (CET)
Mime-Version: 1.0
Date: Sun, 07 Jan 2018 06:55:24 +0000
Message-ID: <658f9066c2e35c4dab0343c3ce22a347@webmail.nanotek.info>
From: shiftag@nanotek.info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Building QEMU natively from ARM CPU statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,=0A=0AI'm trying to build QEMU statically from ARM CPU (without cross-=
compiling). But at "configure" step I have the following issue :=0A=0AERR=
OR: User requested feature sdl=0A configure was not able to find it.=0A I=
nstall SDL devel=0AHowever, from config.log, it seems that issue is not r=
elated to SDL.=0A=0A--------- long paste ---------=0A=0A# QEMU configure =
log Sun Jan 7 10:05:50 +04 2018=0A# Configured with: './configure' '--pre=
fix=3D/usr' '--libdir=3D/usr/lib' '--sysconfdir=3D/etc' '--localstatedir=
=3D/var' '--docdir=3D/usr/doc/qemu-2.11.0' '--cc=3Dgcc' '--host-cc=3Dgcc'=
 '--cpu=3Darm' '--enable-gtk' '--enable-system' '--enable-kvm' '--disable=
-debug-info' '--enable-virtfs' '--enable-sdl' '--enable-jemalloc' '--disa=
ble-docs' '--static' '--disable-vnc' '--target-list=3Dmips-linux-user'=0A=
#=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstri=
ct-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-p=
rototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu=
-conf.o config-temp/qemu-conf.c=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wu=
ndef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-commo=
n -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c=0Agcc -D_=
GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototyp=
es -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -=
fno-strict-aliasing -fno-common -fwrapv -o config-temp/qemu-conf.exe conf=
ig-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -=
Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwr=
apv -Werror -Wstring-plus-int -o config-temp/qemu-conf.exe config-temp/qe=
mu-conf.c -static=0Agcc: error: unrecognized command line option =E2=80=
=98-Wstring-plus-int=E2=80=99=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D6=
4 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef=
 -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -f=
wrapv -Werror -Winitializer-overrides -o config-temp/qemu-conf.exe config=
-temp/qemu-conf.c -static=0Agcc: error: unrecognized command line option =
=E2=80=98-Winitializer-overrides=E2=80=99=0Agcc -D_GNU_SOURCE -D_FILE_OFF=
SET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -=
Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -f=
no-common -fwrapv -Werror -Wexpansion-to-defined -o config-temp/qemu-conf=
.exe config-temp/qemu-conf.c -static=0Agcc: error: unrecognized command l=
ine option =E2=80=98-Wexpansion-to-defined=E2=80=99=0Agcc -D_GNU_SOURCE -=
D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredunda=
nt-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-a=
liasing -fno-common -fwrapv -Werror -Wendif-labels -o config-temp/qemu-co=
nf.exe config-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET=
_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wal=
l -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-=
common -fwrapv -Wendif-labels -Werror -Wshift-negative-value -o config-te=
mp/qemu-conf.exe config-temp/qemu-conf.c -static=0Agcc: error: unrecogniz=
ed command line option =E2=80=98-Wshift-negative-value=E2=80=99=0Agcc -D_=
GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototyp=
es -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -=
fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Werror -Wmissing-=
include-dirs -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=
=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstric=
t-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-pr=
ototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-mis=
sing-include-dirs -Werror -Wempty-body -o config-temp/qemu-conf.exe confi=
g-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -W=
write-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwra=
pv -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Werror -Wnested=
-externs -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=0Ag=
cc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-pr=
ototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-protot=
ypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing=
-include-dirs -Wempty-body -Wnested-externs -Werror -Wformat-security -o =
config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=0Agcc -D_GNU_SO=
URCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wr=
edundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-st=
rict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dir=
s -Wempty-body -Wnested-externs -Wformat-security -Werror -Wformat-y2k -o=
 config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=0Agcc -D_GNU_S=
OURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -W=
redundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-s=
trict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-di=
rs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Werror -=
Winit-self -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=
=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstric=
t-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-pr=
ototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-mis=
sing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wforma=
t-y2k -Winit-self -Werror -Wignored-qualifiers -o config-temp/qemu-conf.e=
xe config-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BIT=
S=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -W=
undef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-comm=
on -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested=
-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers =
-Werror -Wold-style-declaration -o config-temp/qemu-conf.exe config-temp/=
qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGE=
FILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-s=
trings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wen=
dif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wform=
at-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-dec=
laration -Werror -Wold-style-definition -o config-temp/qemu-conf.exe conf=
ig-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -=
Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwr=
apv -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-extern=
s -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-s=
tyle-declaration -Wold-style-definition -Werror -Wtype-limits -o config-t=
emp/qemu-conf.exe config-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_=
FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant=
-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-ali=
asing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wempt=
y-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wigno=
red-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limi=
ts -Werror -fstack-protector-strong -c -o config-temp/qemu-conf.o config-=
temp/qemu-conf.c=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFIL=
E_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-stri=
ngs -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif=
-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-=
security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declar=
ation -Wold-style-definition -Wtype-limits -Werror -fstack-protector-stro=
ng -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=0Agcc -D_=
GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototyp=
es -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -=
fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-inclu=
de-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Win=
it-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definiti=
on -Wtype-limits -fstack-protector-strong -Werror -c -o config-temp/qemu-=
conf.o config-temp/qemu-conf.c=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D=
64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wunde=
f -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -=
fwrapv -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-ext=
erns -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wol=
d-style-declaration -Wold-style-definition -Wtype-limits -fstack-protecto=
r-strong -Werror -fno-gcse -o config-temp/qemu-conf.exe config-temp/qemu-=
conf.c -static=0Aconfig-temp/qemu-conf.c:4:2: error: #error No bug in thi=
s compiler.=0A #error No bug in this compiler.=0A ^=0Agcc -D_GNU_SOURCE -=
D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredunda=
nt-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-a=
liasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wem=
pty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wig=
nored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-li=
mits -fstack-protector-strong -Werror -o config-temp/qemu-conf.exe config=
-temp/qemu-conf.c -static=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D=
_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Ww=
rite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrap=
v -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs =
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-sty=
le-declaration -Wold-style-definition -Wtype-limits -fstack-protector-str=
ong -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c=0Agcc -D_GNU_SO=
URCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wr=
edundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-st=
rict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dir=
s -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-sel=
f -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wt=
ype-limits -fstack-protector-strong -Werror -c -o config-temp/qemu-conf.o=
 config-temp/qemu-conf.c=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_=
LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwr=
ite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv=
 -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -=
Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-styl=
e-declaration -Wold-style-definition -Wtype-limits -fstack-protector-stro=
ng -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=0Agcc -D_=
GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototyp=
es -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -=
fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-inclu=
de-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Win=
it-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definiti=
on -Wtype-limits -fstack-protector-strong -c -o config-temp/qemu-conf.o c=
onfig-temp/qemu-conf.c=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LA=
RGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrit=
e-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -=
Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wf=
ormat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-=
declaration -Wold-style-definition -Wtype-limits -fstack-protector-strong=
 -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static -lz=0Agcc -=
D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-protot=
ypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes=
 -fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-inc=
lude-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -W=
init-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-defini=
tion -Wtype-limits -fstack-protector-strong -o config-temp/qemu-conf.exe =
config-temp/qemu-conf.c -static -llzo2=0A/usr/lib/gcc/arm-slackware-linux=
-gnueabi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cannot fin=
d -llzo2=0Acollect2: error: ld returned 1 exit status=0Agcc -D_GNU_SOURCE=
 -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredun=
dant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict=
-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dirs -W=
empty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -W=
ignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-=
limits -fstack-protector-strong -o config-temp/qemu-conf.exe config-temp/=
qemu-conf.c -static -lsnappy=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5=
.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cannot find -lsnappy=
=0Acollect2: error: ld returned 1 exit status=0Agcc -D_GNU_SOURCE -D_FILE=
_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-dec=
ls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasin=
g -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wempty-bo=
dy -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-=
qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -=
fstack-protector-strong -o config-temp/qemu-conf.exe config-temp/qemu-con=
f.c -static -lbz2=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFI=
LE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-str=
ings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wendi=
f-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat=
-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-decla=
ration -Wold-style-definition -Wtype-limits -fstack-protector-strong -o c=
onfig-temp/qemu-conf.exe config-temp/qemu-conf.c -static -lxenstore -lxen=
ctrl -lxenguest=0Aconfig-temp/qemu-conf.c:1:21: fatal error: xenctrl.h: N=
o such file or directory=0Acompilation terminated.=0Agcc -D_GNU_SOURCE -D=
_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundan=
t-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-al=
iasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wemp=
ty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wign=
ored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-lim=
its -fstack-protector-strong -I/usr/include/p11-kit-1 -o config-temp/qemu=
-conf.exe config-temp/qemu-conf.c -static -lgnutls -lz -lp11-kit -lgmp -l=
hogweed -lgmp -lnettle -lidn -lp11-kit -lz=0A/usr/lib/gcc/arm-slackware-l=
inux-gnueabi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cannot=
 find -lgnutls=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../../../=
../arm-slackware-linux-gnueabi/bin/ld: cannot find -lp11-kit=0A/usr/lib/g=
cc/arm-slackware-linux-gnueabi/5.3.1/../../../../arm-slackware-linux-gnue=
abi/bin/ld: cannot find -lgmp=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/=
5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cannot find -lhogwe=
ed=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../../../../arm-slack=
ware-linux-gnueabi/bin/ld: cannot find -lgmp=0A/usr/lib/gcc/arm-slackware=
-linux-gnueabi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cann=
ot find -lnettle=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../../.=
./../arm-slackware-linux-gnueabi/bin/ld: cannot find -lp11-kit=0Acollect2=
: error: ld returned 1 exit status=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BIT=
S=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -W=
undef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-comm=
on -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested=
-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers =
-Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-prot=
ector-strong -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static=
 -lgcrypt -lgpg-error -lgpg-error=0A/usr/lib/gcc/arm-slackware-linux-gnue=
abi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cannot find -lg=
crypt=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../../../../arm-sl=
ackware-linux-gnueabi/bin/ld: cannot find -lgpg-error=0A/usr/lib/gcc/arm-=
slackware-linux-gnueabi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin=
/ld: cannot find -lgpg-error=0Acollect2: error: ld returned 1 exit status=
=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstric=
t-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-pr=
ototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-mis=
sing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wforma=
t-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-styl=
e-definition -Wtype-limits -fstack-protector-strong -o config-temp/qemu-c=
onf.exe config-temp/qemu-conf.c -static -lgcrypt -lgpg-error -lgpg-error=
=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../../../../arm-slackwa=
re-linux-gnueabi/bin/ld: cannot find -lgcrypt=0A/usr/lib/gcc/arm-slackwar=
e-linux-gnueabi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: can=
not find -lgpg-error=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../=
../../../arm-slackware-linux-gnueabi/bin/ld: cannot find -lgpg-error=0Aco=
llect2: error: ld returned 1 exit status=0Agcc -D_GNU_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -W=
all -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fn=
o-common -fwrapv -Wendif-labels -Wno-missing-include-dirs -Wempty-body -W=
nested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-quali=
fiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstac=
k-protector-strong -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c=
=0Agcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstric=
t-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-pr=
ototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-mis=
sing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wforma=
t-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-styl=
e-definition -Wtype-limits -fstack-protector-strong -D_REENTRANT -I/usr/i=
nclude/SDL2 -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static =
-Wl,-rpath,/usr/lib -Wl,--enable-new-dtags -pthread -lSDL2 -ldbus-1 -ldl =
-lm -Wl,--no-undefined -pthread -lSDL2=0A/usr/lib/gcc/arm-slackware-linux=
-gnueabi/5.3.1/../../../../arm-slackware-linux-gnueabi/bin/ld: cannot fin=
d -ldbus-1=0A/usr/lib/gcc/arm-slackware-linux-gnueabi/5.3.1/../../../libS=
DL2.a(SDL_dynapi.c.o): In function `SDL_InitDynamicAPI':=0ASDL_dynapi.c:(=
.text+0x1cb8): warning: Using 'dlopen' in statically linked applications =
requires at runtime the shared libraries from the glibc version used for =
linking=0Acollect2: error: ld returned 1 exit status=0A=0A--------- long =
paste ---------=0A=0AI'm compiling version 2.11.0 so the SDL patch has al=
ready been applied. Also, some libraries errors are strange as I can find=
 them on my system, see :=0A=0A $ pkg-config --cflags --libs p11-kit-1 gn=
utls hogweed nettle dbus-1 =0A -I/usr/include/p11-kit-1 -I/usr/include/db=
us-1.0 -I/usr/lib/dbus-1.0/include -lp11-kit -lgnutls -lhogweed -lnettle =
-ldbus-1=0A=0AAlso, I tried building a shared version (without --static) =
of qemu-2.11.0 and it works fine.=0A=0ASo, do you have an idea about how =
to fix this ?=0A=0ACheers
