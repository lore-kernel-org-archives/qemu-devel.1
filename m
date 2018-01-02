Received: from eggs.gnu.org ([2001:4830:134:3::10]:59242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWPI6-0006Rq-I3
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWPI2-00007Z-Dq
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:19:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:40474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWPI2-00006x-6I
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:19:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWPI1-0007dM-Aa
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:19:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F45A2E80C9
	for <qemu-devel@nongnu.org>; Tue,  2 Jan 2018 16:19:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2018 16:10:29 -0000
From: Thomas Huth <1158912@bugs.launchpad.net>
Reply-To: Bug 1158912 <1158912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130322175114.10747.75661.malonedeb@wampee.canonical.com>
Message-Id: <151490942937.23838.11810885703063316904.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1158912] Re: QEMU Version 1.4.0 - SLIRP hangs VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1158912

Title:
  QEMU Version 1.4.0 - SLIRP hangs VM

Status in QEMU:
  Incomplete

Bug description:
  (Note: problem is not present in version 1.3.0)

  Stacktrace: please see attached gdb log file.

  Steps to reproduce:

  1. gdb -x debug-qemu.gdb testing/qemu-1.4.0/ppc64-softmmu/qemu-system-
  ppc64

  Contents of debug-qemu.gdb:

  run -L ./testing/qemu-1.4.0/pc-bios  -name "[DEBUG] Software und
  System-Entwicklung IBM POWER7" -cpu POWER7_v2.3 -M pseries -m 1024
  -rtc base=3Dutc -nodefaults -vga std -monitor vc -serial vc -netdev
  type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9011-10.0.2.11:22 -device
  virtio-net-pci,netdev=3Dmynet0 -drive file=3Dimages/suse-
  ppc.img,if=3Dvirtio,index=3D0,media=3Ddisk,cache=3Dunsafe -kernel
  images/iso/suseboot/vmlinux -append "root=3D/dev/mapper/system-root ro
  audit=3D0 selinux=3D0 apparmor=3D0" -initrd images/iso/suseboot/initrd.img
  -drive if=3Dscsi,bus=3D0,unit=3D0,media=3Dcdrom

  =

  2. build information
      QEMU: ppc64 full emulation, version 1.4.0
      Host OS: Windows XP
      Guest OS: openSUSE 12.2 kernel 3.4.6-2.10-ppc64

      PATH=3D/usr/i686-pc-mingw32/sys-root/mingw/bin:$PATH
      PKG_CONFIG_LIBDIR=3D/usr/i686-pc-mingw32/sys-root/mingw/lib/pkgconfig
      THREADS=3D4
      export PKG_CONFIG_LIBDIR
      =

      sed -i 's/--static-libs/--static --libs/' configure
      CC=3Di686-pc-mingw32-gcc ./configure \
            --target-list=3Dppc64-softmmu \
            --enable-debug \
            --enable-sdl \
            --static \
            --enable-fdt && \
      sed -i 's/ -Wl,--dynamicbase//g; s/-Wl,--nxcompat //g;'  config-host.=
mak && \
      make -j$THREADS && {
            echo "renaming binw.exe to bin.exe..."
            for i in `echo $TARGET_LIST | tr ',' ' '`; do
                   BINARCH=3D`echo $i | sed 's/-softmmu//'`
                   mv $i/qemu-system-${BINARCH}w.exe \
                          $i/qemu-system-$BINARCH.exe
            done
      }

     =

  3. From VM: =

      Command to hang VM: zypper dup
      Last message before VM hang:  Retrieving repository 'openSUSE-12.2-12=
.2-0' metadata -----------------------[|]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1158912/+subscriptions
