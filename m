Received: from eggs.gnu.org ([2001:4830:134:3::10]:40079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dAZf5-000733-VY
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dAZf0-00073N-V6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:25:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:42429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dAZf0-000737-PF
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:24:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dAZex-0005fs-QD
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 10:24:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A81A22E80C4
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 10:24:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 May 2017 10:12:49 -0000
From: Thomas Huth <1286253@bugs.launchpad.net>
Reply-To: Bug 1286253 <1286253@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140228174019.12875.25127.malonedeb@wampee.canonical.com>
Message-Id: <149492956905.8782.10164928502790473342.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1286253] Re: virtio-net acceleration features not
 set when plugged into backend dynamically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU did you use here? Can you still reproduce this
problem with the latest version of QEMU (currently v2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1286253

Title:
  virtio-net acceleration features not set when plugged into backend
  dynamically

Status in QEMU:
  Incomplete

Bug description:
  When using indpendent transport and backend in this case virtio-net-
  device transport, none of the acceleration features are set after
  guest probes the transport the backend is plugged into. For virtio-net
  this leads to low throughput/performance.  This holds true for
  virtio-mmio, PCI transports and most likely for others as well (CCW,
  S390) and other backends

  Command to run:
  ./qemu-system-arm -enable-kvm -smp 2 -kernel zImage -dtb ./guest-a15.dtb =
-m 512 -M vexpress-a15 -cpu cortex-a15 -nographic \
        -append "root=3D/dev/vda rw console=3DttyAMA0 rootwait" -drive if=
=3Dnone,file=3D/mnt/gauss.root,id=3Dvm1 \
        -device virtio-blk-device,drive=3Dvm1 -netdev type=3Dtap,id=3Dnet0,=
ifname=3Dtap0 \
        -device virtio-net-device,netdev=3Dnet0,mac=3D"52:54:00:12:34:58"

  For x86 same virtio command for network.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1286253/+subscriptions
