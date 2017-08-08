Received: from eggs.gnu.org ([2001:4830:134:3::10]:55281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dextD-0005h2-Ok
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dext8-0004ze-OE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:21:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:56935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dext8-0004yY-I2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:21:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dext6-0000F3-I5
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 06:21:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5F03C2E80CB
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 06:21:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 06:06:37 -0000
From: Thomas Huth <1359394@bugs.launchpad.net>
Reply-To: Bug 1359394 <1359394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140820203746.5581.233.malonedeb@gac.canonical.com>
Message-Id: <150217239732.19046.15221346317828931287.malone@chaenomeles.canonical.com>
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

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU and the kernel?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1359394

Title:
  virtio block device hangs after "virtio_blk virtio3: requests:id 0 is
  not a head!"

Status in QEMU:
  Incomplete

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
