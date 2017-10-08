Received: from eggs.gnu.org ([2001:4830:134:3::10]:32874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e13ER-0001pM-HJ
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 00:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e13EO-0006aT-DZ
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 00:30:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:41256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e13EO-0006aH-2F
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 00:30:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e13EN-0007tv-2g
	for <qemu-devel@nongnu.org>; Sun, 08 Oct 2017 04:30:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0F88E2E8056
	for <qemu-devel@nongnu.org>; Sun,  8 Oct 2017 04:30:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Oct 2017 04:17:23 -0000
From: Launchpad Bug Tracker <1359394@bugs.launchpad.net>
Reply-To: Bug 1359394 <1359394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140820203746.5581.233.malonedeb@gac.canonical.com>
Message-Id: <150743624410.13125.8795547842057186796.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1359394] Re: virtio block device hangs after
 "virtio_blk virtio3: requests:id 0 is not a head!"
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
https://bugs.launchpad.net/bugs/1359394

Title:
  virtio block device hangs after "virtio_blk virtio3: requests:id 0 is
  not a head!"

Status in QEMU:
  Expired

Bug description:
  The virtual machine is running block layer workloads, interrupted by
  unclean reboots (echo b > /proc/sysrq-trigger). Kernel version is
  3.14.

  Sometimes, I get this message on boot:

  "virtio_blk virtio3: requests:id 0 is not a head!"

  Then, I/O to the virtio block devices just hangs.

  Unfortunately I don't have a test case and this is kind of hard to
  reproduce, but it seems related to having I/O in flight when the
  kernel is forced to reboot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1359394/+subscriptions
