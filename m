Received: from eggs.gnu.org ([2001:4830:134:3::10]:47117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbd6V-0005dt-O2
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbd6P-0003vv-VO
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:60604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cbd6P-0003vP-Q3
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:00:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cbd6N-0003L8-99
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 01:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E6722E80C0
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 01:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Feb 2017 00:55:38 -0000
From: Paco <manuel.arguelles@gmail.com>
Reply-To: Bug 1663079 <1663079@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170209005538.4996.16948.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1663079] [NEW] socket network not working
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

The socket network type is no longer working in 2.8.0.

When trying to establish a network between 2 qemu instances:

The listening host:
qemu-system-x86_64 -netdev socket,id=3Din0,listen=3D127.0.0.1:9999 -device =
virtio-net-pci,netdev=3Din0

works fine, but for the second one:

qemu-system-x86_64 -netdev socket,id=3Din0,connect=3D127.0.0.1:9999 -device
virtio-net-pci,netdev=3Din0

It fails with:

qemu-system-x86_64: -device virtio-net-pci,netdev=3Din0: Property 'virtio-
net-device.netdev' can't find value 'in0'

netstat shows a new connection to port 9999 in time_wait state every
time.

host: kernel 4.4.38, 64bits.

It was working fine with previous version.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1663079

Title:
  socket network not working

Status in QEMU:
  New

Bug description:
  The socket network type is no longer working in 2.8.0.

  When trying to establish a network between 2 qemu instances:

  The listening host:
  qemu-system-x86_64 -netdev socket,id=3Din0,listen=3D127.0.0.1:9999 -devic=
e virtio-net-pci,netdev=3Din0

  works fine, but for the second one:

  qemu-system-x86_64 -netdev socket,id=3Din0,connect=3D127.0.0.1:9999
  -device virtio-net-pci,netdev=3Din0

  It fails with:

  qemu-system-x86_64: -device virtio-net-pci,netdev=3Din0: Property
  'virtio-net-device.netdev' can't find value 'in0'

  netstat shows a new connection to port 9999 in time_wait state every
  time.

  host: kernel 4.4.38, 64bits.

  It was working fine with previous version.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1663079/+subscriptions
