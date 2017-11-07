Received: from eggs.gnu.org ([2001:4830:134:3::10]:43026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC8BI-00074M-PP
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC8B7-0007yx-39
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:52270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC8B6-0007yH-Su
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:00:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC8B5-0005Jc-Lr
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5DBC12E80D2
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 18:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:50:23 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1452230 <1452230@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150506104726.29194.34346.malonedeb@soybean.canonical.com>
Message-Id: <151007702315.4447.3789549841906384077.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1452230] Re: Qemu 2.3.0 failes to compile with
 GCC 5.1.0 and -flto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This seems to be a GCC bug, not a QEMU bug? I'm going to close this bug,
since it has been reported upstream with the GCC folks, and they don't
seem to think this is an error on our side.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1452230

Title:
  Qemu 2.3.0 failes to compile with GCC 5.1.0 and -flto

Status in QEMU:
  Invalid

Bug description:
  Compiling Qemu 2.3.0 failes with the following error:

  x86_64-pc-linux-gnu-g++ -I/usr/include/pixman-1   -fPIE -DPIE -m64 -D_GNU=
_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -W=
redundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-str=
ict-aliasing -fno-common  -Wendif-labels -Wmissing-include-dirs -Wempty-bod=
y -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qua=
lifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstac=
k-protector-strong   -I/usr/include/libpng16  -I/usr/include/libusb-1.0  -I=
/home/gentoo/tmp/portage/app-emulation/qemu-2.3.0/work/qemu-2.3.0/tests -pt=
hread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -march=3Dnativ=
e -O2 -pipe -ggdb -floop-interchange -floop-strip-mine -floop-block -ftree-=
loop-distribution -fira-loop-pressure -ftree-vectorize -ftree-loop-linear -=
flto=3D5 -fuse-linker-plugin -Wl,-z,relro -Wl,-z,now -pie -m64 -Wl,-O1 -Wl,=
--as-needed -march=3Dnative -O2 -pipe -ggdb -floop-interchange -floop-strip=
-mine -floop-block -ftree-loop-distribution -fira-loop-pressure -ftree-vect=
orize -ftree-loop-linear -flto=3D5 -fuse-linker-plugin -Wl,-znow -Wl,--sort=
-common -Wl,--hash-style=3Dgnu -Wl,--enable-new-dtags -o qemu-img qemu-img.=
o async.o thread-pool.o nbd.o block.o blockjob.o main-loop.o iohandler.o qe=
mu-timer.o aio-posix.o qemu-io-cmds.o qemu-coroutine.o qemu-coroutine-lock.=
o qemu-coroutine-io.o qemu-coroutine-sleep.o coroutine-ucontext.o block/raw=
_bsd.o block/qcow.o block/vdi.o block/vmdk.o block/cloop.o block/dmg.o bloc=
k/bochs.o block/vpc.o block/vvfat.o block/qcow2.o block/qcow2-refcount.o bl=
ock/qcow2-cluster.o block/qcow2-snapshot.o block/qcow2-cache.o block/qed.o =
block/qed-gencb.o block/qed-l2-cache.o block/qed-table.o block/qed-cluster.=
o block/qed-check.o block/vhdx.o block/vhdx-endian.o block/vhdx-log.o block=
/parallels.o block/blkdebug.o block/blkverify.o block/block-backend.o block=
/snapshot.o block/qapi.o block/raw-posix.o block/linux-aio.o block/null.o b=
lock/mirror.o block/nbd.o block/nbd-client.o block/sheepdog.o block/account=
ing.o block/write-threshold.o block/curl.o  libqemuutil.a libqemustub.a   -=
lz -lbz2 -laio -lcurl -lm -lgthread-2.0 -pthread -lglib-2.0   -lz -lrt -lz =
-lcap-ng -luuid  -lutil
  lto1: error: two or more sections for .gnu.lto_fprintf.2f4a95b725db6827
  (null):0: confused by earlier errors, bailing out
  make[1]: *** [/home/gentoo/tmp/portage/app-emulation/qemu-2.3.0/temp/ccEU=
T6Vq.ltrans11.ltrans.o] Error 1
  make[1]: *** Waiting for unfinished jobs....
  lto-wrapper: fatal error: make returned 2 exit status
  compilation terminated.
  /usr/lib/gcc/x86_64-pc-linux-gnu/5.1.0/../../../../x86_64-pc-linux-gnu/bi=
n/ld: fatal error: lto-wrapper failed
  collect2: error: ld returned 1 exit status
  /home/gentoo/tmp/portage/app-emulation/qemu-2.3.0/work/qemu-2.3.0/rules.m=
ak:122: recipe for target 'qemu-img' failed
  make: *** [qemu-img] Error 1

  I've found an old GCC bugreport with the same error:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D52159 (which has been
  marked as dup of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D59000) .
  I was able to reduce the object list to to three .o files which
  reproduce the error reliably: qemu-img.o qemu-io-cmds.o block/qapi.o.

  Please let me know if you need further information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1452230/+subscriptions
