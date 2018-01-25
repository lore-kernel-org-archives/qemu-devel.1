Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eecuO-0000bB-Qe
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eecuL-0004E2-Jp
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:29:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:55708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eecuL-0004Dj-DC
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:29:17 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eecuK-0001MH-Dk
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:29:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 591552E8550
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:29:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jan 2018 08:16:26 -0000
From: Thomas Huth <1187334@bugs.launchpad.net>
Reply-To: Bug 1187334 <1187334@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130604103712.10468.8250.malonedeb@wampee.canonical.com>
Message-Id: <151686818658.10193.3169483455571961610.malone@gac.canonical.com>
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

Looks like this assertion does not trigger with the current version
anymore, so I think we could close this bug. Or can you still reproduce
it?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1187334

Title:
  crash on hot-unplug of vmxnet3

Status in QEMU:
  Incomplete

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
