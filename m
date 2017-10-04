Received: from eggs.gnu.org ([2001:4830:134:3::10]:49541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzgxK-0001AX-F7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzgxH-0000lN-5K
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:31:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:33830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzgxG-0000ju-Vc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:31:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzgxE-0006RX-K6
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 10:31:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9615F2E80DB
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:31:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Oct 2017 10:20:06 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1721224 <1721224@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150711240619.28742.14769362567837002713.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721224] [NEW] qemu crashes with Assertion
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

Public bug reported:

Re-production steps:
git clone today's qemu git tree (4th Oct 2017)
./configure --target-list=3Dppc64-softmmu && make -j 8

Run the device-crash-test from scripts folder, seeing the following
error

INFO: running test case: machine=3Dprep binary=3Dppc64-softmmu/qemu-system-=
ppc64 device=3Di82374 accel=3Dtcg
WARNING: qemu received signal -6: ppc64-softmmu/qemu-system-ppc64 -chardev =
socket,id=3Dmon,path=3D/var/tmp/qemu-30972-monitor.sock -mon chardev=3Dmon,=
mode=3Dcontrol -display none -vga none -S -machine prep,accel=3Dtcg -device=
 i82374
CRITICAL: failed: machine=3Dprep binary=3Dppc64-softmmu/qemu-system-ppc64 d=
evice=3Di82374 accel=3Dtcg
CRITICAL: cmdline: ppc64-softmmu/qemu-system-ppc64 -S -machine prep,accel=
=3Dtcg -device i82374
CRITICAL: log: qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assert=
ion `!bus->dma[0] && !bus->dma[1]' failed.
CRITICAL: exit code: -6

** Affects: qemu
     Importance: Undecided
         Status: New

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
