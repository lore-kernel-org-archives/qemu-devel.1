Received: from eggs.gnu.org ([2001:4830:134:3::10]:37028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzhjp-0002Am-GG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzhjl-0007We-HG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:21:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:43960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzhjl-0007Vw-Aj
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:21:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzhjk-0005qm-79
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:21:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 341002E80CD
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 11:21:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Oct 2017 11:08:38 -0000
From: Thomas Huth <1721220@bugs.launchpad.net>
Reply-To: Bug 1721220 <1721220@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150711170680.1346.17864224825794910388.malonedeb@chaenomeles.canonical.com>
Message-Id: <150711531851.2038.270222042115319432.malone@chaenomeles.canonical.com>
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

I think this should be fixed by this patch here:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06696.html
("hw/pci-bridge/pcie_pci_bridge: properly handle MSI unavailability case")

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721220

Title:
  qemu crashes with assertion error `!mr->container' failed

Status in QEMU:
  New

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
