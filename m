Received: from eggs.gnu.org ([2001:4830:134:3::10]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxWff-0006UF-6x
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxWfY-0004SV-Dc
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:35:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:44628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cxWfY-0004Rf-7V
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:35:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cxWfU-00045c-PB
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A7D222E80CB
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Apr 2017 10:29:59 -0000
From: Suramya <1681398@bugs.launchpad.net>
Reply-To: Bug 1681398 <1681398@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170410102959.31714.32437.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1681398] [NEW] hw/core: segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Reproducer:
 $i386-softmmu/qemu-system-i386 -S -machine isapc,accel=3Dtcg -device amd-i=
ommu
Segmentation fault (core dumped)

Partial bt:
#0  bus_add_child (child=3D0x555556d4e520, bus=3D0x0) at hw/core/qdev.c:88
#1  qdev_set_parent_bus (dev=3D0x555556d4e520, bus=3Dbus@entry=3D0x0)
at hw/core/qdev.c:119

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681398

Title:
  hw/core: segmentation fault

Status in QEMU:
  New

Bug description:
  Reproducer:
   $i386-softmmu/qemu-system-i386 -S -machine isapc,accel=3Dtcg -device amd=
-iommu
  Segmentation fault (core dumped)

  Partial bt:
  #0  bus_add_child (child=3D0x555556d4e520, bus=3D0x0) at hw/core/qdev.c:88
  #1  qdev_set_parent_bus (dev=3D0x555556d4e520, bus=3Dbus@entry=3D0x0)
  at hw/core/qdev.c:119

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681398/+subscriptions
