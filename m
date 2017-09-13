Received: from eggs.gnu.org ([2001:4830:134:3::10]:34041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds3cN-0001Vx-Fj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds3cK-0007Tt-8q
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:53708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds3cK-0007T8-2x
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds3cH-0001LV-LJ
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:05:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9AA672E8058
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 08:52:03 -0000
From: Thomas Huth <1037675@bugs.launchpad.net>
Reply-To: Bug 1037675 <1037675@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120816165117.15213.21939.malonedeb@soybean.canonical.com>
Message-Id: <150529272404.17056.16937001552829398874.launchpad@soybean.canonical.com>
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

** Bug watch removed: Gentoo Bugzilla #431640
   https://bugs.gentoo.org/show_bug.cgi?id=3D431640

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
