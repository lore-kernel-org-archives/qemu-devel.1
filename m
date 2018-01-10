Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOQc-0002pC-43
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOQY-0001GT-TY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:39054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOQY-0001Fh-N0
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOQX-0004TI-Fk
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 704672E80C9
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 21:48:53 -0000
From: Thomas Huth <1129957@bugs.launchpad.net>
Reply-To: Bug 1129957 <1129957@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130219090314.18849.88631.malonedeb@soybean.canonical.com>
Message-Id: <151562093385.3150.17555512794739012536.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1129957] Re: Performance issue running quest
 image on qemu compiled for Win32 platform
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
latest version of QEMU and the latest version of MinGW? Do you also see
the problem with the builds from https://qemu.weilnetz.de/ ? Or could we
close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1129957

Title:
  Performance issue running quest image on qemu compiled for Win32
  platform

Status in QEMU:
  Incomplete

Bug description:
  I'm seeing performance issues when booting a guest image on qemu 1.4.0 co=
mpiled for the Win32 platform.
  The same image boots a lot faster on the same computer running qemu/linux=
 on Fedora via VmWare, and even running the Win32 exectuable via Wine perfo=
rms better than running qemu natively on Win32.

  Although I'm not the author of the image, it is located here:
  http://people.freebsd.org/~wpaul/qemu/vxworks.img

  All testing has been done on QEMU 1.4.0.

  I'm also attaching a couple of gprof logs. For these I have disabled
  ssp in qemu by removing "-fstack-protector-all" and
  "-D_FORTIFY_SOURCE=3D2" from the qemu configure script.

  qemu-perf-linux.txt
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Machine - Windows XP - VmWare - Fedora - QEMU

  qemu-perf-win32.txt
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Machine - Windows XP - QEMU

  qemu-perf-wine.txt
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Machine - Windows XP - VmWare - Fedora - Wine - QEMU

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1129957/+subscriptions
