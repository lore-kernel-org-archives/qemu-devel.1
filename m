Received: from eggs.gnu.org ([2001:4830:134:3::10]:42814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOQc-0002pD-4U
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOQa-0001HC-3v
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:39096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOQZ-0001Ge-QV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOQY-0004TD-Qe
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C348F2E802D
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 21:41:50 -0000
From: Thomas Huth <1094564@bugs.launchpad.net>
Reply-To: Bug 1094564 <1094564@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121229222619.26431.54663.malonedeb@soybean.canonical.com>
Message-Id: <151562051060.26801.12805446874737120018.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1094564] Re: images used as scsi disks not
 readable (qemu-system-arm, macos 10.8)
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
https://bugs.launchpad.net/bugs/1094564

Title:
  images used as scsi disks not readable (qemu-system-arm, macos 10.8)

Status in MacPorts:
  New
Status in QEMU:
  Incomplete

Bug description:
  Using a arm1176 kernel and the raspbian image (10-28 or 12-16) as my
  disk, I get as far as mounting root and then get SCSI errors with
  1.3.0 and the current origin/master. git bisect says the issue is

  commit f563a5d7a820424756f358e747238f03e866838a
  Merge: a273652 aee0bf7
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Oct 31 10:42:51 2012 +0100

      Merge remote-tracking branch 'origin/master' into threadpool
      =

      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  =

  I am using:
  qemu-system-arm -no-reboot -M versatilepb -cpu arm1176 -m 256 -hda 2012-1=
2-16-wheezy-raspbian.img -kernel kernel-qemu -append "root=3D/dev/sda2 root=
fstype=3Dext4 elevator=3Ddeadline rootwait panic=3D1" -serial stdio -usbdev=
ice tablet -net nic -net user,hostfwd=3Dtcp::40022-:22

  Configured on MacOS 10.8.2 with current Xcode and MacPorts installed, thu=
s:
  CPATH=3D/opt/local/include CFLAGS=3D"-pipe -O2 -arch x86_64" CPPFLAGS=3D"=
-I/opt/local/include" CXXFLAGS=3D"-pipe -O2 -arch x86_64" LIBRARY_PATH=3D"/=
opt/local/lib" MACOSX_DEPLOYMENT_TARGET=3D"10.8" CXX=3D"/usr/bin/clang++" L=
DFLAGS=3D"-L/opt/local/lib -arch x86_64" OBJC=3D/usr/bin/clang FCFLAGS=3D"-=
pipe -O2 -m64" INSTALL=3D"/usr/bin/install -c" OBJCFLAGS=3D"-pipe -O2 -arch=
 x86_64" CC=3D"/usr/bin/clang"  ./configure --prefix=3D/opt/local --cpu=3Dx=
86_64 --cc=3D/usr/bin/clang --objcc=3D/usr/bin/clang --host-cc=3D/usr/bin/c=
lang --python=3D/opt/local/bin/python2.7 --target-list=3Darm-softmmu

To manage notifications about this bug go to:
https://bugs.launchpad.net/macports/+bug/1094564/+subscriptions
