Received: from eggs.gnu.org ([2001:4830:134:3::10]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0gLW-00010L-Gt
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0gLT-00026a-Fk
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:36:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:42438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f0gLT-000269-A0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:36:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f0gLS-0001NN-7Z
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 04:36:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 384172E806D
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 04:36:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Mar 2018 04:17:29 -0000
From: Launchpad Bug Tracker <1187334@bugs.launchpad.net>
Reply-To: Bug 1187334 <1187334@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130604103712.10468.8250.malonedeb@wampee.canonical.com>
Message-Id: <152212424964.3695.6359070469874465939.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1187334] Re: crash on hot-unplug of vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1187334

Title:
  crash on hot-unplug of vmxnet3

Status in QEMU:
  Expired

Bug description:
  Hot-unplug of a vmxnet3 device crashes as follows:

  (qemu) device_add id=3Dff,driver=3Dvmxnet3
  [vmxnet3][WR][vmxnet3_peer_has_vnet_hdr]: Peer has no virtio extension. T=
ask offloads will be emulated.
  (qemu) device_del ff
  (qemu) qemu-system-x86_64: /home/pbonzini/work/upstream/qemu/net/net.c:31=
5: qemu_del_net_client: Assertion `queues !=3D 0' failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1187334/+subscriptions
