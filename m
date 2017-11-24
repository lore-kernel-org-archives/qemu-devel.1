Received: from eggs.gnu.org ([2001:4830:134:3::10]:56130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eIElo-0004D6-3n
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eIElj-0006m0-69
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:15:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eIEli-0006lj-W5
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:15:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eIElg-0006NO-UL
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 14:15:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DE1682E80CC
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 14:15:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2017 14:01:48 -0000
From: Eduardo Otubo <1721224@bugs.launchpad.net>
Reply-To: Bug 1721224 <1721224@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150711240619.28742.14769362567837002713.malonedeb@gac.canonical.com>
Message-Id: <151153210809.18950.2984855359777133150.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721224] Re: qemu crashes with Assertion
 `!bus->dma[0] && !bus->dma[1]' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2 patch posted on list and waiting for review:

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04604.html
[PATCHv3] dma/i82374: avoid double creation of i82374 device

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721224

Title:
  qemu crashes with Assertion `!bus->dma[0] && !bus->dma[1]' failed

Status in QEMU:
  New

Bug description:
  Re-production steps:
  git clone today's qemu git tree (4th Oct 2017)
  ./configure --target-list=3Dppc64-softmmu && make -j 8

  Run the device-crash-test from scripts folder, seeing the following
  error

  INFO: running test case: machine=3Dprep binary=3Dppc64-softmmu/qemu-syste=
m-ppc64 device=3Di82374 accel=3Dtcg
  WARNING: qemu received signal -6: ppc64-softmmu/qemu-system-ppc64 -charde=
v socket,id=3Dmon,path=3D/var/tmp/qemu-30972-monitor.sock -mon chardev=3Dmo=
n,mode=3Dcontrol -display none -vga none -S -machine prep,accel=3Dtcg -devi=
ce i82374
  CRITICAL: failed: machine=3Dprep binary=3Dppc64-softmmu/qemu-system-ppc64=
 device=3Di82374 accel=3Dtcg
  CRITICAL: cmdline: ppc64-softmmu/qemu-system-ppc64 -S -machine prep,accel=
=3Dtcg -device i82374
  CRITICAL: log: qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Asse=
rtion `!bus->dma[0] && !bus->dma[1]' failed.
  CRITICAL: exit code: -6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721224/+subscriptions
