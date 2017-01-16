Received: from eggs.gnu.org ([2001:4830:134:3::10]:60839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anibal.limon@linux.intel.com>) id 1cTFDJ-0004cG-WE
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anibal.limon@linux.intel.com>) id 1cTFDG-0005zD-QQ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:53:18 -0500
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <587D4171.6@linux.intel.com>
Date: Mon, 16 Jan 2017 15:56:01 -0600
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="IuGvJNW0KlgenqVxii6cehoWASPCSVDkW"
Subject: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IuGvJNW0KlgenqVxii6cehoWASPCSVDkW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi folks,

I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfaults
in qemu-ppc when is executing:

/home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8.0=
-r0/build/ppc-linux-user/qemu-ppc
-s 16M -r 3.2.0 -cpu 7400 -L
/home/alimon/repos/poky/build-ppc/tmp/sysroots/qemuppc -E
LD_LIBRARY_PATH=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky=
-linux/gobject-introspection/1.50.0-r0/build/.libs:.libs:/home/alimon/rep=
os/poky/build-ppc/tmp/sysroots/qemuppc//usr/lib:/home/alimon/repos/poky/b=
uild-ppc/tmp/sysroots/qemuppc//lib
/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-linux/gobject-int=
rospection/1.50.0-r0/build/tmp-introspectu_ewt_1z/Gio-2.0
--introspect-dump=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-po=
ky-linux/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/fun=
ctions.txt,/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-linux/=
gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/dump.xml
[Thread debugging using libthread_db enabled]


And the debug info,

(gdb) info threads
  Id   Target Id         Frame
  1    Thread 0x7ffff7fd0780 (LWP 25457) "qemu-ppc"
pthread_cond_wait@@GLIBC_2.3.2 () at
=2E./nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
  2    Thread 0x7ffff647e700 (LWP 25461) "qemu-ppc" syscall () at
=2E./sysdeps/unix/sysv/linux/x86_64/syscall.S:38
* 3    Thread 0x7ffff7f4d700 (LWP 25462) "qemu-ppc" 0x000000000086fba4
in static_code_gen_buffer ()

(gdb) bt
#0  0x000000000086fba4 in static_code_gen_buffer ()
#1  0x000000000040e922 in cpu_tb_exec (itb=3D<optimized out>,
itb=3D<optimized out>, cpu=3D0x29864d0) at
/home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8.0=
-r0/qemu-2.8.0/cpu-exec.c:164
#2  cpu_loop_exec_tb (sc=3D<optimized out>, tb_exit=3D<synthetic pointer>=
,
last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x29864d0) at
/home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8.0=
-r0/qemu-2.8.0/cpu-exec.c:544
#3  cpu_exec (cpu=3Dcpu@entry=3D0x29864d0) at
/home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8.0=
-r0/qemu-2.8.0/cpu-exec.c:638
#4  0x0000000000445fba in cpu_loop (env=3Denv@entry=3D0x298e750) at
/home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8.0=
-r0/qemu-2.8.0/linux-user/main.c:1359
#5  0x0000000000448a95 in clone_func (arg=3D0x7fffffffa910) at
/home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8.0=
-r0/qemu-2.8.0/linux-user/syscall.c:6090
#6  0x00007ffff6a750a4 in start_thread (arg=3D0x7ffff7f4d700) at
pthread_create.c:309
#7  0x00007ffff67aa62d in clone () at
=2E./sysdeps/unix/sysv/linux/x86_64/clone.S:111

Any help will be appreciated.

Best regards,
	alimon


--IuGvJNW0KlgenqVxii6cehoWASPCSVDkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYfUFzAAoJEGJqcE9h3glg/2QP/3PCafARVxG97rppCi8FTwhQ
FtcTU8Nj22kyxymMkLJgMotSZEGGDG/vhF9dgnE8iJcUbQBRmMPLyuUcZ9H1OqMO
KSM6IF7GanadaeLZZx/9JCLh4lsxVXZUAVUulzE6zvN3/lQNLpwEr1IAV9L3V5Yd
JAwm3mbq8fDDZyOk5Xxix/7kF/vua7FCs8B9en9Zirdi7HuJYyNUNZY9cPzPwcZ2
NpPEVoxIR6ydlzoR955J9LY2zy+o5FX8RAeIFePs7I0iKNY/OIMvt14kgsq7SunC
YTJxsOEesNdhof1ReyWOxmje5ATbYE0WcDDWi4zbBfJQKur03GG1plDYsDbDmUvz
OMbWv+99raqGgyqG7uL1R7gwgmu+IZpGRzSs/7eZQGBiBkFHFp346O1tlNHnv2/m
dmFkI8yCIr1TjQh2dc3qq0dQ7J8OONo7c8IjVWNi4Wxz0Wwbnbpqnp4ZFT50rkMW
6pSnZ0um7d08f8GXbE3G+V9JZvPEvM0ZG8NCw+hAJEvzo/c/g5+4Gg3Co8Royf1/
yPGKTX/MiLMXLB/6I+AKl3uf5yKwmTbxTv6b9bRRBOIvLrOaGz3fJ00YeGTrVB8P
BZHpxMhqsYmQLWUj0qkvRnreqz/udCNfh3UiDyrhCXlpC6Piz+v2PN1OLZk7Fus9
PF0ubEDUCqcsLehKAd/R
=bD1e
-----END PGP SIGNATURE-----

--IuGvJNW0KlgenqVxii6cehoWASPCSVDkW--
