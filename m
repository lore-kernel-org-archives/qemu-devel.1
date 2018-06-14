Received: from eggs.gnu.org ([2001:4830:134:3::10]:53363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWTS-0003Ok-Pe
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWTO-0006oB-RD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:58324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTWTO-0006n4-Kb
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTWTN-0005c4-BM
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 17:55:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B5562E80C7
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 17:55:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 17:37:28 -0000
From: Thomas Huth <1469946@bugs.launchpad.net>
Reply-To: Bug 1469946 <1469946@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150630034055.10614.7558.malonedeb@soybean.canonical.com>
Message-Id: <152899784811.25800.12409378742685764073.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1469946] Re: guest can't get IP when create guest
 with bridge.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The patch mentioned earlier has been committed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D625de449fc5597f2e1aff
... so I think we can mark this as fixed now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1469946

Title:
  guest can't get IP when create guest with bridge.

Status in QEMU:
  Fix Released

Bug description:
  Environment:
  ------------
  Host OS (ia32/ia32e/IA64):ia32e
  Guest OS (ia32/ia32e/IA64):ia32e
  Guest OS Type (Linux/Windows):linux
  kvm.git Commit:aefbef10e3ae6e2c6e3c54f906f10b34c73a2c66
  qemu.git Commit:dc1e1350f8061021df765b396295329797d66933
  Host Kernel Version:4.1.0
  Hardware:Ivytown_EP, Haswell_EP

  =

  Bug detailed description:
  --------------------------
  when create guest with bridge, the guest can not get ip.

  note:
  1. fail rate: 3/5
  2. this is a qemu bug:
  kvm      + qemu   =3D  result
  aefbef10 + dc1e1350    =3D  bad =

  aefbef10 + a4ef02fd   =3D  good

  Reproduce steps:
  ----------------
  1. create guest:
  qemu-system-x86_64 -enable-kvm -m 2G -smp 4 -device virtio-net-pci,netdev=
=3Dnet0,mac=3D$random_mac -netdev tap,id=3Dnet0,script=3D/etc/kvm/qemu-ifup=
 rhel6u5.qcow

  Current result:
  ----------------
  guest can't get IP

  Expected result:
  ----------------
  guest can get ip

  Basic root-causing log:
  ----------------------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1469946/+subscriptions
