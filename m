Received: from eggs.gnu.org ([2001:4830:134:3::10]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eo8Es-0004XD-Ay
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eo8Ep-0005Fo-71
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:45:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:45044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eo8Ep-0005Ec-0U
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:45:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eo8En-0000WL-UP
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D83802E80CC
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Feb 2018 13:26:38 -0000
From: Thomas Huth <1187529@bugs.launchpad.net>
Reply-To: Bug 1187529 <1187529@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130604183209.6036.79098.malonedeb@chaenomeles.canonical.com>
Message-Id: <151913319887.2410.11052716208316289987.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1187529] Re: Devices on PCI bridge stop working
 when live-migrated
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
latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
     Assignee: Don Koch (dkoch-r) =3D> (unassigned)

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1187529

Title:
  Devices on PCI bridge stop working when live-migrated

Status in QEMU:
  Incomplete

Bug description:
  qemu version: 1.4.50 (0ca5aa4f4c4a8bcc73988dd52a536241d35e5223)
  host: x86_64, Linux 3.6.10 (Fedora 17)
  client: x86_64 Centos 6.3 (doesn't matter, really)

  If a device, e.g. an lsi53c895a, is on a pci-bridge, after migration, the=
 device stops working (e.g., commands like "poweroff"
  get an Input/Output error. Fails under either xen or kvm. If "top" was ru=
nning, some cpus go to ~100% wait.

  Sample KVM invocation line:
  qemu-system-x86_64 -machine type=3Dpc,accel=3Dkvm -m 4096 -device pci-bri=
dgemsi=3Don,chassis_nr=3D1,id=3DpciBridge1.0,addr=3D0x11.0 -device lsi53c89=
5a,id=3Dsas,bus=3DpciBridge1.0,addr=3D0x1.0x0 -drive if=3Dnone,id=3Ddisk0,f=
ile=3D/path/to/disk/image -device scsi-disk,bus=3Dsas.0,scsi-id=3D0,drive=
=3Ddisk0 -vnc 127.0.0.1:0,to=3D99 -serial pty -boot order=3Dcda -smp 4,maxc=
pus=3D4 -monitor vc

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1187529/+subscriptions
