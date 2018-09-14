Received: from eggs.gnu.org ([2001:4830:134:3::10]:58817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0l8f-0003tq-Dz
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0l8c-0005Wr-7M
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:15:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:42122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g0l8b-0005UU-Ut
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g0l8a-0007JI-MS
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 10:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A4A392E8076
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 10:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Sep 2018 10:09:22 -0000
From: Kirill Bugaev <1792193@bugs.launchpad.net>
Reply-To: Bug 1792193 <1792193@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153677257295.16759.16180406339964880552.malonedeb@chaenomeles.canonical.com>
Message-Id: <153691976281.16875.14864533733678338209.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1792193] Re: AMD Athlon(tm) X2 Dual-Core QL-64 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes I could, but it rebuilds too long. I will report results later, when
find broke commit.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1792193

Title:
  AMD Athlon(tm) X2 Dual-Core QL-64 bug

Status in QEMU:
  New

Bug description:
  I upgrade my qemu 2.12.0-2 =3D> 3.0.0-1. After that I can't load virtual =
machine with "-cpu host" option. Full command line is
  qemu-system-x86_64 \
  	-monitor stdio \
  	-enable-kvm \
  	-cpu host \
  	-smp cpus=3D2 \
  	-m 1G \
  	-vga virtio \
  	-display gtk,gl=3Don \
  	-soundhw ac97 \
  	-drive file=3D/ehdd/qemu/arch_hw_12_08_2018/arch_shrinked.raw,format=3Dr=
aw,if=3Dvirtio
  I have Arch Linux on virtual machine. When I start QEMU, GRUB tries to lo=
ad initial ramdisk and stops. System doesn't load. If I try to start virtua=
l machine with "-cpu athlon" option then get the same bug.
  I downgrade back to qemu 2.12.0-2 and virtual machine works fine, system =
loads.
  My processor is AMD Athlon(tm) X2 Dual-Core QL-64.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1792193/+subscriptions
