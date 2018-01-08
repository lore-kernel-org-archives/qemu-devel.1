Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYcfa-0000cQ-5f
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYcfV-0001cn-A5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:01:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:49386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eYcfU-0001bZ-R2
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:01:08 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eYcfS-00046l-Lp
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 19:01:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6A0272E8195
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 19:01:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jan 2018 18:49:15 -0000
From: =?utf-8?q?Murilo_Opsfelder_Ara=C3=BAjo?= <1721220@bugs.launchpad.net>
Reply-To: Bug 1721220 <1721220@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150711170680.1346.17864224825794910388.malonedeb@chaenomeles.canonical.com>
Message-Id: <151543735625.461.7044508832153749324.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721220] Re: qemu crashes with assertion error
 `!mr->container' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As per previous comments, this bug was fixed by commit
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dd659d94013390238961fa=
c741572306c95496bf5
(released in QEMU v2.11.0):

commit d659d94013390238961fac741572306c95496bf5
Author: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date:   Mon Sep 25 02:21:58 2017 +0300

    hw/pci-bridge/pcie_pci_bridge: properly handle MSI unavailability
case

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721220

Title:
  qemu crashes with assertion error `!mr->container' failed

Status in QEMU:
  Fix Released

Bug description:
  Re-production steps:
  git clone today's qemu git tree (4th Oct 2017)
  ./configure --target-list=3Dppc64-softmmu && make -j 8

  Run the device-crash-test from scripts folder, seeing the following
  error

  INFO: running test case: machine=3Dbamboo binary=3Dppc64-softmmu/qemu-sys=
tem-ppc64 device=3Dpcie-pci-bridge accel=3Dkvm
  WARNING: qemu received signal -6: ppc64-softmmu/qemu-system-ppc64 -charde=
v socket,id=3Dmon,path=3D/var/tmp/qemu-30972-monitor.sock -mon chardev=3Dmo=
n,mode=3Dcontrol -display none -vga none -S -machine bamboo,accel=3Dkvm -de=
vice pcie-pci-bridge
  CRITICAL: failed: machine=3Dbamboo binary=3Dppc64-softmmu/qemu-system-ppc=
64 device=3Dpcie-pci-bridge accel=3Dkvm
  CRITICAL: cmdline: ppc64-softmmu/qemu-system-ppc64 -S -machine bamboo,acc=
el=3Dkvm -device pcie-pci-bridge
  CRITICAL: log: qemu-system-ppc64: /home/nasastry/qemu/memory.c:1699: memo=
ry_region_finalize: Assertion `!mr->container' failed.
  CRITICAL: log: warning: KVM does not support watchdog
  CRITICAL: exit code: -6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721220/+subscriptions
