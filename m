Received: from eggs.gnu.org ([2001:4830:134:3::10]:34164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ9aK-0001Yr-5W
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ9aG-00033d-Vd
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:16:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:35711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQ9aG-00032g-Q9
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:16:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQ9aG-00013q-1u
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:16:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F39BB2E80AF
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 09:16:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jan 2017 08:56:27 -0000
From: Thomas Huth <888016@bugs.launchpad.net>
Reply-To: Bug 888016 <888016@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111109115824.7938.15673.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170108085627.14095.7866.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 888016] Re: RHEL 6.1 guest fails to boot with
 vhost
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU
from http://qemu-project.org/Download and recent host and guest Linux
kernels?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/888016

Title:
  RHEL 6.1 guest fails to boot with vhost

Status in QEMU:
  Incomplete

Bug description:
  Tried to boot 6.1 guest on hs22 blade with/without  vhost enabled.

  With vhost enabled,  guest aborted with core dump.

  installed guest with autotest.    =

  Command : =

  /usr/local/bin/qemu-system-x86_64 -name 'vm1' -nodefaults -vga std -monit=
or unix:'/tmp/monitor-humanmonitor1-20111108-193209-fc6O',server,nowait -se=
rial unix:'/tmp/serial-20111108-193209-fc6O',server,nowait -drive file=3D'/=
home/pradeep/autotest/client/tests/kvm/images/rhel6.1-64.qed',index=3D0,if=
=3Dvirtio,cache=3Dnone -device virtio-net-pci,netdev=3DidQhUaOc,mac=3D'9a:b=
7:ea:c9:0e:0d',id=3D'idVR6XQz' -netdev tap,id=3DidQhUaOc,vhost=3Don,script=
=3D/home/pradeep/qemu-ifup-latest -m 1024 -smp 8 -vnc :0 -monitor stdio
  QEMU 0.15.91 monitor - type 'help' for more information
  (qemu) Aborted (core dumped)

  =

  host:

  2.6.32-214
  m/c: hs22
  vhost modules are loaded.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/888016/+subscriptions
