Received: from eggs.gnu.org ([2001:4830:134:3::10]:36877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKq2L-0007d0-99
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKq2H-00046b-KF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:49935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKq2H-00046D-Ek
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKq2G-0006YZ-B0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:55:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 478E52E806B
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:55:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 17:36:11 -0000
From: Thomas Huth <1037675@bugs.launchpad.net>
Reply-To: Bug 1037675 <1037675@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120816165117.15213.21939.malonedeb@soybean.canonical.com>
Message-Id: <149737537144.8025.10259264351786282356.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1037675] Re: Guest Kernel Panic if using "-cpu
 host" in qemu-kvm 1.1.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is there still something left to do here or can we close this bug
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1037675

Title:
  Guest Kernel Panic if using "-cpu host" in qemu-kvm 1.1.1

Status in QEMU:
  Incomplete

Bug description:
  After Upgrading to qemu-kvm-1.1.1-r1 from version 1.0.1-r1 my virtual
  machines (running gentoo linux) panic at intel_pmu_init. (detailed
  information including stacktrace are in the uploaded screenshot). When
  i remove the "-cpu host" option, the system starts normally.

  the command line from whicht the system is bootet:

  qemu-kvm -vnc :7 -usbdevice tablet -daemonize -m 256 -drive
  file=3D/data/virtual_machines/wgs-l08.img,if=3Dvirtio  -boot c -k de -net
  nic,model=3Dvirtio,macaddr=3D12:12:00:12:34:63,vlan=3D0 -net
  tap,ifname=3Dqtap6,script=3Dno,downscript=3Dno,vlan=3D0 -smp 2 -enable-kvm
  -cpu host -monitor unix:/var/run/qemu-
  kvm/wgs-l08.monitor,server,nowait

  also reported on gentoo bug tracker (with some more details of the
  host): https://bugs.gentoo.org/show_bug.cgi?id=3D431640

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1037675/+subscriptions
