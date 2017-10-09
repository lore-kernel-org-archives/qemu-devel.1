Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e1eXn-0006wf-Vj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e1eXk-0005Eu-PK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:20:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:60178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e1eXk-0005EK-Iw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e1eXi-0000ur-Cc
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 20:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5AC292E8078
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 20:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Oct 2017 20:07:30 -0000
From: John Snow <1721222@bugs.launchpad.net>
Reply-To: Bug 1721222 <1721222@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150711232495.21489.16130885545383141656.malonedeb@soybean.canonical.com>
Message-Id: <150757965095.1539.14091414065317691021.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721222] Re: qemu crashes with Assertion
 `fdctrl->dma' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
     Assignee: (unassigned) =3D> John Snow (jnsnow)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721222

Title:
  qemu crashes with Assertion `fdctrl->dma' failed

Status in QEMU:
  Confirmed

Bug description:
  Re-production steps:
  git clone today's qemu git tree (4th Oct 2017)
  ./configure --target-list=3Dppc64-softmmu && make -j 8

  Run the device-crash-test from scripts folder, seeing the following
  error

  =

  INFO: running test case: machine=3Dpowernv binary=3Dppc64-softmmu/qemu-sy=
stem-ppc64 device=3Disa-fdc accel=3Dtcg
  WARNING: qemu received signal -6: ppc64-softmmu/qemu-system-ppc64 -charde=
v socket,id=3Dmon,path=3D/var/tmp/qemu-30972-monitor.sock -mon chardev=3Dmo=
n,mode=3Dcontrol -display none -vga none -S -machine powernv,accel=3Dtcg -d=
evice isa-fdc
  CRITICAL: failed: machine=3Dpowernv binary=3Dppc64-softmmu/qemu-system-pp=
c64 device=3Disa-fdc accel=3Dtcg
  CRITICAL: cmdline: ppc64-softmmu/qemu-system-ppc64 -S -machine powernv,ac=
cel=3Dtcg -device isa-fdc
  CRITICAL: log: qemu-system-ppc64: hw/block/fdc.c:2703: isabus_fdc_realize=
: Assertion `fdctrl->dma' failed.
  CRITICAL: exit code: -6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721222/+subscriptions
